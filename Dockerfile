FROM ubuntu:22.04

#RUN cd /etc/apt && \
#	sed -i 's/ports.ubuntu.com/ftp.kaist.ac.kr/g' sources.list 

RUN cd /etc/apt && \
	sed -i 's/archive.ubuntu.com/ftp.kaist.ac.kr/g' sources.list 

RUN apt-get -qq update \
&& apt-get install -y --no-install-recommends apt-utils \
clang \
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

ARG USERNAME=docker
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
USER $USERNAME

# install powerlevel10k
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
RUN sed -i 's/robbyrussell/powerlevel10k\/powerlevel10k/g' ~/.zshrc
RUN echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >>~/.zshrc
RUN wget -O ~/.p10k.zsh https://gist.githubusercontent.com/JonhaLee/24f70e9aee59bacaa5290bae09b9d1c6/raw/1b082a9b112bec86fb5d939138391fd1b9d12997/gistfile1.txt

ENTRYPOINT ["/bin/zsh"]
