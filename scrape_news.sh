#!/bin/bash

wget https://www.ynetnews.com/category/3082
grep -o 'https://www.ynetnews.com/article/[A-Za-z0-9]\+' 3082 | uniq > articles
num_of_lines=$(wc -l < articles)

echo $num_of_lines
cat articles | while read link_line;
	
	do wget $link_line;
	(( netanyahu_sum=$(grep -o Netanyahu `echo $link_line | cut -d / -f 5` | wc -l) ));
	(( gantz_sum=$(grep -o Gantz `echo $link_line | cut -d / -f 5` | wc -l) ));
	
	echo $link_line, Netanyahu, $netanyahu_sum, Gantz, $gantz_sum >> results.csv

done
