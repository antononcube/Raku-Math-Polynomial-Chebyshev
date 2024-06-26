#!/usr/bin/env raku
use v6.d;

use Math::Polynomial::Chebyshev;
use Data::TypeSystem;
use Data::Summarizers;

my @x = (-1.0, -0.98 ... 1.0);
my $k = 100;
my $n = 10;

my $method = 'recursive';

#========================================================================================================================
say '=' x 120;
say "Numeric argument, $k degree, $n repetions";
say '-' x 120;

my $tstart = now;
for ^$n {
    @x.map({ [$_, chebyshev-t($k, $_, :$method)]});
}
my $tend = now;
say "Computation time, total   : {$tend - $tstart}";
say "Computation time, per call: {($tend - $tstart) / $n}";

#========================================================================================================================
say '=' x 120;
say "Vector argument, $k degree, $n repetions";
say '-' x 120;

my $tstart2 = now;
for ^$n {
    chebyshev-t($k, @x);
}
my $tend2 = now;
say "Computation time, total   : {$tend2 - $tstart2}";
say "Computation time, per call: {($tend2 - $tstart2) / $n}";

#========================================================================================================================
say '=' x 120;
say 'Equivalence';
say '-' x 120;

say '@x.elems : ', @x.elems;

my @data  = @x.map({ [$_, chebyshev-t($k, $_, :$method)]});
my @data1 = chebyshev-t($k, @x);

say deduce-type(@data);
say deduce-type(@data1);


records-summary(@data.map(*.tail) <<->> @data1);