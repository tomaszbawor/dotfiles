#!/bin/bash

# Check if a URL has been provided
if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <URL>"
	exit 1
fi

# Extract the domain name from the URL
url=$1
domain=$(echo $url | awk -F[/:] '{print $4}')

# Check if the domain was extracted successfully
if [ -z "$domain" ]; then
	echo "Could not extract domain from URL."
	exit 1
fi

# Use openssl to get certificate information
echo "Getting SSL certificate details for $domain..."

# Connect to the domain and fetch the certificate details
echo | openssl s_client -servername $domain -connect $domain:443 2>/dev/null | openssl x509 -noout -issuer -dates

# Check if the openssl command was successful
if [ $? -ne 0 ]; then
	echo "Failed to retrieve SSL certificate details."
	exit 1
fi

echo "SSL certificate details retrieved successfully."
