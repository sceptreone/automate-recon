#!/bin/bash

# Configure variables
declare domain=$1 threads=$2 

# Subdomains

subfind(){
~/go/bin/subfinder -d "${domain}" -t "${threads}" -o subfind.txt
}

crtsh(){
curl -s https://crt.sh/?q=%."${domain}"  | sed 's/<\/\?[^>]\+>//g' | sed 's/ //g' | grep "${domain}" > crtsh.txt
}

certspotter(){
curl -s https://certspotter.com/api/v0/certs\?domain\="${domain}" | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | grep "${domain}" > certspot.txt
} 

# Combine Subdomains and Sort
merge(){
cat *.txt | sort -u > all.txt
sed 's/*.//g' all.txt > allCleaned.txt
}

# Alive host
alive(){
cat allCleaned.txt | ~/go/bin/httprobe > alive.txt
}

main()
{

	mkdir "${domain}" && cd "${domain}"
	echo "Starting Recon on ${domain}"
	echo "Threads consumed : ${threads}"
	echo "Trim Level : ${trimlvl}"

	echo "Subdomain scanning starting..."
	echo "Subfinder started..."
	subfind
	echo "Crtsh started..."
	crtsh 
	echo "Certspotter started..."
	certspotter

	echo "Merging and sorting domains..."
	merge

	echo "Looking for zombie domains..."
	alive

}

main
