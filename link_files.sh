find . -maxdepth 1 ! -path "*.git*" ! -path "." ! -path "*link_files.sh"|xargs -I{} sh -c "unlink ~/{} ; ln -s `pwd`/{} ~/{}"
