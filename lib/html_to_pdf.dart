

import 'dart:io';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:open_file/open_file.dart';

class HTMLtoPDF {
  String chAUr = HtmlUnescape().convert("A square matrix &lt;img src=&quot;data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEcAAAAnCAYAAABdRFVFAAAAAXNSR0IArs4c6QAAAmFJREFUaEPt2kuoTVEcx\/HP9UpJBggDI2QgoTyK5JWQlAHyigERETNKBlIyk5I884qMECYk5REZipgxUchARgyIVq3b3Y69T\/fsc+6xL2sN997\/tdf\/+\/\/9\/+vR6pBaIYGOxKaYQLvhjMLuzHBe4lITAVqJqRn70FfosyWt3XAm4gTWxdF\/w4cmPBmOQdH+MK7iRhP9\/Wb6N+AcxfxWOZDp5yxuJTj5ZBOcOopLcBKccgUpKScpJymnHIGknHLc2lpzpmMaTuJ7ufH+YRVWyL1+EdgHNzEBq\/EswekiMBbncRGTsT3B6SKwD\/1xCvcwB59yAI3Atpznb3Eh53m9tJqNQ5gR\/3UcYTP5o5uBaUvNGYhH2IDXuIL7OJMzyNojiM5P3sRaVWtSBCfsrh9gE55iDO5iGV5VCU6I4EEsiFFbhP2Y24LCXARnJGbiOgZjCk5jMx5WCU5QSIhgtgVpz8opzK1KqwE4gDV4jxdYiI1VgjMUT6Jq3mXohFoQ3m2tgdaqtFqBHViCr+iLx9hTJThrsR5L8TMDIsxYt6Pc8wpzN5WvKK2CYnZm4IR0OhLV8xzLMwU+qHVxTsHv0YIconUH53C5xtt+sUiHd2EGK9uK4ISjzmNYhY\/xKHVcVPG1KsAp63AjdmVWyEMSnGLEo2MKdZ47FwHu0bRqRAFlvy2jnASnDu0EJ8FROJXXS9OknKSccsrp7ub1v5ytsnDCOdOWuDmtPSr5J+CEVfau6PGXBm9FTMK8uO75jPEYFvvaiwCo114kSFdQyq4Qq2bX7isoVfO\/7ngSnDp4EpwEp1w2\/wKwXr4ogA4XsQAAAABJRU5ErkJggg==&quot; border=&quot;0&quot; imatheq-mml=&quot;%3Cmath%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F1998%2FMath%2FMathML%22%3E%3Cmi%20mathvariant%3D%22normal%22%3EA%3C%2Fmi%3E%3Cmo%3E%3D%3C%2Fmo%3E%3Cmfenced%20open%3D%22%5B%22%20close%3D%22%5D%22%3E%3Cmrow%3E%3Cmsub%3E%3Cmi%20mathvariant%3D%22normal%22%3Ea%3C%2Fmi%3E%3Cmi%20mathvariant%3D%22normal%22%3Eij%3C%2Fmi%3E%3C%2Fmsub%3E%3C%2Fmrow%3E%3C%2Fmfenced%3E%3C%2Fmath%3E&quot; \/&gt; for which all &lt;img src=&quot;data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFcAAAAbCAYAAAAJUhN7AAAAAXNSR0IArs4c6QAAArtJREFUaEPt2E3IzlkYx\/GPyAZZIC+lWSAWY7BivI\/yNqWmiBRZkBIm2VhYWXhZmUwTg4iZBRaDUkhRXiJkISUrlCIUWSnvXdN5dHe7n+f5\/+\/n\/39uT\/3P6r7\/nXOd6\/qe37nOdU4vVSuNQK\/SLFeGtRruNMzGLVzCxybWZCBWYR\/eNzG+bUhRdr660Eq4v2MlzmE67mETPucENDItzE94m3Nsbfei7LQc7iBcxXw8QT9cxgo86AKg2qGD0R+PC7KX20y9cmdgBybjJfZiV8btOhTrGnjwCEfrvs\/ENsypUephXMGRnFG0p7jh+CeligM400kcpSp3SFLPatzAKFzAItzPEHAEE9u6vj3E\/rqPv6WUsLjm+9b0e3uGufJs5x\/Tok\/Ff4hFfNpgjlLhDkM4cAoDMAkHsSYpKmfMHXZfhqXoDrhtjsTOOpFS0M\/4UOdhqXD7pq26HM\/SATM3ncSxXTtredLCr1iLUHBbi\/TzArs7mygnlLGIw7Olyl2CDViYTt3euIYtGZWbJy2Mw7+IUuwd\/5eEkRP\/wvmC4H5XOTcUu7EGbqSDPxDqvZtU1nYwhUoXNDiosnLpk\/L5cRzCPOzELLypMxI17M0Oqoj2tnPeaqHUtBDlUCgncuFz\/I0xuI6TBcMNfj+knB6XiNtp695psDpxufgTp9tZuaKgFGXnq5tZLxFxe4n8WJRysyo8+k3ECJzNM6iJvgH3IiZ08TKSG25MHGCjLo02Hntq\/jcRS+Yh63EMrzKPyN8xbnebEeVolJ6f8pv4dkRW5bYSbhFxdmZjSrqCxyEbKbGQVsEtBGNjIxXcCm6JBEo0XSn3O4Bb70J3Vgslhl+u6azKrfVidHoXiMedRk+M5Xrcg6w3AzeK7F9S3fu6B8Xa7a42A7fbneypE1ZwS1y5Cm4Ft0QCJZqulFsi3C\/87p0cCd2jNQAAAABJRU5ErkJggg==&quot; border=&quot;0&quot; imatheq-mml=&quot;%3Cmath%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F1998%2FMath%2FMathML%22%3E%3Cmsub%3E%3Cmi%20mathvariant%3D%22normal%22%3Ea%3C%2Fmi%3E%3Cmi%20mathvariant%3D%22normal%22%3Eij%3C%2Fmi%3E%3C%2Fmsub%3E%3Cmo%3E%3D%3C%2Fmo%3E%3Cmn%3E0%3C%2Fmn%3E%3Cmo%3E%26%23xA0%3B%3C%2Fmo%3E%3Cmo%3E%2C%3C%2Fmo%3E%3Cmo%3E%26%23xA0%3B%3C%2Fmo%3E%3Cmi%20mathvariant%3D%22normal%22%3Ei%3C%2Fmi%3E%3Cmo%3E%26gt%3B%3C%2Fmo%3E%3Cmi%20mathvariant%3D%22normal%22%3Ej%3C%2Fmi%3E%3C%2Fmath%3E&quot; \/&gt; then &lt;img src=&quot;data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAASCAYAAABM8m7ZAAAAAXNSR0IArs4c6QAAAN5JREFUSEvt1LFKQmEYxvHfyYT2bsGtJYdaIhQcHLqBkGhxCLyFcAq6h0JIgrwAcRGiJRC8Am+grVtQig8cDgd1Od\/xNPSuL3z\/9\/\/w8CVKmqQkrl3gc5zhCcvYB24DH2CME1xjvi9wDUO84hS9fYHvUcUz3tHAd0z4pqiP8IlbLDDCBwZFgy\/xgBZWaKOPZsySbTIOZt2MXTjgImbJsuBjzNa2Xyn4I8LuLlbcWXAHN7jCTwoSmj1BPVbJ0uAKpnjBW8bscF24sAtNzz1\/8svMbbXrgX\/jQuNNP15a1L\/z7h8T+NoUkQAAAABJRU5ErkJggg==&quot; border=&quot;0&quot; imatheq-mml=&quot;%3Cmath%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F1998%2FMath%2FMathML%22%3E%3Cmi%20mathvariant%3D%22normal%22%3EA%3C%2Fmi%3E%3C%2Fmath%3E&quot; \/&gt; is called");

