#!/usr/bin/raku

use JSON::Tiny;

sub MAIN(Str $json-file) {

    #get json file data as list

    my @data = from-json $json-file.IO.slurp;

    #get headers
    my @keys = @data[0][0].keys;

    my @lines;
    my @vals;
    my %one-row;
    my $i;

    #process
    {
        @vals = [];
        %one-row = @data[0][$i++];
        @vals.push: %one-row{$_} for @keys;
        @lines.push(@vals.join(';'));
    } for ^@data[0].elems;

    my $csv-file = $json-file.subst('.json');
    $csv-file ~= '.csv';

    $csv-file.IO.spurt: @keys.join(';') ~ "\n" ~ @lines.join("\n");
    'done.'.say;
}
