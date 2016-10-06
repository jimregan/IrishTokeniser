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
XMLEnt = ( "&quot;" | "&gt;" | "&lt;" | "&apos;" )

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

HYPH = ( "-" )

CONT = ( [Mm][Bb] {APOS} | [Bb] {APOS} | [Dd] {APOS}
 | [Dd][Hh] {APOS} | [Mm] {APOS} | [Aa][Nn][Aa]{HYPH}
 | [Aa][Nn]{HYPH} | [Aa] {Space} [Dd][Hh] {APOS} | [Aa] {APOS} [Mm]
 | [Aa] {APOS} [Aa][Tt] | [Dd][Oo][Dd] {APOS} | [Ll][Ee][Mm] {APOS}
 | [Ss] {APOS} | {APOS} [Nn][Aa] {Space} | {APOS} [Nn] {Space}
 | [Aa][Rr][Ss] {APOS} | [Aa] {APOS} [Ss] | [Aa] {APOS}
 | [Nn] {APOS} )

APOS = ( "'" | \u2019 | "&apos;" )
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

ENGWORD = {Letter} {Letter}+ {APOS}[Ss]

XMLPUNCT = ( "\"" | "'" | "/" | "=" | "_" | "." | "?" )

NOTYPO = {Space} [Aa][Tt]{AFADA} ( [Ii][Mm][Ii][Dd][Nn][Ee] | [Ii][Mm][Ii][Dd] | [Ii][Mm][Ss][Ee] | [Ii][Mm] | [Tt][Hh][Aa][Rr] | {Space} [Tt]{UFADA} | {Space} [Ss][Ii][Aa][Dd] )?

DIVTAG = ( "<div" | "<speaker_turn" | "<lb" | "<pb" | "<L" ) ( {Space} | {XMLPUNCT} | {Digit} | {Letter} )+ ">"

AFADA = (\u00C1 | \u00E1)
EFADA = (\u00C9 | \u00E9)
IFADA = (\u00CD | \u00ED)
OFADA = (\u00D3 | \u00F3)
UFADA = (\u00DA | \u00FA)

