#!/usr/bin/perl

use strict;
use warnings;

use File::Spec;

my %hash = ();
my $email;
my $person;
my $key;
my $value;

print "Year (y) or Department (d)? ";
my $s = <STDIN>; 
chomp $s; 
my %search = ('d', 'ou:', 'y', 'mitDirStudentYear:');
my %label = ('d', 'Department:', 'y', 'Year:');
exit 0 if (!exists($search{$s}));

system('athrun consult mmblanche mitsss11 > foo.txt');

print "Performing LDAP search... this may take a while, please be patient.\n";

open STDERR, '>', File::Spec->devnull();

open(DATA, '<foo.txt') or die 'File IO failed!';
foreach $email (<DATA>) {
  if ($email =~ /\@mit\.edu/) {
    $person = `athrun consult ldaps $email`;
    if ($person =~ m/^$search{$s} (.+)$/m) {
      $hash{$1} = exists($hash{$1}) ? $hash{$1} + 1 : 1;
      print ".";
    }
  }
}

print " done.\n\n";
while ( ($key, $value) = each %hash ) {
  print "$label{$s} $key, $value\n";
}
