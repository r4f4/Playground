% % % % % % % % % % % % % % % % % % % % % % % % 
%
% LaTeX2e class
%
% SBA -- Sociedade Brasileira de Automática
%
% Version: 1.0 alpha
%
% Writen by: Mauricio C. de Oliveira
%            mcdeoliveira@ieee.org
%            18/12/2000
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sbatex}
[2000/12/18 LaTeX2e class for Revista SBA - 1.0 alpha]

% process submission option
\RequirePackage{ifthen,calc}
\newboolean{isSubmission}
\setboolean{isSubmission}{false}

\DeclareOption{submission}{
  \setboolean{isSubmission}{true}
}

% Set up journal
\DeclareOption{journal}{

  % Issue information
  \def\volume#1{\gdef\@volume{#1}}
  \def\@volume{XX\@latex@warning@no@line{No \noexpand\volume given}}

  \def\numero#1{\gdef\@numero{#1}}
  \def\@numero{X\@latex@warning@no@line{No \noexpand\numero given}}

  \def\mes#1{\gdef\@mes{#1}}
  \def\@mes{Meses\@latex@warning@no@line{No \noexpand\mes given}}

  \def\ano#1{\gdef\@ano{#1}}
  \def\@ano{XXXX\@latex@warning@no@line{No \noexpand\ano given}}

  \newcommand{\aceito}[1]{
    \renewcommand{\@makefnmark}{}
    \footnotetext{{\sffamily #1}}
    \renewcommand{\@makefnmark}{\ensuremath{^{\@thefnmark}}}
    \setcounter{footnote}{0}
  }
  \newcommand{\pagina}[1]{\setcounter{page}{#1}}

  \ifthenelse{\boolean{isSubmission}}{
    % pass options to class article
    \PassOptionsToClass{11pt,onecolumn,oneside}{article}
  }{
    % pass options to class article
    \PassOptionsToClass{10pt,twocolumn,twoside}{article}
  }
  \AtEndOfPackage{

    % section layout
    \renewcommand\section{\@startsection{section}{1}
                          {0pt}
                          {-6pt}
                          {1pt}
                         {\large\sffamily\bfseries\MakeUppercase}}
    \renewcommand\subsection{\@startsection{subsection}{2}
                             {0pt} 
                             {-6pt}
                             {1pt}
                             {\large\sffamily\bfseries}}
    \renewcommand\subsubsection{\@startsection{subsubsection}{3}
                                {0pt}
                                {-6pt}
                                {1pt}
                                {\normalsize\sffamily\bfseries}}

    % authors and address
    \newcounter{author}
    \newcounter{tmpauthor}

    \newcommand\listofauthors{\@starttoc{loa}}
    \newcommand{\l@authors}[2]{
      \begin{minipage}[t]{0.49\textwidth}
        \begin{center}
          \begin{tabular}{c}
            #1
          \end{tabular}
        \end{center}
      \end{minipage}
    }

    \newcommand{\newauthor}[3][-1]{
      \ifthenelse{\equal{#1}{-1}}
        { \stepcounter{author} }
        { \setcounter{tmpauthor}{\theauthor}
          \setcounter{author}{#1} }
      \addcontentsline{loa}{authors}
        { {\large\bfseries #2$^\fnsymbol{author}$} \\ {\ttfamily #3} }
      \ifthenelse{\equal{#1}{-1}}
        {}
        { \setcounter{author}{\thetmpauthor} }
    }

    \newcommand{\newaddress}[1]{
      \stepcounter{address}
      \addcontentsline{los}{addresses}
        { {$^\fnsymbol{address}$#1} }
    }

    \let\author\newauthor
    \let\address\newaddress

    % maketitle
    \def\@maketitle{%
      \newpage
      \begin{center}%
        \hbox{\rule{\textwidth}{6pt}}
        \vskip 1pt 
        \hbox{\rule{\textwidth}{0.4pt}}
        \vskip 3mm
        {\Large\sffamily\bfseries\MakeUppercase\@title \par}%
        \vskip 12mm 
        \lineskip .5em
        {\centering{\listofauthors} \par}
        \vskip 6pt
        {\centering{\listofaddresses} \par}
        \vskip 8mm 
        \hbox{\rule{\textwidth}{6pt}}
        \vskip 1pt 
        \hbox{\rule{\textwidth}{0.4pt}}
        \vskip 30pt
      \end{center}
    }

    % set font = times on journal style
    \RequirePackage{times}

    \ifthenelse{\boolean{isSubmission}}{
      % set page dimensions
      \geometry{margin=2cm,nohead,nofoot}

      % load set space
      \RequirePackage{setspace}
    }{
      % set page dimensions
      %\geometry{margin=17.5mm,twosideshift=2.5mm,top=50mm,bottom=11mm,footskip=9mm,nohead}
      \geometry{margin=17.5mm,twosideshift=2.5mm,top=45mm,headsep=0pt,headheight=5mm,bottom=11mm,footskip=9mm,}

      % include marker
      \special{!
        userdict begin
          /mm {72 mul 25.4 div} def % Convert inches->points (1/72 inch)
          /bop-hook {
            newpath		    % Start a new path
            0 mm 267 mm moveto      %
            30 mm 267 mm lineto     % 
            180 mm 267 mm moveto    %
            210 mm 267 mm lineto    %
            0.1 setlinewidth        % set line width
            stroke                  % Draw the outer lines
          } def end
      }
    }

    % header and footer
    \RequirePackage{fancyhdr}
    \renewcommand\headrulewidth{0pt}
    \ifthenelse{\boolean{isSubmission}}{
      \def\currentfooter{Artigo proposto \`{a} Revista Controle \&
Automa\c{c}\~{a}o em \today}
    }{
      \def\currentfooter{Revista Controle \&
      Automa\c{c}\~{a}o/Vol.\@volume~no.\@numero/\@mes\ \@ano}
    }
    \cfoot{} \rhead{} \lhead{}
    \lfoot[\footnotesize \sffamily\bfseries \thepage \hskip 3mm \currentfooter]{}
    \rfoot[]{\footnotesize \sffamily\bfseries \currentfooter \hskip 3mm \thepage}

    % set page style
    \pagestyle{fancy}

    % page layout parameters
    \setlength\parindent{0pt}
    \setlength\parskip{9pt}
    \setlength\columnsep{5mm}


    % Set theorem body font to roman
    \theorembodyfont{\rmfamily}

    %% Keywords
    \def\keywords#1{
      \par
      {\small \sffamily \textbf{\MakeUppercase{\keywordlabel}}}: #1
      \par
    }
  }

  
  % turn on double space
  \ifthenelse{\boolean{isSubmission}}{
    \AtBeginDocument{\begin{doublespace}}
    \AtEndDocument{\end{doublespace}}
  }{}

}

% set up conference
\DeclareOption{conference}{

  % ignore submission flag
  \setboolean{isSubmission}{false}

  % pass options to class article
  \PassOptionsToClass{10pt,twocolumn,oneside}{article}
  \AtEndOfPackage{

    % section layout
    \renewcommand\section{\@startsection{section}{1}
                         {\z@}
                         {-3.5ex plus -1ex minus -.2ex}
                         {2.3ex plus .2ex}
                         {\centering\bfseries}}
    \renewcommand\subsection{\@startsection{subsection}{2}
                            {\z@}
                            {-3.25ex plus -1ex minus -.2ex}
                            {1.5ex plus .2ex}
                            {\itshape}}

    % authors and address
    \newcounter{author}
    \newcounter{tmpauthor}

    \def\@eebuffer{}
    \def\addemail #1{\expandafter\def\expandafter\@eebuffer\expandafter
                     {\@eebuffer #1\relax}}

    \newcommand\listofauthors{\@starttoc{loa}}
    \newcommand{\l@authors}[2]{#1}

    \newcommand{\newauthor}[3][-1]{
      \setcounter{tmpauthor}{\theauthor}
      \ifthenelse{\equal{#1}{-1}}
        { \stepcounter{author} }
        { \setcounter{author}{#1} }
      \ifthenelse{\value{tmpauthor} = 0}
        { }
        { \addcontentsline{loa}{authors}{\hspace{-2ex}~,}
          \addemail{, } }
      \addemail{\ttfamily{#3}}
      \addcontentsline{loa}{authors}{\scshape{#2}$^\fnsymbol{author}$}
      \ifthenelse{\equal{#1}{-1}}
        {}
        { \setcounter{author}{\thetmpauthor} }
    }

    \newcommand{\newaddress}[1]{
      \stepcounter{address}
      \addcontentsline{los}{addresses}
        { {\normalsize\itshape{$^\fnsymbol{address}$#1}} }
    }

    \let\author\newauthor
    \let\address\newaddress

    % maketitle
    \def\@maketitle{%
      \newpage
      \begin{center}
         {\bf \MakeUppercase \@title \par}
         \vskip 2em                      % Vertical space after title.
         \lineskip .5em
         {\centering{\listofauthors} \par}
         \vskip 6pt
         {\centering{\listofaddresses} \par}
         \vskip 3pt
         {\centering{
            \ifthenelse{\value{tmpauthor} = 0}
              { Email: }
              { Emails: }
            \@eebuffer} \par}
      \end{center}
      \vskip 1.5em \par
    }

    % paragraph with argument to make a runaway title.
    \def\namedpar#1{\paragraph{\footnotesize\bfseries #1---}}
  
    % redifine abstract
    \renewenvironment{abstract}{
      \begin{center}
        \begin{minipage}{5.75truein}
          \footnotesize
          \namedpar{\abstractname}
    }{
        \end{minipage}
      \end{center} 
      \vskip 1ex \par
    }

    % header and footer
    %\RequirePackage{fancyhdr}
    %\renewcommand\headrulewidth{0pt}
    %\cfoot{} \lfoot{} \rfoot{} \rhead{} \lhead{}

    % Set page style
    \pagestyle{empty}

    % page layout parameters
    \setlength{\parindent}{0.25in}
    \setlength{\columnsep}{0.3in}

    % list parameters
    \setlength{\topsep}{1ex}
    \setlength{\partopsep}{0in}
    \setlength{\parsep}{0in}
    \setlength{\itemsep}{0in}

    % set page dimensions
    \geometry{width=6.27in,height=10in,nohead,nofoot}

    %% Keywords
    \def\keywords#1{
      \renewcommand{\abstractname}{\keywordlabel}
      \begin{abstract}
        #1
      \end{abstract}
    }
  }
}

\DeclareOption{harvard}{

  \AtEndOfPackage{

    % load package harvard
    \RequirePackage{harvard}

    % configure style
    \iflanguage{english}{}{
    	\renewcommand{\HAR@and@agsm}{\&}
    	\renewcommand{\HAR@and@dcu}{e}
    	\renewcommand{\HAR@and@apsr}{e}
    }
    \citationmode{abbr}
    \citationstyle{dcu}
    \bibliographystyle{dcu}
  }
}

% Process all unknown options through article
\DeclareOption*{
  \PassOptionsToPackage{\CurrentOption}{babel}
  \PassOptionsToClass{\CurrentOption}{article}
}

% Do final as default
%\ifthenelse{\boolean{isSubmission}}
%{\ExecuteOptions{journal}}{}

% Process all options
\ProcessOptions

% Based on article.cls
\LoadClass[a4paper]{article}

% Load Packages

\RequirePackage{babel}
\RequirePackage{theorem}
\RequirePackage{geometry}
\RequirePackage{latexsym}

%% List of adresses
\newcommand\listofaddresses{\@starttoc{los}}
\newcommand{\l@addresses}[2]{#1 \par \vskip 6pt}

\newcounter{address}
\setcounter{address}{0}

%% Thanks
%\def\thanks#1{
%  \protected@xdef\@thanks{\@thanks\protect\footnotetext[\the\c@footnote]{#1}}
%}

%% Define maketitle command
\renewcommand\maketitle{
  \par
  \ifthenelse{\boolean{isSubmission}}{\begin{singlespace}}{}
  \begingroup
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
    %\thispagestyle{fancy}
    \renewcommand{\thefootnote}{\fnsymbol{footnote}}
    {\sffamily \@thanks}
    \renewcommand{\thefootnote}{\arabic{footnote}}
  \endgroup
  \ifthenelse{\boolean{isSubmission}}{\end{singlespace}}{}
}

% Multilanguage labels
\def\theoremlabel{\iflanguage{english}{Theorem}{Teorema}}
\def\corollarylabel{\iflanguage{english}{Corollary}{Corol\'ario}}
\def\lemmalabel{\iflanguage{english}{Lemma}{Lema}}
\def\prooflabel{\iflanguage{english}{Proof}{Prova}}
\def\keywordlabel{\iflanguage{english}{Keywords}{Palavras-chave}}

% Theorems
\newtheorem{theorem}{\theoremlabel}
\newtheorem{corollary}[theorem]{\corollarylabel}
\newtheorem{lemma}[theorem]{\lemmalabel}

\newenvironment{proof}
{ \begin{trivlist} \item[{ \bf \prooflabel:}] }
{ ~\hfill$\Box$ \end{trivlist} }


%%%%%%%%%%%%%%%%%%%%%%
% The logo of sbatex %
%%%%%%%%%%%%%%%%%%%%%%

\DeclareRobustCommand{\SBATeX}{{\small SBA}\kern-.05em\TeX}
