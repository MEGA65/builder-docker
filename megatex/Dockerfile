FROM megabuild

# install texlive
RUN apt install -y texlive-latex-extra texlive-bibtex-extra texlive-xetex latexmk xzdec \
 && apt clean -y

# install texmf stuff in user path
USER mega
RUN tlmgr init-usertree \
 && tlmgr --usermode option repository http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2019/tlnet-final/ \
 && ( tlmgr --no-verify-downloads --usermode \
          install IEEEtran tools url arydshln booktabs sttools etoolbox titlesec appendix parskip \
		  	kvoptions ltxcmds kvsetkeys float caption tikzpagenodes pgf ifoddpage imakeidx xkeyval nowidow \
		  	hyperref infwarerr textpos enumitem tcolorbox environ listings wrapfig needspace ean ocr-b \
		  	changepage tabulary multirow geometry zapfding helvetic || true ) \
 && updmap-user

# switch back to root
USER root