MWE = ( ([Mm][Aa][Rr] {Space} [Aa] {Space} [Dd]{EFADA}[Aa][Rr][Ff]{AFADA})
| ([Aa][Rr] {Space} [Aa][Ii][Ss])
| ([Aa][Rr] {Space} [Ff][Ee][Aa][Dd][Hh])
| ([Aa][Rr] {Space} [Ff][Uu][Dd])
| ([Aa][Rr] {Space} [Ll][Oo][Rr][Gg])
| ([Aa][Rr] {Space} [Nn]{OFADA}[Ss])
| ([Aa][Rr] {Space} [Ss][Oo][Nn])
| ( [Cc]{EFADA}({Space} [Ii])?[Ss] {Space} [Mm]([Oo] | {OFADA})[Ii][Tt][Ee] )
| ( [Cc][Hh][Uu][Nn] {Space} [Gg][Oo] )
| ([Dd][Ee] {Space} [Bb][Hh][Aa][Rr])
| ([Dd] {APOS} [Aa][Ii][Nn][Nn][Ee][Oo][Ii][Nn])
| ([Dd]{AFADA} {Space} [Bb][Hh][Aa][Rr][Rr] {Space} [Ss][Ii][Nn])
| ([Dd][Ee] {Space} [Bb][Hh][Aa][Rr][Rr])
| ([Dd][Ee] {Space} [Cc][Hh][Oo][Ii][Ss])
| ( [Aa] {Space} [Ll]{AFADA}[Nn] )
| ( [Aa] {Space} [Tt][Hh][Uu][Ii][Ll][Ll][Ee][Aa][Dd][Hh] )
| ( [Dd][Ee] {Space} [Dd][Hh][Ee][Aa][Ss][Cc][Aa] )
| ( [Dd][Ee] {Space} [Dd][Hh][Ee][Aa][Ss][Cc][Aa][Ii][Bb][Hh] )
| ( [Dd][Ee] {Space} [Dd][Hh]{IFADA}[Oo][Bb][Hh]{AFADA}[Ii][Ll] )
| ( [Dd][Ee] {Space} [Ll]{AFADA}[Ii][Mm][Hh] )
| ( [Dd][Ee] {Space} [Rr]{EFADA}[Ii][Rr] )
| ( [Dd][Ee] {Space} [Tt][Hh][Aa][Ii][Rr][Bb][Hh][Ee] )
| ( [Ff][Aa][Oo][Ii] {Space} [Bb][Hh][Rr]{AFADA}[Ii][Dd] )
| ( [Ff][Aa][Oo][Ii] {Space} [Bb][Hh][Uu][Nn] )
| ( [Ff][Aa][Oo][Ii] {Space} [Cc][Hh][Oo][Ii][Nn][Nn][Ee] )
| ( [Ff][Aa][Oo][Ii] {Space} [Dd][Hh]{EFADA}[Ii][Nn] )
| ( [Ff]{AFADA} {Space} [Cc][Hh][Oo][Ii][Nn][Nn][Ee] )
| ( [Gg][Oo] {Space} [Cc][Ee][Aa][Nn][Nn] )
| ( [Gg][Oo] {Space} [Dd][Tt]{IFADA} )
| ( [Gg][Oo] {Space} [Ll][Ee][Oo][Rr] )
| ( [Ii] {Space} [Bb][Hh][Ff][Ee][Ii][Gg][Hh][Ii][Ll] )
| ( [Ii] {Space} [Bb][Hh][Ff][Oo][Cc][Hh][Aa][Ii][Rr] )
| ( [Ii] {Space} [Dd][Tt][Ee][Aa][Nn][Nn][Tt][Aa] )
| ( [Ii] {Space} [Dd][Tt][Rr]{AFADA}[Tt][Hh][Aa] )
| ( [Ii] {Space} [Dd][Tt][Uu][Ii][Ll][Ll][Ee][Aa][Mm][Aa]{IFADA} )
| ( [Ii] {Space} [Gg][Cc][Ee][Aa][Nn][Nn] )
| ( [Ii] {Space} [Gg][Cc][Ii][Oo][Nn][Nn] )
| ( [Ii] {Space} [Gg][Cc][Oo][Ii][Nn][Nn][Ee] )
| ( [Ii] {Space} [Gg][Cc][Oo][Ss][Aa][Mm][Aa][Rr] )
| ( [Ii] {Space} [Gg][Cc][Uu][Ii][Dd][Ee][Aa][Cc][Hh][Tt][Aa] )
| ( [Ii] {Space} [Gg][Cc]{OFADA}[Ii][Rr] )
| ( [Ii] {Space} [Ll]{AFADA}[Rr] )
| ( [Ii] {Space} [Ll]{AFADA}[Tt][Hh][Aa][Ii][Rr] )
| ( [Ii] {Space} [Mm][Bb][Uu][Nn] )
| ( [Ii] {Space} [Nn][Dd][Ii][Aa][Ii][Dd][Hh] )
| ( [Ii] {Space} [Rr][Ii][Tt][Hh] )
| ( [Ii][Nn] {Space} [Aa][Gg][Hh][Aa][Ii][Dd][Hh] )
| ( [Ii][Nn] {Space} [Aa][Ii][Cc][Ee] )
| ( [Ii][Nn] {Space} [Aa][Ii][Rr][Ii][Cc][Ii][Ss] )
| ( [Ii][Nn] {Space} [Aa][Nn][Nn] )
| ( [Ii][Nn] {Space} {EFADA}[Aa][Dd][Aa][Nn] )
| ( [Ll][Ee] {Space} [Cc][Oo][Ii][Ss] )
| ( [Ll][Ee] {Space} [Gg][Aa][Ii][Rr][Ii][Dd] )
| ( [Ll][Ee] {Space} [Gg][Oo] )
| ( [Ll][Ee] {Space} [Hh][Aa][Ii][Ss] )
| ( [Ll][Ee] {Space} [Ll][Ii][Nn][Nn] )
| ( [Ll][Ee][Aa][Gg][Aa][Nn] {Space} [Aa][Mm][Aa][Cc][Hh] )
| ( [Mm][Aa][Ii][Dd][Ii][Rr] {Space} [Ll][Ee] )
| ( [Mm][Aa][Ii][Dd][Ii][Rr] {Space} [Ll][Ee][Aa][Tt] )
| ( [Mm][Aa][Ii][Dd][Ii][Rr] {Space} [Ll][Ee][Aa][Tt][Ss][Aa] )
| ( [Mm][Aa][Ii][Dd][Ii][Rr] {Space} [Ll][Ee][Ii][Ss] )
| ( [Mm][Aa][Ii][Dd][Ii][Rr] {Space} [Ll][Ee][Nn][Aa] )
| ( [Mm][Aa][Ii][Dd][Ii][Rr] {Space} [Ll][Ee][Nn][Aa][Rr] )
| ( [Mm][Aa][Ii][Dd][Ii][Rr] {Space} [Ll][Ee][Nn]{AFADA}[Rr] )
| ( [Mm][Aa][Ii][Dd][Ii][Rr] {Space} [Ll][Ee][Oo] )
| ( [Mm][Aa][Ii][Dd][Ii][Rr] {Space} [Ll][Ee][Oo][Ss][Aa][Nn] )
| ( [Mm][Aa][Ii][Dd][Ii][Rr] {Space} [Ll][Ii][Bb][Hh] )
| ( [Mm][Aa][Ii][Dd][Ii][Rr] {Space} [Ll][Ii][Bb][Hh][Ss][Ee] )
| ( [Mm][Aa][Ii][Dd][Ii][Rr] {Space} [Ll][Ii][Nn][Nn] )
| ( [Mm][Aa][Ii][Dd][Ii][Rr] {Space} [Ll][Ii][Nn][Nn][Ee] )
| ( [Mm][Aa][Ii][Dd][Ii][Rr] {Space} [Ll][Ii][Oo][Mm] )
| ( [Mm][Aa][Ii][Dd][Ii][Rr] {Space} [Ll][Ii][Oo][Mm][Ss][Aa] )
| ( [Mm][Aa][Ii][Dd][Ii][Rr] {Space} [Ll]{EFADA}[Ii] )
| ( [Nn]{IFADA} {Space} [Bb][Aa] )
| ( [Nn]{IFADA} {Space} [Bb]{APOS} )
| ( [Oo][Ss] {Space} [Cc][Ii][Oo][Nn][Nn] )
| ( [Oo][Ss] {Space} [Cc][Oo][Ii][Nn][Nn][Ee] )
| ( [Oo][Ss] {Space} [Cc][Oo][Mm][Hh][Aa][Ii][Rr] )
| ( [Tt][Aa][Oo][Bb][Hh] {Space} [Aa][Mm][Uu][Ii][Gg][Hh] )
| ( [Tt][Aa][Oo][Bb][Hh] {Space} [Ii][Ss][Tt][Ii][Gg][Hh] )
| ( [Tt][Aa][Rr] {Space} {EFADA}[Ii][Ss] )
| ( [Tt][Hh][Aa][Rr] {Space} [Aa] {Space} [Bb][Hh][Ee][Ii][Tt][Hh] )
| ( [Tt][Hh][Aa][Rr] {Space} [Cc][Ee][Aa][Nn][Nn] )
| ( {OFADA} {Space} [Dd][Hh][Ee][Aa][Ss] )
| ( {OFADA} {Space} [Tt][Hh][Uu][Aa][Ii][Dd][Hh] ) )

