%% Class natureprintstyle
%% Written by Brendon Higgins, blhiggins@gmail.com
%% v1.0 - 19 April 2008
%% Based on class nature, written by Peter Czoschke, czoschke@mrl.uiuc.edu
%% V1.1 - 13 February 2012
%% Various minor changes by Michele Cappellari (Oxford) to agree more 
%% closely with the style of published Nature articles.
%% V1.2 - 25 April 2016
%% Other minor changes made by Grant Tremblay (Yale) to slightly better
%% emulate the style of published Nature articles. 
%%
%%
%% A drop-in replacement for the nature.cls class, used for Nature letter and
%% article preprints, that approximates Nature's style in print.
%%
%% Note that \includegraphics commands are not ignored, as they are in
%% nature.cls.
%%
%% This class may be particularly handy if an author finds it annoying to
%% read the single column format of the Nature preprint style.
%%
%% I created this class for personal purposes and without any connection
%% to the Nature Publishing Group.  I in no way claim that documents generated
%% with this file fully comply with their current style requirements.
%% I disclaim any responsibility for the use of this file heretofore.
%%
%% Nature articles are typeset with 'Minion Pro' font. While this can be implemented
%% using non-free fonts in LaTeX, this font is not available on arXiv. 
%%
%% ------------------------------------
%%
%% See nature.cls and its documentation for notes on usage.
%%
%% The file nature-template.tex, an example for the nature.cls class, should
%% also work with this class. Simply replace \documentclass{nature} with
%% \documentclass{natureprintstyle}.

\ProvidesClass{natureprintstyle}[25/4/2016 v1.2]
% \typeout{A class for emulating the style of Nature in print when writing preprints for the journal Nature}
% \typeout{Written by Brendon Higgins}
% \typeout{Based on nature.cls by Peter Czoschke}
% \typeout{Futher edited by Michele Cappellari and Grant Tremblay }


\LoadClass[9pt,twocolumn]{extarticle}
\RequirePackage{times}
\RequirePackage{cite}
\RequirePackage{ifthen}
\RequirePackage[total={18.2cm,24.4cm},centering]{geometry}
\RequirePackage{scalefnt}
\RequirePackage{type1cm}
\RequirePackage{color}
\definecolor{yaleblue}{rgb}{0.06,0.3,0.57} % Nature's blue is close to either Dark Cerulean or Yale Blue

%% make labels in bibliobraphy be #.
\renewcommand\@biblabel[1]{#1.}

%% make citations be superscripts, taken from citesupernumber.sty
\def\@cite#1#2{$^{\mbox{\scriptsize #1\if@tempswa , #2\fi}}$}

%% Some style parameters
\setlength{\parindent}{0.20in}
\newcommand{\spacing}[1]{\renewcommand{\baselinestretch}{#1}\large\normalsize}

%% Redefine \maketitle for Nature style
\def\@maketitle{%
  \newpage\spacing{1.0}\setlength{\parskip}{3pt}%
    {\color{yaleblue} \fontsize{40}{10}\selectfont LETTERS  \par \color{black}  \rule{\textwidth}{0.4pt}\\[-7pt]\rule{\textwidth}{0.4pt}\\[-7pt]\rule{\textwidth}{0.4pt} \par   }%
    {\scalefont{2.7}\noindent\sloppy%
        \begin{flushleft}\bfseries\@title\end{flushleft} \par}%
    {\scalefont{1.0}\noindent\sloppy \@author \par \vspace{0.5cm}}%
}

%% Define the affiliations environment, list each institution as an \item
%% Put as footnote of first paragraph
\newenvironment{affiliations}{%
    \let\olditem=\item
    \renewcommand\item[1][]{$^{\arabic{enumi}}$\stepcounter{enumi}}
    \setcounter{enumi}{1}%
    \setlength{\parindent}{0in}%
    \sffamily\sloppy%
    \scalefont{0.83}
    }{\let\item=\olditem}

%% Redefine the abstract environment to be the first bold paragraph
\renewenvironment{abstract}{%
    \setlength{\parindent}{0in}%
    \setlength{\parskip}{0in}%
    \bfseries%
    }{\par}

%% Redefine the \section command.
\renewcommand{\section}{\@startsection {section}{1}{0pt}%
    {12pt}{0pt}%
    {\sffamily\bfseries\scalefont{1.1}}%
    }
\renewcommand{\subsection}{\@startsection {subsection}{2}{0pt}%
    {0pt}{-0.5em}%
    {\bfseries}*%
    }

%% Define the methodssummary environment.  Use \subsection to separate. These come before methods.
\newenvironment{methodssummary}{%
    \section*{METHODS SUMMARY}%
    \setlength{\parskip}{0pt}%
    \scalefont{0.93}
    }{}

%% Define the methods environment.  Use \subsection to separate.
\newenvironment{methods}{%
    \section*{{\color{yaleblue}METHODS}}%
    \setlength{\parskip}{0pt}%
    \scalefont{0.93}
    }{}

%% No heading for References section, but eat up the extra space from \section command
\renewcommand\refname{References} % added back by Bin Ren

\let\oldthebibliography=\thebibliography
  \let\endoldthebibliography=\endthebibliography
  \renewenvironment{thebibliography}[1]{%
    \begin{oldthebibliography}{#1}%
      \sffamily%
      \scalefont{0.83}%
      \setlength{\parskip}{-4pt}%
  }%
  {%
    \end{oldthebibliography}%
  }

\let\oldbibitem=\bibitem
\renewcommand{\bibitem}[1]{\vspace{-0.15ex}\oldbibitem{#1}}
%% bibitem takes an optional parameter, so this might be broken.


%% Define the addendum environment for Supplementary Info, Acknowledgements, etc.
\newenvironment{addendum}{%
    \setlength{\parindent}{0in}%
    \sffamily%
    \scalefont{0.83}%
    \begin{list}{Acknowledgements}{%
        \setlength{\leftmargin}{0in}%
        \setlength{\listparindent}{0in}%
        \setlength{\labelsep}{0em}%
        \setlength{\labelwidth}{0in}%
        \setlength{\itemsep}{5pt}%
        \let\makelabel\addendumlabel}
    }
    {\end{list}\par\vfill}

\newcommand*{\addendumlabel}[1]{\textbf{#1}\hspace{1em}}

%% Figures and tables:
%% The \includegraphics command is respected.
%% Tables should all be moved to the end of the document
%% manually.

\renewcommand{\figurename}{\textbf{Fig.}}
\renewcommand{\tablename}{Table}

%% Change the way captions are formatted. Based on a tip by Jakob Schiotz.
%% http://dcwww.camd.dtu.dk/~schiotz/comp/LatexTips/LatexTips.html
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{{\textbf{\scalefont{0.93}#1 $\vert$}} \scalefont{0.93}#2}%
  \ifdim \wd\@tempboxa >\hsize
    {\scalefont{0.93}{\textbf{\scalefont{0.93}#1 $\vert$}} \scalefont{0.93}#2\par}
  \else
    \hbox to\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

