function duroot
    set --local WD (pwd)
    cd /
    du -hxd1 --exclude={"proc","sys","dev","mnt","efi","Shared"} 2>/dev/null | sort -h
    cd $WD
end
