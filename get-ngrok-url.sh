#!/bin/bash

# Retrieve the Ngrok URL
sleep 5
ngrok_url=$(curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')

echo "Ngrok URL: $ngrok_url"
