#Detect somatic mutations and do comparsion analysis in cfDNA samples

path: /labshares/fanlab/anqin/cfDNA_project/SNV

Data: cfDNAs
##Call somatic mutations using GATK MuTect2

Only cf2.1 need processing. Other samples are already processed.
 
1. Fastq to re-align

	usig **Map\_and\_call.sh**
	
	```
	bgrun -m a -n cf2.1 "sh ./Map_and_call.sh 16A-2-1_S5_L007_R1_001.fastq.gz 16A-2-1_S5_L007_R2_001.fastq.gz 802"
	```
	This gives you BAM file ready for VCF calling.
	
2. Call somatic mutations per-chromosome

	* To run per-chromosome variant calling:
	* generate a file contains all tumor-normal pairs and sample name. Each line is a pair (pair.txt)
	* run python ./files\_txt\_generator.py pair.txt > files.txt . This output files.txt for job array.
	* Submit job

## Process VCF files
Clean vcf, get mutations that passed quality control
```
for i in $(ls cf*somatic/*{0,1,2,3,4,5,6,7,8,9,X,Y}.vcf); do python clean_vcf.py $i; done
```

Count mutation number for each chromosome, each sample:
Run **count\_mutation\_per\_chro.sh**

##Use R to generate barplot and boxplot 
 