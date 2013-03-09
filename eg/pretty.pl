use JQueryPresentationHelper;

my $title = title "JQueryPresentation";

header q{<script src="https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js?lang=perl&skin=sunburst"></script>};

hook 'pretty' => sub { $_[0] =~ s/<pre>/<pre class="prettyprint" style="font-size:24px;">/g; $_[0] };

plain q{
## コードハイライトするよ!!!

    sub echo {
        print shift, "\n";
    }
} => 'pretty';

run();
