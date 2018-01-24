use v6.c;
use Test;
use P5wantarray;

plan 4;

ok defined(::('&wantarray')),             'is &wantarray imported?';
ok !defined(P5wantarray::{'&wantarray'}), 'no &wantarray externally?';
ok defined(::('&scalar')),                'is &scalar imported?';
ok !defined(P5wantarray::{'&scalar'}),    'no &scalar externally?';

sub a() { say wantarray }
a;
scalar a;

# vim: ft=perl6 expandtab sw=4
