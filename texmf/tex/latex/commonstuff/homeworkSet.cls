\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{homeworkSet}

% Written by Adam Wilson
% Converted to an actual document class by Alex Ferro
% A class for homework assignments
\newcommand\@statementSeperation{\newpage}
\DeclareOption{nobreak}{
  \renewcommand\@statementSeperation{\bigskip}
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass[twoside]{report}

\usepackage{amsmath,amsfonts,amsthm,amssymb}
\usepackage{epsfig,amscd}
\usepackage{setspace}
\usepackage{fancyhdr}
\usepackage{lastpage}
\usepackage{extramarks}
\usepackage{chngpage}
\usepackage{soul}
\usepackage[usenames,dvipsnames]{color}
\usepackage{graphicx,float,wrapfig}
\usepackage{ifthen}
\usepackage{listings}
\usepackage{courier}
\usepackage{url}
\usepackage{listing}
\usepackage{framed}

\definecolor{lstcomment}{rgb}{0,0.6,0}
\definecolor{lstlineno}{rgb}{0.5,0.5,0.5}
\definecolor{lststring}{rgb}{0.58,0,0.82}

\lstset{ %
  backgroundcolor=\color{white},   % choose the background color; you must add \usepackage{color} or \usepackage{xcolor}
  basicstyle=\footnotesize,        % the size of the fonts that are used for the code
  breakatwhitespace=false,         % sets if automatic breaks should only happen at whitespace
  breaklines=true,                 % sets automatic line breaking
  captionpos=b,                    % sets the caption-position to bottom
  commentstyle=\color{lstcomment},    % comment style
  deletekeywords={...},            % if you want to delete keywords from the given language
  escapeinside={\%*}{*)},          % if you want to add LaTeX within your code
  extendedchars=true,              % lets you use non-ASCII characters; for 8-bits encodings only, does not work with UTF-8
  frame=single,                    % adds a frame around the code
  keepspaces=true,                 % keeps spaces in text, useful for keeping indentation of code (possibly needs columns=flexible)
  keywordstyle=\color{blue},       % keyword style
  language=C,                 % the language of the code
  morekeywords={*,...},            % if you want to add more keywords to the set
  numbers=left,                    % where to put the line-numbers; possible values are (none, left, right)
  numbersep=5pt,                   % how far the line-numbers are from the code
  numberstyle=\tiny\color{lstlineno}, % the style that is used for the line-numbers
  rulecolor=\color{black},         % if not set, the frame-color may be changed on line-breaks within not-black text (e.g. comments (green here))
  showspaces=false,                % show spaces everywhere adding particular underscores; it overrides 'showstringspaces'
  showstringspaces=false,          % underline spaces within strings only
  showtabs=false,                  % show tabs within strings adding particular underscores
  stepnumber=2,                    % the step between two line-numbers. If its 1, each line will be numbered
  stringstyle=\color{lststring},     % string literal style
  tabsize=2,                       % sets default tabsize to 2 spaces
  title=\lstname                   % show the filename of files included with \lstinputlisting; also try caption instead of title
}

% User defined commands

% use a monospace font for method and type names
\newcommand{\datatype}[1]{\texttt{#1}}
\newcommand{\method}[1]{\texttt{#1}}

% End of user defined commands

% Homework Specific Information
\newcommand{\@hwTitle}{Homework Title}
\newcommand{\@subTitle}{}
\newcommand{\@dueDate}{Due Date}
\newcommand{\@class}{Class Name}
\newcommand{\@semester}{Semester}
\newcommand{\@instructor}{Instructor Name}
\newcommand{\@authorName}{Your name}
\newcommand{\@authorId}{Your uNID}

\newcommand{\hwTitle}[1]{\renewcommand\@hwTitle{#1}}
\newcommand{\subTitle}[1]{\renewcommand\@subTitle{#1}}
\newcommand{\dueDate}[1]{\renewcommand\@dueDate{#1}}
\newcommand{\class}[1]{\renewcommand\@class{#1}}
\newcommand{\semester}[1]{\renewcommand\@semester{#1}}
\newcommand{\instructor}[1]{\renewcommand\@instructor{#1}}
\newcommand{\authorName}[1]{\renewcommand\@authorName{#1}}
\newcommand{\authorId}[1]{\renewcommand\@authorId{#1}}

% Comment this block for default LaTeX enumerate behavior
\renewcommand{\labelenumi}{\alph{enumi})}
\renewcommand{\labelenumii}{\roman{enumii})}

% In case you need to adjust margins:
\topmargin=-0.45in      %
\evensidemargin=0in     %
\oddsidemargin=0in      %
\textwidth=6.5in        %
\textheight=9.0in       %
\headsep=0.25in         %

% No paragraph indentation for the document
\setlength{\parindent}{0in}

% Get rid of the line above footnote text
\renewcommand{\footnoterule}{}

% Setup the header and footer
\pagestyle{fancy}                                                       %
\lhead{\@authorName}                                                 %
\chead{\@class:\ \@hwTitle\ (\@instructor)}                 %
\rhead{\firstxmark}                                                     %
\lfoot{\lastxmark}                                                      %
\cfoot{}                                                                %
\rfoot{Page\ \thepage\ of\ \protect\pageref{LastPage}}                  %
\renewcommand\headrulewidth{0.4pt}                                      %
\renewcommand\footrulewidth{0.4pt}                                      %

\let\@oldmaketitle\maketitle
\renewcommand{\maketitle}{
\title{\vspace{2in}\textmd{\textbf{\@class\\\@hwTitle\ifthenelse{\equal{\@subTitle}{}}{}{\\\@subTitle}}}\\\normalsize\vspace{0.1in}\small{Due\ \@dueDate}\\\vspace{0.1in}\large{\textit{\@instructor}}\\\vspace{.01in}\small{\textit{\@semester}}\vspace{3in}}
\date{}
\author{\textbf{\@authorName}\\\textbf{\@authorId}}
\@oldmaketitle
%-----------------------------
%For double sided printing use:
%\thispagestyle{empty}
%\cleardoublepage
%--OR--
%For single sided printing use:
\newpage
%-----------------------------
\setcounter{page}{1}
}

%-----

\newenvironment{homeworkproblem}[3]{\@statementSeperation
				    \nobreak\extramarks{#1}{}\nobreak
                                    \nobreak\extramarks{#1 (continued)}{}\nobreak\lfoot{#3}\textbf{\underline{#1}\ifthenelse{\equal{#2}{}}{}{:\ #2}}\\}{\medskip}
\newenvironment{problemstatement}[0]{\begin{framed}}{\end{framed}}
\newenvironment{subproblem}[2]{\ifthenelse{\equal{#2}{}}{\textbf{#1:}}{\textbf{#1:} \emph{#2}}\newline\newline}{\ \newline}
