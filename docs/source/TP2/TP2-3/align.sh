sample=$1

mkdir -p align/$sample;

/home/ICM-INSTITUTE.ORG/ihu-j.guegan/tools/STAR/STAR-2.5.2b/bin/Linux_x86_64/STAR \
	--runThreadN 16 \
	--genomeDir /lnec/BIOINFO/DATABASE/HS/hg19/indexes/DNA/UCSC/STAR/ \
	--readFilesIn raw_data/$sample"_1.fastq.gz" raw_data/$sample"_2.fastq.gz" \
	--readFilesCommand zcat \
	--outFileNamePrefix align/$sample/ \
	--sjdbGTFfile /lnec/BIOINFO/DATABASE/HS/hg19/annotations/db/RNA/refGene/latest/clean/UCSC/default/refGene.gtf \
	--outSAMtype BAM Unsorted SortedByCoordinate \
	--outFilterMultimapNmax 1 \
	--outSAMunmapped Within \
	--quantMode TranscriptomeSAM \
	--twopassMode Basic 
	
samtools index align/$sample/Aligned.toTranscriptome.out.bam
