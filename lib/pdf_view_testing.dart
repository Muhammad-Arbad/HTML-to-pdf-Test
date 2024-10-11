
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_test/simple_pdf_api.dart';


class PdfViewTesting extends StatefulWidget {
  const PdfViewTesting({super.key});

  @override
  State<PdfViewTesting> createState() => _PdfViewTestingState();
}

class _PdfViewTestingState extends State<PdfViewTesting> {


  final pdfDocument = pw.Document();

  @override
  void initState() {
    super.initState();
    // load();
  }

  String chAUr = HtmlUnescape().convert("A square matrix &lt;img src=&quot;data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEcAAAAnCAYAAABdRFVFAAAAAXNSR0IArs4c6QAAAmFJREFUaEPt2kuoTVEcx\/HP9UpJBggDI2QgoTyK5JWQlAHyigERETNKBlIyk5I884qMECYk5REZipgxUchARgyIVq3b3Y69T\/fsc+6xL2sN997\/tdf\/+\/\/9\/+vR6pBaIYGOxKaYQLvhjMLuzHBe4lITAVqJqRn70FfosyWt3XAm4gTWxdF\/w4cmPBmOQdH+MK7iRhP9\/Wb6N+AcxfxWOZDp5yxuJTj5ZBOcOopLcBKccgUpKScpJymnHIGknHLc2lpzpmMaTuJ7ufH+YRVWyL1+EdgHNzEBq\/EswekiMBbncRGTsT3B6SKwD\/1xCvcwB59yAI3Atpznb3Eh53m9tJqNQ5gR\/3UcYTP5o5uBaUvNGYhH2IDXuIL7OJMzyNojiM5P3sRaVWtSBCfsrh9gE55iDO5iGV5VCU6I4EEsiFFbhP2Y24LCXARnJGbiOgZjCk5jMx5WCU5QSIhgtgVpz8opzK1KqwE4gDV4jxdYiI1VgjMUT6Jq3mXohFoQ3m2tgdaqtFqBHViCr+iLx9hTJThrsR5L8TMDIsxYt6Pc8wpzN5WvKK2CYnZm4IR0OhLV8xzLMwU+qHVxTsHv0YIconUH53C5xtt+sUiHd2EGK9uK4ISjzmNYhY\/xKHVcVPG1KsAp63AjdmVWyEMSnGLEo2MKdZ47FwHu0bRqRAFlvy2jnASnDu0EJ8FROJXXS9OknKSccsrp7ub1v5ytsnDCOdOWuDmtPSr5J+CEVfau6PGXBm9FTMK8uO75jPEYFvvaiwCo114kSFdQyq4Qq2bX7isoVfO\/7ngSnDp4EpwEp1w2\/wKwXr4ogA4XsQAAAABJRU5ErkJggg==&quot; border=&quot;0&quot; imatheq-mml=&quot;%3Cmath%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F1998%2FMath%2FMathML%22%3E%3Cmi%20mathvariant%3D%22normal%22%3EA%3C%2Fmi%3E%3Cmo%3E%3D%3C%2Fmo%3E%3Cmfenced%20open%3D%22%5B%22%20close%3D%22%5D%22%3E%3Cmrow%3E%3Cmsub%3E%3Cmi%20mathvariant%3D%22normal%22%3Ea%3C%2Fmi%3E%3Cmi%20mathvariant%3D%22normal%22%3Eij%3C%2Fmi%3E%3C%2Fmsub%3E%3C%2Fmrow%3E%3C%2Fmfenced%3E%3C%2Fmath%3E&quot; \/&gt; for which all &lt;img src=&quot;data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFcAAAAbCAYAAAAJUhN7AAAAAXNSR0IArs4c6QAAArtJREFUaEPt2E3IzlkYx\/GPyAZZIC+lWSAWY7BivI\/yNqWmiBRZkBIm2VhYWXhZmUwTg4iZBRaDUkhRXiJkISUrlCIUWSnvXdN5dHe7n+f5\/+\/n\/39uT\/3P6r7\/nXOd6\/qe37nOdU4vVSuNQK\/SLFeGtRruNMzGLVzCxybWZCBWYR\/eNzG+bUhRdr660Eq4v2MlzmE67mETPucENDItzE94m3Nsbfei7LQc7iBcxXw8QT9cxgo86AKg2qGD0R+PC7KX20y9cmdgBybjJfZiV8btOhTrGnjwCEfrvs\/ENsypUephXMGRnFG0p7jh+CeligM400kcpSp3SFLPatzAKFzAItzPEHAEE9u6vj3E\/rqPv6WUsLjm+9b0e3uGufJs5x\/Tok\/Ff4hFfNpgjlLhDkM4cAoDMAkHsSYpKmfMHXZfhqXoDrhtjsTOOpFS0M\/4UOdhqXD7pq26HM\/SATM3ncSxXTtredLCr1iLUHBbi\/TzArs7mygnlLGIw7Olyl2CDViYTt3euIYtGZWbJy2Mw7+IUuwd\/5eEkRP\/wvmC4H5XOTcUu7EGbqSDPxDqvZtU1nYwhUoXNDiosnLpk\/L5cRzCPOzELLypMxI17M0Oqoj2tnPeaqHUtBDlUCgncuFz\/I0xuI6TBcMNfj+knB6XiNtp695psDpxufgTp9tZuaKgFGXnq5tZLxFxe4n8WJRysyo8+k3ECJzNM6iJvgH3IiZ08TKSG25MHGCjLo02Hntq\/jcRS+Yh63EMrzKPyN8xbnebEeVolJ6f8pv4dkRW5bYSbhFxdmZjSrqCxyEbKbGQVsEtBGNjIxXcCm6JBEo0XSn3O4Bb70J3Vgslhl+u6azKrfVidHoXiMedRk+M5Xrcg6w3AzeK7F9S3fu6B8Xa7a42A7fbneypE1ZwS1y5Cm4Ft0QCJZqulFsi3C\/87p0cCd2jNQAAAABJRU5ErkJggg==&quot; border=&quot;0&quot; imatheq-mml=&quot;%3Cmath%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F1998%2FMath%2FMathML%22%3E%3Cmsub%3E%3Cmi%20mathvariant%3D%22normal%22%3Ea%3C%2Fmi%3E%3Cmi%20mathvariant%3D%22normal%22%3Eij%3C%2Fmi%3E%3C%2Fmsub%3E%3Cmo%3E%3D%3C%2Fmo%3E%3Cmn%3E0%3C%2Fmn%3E%3Cmo%3E%26%23xA0%3B%3C%2Fmo%3E%3Cmo%3E%2C%3C%2Fmo%3E%3Cmo%3E%26%23xA0%3B%3C%2Fmo%3E%3Cmi%20mathvariant%3D%22normal%22%3Ei%3C%2Fmi%3E%3Cmo%3E%26gt%3B%3C%2Fmo%3E%3Cmi%20mathvariant%3D%22normal%22%3Ej%3C%2Fmi%3E%3C%2Fmath%3E&quot; \/&gt; then &lt;img src=&quot;data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAASCAYAAABM8m7ZAAAAAXNSR0IArs4c6QAAAN5JREFUSEvt1LFKQmEYxvHfyYT2bsGtJYdaIhQcHLqBkGhxCLyFcAq6h0JIgrwAcRGiJRC8Am+grVtQig8cDgd1Od\/xNPSuL3z\/9\/\/w8CVKmqQkrl3gc5zhCcvYB24DH2CME1xjvi9wDUO84hS9fYHvUcUz3tHAd0z4pqiP8IlbLDDCBwZFgy\/xgBZWaKOPZsySbTIOZt2MXTjgImbJsuBjzNa2Xyn4I8LuLlbcWXAHN7jCTwoSmj1BPVbJ0uAKpnjBW8bscF24sAtNzz1\/8svMbbXrgX\/jQuNNP15a1L\/z7h8T+NoUkQAAAABJRU5ErkJggg==&quot; border=&quot;0&quot; imatheq-mml=&quot;%3Cmath%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F1998%2FMath%2FMathML%22%3E%3Cmi%20mathvariant%3D%22normal%22%3EA%3C%2Fmi%3E%3C%2Fmath%3E&quot; \/&gt; is called");


