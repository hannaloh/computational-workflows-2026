params.step = 0


workflow{

    // =========================================================================== //
    //                                  Examples                                   //                            
    // =========================================================================== //
    
    // Queue channel
    if (params.step == 0) {
        out_ch = channel.of(1,2,3)
    }

    // Value channel
    if (params.step == 00) {
        out_ch = channel.value(1)
    }


    // =========================================================================== //
    //                                  Tasks                                      //                            
    // =========================================================================== //


    // Task 1 - Create a channel that enumerates the numbers from 1 to 10

    if (params.step == "1") {
        out_ch = channel.of(1..10)

    }

    // Task 2 - Create a channel that gives out the entire alphabet
    
    if (params.step == "2") {
        out_ch = channel.of('A'..'Z')
        
    }

    // Task 3 - Create a channel that includes all files in the "files_dir" directory

    if (params.step == "3") {
        out_ch = channel.fromPath('files_dir/*')
        
    }

    // Task 4 - Create a channel that includes all TXT files in the "files_dir" directory
    
    if (params.step == "4") {
        out_ch = channel.fromPath('files_dir/*.txt')
    }

    // Task 5 - Create a channel that includes the files "fastq_1.fq" and "fastq_2.fq" in the "files_dir" directory

    if (params.step == "5") {
         out_ch = channel.fromPath(['files_dir/fastq_1.fq', 'files_dir/fastq_2.fq'])
    }
    

    // Task 6 - go back to the time when you included all files. Are you sure that really ALL files are included? If not, how can you include them?

    if (params.step == "6") {
        out_ch = channel.fromPath('files_dir/*', hidden: true)
        
    }

    // Task 7 - get all filepairs in the "files_dir" directory

    if (params.step == "7") {
        out_ch = channel.fromFilePairs('files_dir/*_{1,2}.fq')
        
    }
    


     // =========================================================================== //
    //                                  Tasks                                      //                            
    // =========================================================================== //

    //Task 1 - Extract the first item from the channel

    if (params.step == "1") {
        in_ch = channel.of(1,2,3)
        out_ch = in_ch.first()
    }


    //Task 2 - Extract the last item from the channel

    if (params.step == "2") {
        in_ch = channel.of(1,2,3)
        out_ch = in_ch.last()
    }


    // Task 3 - Use an operator to extract the first two items from the channel

    if (params.step == "3") {
        in_ch = channel.of(1,2,3)
        out_ch = in_ch.take(2)
    }

    // Task 4 - Return the squared values of the channel

    if (params.step == "4") {
        in_ch = channel.of(1,2,3)
        out_ch = in_ch.map { it * it }
    }

    //Task 5 - Remember the previous task where you squared the values of the channel. Now, extract the first two items from the squared channel

    if (params.step == "5") {
        in_ch = channel.of(1,2,3)
        out_ch = in_ch.map { it * it }.take(2)
    }

    // Task 6 - Remember when you used bash to reverse the output? Try to use map and Groovy to reverse the output

    if (params.step == "6") {
        in_ch = channel.of(1,2,3)
        out_ch = in_ch.map { it.toString().reverse() }
    }
    // Task 7 - Use fromPath to include all fastq files in the "files_dir" directory, then use map to return a pair containing the file name and the file path (Hint: include groovy code)

    if (params.step == "7") {
        in_ch = channel.fromPath('files_dir/*.fq')
        out_ch = in_ch.map { file -> [file.name, file] }
    }


    out_ch.view()
}
