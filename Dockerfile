FROM cm2network/steamcmd:root

ENV STEAMAPPID 1690800
ENV STEAMAPP Satisfactory
ENV STEAMAPPDIR ${HOMEDIR}/satisfactory

RUN echo -e "export LD_LIBRARY_PATH=${STEAMAPPDIR}/linux64:$LD_LIBRARY_PATH\n\
    bash ${STEAMCMDDIR}/steamcmd.sh +login anonymous +force_install_dir ${STEAMAPPDIR} +app_update ${STEAMAPPID} validate +quit\n\
    test -d ~/.config/Epic/FactoryGame/Saved || mkdir -p ~/.config/Epic/FactoryGame/Saved\n\
    test -d ${STEAMAPPDIR}/saves || mkdir ${STEAMAPPDIR}/saves\n\
    test -L ~/.config/Epic/FactoryGame/Saved/SaveGames || ln -s ${STEAMAPPDIR}/saves ~/.config/Epic/FactoryGame/Saved/SaveGames\n\
    ${STEAMAPPDIR}/FactoryServer.sh" >> ${HOMEDIR}/entry.sh

RUN chmod +x "${HOMEDIR}/entry.sh" && chown -R "${USER}:${USER}" "${HOMEDIR}"

USER ${USER}

VOLUME ${STEAMAPPDIR}

WORKDIR ${HOMEDIR}

EXPOSE 15777/udp 15000/udp 7777/udp

CMD ["bash", "entry.sh"]
