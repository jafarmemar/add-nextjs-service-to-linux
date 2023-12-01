main() {
  if [ $# == 0 ]; then
    echo "Please add the required parameters!"
  else
    if [ $@ == "--add" ]; then
      read -p "Please set up your port service: " PORT
      read -p "Please set up your Next.js app folder: " APP_FOLDER
      curl -OLs https://github.com/jafarmemar/add-nextjs-service-to-linux/raw/main/nextjs.service
      PORT=$PORT APP_FOLDER=$APP_FOLDER envsubst <nextjs.service >nextjs-$APP_FOLDER.service
      rm -f nextjs.service
    elif [ $@ == "--remove" ]; then
      echo "remove"
    else
      echo "Please specify the correct parameters!"
    fi
  fi
}

main "$@"
