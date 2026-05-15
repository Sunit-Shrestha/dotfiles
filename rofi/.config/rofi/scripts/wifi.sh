#!/usr/bin/env bash

declare -A seen

generate_menu() {
  echo -en "\0prompt\x1f \n"
	echo -en "\0markup-rows\x1ftrue\n"

  printf "Rescan Networks\0icon\x1f%s\x1finfo\x1f%s\n" "reload" "__RESCAN__"
	nmcli device wifi rescan &>/dev/null
  nmcli -t -f IN-USE,SSID,SIGNAL,SECURITY device wifi list --rescan no |
  sort -t: -k1,1r | \
  while IFS=: read -r inuse ssid signal security; do
    [ -z "$ssid" ] && continue
    [ -n "${seen[$ssid]}" ] && continue
    seen[$ssid]=1

    if   [ "$signal" -ge 90 ]; then level=100
    elif [ "$signal" -ge 70 ]; then level=75
    elif [ "$signal" -ge 40 ]; then level=50
    else                          level=25
    fi

    if [ -n "$security" ] && [ "$security" != "--" ]; then
      icon="nm-signal-${level}-secure"
    else
      icon="nm-signal-${level}"
    fi

    if [ "$inuse" = "*" ]; then
      printf "<b>%s</b>\0icon\x1f%s\x1finfo\x1f%s\n" "$ssid" "$icon" "$ssid"
    else
      printf "%s\0icon\x1f%s\x1finfo\x1f%s\n" "$ssid" "$icon" "$ssid"
    fi
  done
}

handle_selection() {
  local info="$1"
	if [[ $info == "__EMPTY__" ]]; then
		generate_menu
		exit 0
	fi
  if [[ "$info" == "__RESCAN__" ]]; then
		nmcli device wifi rescan &>/dev/null
    nohup bash -c "rofi -show wifi" >/dev/null 2>&1 &
		exit 0
  fi
  local ssid="$info"
  local current
  current="$(nmcli -t -f NAME connection show --active | grep -Fx -- "$ssid")"
  if [[ -n "$current" ]]; then
    printf "%s\0icon\x1f%s\x1finfo\x1f%s\n" "Already connected to $ssid" "dialog-yes" "__EMPTY__"
    generate_menu
    exit 0
  fi
	
	nohup nmcli --ask device wifi connect "$ssid" >/dev/null 2>&1 &
  exit 0
}

if [[ "$ROFI_RETV" == "0" ]]; then
  generate_menu
elif [[ "$ROFI_RETV" == "1" ]]; then
  handle_selection "$ROFI_INFO"
fi

