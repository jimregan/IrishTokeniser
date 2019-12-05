/*
 * Copyright © 2016 Trinity College, Dublin
 * Irish Speech and Language Technology Research Centre
 * Cóipcheart © 2016 Coláiste na Tríonóide, Baile Átha Cliath
 * An tIonad taighde do Theicneolaíocht Urlabhra agus Teangeolaíochta na Gaeilge
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

%option noyywrap
 
%{
#include <stdio.h>

static int exclude_xml = 1;
static int exclude_childes = 1;
char sep = '\n';

char* replace_spaces(char* s);
%}
 
ABBR1	(Co\.|gCo\.|Dr\.|eag\.|e\.g\.|i\.e\.|lch\.)
ABBR2	(lgh\.|Ms\.|m\.sh\.|Mrs\.|Mr\.|O{APOS}|R\.Ch\.)
ABBR3	(srl\.|St\.|Uas\.|uimh\.|Uimh\.|Teo\.)
ABBR4	(\[\?\]|Ph\.D|Msc\.|\.i\.)
ABBR	({ABBR1}|{ABBR2}|{ABBR3}|{ABBR4})
XMLEnt	(&quot;|&gt;|&lt;|&apos;)

RealSpace	[ ]
NoBreakSpace	\xc2\xa0
Space	({RealSpace}|{NoBreakSpace})
WS	([ \t\n]|{Space})
WORD	({Letter}+)

Char	[^"\.,;:!?()\[\]{}'`#&<>/ \t\n]
SINGLE = ({SingleCharE}|{SingleCharM})
SYMBOL = ({SINGLE}|{PUNCT})
Digit	[0-9]
NumOp	([-=+*/:]|\xC3\xB7)
PUNCT	(...|``|\'\'|,,|-|\xE2\x80\xA6|\xE2\x80\x9C|\xE2\x80\x9D|\xE2\x80\x98)
XMLQUOTE	["']

SingleCharEBase	([",;:!?()[\]{}'`#&<>/]|\.)
SingleCharE	({SingleCharEBase}|\xE2\x82\xAC|\xC2\xAE|\xC2\xA1|\xC2\xBF|\xC2\xA3)
SingleCharM1	(\xc2\xb0|\xcb\x9a|\xc2\xba|\xc2\xb7|\xc2\xae|\xe2\x87\x92)
SingleCharM2	(\xe2\x88\x9a|\xc2\xb1|\xe2\x88\x9d|\xce\xb1|\xe2\x84\xa6)
SingleCharM3	(\xce\xa9|\xcf\x81|\xce\xa1|\xe2\x80\xa2|\xc2\xb5|\xcf\x80)
SingleCharM4	(\xe2\x88\x8f|\xce\xa0|\xe3\x85\xa0|\xce\x94|\xe2\x88\x86)
SingleCharM5	(\xc2\xa9|\xe2\x80\xa6|\xe2\x99\xa0|\xe2\x99\xa5|\xe2\x99\xa6)
SingleCharM6	(\xe2\x99\xa3|\xe2\x99\x95|\xe2\x99\x9b|\xe2\x99\x94)
SingleCharM7	(\xe2\x99\x96|\xe2\x99\x9c|\xe2\x84\x95|\xe2\x80\xa0)
SingleCharM8	(\xe2\x91\xa0|\xe2\x91\xa1|\xe2\x91\xa2|\xe2\x91\xa3)
SingleCharM9	(\xe2\x91\xa4|\xe2\x91\xa5|\xe2\x91\xa6|\xe2\x91\xa7)
SingleCharM10	(\xe2\x91\xa8|\xe2\x91\xa9|\xe2\x91\xaa|\xe2\x91\xab)
SingleCharM11	(\xe2\x91\xac|\xe2\x91\xad|\xe2\x91\xae|\xe2\x91\xaf)
SingleCharM12	(\xe2\x91\xb0|\xe2\x91\xb1|\xe2\x91\xb2|\xe2\x91\xb3)
SingleCharM13	(\xe2\x86\x92|\xe2\x86\x91|\xe2\x86\x93|\xce\x93|\xcf\x91)
SingleCharM14	(\xce\x9b|\xce\x9e|\xce\xb8|\xce\xa3|\xce\xa6|\xce\xa8)
SingleCharM15	(\xce\xa9|\xc3\xb8|\xe2\x88\x9e|\xe2\x88\x82|\xe2\x88\xa7)
SingleCharM16	(\xe2\x88\x80|\xe2\x88\x91|\xce\xb2|\xce\xb3|\xce\xb4)
SingleCharM17	(\xce\x95|\xce\xb5|\xce\x92|\xce\x91|\xce\x96|\xce\xb6)
SingleCharM18	(\xce\x97|\xce\xb7|\xce\x98|\xce\x99|\xce\xb9|\xce\x9a)
SingleCharM19	(\xce\xba|\xce\xbb|\xce\x9c|\xce\x9d|\xce\xbd|\xce\xbe)
SingleCharM20	(\xce\x9f|\xce\xbf|\xcf\x83|\xcf\x82|\xce\xa4|\xcf\x84)
SingleCharM21	(\xce\xa5|\xcf\x85|\xce\xa6|\xcf\x86|\xce\xa7|\xcf\x87)
SingleCharM22	(\xce\xa8|\xcf\x88|\xce\xa9|\xcf\x89|\xce\xbc|\xe2\x88\xb4)
SingleCharM23	(\xc2\xbd|\xc2\xbc|\xc2\xbe|\xe2\x85\x94|\xe2\x85\x93)
SingleCharM24	(\xc2\xaf|\xc2\xb3|\xc2\xb2|\xc2\xb9|\xe2\x89\x88|\xe2\x86\x94)
SingleCharM25	(\xe2\x9e\x9e|\xe2\x87\x94|\xe2\x96\xb6|\xe2\x97\x80)
SingleCharM26	(\xe2\x96\xbc|\xe2\x9c\x94|\xe2\x9c\x98|\xe2\x9e\xa1)
SingleCharM27	(\xe2\xac\x85|\xe2\xac\x86|\xe2\xac\x87|\xe2\x86\x97)
SingleCharM28	(\xe2\x86\x98|\xe2\x86\x99|\xe2\x86\x96|\xe2\x86\x95)
SingleCharM29	(\xe2\x86\x94|\xe2\x86\xaa|\xe2\x86\xa9|\xe2\xa4\xb4)
SingleCharM30	(\xe2\xa4\xb5|\x7e|\xe2\x88\x95|\xe2\x80\xb0|\xc2\xac)
SingleCharM31	(\xe2\x88\xaa|\xe2\x88\xa9|\xe2\x89\xa5|\xe2\x89\xa4)
SingleCharM32	(\xe2\x89\xa1|\xe2\x89\x88|\xe2\x89\xa0|\xc3\x97|\xe2\x88\xa0)
SingleCharMG1	({SingleCharM1}|{SingleCharM2}|{SingleCharM3}|{SingleCharM4})
SingleCharMG2	({SingleCharM6}|{SingleCharM7}|{SingleCharM8}|{SingleCharM9})
SingleCharMG3	({SingleCharM11}|{SingleCharM12}|{SingleCharM13})
SingleCharMG4	({SingleCharM15}|{SingleCharM16}|{SingleCharM17})
SingleCharMG5	({SingleCharM19}|{SingleCharM20}|{SingleCharM21})
SingleCharMG6	({SingleCharM23}|{SingleCharM24}|{SingleCharM25})
SingleCharMG7	({SingleCharM27}|{SingleCharM28}|{SingleCharM29})
SingleCharMG8	({SingleCharM31}|{SingleCharM32})
SingleCharMGG1	({SingleCharMG1}|{SingleCharMG2}|{SingleCharMG3}|{SingleCharMG4})
SingleCharMGG2	({SingleCharMG6}|{SingleCharMG7}|{SingleCharMG8})
SingleCharM	({SingleCharMGG1}|{SingleCharMGG2})

WEB	(http:\/\/|www\.)
AlphaNum	({Letter}|{Digit})
Email	({AlphaNum}+(\.{AlphaNum}+)?)+\@({AlphaNum}+\.)+{AlphaNum}+
URIWeb	{WEB}({AlphaNum}+\.)+{AlphaNum}+
WEBADDR	{Email}|{URIWeb}
Roman	[ivxlc]
URoman	[IVXLC]
NONSTD	^({Letter}|[-']|{Space})+^
MUTWORD	[tn][-]{Char}+


XMLPUNCT	["'/=_.?]
DIVTAG	(<div|<speaker_turn|<lb|<pb|<L)({Space}|{XMLPUNCT}|{Digit}|{Letter})+>

CHILDES	\*{LetterUC}{LetterUC}{LetterUC}:
Letter	({LetterLC}|{LetterUC})
LetterLC	({ListLC}|{FadaLC})
LetterUC	({ListUC}|{FadaUC})
ListLC	[a-z]
ListUC	[A-Z]
FadaUC	(\xC3\x81|\xC3\x89|\xC3\x8D|\xC3\x93|\xC3\x9A)
FadaLC	(\xC3\xA1|\xC3\xA9|\xC3\xAD|\xC3\xB3|\xC3\xBA)

HYPH	[-]
APOS	([']|\xE2\x80\x99|&apos;)

ENGWORD	{Letter}({Letter})+{APOS}[Ss]

AFADA	\xC3\x81|\xC3\xA1
EFADA	\xC3\x89|\xC3\xA9
IFADA	\xC3\x8D|\xC3\xAD
OFADA	\xC3\x93|\xC3\xB3
UFADA	\xC3\x9A|\xC3\xBA
NOTYPO	{Space}[Aa][Tt]{AFADA}([Ii][Mm][Ii][Dd][Nn][Ee]|[Ii][Mm][Ii][Dd]|[Ii][Mm][Ss][Ee]|[Ii][Mm]|[Tt][Hh][Aa][Rr]|{Space}[Tt]{UFADA}|{Space}[Ss][Ii][Aa][Dd])?

CONT1	([Mm][Bb]{APOS}|[Bb]{APOS}|[Dd]{APOS}|[Dd][Hh]{APOS}|[Mm]{APOS})
CONT2	([Aa][Nn][Aa]{HYPH}|[Aa][Nn]{HYPH}|[Aa]{Space}[Dd][Hh]{APOS})
CONT3	([Aa]{APOS}[Mm]|[Aa]{APOS}[Aa][Tt]|[Dd][Oo][Dd]{APOS}|[Ll][Ee][Mm]{APOS})
CONT4	([Ss]{APOS}|{APOS}[Nn][Aa]{Space}|{APOS}[Nn]{Space})
CONT5	([Aa][Rr][Ss]{APOS}|[Aa]{APOS}[Ss]|[Aa]{APOS}|[Nn]{APOS})
CONT	({CONT1}|{CONT2}|{CONT3}|{CONT4}|{CONT5})

MWEENG1	([Dd]{APOS})?[Yy][Oo][Uu]{Space}[Kk][Nn][Oo][Ww]({Space}[Ww][Hh][Aa][Tt]{Space}[Ii]{Space}[Mm][Ee][Aa][Nn])?
MWEENG2	[Ii]{Space}[Mm][Ee][Aa][Nn]
MWEENG3	[Ii]{Space}[Ss][Uu][Pp][Pp][Oo][Ss][Ee]
MWEENG4	[Ff][Aa][Ii][Rr]{Space}[Pp][Ll][Aa][Yy]
MWEENG5 [Nn][Oo]{Space}[Ww][Aa][Yy]
MWEENG6	[Ss][Oo][Rr][Tt]{Space}[Oo][Ff]
MWEENG	{MWEENG1}|{MWEENG2}|{MWEENG3}|{MWEENG4}|{MWEENG5}|{MWEENG6}

MWE1	([Mm][Aa][Rr]{Space}[Aa]{Space}[Dd]{EFADA}[Aa][Rr][Ff]{AFADA})
MWE2	([Aa][Rr]{Space}[Aa][Ii][Ss])
MWE3	([Aa][Rr]{Space}[Ff][Ee][Aa][Dd][Hh])
MWE4	([Aa][Rr]{Space}[Ff][Uu][Dd])
MWE5	([Aa][Rr]{Space}[Ll][Oo][Rr][Gg])
MWE6	([Aa][Rr]{Space}[Nn]{OFADA}[Ss])
MWE7	([Aa][Rr]{Space}[Ss][Oo][Nn])
MWE8	([Cc]{EFADA}({Space}[Ii])?[Ss]{Space}[Mm]([Oo]MWE{OFADA})[Ii][Tt][Ee])
MWE9	([Cc][Hh][Uu][Nn]{Space}[Gg][Oo])
MWE10	([Dd][Ee]{Space}[Bb][Hh][Aa][Rr])
MWE11	([Dd]{APOS}[Aa][Ii][Nn][Nn][Ee][Oo][Ii][Nn])
MWE12	([Dd]{AFADA}{Space}[Bb][Hh][Aa][Rr][Rr]{Space}[Ss][Ii][Nn])
MWE13	([Dd][Ee]{Space}[Bb][Hh][Aa][Rr][Rr])
MWE14	([Dd][Ee]{Space}[Cc][Hh][Oo][Ii][Ss])
MWE15	([Aa]{Space}[Ll]{AFADA}[Nn])
MWE16	([Aa]{Space}[Tt][Hh][Uu][Ii][Ll][Ll][Ee][Aa][Dd][Hh])
MWE17	([Dd][Ee]{Space}[Dd][Hh][Ee][Aa][Ss][Cc][Aa])
MWE18	([Dd][Ee]{Space}[Dd][Hh][Ee][Aa][Ss][Cc][Aa][Ii][Bb][Hh])
MWE19	([Dd][Ee]{Space}[Dd][Hh]{IFADA}[Oo][Bb][Hh]{AFADA}[Ii][Ll])
MWE20	([Dd][Ee]{Space}[Ll]{AFADA}[Ii][Mm][Hh])
MWE21	([Dd][Ee]{Space}[Rr]{EFADA}[Ii][Rr])
MWE22	([Dd][Ee]{Space}[Tt][Hh][Aa][Ii][Rr][Bb][Hh][Ee])
MWE23	([Ff][Aa][Oo][Ii]{Space}[Bb][Hh][Rr]{AFADA}[Ii][Dd])
MWE24	([Ff][Aa][Oo][Ii]{Space}[Bb][Hh][Uu][Nn])
MWE25	([Ff][Aa][Oo][Ii]{Space}[Cc][Hh][Oo][Ii][Nn][Nn][Ee])
MWE26	([Ff][Aa][Oo][Ii]{Space}[Dd][Hh]{EFADA}[Ii][Nn])
MWE27	([Ff]{AFADA}{Space}[Cc][Hh][Oo][Ii][Nn][Nn][Ee])
MWE28	([Gg][Oo]{Space}[Cc][Ee][Aa][Nn][Nn])
MWE29	([Gg][Oo]{Space}[Dd][Tt]{IFADA})
MWE30	([Gg][Oo]{Space}[Ll][Ee][Oo][Rr])
MWE31	([Ii]{Space}[Bb][Hh][Ff][Ee][Ii][Gg][Hh][Ii][Ll])
MWE32	([Ii]{Space}[Bb][Hh][Ff][Oo][Cc][Hh][Aa][Ii][Rr])
MWE33	([Ii]{Space}[Dd][Tt][Ee][Aa][Nn][Nn][Tt][Aa])
MWE34	([Ii]{Space}[Dd][Tt][Rr]{AFADA}[Tt][Hh][Aa])
MWE35	([Ii]{Space}[Dd][Tt][Uu][Ii][Ll][Ll][Ee][Aa][Mm][Aa]{IFADA})
MWE36	([Ii]{Space}[Gg][Cc][Ee][Aa][Nn][Nn])
MWE37	([Ii]{Space}[Gg][Cc][Ii][Oo][Nn][Nn])
MWE38	([Ii]{Space}[Gg][Cc][Oo][Ii][Nn][Nn][Ee])
MWE39	([Ii]{Space}[Gg][Cc][Oo][Ss][Aa][Mm][Aa][Rr])
MWE40	([Ii]{Space}[Gg][Cc][Uu][Ii][Dd][Ee][Aa][Cc][Hh][Tt][Aa])
MWE41	([Ii]{Space}[Gg][Cc]{OFADA}[Ii][Rr])
MWE42	([Ii]{Space}[Ll]{AFADA}[Rr])
MWE43	([Ii]{Space}[Ll]{AFADA}[Tt][Hh][Aa][Ii][Rr])
MWE44	([Ii]{Space}[Mm][Bb][Uu][Nn])
MWE45	([Ii]{Space}[Nn][Dd][Ii][Aa][Ii][Dd][Hh])
MWE46	([Ii]{Space}[Rr][Ii][Tt][Hh])
MWE47	([Ii][Nn]{Space}[Aa][Gg][Hh][Aa][Ii][Dd][Hh])
MWE48	([Ii][Nn]{Space}[Aa][Ii][Cc][Ee])
MWE49	([Ii][Nn]{Space}[Aa][Ii][Rr][Ii][Cc][Ii][Ss])
MWE50	([Ii][Nn]{Space}[Aa][Nn][Nn])
MWE51	([Ii][Nn]{Space}{EFADA}[Aa][Dd][Aa][Nn])
MWE52	([Ll][Ee]{Space}[Cc][Oo][Ii][Ss])
MWE53	([Ll][Ee]{Space}[Gg][Aa][Ii][Rr][Ii][Dd])
MWE54	([Ll][Ee]{Space}[Gg][Oo])
MWE55	([Ll][Ee]{Space}[Hh][Aa][Ii][Ss])
MWE56	([Ll][Ee]{Space}[Ll][Ii][Nn][Nn])
MWE57	([Ll][Ee][Aa][Gg][Aa][Nn]{Space}[Aa][Mm][Aa][Cc][Hh])
MWE58	([Mm][Aa][Ii][Dd][Ii][Rr]{Space}[Ll][Ee])
MWE59	([Mm][Aa][Ii][Dd][Ii][Rr]{Space}[Ll][Ee][Aa][Tt])
MWE60	([Mm][Aa][Ii][Dd][Ii][Rr]{Space}[Ll][Ee][Aa][Tt][Ss][Aa])
MWE61	([Mm][Aa][Ii][Dd][Ii][Rr]{Space}[Ll][Ee][Ii][Ss])
MWE62	([Mm][Aa][Ii][Dd][Ii][Rr]{Space}[Ll][Ee][Nn][Aa])
MWE63	([Mm][Aa][Ii][Dd][Ii][Rr]{Space}[Ll][Ee][Nn][Aa][Rr])
MWE64	([Mm][Aa][Ii][Dd][Ii][Rr]{Space}[Ll][Ee][Nn]{AFADA}[Rr])
MWE65	([Mm][Aa][Ii][Dd][Ii][Rr]{Space}[Ll][Ee][Oo])
MWE66	([Mm][Aa][Ii][Dd][Ii][Rr]{Space}[Ll][Ee][Oo][Ss][Aa][Nn])
MWE67	([Mm][Aa][Ii][Dd][Ii][Rr]{Space}[Ll][Ii][Bb][Hh])
MWE68	([Mm][Aa][Ii][Dd][Ii][Rr]{Space}[Ll][Ii][Bb][Hh][Ss][Ee])
MWE69	([Mm][Aa][Ii][Dd][Ii][Rr]{Space}[Ll][Ii][Nn][Nn])
MWE70	([Mm][Aa][Ii][Dd][Ii][Rr]{Space}[Ll][Ii][Nn][Nn][Ee])
MWE71	([Mm][Aa][Ii][Dd][Ii][Rr]{Space}[Ll][Ii][Oo][Mm])
MWE72	([Mm][Aa][Ii][Dd][Ii][Rr]{Space}[Ll][Ii][Oo][Mm][Ss][Aa])
MWE73	([Mm][Aa][Ii][Dd][Ii][Rr]{Space}[Ll]{EFADA}[Ii])
MWE74	([Nn]{IFADA}{Space}[Bb][Aa])
MWE75	([Nn]{IFADA}{Space}[Bb]{APOS})
MWE76	([Oo][Ss]{Space}[Cc][Ii][Oo][Nn][Nn])
MWE77	([Oo][Ss]{Space}[Cc][Oo][Ii][Nn][Nn][Ee])
MWE78	([Oo][Ss]{Space}[Cc][Oo][Mm][Hh][Aa][Ii][Rr])
MWE79	([Tt][Aa][Oo][Bb][Hh]{Space}[Aa][Mm][Uu][Ii][Gg][Hh])
MWE80	([Tt][Aa][Oo][Bb][Hh]{Space}[Ii][Ss][Tt][Ii][Gg][Hh])
MWE81	([Tt][Aa][Rr]{Space}{EFADA}[Ii][Ss])
MWE82	([Tt][Hh][Aa][Rr]{Space}[Aa]{Space}[Bb][Hh][Ee][Ii][Tt][Hh])
MWE83	([Tt][Hh][Aa][Rr]{Space}[Cc][Ee][Aa][Nn][Nn])
MWE84	({OFADA}{Space}[Dd][Hh][Ee][Aa][Ss])
MWE85	({OFADA}{Space}[Tt][Hh][Uu][Aa][Ii][Dd][Hh])
MWEX0	({MWE1}|{MWE2}|{MWE3}|{MWE4}|{MWE5}|{MWE6}|{MWE7}|{MWE8}|{MWE9})
MWEX1	({MWE10}|{MWE11}|{MWE12}|{MWE13}|{MWE14}|{MWE15}|{MWE16}|{MWE17}|{MWE18}|{MWE19})
MWEX2	({MWE20}|{MWE21}|{MWE22}|{MWE23}|{MWE24}|{MWE25}|{MWE26}|{MWE27}|{MWE28}|{MWE29})
MWEX3	({MWE30}|{MWE31}|{MWE32}|{MWE33}|{MWE34}|{MWE35}|{MWE36}|{MWE37}|{MWE38}|{MWE39})
MWEX4	({MWE40}|{MWE41}|{MWE42}|{MWE43}|{MWE44}|{MWE45}|{MWE46}|{MWE47}|{MWE48}|{MWE49})
MWEX5	({MWE50}|{MWE51}|{MWE52}|{MWE53}|{MWE54}|{MWE55}|{MWE56}|{MWE57}|{MWE58}|{MWE59})
MWEX6	({MWE60}|{MWE61}|{MWE62}|{MWE63}|{MWE64}|{MWE65}|{MWE66}|{MWE67}|{MWE68}|{MWE69})
MWEX7	({MWE70}|{MWE71}|{MWE72}|{MWE73}|{MWE74}|{MWE75}|{MWE76}|{MWE77}|{MWE78}|{MWE79})
MWEX8	({MWE80}|{MWE81}|{MWE82}|{MWE83}|{MWE84}|{MWE85})
MWE	({MWEX0}|{MWEX1}|{MWEX2}|{MWEX3}|{MWEX4}|{MWEX5}|{MWEX6}|{MWEX7}|{MWEX8})

PTAG1	(<p>|<\/p>|<s>|<\/s>|<title>|<\/title>|<caption>|<\/caption>)
PTAG2	(<head>|<\/head>|<\/hi>|<hi{Space}rend={XMLQUOTE}(bo|it){XMLQUOTE}>)
PTAG3	(<gap\/>|<gap>|<\/gap>|<span>|<\/span>|<text>|<\/text>)
PTAG4	(<foreign>|<\/foreign>|<div>|<\/div>|<poem>|<\/poem>|<body>|<\/body>)
PTAG5	(<div1>|<\/div1>)
GAPSTART	<gap{Space}desc\={XMLQUOTE}
GAP1	(Old{Space}Irish|english{Space}text|german{Space}text|german)
GAP2	(english|french|spanish|welsh|latin|bibl|glossary|note|table|contact_info)
PTAG6	{GAPSTART}({GAP1}|{GAP2})\/>
PTAG7	<foreign{Space}lang\={XMLQUOTE}(en|fr|la){XMLQUOTE}>
PTAG8	(<lb>|<\/lb>|<l>|<\/l>|<lg>|<\/lg>|<\/speaker_turn>)
PTAG	({PTAG1}|{PTAG2}|{PTAG3}|{PTAG4}|{PTAG5}|{PTAG6}|{PTAG7}|{PTAG8})

%%

{APOS}	printf("'%c", sep);

\xC2\xA3	printf("£%c", sep);

{SingleCharM}	printf("%s%c", yytext, sep);

{SingleCharE}	printf("%s%c", yytext, sep);

{MUTWORD}	printf("%s%c", yytext, sep);

{Email}	printf("%s%c", yytext, sep);

{ABBR}	printf("%s%c", yytext, sep);

{CONT}	printf("%s%c", yytext, sep);

{MWEENG}|{MWE}	{
	printf("%s%c", yytext, sep);
}

{ENGWORD}	printf("%s%c", yytext, sep);

{NOTYPO}	printf("%s%c", yytext, sep);

{CHILDES}	{
	if(!exclude_childes) {
		printf("%s%c", yytext, sep);
	}
}

{DIVTAG}|{PTAG}	{
	if(!exclude_xml) {
		printf("%s%c", yytext, sep);
	}
}

{NONSTD}	printf("%s%c", yytext, sep);

{WEBADDR}	printf("%s%c", yytext, sep);

{Char}+	printf("%s%c", yytext, sep);

{WS}+	;

.	printf("%s%c", yytext, sep);
		
%%

char* replace_spaces(char* s)
{
	char* out = (char *) malloc((strlen(s) + 1) * sizeof(char));
	char* ret = out;
	char tmp;
	if(out != NULL) {
		while(*s != '\0') {
			tmp = *s++;
			*out++ = (tmp == ' ') ? '_' : tmp;
		}
	}
	*out = '\0';
	return ret;
}

int main(int argc, char** argv)
{
	yyin = stdin;
	yylex();
	return 0;
}
