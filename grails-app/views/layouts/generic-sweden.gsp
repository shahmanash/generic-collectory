<g:set var="orgNameLong" value="${grailsApplication.config.skin.orgNameLong}"/>
<g:set var="orgNameShort" value="${grailsApplication.config.skin.orgNameShort}"/>
<!DOCTYPE html>
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <meta name="app.version" content="${g.meta(name:'app.version')}"/>
   <meta name="app.build" content="${g.meta(name:'app.build')}"/>
   <link rel="shortcut icon" type="image/x-icon" href="favicon.ico">
   <g:if test="${instance}">
        <meta name="description" content="${orgNameLong} description of the ${instance?.name}. ${instance?.makeAbstract(200)}"/>
   </g:if>
   <g:else>
        <meta name="description" content="Explore ${orgNameLong}'s Natural History Collections."/>
   </g:else>
   <title><g:layoutTitle /> | ${orgNameLong}</title>
   <g:render template="/layouts/global"/>
   <r:require modules="jquery, jquery_migration, bootstrap, application, collectory" />
   <style type="text/css">
        body {
            background-color: #ffffff !important;
        }
        #breadcrumb {
            margin-top: 10px;
        }
        #footer {
            margin: 20px;
            padding-top: 10px;
            border-top: 1px solid #CCC;
            font-size: 12px;
        }
        #content .nav-tabs > li.active > a {
            background-color: #ffffff;
        }
        .nav {
            margin-top: 20px;
        }
   </style>
   <r:script disposition='head'>
        // initialise plugins
        jQuery(function(){
            // autocomplete on navbar search input
            jQuery("form#search-form-2011 input#search-2011, form#search-inpage input#search, input#search-2013").autocomplete('http://bie.ala.org.au/search/auto.jsonp', {
                extraParams: {limit: 100},
                dataType: 'jsonp',
                parse: function(data) {
                    var rows = new Array();
                    data = data.autoCompleteList;
                    for(var i=0; i<data.length; i++) {
                        rows[i] = {
                            data:data[i],
                            value: data[i].matchedNames[0],
                            result: data[i].matchedNames[0]
                        };
                    }
                    return rows;
                },
                matchSubset: false,
                formatItem: function(row, i, n) {
                    return row.matchedNames[0];
                },
                cacheLength: 10,
                minChars: 3,
                scroll: false,
                max: 10,
                selectFirst: false
            });

            // Mobile/desktop toggle
            // TODO: set a cookie so user's choice is remembered across pages
            var responsiveCssFile = $("#responsiveCss").attr("href"); // remember set href
            $(".toggleResponsive").click(function(e) {
                e.preventDefault();
                $(this).find("i").toggleClass("icon-resize-small icon-resize-full");
                var currentHref = $("#responsiveCss").attr("href");
                if (currentHref) {
                    $("#responsiveCss").attr("href", ""); // set to desktop (fixed)
                    $(this).find("span").html("Mobile");
                } else {
                    $("#responsiveCss").attr("href", responsiveCssFile); // set to mobile (responsive)
                    $(this).find("span").html("Desktop");
                }
            });

            $('.helphover').popover({animation: true, trigger:'hover'});
        });
    </r:script>
    <r:layoutResources/>
    <g:layoutHead />
</head>
<body class="${pageProperty(name:'body.class')?:'nav-collections'}" id="${pageProperty(name:'body.id')}" onload="${pageProperty(name:'body.onload')}">

    <div class="navbar navbar-inverse navbar-static-top">
        <div class="navbar-inner ">
            <div class="container">
                <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="brand" href="#">${orgNameLong}</a>
                <div class="nav-collapse collapse">
                    <p class="navbar-text pull-right">
                        %{--Logged in as <a href="#" class="navbar-link">Fred Bare</a>--}%
                    </p>
                    <ul class="nav">                        
                        <li class="active"><a href="/">Home</a></li>
                        <li><a href="/about/">About</a></li>
                        <li><a href="/collectory/">Collections</a></li>
                        <li><a href="/collectory/datasets/">Datasets</a></li>
                        <li><a href="/generic-hub/search/">Occurrences</a></li>                    
                        <li><a href="/biocache-service/oldapi/">API</a></li>
                        <li><a href="/links/">Links</a></li>                    
                        <li><a href="/resources">Resources</a></li>                    
                        <li><a href="/contacts">Contact</a></li>
                    </ul>
                </div><!--/.nav-collapse -->
            </div><!--/.container-fluid -->
        </div><!--/.navbar-inner -->
    </div><!--/.navbar -->

    <div class="container" id="main-content">
        <g:layoutBody />
    </div><!--/.container-->

    <div id="footer">
        <div class="container-fluid">
            <div class="row-fluid">
                <a href="http://creativecommons.org/licenses/by/3.0/au/" title="External link to Creative Commons"><img src="http://i.creativecommons.org/l/by/3.0/88x31.png" width="88" height="31" alt=""></a>
                This site is licensed under a <a href="http://creativecommons.org/licenses/by/3.0/au/" title="External link to Creative Commons" class="external">Creative Commons Attribution 3.0 Australia License</a>.
            Provider content may be covered by other <a href="#terms-of-use" title="Terms of Use">Terms of Use</a>.
            </div>
        </div>
    </div><!--/#footer -->

<!-- JS resources-->
<r:layoutResources/>
</body>
</html>