main() {
  if [ $# == 0 ]; then
    echo -e "Please add the required parameters!"
  else
    if [ $@ == "--add" ]; then
      read -p "Please set up your port service: " PORT
      read -p "Please set up your Next.js app folder: " APP_FOLDER
      curl -OLs https://github.com/jafarmemar/add-nextjs-service-to-linux/raw/main/nextjs.service
      PORT=$PORT APP_FOLDER=$APP_FOLDER envsubst <nextjs.service >nextjs-$APP_FOLDER.service
      rm -f nextjs.service
      mv -f nextjs-$APP_FOLDER.service /etc/systemd/system/nextjs-$APP_FOLDER.service
      systemctl daemon-reload
      systemctl enable nextjs-$APP_FOLDER.service
      systemctl start nextjs-$APP_FOLDER.service
      echo -e "Service added successfully."
      mkdir -p /usr/share/nextjs-apps/$APP_FOLDER
      echo -e "Next.js folder path: /usr/share/nextjs-apps/$APP_FOLDER"
    elif [ $@ == "--remove" ]; then
      echo -e "Oops, this command hasn't been implemented yet!"
    else
      read -p "Please enter your Next.js service name : " SERVICE_NAME
      systemctl disable nextjs-$SERVICE_NAME.service
      systemctl stop nextjs-$SERVICE_NAME.service
      rm -f /etc/systemd/system/nextjs-$SERVICE_NAME.service
      systemctl daemon-reload
    fi
  fi
}

main "$@"
