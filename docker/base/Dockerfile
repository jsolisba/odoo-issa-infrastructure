FROM odoo:18.0-20250131

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3-pip \
        python3-venv \
        build-essential \
        libatlas-base-dev \
        libffi-dev \
        libssl-dev \
    && rm -rf /var/lib/apt/lists/*

    RUN pip3 install --no-cache-dir --break-system-packages pandas

COPY docker/base/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

USER odoo

ENTRYPOINT ["/entrypoint.sh"]

CMD ["odoo"]