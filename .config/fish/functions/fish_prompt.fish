function fish_prompt
    set_color brcyan
    if test (pwd) = "/"
        printf "/"
    else
        printf (prompt_pwd | awk -F/ '{printf $NF}')
    end
    set_color normal 
    if test (id -u) -eq 0
        printf " # "
    else
        printf " \$ "
    end
    set_color normal
end
