use JQueryPresentationHelper;

my $title = title q{$.presentation};

top qq{
# $title

Takeshi Takatsudo (<mailto:takazudo\@gmail.com>)
};

plain q{
## $.presentation is ...

* the presentation framework based on jQuery.
* works on the browsers without IE6,7
* looks pretty cool if your browser is webkit based.
* You can use this template and script for any use.
* I'm happy if you put some notes or link about this framework somewhere on your presentation.
* [project page](http://code.google.com/p/jquery-presentation/)
};

plain q{
## Keyboard shortcuts

* Left,Up arrow / PgUp: prev page
* Right,Down arrow / PgDn: next page
* Home: first page
* End: last page
};

plain escape q{
## Tips

* add <div class="mod-page"> to create pages.
* Create your own page template to add the skin class to this div.  
  ex) <div class="mod-page mySkin">
* Write css under your skin class.  
  see the example in "common.css".  
  You can find "plain" and "shout" skin there.
* Add the class "first" to the <div class="mod-page">  
  which you want to show first.
* If no "div.mod-page.first" found,  
  $.presentation shows the first "div.mod-page".
};

plain q{
## pageSkin = plain

<img class="sideImgR" src="imgs/dummy.gif" alt="" width="400" height="400" />
The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.The quick brown fox jumps over the lazy dog.

<ul>
  <li>The quick brown fox jumps over the lazy dog.</li>
  <li>The quick brown fox jumps over the lazy dog.</li>
</ul>
<ol>
  <li>The quick brown fox jumps over the lazy dog.</li>
  <li>The quick brown fox jumps over the lazy dog.</li>
</ol>
};

shout q{
pageSkin = shout  
wooooooooooooooot
};

none q{
contnet here
};

none q{
contnet here
};

none q{
contnet here
};

none q{
contnet here
};

none q{
contnet here
};

none q{
contnet here
};

none q{
contnet here
};

none q{
contnet here
};

none q{
contnet here
};

none q{
the final page.
};

run();