  // createDocument() async {
  //   // String chAUr = "A square matrix &lt;img src=&quot;data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEcAAAAnCAYAAABdRFVFAAAAAXNSR0IArs4c6QAAAmFJREFUaEPt2kuoTVEcx\/HP9UpJBggDI2QgoTyK5JWQlAHyigERETNKBlIyk5I884qMECYk5REZipgxUchARgyIVq3b3Y69T\/fsc+6xL2sN997\/tdf\/+\/\/9\/+vR6pBaIYGOxKaYQLvhjMLuzHBe4lITAVqJqRn70FfosyWt3XAm4gTWxdF\/w4cmPBmOQdH+MK7iRhP9\/Wb6N+AcxfxWOZDp5yxuJTj5ZBOcOopLcBKccgUpKScpJymnHIGknHLc2lpzpmMaTuJ7ufH+YRVWyL1+EdgHNzEBq\/EswekiMBbncRGTsT3B6SKwD\/1xCvcwB59yAI3Atpznb3Eh53m9tJqNQ5gR\/3UcYTP5o5uBaUvNGYhH2IDXuIL7OJMzyNojiM5P3sRaVWtSBCfsrh9gE55iDO5iGV5VCU6I4EEsiFFbhP2Y24LCXARnJGbiOgZjCk5jMx5WCU5QSIhgtgVpz8opzK1KqwE4gDV4jxdYiI1VgjMUT6Jq3mXohFoQ3m2tgdaqtFqBHViCr+iLx9hTJThrsR5L8TMDIsxYt6Pc8wpzN5WvKK2CYnZm4IR0OhLV8xzLMwU+qHVxTsHv0YIconUH53C5xtt+sUiHd2EGK9uK4ISjzmNYhY\/xKHVcVPG1KsAp63AjdmVWyEMSnGLEo2MKdZ47FwHu0bRqRAFlvy2jnASnDu0EJ8FROJXXS9OknKSccsrp7ub1v5ytsnDCOdOWuDmtPSr5J+CEVfau6PGXBm9FTMK8uO75jPEYFvvaiwCo114kSFdQyq4Qq2bX7isoVfO\/7ngSnDp4EpwEp1w2\/wKwXr4ogA4XsQAAAABJRU5ErkJggg==&quot; border=&quot;0&quot; imatheq-mml=&quot;%3Cmath%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F1998%2FMath%2FMathML%22%3E%3Cmi%20mathvariant%3D%22normal%22%3EA%3C%2Fmi%3E%3Cmo%3E%3D%3C%2Fmo%3E%3Cmfenced%20open%3D%22%5B%22%20close%3D%22%5D%22%3E%3Cmrow%3E%3Cmsub%3E%3Cmi%20mathvariant%3D%22normal%22%3Ea%3C%2Fmi%3E%3Cmi%20mathvariant%3D%22normal%22%3Eij%3C%2Fmi%3E%3C%2Fmsub%3E%3C%2Fmrow%3E%3C%2Fmfenced%3E%3C%2Fmath%3E&quot; \/&gt; for which all &lt;img src=&quot;data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFcAAAAbCAYAAAAJUhN7AAAAAXNSR0IArs4c6QAAArtJREFUaEPt2E3IzlkYx\/GPyAZZIC+lWSAWY7BivI\/yNqWmiBRZkBIm2VhYWXhZmUwTg4iZBRaDUkhRXiJkISUrlCIUWSnvXdN5dHe7n+f5\/+\/n\/39uT\/3P6r7\/nXOd6\/qe37nOdU4vVSuNQK\/SLFeGtRruNMzGLVzCxybWZCBWYR\/eNzG+bUhRdr660Eq4v2MlzmE67mETPucENDItzE94m3Nsbfei7LQc7iBcxXw8QT9cxgo86AKg2qGD0R+PC7KX20y9cmdgBybjJfZiV8btOhTrGnjwCEfrvs\/ENsypUephXMGRnFG0p7jh+CeligM400kcpSp3SFLPatzAKFzAItzPEHAEE9u6vj3E\/rqPv6WUsLjm+9b0e3uGufJs5x\/Tok\/Ff4hFfNpgjlLhDkM4cAoDMAkHsSYpKmfMHXZfhqXoDrhtjsTOOpFS0M\/4UOdhqXD7pq26HM\/SATM3ncSxXTtredLCr1iLUHBbi\/TzArs7mygnlLGIw7Olyl2CDViYTt3euIYtGZWbJy2Mw7+IUuwd\/5eEkRP\/wvmC4H5XOTcUu7EGbqSDPxDqvZtU1nYwhUoXNDiosnLpk\/L5cRzCPOzELLypMxI17M0Oqoj2tnPeaqHUtBDlUCgncuFz\/I0xuI6TBcMNfj+knB6XiNtp695psDpxufgTp9tZuaKgFGXnq5tZLxFxe4n8WJRysyo8+k3ECJzNM6iJvgH3IiZ08TKSG25MHGCjLo02Hntq\/jcRS+Yh63EMrzKPyN8xbnebEeVolJ6f8pv4dkRW5bYSbhFxdmZjSrqCxyEbKbGQVsEtBGNjIxXcCm6JBEo0XSn3O4Bb70J3Vgslhl+u6azKrfVidHoXiMedRk+M5Xrcg6w3AzeK7F9S3fu6B8Xa7a42A7fbneypE1ZwS1y5Cm4Ft0QCJZqulFsi3C\/87p0cCd2jNQAAAABJRU5ErkJggg==&quot; border=&quot;0&quot; imatheq-mml=&quot;%3Cmath%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F1998%2FMath%2FMathML%22%3E%3Cmsub%3E%3Cmi%20mathvariant%3D%22normal%22%3Ea%3C%2Fmi%3E%3Cmi%20mathvariant%3D%22normal%22%3Eij%3C%2Fmi%3E%3C%2Fmsub%3E%3Cmo%3E%3D%3C%2Fmo%3E%3Cmn%3E0%3C%2Fmn%3E%3Cmo%3E%26%23xA0%3B%3C%2Fmo%3E%3Cmo%3E%2C%3C%2Fmo%3E%3Cmo%3E%26%23xA0%3B%3C%2Fmo%3E%3Cmi%20mathvariant%3D%22normal%22%3Ei%3C%2Fmi%3E%3Cmo%3E%26gt%3B%3C%2Fmo%3E%3Cmi%20mathvariant%3D%22normal%22%3Ej%3C%2Fmi%3E%3C%2Fmath%3E&quot; \/&gt; then &lt;img src=&quot;data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAASCAYAAABM8m7ZAAAAAXNSR0IArs4c6QAAAN5JREFUSEvt1LFKQmEYxvHfyYT2bsGtJYdaIhQcHLqBkGhxCLyFcAq6h0JIgrwAcRGiJRC8Am+grVtQig8cDgd1Od\/xNPSuL3z\/9\/\/w8CVKmqQkrl3gc5zhCcvYB24DH2CME1xjvi9wDUO84hS9fYHvUcUz3tHAd0z4pqiP8IlbLDDCBwZFgy\/xgBZWaKOPZsySbTIOZt2MXTjgImbJsuBjzNa2Xyn4I8LuLlbcWXAHN7jCTwoSmj1BPVbJ0uAKpnjBW8bscF24sAtNzz1\/8svMbbXrgX\/jQuNNP15a1L\/z7h8T+NoUkQAAAABJRU5ErkJggg==&quot; border=&quot;0&quot; imatheq-mml=&quot;%3Cmath%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F1998%2FMath%2FMathML%22%3E%3Cmi%20mathvariant%3D%22normal%22%3EA%3C%2Fmi%3E%3C%2Fmath%3E&quot; \/&gt; is called";
  //   // Get the documents directory
  //   Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   String filePath = '${documentsDirectory.path}/example.pdf'; // Full path to the PDF file
  //
  //   final file = File(filePath);
  //   final newpdf = Document();
  //   final List<Widget> widgets = await HTMLToPdf().convert(chAUr);
  //   widgets.add(Text("text"));
  //   widgets.add(Text("text"));
  //   widgets.add(Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children:
  //   [
  //     Text("text"),
  //     Text("text"),
  //     Text("text"),
  //     Text("text"),
  //
  //   ]));
  //
  //   newpdf.addPage(MultiPage(
  //     pageTheme: PageTheme(
  //         pageFormat: PdfPageFormat.a4,
  //       buildBackground: (context){
  //           return Text("text");
  //       }
  //     ),
  //       maxPages: 200,
  //       build: (context) {
  //         return widgets;
  //       }));
  //   await file.writeAsBytes(await newpdf.save());
  //   print('PDF saved to $filePath'); // Optional: print the path where PDF is saved
  //
  //   // Open the PDF file
  //   OpenFile.open(filePath);
  // }







