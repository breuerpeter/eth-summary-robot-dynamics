%=================================================================
% MIT LICENSE
%=================================================================
% Copyright (c) 2022 Griffin J. Norris
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%=================================================================

\NeedsTeXFormat{LaTeX2e}
\LoadClass[10pt,usenames,dvipsnames,twoside]{article}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{norrisgsummary}[2022/07/14]

%-----------------------------------------------------------------
% GENERAL PACKAGES
%-----------------------------------------------------------------
\RequirePackage[yyyymmdd]{datetime} % change date format
\renewcommand{\dateseparator}{} % select date separator character
\RequirePackage[shortlabels]{enumitem} % pause/resume lists
\RequirePackage{multicol} % multi column format
\RequirePackage{graphicx} % used for figures
\graphicspath{{images/}} % put figures inside folder 'images'  in same folder as .tex
\RequirePackage[dvipsnames]{xcolor} %colors, dvips -> extra premade colors
\RequirePackage[explicit]{titlesec} % formating of titles
\RequirePackage{siunitx} % SI units
\RequirePackage{amsmath}  % math stuff
\RequirePackage{amsfonts} % more math stuff
\RequirePackage{amssymb}
\RequirePackage{mathtools} % even more math stuff
% \RequirePackage{breqn} % honestly I don't even remember
\RequirePackage{empheq} % Fancy boxed equations
\RequirePackage{fancybox} % Additional box types
\RequirePackage{subcaption}
\RequirePackage[hidelinks]{hyperref} % used for hyperlinked nodes
\RequirePackage{cleveref}
\RequirePackage{lipsum} % lorem ipsum
\RequirePackage[document]{ragged2e} % left ragged text
\RequirePackage{atbegshi}  % special commands that apply tikz to all pages
\RequirePackage{fancyhdr} % custom header/footer
\RequirePackage{etoolbox} % Boolean and if/else
\RequirePackage{calc} % math inside other commands
\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{tabularx}
\RequirePackage{xfrac} % nice inline (split) fractions
\RequirePackage{fontawesome} % icons
\RequirePackage{cancel}
\RequirePackage{siunitx}
\RequirePackage{bm} % bold math
\RequirePackage{makecell} % tabular column heads and multilined cells
\RequirePackage{adjustbox}

%=================================================================
% O P T I O N S   S T A R T
%=================================================================

%-----------------------------------------------------------------
% FONT OPTIONS
%-----------------------------------------------------------------
\newtoggle{fontHelvet}
\newtoggle{loadfontspec}
\newtoggle{fontSpartan}

\DeclareOption{fontHelvet}{
    \toggletrue{fontHelvet}
}

\DeclareOption{fontSpartan}{
    \toggletrue{loadfontspec}
    \toggletrue{fontSpartan}
    \togglefalse{fontHelvet}
}


%-----------------------------------------------------------------
% GEOMETRY OPTIONS
%-----------------------------------------------------------------
\newtoggle{hatch}

\newlength{\paperh}
\newlength{\paperw}
\newlength{\inmar}
\newlength{\outmar}
\newlength{\topmar}
\newlength{\botmar}
\newlength{\footmar}
\def\hatchscale{1}

\DeclareOption{a3compact}{
    \setlength\paperh{420mm}
    \setlength\paperw{297mm}
    \setlength\inmar{1mm}
    \setlength\outmar{1mm}
    \setlength\topmar{1mm}
    \setlength\botmar{1mm}
    \setlength\footmar{5mm}
}

\DeclareOption{a3hatched}{
    \setlength\paperh{420mm}
    \setlength\paperw{297mm}
    \setlength\inmar{1mm}
    \setlength\outmar{1mm}
    \setlength\topmar{12mm}
    \setlength\botmar{1mm}
    \setlength\footmar{5mm}
    \toggletrue{hatch}
    \def\hatchscale{1.4}
}

\DeclareOption{a4compact}{
    \setlength\paperh{297mm}
    \setlength\paperw{210mm}
    \setlength\inmar{1mm}
    \setlength\outmar{1mm}
    \setlength\topmar{1mm}
    \setlength\botmar{1mm}
    \setlength\footmar{5mm}
}

