function linecounter
    # Parse arguments
    getopts $argv | while read -l key value
        switch $key
            case _
                set files $files $value
            case h help
                echo "Apua"
            case r recursive
                set recursive true
            case p print
                set print true
        end
    end

    # Count lines
    for file in $files
        if test -d $file
            if set -q recursive
                set current_lines (linecounter $file/* -r)
            else
                set current_lines 0
            end
        else
            set current_lines (cat $file | wc -l)
        end
        if set -q print
            echo $file $current_lines
        end
        set lines $lines $current_lines +
    end

    # Sum up and print result
    set lines $lines 0
    if set -q print
        echo "Total lines: " (math $lines)
    else
        echo (math $lines)
    end
end