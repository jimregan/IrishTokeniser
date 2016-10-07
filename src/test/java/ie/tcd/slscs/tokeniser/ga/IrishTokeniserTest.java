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
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;

public class IrishTokeniserTest {
    @Test
    public void tokenise() throws Exception {
        String inp1 = "Dúirt... m'athair é!";
        List<String> exp1 = Arrays.asList("Dúirt", "...", " ", "m'", "athair", " ", "é", "!");
        String inp2 = "m'";
        List<String> exp2 = Arrays.asList("m'");
        String inp3 = " ";
        List<String> exp3 = Arrays.asList(" ");
        String inp4 = "Dúirt";
        List<String> exp4 = Arrays.asList("Dúirt");
        String inp5 = "m&apos;athair";
        List<String> exp5 = Arrays.asList("m'", "athair");
        String inp6 = "*ABC:";
        List<String> exp6 = Arrays.asList("*ABC:");
        String inp7 = "\u2019na ";
        List<String> exp7 = Arrays.asList("'na", " ");
        String inp8 = "*ABC:*ABC:...'' Co.<p>";
        List<String> exp8 = Arrays.asList("*ABC:", "*ABC:", "...", "''", " ", "Co.", "<p>");
        String inp9 = "!http://tcd.ie atá";
        List<String> exp9 = Arrays.asList("!", "http://tcd.ie", " ", "atá");
        String inp10 = "mar a déarfá, you know";
        List<String> exp10 = Arrays.asList("mar a déarfá", ",", " ", "you know");
        String inp11 = "IRP6%";
        List<String> exp11 = Arrays.asList("126,33.6", " ", "xiv)");

        IrishTokeniser tok = new IrishTokeniser();
        List<String> out1 = tok.tokenise(inp1);
        assertEquals(exp1, out1);
        List<String> out2 = tok.tokenise(inp2);
        assertEquals(exp2, out2);
        List<String> out3 = tok.tokenise(inp3);
        assertEquals(exp3, out3);
        List<String> out4 = tok.tokenise(inp4);
        assertEquals(exp4, out4);
        List<String> out5 = tok.tokenise(inp5);
        assertEquals(exp5, out5);
        List<String> out6 = tok.tokenise(inp6);
        assertEquals(exp6, out6);
        List<String> out7 = tok.tokenise(inp7);
        assertEquals(exp7, out7);
        List<String> out8 = tok.tokenise(inp8);
        assertEquals(exp8, out8);
        List<String> out9 = tok.tokenise(inp9);
        assertEquals(exp9, out9);
        List<String> out10 = tok.tokenise(inp10);
        assertEquals(exp10, out10);
        List<String> out11 = tok.tokenise(inp11);
        assertEquals(exp11, out11);
    }

}