\DeclareOption{a4hatched}{
    \setlength\paperh{297mm}
    \setlength\paperw{210mm}
    \setlength\inmar{1mm}
    \setlength\outmar{1mm}
    \setlength\topmar{12mm}
    \setlength\botmar{1mm}
    \setlength\footmar{5mm}
    \toggletrue{hatch}
    \def\hatchscale{1}
}

\DeclareOption{pnumber}{
    \setlength\botmar{8mm}
}

%-----------------------------------------------------------------
% COLOR OPTIONS
%-----------------------------------------------------------------
% color1 - main color
% color2 - Blue color
% color3 - Highlight color

\DeclareOption{colorful}{
    \colorlet{color1}{black}
    \colorlet{color2}{NavyBlue}
    % \colorlet{color3}{Yellow}
    \definecolor{color3}{HTML}{FFE534} % bf2042yellow
}

\DeclareOption{b/w}{
    \colorlet{color1}{black}
    \colorlet{color2}{black}
    \colorlet{color3}{black!20}
}
%-----------------------------------------------------------------
% CONTENT OPTIONS
%-----------------------------------------------------------------
\newtoggle{tikz}
\newtoggle{circuitikz}
\newtoggle{tcolorbox}

\DeclareOption{tikz}{
    \toggletrue{tikz}
}
\DeclareOption{circuitikz}{
    \toggletrue{circuitikz}
}
\DeclareOption{tcolorbox}{
    \toggletrue{tcolorbox}
}

%=================================================================
% PROCESS OPTIONS
%=================================================================
\ExecuteOptions{fontHelvet, a3compact, colorful}
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O P T I O N S   E N D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GLOBAL FORMATTING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-----------------------------------------------------------------
% LOAD PACKAGES
%-----------------------------------------------------------------

\iftoggle{loadfontspec}{
    \RequirePackage{fontspec}
}{}

% Requires Spartan-MB font from: 
% https://github.com/MattBaileyDesign/Spartan-MB
\iftoggle{fontSpartan}{
	\setmainfont[
		Ligatures=TeX,
		UprightFont=*-Medium,
		ItalicFont=*-Medium Italic,
		BoldFont=*-Bold,
	]{Spartan MB}
}{}

\iftoggle{fontHelvet}{
    \RequirePackage[utf8]{inputenc} % more charecter inpus (ü,ö,ä)
    \RequirePackage[T1]{fontenc}
    \RequirePackage{helvet}
    \renewcommand{\familydefault}{\sfdefault}
}{}

\RequirePackage[
    paperheight=\paperh,
    paperwidth=\paperw,
    margin=0.1cm,
    top=\topmar,
    bottom=\botmar,
    headsep=0.5cm,
    headheight=0.5cm,
    footskip=\footmar,
    inner=\inmar,
    outer=\outmar,
    centering
]{geometry}

%-----------------------------------------------------------------
% TIKZ PACKAGES
%-----------------------------------------------------------------
\iftoggle{tikz}{
    \RequirePackage{tikz} % shapes, figures
    \RequirePackage{tikzpagenodes} % points for tikz
    \usetikzlibrary{calc,shapes,arrows,intersections}
    \RequirePackage{tikz-layers}
    \usetikzlibrary{shapes, arrows, arrows.meta, decorations.markings, positioning} % shadows causes problems with lualatex

    \tikzset{
        dynamic/.style={
            draw, rectangle, fill=white,
            minimum height=2em, minimum width=3em, copy shadow={fill=black,shadow xshift=.5ex,shadow yshift=-.5ex}
        },
        static/.style={
            draw, rectangle, fill=white,
            minimum height=2em, minimum width=3em
        },
        sum/.style={
            draw, circle, node distance=1cm
        },
    }
}{}

\iftoggle{circuitikz}{
    \RequirePackage[
        siunitx,
        straightvoltages,
        european resistors
    ]{circuitikz} % Circuits
    \ctikzset{bipoles/length=0.75cm}
}{}

