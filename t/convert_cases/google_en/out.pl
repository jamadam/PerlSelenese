#!/usr/bin/perl
use strict;
use warnings;
use Time::HiRes qw(sleep);
use Test::WWW::Selenium;
use Test::More "no_plan";
use Test::Exception;
use utf8;

my $sel = Test::WWW::Selenium->new( host => "localhost",
                                    port => 4444,
                                    browser => "*firefox",
                                    browser_url => "http://www.google.com/" );

WAIT: {
    for (1..60) {
        if (eval { $sel->is_text_present("toast") }) { pass; last WAIT }
        sleep(1);
    }
    fail("timeout");
}
my $a_key = $sel->get_title();
$sel->open_ok("/");
$sel->type_ok("q", "Hello World");
#this is a comment
$sel->click_ok("btnG");
$sel->wait_for_page_to_load_ok("30000");
