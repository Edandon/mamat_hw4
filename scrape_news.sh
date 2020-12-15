#!/bin/bash

# scrapes 3082 page and gets all relevant links
wget https://www.ynetnews.com/category/3082
grep -o 'https://www.ynetnews.com/article/[A-Za-z0-9]\{9\}\b' 3082 | sort | uniq > articles
echo `wc -l < articles` > results.csv

# Goes into each article and counts appearances
cat articles | while read link_line;
	
	do wget $link_line;
	(( netanyahu_sum=$(grep -o Netanyahu `echo $link_line | cut -d / -f 5` | wc -l) ));
	(( gantz_sum=$(grep -o Gantz `echo $link_line | cut -d / -f 5` | wc -l) ));
	rm `echo $link_line | cut -d / -f 5`;
	if [[ $netanyahu_sum -eq 0 && $gantz_sum -eq 0 ]]
	then
		echo $link_line, - >> results.csv
	else
		echo $link_line, Netanyahu, $netanyahu_sum, Gantz, $gantz_sum >> results.csv
	fi
done
rm articles
