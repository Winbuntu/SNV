if [ ! -d "/tmp" ]; then
  mkdir /tmp
fi

GATK="/home/qan/GenomeAnalysisTK-3.6/GenomeAnalysisTK.jar"

# alignment $1 is first pair , $2 is second pair
# $3 is name, a number

# bwa mem   -t 16  /labshares/fanlab/anqin/REF/Hg38/Homo_sapiens/UCSC/hg38/Sequence/BWAIndex/genome.fa  ${1} ${2} > ${1}_bwa_align.sam






# add group information
#/home/qan/jdk1.8.0_77/bin/java -Djava.io.tmpdir=`pwd`/tmp -jar /home/qan/picard-tools-2.1.1_03282016/picard.jar  AddOrReplaceReadGroups \
#	I=${1}_bwa_align.sam \
#	O=${1}_bwa_align_gpi.bam \
#	RGID=${3} \
#	RGLB=lib1 \
#	RGPL=illumina \
#	RGPU=unit1 \
#	RGSM=${3}


#rm ${1}_bwa_align.sam

#bug fixed
#samtools sort -@ 10  ${1}_bwa_align_gpi.bam  ${1}_bwa_align_sorted_gpied

#rm ${1}_bwa_align_gpi.bam

# mark duplicates
#/home/qan/jdk1.8.0_77/bin/java -Djava.io.tmpdir=`pwd`/tmp -jar /home/qan/picard-tools-2.1.1_03282016/picard.jar  MarkDuplicates \
#	I=${1}_bwa_align_sorted_gpied.bam \
#	O=${1}_bwa_align_sorted_gpied_dedup.bam \
#	M=${1}marked_dup_metrics.txt

#rm ${1}_bwa_align_sorted_gpied.bam


#build bam index
#/home/qan/jdk1.8.0_77/bin/java -Djava.io.tmpdir=`pwd`/tmp -jar /home/qan/picard-tools-2.1.1_03282016/picard.jar BuildBamIndex  I=${1}_bwa_align_sorted_gpied_dedup.bam OUTPUT=${1}_bwa_align_sorted_gpied_dedup.bam.bai

#samtools index ${1}_bwa_align_sorted_gpied_dedup.bam

#Create realignment targets
#/home/qan/jdk1.8.0_77/bin/java -Xms6G -Xmx8G  -jar $GATK -T RealignerTargetCreator -nct 1 -nt 24 -R /labshares/fanlab/anqin/REF/Hg38/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa  \
#	-I ${1}_bwa_align_sorted_gpied_dedup.bam  \
#	-o ${1}.targetintervals.list


#Indel realignment
#/home/qan/jdk1.8.0_77/bin/java  -jar $GATK -T IndelRealigner \
#	-R /labshares/fanlab/anqin/REF/Hg38/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa  \
#	-I ${1}_bwa_align_sorted_gpied_dedup.bam  \
#	-targetIntervals ${1}.targetintervals.list \
#	-o ${1}_bwa_align_sorted_gpied_dedup_realign.bam

#rm ${1}_bwa_align_sorted_gpied_dedup.bam

# BQSR
#/home/qan/jdk1.8.0_77/bin/java  -jar $GATK \
#	-T BaseRecalibrator \
#	-R /labshares/fanlab/anqin/REF/Hg38/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa \
#	-I ${1}_bwa_align_sorted_gpied_dedup_realign.bam \
#   	-o recal_data.table 

#echo BQSR done

# recal reads
#/home/qan/jdk1.8.0_77/bin/java  -jar $GATK \
#	-T PrintReads \
#	-R /labshares/fanlab/anqin/REF/Hg38/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa \
#	-I ${1}_bwa_align_sorted_gpied_dedup_realign.bam \
#	-BQSR recal_data.table \
#	-o ${1}_bwa_align_sorted_gpied_dedup_realign_recal.bam


#exit
# haplotypcall

#/home/qan/jdk1.8.0_77/bin/java  -jar $GATK -T  HaplotypeCaller \
#	-R /labshares/fanlab/anqin/REF/Hg38/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa \
#	-I ${1}_bwa_align_sorted_gpied_dedup_realign.bam \
#	--genotyping_mode DISCOVERY \
#	-stand_emit_conf 10 \
#	-stand_call_conf 30  \
#	-o ${1}.raw_variants.vcf


#MuTect2 call

if [ ! -d "${3}" ]; then
  mkdir ${3}
fi

/home/qan/jdk1.8.0_77/bin/java  -Xms6G -Xmx8G  -jar $GATK -T  MuTect2 \
	-R /labshares/fanlab/anqin/REF/Hg38/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa \
	-I:tumor ${1} \
	-I:normal ${2} \
	-L ${4} \
	-o ./${3}/${3}_${4}.vcf














