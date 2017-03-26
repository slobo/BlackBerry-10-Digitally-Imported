#!/usr/bin/env perl

use strict;
use warnings;

use JSON;
use File::Slurp;
use DDP;

use XML::Writer;
use IO::File;
 
my $output = IO::File->new(">../assets/stations.xml");
 
my $writer = XML::Writer->new(OUTPUT => $output);
my $channels = decode_json(read_file('channels.json'));
$writer->startTag('root');
$writer->startTag('header', title=>"Stations");
for ( @$channels )  {
  print "Converting $_->{key}\n";
  $writer->emptyTag('station',
    id    => $_->{key},
    title => $_->{name},
    description => $_->{description},
  );
    
}
$writer->endTag();
$writer->endTag();
$writer->end();
$output->close();


