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

import org.junit.Test;

import static org.junit.Assert.*;

public class StringUtilsTest {
    @Test
    public void toLower() throws Exception {
        assertEquals("n-éan", StringUtils.toLower("nÉAN"));
        assertEquals("t-éan", StringUtils.toLower("tÉAN"));
        assertEquals("héan", StringUtils.toLower("hÉAN"));
    }

    @Test
    public void isIrishVowel() throws Exception {
        assertEquals(true, StringUtils.isIrishVowel('á'));
        assertEquals(true, StringUtils.isIrishVowel('Á'));
        assertEquals(false, StringUtils.isIrishVowel('b'));
    }

    @Test
    public void isIrishUpperVowel() throws Exception {
        assertEquals(false, StringUtils.isIrishUpperVowel('á'));
        assertEquals(true, StringUtils.isIrishUpperVowel('Á'));
        assertEquals(false, StringUtils.isIrishUpperVowel('b'));
    }

    @Test
    public void stripDots() throws Exception {
        assertEquals("BbCcDdFfGgMmPpSsTt", StringUtils.stripDots("ḂḃĊċḊḋḞḟĠġṀṁṖṗṠṡṪṫ"));
        assertEquals("should be exactly the same", StringUtils.stripDots("should be exactly the same"));
    }

    @Test
    public void addDots() throws Exception {
        assertEquals("ḂḃĊċḊḋḞḟĠġṀṁṖṗṠṡṪṫ", StringUtils.addDots("BbCcDdFfGgMmPpSsTt"));
        assertEquals("uhoh", StringUtils.addDots("uhoh"));
    }

    @Test
    public void removeBuailte() throws Exception {
        assertEquals("BH", StringUtils.removeBuailte("Ḃ"));
        assertEquals("Bha", StringUtils.removeBuailte("Ḃa"));
        assertEquals("BHA", StringUtils.removeBuailte("ḂA"));
        assertEquals("CHUAIGH", StringUtils.removeBuailte("ĊUAIĠ"));
        assertEquals("LAGHAD", StringUtils.removeBuailte("LAĠAD"));
        assertEquals("uhoh", StringUtils.removeBuailte("uhoh"));
    }

    @Test
    public void insertBuailte() throws Exception {
        assertEquals("uhoh", StringUtils.insertBuailte("uhoh"));
        assertEquals("Ḃ", StringUtils.insertBuailte("BH"));
        assertEquals("Ḃa", StringUtils.insertBuailte("Bha"));
        assertEquals("ḂA", StringUtils.insertBuailte("BHA"));
        assertEquals("ḃ", StringUtils.insertBuailte("bh"));
        assertEquals("ḃa", StringUtils.insertBuailte("bha"));
        assertEquals("ḃA", StringUtils.insertBuailte("bHA"));
        assertEquals("ĊUAIĠ", StringUtils.insertBuailte("CHUAIGH"));
        assertEquals("LAĠAD", StringUtils.insertBuailte("LAGHAD"));

    }
}