printf "Termsuite Initiation ....\n"
echo "."
echo "."
#example
#java -cp termsuite-core-3.0.10.jar fr.univnantes.termsuite.tools.TerminologyExtractorCLI -t ./treetagger/ -c ./wind-energy/English/txt/ -l en --tsv ./wind-energy-en.tsv
java -cp termsuite-core-3.0.10.jar fr.univnantes.termsuite.tools.TerminologyExtractorCLI -t ./treetagger/ -c ./Operation_engine/English/txt/ -l en --tsv ./operation_engine.tsv

printf " .tsv to .txt conversion ....\n"
echo "."
cp operation_engine.tsv tsv_conv_text.txt



printf "Extracting words from tsv .... \n"
sed -i 's/\t/:/g' tsv_conv_text.txt


echo "."
echo "."
awk 'BEGIN{FS=OFS=":"}{print $4}' tsv_conv_text.txt > extracted_eng.txt
printf "Enter the no. of File splits (so that each file contains 10 - 12 words only)...\n"
printf "example for input 10 : files created are from {0 to 9}\n"
read a
split -n $a -d -a 2 extracted_eng.txt english

for i in `seq 0 $a`;
do 
	if (( i < 10 )); then 
	mkdir English$i
	mv english0$i English$i/ 
	mv English$i/english0$i English$i/english	

	else 

	mkdir English$i
	mv english$i English$i/ 
	mv English$i/english$i English$i/english
	fi
done


echo "."
echo "."
printf " Ignore the above mv: cannot stat ERROR \n\n" 

for i in `seq 1 $a`
do 
	python translate.py English$i/english English$i/hindi
done



