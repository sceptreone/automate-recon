# AUTOMATE RECON
A collection of bash scripts I wrote to automate my recon, as I am learning different recon methods. I will keep updating it and adding more stuff. This is just the stuff I am doing repeatedly, so y not put it in a bash script and save trouble for next time. 

### Recon.sh
Following [@namase](https://twitter.com/NahamSec) methods from his livestream, tested all tools for enum, these are the one that works best for me. Did stuff manually, and after that automate it, <br />cause 
AUTOMATE EVERYTHING!!!!!! <br />
<br />
The idea here is, to automate the process from finding subdomains, then unique subdomains and taking screenshots too.
And then sending the unique subdomains, again to script to do the same thing. <br /> 
I will add more stuff as I find time like port scanning and stuff. <br />
If you have any bright ideas or want to automate something, just ping me at [@codesceptre](https://twitter.com/codesceptre)
 

##### Tools Required:
1. Subfinder
3. Httprobe
2. GoWitness

##### Usage:
./recon.sh $1 $2 $2 <br />
domain=$1 threads=$2 trimlvl=$3 <br />
Example: ./recon.sh example.com 10 4 <br />

### Alive.sh
Does same stuff, as recon but does not take screenshots. <br />
Big idea here is, to find new targets or subdomains daily from a program and match it with existing alive.txt, new code everyday pushed by the company, keep an eye and AUTOMATE EVERYTHING!!!!!! <br />
Command to check for new subdomains 

##### sort oldReconSubdomains.txt newReconSubdomains.txt | uniq -u

Gives domains that are not listed in oldReconSubdomains.txt, resulting in maybe new targets. <br />
