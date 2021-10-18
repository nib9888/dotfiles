function secretdir -d "Mount or Unmount Documents/Secret"
    set VERBOSE 0
    if [ $argv[1] = "--verbose" ]
        set VERBOSE 1
        set -e argv[1]
    end
    switch $argv[1]
        case umount
            test $VERBOSE -eq 1; and fusermount -u /home/enigma/Documents/Secret; and echo 'Unmounted Document/Secret'
            test $VERBOSE -eq 0; and fusermount -u /home/enigma/Documents/Secret 2>/dev/null; and echo 'Unmounted Documents/Secret'
        case mount
            test $VERBOSE -eq 1; and encfs /home/enigma/.crypt/ /home/enigma/Documents/Secret/; and echo 'Mounted Document/Secret'
            test $VERBOSE -eq 0; and encfs /home/enigma/.crypt/ /home/enigma/Documents/Secret/ 2>/dev/null; and echo 'Mounted Documents/Secret'
    end
end