  List<String> abc = [
    "13",
    "13",
    "13",
    "13",
    "13",
    "13",
    "13",
    "13",
    "13",
    "13",
    "13",
    "13",
    "13",
    "13",
    "13",
    "13",
    "13",
    "13",
    "13",
    "13",
    "13",
    "13"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pdf View Test'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: Text('Open Simple PDF'),
            onPressed: () async {


              final simplePdfFile = await SimplePdfApi.generateSimpleTextPdf(
                content: pw.Column(
                  children: [
                    pw.Padding(
                        padding: pw.EdgeInsets.only(top: 20),
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(20),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.center,
                                  children: [
                                    pw.Text(
                                      "{data.secTitle}",
                                      style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ],
                                ),
                              pw.SizedBox(height: 10),

                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Text(
                                        "{data.secRemarks}",
                                        style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    pw.Expanded(
                                      child: pw.Text(
                                        "({data.secMarks} Marks/Qs)",
                                        style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              pw.SizedBox(height: 10),
                              pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.start,
                                children: [
                                  pw.Text('Question: {data.qstmt}'),
                                ],
                              ),
                              pw.SizedBox(height: 10),
                              pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                                children: [
                                  pw.Text('A: {data.chA}'),
                                  pw.Text('B: {data.chB}'),
                                  pw.Text('C: {data.chC}'),
                                  pw.Text('D: {data.chD}'),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              );

              // Save and open the PDF
              SaveAndOpenPdf.openPdf(simplePdfFile);
            },
          ),


          Html(data: chAUr),
        ],
      ),
    );
  }

  pw.Row buildQuestionRow(
      String label, Uint8List minusImageData, Uint8List plusImageData) {
    return pw.Row(
      children: [
        pw.Expanded(
          child: pw.Text(
            label,
            style: pw.TextStyle(color: PdfColors.black, fontSize: 20),
          ),
        ),
        pw.Expanded(
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Image(pw.MemoryImage(minusImageData), width: 15, height: 15),
              pw.Text('1',
                  style: pw.TextStyle(color: PdfColors.black, fontSize: 24)),
              pw.Image(pw.MemoryImage(plusImageData), width: 15, height: 15),
            ],
          ),
        ),
      ],
    );
  }
}

