import sys

chr_list = ["chr1", "chr2", "chr3", "chr4", "chr5", "chr6", "chr7", "chr8", "chr9", "chr10", "chr11", "chr12", "chr13", "chr14", "chr15", "chr16", "chr17", "chr18", "chr19", "chr20", "chr21", "chr22", "chrX", "chrY"]

def main(filename):
	
	with open(filename,"r") as pairs:
		for line in pairs:
			for i in chr_list:
				print line.strip() + "\t" + i 


if __name__ == "__main__":
	main(sys.argv[1])