  Future<void> generateExampleDocument() async {
    String generatedPdfFilePath;

    // Get the application documents directory
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final targetPath = appDocDir.path;
    final targetFileName = "example-pdf";

    // Generate the PDF file
    final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
      ConstString.html,
      // chAUr,
      targetPath,
      targetFileName,
    );

    // Store the file path
    generatedPdfFilePath = generatedPdfFile.path;

    // Log the generated PDF file path
    print('PDF generated at: $generatedPdfFilePath');

    // Open the generated PDF file
    OpenFile.open(generatedPdfFilePath);
  }

}




class ConstString{
  static String html =
      """
        
<!DOCTYPE html>
<html>

<head>
    <noscript>
        <meta http-equiv="refresh" content="0; URL=./401-page.php">
    </noscript>
    <title>
        Direct Paper Access - Web App </title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel='stylesheet' href="https://easyautopaper.com//bootstrap/css/bootstrap.min.css">
    <link rel='stylesheet' href="https://easyautopaper.com//plugins/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel='stylesheet' href="https://easyautopaper.com//dist/css/AdminLTE.min.css">
    <link rel='stylesheet' href="https://easyautopaper.com//dist/css/skins/_all-skins.min.css">
    <link rel='stylesheet' href="https://easyautopaper.com//plugins/daterangepicker/daterangepicker.css">
    <link rel='stylesheet' href="https://easyautopaper.com//plugins/datepicker/datepicker3.css">
    <link rel='stylesheet' href="https://easyautopaper.com//plugins/select2/select2.min.css">
    <link rel='stylesheet' href="https://easyautopaper.com//dist/paginate/pagination-styles.css">
    <link rel='stylesheet' href="https://easyautopaper.com//dist/helper.css">
    <link rel='stylesheet' href="https://easyautopaper.com//dist/custom.css">




    <script type="text/javascript" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.4/MathJax.js"></script>

    <!--<script type="text/javascript" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.4/MathJax.js?config=TeX-MML-AM_CHTML"></script>-->


    <script type="text/x-mathjax-config">

        MathJax.Ajax.config.path["arabic"] = "https://cdn.rawgit.com/Edraak/arabic-mathjax/v1.0/dist";

MathJax.Hub.Config({
  jax: ["input/MathML","output/PreviewHTML"],
  extensions: ["mml2jax.js","MathMenu.js","MathZoom.js", "fast-preview.js", "AssistiveMML.js", "a11y/accessibility-menu.js","[arabic]/arabic.js"],
  showProcessingMessages: true,
  CommonHTML: { linebreaks: { automatic: true,width:"98% container" } },
  PreviewHTML: { linebreaks: { automatic: true,width:"98% container" } },
  "HTML-CSS": { linebreaks: { automatic: true,width:"98% container" } },
         SVG: { linebreaks: { automatic: true,width:"98% container" } }
});

</script>
    <!--
old in use
<script type="text/x-mathjax-config">
    MathJax.Hub.Config({
    "HTML-CSS": {matchFontHeight: false,undefinedFamily: 'Amiri'},
     SVG: {matchFontHeight: false},
    CommonHTML: {
     linebreaks: { automatic: false }
     },
    styles: {
        ".math-jx": {
           "font-style": "normal",
           "font-size": "12px",
           "font-family": "Arial, Helvetica, sans-serif ",
 },

}
   });


</script>
-->


    <!--
old IN USE
<script type="text/x-mathjax-config">
if (MathJax.Hub.Browser.isChrome && MathJax.Hub.Browser.version.substr(0,3) === "32.") {
  MathJax.Hub.Register.StartupHook("HTML-CSS Jax Config", function () {
    MathJax.OutputJax["HTML-CSS"].FontFaceBug = true;
  });
}

</script>-->
    <link rel='stylesheet' href="https://easyautopaper.com//dist/question-paper.css">

</head>
<!--<body class="qp-body " oncontextmenu="return false">-->

<body class="qp-body">


    <div class='qp-wrapper'>
        <!--    <div class="qp-content page-break-after qp-watermark" style=" background:!important;"> -->
        <div class="qp-content qp-watermark"
            style=" background: url(https://papergen.easyautopaper.com/uploads/watermarks/coid_10.png) !important;">
            <div class="col-xs-6">
                <span data-toggle="tooltip" title="Version V1" data-placement="bottom"><i class="fa fa-star"></i></span>
            </div>
            <div class="col-xs-6 hidden-print text-right">
                <span class="fa fa-exchange"></span>
                <span data-toggle="tooltip" title="Template" data-placement="bottom" class="hidden-print">English</span>
                | <a href="#!" class="cloneqp"><span class="fa fa-copy"></span> Clone</a> | <a href="#!"
                    class="removeqp"><span class="fa fa-remove"></span> Remove</a>
            </div>
            <div class="clearfix"></div>

            <!-- Paper  headerLevel -->
            <div class="qp-header">
                <div class='pn col-xs-12  ph-english '>
                    <div class='' style=''> </div>
                </div>
                <div class='clearfix'></div>
                <div class='pn col-xs-12 text-center'><img src='../uploads/company/logo_logo_albaghdad_0.png' alt='' class='text-center' style='width:50px;height:50px; ' >
                </div>
                <div class='clearfix'></div>
                <div class='pn col-xs-12 text-center'>
                    <div class='text-center' style='font-size: 25px; font-family: algerian; font-weight: bold;'>
                        AL-BAGHDAD ACADEMY </div>
                </div>
                <div class='clearfix'></div>
                <div class='pn col-xs-12 text-center'>
                    <div contenteditable='true' class='text-center'
                        style='font-size: 20px; font-family: calibri; font-weight: bold;'> pakistan</div>
                </div>
                <div class='clearfix'></div>
                <div class='pn col-xs-4 text-left ph-english '>
                    <div data-clstitle dir='ltr' class='text-left' style=''> CLASS 11 </div>
                </div>
                <div class='pn col-xs-4 text-left'>
                    <div data-sjtitle dir='ltr' class='text-left' style=''>SUBJECT: ENGLISH </div>
                </div>
                <div class='pn col-xs-4 text-left'>
                    <div class='text-left' style=''>CHAPTERS: All Chapters</div>
                </div>
                <div class='clearfix'></div>
                <div class='pn col-xs-4 text-left ph-english '>
                    <div contenteditable='true' class='text-left' style=''>TOTAL MARKS: 100</div>
                </div>
                <div class='pn col-xs-4 text-left'>
                    <span contenteditable='true'  class='text-left'  style=''  >PASSING MARKS: 33</span></div>
                <div class='pn col-xs-4 text-left'>
                    <div contenteditable='true' class='text-left' style=''>TOTAL TIME : 03:00</div>
                </div>
                <div class='clearfix'></div>
                <div class='pn col-xs-4 text-left ph-english '>
                    <span contenteditable='true'  class='text-left'  style='font-weight: bold;'  >STUDENT&#039;S NAME: _____________</span>
                </div>
                <div class='pn col-xs-4 text-left'><span data-date>10-10-24</span></div>
                <div class='pn col-xs-4 text-left'>
                    <span contenteditable='true'  class='text-left'  style='font-weight: bold;'  >ID /ROLL NO: __________</span>
                </div>
                <div class='clearfix'></div>
            </div>
            <div class='section section_mcq sh-english'>
                <div class='pn  col-xs-12 text-center'>
                    <div contenteditable='true' class='text-center'
                        style='font-size: 18px; font-family: arial black; font-weight: normal;'> OBJECTIVE TYPE</div>
                </div>
            </div>
            <div class='section section_mcq sh-english'>
                <div class='pn col-xs-8 text-left'>
                    <div contenteditable='true' class='text-left' style='font-size: 16px; font-weight: bold;'>Q No.1 a-
                        Choose the right option of the underlined words in meaning and fill up the bubbles. (Book I:
                        short stories, Book III: plays and poetry)</div>
                </div>
                <div class='pn  col-xs-4 text-left english'>
                    <div contenteditable='true' class='text-left english' style='font-size: 16px;font-weight: bold;'>
                        (1&nbsp;Marks/Q)</div>
                </div>
            </div>
            <div class='section section_mcq'>
                <div class='clearfix'></div>
                <table class='mcq-table'>
                    <tr>
                        <td class='mcq-stmt' contenteditable='true' colspan='8'>
                            <span contenteditable='true'>i</span><span class='mcq-bubble hidden'>

                <div class="stacked-icons-eng ">
                  <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">A</strong>
                  </span>
                            <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">B</strong>
                  </span>
                            <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">C</strong>
                  </span>
                            <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">D</strong>
                  </span>
                            <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">E</strong>
                  </span>
            </div>

            </span><span class='mcq-stmt-bubble'>&nbsp;- Without his love Bullah is in <u>loss</u>. </span></td>
            </tr>
            <tr class=' mcq-option-row'>
                <td class='mcq-option mcq-option-td-first'><span class='mcq-option-ans'>a)</span></td>
                <td contenteditable='true' class='mcq-option-stmt'>Harm</td>
                <td class='mcq-option'><span class=''><span class=''>b)</span></span></td>
                <td contenteditable='true' class='mcq-option-stmt'>Virtue</td>
                <td class='mcq-option '><span class=''>c)</span></td>
                <td contenteditable='true' class='mcq-option-stmt'>Goodliness</td>
                <td class='mcq-option'><span class=''>d)</span></td>
                <td contenteditable='true' class='mcq-option-stmt'>Storage</td>
            </tr>
            </table>
            <div class='clearfix'></div>
            <table class='mcq-table'>
                <tr>
                    <td class='mcq-stmt' contenteditable='true' colspan='8'> <span contenteditable='true'>ii</span><span class='mcq-bubble hidden'>

                <div class="stacked-icons-eng ">
                  <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">A</strong>
                  </span>
                        <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">B</strong>
                  </span>
                        <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">C</strong>
                  </span>
                        <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">D</strong>
                  </span>
                        <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">E</strong>
                  </span>
        </div>

        </span><span class='mcq-stmt-bubble'>&nbsp;- It looked as if the sun is packed in a <u>pitted</u> skin. </span>
        </td>
        </tr>
        <tr class=' mcq-option-row'>
            <td class='mcq-option mcq-option-td-first'><span class=''>a)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Clean</td>
            <td class='mcq-option'><span class=''><span class='mcq-option-ans'>b)</span></span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Spotted</td>
            <td class='mcq-option '><span class=''>c)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Painted</td>
            <td class='mcq-option'><span class=''>d)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Embellished</td>
        </tr>
        </table>
        <div class='clearfix'></div>
        <table class='mcq-table'>
            <tr>
                <td class='mcq-stmt' contenteditable='true' colspan='8'> <span contenteditable='true'>iii</span><span class='mcq-bubble hidden'>

                <div class="stacked-icons-eng ">
                  <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">A</strong>
                  </span>
                    <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">B</strong>
                  </span>
                    <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">C</strong>
                  </span>
                    <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">D</strong>
                  </span>
                    <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">E</strong>
                  </span>
    </div>

    </span><span class='mcq-stmt-bubble'>&nbsp;- Mehrun was put in seclusion till the <u>auspicious</u> day. </span>
    </td>
    </tr>
    <tr class=' mcq-option-row'>
        <td class='mcq-option mcq-option-td-first'><span class=''>a)</span></td>
        <td contenteditable='true' class='mcq-option-stmt'>Wrathful</td>
        <td class='mcq-option'><span class=''><span class=''>b)</span></span></td>
        <td contenteditable='true' class='mcq-option-stmt'>Shocking</td>
        <td class='mcq-option '><span class=''>c)</span></td>
        <td contenteditable='true' class='mcq-option-stmt'>Sad</td>
        <td class='mcq-option'><span class='mcq-option-ans'>d)</span></td>
        <td contenteditable='true' class='mcq-option-stmt'>Hopeful</td>
    </tr>
    </table>
    <div class='clearfix'></div>
    <table class='mcq-table'>
        <tr>
            <td class='mcq-stmt' contenteditable='true' colspan='8'> <span contenteditable='true'>iv</span><span class='mcq-bubble hidden'>

                <div class="stacked-icons-eng ">
                  <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">A</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">B</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">C</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">D</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">E</strong>
                  </span>
                </div>

                </span><span class='mcq-stmt-bubble'>&nbsp;- The shattered visage has a frown and <u>wrinkled </u>lip. </span>
            </td>
        </tr>
        <tr class=' mcq-option-row'>
            <td class='mcq-option mcq-option-td-first'><span class=''>a)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Wounded</td>
            <td class='mcq-option'><span class=''><span class='mcq-option-ans'>b)</span></span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Folded</td>
            <td class='mcq-option '><span class=''>c)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Balmy</td>
            <td class='mcq-option'><span class=''>d)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Crimson</td>
        </tr>
    </table>
    <div class='clearfix'></div>
    <table class='mcq-table'>
        <tr>
            <td class='mcq-stmt' contenteditable='true' colspan='8'> <span contenteditable='true'>v</span><span class='mcq-bubble hidden'>

                <div class="stacked-icons-eng ">
                  <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">A</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">B</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">C</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">D</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">E</strong>
                  </span>
                </div>

                </span><span class='mcq-stmt-bubble'>&nbsp;- The girl clawed <u>instinctively</u> for the doctor&#039;s eyes. </span>
            </td>
        </tr>
        <tr class=' mcq-option-row'>
            <td class='mcq-option mcq-option-td-first'><span class=''>a)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Audaciously</td>
            <td class='mcq-option'><span class=''><span class=''>b)</span></span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Boldly</td>
            <td class='mcq-option '><span class=''>c)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Spontaneously</td>
            <td class='mcq-option'><span class='mcq-option-ans'>d)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Automaticlly</td>
        </tr>
    </table>
    <div class='clearfix'></div>
    <table class='mcq-table'>
        <tr>
            <td class='mcq-stmt' contenteditable='true' colspan='8'> <span contenteditable='true'>vi</span><span class='mcq-bubble hidden'>

                <div class="stacked-icons-eng ">
                  <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">A</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">B</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">C</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">D</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">E</strong>
                  </span>
                </div>

                </span><span class='mcq-stmt-bubble'>&nbsp;- All the <u>grills</u> were wasteful. </span>
            </td>
        </tr>
        <tr class=' mcq-option-row'>
            <td class='mcq-option mcq-option-td-first'><span class=''>a)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Children</td>
            <td class='mcq-option'><span class=''><span class=''>b)</span></span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Men</td>
            <td class='mcq-option '><span class=''>c)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Girls</td>
            <td class='mcq-option'><span class='mcq-option-ans'>d)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Broiler</td>
        </tr>
    </table>
    <div class='clearfix'></div>
    <table class='mcq-table'>
        <tr>
            <td class='mcq-stmt' contenteditable='true' colspan='8'> <span contenteditable='true'>vii</span><span class='mcq-bubble hidden'>

                <div class="stacked-icons-eng ">
                  <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">A</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">B</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">C</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">D</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">E</strong>
                  </span>
                </div>

                </span><span class='mcq-stmt-bubble'>&nbsp;- Get the kettle going. It is <u>thirsty work</u> . </span>
            </td>
        </tr>
        <tr class=' mcq-option-row'>
            <td class='mcq-option mcq-option-td-first'><span class='mcq-option-ans'>a)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Hard work</td>
            <td class='mcq-option'><span class=''><span class=''>b)</span></span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Important work</td>
            <td class='mcq-option '><span class=''>c)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Critical work</td>
            <td class='mcq-option'><span class=''>d)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Mysterious work</td>
        </tr>
    </table>
    <div class='clearfix'></div>
    <table class='mcq-table'>
        <tr>
            <td class='mcq-stmt' contenteditable='true' colspan='8'> <span contenteditable='true'>viii</span><span class='mcq-bubble hidden'>

                <div class="stacked-icons-eng ">
                  <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">A</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">B</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">C</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">D</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">E</strong>
                  </span>
                </div>

                </span><span class='mcq-stmt-bubble'>&nbsp;- The Muslim&#039;s hearts are <u>perplexed</u>. </span>
            </td>
        </tr>
        <tr class=' mcq-option-row'>
            <td class='mcq-option mcq-option-td-first'><span class=''>a)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Overjoyed</td>
            <td class='mcq-option'><span class=''><span class=''>b)</span></span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Pleased</td>
            <td class='mcq-option '><span class='mcq-option-ans'>c)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Upset</td>
            <td class='mcq-option'><span class=''>d)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Satisfied</td>
        </tr>
    </table>
    <div class='clearfix'></div>
    <table class='mcq-table'>
        <tr>
            <td class='mcq-stmt' contenteditable='true' colspan='8'> <span contenteditable='true'>ix</span><span class='mcq-bubble hidden'>

                <div class="stacked-icons-eng ">
                  <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">A</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">B</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">C</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">D</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">E</strong>
                  </span>
                </div>

                </span><span class='mcq-stmt-bubble'>&nbsp;- Gentle <u>applause</u> broke out form every hand for Gorgios. </span>
            </td>
        </tr>
        <tr class=' mcq-option-row'>
            <td class='mcq-option mcq-option-td-first'><span class=''>a)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Curse</td>
            <td class='mcq-option'><span class=''><span class=''>b)</span></span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Dislike</td>
            <td class='mcq-option '><span class='mcq-option-ans'>c)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Clapping</td>
            <td class='mcq-option'><span class=''>d)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Abuse</td>
        </tr>
    </table>
    <div class='clearfix'></div>
    <table class='mcq-table'>
        <tr>
            <td class='mcq-stmt' contenteditable='true' colspan='8'> <span contenteditable='true'>x</span><span class='mcq-bubble hidden'>

                <div class="stacked-icons-eng ">
                  <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">A</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">B</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">C</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">D</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">E</strong>
                  </span>
                </div>

                </span><span class='mcq-stmt-bubble'>&nbsp;- I am not <u>unmindful</u>. </span>
            </td>
        </tr>
        <tr class=' mcq-option-row'>
            <td class='mcq-option mcq-option-td-first'><span class=''>a)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Knowing</td>
            <td class='mcq-option'><span class=''><span class=''>b)</span></span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Undaunted</td>
            <td class='mcq-option '><span class='mcq-option-ans'>c)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Unaware</td>
            <td class='mcq-option'><span class=''>d)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Unearned</td>
        </tr>
    </table>
    </div>
    <div class='section section_mcq sh-english'>
        <div class='pn  col-xs-12 text-center'></div>
    </div>
    <div class='section section_mcq sh-english'>
        <div class='pn col-xs-8 text-left'>
            <div contenteditable='true' class='text-left' style='font-size: 16px; font-weight: bold;'> b- Choose the
                right option for the followings and fill up the bubbles.</div>
        </div>
        <div class='pn  col-xs-4 text-left english'></div>
    </div>
    <div class='section section_mcq'>
        <div class='clearfix'></div>
        <table class='mcq-table'>
            <tr>
                <td class='mcq-stmt' contenteditable='true' colspan='8'> <span contenteditable='true'>xi</span><span class='mcq-bubble hidden'>

                <div class="stacked-icons-eng ">
                  <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">A</strong>
                  </span>
                    <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">B</strong>
                  </span>
                    <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">C</strong>
                  </span>
                    <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">D</strong>
                  </span>
                    <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">E</strong>
                  </span>
    </div>

    </span><span class='mcq-stmt-bubble'>&nbsp;- What would the court acrobat do in the court? </span></td>
    </tr>
    <tr class=' mcq-option-row'>
        <td class='mcq-option mcq-option-td-first'><span class=''>a)</span></td>
        <td contenteditable='true' class='mcq-option-stmt'>Entertain the queen</td>
        <td class='mcq-option'><span class=''><span class='mcq-option-ans'>b)</span></span></td>
        <td contenteditable='true' class='mcq-option-stmt'>Exhibit physical fitness</td>
        <td class='mcq-option '><span class=''>c)</span></td>
        <td contenteditable='true' class='mcq-option-stmt'>Amuse the king</td>
        <td class='mcq-option'><span class=''>d)</span></td>
        <td contenteditable='true' class='mcq-option-stmt'>Make jokes</td>
    </tr>
    </table>
    <div class='clearfix'></div>
    <table class='mcq-table'>
        <tr>
            <td class='mcq-stmt' contenteditable='true' colspan='8'> <span contenteditable='true'>xii</span><span class='mcq-bubble hidden'>

                <div class="stacked-icons-eng ">
                  <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">A</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">B</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">C</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">D</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">E</strong>
                  </span>
                </div>

                </span><span class='mcq-stmt-bubble'>&nbsp;- Through love vinegar becomes--------. </span>
            </td>
        </tr>
        <tr class=' mcq-option-row'>
            <td class='mcq-option mcq-option-td-first'><span class=''>a)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Sour juice</td>
            <td class='mcq-option'><span class=''><span class=''>b)</span></span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Sour wine</td>
            <td class='mcq-option '><span class=''>c)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Bitter wine</td>
            <td class='mcq-option'><span class='mcq-option-ans'>d)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Sweet wine</td>
        </tr>
    </table>
    <div class='clearfix'></div>
    <table class='mcq-table'>
        <tr>
            <td class='mcq-stmt' contenteditable='true' colspan='8'> <span contenteditable='true'>xiii</span><span class='mcq-bubble hidden'>

                <div class="stacked-icons-eng ">
                  <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">A</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">B</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">C</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">D</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">E</strong>
                  </span>
                </div>

                </span><span class='mcq-stmt-bubble'>&nbsp;- Cherry tree glorifies _____. </span>
            </td>
        </tr>
        <tr class=' mcq-option-row'>
            <td class='mcq-option mcq-option-td-first'><span class=''>a)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>the life</td>
            <td class='mcq-option'><span class=''><span class='mcq-option-ans'>b)</span></span></td>
            <td contenteditable='true' class='mcq-option-stmt'>mind and thought</td>
            <td class='mcq-option '><span class=''>c)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>the city</td>
            <td class='mcq-option'><span class=''>d)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>the environment</td>
        </tr>
    </table>
    <div class='clearfix'></div>
    <table class='mcq-table'>
        <tr>
            <td class='mcq-stmt' contenteditable='true' colspan='8'> <span contenteditable='true'>xiv</span><span class='mcq-bubble hidden'>

                <div class="stacked-icons-eng ">
                  <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">A</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">B</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">C</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">D</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">E</strong>
                  </span>
                </div>

                </span><span class='mcq-stmt-bubble'>&nbsp;- The tree of the cherry is the loveliest in _____. </span>
            </td>
        </tr>
        <tr class=' mcq-option-row'>
            <td class='mcq-option mcq-option-td-first'><span class=''>a)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>winter</td>
            <td class='mcq-option'><span class=''><span class='mcq-option-ans'>b)</span></span></td>
            <td contenteditable='true' class='mcq-option-stmt'>spring</td>
            <td class='mcq-option '><span class=''>c)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>summer</td>
            <td class='mcq-option'><span class=''>d)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>autumn</td>
        </tr>
    </table>
    <div class='clearfix'></div>
    <table class='mcq-table'>
        <tr>
            <td class='mcq-stmt' contenteditable='true' colspan='8'> <span contenteditable='true'>xv</span><span class='mcq-bubble hidden'>

                <div class="stacked-icons-eng ">
                  <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">A</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">B</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">C</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">D</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">E</strong>
                  </span>
                </div>

                </span><span class='mcq-stmt-bubble'>&nbsp;- Three score years and ten are _____. </span>
            </td>
        </tr>
        <tr class=' mcq-option-row'>
            <td class='mcq-option mcq-option-td-first'><span class=''>a)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>forty years</td>
            <td class='mcq-option'><span class=''><span class=''>b)</span></span></td>
            <td contenteditable='true' class='mcq-option-stmt'>fifty years</td>
            <td class='mcq-option '><span class=''>c)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>sixty years</td>
            <td class='mcq-option'><span class='mcq-option-ans'>d)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>seventy years</td>
        </tr>
    </table>
    </div>
    <div class='section section_mcq sh-english'>
        <div class='pn  col-xs-12 text-center'></div>
    </div>
    <div class='section section_mcq sh-english'>
        <div class='pn col-xs-8 text-left'>
            <div contenteditable='true' class='text-left' style='font-size: 16px; font-weight: bold;'> c- Choose the
                correct form of verb and fill up the bubbles.</div>
        </div>
        <div class='pn  col-xs-4 text-left english'></div>
    </div>
    <div class='section section_mcq'>
        <div class='clearfix'></div>
        <table class='mcq-table'>
            <tr>
                <td class='mcq-stmt' contenteditable='true' colspan='8'> <span contenteditable='true'>xvi</span><span class='mcq-bubble hidden'>

                <div class="stacked-icons-eng ">
                  <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">A</strong>
                  </span>
                    <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">B</strong>
                  </span>
                    <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">C</strong>
                  </span>
                    <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">D</strong>
                  </span>
                    <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">E</strong>
                  </span>
    </div>

    </span><span class='mcq-stmt-bubble'>&nbsp;- The snow .......... in the sun. </span></td>
    </tr>
    <tr class=' mcq-option-row'>
        <td class='mcq-option mcq-option-td-first'><span class=''>a)</span></td>
        <td contenteditable='true' class='mcq-option-stmt'>Melt</td>
        <td class='mcq-option'><span class=''><span class='mcq-option-ans'>b)</span></span></td>
        <td contenteditable='true' class='mcq-option-stmt'>Melts</td>
        <td class='mcq-option '><span class=''>c)</span></td>
        <td contenteditable='true' class='mcq-option-stmt'>Do not melts</td>
        <td class='mcq-option'><span class=''>d)</span></td>
        <td contenteditable='true' class='mcq-option-stmt'>Does not melts</td>
    </tr>
    </table>
    <div class='clearfix'></div>
    <table class='mcq-table'>
        <tr>
            <td class='mcq-stmt' contenteditable='true' colspan='8'> <span contenteditable='true'>xvii</span><span class='mcq-bubble hidden'>

                <div class="stacked-icons-eng ">
                  <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">A</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">B</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">C</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">D</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">E</strong>
                  </span>
                </div>

                </span><span class='mcq-stmt-bubble'>&nbsp;- I .......... you to mend your behaviour ever since I came here. </span>
            </td>
        </tr>
        <tr class=' mcq-option-row'>
            <td class='mcq-option mcq-option-td-first'><span class=''>a)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Asked</td>
            <td class='mcq-option'><span class=''><span class=''>b)</span></span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Ask</td>
            <td class='mcq-option '><span class=''>c)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Have been asked</td>
            <td class='mcq-option'><span class='mcq-option-ans'>d)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Have been asking</td>
        </tr>
    </table>
    <div class='clearfix'></div>
    <table class='mcq-table'>
        <tr>
            <td class='mcq-stmt' contenteditable='true' colspan='8'> <span contenteditable='true'>xviii</span><span class='mcq-bubble hidden'>

                <div class="stacked-icons-eng ">
                  <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">A</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">B</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">C</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">D</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">E</strong>
                  </span>
                </div>

                </span><span class='mcq-stmt-bubble'>&nbsp;- You .......... a shock when you open that box. </span>
            </td>
        </tr>
        <tr class=' mcq-option-row'>
            <td class='mcq-option mcq-option-td-first'><span class=''>a)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Had got</td>
            <td class='mcq-option'><span class=''><span class=''>b)</span></span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Got</td>
            <td class='mcq-option '><span class=''>c)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Has got</td>
            <td class='mcq-option'><span class='mcq-option-ans'>d)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Will get</td>
        </tr>
    </table>
    <div class='clearfix'></div>
    <table class='mcq-table'>
        <tr>
            <td class='mcq-stmt' contenteditable='true' colspan='8'> <span contenteditable='true'>xix</span><span class='mcq-bubble hidden'>

                <div class="stacked-icons-eng ">
                  <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">A</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">B</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">C</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">D</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">E</strong>
                  </span>
                </div>

                </span><span class='mcq-stmt-bubble'>&nbsp;- I asked if he .......... the exam. </span>
            </td>
        </tr>
        <tr class=' mcq-option-row'>
            <td class='mcq-option mcq-option-td-first'><span class=''>a)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Takes</td>
            <td class='mcq-option'><span class=''><span class='mcq-option-ans'>b)</span></span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Had taken</td>
            <td class='mcq-option '><span class=''>c)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Have taken</td>
            <td class='mcq-option'><span class=''>d)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Will take</td>
        </tr>
    </table>
    <div class='clearfix'></div>
    <table class='mcq-table'>
        <tr>
            <td class='mcq-stmt' contenteditable='true' colspan='8'> <span contenteditable='true'>xx</span><span class='mcq-bubble hidden'>

                <div class="stacked-icons-eng ">
                  <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">A</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">B</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">C</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">D</strong>
                  </span>
                <span class="fa-stack-eng">
                    <i class="fa fa-circle-o fa-stack-2x"></i>
                    <strong class="fa-stack fa-stack-text">E</strong>
                  </span>
                </div>

                </span><span class='mcq-stmt-bubble'>&nbsp;- When i saw him he .......... a portrait of his wife. </span>
            </td>
        </tr>
        <tr class=' mcq-option-row'>
            <td class='mcq-option mcq-option-td-first'><span class='mcq-option-ans'>a)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Was drawing</td>
            <td class='mcq-option'><span class=''><span class=''>b)</span></span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Has drawn</td>
            <td class='mcq-option '><span class=''>c)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Will draw</td>
            <td class='mcq-option'><span class=''>d)</span></td>
            <td contenteditable='true' class='mcq-option-stmt'>Can draw</td>
        </tr>
    </table>
    </div>
    <div class='section section_short sh-english'>
        <div class='pn  col-xs-12 text-center'>
            <div contenteditable='true' class='text-center'
                style='font-size: 18px; font-family: arial black; font-weight: normal;'> SUBJECTIVE TYPE (SECTION I)
            </div>
        </div>
    </div>
    <div class='section section_short sh-english'>
        <div class='pn col-xs-8 text-left'>
            <div contenteditable='true' class='text-left' style='font-size: 16px; font-weight: bold;'>Q No.2 Answer (in
                3-5 lines/ sentences) any SIX of the following questions from Book-I (short stories):</div>
        </div>
        <div class='pn  col-xs-4 text-left english'>
            <div contenteditable='true' class='text-left english' style='font-size: 16px;font-weight: bold;'>
                (2&nbsp;Marks/Q)</div>
        </div>
    </div>
    <div class='section section_short'>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>i</span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <span>What accusation did the Mayor make against Hubert?</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>ii</span></td>
                <td contenteditable='true' class='lq-stmt wspree '><span>Who was Martin Luther King?</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>iii</span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <span>What did Terbut think of Jorkens&#039; argument?</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>iv</span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <span>Did Gorgios use any short cut to achieve his ambition?</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>v</span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <span>What do you understand by the phrase "to thin corn"? When was Jess brought to the filed to thin corn? Why was Jess brought to the field at the age of six?</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>vi</span></td>
                <td contenteditable='true' class='lq-stmt wspree '><span>What report did lieutenant give?</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>vii</span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <span>How much did the Maulvi collect on every Eid?</span> <strong contenteditable='true' ></strong>
                </td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>viii</span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <span>What happened to the king after he had allowed the boy to go?</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>ix</span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <span>Who stepped  out of the control room of the rocket?</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
    </div>
    <div class='section section_short sh-english'>
        <div class='pn  col-xs-12 text-center'></div>
    </div>
    <div class='section section_short sh-english'>
        <div class='pn col-xs-8 text-left'>
            <div contenteditable='true' class='text-left' style='font-size: 16px; font-weight: bold;'>Q No.3 Answer (in
                3-5 lines/ sentences) any FIVE of the following questions from Book-III (Act on Plays):</div>
        </div>
        <div class='pn  col-xs-4 text-left english'>
            <div contenteditable='true' class='text-left english' style='font-size: 16px;font-weight: bold;'>
                (2&nbsp;Marks/Q)</div>
        </div>
    </div>
    <div class='section section_short'>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>i</span></td>
                <td contenteditable='true' class='lq-stmt wspree '><span>Which oyster contains a pearl in it?</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>ii</span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <span>Why did Clay say that he would never have a haircut if Harry had not been there?</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>iii</span></td>
                <td contenteditable='true' class='lq-stmt wspree '><span>Why do they want Wozzeck to come?</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>iv</span></td>
                <td contenteditable='true' class='lq-stmt wspree '><span>To whom was AIDE asked to put a call?</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>v</span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <span>What kind of haircut does Miss mcCutcheon want?</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>vi</span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <span>Does the Girl become suspicious of First Man as the play progresses?</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>vii</span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <span>When did Miss McCutcheon come to O.K. -by-the-Sea?</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>viii</span></td>
                <td contenteditable='true' class='lq-stmt wspree '><span>What is unsupportable for Spelding?</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
    </div>
    <div class='section section_short sh-english'>
        <div class='pn  col-xs-12 text-center'></div>
    </div>
    <div class='section section_short sh-english'>
        <div class='pn col-xs-8 text-left'>
            <div contenteditable='true' class='text-left' style='font-size: 16px; font-weight: bold;'>Q No.4 Answer (in
                3-5 lines/ sentences) any FOUR of the following questions from Book-III (Poems):</div>
        </div>
        <div class='pn  col-xs-4 text-left english'>
            <div contenteditable='true' class='text-left english' style='font-size: 16px;font-weight: bold;'>
                (2&nbsp;Marks/Q)</div>
        </div>
    </div>
    <div class='section section_short'>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>i</span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <span>Who wrote and translated, "My Neighbour Friend Breathing His Last"?</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>ii</span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <span>In which orbit do the dark children enter?</span> <strong contenteditable='true' ></strong>
                </td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>iii</span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <span>What does Dr. Iqbal say about the miserable condition of the Muslim?</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>iv</span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <span>What is the condition of the poet at the death of his spiritual friend?</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>v</span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <span>What is irony of the words: "Look on my works, Ye Mighty and despair"?</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>vi</span></td>
                <td contenteditable='true' class='lq-stmt wspree '><span>How does the other person think?</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(2)</td>
            </tr>
        </table>
    </div>
    <div class='section section_letters sh-english'>
        <div class='pn  col-xs-12 text-center'>
            <div contenteditable='true' class='text-center'
                style='font-size: 18px; font-family: arial black; font-weight: normal;'> SECTION II</div>
        </div>
    </div>
    <div class='section section_letters sh-english'>
        <div class='pn col-xs-8 text-left'>
            <div contenteditable='true' class='text-left' style='font-size: 16px; font-weight: bold;'>Q No.5 </div>
        </div>
        <div class='pn  col-xs-4 text-left english'>
            <div contenteditable='true' class='text-left english' style='font-size: 16px;font-weight: bold;'>
                (10&nbsp;Marks/Q)</div>
        </div>
    </div>
    <div class='section section_letters'>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'></span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <span>Write a letter to your younger brother to give up his smoking and advising him to take interest in studies.</span>
                    <strong contenteditable='true' ><br/><span style="text-align:center">OR</span><br/></strong></td>
                <td contenteditable='true' class='lq-remarks'>(10)</td>
            </tr>
        </table>
    </div>
    <div class='section section_applications sh-english'>
        <div class='pn  col-xs-12 text-center'></div>
    </div>
    <div class='section section_applications sh-english'>
        <div class='pn col-xs-8 text-left'></div>
        <div class='pn  col-xs-4 text-left english'></div>
    </div>
    <div class='section section_applications'>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'></span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <span>Write an application to the Principal for the refund of hostel security.</span>
                    <strong contenteditable='true' ><br/><span style="text-align:center"></span><br/></strong></td>
                <td contenteditable='true' class='lq-remarks'>(0)</td>
            </tr>
        </table>
    </div>
    <div class='section section_stories sh-english'>
        <div class='pn  col-xs-12 text-center'></div>
    </div>
    <div class='section section_stories sh-english'>
        <div class='pn col-xs-8 text-left'>
            <div contenteditable='true' class='text-left' style='font-size: 16px; font-weight: bold;'>Q No.6 </div>
        </div>
        <div class='pn  col-xs-4 text-left english'>
            <div contenteditable='true' class='text-left english' style='font-size: 16px;font-weight: bold;'>
                (10&nbsp;Marks/Q)</div>
        </div>
    </div>
    <div class='section section_stories'>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'></span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <span>Write a story on the moral lesson  "Stich in time saves nine".</span>
                    <strong contenteditable='true' ><br/><span style="text-align:center">OR</span><br/></strong></td>
                <td contenteditable='true' class='lq-remarks'>(10)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'></span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <span>Write a story on the moral lesson  "Honesty never goes unrewarded".</span>
                    <strong contenteditable='true' ><br/><span style="text-align:center"></span><br/></strong></td>
                <td contenteditable='true' class='lq-remarks'>(10)</td>
            </tr>
        </table>
    </div>
    <div class='section section_explanation_of_stanza sh-english'>
        <div class='pn  col-xs-12 text-center'></div>
    </div>
    <div class='section section_explanation_of_stanza sh-english'>
        <div class='pn col-xs-8 text-left'></div>
        <div class='pn  col-xs-4 text-left english'>
            <div contenteditable='true' class='text-left english' style='font-size: 16px;font-weight: bold;'>
                (5&nbsp;Marks/Q)</div>
        </div>
    </div>
    <div class='section section_explanation_of_stanza'>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno ' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>Q No.7</span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <div contenteditable='true' class='text-left' style='font-size: 16px; font-weight: bold;'> a-
                        Explain the following lines with reference to the context.</div><span>And since to look at things in bloom
Fifty Springs are little room,
About the woodland I will go
To see the cherry hung with snow.</span> <strong contenteditable='true' ></strong>
                </td>
                <td contenteditable='true' class='lq-remarks'>(5)</td>
            </tr>
        </table>
    </div>
    <div class='section section_punctuation sh-english'>
        <div class='pn  col-xs-12 text-center'></div>
    </div>
    <div class='section section_punctuation sh-english'>
        <div class='pn col-xs-8 text-left'></div>
        <div class='pn  col-xs-4 text-left english'></div>
    </div>
    <div class='section section_punctuation'>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'></span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <div contenteditable='true' class='text-left' style='font-size: 16px; font-weight: bold;'> b-
                        Punctuate the following extract from the Book-I (Short Stories).</div>
                    <span>it could prove very valuable he told her monetarily she challenged</span>
                    <strong contenteditable='true' ></strong>
                </td>
                <td contenteditable='true' class='lq-remarks'>(5)</td>
            </tr>
        </table>
    </div>
    <div class='section section_pairs_of_words sh-english'>
        <div class='pn  col-xs-12 text-center'></div>
    </div>
    <div class='section section_pairs_of_words sh-english'>
        <div class='pn col-xs-8 text-left'>
            <div contenteditable='true' class='text-left' style='font-size: 16px; font-weight: bold;'> c- Use any five
                of the following pair of words in sentences of your own.</div>
        </div>
        <div class='pn  col-xs-4 text-left english'></div>
    </div>
    <div class='section section_pairs_of_words'>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>i</span></td>
                <td contenteditable='true' class='lq-stmt wspree '><span>Lion, Loin</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(1)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>ii</span></td>
                <td contenteditable='true' class='lq-stmt wspree '><span>Envelope, Envelop</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(1)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>iii</span></td>
                <td contenteditable='true' class='lq-stmt wspree '><span>Medal, Meddle</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(1)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>iv</span></td>
                <td contenteditable='true' class='lq-stmt wspree '><span>Knotty  ,  Naughty</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(1)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>v</span></td>
                <td contenteditable='true' class='lq-stmt wspree '><span>Altar, Alter</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(1)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>vi</span></td>
                <td contenteditable='true' class='lq-stmt wspree '><span>Idle  ,  Idol</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(1)</td>
            </tr>
        </table>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno lq-sub-qno' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>vii</span></td>
                <td contenteditable='true' class='lq-stmt wspree '><span>Lion  ,  Loin</span>
                    <strong contenteditable='true' ></strong></td>
                <td contenteditable='true' class='lq-remarks'>(1)</td>
            </tr>
        </table>
    </div>
    <div class='section section_translation_into_urdu sh-english'>
        <div class='pn  col-xs-12 text-center'></div>
    </div>
    <div class='section section_translation_into_urdu sh-english'>
        <div class='pn col-xs-8 text-left'></div>
        <div class='pn  col-xs-4 text-left english'>
            <div contenteditable='true' class='text-left english' style='font-size: 16px;font-weight: bold;'>
                (15&nbsp;Marks/Q)</div>
        </div>
    </div>
    <div class='section section_translation_into_urdu'>
        <table class='lq-table'>
            <tr class='' style=''>
                <td class='lq-qno ' contenteditable='true'>
                    <span style='font-size: 16px; font-weight: bold;'>Q No.8</span></td>
                <td contenteditable='true' class='lq-stmt wspree '>
                    <div contenteditable='true' class='text-left' style='font-size: 16px; font-weight: bold;'> Translate
                        the following passage into Urdu.</div>
                    <span>Sweat popped out on the boy&#039;s face and he began to struggle. Mrs. Jones stopped, jerked him around in front of her, put a half nelson about his neck, and continued to drag him up the street. When she got to her door, she dragged the boy inside, down a hall, and into a large kitchenette-furnished room at the rear of the house.</span>
                    <strong contenteditable='true' ></strong>
                </td>
                <td contenteditable='true' class='lq-remarks'>(15)</td>
            </tr>
        </table>
    </div>
    <div class='clearfix'></div>
    <div class='col-xs-12 text-center  pf-english'>
        <span class="text-center" style="font-size: 15px;  font-weight: bold;"><div contenteditable='true'  class='' style=''><strong></strong>  </div></span>
    </div>
    <div class='clearfix'></div>
    </div>
    </div>
    <div class="duplicate"></div>

    <button class="hidden-print btn btn-primary btn-xs float-btn-bottom110-right fs14 mr10 mnw150" onclick="window.print()">
    <i class="fa fa-print fa-fw "></i> PrintPaper
  </button>

    <a href="javascript:void(0)" id="show-answer"
        class="hidden-print btn btn-danger btn-xs float-btn-bottom60-right fs14 mr10 mnw150"><i class="fa fa-eye fa-fw"></i>
        View Anwser Keys</a>

    <button class="hidden-print btn btn-success float-btn-bottom-right btn-xs fs14 mr10 mnw150" onclick="showBubbleMcq()">
    <i class="fa fa-print fa-fw "></i> Bubble Sheet
  </button>




    <script type='text/javascript' src="https://easyautopaper.com//plugins/jQuery/jquery-2.2.3.min.js"></script>
    <script type='text/javascript' src="https://easyautopaper.com//bootstrap/js/bootstrap.min.js"></script>
    <script type='text/javascript' src="https://easyautopaper.com//plugins/select2/select2.full.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
    <script type='text/javascript' src="https://easyautopaper.com//plugins/datepicker/bootstrap-datepicker.js"></script>
    <script type='text/javascript' src="https://easyautopaper.com//plugins/timepicker/bootstrap-timepicker.min.js">
    </script>
    <script type='text/javascript' src="https://easyautopaper.com//plugins/daterangepicker/daterangepicker.js"></script>
    <script type='text/javascript' src="https://easyautopaper.com//dist/js/app.min.js"></script>
    <script type='text/javascript' src="https://easyautopaper.com//dist/js/jquery.blockui.js"></script>
</body>

</html>
""";
}