%-----------------------------------------------------------------
% GLOBAL PARAMETER COMMANDS
%-----------------------------------------------------------------
% Set label for header
\newcommand*\@headtitle{SUBJECT}
\newcommand*{\headtitle}[1]{\renewcommand*\@headtitle{#1}}


%-----------------------------------------------------------------
% HEADER/FOOT FORMATTING
%-----------------------------------------------------------------
% remove header and foot
\pagestyle{empty}
% fancy header with NAME in hatching
\pagestyle{fancy}
\fancypagestyle{plain}{
	% clear defaults
	\fancyhf{}
	% page number in footer
	\fancyfoot[C]{\textbf{--- \thepage \ ---}}% LE,RO
	% date in top right
	\fancyhead[RE,RO]{\colorbox{color1}{
			\textcolor{white}{\huge\textbf{REV: \today}}
	}}
	% extra thing in middle
	\fancyhead[C]{\colorbox{color1}{
			\textcolor{white}{\huge\textbf{\@headtitle}}
	}}
    \fancyhead[LE,LO]{\colorbox{color1}{
			\textcolor{white}{\huge\textbf{\@author}}
	}}
	\renewcommand{\headrulewidth}{0pt} % and the line
}
\pagestyle{plain}

% \pagestyle{empty}
% %fancy header with section title in hatching
% \renewcommand{\sectionmark}[1]{\markboth{\colorbox{color1}{
%       % code formatting section titles in header
%       \textcolor{white}{\huge\textbf{#1}}
% }}{}}
% \pagestyle{fancy}
% \fancypagestyle{plain}{
% 	% clear defaults
% 	\fancyhf{}
% 	% page number in footer
% 	\fancyfoot[C]{\textbf{--- \thepage \ ---}}% LE,RO
% 	% date in top right
% 	\fancyhead[RE,RO]{\colorbox{color1}{
% 			\textcolor{white}{\huge\textbf{REV: \today}}
% 	}}
% 	% extra thing in middle
% 	\fancyhead[C]{\colorbox{color1}{
% 			\textcolor{white}{\huge\textbf{DPOC -- SUMMARY}}
% 	}}
%   \fancyhead[LE,LO]{\textbf{\leftmark}}
% 	\renewcommand{\headrulewidth}{0pt} % and the line
% }
% \pagestyle{plain}


%-----------------------------------------------------------------
% OTHER FORMATTING
%-----------------------------------------------------------------
% indent for paragraph
\setlength{\parindent}{0pt}
%space between paragraphs
\setlength{\parskip}{0.3em}

% spacing around eqns
\setlength{\abovedisplayskip}{0pt}
\setlength{\belowdisplayskip}{0pt}
\setlength{\abovedisplayshortskip}{0pt}
\setlength{\belowdisplayshortskip}{0pt}

% space between columns
\setlength{\columnsep}{0.2cm}
% create lines between columns and define color of columns
\setlength{\columnseprule}{1pt} %set thickness default 1pt
\def\columnseprulecolor{\color{black}}

% spacing within lists
\setlist[enumerate]{itemsep=2pt,parsep=0pt,leftmargin=16pt}
\setlist[itemize]{itemsep=2pt,parsep=0pt,leftmargin=10pt}
\setlist[description]{nosep}
%\setlist[enumerate, 1]{itemsep=1pt, parsep=0pt}
%\setlist[enumerate, 2]{itemsep=1pt, parsep=0pt}
%\setlist[itemize, 1]{itemsep=1pt, parsep=0pt}
%\setlist[itemize, 2]{itemsep=1pt, parsep=0pt}

% pros and cons list
\newcommand{\itemPro}{\item[\faPlusCircle]}
\newcommand{\itemCon}{\item[\faMinusCircle]}

\sisetup{range-units=single}

%-----------------------------------------------------------------
% TITLE FORMATTING
%-----------------------------------------------------------------
% \titleformat{<command>}[<shape>]{<format>}{<label>}{<sep>}{<before-code>}[<after-code>]

% formatting of section
\titleformat{\section} % {<command>}
{\color{black}\normalfont\large\bfseries} % {<format>}
{\color{black}\thesection} % {<label>}
{1em} % {<sep>}
{#1} % {<before-code>}
[{\titlerule[1pt]}] % [<after-code>]

% formatting of subsection
\titleformat{\subsection} % {<command>}
{\color{white}\normalfont\bfseries} % {<format>}
{\color{color1}\thesubsection} % {<label>}
{1em} % {<sep>}
{\colorbox{color1}{#1}} % {<before-code>}
[] % [<after-code>]

% 1st number is weird, 2nd is spacing before, 3rd is spacing after section title
\titlespacing{\section}{0pt}{5pt}{2pt}
\titlespacing{\subsection}{0pt}{2pt}{2pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CUSTOM COMMANDS / ENVIRONEMNTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-----------------------------------------------------------------
% COMMANDS
%-----------------------------------------------------------------
% command to create blue, bold mini-titles
\newcommand{\blue}[1]{\textbf{\textcolor{color2}{#1}}}

% defines thickness of boxes
\setlength{\fboxrule}{0.8pt}

%-----------------------------------------------------------------
% CUSTOM ENVIRONMENTS
%-----------------------------------------------------------------
% Boxed equations in color1
\newcommand{\mathbox}[1]{
	\setlength{\abovedisplayskip}{5pt}
	\setlength{\belowdisplayskip}{5pt}
	\begin{empheq}
	[box=\fcolorbox{color1}{white}]
	{align*}
	#1
	\end{empheq}
}

% Boxed equations in color 1 with yellow highlighting
\newcommand{\mathboxplus}[1]{
	\setlength{\abovedisplayskip}{2pt}
	\setlength{\belowdisplayskip}{2pt}
	\begin{empheq}
	[box=\fcolorbox{color1}{color3!75}]
	{align*}
	#1
	\end{empheq}
}

%-----------------------------------------------------------------
% CUSTOM TCOLORBOX ENVIRONMENTS
%-----------------------------------------------------------------
\iftoggle{tcolorbox}{
    \RequirePackage{tcolorbox} % for rounded boxes
    \tcbuselibrary{skins, breakable}

    \newtcolorbox{yellowbox}[1]{
        colback=color3!75,
        colframe=color1,
        left=0pt, 
        bottom=0pt, 
        right=0pt, 
        top=2pt, 
        title=#1,
        subtitle style={colback=color1, colframe=color1},
    }

    \newtcolorbox{bluebox}[1]{
        colback=color2!50, 
        colframe=color1,
        left=0pt, 
        bottom=0pt, 
        right=0pt, 
        top=2pt, 
        title=#1,
        subtitle style={colback=color1, colframe=color1},
    }

    \newtcolorbox{whitebox}[1]{
        colback=white, 
        colframe=color1,
        left=0pt, 
        bottom=0pt, 
        right=0pt, 
        top=2pt, 
        title=#1,
        subtitle style={colback=color1, colframe=color1},
        before upper={\setlength{\abovedisplayskip}{2pt} 
        \setlength{\belowdisplayskip}{2pt}},
        before skip balanced=0pt, 
        after skip balanced=2pt,
    }

    % Intended to highlight mixed math/text such as theorems
    \newtcolorbox{highlightbox}[1]{
        colback=color3!75, 
        colframe=color1, 
        left=0pt, 
        bottom=0pt, 
        right=0pt, 
        top=0pt, 
        title=#1,
        subtitle style={colback=color1, colframe=color1},
        before upper={\setlength{\abovedisplayskip}{2pt} 
        \setlength{\belowdisplayskip}{2pt}},
        before skip balanced=0pt, 
        after skip balanced=2pt,
    }
}{}



%-----------------------------------------------------------------
% HATCHING
%-----------------------------------------------------------------
% individual parallelogram
\newcommand{\single}[1]{
	\fill[black]
	([xshift=#1*2*\hatchscale*0.5cm,yshift = 0.1cm]current page text area.north west) --
	([xshift=#1*2*\hatchscale*0.5cm+\hatchscale*2cm,yshift=\hatchscale*2cm+0.1cm]current page text area.north west) --
	([xshift=#1*2*\hatchscale*0.5cm+\hatchscale*2.5cm,yshift=\hatchscale*2cm+0.1cm]current page text area.north west) --
	([xshift=#1*2*\hatchscale*0.5cm+\hatchscale*0.5cm,yshift=0.1cm]current page text area.north west) --
	cycle;
}
% while loop to make many parallelograms
\newcommand\Hatch{
	\begin{tikzpicture}[remember picture,overlay]
	\newcount\foo
	\foo=-3
	\loop
	\single{\the\foo}
	\advance \foo +1
	\ifnum \foo<30
	\repeat
	\end{tikzpicture}
}

% apply hatching to all pages
\iftoggle{hatch}{
    \AtBeginShipout{\AtBeginShipoutAddToBox{\Hatch}}
}{}