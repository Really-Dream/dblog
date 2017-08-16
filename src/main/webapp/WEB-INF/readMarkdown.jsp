<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>${blog.title}</title>
  <script src="/markdown/markdown-it.js"></script>
  <script src="/markdown/markdown-it-footnote.js"></script>
  <script src="/markdown/highlight.pack.js"></script>
  <script src="/markdown/emojify.js"></script>
  <script src="/markdown/codemirror/lib/codemirror.js"></script>
  <script src="/markdown/codemirror/overlay.js"></script>
  <script src="/markdown/codemirror/xml/xml.js"></script>
  <script src="/markdown/codemirror/markdown/markdown.js"></script>
  <script src="/markdown/codemirror/gfm/gfm.js"></script>
  <script src="/markdown/codemirror/javascript/javascript.js"></script>
  <script src="/markdown/codemirror/css/css.js"></script>
  <script src="/markdown/codemirror/htmlmixed/htmlmixed.js"></script>
  <script src="/markdown/codemirror/lib/util/continuelist.js"></script>
  <script src="/markdown/rawinflate.js"></script>
  <script src="/markdown/rawdeflate.js"></script>
  <script src="/markdown/jquery-3.2.1.min.js"></script>
  <link rel="stylesheet" href="/markdown/base16-light.css">
  <link rel="stylesheet" href="/markdown/codemirror/lib/codemirror.css">
  <link rel="stylesheet" href="/markdown/default.css">
  <link rel="stylesheet" href="/markdown/index.css">

  <style>

    #in{
      position: fixed;
      top: 0;
      left: 0;
      bottom: 0;
      width: 0%;
      height: auto;
      overflow: auto;
      font-size: 12px;
      box-shadow: -10px 2px 6px 10px rgba(0,0,0,0.4);
    }

    #out{
      position: fixed;
      top: 10%;
      right: 20%;
      left: 25%;
      bottom: 0;
      overflow: auto;
      padding-left: 20px;
      color: #444;
      font-family:Georgia, Palatino, 'Palatino Linotype', Times, 'Times New Roman', serif;
      font-size: 16px;
      line-height: 1.5em;
      margin-left: auto;
      margin-r: auto;
    }
  </style>
</head>
<body>
<div id="top" style="font-family: Sans-serif  ;margin-top: 20px;">
  ${blog.title}
