# aastex_pwned
AASTex.cls and aasjournal.bst files for __maximum similarity__ with published version and __citations__.

## How to use:
Download ```aastex63.cls``` (or ```aastex62.cls```), ```aasjournal.bst```, and ```orcid.png``` from https://github.com/seawander/aastex_pwned.

Check the https://github.com/seawander/aastex_pwned/blob/master/ms.pdf file for a simple example. https://arxiv.org/abs/2012.05242 is a fully working example.

Add the following commands between `\usepackage` and `\begin{document}` in your `.tex` file to highlight only year in the main text.
```
%%%%%%The command BELOW link only the year (not the author name)
\makeatletter
% Patch case where name and year are separated by aysep
\patchcmd{\NAT@citex}
  {\@citea\NAT@hyper@{%
     \NAT@nmfmt{\NAT@nm}%
     \hyper@natlinkbreak{\NAT@aysep\NAT@spacechar}{\@citeb\@extra@b@citeb}%
     \NAT@date}}
  {\@citea\NAT@nmfmt{\NAT@nm}%
   \NAT@aysep\NAT@spacechar\NAT@hyper@{\NAT@date}}{}{}

% Patch case where name and year are separated by opening bracket
\patchcmd{\NAT@citex}
  {\@citea\NAT@hyper@{%
     \NAT@nmfmt{\NAT@nm}%
     \hyper@natlinkbreak{\NAT@spacechar\NAT@@open\if*#1*\else#1\NAT@spacechar\fi}%
       {\@citeb\@extra@b@citeb}%
     \NAT@date}}
  {\@citea\NAT@nmfmt{\NAT@nm}%
   \NAT@spacechar\NAT@@open\if*#1*\else#1\NAT@spacechar\fi\NAT@hyper@{\NAT@date}}
  {}{}
\makeatother
%%%%%%The command ABOVE link only the year (not the author name)
```

### Notes:
1. Modified from https://journals.aas.org/aastexguide/.
2. Don't forget the ```orcid.png``` file, otherwise you won't get the awesome ORCID symbol.
3. You are welcome to modify based on your needs!