MWEENG = ( ([Yy][Oo][Uu] {Space} [Kk][Nn][Oo][Ww] {Space} [Ww][Hh][Aa][Tt] {Space} [Ii] {Space} [Mm][Ee][Aa][Nn])
| ([Yy][Oo][Uu] {Space} [Kk][Nn][Oo][Ww])
| ([Dd] {APOS} [Yy][Oo][Uu] {Space} [Kk][Nn][Oo][Ww])
| ([Ii] {Space} [Mm][Ee][Aa][Nn])
| ([Ii] {Space} [Ss][Uu][Pp][Pp][Oo][Ss][Ee])
| ([Ff][Aa][Ii][Rr] {Space} [Pp][Ll][Aa][Yy])
| ([Nn][Oo] {Space} [Ww][Aa][Yy])
| ([Ss][Oo][Rr][Tt] {Space} [Oo][Ff]) )

NotPron = ( [A-Z] | [a-z] | {AFADA} | {OFADA} | {UFADA} )
InitLetter = ( [A-Z] | [a-z] | {AFADA} | {EFADA} | {IFADA} | {OFADA} | {UFADA} )

INIT = ( {InitLetter} "." ({InitLetter} ".") | ({NotPron} ".") )
NUM = ( "IRP"? ( {Digit} | {NumOp} | {NumSep} )+ {Digit} "%" | "#" {Digit}+ )
//ITEM = ( !({NumOp}|{Letter}|{Digit}|{SINGLE}|"(") ( {Letter}| {Digit}+ | {Roman}+ | {URoman}+ ) ")" )
ITEM = ( ( {Letter}| {Digit}+ | {Roman}+ | {URoman}+ ) ")" )

