FROM ghcr.io/jsolisba/odoo:18

USER root

RUN mkdir -p /opt/odoo \
    && chown -R odoo:odoo /opt/odoo

USER odoo

CMD ["odoo"]
