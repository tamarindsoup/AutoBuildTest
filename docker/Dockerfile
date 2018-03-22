    FROM ubuntu

    # レポジトリをjaistに変更
    RUN sed -i.bak2 -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list
    RUN sed -i.bak1 -e "s%^# deb-src%deb-src%" /etc/apt/sources.list

    # sudoとapt-utilsをインストール
    RUN apt update && \
    	apt install -y apt-utils && \
    	apt install -y sudo

    # uidとgidはホスト側のユーザのものを使用
    RUN export uid=1000 gid=1000 && \
        mkdir -p /home/developer/haribote && \
        echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
        echo "developer:x:${uid}:" >> /etc/group && \
        echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
        chmod 0440 /etc/sudoers.d/developer && \
        chown ${uid}:${gid} -R /home/developer && \
	chown ${uid}:${gid} -R /home/developer/haribote 
	
    # 以降はユーザdeveloperとして実行	
    USER developer
    ENV HOME /home/developer

    #
    RUN sudo apt install -y bash-completion pkg-config \
    	     	 	    wget curl build-essential \
			    gcc-multilib xz-utils python \
			    nasm mtools 

    #
    RUN sudo apt build-dep -y qemu 

    #
    RUN sudo apt build-dep -y binutils

    #
    RUN mkdir ~/Download && \
	wget -P ~/Download \
	http://ftp.jaist.ac.jp/pub/GNU/binutils/binutils-2.30.tar.xz \
	https://download.qemu.org/qemu-2.11.1.tar.xz

    #
    RUN cd ~/Download && \
    	tar axvf qemu-2.11.1.tar.xz && \
    	cd qemu-2.11.1 && \
    	./configure --target-list=i386-softmmu && \
    	make -j8 && \
    	sudo make -j8 install

    #
    RUN cd ~/Download && \
    	tar axvf binutils-2.30.tar.xz && \
	cd binutils-2.30 && \
    	./configure --target=i686-unknown-linux-gnu && \
    	make -j8 && \
    	sudo make -j8 install

    #
    RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain nightly -y

    #
    RUN . ~/.cargo/env && \
    	rustup target add i686-unknown-linux-gnu

    #
    RUN . ~/.cargo/env && \
    	cargo install racer && \
    	rustup component add rust-src

    #
    ENV RUST_SRC_PATH ~/.multirust/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src

    #
    RUN . ~/.cargo/env && \
    	cargo install --force rustfmt

    #
    RUN echo ". ~/haribote/.bashrc" >> ~/.profile

    CMD cd ~/ ; /bin/bash -l
    