<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Markdown Editor</title>
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/other/photo/favicon.ico" type="image/x-icon" />

  <script src="${pageContext.request.contextPath}/markdown/markdown-it.js"></script>
  <script src="${pageContext.request.contextPath}/markdown/markdown-it-footnote.js"></script>
  <script src="${pageContext.request.contextPath}/markdown/highlight.pack.js"></script>
  <script src="${pageContext.request.contextPath}/markdown/emojify.js"></script>
  <script src="${pageContext.request.contextPath}/markdown/codemirror/lib/codemirror.js"></script>
  <script src="${pageContext.request.contextPath}/markdown/codemirror/overlay.js"></script>
  <script src="${pageContext.request.contextPath}/markdown/codemirror/xml/xml.js"></script>
  <script src="${pageContext.request.contextPath}/markdown/codemirror/markdown/markdown.js"></script>
  <script src="${pageContext.request.contextPath}/markdown/codemirror/gfm/gfm.js"></script>
  <script src="${pageContext.request.contextPath}/markdown/codemirror/javascript/javascript.js"></script>
  <script src="${pageContext.request.contextPath}/markdown/codemirror/css/css.js"></script>
  <script src="${pageContext.request.contextPath}/markdown/codemirror/htmlmixed/htmlmixed.js"></script>
  <script src="${pageContext.request.contextPath}/markdown/codemirror/lib/util/continuelist.js"></script>
  <script src="${pageContext.request.contextPath}/markdown/rawinflate.js"></script>
  <script src="${pageContext.request.contextPath}/markdown/rawdeflate.js"></script>
  <script src="${pageContext.request.contextPath}/markdown/jquery-3.2.1.min.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/markdown/base16-light.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/markdown/codemirror/lib/codemirror.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/markdown/default.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/markdown/index.css">
  <style>
    .dw-btn { cursor: pointer; border: none; outline: none; font-size: 14px; padding: 10px 32px; display: inline-block; vertical-align: middle;  *vertical-align: auto;
      *zoom: 1;
      *display: inline;
      -moz-border-radius: 4px; -webkit-border-radius: 4px; border-radius: 4px; background: #9e9e9e; color: #ffffff; -moz-border-radius: 4px; -webkit-border-radius: 4px; border-radius: 4px; overflow-wrap: break-word; }
    .dw-btn.has-hover:hover { background: #e1e1e1; }
    .dw-btn:disabled { background: #aaaaaa !important; color: #fff !important; border: none !important; }
  </style>
</head>
<body>
<div id="top">
  <textarea id = "title" style="border-style: none;height: 50%;width: 90%;font-family: Sans-serif;font-size: 33px;text-align:center;margin-top: 1%;resize: none;outline: none">
  </textarea>
  <input class="dw-btn has-hover disabled input-reverse-tofull" type="button" value="保存" onclick="saveBlog();"/>
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
    function saveBlog() {
        var article = editor.getValue();
        var title = $("#title").val();
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/blog/insert",
            data: {
                "article":R(article),
                "title":title,
                "sub_id":'${blog.id}',
                "parent_id":'${blog.parent_id}'
            },
            dataType: "json",
            success: function (data) {
                window.location.href="${pageContext.request.contextPath}/blog/readBlog?id=${blog.id}";
            },
            error: function (msg) {
            }
        });
    }

    var editor;
    function setBlog(){
        $("#title").val('${blog.title}');
        document.getElementById("code").value=L("${article}");
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

    function R(s){
        var reg1=new RegExp("\n","g");
        var reg2=new RegExp("&","g");
        var reg3=new RegExp('"',"g");
        var reg4=new RegExp("'","g");
        var reg5=new RegExp("<","g");
        var reg6=new RegExp(">","g");
//        var reg7=new RegExp("\\","g");
        s = s.replace(reg2,"&amp;");
        s = s.replace(reg3,"&quot;");
        s = s.replace(reg4,"&#39;");
        s = s.replace(reg5,"&lt;");
        s = s.replace(reg6,"&gt;");
        s = s.replace(reg1,"<br>");
//        s = s.replace(reg7,"\\\\");
        return s;
    }
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

    function escapeHtml(s) {
        s = String(s === null ? "" : s);
        return s.replace(/&(?!\w+;)|["'<>\\]/g, function(s) {
            switch(s) {
                case "&": return "&amp;";
                case "\\": return "\\\\";
                case '"': return '&quot;';
                case "'": return '&#39;';
                case "<": return "&lt;";
                case ">": return "&gt;";
                default: return s;
            }});
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

    emojify.setConfig({ img_dir: '${pageContext.request.contextPath}/markdown/emoji' });

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

//    var URL = window.URL || window.webkitURL || window.mozURL || window.msURL;
//    navigator.saveBlob = navigator.saveBlob || navigator.msSaveBlob || navigator.mozSaveBlob || navigator.webkitSaveBlob;
//    window.saveAs = window.saveAs || window.webkitSaveAs || window.mozSaveAs || window.msSaveAs;

    // Because highlight.js is a bit awkward at times




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
