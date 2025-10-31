# Dockerfile для курса "Архитектура компьютера и операционные системы"
# Образ для сборки и запуска программ на C и ассемблере (Intel syntax)

FROM --platform=linux/amd64 ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Основные пакеты
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
      locales \
      ca-certificates \
      curl \
      git \
      make \
      build-essential \
      gcc \
      g++ \
      binutils \
      gdb \
      vim vim-runtime vim-doc \
      docker.io \
      python3 python3-pip python3-venv \
      bash-completion \
      file \
      less \
      man-db \
      pkg-config \
      rsync \
      unzip \
      xz-utils && \
    rm -rf /var/lib/apt/lists/*

# Восстановление man-страниц и документации
RUN yes | unminimize && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      manpages manpages-dev manpages-posix manpages-posix-dev && \
    rm -rf /var/lib/apt/lists/*

# Настройка локали
RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen && \
    sed -i 's/^# *\(ru_RU.UTF-8\)/\1/' /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

# Удобные алиасы
RUN echo 'alias ll="ls -alF"' >> /etc/bash.bashrc && \
    echo 'alias vimtutor-ru="LANG=ru_RU.UTF-8 vimtutor"' >> /etc/bash.bashrc && \
    echo 'alias gcc-intel="gcc -S -masm=intel -O0"' >> /etc/bash.bashrc && \
    echo 'alias g++-intel="g++ -S -masm=intel -O0"' >> /etc/bash.bashrc

WORKDIR /workspace

# Проверка установки инструментов
RUN bash -lc "gcc --version | head -n1 && g++ --version | head -n1 && gdb --version | head -n1 && python3 --version && vim --version | head -n1 && man --version | head -n1"

CMD ["/bin/bash"]

# Для сборки:
# docker build -t my-intel .
# docker run -it --rm -v "$(pwd)":/workspace -w /workspace my-intel
