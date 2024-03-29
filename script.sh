main() {
  if [ $# == 0 ]; then
    echo -e "Please add the required parameters!"
  else
    if [ $@ == "--add" ]; then
      read -p "Please set up your port service: " PORT
      read -p "Please set up your Next.js app folder: " APP_FOLDER
      curl -Ls -o nextjs.service https://github.com/jafarmemar/add-nextjs-service-to-linux/raw/main/nextjs-min.service
      PORT=$PORT APP_FOLDER=$APP_FOLDER MAINPID='$MAINPID' envsubst <nextjs.service >nextjs-$APP_FOLDER.service
      rm -f nextjs.service
      mv -f nextjs-$APP_FOLDER.service /etc/systemd/system/nextjs-$APP_FOLDER.service
      systemctl daemon-reload
      systemctl enable nextjs-$APP_FOLDER.service
      systemctl start nextjs-$APP_FOLDER.service
      echo -e "Service added successfully."
      mkdir -p /usr/share/nextjs-apps/$APP_FOLDER
      echo -e "Next.js folder path: /usr/share/nextjs-apps/$APP_FOLDER"
    elif [ $@ == "--remove" ]; then
      read -p "Please enter your Next.js service name: " SERVICE_NAME
      systemctl disable nextjs-$SERVICE_NAME.service
      systemctl stop nextjs-$SERVICE_NAME.service
      rm -f /etc/systemd/system/nextjs-$SERVICE_NAME.service
      systemctl daemon-reload
      echo -e "Service removed successfully."
    else
      echo -e "Please specify the correct parameters!"
    fi
  fi
}

main "$@"
