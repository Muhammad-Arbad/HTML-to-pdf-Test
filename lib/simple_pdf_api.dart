
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class SimplePdfApi {
  static Future<File> generateSimpleTextPdf(
      {required pw.Widget content}) async {


    // String chAUr = HtmlUnescape().convert("A square matrix &lt;img src=&quot;data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEcAAAAnCAYAAABdRFVFAAAAAXNSR0IArs4c6QAAAmFJREFUaEPt2kuoTVEcx\/HP9UpJBggDI2QgoTyK5JWQlAHyigERETNKBlIyk5I884qMECYk5REZipgxUchARgyIVq3b3Y69T\/fsc+6xL2sN997\/tdf\/+\/\/9\/+vR6pBaIYGOxKaYQLvhjMLuzHBe4lITAVqJqRn70FfosyWt3XAm4gTWxdF\/w4cmPBmOQdH+MK7iRhP9\/Wb6N+AcxfxWOZDp5yxuJTj5ZBOcOopLcBKccgUpKScpJymnHIGknHLc2lpzpmMaTuJ7ufH+YRVWyL1+EdgHNzEBq\/EswekiMBbncRGTsT3B6SKwD\/1xCvcwB59yAI3Atpznb3Eh53m9tJqNQ5gR\/3UcYTP5o5uBaUvNGYhH2IDXuIL7OJMzyNojiM5P3sRaVWtSBCfsrh9gE55iDO5iGV5VCU6I4EEsiFFbhP2Y24LCXARnJGbiOgZjCk5jMx5WCU5QSIhgtgVpz8opzK1KqwE4gDV4jxdYiI1VgjMUT6Jq3mXohFoQ3m2tgdaqtFqBHViCr+iLx9hTJThrsR5L8TMDIsxYt6Pc8wpzN5WvKK2CYnZm4IR0OhLV8xzLMwU+qHVxTsHv0YIconUH53C5xtt+sUiHd2EGK9uK4ISjzmNYhY\/xKHVcVPG1KsAp63AjdmVWyEMSnGLEo2MKdZ47FwHu0bRqRAFlvy2jnASnDu0EJ8FROJXXS9OknKSccsrp7ub1v5ytsnDCOdOWuDmtPSr5J+CEVfau6PGXBm9FTMK8uO75jPEYFvvaiwCo114kSFdQyq4Qq2bX7isoVfO\/7ngSnDp4EpwEp1w2\/wKwXr4ogA4XsQAAAABJRU5ErkJggg==&quot; border=&quot;0&quot; imatheq-mml=&quot;%3Cmath%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F1998%2FMath%2FMathML%22%3E%3Cmi%20mathvariant%3D%22normal%22%3EA%3C%2Fmi%3E%3Cmo%3E%3D%3C%2Fmo%3E%3Cmfenced%20open%3D%22%5B%22%20close%3D%22%5D%22%3E%3Cmrow%3E%3Cmsub%3E%3Cmi%20mathvariant%3D%22normal%22%3Ea%3C%2Fmi%3E%3Cmi%20mathvariant%3D%22normal%22%3Eij%3C%2Fmi%3E%3C%2Fmsub%3E%3C%2Fmrow%3E%3C%2Fmfenced%3E%3C%2Fmath%3E&quot; \/&gt; for which all &lt;img src=&quot;data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFcAAAAbCAYAAAAJUhN7AAAAAXNSR0IArs4c6QAAArtJREFUaEPt2E3IzlkYx\/GPyAZZIC+lWSAWY7BivI\/yNqWmiBRZkBIm2VhYWXhZmUwTg4iZBRaDUkhRXiJkISUrlCIUWSnvXdN5dHe7n+f5\/+\/n\/39uT\/3P6r7\/nXOd6\/qe37nOdU4vVSuNQK\/SLFeGtRruNMzGLVzCxybWZCBWYR\/eNzG+bUhRdr660Eq4v2MlzmE67mETPucENDItzE94m3Nsbfei7LQc7iBcxXw8QT9cxgo86AKg2qGD0R+PC7KX20y9cmdgBybjJfZiV8btOhTrGnjwCEfrvs\/ENsypUephXMGRnFG0p7jh+CeligM400kcpSp3SFLPatzAKFzAItzPEHAEE9u6vj3E\/rqPv6WUsLjm+9b0e3uGufJs5x\/Tok\/Ff4hFfNpgjlLhDkM4cAoDMAkHsSYpKmfMHXZfhqXoDrhtjsTOOpFS0M\/4UOdhqXD7pq26HM\/SATM3ncSxXTtredLCr1iLUHBbi\/TzArs7mygnlLGIw7Olyl2CDViYTt3euIYtGZWbJy2Mw7+IUuwd\/5eEkRP\/wvmC4H5XOTcUu7EGbqSDPxDqvZtU1nYwhUoXNDiosnLpk\/L5cRzCPOzELLypMxI17M0Oqoj2tnPeaqHUtBDlUCgncuFz\/I0xuI6TBcMNfj+knB6XiNtp695psDpxufgTp9tZuaKgFGXnq5tZLxFxe4n8WJRysyo8+k3ECJzNM6iJvgH3IiZ08TKSG25MHGCjLo02Hntq\/jcRS+Yh63EMrzKPyN8xbnebEeVolJ6f8pv4dkRW5bYSbhFxdmZjSrqCxyEbKbGQVsEtBGNjIxXcCm6JBEo0XSn3O4Bb70J3Vgslhl+u6azKrfVidHoXiMedRk+M5Xrcg6w3AzeK7F9S3fu6B8Xa7a42A7fbneypE1ZwS1y5Cm4Ft0QCJZqulFsi3C\/87p0cCd2jNQAAAABJRU5ErkJggg==&quot; border=&quot;0&quot; imatheq-mml=&quot;%3Cmath%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F1998%2FMath%2FMathML%22%3E%3Cmsub%3E%3Cmi%20mathvariant%3D%22normal%22%3Ea%3C%2Fmi%3E%3Cmi%20mathvariant%3D%22normal%22%3Eij%3C%2Fmi%3E%3C%2Fmsub%3E%3Cmo%3E%3D%3C%2Fmo%3E%3Cmn%3E0%3C%2Fmn%3E%3Cmo%3E%26%23xA0%3B%3C%2Fmo%3E%3Cmo%3E%2C%3C%2Fmo%3E%3Cmo%3E%26%23xA0%3B%3C%2Fmo%3E%3Cmi%20mathvariant%3D%22normal%22%3Ei%3C%2Fmi%3E%3Cmo%3E%26gt%3B%3C%2Fmo%3E%3Cmi%20mathvariant%3D%22normal%22%3Ej%3C%2Fmi%3E%3C%2Fmath%3E&quot; \/&gt; then &lt;img src=&quot;data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAASCAYAAABM8m7ZAAAAAXNSR0IArs4c6QAAAN5JREFUSEvt1LFKQmEYxvHfyYT2bsGtJYdaIhQcHLqBkGhxCLyFcAq6h0JIgrwAcRGiJRC8Am+grVtQig8cDgd1Od\/xNPSuL3z\/9\/\/w8CVKmqQkrl3gc5zhCcvYB24DH2CME1xjvi9wDUO84hS9fYHvUcUz3tHAd0z4pqiP8IlbLDDCBwZFgy\/xgBZWaKOPZsySbTIOZt2MXTjgImbJsuBjzNa2Xyn4I8LuLlbcWXAHN7jCTwoSmj1BPVbJ0uAKpnjBW8bscF24sAtNzz1\/8svMbbXrgX\/jQuNNP15a1L\/z7h8T+NoUkQAAAABJRU5ErkJggg==&quot; border=&quot;0&quot; imatheq-mml=&quot;%3Cmath%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F1998%2FMath%2FMathML%22%3E%3Cmi%20mathvariant%3D%22normal%22%3EA%3C%2Fmi%3E%3C%2Fmath%3E&quot; \/&gt; is called");
    String chAUr = "A square matrix &lt;img src=&quot;data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEcAAAAnCAYAAABdRFVFAAAAAXNSR0IArs4c6QAAAmFJREFUaEPt2kuoTVEcx\/HP9UpJBggDI2QgoTyK5JWQlAHyigERETNKBlIyk5I884qMECYk5REZipgxUchARgyIVq3b3Y69T\/fsc+6xL2sN997\/tdf\/+\/\/9\/+vR6pBaIYGOxKaYQLvhjMLuzHBe4lITAVqJqRn70FfosyWt3XAm4gTWxdF\/w4cmPBmOQdH+MK7iRhP9\/Wb6N+AcxfxWOZDp5yxuJTj5ZBOcOopLcBKccgUpKScpJymnHIGknHLc2lpzpmMaTuJ7ufH+YRVWyL1+EdgHNzEBq\/EswekiMBbncRGTsT3B6SKwD\/1xCvcwB59yAI3Atpznb3Eh53m9tJqNQ5gR\/3UcYTP5o5uBaUvNGYhH2IDXuIL7OJMzyNojiM5P3sRaVWtSBCfsrh9gE55iDO5iGV5VCU6I4EEsiFFbhP2Y24LCXARnJGbiOgZjCk5jMx5WCU5QSIhgtgVpz8opzK1KqwE4gDV4jxdYiI1VgjMUT6Jq3mXohFoQ3m2tgdaqtFqBHViCr+iLx9hTJThrsR5L8TMDIsxYt6Pc8wpzN5WvKK2CYnZm4IR0OhLV8xzLMwU+qHVxTsHv0YIconUH53C5xtt+sUiHd2EGK9uK4ISjzmNYhY\/xKHVcVPG1KsAp63AjdmVWyEMSnGLEo2MKdZ47FwHu0bRqRAFlvy2jnASnDu0EJ8FROJXXS9OknKSccsrp7ub1v5ytsnDCOdOWuDmtPSr5J+CEVfau6PGXBm9FTMK8uO75jPEYFvvaiwCo114kSFdQyq4Qq2bX7isoVfO\/7ngSnDp4EpwEp1w2\/wKwXr4ogA4XsQAAAABJRU5ErkJggg==&quot; border=&quot;0&quot; imatheq-mml=&quot;%3Cmath%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F1998%2FMath%2FMathML%22%3E%3Cmi%20mathvariant%3D%22normal%22%3EA%3C%2Fmi%3E%3Cmo%3E%3D%3C%2Fmo%3E%3Cmfenced%20open%3D%22%5B%22%20close%3D%22%5D%22%3E%3Cmrow%3E%3Cmsub%3E%3Cmi%20mathvariant%3D%22normal%22%3Ea%3C%2Fmi%3E%3Cmi%20mathvariant%3D%22normal%22%3Eij%3C%2Fmi%3E%3C%2Fmsub%3E%3C%2Fmrow%3E%3C%2Fmfenced%3E%3C%2Fmath%3E&quot; \/&gt; for which all &lt;img src=&quot;data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFcAAAAbCAYAAAAJUhN7AAAAAXNSR0IArs4c6QAAArtJREFUaEPt2E3IzlkYx\/GPyAZZIC+lWSAWY7BivI\/yNqWmiBRZkBIm2VhYWXhZmUwTg4iZBRaDUkhRXiJkISUrlCIUWSnvXdN5dHe7n+f5\/+\/n\/39uT\/3P6r7\/nXOd6\/qe37nOdU4vVSuNQK\/SLFeGtRruNMzGLVzCxybWZCBWYR\/eNzG+bUhRdr660Eq4v2MlzmE67mETPucENDItzE94m3Nsbfei7LQc7iBcxXw8QT9cxgo86AKg2qGD0R+PC7KX20y9cmdgBybjJfZiV8btOhTrGnjwCEfrvs\/ENsypUephXMGRnFG0p7jh+CeligM400kcpSp3SFLPatzAKFzAItzPEHAEE9u6vj3E\/rqPv6WUsLjm+9b0e3uGufJs5x\/Tok\/Ff4hFfNpgjlLhDkM4cAoDMAkHsSYpKmfMHXZfhqXoDrhtjsTOOpFS0M\/4UOdhqXD7pq26HM\/SATM3ncSxXTtredLCr1iLUHBbi\/TzArs7mygnlLGIw7Olyl2CDViYTt3euIYtGZWbJy2Mw7+IUuwd\/5eEkRP\/wvmC4H5XOTcUu7EGbqSDPxDqvZtU1nYwhUoXNDiosnLpk\/L5cRzCPOzELLypMxI17M0Oqoj2tnPeaqHUtBDlUCgncuFz\/I0xuI6TBcMNfj+knB6XiNtp695psDpxufgTp9tZuaKgFGXnq5tZLxFxe4n8WJRysyo8+k3ECJzNM6iJvgH3IiZ08TKSG25MHGCjLo02Hntq\/jcRS+Yh63EMrzKPyN8xbnebEeVolJ6f8pv4dkRW5bYSbhFxdmZjSrqCxyEbKbGQVsEtBGNjIxXcCm6JBEo0XSn3O4Bb70J3Vgslhl+u6azKrfVidHoXiMedRk+M5Xrcg6w3AzeK7F9S3fu6B8Xa7a42A7fbneypE1ZwS1y5Cm4Ft0QCJZqulFsi3C\/87p0cCd2jNQAAAABJRU5ErkJggg==&quot; border=&quot;0&quot; imatheq-mml=&quot;%3Cmath%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F1998%2FMath%2FMathML%22%3E%3Cmsub%3E%3Cmi%20mathvariant%3D%22normal%22%3Ea%3C%2Fmi%3E%3Cmi%20mathvariant%3D%22normal%22%3Eij%3C%2Fmi%3E%3C%2Fmsub%3E%3Cmo%3E%3D%3C%2Fmo%3E%3Cmn%3E0%3C%2Fmn%3E%3Cmo%3E%26%23xA0%3B%3C%2Fmo%3E%3Cmo%3E%2C%3C%2Fmo%3E%3Cmo%3E%26%23xA0%3B%3C%2Fmo%3E%3Cmi%20mathvariant%3D%22normal%22%3Ei%3C%2Fmi%3E%3Cmo%3E%26gt%3B%3C%2Fmo%3E%3Cmi%20mathvariant%3D%22normal%22%3Ej%3C%2Fmi%3E%3C%2Fmath%3E&quot; \/&gt; then &lt;img src=&quot;data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAASCAYAAABM8m7ZAAAAAXNSR0IArs4c6QAAAN5JREFUSEvt1LFKQmEYxvHfyYT2bsGtJYdaIhQcHLqBkGhxCLyFcAq6h0JIgrwAcRGiJRC8Am+grVtQig8cDgd1Od\/xNPSuL3z\/9\/\/w8CVKmqQkrl3gc5zhCcvYB24DH2CME1xjvi9wDUO84hS9fYHvUcUz3tHAd0z4pqiP8IlbLDDCBwZFgy\/xgBZWaKOPZsySbTIOZt2MXTjgImbJsuBjzNa2Xyn4I8LuLlbcWXAHN7jCTwoSmj1BPVbJ0uAKpnjBW8bscF24sAtNzz1\/8svMbbXrgX\/jQuNNP15a1L\/z7h8T+NoUkQAAAABJRU5ErkJggg==&quot; border=&quot;0&quot; imatheq-mml=&quot;%3Cmath%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F1998%2FMath%2FMathML%22%3E%3Cmi%20mathvariant%3D%22normal%22%3EA%3C%2Fmi%3E%3C%2Fmath%3E&quot; \/&gt; is called";

    String a = "ABCD <b>A</b>";

    final pdf = pw.Document();

    log("chAUr");
    log(chAUr);



    pdf.addPage(
      pw.MultiPage(

        // pageTheme: pageTheme,

        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(20),
          buildForeground: (context) => pw.Container(

              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 2),
              ),
          ),

          buildBackground: (context) => pw.FullPage(
            ignoreMargins: true,
            child: pw.Stack(
              children: [

                pw.Positioned(
                  top: 50,
                  left: 50,
                  child: pw.Transform.rotate(
                    angle: -0.5,
                    child: pw.Opacity(
                      opacity: 0.3,
                      child: pw.Text(
                        'Al Baghdad School',
                        style: pw.TextStyle(
                          fontSize: 54,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey,
                        ),
                      ),
                    ),
                  ),
                ),

                // Second instance of watermark at center
                pw.Center(
                  child: pw.Transform.rotate(
                    angle: -0.5,
                    child: pw.Opacity(
                      opacity: 0.3,
                      child: pw.Text(
                        'Al Baghdad School',
                        style: pw.TextStyle(
                          fontSize: 54,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey,
                        ),
                      ),
                    ),
                  ),
                ),

                // Third instance of watermark at bottom right
                pw.Positioned(
                  bottom: 50,
                  right: 50,
                  child: pw.Transform.rotate(
                    angle: -0.5,
                    child: pw.Opacity(
                      opacity: 0.3,
                      child: pw.Text(
                        'Al Baghdad School',
                        style: pw.TextStyle(
                          fontSize: 54,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Header
        header: (pw.Context context) => pw.Container(
          alignment: pw.Alignment.centerLeft,
          padding: const pw.EdgeInsets.only(bottom: 8),
          decoration: const pw.BoxDecoration(
            border: pw.Border(bottom: pw.BorderSide(width: 0.5)),
          ),
          child: pw.Text(
            'Physics Paper',
            style: pw.TextStyle(
              fontSize: 20,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),

        // Footer
        footer: (pw.Context context) => pw.Container(
          alignment: pw.Alignment.center,
          child: pw.Text(
            'Best of luck',
            style: pw.TextStyle(
              fontSize: 20,
              color: PdfColors.black,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),

        // Content
        build: (context) => [
          pw.SizedBox(height: 10),
         content,
          // pw.HtmlWrap(data: chAUr),
          pw.HtmlWrap(data: a,styles: {
            "body": pw.TextStyle(
              fontSize: 50
            )
          }),

          HtmlWrap(
            data: a,
            styles: {
              "body": pw.TextStyle(fontSize: 50),
              "b": pw.TextStyle(fontWeight: pw.FontWeight.bold), // Ensure bold style
            },
          ),

          pw.SizedBox(height: 10),
        ],
      ),
    );

    // Save the PDF
    return await SaveAndOpenPdf.savePdf(name: 'simple_text.pdf', pdf: pdf);
  }


  Html htmlWithStylingForOptions({required String text}) {
    return Html(data: text, style: {
      "body": Style(
        margin: Margins.zero,
        padding: HtmlPaddings.zero,
      )
    });
  }

}


Future<pw.PageTheme> _myPageTheme() async {
  final bgShape = await rootBundle.loadString('assets/icons/abc.svg');

  // format = format.applyMargin(
  //     left: 2.0 * PdfPageFormat.cm,
  //     top: 4.0 * PdfPageFormat.cm,
  //     right: 2.0 * PdfPageFormat.cm,
  //     bottom: 2.0 * PdfPageFormat.cm);
  return pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
    // theme: pw.ThemeData.withFont(
    //   base: await PdfGoogleFonts.openSansRegular(),
    //   bold: await PdfGoogleFonts.openSansBold(),
    //   icons: await PdfGoogleFonts.materialIcons(),
    // ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.Center(
          child:
          pw.Transform.rotate(angle: -45,child: pw.Opacity(
              opacity: 0.1,
              child: pw.Text("ABC",style: pw.TextStyle(fontSize: 200,color: PdfColors.grey,))))

          // pw.Opacity(opacity: 0.3, child: pw.Text("ABC",style: pw.TextStyle(fontSize: 100,color: PdfColors.grey,)))

      ),
        // pw.Stack(
        //   children: [
        //     // pw.Positioned(
        //     //   child: pw.SvgImage(svg: bgShape),
        //     //   left: 0,
        //     //   top: 0,
        //     // ),
        //     // pw.Positioned(
        //     //   child: pw.Transform.rotate(angle: pi, child: pw.SvgImage(svg: bgShape)),
        //     //   right: 0,
        //     //   bottom: 0,
        //     // ),
        //   ],
        // ),
      );
    },
  );
}






class SaveAndOpenPdf {
  static Future<File> savePdf({
    required String name,
    required Document pdf,
  }) async {
    final root = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    final file = File('${root!.path}/$name');
    log('${root.path}/$name');
    await file.writeAsBytes(await pdf.save());

    return file;
  }

  static Future<void> openPdf(File file) async {
    final path = file.path;
    await OpenFile.open(path);
    log('PDF opened');
  }
}
