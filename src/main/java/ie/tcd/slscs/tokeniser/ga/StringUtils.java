/*
 * Copyright 2016 Trinity College, Dublin
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

package ie.tcd.slscs.tokeniser.ga;

public class StringUtils {
    /**
     * toLower, but for Irish strings: if the word begins with 'n' or 't',
     * followed by a vowel, the lowercase string must have a hyphen after
     * the 'n' or 't'
     * @param s the string to convert
     * @return the lower case version of the input
     */
    public static String toLower(String s) {
        if(s.length() <= 1) {
            return s;
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
}
