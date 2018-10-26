<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head> 
 <title>jQuery Star Rating Plugin v4.11 (2013-03-14)</title>
 <!--// plugin-specific resources //-->
	<script src='resources/star-rating/jquery.js' type="text/javascript"></script>
	<script src='resources/star-rating/jquery.MetaData.js' type="text/javascript" language="javascript"></script>
 <script src='resources/star-rating/jquery.rating.js' type="text/javascript" language="javascript"></script>
 <link href='resources/star-rating/jquery.rating.css' type="text/css" rel="stylesheet"/>
 <!--// documentation resources //-->
 <!--<script src="http://code.jquery.com/jquery-migrate-1.1.1.js" type="text/javascript"></script>-->
 <link type="text/css" href="/@/js/jquery/ui/jquery.ui.css" rel="stylesheet" />
 <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.1/jquery-ui.min.js" type="text/javascript"></script>
 <link href='documentation/documentation.css' type="text/css" rel="stylesheet"/>
	<script src='documentation/documentation.js' type="text/javascript"></script>
</head>
<body>
<div class="Clear" id="wrap">

 <div class="Clear" id="body">
  <div class="Clear" id="ad">
   <!--//
   <div id='vu_ytplayer_vjVQa1PpcFNzWL_xJNUOpZhjtZP7PE8aGHuLQqHHrFI='><a href='http://www.youtube.com/browse'>Watch the latest videos on YouTube.com</a></div>
   <script type='text/javascript' src='http://www.youtube.com/watch_custom_player?id=vjVQa1PpcFNzWL_xJNUOpZhjtZP7PE8aGHuLQqHHrFI='></script>
   //-->
			<script type="text/javascript"><!--
   google_ad_client = "pub-9465008056978568";
   /* 120x600, created 25/11/09 */
   google_ad_slot = "4176621808";
   google_ad_width = 120;
   google_ad_height = 600;
   //--></script>
   <script type="text/javascript" src="http://pagead2.googlesyndication.com/pagead/show_ads.js"></script>
  </div>
  <div class="Clear" id="documentation">
   <div class="tabs">
    <ul class="Clear">
     <li><a href="#tab-Overview" id="btn-Overview">Intro</a></li>
     <li><a href="#tab-Testing" id="btn-Testing">Demos</a></li>
     <li><a href="#tab-API" id="btn-API">API</a></li>
     <li><a href="#tab-Database" id="btn-Database">Database Integration</a></li>
     <li><a href="#tab-Background" id="btn-Background">Background</a></li>
     <li><a href="#tab-Download" id="btn-Download">Download</a></li>
     <li><a href="#tab-Support" id="btn-Support">Support</a></li>
     <li><a href="#tab-License" id="btn-License">License</a></li>
     <li><a href="#tab-More" id="btn-More">More</a></li>
    </ul><!--// tabs //-->
    <!--//
    ####################################
    #
    #        * START CONTENT *
    #
    ####################################
    //-->
      
   
   <div id="tab-Testing">
    <h2>Test Suite</h2>
<script type="text/javascript" language="javascript">
$(function(){  
 $('#form4 :radio.star').rating(); 
});
</script>


<script>
$(function(){
 $('#tab-Testing form').submit(function(){
  $('.test',this).html('');
  $('input',this).each(function(){
   if(this.checked) $('.test',this.form).append(''+this.name+': '+this.value+'<br/>');
		});
  return false;
 });
});
</script>



<div class="Clear">&nbsp;</div><div class="Clear">&nbsp;</div>