%{

    public static final int TOKEN_WORD = 0;
    public static final int TOKEN_CHILDES = 1;
    public static final int TOKEN_ABBR = 2;
    public static final int TOKEN_CONT = 3;
    public static final int TOKEN_SPACE = 4;
    public static final int TOKEN_SYMBOL = 5;
    public static final int TOKEN_XMLENT = 6;
    public static final int TOKEN_PTAG = 7;
    public static final int TOKEN_WEBADDR = 8;
    public static final int TOKEN_DIVTAG = 9;
    public static final int TOKEN_ENGWORD = 10;
    public static final int TOKEN_MUTWORD = 11;
    public static final int TOKEN_NONSTD = 12;
    public static final int TOKEN_NOTYPO = 13;
    public static final int TOKEN_MWE = 14;
    public static final int TOKEN_MWEENG = 15;
    public static final int TOKEN_INIT = 16;
    public static final int TOKEN_NUM = 17;
    public static final int TOKEN_ITEM = 18;

    public final int yychar() {
        return yychar;
    }

    public final String getText() {
        return new String(zzBuffer, zzStartRead, zzMarkedPos - zzStartRead);
    }
%}

%%

<<EOF>> { return -1; }
{NOTYPO} { return TOKEN_NOTYPO ; }
{SYMBOL} { return TOKEN_SYMBOL ; }
{Space} { return TOKEN_SPACE ; }
{CONT} { return TOKEN_CONT ; }
{CHILDES} { return TOKEN_CHILDES ; }
{ABBR} { return TOKEN_ABBR ; }
{PTAG} { return TOKEN_PTAG ; }
{WORD} { return TOKEN_WORD ; }
{WEBADDR} { return TOKEN_WEBADDR ; }
{DIVTAG} { return TOKEN_DIVTAG ; }
{ENGWORD} { return TOKEN_ENGWORD ; }
{MUTWORD} { return TOKEN_MUTWORD ; }
{NONSTD} { return TOKEN_NONSTD ; }
{MWE} { return TOKEN_MWE ; }
{MWEENG} { return TOKEN_MWEENG ; }
{INIT} { return TOKEN_INIT ; }
{NUM} { return TOKEN_NUM ; }
{ITEM} { return TOKEN_ITEM ; }
{XMLEnt} { return TOKEN_XMLENT ; }
