params.step = 0


workflow{
    def out_ch = channel.empty()

    // Task 1 - Extract the first item from the channel

    if (params.step == "1") {
        in_ch = channel.of(1,2,3)
        out_ch = in_ch.first()

    }

    // Task 2 - Extract the last item from the channel
    
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

        in_ch = channel.of(2,3,4)
        out_ch = in_ch.map { it -> it * it }


    }

    // Task 5 - Remember the previous task where you squared the values of the channel. Now, extract the first two items from the squared channel

    if (params.step == "5") {

        in_ch = channel.of(2,3,4)
        out_ch = in_ch.map { it -> it * it }.take(2)
        
    }

    // Task 6 - Remember when you used bash to reverse the output? Try to use map and Groovy to reverse the output

    if (params.step == "6") {
        
        in_ch = channel.of('Taylor', 'Swift')
        out_ch = in_ch.map { it.toString().reverse()}
    }

    // Task 7 - Use fromPath to include all fastq files in the "files_dir" directory, then use map to return a pair containing the file name and the file path (Hint: include groovy code)

    if (params.step == "7") {

        in_ch = channel.fromPath('files_dir/*.fq')
        out_ch = in_ch.map { file -> [file.name, file] }

    }

        // Task 8 - Combine the items from the two channels into a single channel
    if (params.step == "8") {
        ch_1 = channel.of(1,2,3)
        ch_2 = channel.of(4,5,6)
        out_ch = ch_1.concat(ch_2)
    }

    // Task 9 - Flatten the channel
    if (params.step == "9") {
        in_ch = channel.of([1,2,3], [4,5,6])
        out_ch = in_ch.flatten()
    }

    // Task 10 - Collect the items of a channel into a list
    if (params.step == "10") {
        in_ch = channel.of(1,2,3)
        out_ch = in_ch.collect()
    }

    // Task 11 - Group the items by their first element
    if (params.step == "11") {
        in_ch = channel.of([1, 'V'], [3, 'M'], [2, 'O'], [1, 'f'], [3, 'G'], [1, 'B'], [2, 'L'], [2, 'E'], [3, '33'])
        out_ch = in_ch.groupTuple()
    }

    // Task 12 - Join the two channels
    if (params.step == "12") {
        left_ch = channel.of([1, 'V'], [3, 'M'], [2, 'O'], [1, 'B'], [3, '33'])
        right_ch = channel.of([1, 'f'], [3, 'G'], [2, 'L'], [2, 'E'],)
        out_ch = left_ch.join(right_ch)
    }

    // Task 13 - Split into even and odd numbers and write them to stdout
    if (params.step == "13") {
        in_ch = channel.of(1,2,3,4,5,6,7,8,9,10)
        result = in_ch.branch { it ->
            even: it % 2 == 0
            odd: true
        }
        even_ch = result.even.collect().dump(tag: 'even').map { it -> "even: ${it}" }
        odd_ch = result.odd.collect().dump(tag: 'odd').map { it -> "odd: ${it}" }
        out_ch = even_ch.mix(odd_ch)
    }

    // Task 14 - Write the names to results/names.txt, one name per line
    if (params.step == "14") {
        in_ch = channel.of(
            ['name': 'Harry', 'title': 'student'],
            ['name': 'Ron', 'title': 'student'],
            ['name': 'Hermione', 'title': 'student'],
            ['name': 'Albus', 'title': 'headmaster'],
            ['name': 'Snape', 'title': 'teacher'],
            ['name': 'Hagrid', 'title': 'groundkeeper'],
            ['name': 'Dobby', 'title': 'hero'],
        )
        out_ch = in_ch
            .map { it -> it.name }
            .collectFile(name: 'names.txt', storeDir: 'results', newLine: true, sort: false)
    }

     out_ch.view()
    }
    







