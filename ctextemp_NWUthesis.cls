\def\CTeXPreproc{Created by ctex v0.2.13, don't edit!}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ctextemp_NWUthesis}[2015/01/01 NWU, Thesis document class, version 0.1.0]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   class and packages

%%%%%%%%%%%%%%%%%%%%
%% Options
%%%%%%%%%%%%%%%%%%%%

%% disable oneside option
\DeclareOption{oneside}{\OptionNotUsed}

%% driver
\newif\ifNWU@Option@dvipdfm \NWU@Option@dvipdfmtrue
\DeclareOption{dvips}{\NWU@Option@dvipdfmfalse}
\DeclareOption{dvipdfm}{\NWU@Option@dvipdfmtrue}

%% print version or electronic version
\newif\ifNWU@Option@PrintVersion \NWU@Option@PrintVersiontrue
\DeclareOption{pversion}{\NWU@Option@PrintVersiontrue}
\DeclareOption{eversion}{\NWU@Option@PrintVersionfalse}

%% info
\newif\ifNWU@Option@info \NWU@Option@infotrue
\DeclareOption{noinfo}{\NWU@Option@infofalse}

%% ref
\newif\ifNWU@Option@ref@sort \NWU@Option@ref@sortfalse
\newif\ifNWU@Option@ref@compress \NWU@Option@ref@compressfalse
\DeclareOption{refsort}{\NWU@Option@ref@sorttrue}
\DeclareOption{refcompress}
  {\NWU@Option@ref@sorttrue\NWU@Option@ref@compresstrue}

%% others
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%
%% load class and packages
%%%%%%%%%%%%%%%%%%%%

%% book
%%
\LoadClass[a4paper,cs4size,twoside,openright,fancyhdr,fntef,punct]{ctexbook}

%% calc
\RequirePackage{calc}

%% ifthen
\RequirePackage{ifthen}

%% ifpdf
\RequirePackage{ifpdf}

\RequirePackage[titles]{tocloft}

\RequirePackage{caption2}

%% natbib
\ifNWU@Option@ref@sort
  \ifNWU@Option@ref@compress
    \RequirePackage[numbers,sort&compress]{natbib}
  \else
    \RequirePackage[numbers,sort]{natbib}
  \fi
\fi
%% hyperref
\ifpdf
  \RequirePackage[pdftex]{hyperref}
\else
  \ifNWU@Option@dvipdfm
    \RequirePackage{hyperref}%[dvipdfm]
  \else
    \RequirePackage{hyperref}%[dvips]
  \fi
\fi

%% color
\ifNWU@Option@PrintVersion\relax\else
  \RequirePackage{color}
\fi

%% config file
\AtEndOfPackage{\makeatletter\input{ctextemp_NWUthesis.def}\makeatother}
\AtEndOfPackage{\makeatletter\input{ctextemp_NWUthesis.cfg}\makeatother}
\AtEndOfPackage{\makeatletter\renewcommand{\numberline}[1]{%
\settowidth\@tempdimb{#1\hspace{0.25em}}%
\ifdim\@tempdima<\@tempdimb%
  \@tempdima=\@tempdimb%
\fi
\hb@xt@\@tempdima{\@cftbsnum #1\@cftasnum\hfil}\@cftasnumb}\makeatother}
\AtEndOfPackage{\makeatletter\@addtoreset{equation}{chapter}\makeatother}

%%%%%%%%%%%%%%%%%%%%
%% setup packages
%%%%%%%%%%%%%%%%%%%%

%% hyperref
  % GBK -> Unicode
\AtBeginDvi{\special{pdf:tounicode GBK-EUC-UCS2}}
  % setup
\ifNWU@Option@PrintVersion
  \hypersetup{
    a4paper,
    CJKbookmarks,
    bookmarksnumbered,
    plainpages    = false,
    pdfstartview  = FitH
  }
\else
  \definecolor{NWU@hypercolor@darkgreen}{rgb}{0.1,0.5,0.1}
  \hypersetup{
    a4paper,
    CJKbookmarks,
    bookmarksnumbered,
    colorlinks,
    linkcolor     = black,
    anchorcolor   = black,
    citecolor     = blue,
    urlcolor      = blue,
    plainpages    = false,
    pdfstartview  = FitH
  }
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   utilities

\DeclareRobustCommand{\NWU@toc@add}[1]
  {\phantomsection\addcontentsline{toc}{chapter}{#1}}

%% underline
\def\CJKunderlinecolor{}
\def\NWU@@underline[#1]#2{\CTEXunderline{\hbox to #1{\hfill{#2}\hfill}}}
\DeclareRobustCommand{\NWU@underline}
  {\@ifnextchar[\NWU@@underline\CTEXunderline}

\DeclareRobustCommand*{\NWU@bold}{\bfseries}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    font

%% family
\DeclareRobustCommand*{\NWU@font@st}{\songti}
\DeclareRobustCommand*{\NWU@font@ht}{\heiti}
\DeclareRobustCommand*{\NWU@font@fs}{\fangsong}
\DeclareRobustCommand*{\NWU@font@ks}{\kaishu}
\DeclareRobustCommand*{\NWU@font@ls}{\lishu}
\DeclareRobustCommand*{\NWU@font@yy}{\youyuan}

\setCJKfamilyfont{zhsong}[AutoFakeBold = {2}]{SimSun}
%\renewcommand*{\songti}{\CJKfamily{zhsong}}
%\DeclareRobustCommand*{\NWU@font@caption}{zhsong}

%% size
\DeclareRobustCommand*{\NWU@font@zihao}[1]{\zihao{#1}\setlength{\baselineskip}{20pt}}
\renewcommand*{\baselinestretch}{1}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    document setting

%% page ql head
\setlength{\textwidth}{\paperwidth}%
\setlength{\textheight}{\paperheight}%
\setlength\marginparwidth{0cm}%
\setlength\marginparsep{0cm}%
\addtolength{\textwidth}{-5.5cm}% 2.5+2.5+0.5
\setlength{\oddsidemargin}{3cm-1in-\hoffset}%
\setlength{\evensidemargin}{2.5cm-1in-\hoffset}%
\setlength{\topmargin}{2cm-1in-\voffset}%
\setlength{\headheight}{31pt}%
\setlength{\headsep}{0pt}%
\setlength{\textheight}{24cm}%
\setlength{\footskip}{\paperheight-3cm-6pt-\textheight-1.75cm}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    head and foot

%% remove header from empty page

%% label of even page header
\def\NWU@hdr@thesistitle
  {\NWU@label@university\NWU@value@degreemark\NWU@value@thesis}

%% the double line under header
\newcommand{\makeheadrule}{%
\makebox[0pt][l]{\rule[9pt]{\headwidth}{0.5pt}}%
\rule[8pt]{\headwidth}{0.5pt}}
\renewcommand{\headrule}{%
{\if@fancyplain\let\headrulewidth\plainheadrulewidth\fi
\makeheadrule}}

%% set header
\fancypagestyle{plain}{
    \pagestyle{fancy}
}

\pagestyle{fancy}
\fancyhf{}
\fancyhead[CE]{{\NWU@font@st\NWU@font@zihao{5}\NWU@hdr@thesistitle}}
\fancyhead[CO]{{\NWU@font@st\NWU@font@zihao{5}\nouppercase\leftmark}}
\fancyfoot[C]{{\NWU@font@st\NWU@font@zihao{5}\thepage}}
%% par skip
%\parskip 0pt plus 6pt minus 0pt

%% section level
\setcounter{secnumdepth}{4}

%% chapter
\CTEXsetup[name={\NWU@chapter@prenumber,\NWU@chapter@afternumber},
           number={\chinese{chapter}},
           format={\centering\NWU@font@ht\NWU@font@zihao{3}},
           nameformat={},
           numberformat={},
           aftername={\quad},
           titleformat={},
           beforeskip={6pt},
           afterskip={18pt},
           indent={0pt}]{chapter}

%% chapter without number
\DeclareRobustCommand{\NWU@nchapter}[1]{\chapter*{#1}\markboth{#1}{}}

%% section
\CTEXsetup[name={,},
           number={\thesection},
           format={\raggedright\NWU@bold\NWU@font@ht\NWU@font@zihao{-3}},
           nameformat={},
           numberformat={},
           aftername={\quad},
           titleformat={},
           beforeskip={18pt plus 0pt minus 0pt},
           afterskip={12pt},
           indent={0pt}]{section}

%% subsection
\CTEXsetup[name={,},
           number={\thesubsection},
           format={\raggedright\NWU@bold\NWU@font@ht\NWU@font@zihao{4}},
           nameformat={},
           numberformat={},
           aftername={\quad},
           titleformat={},
           beforeskip={12pt plus 0pt minus 0pt},
           afterskip={6pt},
           indent={2em}]{subsection}

%% subsubsection
\CTEXsetup[name={,},
           number={\thesubsubsection},
           format={\raggedright\NWU@bold\NWU@font@ht\NWU@font@zihao{-4}},
           nameformat={},
           numberformat={},
           aftername={\quad},
           titleformat={},
           beforeskip={6pt plus 0pt minus 0pt},
           afterskip={0pt},
           indent={4em}]{subsubsection}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    figure and table

%% figure name
\CTEXoptions[figurename={\zihao{5}\NWU@label@figure@cap}]

%% table name
\CTEXoptions[tablename={\zihao{5}\NWU@label@table@cap}]
\newcommand{\tabincell}[2]{\begin{tabular}{@{}#1@{}}#2\end{tabular}} %

\renewcommand{\theequation}{\arabic{chapter}-\arabic{equation}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    chinese  cover
%% ql first
\DeclareRobustCommand{\NWU@make@cover}
{{\CTEXnoindent\thispagestyle{empty}%
    \normalfont\NWU@font@st\NWU@font@zihao{2}\setlength{\baselineskip}{30pt}%
    \makebox[\textwidth]{\rule{0pt}{14.5cm}}
    \rule[-3.2cm]{0pt}{3.2cm}\parbox[t]{\textwidth}{%
    %\begin{center}%
        %{\NWU@bold\NWU@value@thesis@title}%
    %\end{center}%
    }
    %\makebox[\textwidth]{\rule{0pt}{1cm}}
    %\rule[-3.2cm+15pt]{0pt}{3.2cm}\hspace{3cm}\parbox[t]{9cm}{%
    %\NWU@font@zihao{4}\setlength{\baselineskip}{30pt}%
    %\newlength{\linelength}
    %\setlength{\linelength}{9cm-4.5em}
    %\NWU@bold\NWU@font@ht{~}\NWU@font@st\NWU@underline[\linelength]{\hspace{2.94em}\NWU@value@author@name}\\
    %\setlength{\linelength}{9cm-9.5em}
    %\NWU@bold\NWU@font@ht{~}\NWU@font@st\NWU@underline[\linelength]{\NWU@value@advisor@name~\NWU@value@advisor@title}\\%
    %\setlength{\linelength}{9cm-6.5em}
    %\NWU@bold\NWU@font@ht{~}\NWU@font@st\NWU@underline[\linelength]{\hspace{1.85em}\NWU@value@degree}%
    %}
\clearpage\thispagestyle{empty}\CTEXindent\cleardoublepage}}

\DeclareRobustCommand{\NWU@make@title}
  {{\cleardoublepage\CTEXnoindent\thispagestyle{empty}%

    \normalfont\NWU@font@st\renewcommand{\baselinestretch}{1.2}\zihao{5}%
    \rule{0pt}{1.35cm}\parbox[b]{4.5cm}{
        \NWU@bold\NWU@label@cover@UDC\NWU@underline[73pt]{\NWU@value@thesis@UDC}\par%
        \vspace{2pt}%
        \NWU@bold\NWU@label@cover@classification\NWU@underline[73pt]{\NWU@value@thesis@classification}%
    }
    \hfill\parbox[b]{4.5cm}{
        \NWU@bold\NWU@label@cover@studentNo\NWU@underline[83pt]{\NWU@value@thesis@studentNo}\par%
        \vspace{2pt}%
        \NWU@bold\NWU@label@cover@confidential\NWU@underline[83pt]{\NWU@value@thesis@confidential}%
    }

\renewcommand{\baselinestretch}{1}%
    \vspace{2.05cm}%
    \makebox[\textwidth]{\rule{0pt}{4.5cm}\shortstack[c]{
        \NWU@bold\NWU@font@ht\NWU@font@zihao{1}\setlength{\baselineskip}{30pt}\NWU@label@university\\%
        \vspace{60pt} \\%
        \NWU@bold\NWU@font@st\NWU@font@zihao{-1}\setlength{\baselineskip}{30pt}\NWU@value@degreemark\NWU@value@thesis%
    }}
    \rule{0pt}{2.7cm}%
    \rule[-3.2cm]{0pt}{3.2cm}\parbox[t]{\textwidth}{
    \begin{center}%
     \NWU@bold\NWU@font@zihao{2}\setlength{\baselineskip}{30pt}\NWU@value@thesis@title%
    \end{center}%
    }

    \vspace{2.5cm}%
    \hspace{4.5cm}\parbox{11cm}{
        \NWU@font@st\NWU@font@zihao{4}\setlength{\baselineskip}{32pt}%
        {\NWU@bold\NWU@label@cover@author}\NWU@value@author@name\\%
        {\NWU@bold\NWU@label@cover@major}\NWU@value@author@major\\%
        {\NWU@bold\NWU@label@cover@submajor}\NWU@value@author@submajor\\%
        {\NWU@bold\NWU@label@cover@degree}\NWU@value@degree\\%
        {\NWU@bold\NWU@label@cover@advisor}\NWU@value@advisor@name~\NWU@value@advisor@title\\%
        {\NWU@bold\NWU@label@cover@school}\NWU@value@school\\%
        {\NWU@bold\NWU@label@cover@submit@date}\NWU@value@thesis@submit@date%
    }
   \clearpage\thispagestyle{empty}%
   \renewcommand{\baselinestretch}{1}%
   \CTEXindent\cleardoublepage}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    english  cover

\DeclareRobustCommand{\NWU@make@titleenglish}
  {{\cleardoublepage\CTEXnoindent\thispagestyle{empty}%
    \normalfont\NWU@font@st%

    \rule[-3.5cm]{0pt}{3.5cm}\parbox[t]{\textwidth}{%
    \NWU@font@zihao{2}\setlength{\baselineskip}{30pt}%
    \begin{center}%
        {\NWU@bold\NWU@evalue@thesis@title}%
    \end{center}%
    }
    \rule{0pt}{2.5cm}%
    \rule[-5.5cm]{0pt}{5.5cm}\parbox[t]{\textwidth}{%
    \NWU@font@zihao{3}\setlength{\baselineskip}{30pt}%
    \begin{center}%
A\space\NWU@evalue@papertype\space submitted to\par\NWU@elabel@university\par%
in partial fulfillment of the requirements \par for the degree of\space\NWU@evalue@degree%
\par in\space\NWU@evalue@author@submajor%
    \end{center}%
    }
    \rule{0pt}{7.2cm}%
    \rule[-4.5cm]{0pt}{4.5cm}\parbox[t]{\textwidth}{%
    \NWU@font@zihao{3}\setlength{\baselineskip}{30pt}%
    \begin{center}%
By \par%
\NWU@evalue@author@name\par%
\NWU@elabel@cover@advisor\NWU@evalue@advisor@name~~\NWU@evalue@advisor@title\par%
\NWU@evalue@thesis@submit@date\par%
    \end{center}%
    }
   \clearpage\thispagestyle{empty}%
   \CTEXindent\cleardoublepage}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    statement and copyright

\DeclareRobustCommand{\NWU@make@statementandcopyright}
  {{\cleardoublepage\CTEXnoindent\thispagestyle{empty}%
  \normalfont\NWU@font@st%
   \begin{center}%
   \bfseries\NWU@font@zihao{4}%
     \NWU@label@stat@statement%
   \end{center}%
   \NWU@font@zihao{-4}%
   \hspace*{2em}\CTEXindent\NWU@value@stat@statement\CTEXnoindent%
  \vskip 20pt%
   \hspace*{2em}\NWU@lable@stat@auther\NWU@underline[100pt]{}\hspace*{1em}%
    \hfill \NWU@lable@stat@date\NWU@underline[100pt]{}\hspace*{1em}
  \vskip \stretch{6}%
   \begin{center}%
     \bfseries\NWU@font@zihao{4}%
     \NWU@lable@stat@copyright%
   \end{center}%
   \NWU@font@zihao{-4}%
   \hspace*{2em}\CTEXindent\NWU@value@stat@copyright\CTEXnoindent%
  \vskip 20pt%
   \normalfont\NWU@font@st\NWU@font@zihao{-4}%
   \hspace*{2em}\NWU@lable@stat@auther\NWU@underline[100pt]{}\hspace*{1em}%
    \hfill \NWU@lable@stat@advisor\NWU@underline[100pt]{}\hspace*{1em}%
  \vskip 20pt%
   \hspace*{2em}\NWU@lable@stat@date\NWU@underline[100pt]{}\hspace*{1em}%
    \hfill \NWU@lable@stat@date\NWU@underline[100pt]{}\hspace*{1em}%
  \vskip \stretch{1}%
  \clearpage\thispagestyle{empty}%
  \CTEXindent\cleardoublepage}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    abstract

%% chinese abstract
\newenvironment{abstract}
  {\NWU@toc@add{\NWU@toc@abstract}%
   \NWU@nchapter{\NWU@label@abstract}\NWU@font@zihao{-4}}
  {\cleardoublepage}

%% chinese keywords
\DeclareRobustCommand{\keywords}[1]
  {{\CTEXnoindent\vspace{20pt}%
   \normalfont\NWU@font@st\bfseries\NWU@font@zihao{-4}%
   \NWU@label@keywords%
   \normalfont\NWU@font@st\NWU@font@zihao{-4}%
   {#1}\CTEXindent}}

%% english abstract
\newenvironment{englishabstract}
  {\NWU@toc@add{\NWU@etoc@abstract}\NWU@nchapter{\NWU@elabel@abstract}%
   \vspace{-2ex}\CTEXnoindent\normalfont\NWU@font@zihao{-4}%
   \CTEXnoindent}
  {\cleardoublepage}

%% english keywords
\DeclareRobustCommand{\englishkeywords}[1]
  {{\CTEXnoindent\vspace{2ex}%
   \normalfont\NWU@font@st\bfseries\NWU@font@zihao{-4}%
   \NWU@elabel@keywords~%
   \normalfont\NWU@font@st\NWU@font@zihao{-4}%
   {#1}\CTEXindent}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    content
    \renewcommand{\cftdot}{\ldots}
    \renewcommand{\cftdotsep}{0.1}
    \setlength{\cftbeforechapskip}{0pt}
    \setlength{\cftbeforesecskip}{0pt}
    \setlength{\cftbeforesubsecskip}{0pt}
    \renewcommand{\cftchapfont}{\NWU@font@ht\NWU@font@zihao{-4}}
    \renewcommand{\cftsecfont}{\NWU@font@st\NWU@font@zihao{-4}}
    \renewcommand{\cftsubsecfont}{\NWU@font@st\NWU@font@zihao{-4}}
    \renewcommand{\cftchapleader}{\cftdotfill{\cftchapdotsep}}
    \renewcommand{\cftchapdotsep}{\cftdotsep}
    \renewcommand{\cftchappagefont}{\NWU@font@st\NWU@font@zihao{-4}}
    \renewcommand{\cftsecpagefont}{\NWU@font@zihao{-4}}
    \renewcommand{\cftsubsecpagefont}{\NWU@font@zihao{-4}}
    \renewcommand{\cftfigfont}{\NWU@font@st\NWU@font@zihao{-4}}
    \renewcommand{\cftloftitlefont}{\NWU@font@st\NWU@font@zihao{-4}}
    \renewcommand{\cftfigpagefont}{\NWU@font@st\NWU@font@zihao{-4}}
    \renewcommand{\cfttabfont}{\NWU@font@st\NWU@font@zihao{-4}}
    \renewcommand{\cftlottitlefont}{\NWU@font@st\NWU@font@zihao{-4}}
    \renewcommand{\cfttabpagefont}{\NWU@font@st\NWU@font@zihao{-4}}

    \setlength{\abovecaptionskip}{0pt}
    \setlength{\belowcaptionskip}{0pt}
    \renewcommand{\captionlabeldelim}{\ ~}%
    \renewcommand{\captionfont}{\NWU@font@st\NWU@font@zihao{5}}

\usepackage{tocloft}
\usepackage{longtable}
\renewcommand{\cftfigpresnum}{~}
\renewcommand{\cfttabpresnum}{~}
\renewcommand{\cftfigaftersnumb}{~~~~~}
\renewcommand{\cfttabaftersnumb}{~~~~~}

%% list of figures
\CTEXoptions[listfigurename={\NWU@label@listoffigures}]
\DeclareRobustCommand{\NWU@listoffigures}
  {\NWU@toc@add{\NWU@toc@listoffigures}%
    \listoffigures}

%% list of tables
\CTEXoptions[listtablename={\NWU@label@listoftables}]
\DeclareRobustCommand{\NWU@listoftables}
  {\NWU@toc@add{\NWU@toc@listoftables}%
    \listoftables}

%% list of Symbols
\newenvironment{symbollist}
  {\CTEXnoindent\NWU@toc@add{\NWU@toc@symbollist@title}%
   \NWU@nchapter{\NWU@label@symbollist@title}\CTEXindent%
   \begin{list}{}
    {\setlength{\topsep}{0pt}\setlength{\itemsep}{0pt}\setlength{\parsep}{0pt}
    \CTEXnoindent\normalfont\NWU@font@st\NWU@font@zihao{-4}
     \setlength{\leftmargin}{0.5\labelwidth}}}
  {\end{list}\CTEXindent\cleardoublepage}

%% list of abbreviations
\newenvironment{abbreviationlist}
  {\CTEXnoindent\NWU@toc@add{\NWU@toc@abbreviationlist@title}%
   \NWU@nchapter{\NWU@label@abbreviationlist@title}\CTEXindent%
   \begin{list}{}
    {\setlength{\topsep}{0pt}\setlength{\itemsep}{0pt}\setlength{\parsep}{0pt}
    \CTEXnoindent\normalfont\NWU@font@st\NWU@font@zihao{-4}
     \setlength{\leftmargin}{0.5\labelwidth}}}
  {\end{list}\CTEXindent\cleardoublepage}

%% content
\CTEXoptions[contentsname={\NWU@label@content}]
\DeclareRobustCommand{\NWU@tableofcontents}
  {\tableofcontents}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    referrence
\renewcommand{\UrlFont}{\NWU@font@zihao{5}}
\CTEXoptions[bibname={\NWU@label@ref@title}]
\bibliographystyle{gbt7714-2005}

\renewenvironment{thebibliography}[1]
  {\NWU@toc@add{\NWU@toc@ref@title}%
   \NWU@nchapter{\bibname}%
   \NWU@font@zihao{5}%
   \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
   \list{\@biblabel{\@arabic\c@enumiv}}%
    {\setlength{\topsep}{0pt}\setlength{\itemsep}{0pt}\setlength{\parsep}{0pt}
    \settowidth\labelwidth{\@biblabel{#1}}%
     \leftmargin\labelwidth\advance\leftmargin\labelsep%
     \@openbib@code\usecounter{enumiv}\let\p@enumiv\@empty%
     \renewcommand\theenumiv{\@arabic\c@enumiv}}%
   \sloppy\clubpenalty4000\@clubpenalty\clubpenalty%
   \widowpenalty4000\sfcode`\.\@m}
  {\def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
   \endlist}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    results

\newenvironment{results}
{\CTEXnoindent\NWU@toc@add{\NWU@toc@results@title}%
	\NWU@nchapter{\NWU@label@results@title}%
	\renewcommand{\thesection}{\arabic{section}}\CTEXindent}
{\cleardoublepage}

%% results list
\newcounter{NWU@counter@resultslistcounter}
\newenvironment{resultslist}[1]
{%{\subsection*{\textbf{#1}}\CTEXindent}%
	\begin{list}{[\arabic{NWU@counter@resultslistcounter}]}
		{\usecounter{NWU@counter@resultslistcounter}
			\setcounter{NWU@counter@resultslistcounter}{0}
			\setlength{\topsep}{0pt}\setlength{\itemsep}{0pt}\setlength{\parsep}{0pt}
			\CTEXnoindent\normalfont\NWU@font@st\NWU@font@zihao{-4}
			\setlength{\leftmargin}{2\labelwidth}}}
	{\end{list}}

\newenvironment{resultslist*}
{\begin{list}{}
		{\setlength{\topsep}{0pt}\setlength{\itemsep}{0pt}\setlength{\parsep}{0pt}
			\CTEXnoindent\normalfont\NWU@font@st\NWU@font@zihao{-4}
			\setlength{\leftmargin}{\labelwidth}}}
	{\end{list}}

%% resultslistitem list item
\DeclareRobustCommand{\resultslistitem}{\item{}}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    thanks

\renewenvironment{thanks}
  {\NWU@toc@add{\NWU@toc@thanks}%
   \NWU@nchapter{\NWU@label@thanks}}
  {}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    resume

%% environment
\newenvironment{resume}
  {\CTEXnoindent\NWU@toc@add{\NWU@toc@resume@title}%
   \NWU@nchapter{\NWU@label@resume@title}%
   \renewcommand{\thesection}{\arabic{section}}\CTEXindent}
  {\cleardoublepage}

%% resume list
\newcounter{NWU@counter@resumelistcounter}
\newenvironment{resumelist}[1]
  {%{\subsection*{\textbf{#1}}\CTEXindent}%
   \begin{list}{[\arabic{NWU@counter@resumelistcounter}]}
    {\usecounter{NWU@counter@resumelistcounter}
     \setcounter{NWU@counter@resumelistcounter}{0}
     \setlength{\topsep}{0pt}\setlength{\itemsep}{0pt}\setlength{\parsep}{0pt}
     \CTEXnoindent\normalfont\NWU@font@st\NWU@font@zihao{-4}
     \setlength{\leftmargin}{2\labelwidth}}}
  {\end{list}}

\newenvironment{resumelist*}
  {\begin{list}{}
    {\setlength{\topsep}{0pt}\setlength{\itemsep}{0pt}\setlength{\parsep}{0pt}
    \CTEXnoindent\normalfont\NWU@font@st\NWU@font@zihao{-4}
     \setlength{\leftmargin}{\labelwidth}}}
  {\end{list}}

%% resume list item
\DeclareRobustCommand{\resumelistitem}{\item{}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    thesis structure

%% front matter
\DeclareRobustCommand{\NWUfrontmatter}
  {\NWU@make@cover%
   %\NWU@make@title%
   \NWU@make@titleenglish%
   %\NWU@make@statementandcopyright%
   \includepdfmerge{chapters/statement.pdf,1-2}
   \frontmatter\pagenumbering{Roman}%
   \setlength{\baselineskip}{20pt}}

%% premain matter
\DeclareRobustCommand{\NWUpremainmatter}
  {\NWU@listoffigures\cleardoublepage%
   \NWU@listoftables\cleardoublepage%
  }
%% main matter
\DeclareRobustCommand{\NWUmainmatter}
  {\NWU@tableofcontents\cleardoublepage%
   \mainmatter}

%% back matter
\DeclareRobustCommand{\NWUbackmatter}[1]
  {\backmatter{}#1{}}