<form id="form4">
<strong style='font-size:150%'>Test 4</strong> - <strong>Half Stars</strong> and <strong>Split Stars</strong>
<table width="100%" cellspacing="10"> <tr>
  <td valign="top" width="">
   <table width="100%">
    <tr>
     <td width="50%">
   <div class="Clear">
    Rating 1:
    (N/M/Y/?)
    <div><small><pre class="code"><code class="html">&lt;input class="star {half:true}"</code></pre></small></div>
    <input class="star {half:true}" type="radio" name="test-4-rating-1" value="N" title="No"/>
    <input class="star {half:true}" type="radio" name="test-4-rating-1" value="M" title="Maybe"/>
    <input class="star {half:true}" type="radio" name="test-4-rating-1" value="Y" title="Yes"/>
    <input class="star {half:true}" type="radio" name="test-4-rating-1" value="?" title="Don't Know"/>
   </div>
   <br/>
   <div class="Clear">
    Rating 2:
    (10 - 60)
    <div><small><pre class="code"><code class="html">&lt;input class="star {split:3}"</code></pre></small></div>
    <input class="star {split:3}" type="radio" name="test-4-rating-2" value="10"/>
    <input class="star {split:3}" type="radio" name="test-4-rating-2" value="20"/>
    <input class="star {split:3}" type="radio" name="test-4-rating-2" value="30"/>
    <input class="star {split:3}" type="radio" name="test-4-rating-2" value="40"/>
    <input class="star {split:3}" type="radio" name="test-4-rating-2" value="50"/>
    <input class="star {split:3}" type="radio" name="test-4-rating-2" value="60"/>
   </div>
   <br/>
   <div class="Clear">
    Rating 3:
    (0-5.0, default 3.5)
    <div><small><pre class="code"><code class="html">&lt;input class="star {split:2}"</code></pre></small></div>
    <input class="star {split:2}" type="radio" name="test-4-rating-3" value="0.5"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-3" value="1.0"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-3" value="1.5"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-3" value="2.0"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-3" value="2.5"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-3" value="3.0"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-3" value="3.5" checked="checked"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-3" value="4.0"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-3" value="4.5"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-3" value="5.0"/>
   </div>
  </td>
  <td valign="top" width="50%">
   <div class="Clear">
    Rating 4:
    (1-6, default 5)
    <div><small><pre class="code"><code class="html">&lt;input class="star {split:2}"</code></pre></small></div>
    <input class="star {split:2}" type="radio" name="test-4-rating-4" value="1" title="Worst"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-4" value="2" title="Bad"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-4" value="3" title="OK"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-4" value="4" title="Good"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-4" value="5" title="Best" checked="checked"/>
    <input class="star {split:2}" type="radio" name="test-4-rating-4" value="6" title="Bestest!!!"/>
   </div>
   <br/>
   <div class="Clear">
    Rating 5:
    (1-20, default 11, required)
    <div><small><pre class="code"><code class="html">&lt;input class="star {split:4}"</code></pre></small></div>
    <input class="star {split:4} required" type="radio" name="test-4-rating-5" value="1"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-5" value="2"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-5" value="3"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-5" value="4"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-5" value="5"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-5" value="6"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-5" value="7"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-5" value="8"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-5" value="9"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-5" value="10"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-5" value="11" checked="checked"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-5" value="12"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-5" value="13"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-5" value="14"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-5" value="15"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-5" value="16"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-5" value="17"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-5" value="18"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-5" value="19"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-5" value="20"/>
   </div>
   <br/>
   <div class="Clear">
    Rating 6 (readonly):
    (1-20, default 13)
    <div><small><pre class="code"><code class="html">&lt;input class="star {split:4}"</code></pre></small></div>
    <input class="star {split:4}" type="radio" name="test-4-rating-6" value="1" disabled="disabled"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-6" value="2" disabled="disabled"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-6" value="3" disabled="disabled"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-6" value="4" disabled="disabled"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-6" value="5" disabled="disabled"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-6" value="6" disabled="disabled"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-6" value="7" disabled="disabled"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-6" value="8" disabled="disabled"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-6" value="9" disabled="disabled"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-6" value="10" disabled="disabled"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-6" value="11" disabled="disabled"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-6" value="12" disabled="disabled"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-6" value="13" disabled="disabled" checked="checked"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-6" value="14" disabled="disabled"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-6" value="15" disabled="disabled"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-6" value="16" disabled="disabled"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-6" value="17" disabled="disabled"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-6" value="18" disabled="disabled"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-6" value="19" disabled="disabled"/>
    <input class="star {split:4}" type="radio" name="test-4-rating-6" value="20" disabled="disabled"/>
   </div>
     </td>
    </tr>
   </table>
  </td>
  <td valign="top" width="5">&nbsp;</td>  <td valign="top" width="50">
   <input type="submit" value="Submit scores!" />  </td>
  <td valign="top" width="5">&nbsp;</td>  <td valign="top" width="160">
   <u>Test results</u>:<br/><br/>
   <div class="test Smaller">
    <span style="color:#FF0000">Results will be displayed here</span>
   </div>
  </td>
 </tr>
</table>
</form>
  
<script type="text/javascript">
		var _gaq = _gaq || [];
		_gaq.push(['_setAccount', 'UA-1942730-1']);
		_gaq.push(['_setDomainName', 'fyneworks.com']);
		_gaq.push(['_trackPageview']);
		(function() {
				var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
				ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
				var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
		})();
</script>
</body>
</html>
