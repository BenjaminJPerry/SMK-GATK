rule fastqc:
    input:
        ["fastq/{sample}_R1.fastq.gz", "fastq/{sample}_R2.fastq.gz"]
    output:
        html = ["results/qc/fastqc/{sample}_R1_fastqc.html", "results/qc/fastqc/{sample}_R2_fastqc.html"],
        zip = ["results/qc/fastqc/{sample}_R1_fastqc.zip", "results/qc/fastqc/{sample}_R2_fastqc.zip"]
    log:
        "logs/fastqc.{sample}.log"
    benchmark:
        "benchmarks/fastqc/{sample}.tsv"
    singularity:
        "docker://biocontainers/fastqc:v0.11.9_cv8"
    threads: 4
    resources:
        # partition = config['PARTITION']['CPU']
    message:
        "QC raw sequence data for {input}"
    shell:
        'fastqc {input} '
        '-o results/qc/fastqc/ '
        '-t {threads} '
        '&> {log}'