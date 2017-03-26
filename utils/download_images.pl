#!/usr/bin/env perl

use strict;
use warnings;

use JSON;
use File::Slurp;
use DDP;
use LWP::Simple;


my $channels = decode_json(read_file('channels.json'));
for ( @$channels )  {
  print "Downloading $_->{key}\n";
  system("curl http:$_->{asset_url} > big-assets/$_->{key}.png ");
}


