#!/usr/bin/perl

use WebService::Mogo2;
use Data::Dumper;

$phrase = shift;
my $mogo = WebService::Mogo2->new(username=>'example@example.com', password=>'PASS');

$result = $mogo->update($phrase);

print Dumper $result;

