\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{UNIPRletter}
\RequirePackage{graphicx}
\RequirePackage{epstopdf}
\RequirePackage{epsfig}
\RequirePackage{ifthen}
\RequirePackage{xcolor}
\definecolor{slcolor}{HTML}{882B21}
\DeclareGraphicsExtensions {.png}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions
\LoadClass[letterpaper]{letter}

\newcommand{\subjectname}{Subject}
\newcommand{\@subject}{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{\subjectname: #1}}

\newboolean{logofound}
\IfFileExists{unipr_full_logo.png}
    {\setboolean{logofound}{true}}
    {\setboolean{logofound}{false}}

\setlength{\textwidth}{6.875in}
\setlength{\textheight}{7.0in}
\setlength{\topskip}{0.0in}
\setlength{\footskip}{1.0in}
\setlength{\oddsidemargin}{-0.25in}
\setlength{\evensidemargin}{-0.25in}
\setlength{\topmargin}{-0.875in}

\DeclareFixedFont{\xcmrbn}{OT1}{cmr}{b}{n}{10}
\DeclareFixedFont{\xcmrmn}{OT1}{cmr}{m}{n}{10}
\DeclareFixedFont{\ixcmrmn}{OT1}{cmr}{m}{n}{9}

\newsavebox{\departmenthead}
\newsavebox{\departmentfoot}

\sbox{\departmenthead}{
    \begin{tabular*}{\textwidth}
        {@{}l@{\extracolsep{0.0in}}|@{\extracolsep{0.125in}}l@{}}
    \parbox{4.00in}
    {\raggedright
        \ifthenelse{\boolean{logofound}}
           {\epsfig{file=unipr_full_logo.png, height=1.30in}}
           {\parbox[c][2.0in][c]{4.0in}{\hfill} 
            \ClassWarning{UNIPRletter}{unipr_full_logo.jpg COULD NOT BE FOUND!}}
    } &

    \parbox[c][1.8in][c]{2.225in}{{~}\\
}\\
    \end{tabular*}
}

\savebox{\departmentfoot}[\textwidth][c]{\ixcmrmn
     UNIPR $\cdot$
     ~Facoltà di Informatica $\cdot$
     ~Parco Area delle Scienze, 53/A  $\cdot$
     ~43124, Parma PR, Italia
}

\renewcommand{\ps@firstpage}{
    \setlength{\headheight}{1.375in}
    \setlength{\headsep}{1.0in}
    \renewcommand{\@oddhead}{\usebox{\departmenthead}}
    \renewcommand{\@oddfoot}{\usebox{\departmentfoot}}
    \renewcommand{\@evenhead}{\usebox{\departmenthead}}
    \renewcommand{\@evenfoot}{\usebox{\departmentfoot}}
}

\renewcommand{\ps@empty}{
    \setlength{\headheight}{1.0in}
    \setlength{\headsep}{0.5in}
    \renewcommand{\@oddhead}{}
    \renewcommand{\@oddfoot}{\usebox{\emptyfoot}}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{\usebox{\emptyfoot}}
}

\providecommand{\@evenhead}{}
\providecommand{\@oddhead}{}
\providecommand{\@evenfoot}{}
\providecommand{\@oddfoot}{}

\pagestyle{empty}

% command to the opening
\renewcommand{\opening}[1]{\thispagestyle{firstpage}
    \ifx\@empty\fromaddress
    \else 
        {\raggedleft
            \begin{tabular}{l@{}}\ignorespaces
            \fromaddress \\ *[1\parskip]
            \end{tabular}\par
        }
     \fi
     \vspace{-6\parskip}
     \@date \vspace{2\parskip}\\
     {\raggedright \toname \\ \toaddress \par}
     \vspace{1\parskip}
     \ifthenelse{\equal{\@subject}{}}{}{\@subject\par}
     \vspace{1\parskip}
     #1\par\nobreak
}