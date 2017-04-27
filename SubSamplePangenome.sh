#Create a list of all pangenome sequences in your Roary output folder 
ls *.fa.aln > names.txt

#Take two sequences from each file and store them in a fasta
for f in $(cat names.txt); do cat ${f} | awk '/^>/ { if(i>0) printf("\n"); i++; printf("%s\t",$0); next;} {printf("%s",$0);} END { printf("\n");}' | head -n 2 | awk '{printf("%s\n%s\n",$1,$2)}' > ${f}.fasta; done

#concatenate all of the fastas into a single fasta file which you can blast against
find . -path './*.fa.aln.fasta' -prune -type f -exec cat {} + > combined.fasta
