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

import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.*;

public class IrishTokeniserTest {
    @Test
    public void tokenise() throws Exception {
        String inp1 = "Dúirt... m'athair é!";
        String inp2 = "m'";
        String inp3 = " ";
        String inp4 = "Dúirt";
        String inp5 = "m'athair";
        String inp6 = "*ABC:";
        String inp7 = "’na ";
        String inp8 = "*ABC:*ABC:...'' Co.<p>";
        String inp9 = "deireann,m'athair,\u00E9!";
        IrishTokeniser tok = new IrishTokeniser();
        List<String> out1 = tok.tokenise(inp1);
        List<String> exp1 = new ArrayList<String>();
        exp1.add("Dúirt");
        exp1.add("...");
        exp1.add(" ");
        exp1.add("m'");
        exp1.add("athair");
        exp1.add(" ");
        exp1.add("é");
        exp1.add("!");
        List<String> exp5 = new ArrayList<String>();
        exp5.add("m'");
        exp5.add("athair");
        List<String> exp7 = new ArrayList<String>();
        exp7.add("'na");
        exp7.add(" ");
        assertEquals(exp1, out1);
    }

}