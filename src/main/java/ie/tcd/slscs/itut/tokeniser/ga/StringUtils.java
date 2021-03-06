/*
 * Copyright © 2016 Trinity College, Dublin
 * Irish Speech and Language Technology Research Centre
 * Cóipcheart © 2016 Coláiste na Tríonóide, Baile Átha Cliath
 * An tIonad taighde do Theicneolaíocht Urlabhra agus Teangeolaíochta na Gaeilge
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package ie.tcd.slscs.itut.tokeniser.ga;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public class StringUtils {
    static final Map<String, String> recase;
    static {
        Map<String, String> recasetmp = new HashMap<String, String>();
        recasetmp.put("áth cliath", "Áth Cliath");
        recasetmp.put("baile átha cliath", "Baile Átha Cliath");
        recasetmp.put("contae átha cliath", "Contae Átha Cliath");
        recasetmp.put("cill chainnigh", "Cill Chainnigh");
        recasetmp.put("gcill chainnigh", "gCill Chainnigh");
        recasetmp.put("chill chainnigh", "Chill Chainnigh");
        recasetmp.put("cill dara", "Cill Dara");
        recasetmp.put("chill dara", "Chill Dara");
        recasetmp.put("gcill dara", "gCill Dara");
        recasetmp.put("cill mhantáin", "Cill Mhantáin");
        recasetmp.put("chill mhantáin", "Chill Mhantáin");
        recasetmp.put("gcill mhantáin", "gCill Mhantáin");
        recasetmp.put("loch garman", "Loch Garman");
        recasetmp.put("uíbh fháilí", "Uíbh Fháilí");
        recasetmp.put("port láirge", "Port Láirge");
        recasetmp.put("phort láirge", "Phort Láirge");
        recasetmp.put("bport láirge", "bPort Láirge");
        recasetmp.put("tiobraid árann", "Tiobraid Árann");
        recasetmp.put("dtiobraid árann", "dTiobraid Árann");
        recasetmp.put("thiobraid árann", "Thiobraid Árann");
        recasetmp.put("maigh eo", "Maigh Eo");
        recasetmp.put("mhaigh eo", "Mhaigh Eo");
        recasetmp.put("ros comáin", "Ros Comáin");
        recasetmp.put("ard mhacha", "Ard Mhacha");
        recasetmp.put("dún na ngall", "Dún na nGall");
        recasetmp.put("dhún na ngall", "Dhún na nGall");
        recasetmp.put("ndún na ngall", "nDún na nGall");
        recasetmp.put("fear manach", "Fear Manach");
        recasetmp.put("bhfear manach", "bhFear Manach");
        recasetmp.put("fhear manach", "Fhear Manach");
        recasetmp.put("tír eoghain", "Tír Eoghain");
        recasetmp.put("thír eoghain", "Thír Eoghain");
        recasetmp.put("dtír eoghain", "dTír Eoghain");
        recasetmp.put("béal feirste", "Béal Feirste");
        recasetmp.put("mbéal feirste", "mBéal Feirste");
        recasetmp.put("bhéal feirste", "Bhéal Feirste");
        recasetmp.put("caisleán riabhach", "Caisleán Riabhach");
        recasetmp.put("chaisleán riabhach", "Chaisleán Riabhach");
        recasetmp.put("gcaisleán riabhach", "gCaisleán Riabhach");
        recasetmp.put("sinn féin", "Sinn Féin");
        recasetmp.put("fianna fáil", "Fianna Fáil");
        recasetmp.put("fine gael", "Fine Gael");
        recasetmp.put("lucht oibre", "Lucht Oibre");
        recase = Collections.unmodifiableMap(recasetmp);
    }

    /**
     * Returns the correctly cased version of the multiword entry,
     * for use with the morphological analyser.
     * @param s The string to recase
     * @return Correctly cased MWE
     */
    public static String recaseMWE(String s) {
        return recase.get(s.toLowerCase());
    }
    /**
     * toLower, but for Irish strings: if the word begins with 'n' or 't',
     * followed by a vowel, the lowercase string must have a hyphen after
     * the 'n' or 't'
     * @param s the string to convert
     * @return the lower case version of the input
     */
    public static String toLower(String s) {
        if(s.length() <= 1) {
            return s.toLowerCase();
        }
        char first = s.charAt(0);
        if((first == 'n' || first == 't') && isIrishUpperVowel(s.charAt(1))) {
            return first + "-" + s.substring(1).toLowerCase();
        } else {
            return s.toLowerCase();
        }
    }

    /**
     * Check if the character is an Irish vowel
     * (a, e, i, o, u, á, é, í, ó, ú)
     * @param c the character to check
     * @return true if the character is an Irish vowel,
     * false otherwise
     */
    public static boolean isIrishVowel(char c) {
        switch (Character.toLowerCase(c)) {
            case 'a':
            case 'e':
            case 'i':
            case 'o':
            case 'u':
            case '\u00E1':
            case '\u00E9':
            case '\u00ED':
            case '\u00F3':
            case '\u00FA':
                return true;
            default:
                return false;
        }
    }

    /**
     * Check if the character is an uppercase Irish vowel
     * (A, E, I, O, U, Á, É, Í, Ó, Ú)
     * @param c the character to check
     * @return true if the character is an uppercase Irish vowel,
     * false otherwise
     */
    public static boolean isIrishUpperVowel(char c) {
        switch (c) {
            case 'A':
            case 'E':
            case 'I':
            case 'O':
            case 'U':
            case '\u00C1':
            case '\u00C9':
            case '\u00CD':
            case '\u00D3':
            case '\u00DA':
                return true;
            default:
                return false;
        }
    }

    /**
     * Strips buailte (dotted) letters from the input string
     * (to test removeDot)
     * @param s
     * @return
     */
    public static String stripDots(String s) {
        String out = "";
        for(Character c : s.toCharArray()) {
            out += removeDot(c);
        }
        return out;
    }
    private static char removeDot(char c) {
        switch(c) {
            case '\u1E02':
                return 'B';
            case '\u1E03':
                return 'b';
            case '\u010A':
                return 'C';
            case '\u010B':
                return 'c';
            case '\u1E0A':
                return 'D';
            case '\u1E0B':
                return 'd';
            case '\u1E1E':
                return 'F';
            case '\u1E1F':
                return 'f';
            case '\u0120':
                return 'G';
            case '\u0121':
                return 'g';
            case '\u1E40':
                return 'M';
            case '\u1E41':
                return 'm';
            case '\u1E56':
                return 'P';
            case '\u1E57':
                return 'p';
            case '\u1E60':
                return 'S';
            case '\u1E61':
                return 's';
            case '\u1E6A':
                return 'T';
            case '\u1E6B':
                return 't';
            default:
                return c;
        }
    }

    /**
     * Adds buailte (dotted) letters to the input string
     * (to test addDot)
     * @param s
     * @return
     */
    public static String addDots(String s) {
        String out = "";
        for(Character c : s.toCharArray()) {
            out += addDot(c);
        }
        return out;
    }
    private static char addDot(char c) {
        switch(c) {
            case 'B':
                return '\u1E02';
            case 'b':
                return '\u1E03';
            case 'C':
                return '\u010A';
            case 'c':
                return '\u010B';
            case 'D':
                return '\u1E0A';
            case 'd':
                return '\u1E0B';
            case 'F':
                return '\u1E1E';
            case 'f':
                return '\u1E1F';
            case 'G':
                return '\u0120';
            case 'g':
                return '\u0121';
            case 'M':
                return '\u1E40';
            case 'm':
                return '\u1E41';
            case 'P':
                return '\u1E56';
            case 'p':
                return '\u1E57';
            case 'S':
                return '\u1E60';
            case 's':
                return '\u1E61';
            case 'T':
                return '\u1E6A';
            case 't':
                return '\u1E6B';
            default:
                return c;
        }
    }

    /**
     * Removes buailte (dotted) letters from older Irish text, inserting 'h'
     * after the relevant letter if it is buailte
     * @param s The input string
     * @return The string with buailte letters removed
     */
    public static String removeBuailte(String s) {
        String out = "";
        char[] ca = s.toCharArray();
        for(int i = 0; i < ca.length; i++) {
            char undotted = removeDot(ca[i]);
            if(undotted == ca[i]) {
                out += ca[i];
            } else {
                if(Character.isLowerCase(ca[i])) {
                    out += undotted;
                    out += 'h';
                } else {
                    if((i == 0 && ca.length == 1)
                        || (ca.length > (i + 1) && Character.isUpperCase(ca[i + 1]))
                        || ((i > 0) && (i == ca.length - 1) && Character.isUpperCase(ca[i - 1]))) {
                        out += undotted;
                        out += 'H';
                    } else {
                        out += undotted;
                        out += 'h';
                    }
                }
            }
        }
        return out;
    }

    public static String insertBuailte(String s) {
        String ret = "";
        for(int i = 0; i < s.length(); ++i) {
            char cur = s.charAt(i);
            char dotted = addDot(cur);
            if(cur == dotted) {
                ret += cur;
            } else {
                if((i < (s.length() - 1)) &&
                   (s.charAt(i + 1) == 'h' || (s.charAt(i + 1) == 'H'))) {
                    ret += dotted;
                    i++;
                } else {
                    ret += cur;
                }
            }
        }
        return ret;
    }
}
