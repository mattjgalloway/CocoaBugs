CTFramesetterSpin
=================

rdar://13222856

It is possible, through using an attributed string that sets attributes on a string mid-glyph, to then make CoreText's `CTFramesetterCreateWithAttributedString()` spin forever.

The problem occurs when you add attributes to a string that contains code points that require surrogate pairs. If you add the attribute to only one half of the pair, then the spin will occur. For example, see the attached project.

This is the backtrace during the spin:

```
* thread #1: tid = 0x1c03, 0x0000a24a CoreText`TRun::GetGlyphIndexForCharIndex(long) const + 46, stop reason = signal SIGSTOP
    frame #0: 0x0000a24a CoreText`TRun::GetGlyphIndexForCharIndex(long) const + 46
    frame #1: 0x0000bf6e CoreText`TRun::GetNextUnmappedCharRange(long) const + 52
    frame #2: 0x00018af8 CoreText`TGlyphEncoder::RunUnicodeEncoderRecursively(CTRun*, adopted_t const&, __CTFont const*, CFRange, TGlyphList<TDeletedGlyphIndex>&, TGlyphList<TDeletedGlyphIndex>&, TFontCascade const*, TGlyphEncoder::ClusterMatching, bool) + 1190
    frame #3: 0x000191d6 CoreText`TGlyphEncoder::AppendUnmappedCharRun(CTRun*, __CTFont const*, CFRange, CFRange, TGlyphList<TDeletedGlyphIndex>&, TGlyphList<TDeletedGlyphIndex>&, TFontCascade const&, TGlyphEncoder::ClusterMatching) + 1554
    frame #4: 0x00018a6d CoreText`TGlyphEncoder::RunUnicodeEncoderRecursively(CTRun*, adopted_t const&, __CTFont const*, CFRange, TGlyphList<TDeletedGlyphIndex>&, TGlyphList<TDeletedGlyphIndex>&, TFontCascade const*, TGlyphEncoder::ClusterMatching, bool) + 1051
    frame #5: 0x000185b4 CoreText`TGlyphEncoder::RunUnicodeEncoder(CTRun*, adopted_t const&, __CTFont const*, CFRange, TGlyphList<TDeletedGlyphIndex>&, TFontCascade const*) + 112
    frame #6: 0x000181c8 CoreText`TGlyphEncoder::EncodeChars(CFRange, TAttributes const&, TGlyphList<TDeletedGlyphIndex>&, TGlyphEncoder::Fallbacks) + 1368
    frame #7: 0x0002aa90 CoreText`TTypesetterAttrString::Initialize(__CFAttributedString const*) + 410
    frame #8: 0x0002a8cc CoreText`TTypesetterAttrString::TTypesetterAttrString(__CFAttributedString const*) + 164
    frame #9: 0x00024beb CoreText`TFramesetterAttrString::TFramesetterAttrString(__CFAttributedString const*) + 117
    frame #10: 0x00024557 CoreText`CTFramesetterCreateWithAttributedString + 110
    frame #11: 0x00001e68 CTFramesetterSpin`main(argc=1, argv=0xbfffef40) + 232 at main.m:17
```

Steps to Reproduce:

1. Open attached sample project.
1. Run on iOS simulator.
1. Observe spin.
1. Pause debugger.
1. Observer backtrace.

Note this is also present on Mac OS X.
