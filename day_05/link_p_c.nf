#!/usr/bin/env nextflow

process SPLITLETTERS {
 input:
    tuple val(meta), val(in_str), val(out_name)

    output:
    tuple val(meta), path("${out_name}_*")

    script:
    """
    printf '%s' "${in_str}" | split -b ${meta.block_size} - ${out_name}_
    """
} 

process CONVERTTOUPPER {
     debug true
    publishDir 'results', mode: 'copy'

    input:
    path chunk

    output:
    path "upper_${chunk}"

    script:
    """
    cat ${chunk} | tr '[:lower:]' '[:upper:]' > upper_${chunk}
    cat upper_${chunk}
    echo ""
    """
} 

workflow { 
    // 1. Read in the samplesheet (samplesheet_2.csv)  into a channel. The block_size will be the meta-map
    // 2. Create a process that splits the "in_str" into sizes with size block_size. The output will be a file for each block, named with the prefix as seen in the samplesheet_2
    // 4. Feed these files into a process that converts the strings to uppercase. The resulting strings should be written to stdout

    // read in samplesheet}
    in_ch = channel.fromPath('samplesheet_2.csv')
        .splitCsv(header: true)
        .map { row -> [[block_size: row.block_size], row.input_str, row.out_name] }

    // split the input string into chunks
    chunks_ch = SPLITLETTERS(in_ch)

    // lets remove the metamap to make it easier for us, as we won't need it anymore
    files_ch = chunks_ch
        .map { meta, files -> files }
        .flatten()

    files_ch.view { it -> "chunk file: ${it}" }

    // convert the chunks to uppercase and save the files to the results directory
    CONVERTTOUPPER(files_ch)


}