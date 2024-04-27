FROM python:3.11
WORKDIR /app
ARG POETRY_VERSION=1.2.2
RUN apt-get update && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash - && \
    . /root/.bashrc && nvm install 16.20 && \
    rm -rf /var/cache/apk/* && \
    pip3 install --no-cache-dir poetry && \
    rm -rf ~/.cache/
COPY package*.json ./
COPY pyproject.toml ./
COPY poetry.lock ./
# Install dependencies
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
RUN . /root/.bashrc && npm config set registry https://registry.npmmirror.com/ && poetry config repositories.cust-china-source https://pypi.mirrors.ustc.edu.cn/simple && poetry install && npm install && rm -rf ~/.npm/
COPY . .
CMD . /root/.bashrc && npm run dev
