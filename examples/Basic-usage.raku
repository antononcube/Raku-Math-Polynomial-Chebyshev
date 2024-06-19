#!/usr/bin/env raku
use v6.d;

use lib <. lib>;

use Math::Polynomial::Chebyshev;

use Math::Matrix;
use Hash::Merge;

use LLM::Configurations;

use Data::Reshapers;
use Data::Summarizers;
use Data::Generators;
use Data::TypeSystem;

use JavaScript::Google::Charts;

my $k = 4;
my @x = (-1.0, -0.9 ... 1.0);
say '@x.elems : ', @x.elems;

my @data  = chebyshev-t($k, @x);

say 'deduce-type(@data) : ', deduce-type(@data);

say (:@data);

my $n = 8;
my @data2 = (-1, -0.98 ... 1).map(-> $x { [:$x, |(0..$n).map({ $_.Str => chebyshev-t($_, $x) }) ].Hash });

spurt "cheb-$n.html",
        js-google-charts('LineChart', @data2,
        column-names => ['x', |(0..$n)».Str],
        title => 'Chebyshev T polynomials, 0 .. ' ~ $n,
        width => 800,
        height => 400,
        legend => %(position => 'right'),
        chartArea =>%(right => 100),
        format => 'html',
        div-id => 'cheb-' ~ $n);
