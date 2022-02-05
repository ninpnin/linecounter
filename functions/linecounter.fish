function linecounter
    getopts $argv | while read -l key value
        switch $key
            case _
                set files $files $value
            case h help
                echo "Apua"
            case r recursive
                set recursive true
            case s separate
                set separate true
        end
    end
    #echo $files
    #echo $recursive
    #echo $separate

    if set -q separate
        for file in $files
            set current_lines (cat $file | wc -l)
            echo $file $current_lines
            set lines $lines $current_lines +
        end
    end

    set lines $lines 0
    echo "Total lines " (math $lines)
end