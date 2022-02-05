function linecounter
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
    #echo $files
    #echo $recursive
    #echo $separate

    for file in $files
        if test -d $file
            if set -q recursive
                echo "Directory: $file"
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

    set lines $lines 0
    echo (math $lines)
end