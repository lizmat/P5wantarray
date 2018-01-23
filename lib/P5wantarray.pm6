use v6.c;

class P5wantarray:ver<0.0.1> {

     my sub wantarray(--> Bool:D) is export { !$*SCALAR }

     my sub scalar(&code) is raw is export { my $*SCALAR = True; code() }
}

sub EXPORT(|) {

    role Scalar::Grammar {
        token statement_prefix:sym<scalar> { <sym><.kok> <blorst> }
    }
    role Scalar::Actions {
        method statement_prefix:sym<scalar>($/)   {
            make QAST::Op.new(
              :op<call>,
              :name<&scalar>,
              :node($/),
              $<blorst>.ast
            );
        }
    }

    use nqp;
    use QAST:from<NQP>;

#    nqp::bindkey(
#      %*LANG,
#      'MAIN',
#      %*LANG<MAIN>.HOW.mixin(%*LANG<MAIN>,Scalar::Grammar)
#    );
    nqp::bindkey(
      %*LANG,
      'MAIN-actions',
      %*LANG<MAIN-actions>.HOW.mixin(%*LANG<MAIN-actions>,Scalar::Actions)
    );

    {}
}

=begin pod

=head1 NAME

P5wantarray - Implement Perl 5's wantarray() built-in

=head1 SYNOPSIS

  use P5wantarray;

=head1 DESCRIPTION

This module tries to mimic the behaviour of C<wantarray> and C<scalar> of Perl 5
as closely as possible.

=head1 AUTHOR

Elizabeth Mattijsen <liz@wenzperl.nl>

Source can be located at: https://github.com/lizmat/P5wantarray . Comments and
Pull Requests are welcome.

=head1 COPYRIGHT AND LICENSE

Copyright 2018 Elizabeth Mattijsen

Re-imagined from Perl 5 as part of the CPAN Butterfly Plan.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
