FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NOWARNINGS="yes"

RUN cd /etc/apt && \
	sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' sources.list 

RUN apt-get -qq update \
&& apt-get install -y --no-install-recommends apt-utils \
clang-12 \
cmake \
ninja-build \
git \
make \
wget \
zsh \
ca-certificates \
curl \
vim \
&& apt-get clean

RUN apt-get update && apt-get upgrade -y

RUN usermod -s $(which zsh) root

# install powerlevel10k
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
RUN sed -i 's/robbyrussell/powerlevel10k\/powerlevel10k/g' ~/.zshrc
RUN echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >>~/.zshrc
RUN wget -O ~/.p10k.zsh https://gist.githubusercontent.com/JonhaLee/24f70e9aee59bacaa5290bae09b9d1c6/raw/1b082a9b112bec86fb5d939138391fd1b9d12997/gistfile1.txt


EXPOSE 8000
ENTRYPOINT ["/bin/bash"]
