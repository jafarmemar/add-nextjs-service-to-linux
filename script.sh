main() {
  if [ $# == 0 ]; then
    echo "Please add the required parameters!"
  else
    if [ $@ == "--add" ]; then
      curl -OLs https://github.com/jafarmemar/add-nextjs-service-to-linux/raw/main/nextjs.service
      PORT=80 envsubst <nextjs.service >my-nextjs.service
      rm -f nextjs.service
    elif [ $@ == "--remove" ]; then
      echo "remove"
    else
      echo "Please specify the correct parameters!"
    fi
  fi
}

main "$@"