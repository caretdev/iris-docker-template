FROM intersystems/iris:2019.3.0.302.0

USER root

RUN mkdir /opt/myapp && \
    chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/myapp

USER ${ISC_PACKAGE_MGRUSER}

WORKDIR /opt/myapp

COPY Installer.cls .

COPY src src

COPY session.sh /

SHELL ["/session.sh"]

RUN \
do $SYSTEM.OBJ.Load("Installer.cls", "ck") \
set sc = ##class(App.Installer).setup()