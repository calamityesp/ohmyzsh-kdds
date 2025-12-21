#!/usr/bin/env bash

log $INFO "Select a profile:"
select choice in "main" "develop" "work"; do
  case $REPLY in
    1|2|3)
      CHOICE="$choice"
      break ;;
    *) log $ERROR "Invalid choice. Pick 1, 2, or 3." ;;
  esac
done
