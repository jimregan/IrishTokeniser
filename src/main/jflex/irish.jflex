/*
 * Copyright 2016 Trinity College, Dublin
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
package ie.tcd.slscs.tokeniser.ga;

%%

%integer
%final
%public
%class IrishTokeniserImpl
%function getNextToken
%char

ABBR = ( "Co." |"gCo." |"Dr." |"eag." |"e.g." |"i.e." |"lch."
 | "lgh." | "Ms." | "m.sh." | "Mrs." | "Mr." | "O'" | "R.Ch."
 | "srl." | "St." | "Uas." | "uimh." | "Uimh." | "Teo."
 | "[?]"| "Ph.D" | "Msc." | ".i." )
XMLEnt = ( "&quot;" | "&gt;" | "&lt;" )

Space = " "
WORD = ({Letter}+)
//WORD = {Char}+
Char = !({WS} | {SINGLE})
SINGLE = ({SingleCharE} | {SingleCharM})
SYMBOL = ({SINGLE} | {PUNCT})
// Opening single quote only, because closing can be used for apostrophe
PUNCT = ( "..." | "``" | "''" | ",," | "-" | "…" | "“" | "”" | "‘")

Digit = [0-9];
NumOp = ( "-" | "=" | "+" | "*" | "/" | ":" | "÷" )
NumSep = ( "." | "," )
WS = ( " " | \t | \n )

// Split, because the highlighting breaks
SingleCharE = ( "\"" | "." | "," | ";" | ":" | "!" | "?" | "(" | ")"
 | "[" | "]" | "{" | "}" | "'" | "`" | "#" | "&" | "£" | \u20AC
 | "<" | ">" | "/" | \u00AE | \u00A1 | \u00BF )
SingleCharM = ( \u00B0 | \u02DA | \u00BA | \u00B7 | \u00AE
 | \u21D2 | \u221A | \u00B1 | \u221D | \u03B1 | \u2126 | \u03A9 | \u03C1 | \u03A1
 | \u2022 | \u00B5 | \u03C0 | \u220F | \u03A0 | \u3160 | \u0394 | \u2206 | \u00A9
 | \u2026 | \u2660 | \u2665 | \u2666 | \u2663 | \u2655 | \u265B | \u2654 | \u2656
 | \u265C | \u2115 | \u2020 | \u2460 | \u2461 | \u2462 | \u2463 | \u2464 | \u2465
 | \u2466 | \u2467 | \u2468 | \u2469 | \u246A | \u246B | \u246C | \u246D | \u246E
 | \u246F | \u2470 | \u2471 | \u2472 | \u2473 | \u2192 | \u2191 | \u2193 | \u0393
 | \u03D1 | \u039B | \u039E | \u03B8 | \u03A3 | \u03A6 | \u03A8 | \u03A9 | \u00F8
 | \u221E | \u2202 | \u2227 | \u2200 | \u2211 | \u03B2 | \u03B3 | \u03B4 | \u0395
 | \u03B5 | \u0392 | \u0391 | \u0396 | \u03B6 | \u0397 | \u03B7 | \u0398 | \u0399
 | \u03B9 | \u039A | \u03BA | \u03BB | \u039C | \u039D | \u03BD | \u03BE | \u039F
 | \u03BF | \u03C3 | \u03C2 | \u03A4 | \u03C4 | \u03A5 | \u03C5 | \u03A6 | \u03C6
 | \u03A7 | \u03C7 | \u03A8 | \u03C8 | \u03A9 | \u03C9 | \u03BC | \u2234 | \u00BD
 | \u00BC | \u00BE | \u2154 | \u2153 | \u00AF | \u00B3 | \u00B2 | \u00B9 | \u2248
 | \u2194 | \u279E | \u21D4 | \u25B6 | \u25C0 | \u25BC | \u2714 | \u2718 | \u27A1
 | \u2B05 | \u2B06 | \u2B07 | \u2197 | \u2198 | \u2199 | \u2196 | \u2195 | \u2194
 | \u21AA | \u21A9 | \u2934 | \u2935 | \u007E | \u2215 | \u2030 | \u00AC | \u222A
 | \u2229 | \u2265 | \u2264 | \u2261 | \u2248 | \u2260 | \u00D7 | \u2220 | \u00BB
 | \u00AB | \u0131 | \u0192 | \u2044 | \u04E8 )

CHILDES = "*" {LetterUC}{3} ":"
Letter = ( {LetterLC} | {LetterUC} )
LetterLC = ( {ListLC} | {FadaLC} )
LetterUC = ( {ListUC} | {FadaUC} )
ListLC = [a-z]
ListUC = [A-Z]
FadaUC = ( \u00C1 | \u00C9 | \u00CD | \u00D3 | \u00DA )
FadaLC = ( \u00E1 | \u00E9 | \u00ED | \u00F3 | \u00FA )

CONT = ( "mb" {APOS} | "MB" {APOS} | "b" {APOS} | "B" {APOS} | "d" {APOS}
 | "D" {APOS} | "dh" {APOS} | "DH" {APOS} | "m" {APOS} | "M" {APOS}
 | "ana-" | "an-" | "a dh" {APOS} | "A dh" {APOS} | "a" {APOS} "m"
 | "a" {APOS} "at" | "dod" {APOS} | "lem" {APOS} | "s" {APOS} | "S" {APOS}
 | {APOS} "na" {Space} | {APOS} "n" {Space}
 | "ars" {APOS} | "a" {APOS} "s" | "a" {APOS}
 | "n" {APOS} | "N" {APOS} )

APOS = ( "'" | \u2019 )
PTAG = ( "<p>" | "</p>" | "<s>" | "</s>"
| "<title>" | "</title>"
| "<caption>" | "</caption>"
| "<head>" | "</head>"
| "</hi>" | "<hi rend=" {XMLQUOTE} "bo" {XMLQUOTE} ">"
| "<hi rend=" {XMLQUOTE} "it" {XMLQUOTE} ">"
| "<gap/>" | "<gap>" | "</gap>"
| "<gap desc=" {XMLQUOTE} "Old Irish" {XMLQUOTE} "/>"
| "<gap desc=" {XMLQUOTE} "english text" {XMLQUOTE} "/>"
| "<gap desc=" {XMLQUOTE} "german text" {XMLQUOTE} "/>"
| "<gap desc=" {XMLQUOTE} "german" {XMLQUOTE} "/>"
| "<gap desc=" {XMLQUOTE} "english" {XMLQUOTE} "/>"
| "<gap desc=" {XMLQUOTE} "french" {XMLQUOTE} "/>"
| "<gap desc=" {XMLQUOTE} "spanish" {XMLQUOTE} "/>"
| "<gap desc=" {XMLQUOTE} "welsh" {XMLQUOTE} "/>"
| "<gap desc=" {XMLQUOTE} "latin" {XMLQUOTE} "/>"
| "<gap desc=" {XMLQUOTE} "bibl" {XMLQUOTE} "/>"
| "<gap desc=" {XMLQUOTE} "glossary" {XMLQUOTE} "/>"
| "<gap desc=" {XMLQUOTE} "note" {XMLQUOTE} "/>"
| "<gap desc=" {XMLQUOTE} "table" {XMLQUOTE} "/>"
| "<gap desc=" {XMLQUOTE} "contact_info" {XMLQUOTE} "/>"
| "<foreign lang=" {XMLQUOTE} "en" {XMLQUOTE} ">"
| "<foreign lang=" {XMLQUOTE} "fr" {XMLQUOTE} ">"
| "<foreign lang=" {XMLQUOTE} "la" {XMLQUOTE} ">"
| "</foreign>"
| "<div>"
| "</div>"
| "<poem>" | "</poem>"
| "<span>" | "</span>"
| "<text>" | "</text>"
| "<body>" | "</body>"
| "<lb>" | "</lb>"
| "<l>" | "</l>"
| "<lg>" | "</lg>"
| "</speaker_turn>" )
XMLQUOTE = ("\"" | "'")

WEB = ( "http://" | "www")
AlphaNum = ( {Letter} | {Digit} )
WEBADDR = ( ( {AlphaNum}+ ("." {AlphaNum}+) )+ "@" ( {AlphaNum}+ "." ) {AlphaNum}+ )
          | ( {WEB} ( {AlphaNum}+ "." )+ {AlphaNum}+ )

// Why no M?
Roman = ( "i" | "v" | "x" | "l" | "c" )
URoman = ( "I" | "V" | "X" | "L" | "C" )

NONSTD = "^" ( {Letter} | "'" | "-" | {Space} )+ "^"

MUTWORD = ( "t" | "n") "-" {Char}+

ENGWORD = {Letter} {Letter}+ "'s"

XMLPUNCT = ( "\"" | "'" | "/" | "=" | "_" | "." | "?" )

NOTYPO = {Space} "at" \u00E1 ( "imidne" | "imid" | "imse" | "im" | "thar" | " t" \u00FA | " siad" )+

DIVTAG = ( "<div" | "<speaker_turn" | "<lb" | "<pb" | "<L" ) ( {Space} | {XMLPUNCT} | {Digit} | {Letter} )+ ">"

%{

    public final int yychar() {
        return yychar;
    }

    public final String getText() {
        return new String(zzBuffer, zzStartRead, zzMarkedPos - zzStartRead);
    }
%}

%%

<<EOF>> { return -1; }
{NOTYPO} { return 13 ; }
{SYMBOL} { return 5; }
{Space} { return 4; }
{CONT} { return 3; }
{CHILDES} { return 1; }
{ABBR} { return 2; }
{PTAG} { return 7; }
{WORD} { return 0; }
{WEBADDR} { return 8; }
{DIVTAG} { return 9 ; }
{ENGWORD} { return 10 ; }
{MUTWORD} { return 11 ; }
{NONSTD} { return 12 ; }
