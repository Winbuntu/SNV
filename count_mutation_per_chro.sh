for i in $(ls cf*_somatic/*_PASS.vcf); do wc -l $i; done > all_sample_per_chromosome_mutation_count.txt