</div>

  <div id="in">
    <form>
      <textarea id="code">
      </textarea>
    </form>
  </div>
  <div id="out"></div>


  <div id="menu">
    <span>Save As</span>
    <div id="saveas-markdown">
      <svg height="64" width="64" xmlns="http://www.w3.org/2000/svg">
        <g transform="scale(0.0625)">
          <path d="M950.154 192H73.846C33.127 192 0 225.12699999999995 0 265.846v492.308C0 798.875 33.127 832 73.846 832h876.308c40.721 0 73.846-33.125 73.846-73.846V265.846C1024 225.12699999999995 990.875 192 950.154 192zM576 703.875L448 704V512l-96 123.077L256 512v192H128V320h128l96 128 96-128 128-0.125V703.875zM767.091 735.875L608 512h96V320h128v192h96L767.091 735.875z" />
        </g>
      </svg>

      <span>Markdown</span>
    </div>
    <div id="saveas-html">
      <svg height="64" width="64" xmlns="http://www.w3.org/2000/svg">
        <g transform="scale(0.0625) translate(64,0)">
          <path d="M608 192l-96 96 224 224L512 736l96 96 288-320L608 192zM288 192L0 512l288 320 96-96L160 512l224-224L288 192z" />
        </g>
      </svg>

      <span>HTML</span>
    </div>
    <a id="close-menu">&times;</a>
  </div>
  <script type="text/javascript">
    var editor;

    function setBlog(){
        data= L('${article}');
        document.getElementById("code").value=data;
        editor = CodeMirror.fromTextArea(document.getElementById('code'), {
            mode: 'gfm',
            lineNumbers: false,
            matchBrackets: true,
            lineWrapping: true,
            theme: 'base16-light',
            extraKeys: {"Enter": "newlineAndIndentContinueMarkdownList"}
        });
        editor.on('change', update);
        update(editor);
    }

    $(function(){
        setBlog();
    });

    function L(s){
        var reg1=new RegExp("<br>","g");
        var reg2=new RegExp("&amp;","g");
        var reg3=new RegExp('&quot;',"g");
        var reg4=new RegExp("&#39;","g");
        var reg5=new RegExp("&lt;","g");
        var reg6=new RegExp("&gt;","g");
//        var reg7=new RegExp("\\\\","g");
        s = s.replace(reg1,"\n");
        s = s.replace(reg2,"&");
        s = s.replace(reg3,'"');
        s = s.replace(reg4,"'");
        s = s.replace(reg5,"<");
        s = s.replace(reg6,">");
//        s = s.replace(reg7,"\\");
        return s;
    }
    var md = markdownit({
        html: true,
        highlight: function(code, lang){
            if(languageOverrides[lang]) lang = languageOverrides[lang];
            if(lang && hljs.getLanguage(lang)){
                try {
                    return hljs.highlight(lang, code).value;
                }catch(e){}
            }
            return '';
        }
    })
        .use(markdownitFootnote);


    var languageOverrides = {
      js: 'javascript',
      html: 'xml'
    };

    emojify.setConfig({ img_dir: 'markdown/emoji' });

    if(window.location.hash && editor != undefined){
        var h = window.location.hash.replace(/^#/, '');
        if(h.slice(0,5) == 'view:'){
            setOutput(decodeURIComponent(escape(RawDeflate.inflate(atob(h.slice(5))))));
            document.body.className = 'view';
        }else{
            editor.setValue(
                decodeURIComponent(escape(
                    RawDeflate.inflate(
                        atob(
                            h
                        )
                    )
                ))
            );
            update(editor);
            editor.focus();
        }
    }else if(editor != undefined){
        update(editor);
        editor.focus();
    }

    var hashto;

    function update(e){
      setOutput(e.getValue());

      clearTimeout(hashto);
      hashto = setTimeout(updateHash, 1000);
    }

    function setOutput(val){
      val = val.replace(/<equation>((.*?\n)*?.*?)<\/equation>/ig, function(a, b){
        return '<img src="http://latex.codecogs.com/png.latex?' + encodeURIComponent(b) + '" />';
      });

      var out = document.getElementById('out');
      var old = out.cloneNode(true);
      out.innerHTML = md.render(val);
      emojify.run(out);

      var allold = old.getElementsByTagName("*");
      if (allold === undefined) return;

      var allnew = out.getElementsByTagName("*");
      if (allnew === undefined) return;

      for (var i = 0, max = Math.min(allold.length, allnew.length); i < max; i++) {
        if (!allold[i].isEqualNode(allnew[i])) {
          out.scrollTop = allnew[i].offsetTop;
          return;
        }
      }
    }

    document.addEventListener('drop', function(e){
      e.preventDefault();
      e.stopPropagation();

      var reader = new FileReader();
      reader.onload = function(e){
        editor.setValue(e.target.result);
      };

      reader.readAsText(e.dataTransfer.files[0]);
    }, false);





    function saveAsMarkdown(){
      save(editor.getValue(), "untitled.md");
    }

    function saveAsHtml() {
      save(document.getElementById('out').innerHTML, "untitled.html");
    }

    document.getElementById('saveas-markdown').addEventListener('click', function() {
      saveAsMarkdown();
      hideMenu();
    });

    document.getElementById('saveas-html').addEventListener('click', function() {
      saveAsHtml();
      hideMenu();
    });

    function save(code, name){
      var blob = new Blob([code], { type: 'text/plain' });
      if(window.saveAs){
        window.saveAs(blob, name);
      }else if(navigator.saveBlob){
        navigator.saveBlob(blob, name);
      }else{
        url = URL.createObjectURL(blob);
        var link = document.createElement("a");
        link.setAttribute("href",url);
        link.setAttribute("download",name);
        var event = document.createEvent('MouseEvents');
        event.initMouseEvent('click', true, true, window, 1, 0, 0, 0, 0, false, false, false, false, 0, null);
        link.dispatchEvent(event);
      }
    }



    var menuVisible = false;
    var menu = document.getElementById('menu');

    function showMenu() {
      menuVisible = true;
      menu.style.display = 'block';
    }

    function hideMenu() {
      menuVisible = false;
      menu.style.display = 'none';
    }

    document.getElementById('close-menu').addEventListener('click', function(){
      hideMenu();
    });




    document.addEventListener('keydown', function(e){
      if(e.keyCode == 83 && (e.ctrlKey || e.metaKey)){
        e.shiftKey ? showMenu() : saveAsMarkdown();

        e.preventDefault();
        return false;
      }

      if(e.keyCode === 27 && menuVisible){
        hideMenu();

        e.preventDefault();
        return false;
      }
    });




    function updateHash(){
      window.location.hash = btoa( // base64 so url-safe
        RawDeflate.deflate( // gzip
          unescape(encodeURIComponent( // convert to utf8
            editor.getValue()
          ))
        )
      );
    }


  </script>
</body>
</html>
