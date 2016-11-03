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

package ie.tcd.slscs.itut.tokeniser.ga;

import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;

public class IrishTokeniser {
    private final IrishTokeniserImpl tokeniser = new IrishTokeniserImpl(new StringReader(""));
    public List<String> tokenise(String s) {
        List<String> toks = new ArrayList<String>();
        tokeniser.yyreset(new StringReader(s));
        int ntok;
        try {
            while((ntok = tokeniser.getNextToken()) != IrishTokeniserImpl.YYEOF) {
                String cur = tokeniser.getText();
                if (ntok == IrishTokeniserImpl.TOKEN_CONT) {
                    cur = cur.replaceAll("\u2019", "'").replaceAll("&apos;", "'");
                    if (cur.startsWith("'n")) {
                        toks.add(cur.substring(0, cur.length()-1));
                        toks.add(" ");
                    } else {
                        toks.add(cur);
                    }
                } else if (ntok == IrishTokeniserImpl.TOKEN_NOTYPO) {
                    toks.add(" ");
                    toks.add(cur.substring(1));
                } else {
                    toks.add(cur);
                }
            }
        } catch(IOException e) {
            throw new RuntimeException(e);
        }
        return toks;
    }
}
