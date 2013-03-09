package JQueryPresentationHelper;

use strict;
use warnings;

use Text::Markdown 'markdown';
use Plack::Builder;
use FindBin;
use File::Basename;

use parent 'Exporter';

our @EXPORT = qw/title header hook top plain shout none escape run/;

my @page = ();

my %config = (
    title  => __PACKAGE__,
    header => '',
    hook   => {},
);

sub title  { $config{title}  = $_[0] }
sub header { $config{header} = $_[0] }

sub hook { $config{hook}{$_[0]} = $_[1] }

sub _add  { push @page, { type => shift, content => shift, hook => \@_ } }
sub top   { _add('top',   @_) }
sub plain { _add('plain', @_) }
sub shout { _add('shout', @_) }
sub none  { _add('',      @_) }

sub escape {
    my $str = $_[0];
    $str =~ s/&/&amp;/go;
    $str =~ s/</&lt;/go;
    $str =~ s/>/&gt;/go;
    $str =~ s/"/&quot;/go;
    $str =~ s/'/&#39;/go;
    $str;
}

sub __render {
    my $page = shift;

    my $content = markdown($page->{content});

    for my $name (@{$page->{hook}}) {
        if ($config{hook}{$name} && ref($config{hook}{$name}) eq 'CODE') {
            $content = $config{hook}{$name}->($content);
        } else {
            die "not found hook: $name";
        }
    }

    chomp $content;

    $content;
}

sub _render {
    my $html = sprintf(q{
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>%s</title>
<link rel="stylesheet" href="css/common.css">
<script src="js/jquery.js"></script>
<script src="js/jquery.presentation.js"></script>
%s
</head>
<body>
}, $config{title}, $config{header});

    for my $page (@page) {
        $html .= sprintf(q{
<div class="mod-page %s">
<div>
%s
</div>
</div>
}, $page->{type}, __render($page));
    }

    $html .= sprintf(q{
<hr />

<ul class="mod-pager" id="pager"> <li id="pager-L"><a href="#">L</a></li> <li id="pager-R"><a href="#">R</a></li> </ul>
<p class="mod-pageNum" id="pageNum"> <span class="current" id="pageNum-current">0</span> / <span class="total" id="pageNum-total">0</span> </p>
</body>
</html>
});
}

sub run {
    unless ($ENV{PLACK_ENV}) {
        print _render();
        exit;
    }
    builder {
        enable "Plack::Middleware::Static", path => qr{^/(images?|imgs?|css|js|javascripts?|fonts)}, root => $FindBin::Bin;
        my $app = sub {
            my $env = shift;
            [200, ['Content-Type' => 'text/html'], [_render()]];
        };
        $app;
    };
}

sub import {
    my $class = shift;

    strict->import;
    warnings->import;
    utf8->import;

    __PACKAGE__->export_to_level(1);
}

1;

=head1 NAME

JQueryPresentationHelper

=head1 SYNOPSIS

    use JQueryPresentationHelper;
    
    plain q{
    ## SectionTitle
    
    * Content
     * Content-1
     * Content-2
     * Content-3
    };

    run();

=head1 GENERATOR

generate

  $ bin/jqph /path/to

=head1 FUNCTIONS

=head2 title

  my $titel = title q{ ... }

Set your header title

=head2 header

  header q{<script>...</script>}

Set your header

=head2 hook

  hook 'hook_name' => sub {
    $c = shift;
    # should replace html text
    # $c =~ s///g;
    $c;
  };
  
  # use your hook
  plain q{ ... } => 'hook_name';

=head2 top

  top q{
  # presentation title
  
  author, etc...
  };
  
  # translate
  => <div class="mod-page top"> ... </div>

=head2 plain

  plain q{
  # section title
  
  * content
   * content-1
   * content-2
   * content-3
  };
  
  # translate
  => <div class="mod-page plain"> ... </div>

=head2 shout

  shout q{
  shout! shout!! shout!!!
  };
  
  # translate
  => <div class="mod-page shout"> ... </div>

=head2 none

  none q{
  murumuru
  };
  
  # translate
  => <div class="mod-page"> ... </div>

=head2 escape

  my $tag_escape = escape q{ ... }

  plain escape q{
  ## with tag escape
  
        <div>this tag is escape</div>
  };

=head2 run

  run();

Render html, if run perl command. Boot local server, if run plackup command.

=head1 SEE ALSO

L<http://code.google.com/p/jquery-presentation/>

=cut
