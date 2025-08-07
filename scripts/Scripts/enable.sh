#!/bin/bash

echo "Enabling systemd services..."
while IFS= read -r service; do
  sudo systemctl enable --now "$service"
done < services.txt
