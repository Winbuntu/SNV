import sys

def main(in_file):
	out_file = open(in_file+"_PASS.vcf","w")
	in_file_handle = open(in_file,"r")

	for line in in_file_handle:
		if line[0] == "#":
			out_file.write(line)
			continue

		elements = line.strip().split("\t")

		#print elements

		if elements[6] == "PASS":
			out_file.write("\t".join(elements)+"\n")


if __name__ == "__main__":
	main(sys.argv[1])