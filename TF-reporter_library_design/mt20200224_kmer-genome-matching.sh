# Bash script used to map 14-mers against genome

# Create mm10 index files (in bowtie folder)
cd /DATA/usr/m.trauernicht/projects/Data/Genomes/mm10/index/bowtie2/
bowtie-build /DATA/usr/m.trauernicht/projects/Data/Genomes/mm10/genome/fasta/mm10Patch4.fa mm10

# Create kmer fasta file
python /DATA/usr/m.trauernicht/projects/tf_activity_reporter/Oligo_Design/All-motifs/mt20200221_kmers.py > /DATA/usr/m.trauernicht/projects/tf_activity_reporter/Oligo_Design/All-motifs/kmers.fasta

# Map kmer file against reference genome and return all matched kmers
cd /DATA/usr/m.trauernicht/projects/Data/Genomes/mm10/index/bowtie2/
bowtie --sam --best --strata -v 0 -n 0 -l 14 -k 1 -m 1 -M 1 -f mm10 /DATA/usr/m.trauernicht/projects/tf_activity_reporter/Oligo_Design/All-motifs/kmers.fasta | mawk '$1 ~ /^@/ {next} {if ($6 != "16M") print $10}' | tee >(pigz > /DATA/usr/m.trauernicht/projects/tf-tf_activity_reporter/Oligo_Design/All-motifs/kmers_notMM10.txt.gz)

# How many 14-mers map the genome?
zcat mydata/projects/tf_activity_reporter/Oligo_Design/All-motifs/kmers_notMM10.txt.gz | wc -l

# Conclusion: All 14-mers map the mm10 reference genome
