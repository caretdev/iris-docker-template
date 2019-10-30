FROM store/intersystems/iris-community:2019.4.0.379.0

USER root

RUN mkdir /opt/myapp && \
    chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/myapp

COPY irissession.sh /

USER ${ISC_PACKAGE_MGRUSER}

WORKDIR /opt/myapp

COPY Installer.cls .

COPY src src

SHELL ["/irissession.sh"]

RUN \
  do $SYSTEM.OBJ.Load("Installer.cls", "ck") \
  set sc = ##class(App.Installer).setup()

SHELL ["/bin/bash", "-c"]