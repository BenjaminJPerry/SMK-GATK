rule sambamba_sort:
    input:
        "mapped/{sample}_bwamem.bam"
    output:
        bams = temp("mapped/{sample}_bwamem_sorted.bam"),
        index = temp("mapped/{sample}_bwamem_sorted.bam.bai")
    params:
        tdir = expand("{tdir}", tdir = config['TEMPDIR']),
        other = "-m 6G"
    log:
        "logs/sambamba_sort/{sample}.log"
    benchmark:
        report("benchmarks/sambamba_sort/{sample}.sambamba", caption = "../report/benchmarking.rst", category = "Benchmarking")
    conda:
        "../envs/sambamba.yaml"
    threads: 4
    message:
        "Sorting BAM files"
    shell:
        "sambamba sort -p {input} -o {output.bams} --tmpdir={params.tdir} {params.other} -t {threads}"