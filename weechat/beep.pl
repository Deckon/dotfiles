 
#
# Copyright (C) 2006-2012 Sebastien Helleu <flashcode@flashtux.org>
# Copyright (C) 2011 Nils Görs <weechatter@arcor.de>
# Copyright (C) 2011 ArZa <arza@arza.us>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
# Beep (terminal bell) and/or run command on highlight/private message or new DCC.
#
# History:
# 2012-04-19, ldvx <ldvx@freenode>:
#     version 0.8: add whitelist, trigger, use hook_process for commands,
#                  rename option "beep_command" to "beep_command_pv", add help for options
# 2011-04-16, ArZa <arza@arza.us>:
#     version 0.7: fix default beep command
# 2011-03-11, nils_2 <weechatter@arcor.de>:
#     version 0.6: add additional command options for dcc and highlight
# 2011-03-09, nils_2 <weechatter@arcor.de>:
#     version 0.5: add option for beep command and dcc
# 2009-05-02, Sebastien Helleu <flashcode@flashtux.org>:
#     version 0.4: sync with last API changes
# 2008-11-05, Sebastien Helleu <flashcode@flashtux.org>:
#     version 0.3: conversion to WeeChat 0.3.0+
# 2007-08-10, Sebastien Helleu <flashcode@flashtux.org>:
#     version 0.2: upgraded licence to GPL 3
# 2006-09-02, Sebastien Helleu <flashcode@flashtux.org>:
#     version 0.1: initial release
#

use strict;
my $SCRIPT_NAME = "beep";
my $VERSION = "0.8";

# default values in setup file (~/.weechat/plugins.conf)
my %options_default = ('beep_pv'                  => ['on',    'beep on private message'],
                       'beep_pv_whitelist'        => ['off',   'turn whitelist for private messages on or off'],
                       'beep_highlight'           => ['on',    'beep on highlight'],
                       'beep_highlight_whitelist' => ['off',   'turn whitelist for highlights on or off'],
                       'beep_dcc'                 => ['on',    'beep on dcc'],
                       'beep_trigger_pv'          => ['',      'word that will trigger execution of beep_command_pv (it empty, anything will trigger)'],
                       'beep_trigger_highlight'   => ['',      'word that will trigger execution of beep_command_highlight (if empty, anything will trigger)'],
                       'beep_command_pv'          => ['$bell', 'command for beep on private message, special value "$bell" is allowed, as well as "$bell;command"'],
                       'beep_command_highlight'   => ['$bell', 'command for beep on highlight, special value "$bell" is allowed, as well as "$bell;command"'],
                       'beep_command_dcc'         => ['$bell', 'command for beep on dcc, special value "$bell" is allowed, as well as "$bell;command"'],
                       'beep_command_timeout'     => ['30000', 'timeout for command run (in milliseconds, 0 = never kill (not recommended))'],
                       'whitelist_nicks'          => ['',      'comma-separated list of "server.nick": if not empty, only these nicks will trigger execution of commands (example: "freenode.nick1,freenode.nick2")'],
);
my %options = ();

weechat::register($SCRIPT_NAME, "FlashCode <flashcode\@flashtux.org>", $VERSION,
                  "GPL3", "Beep (terminal bell) and/or run command on highlight/private message or new DCC", "", "");
init_config();

weechat::hook_config("plugins.var.perl.$SCRIPT_NAME.*", "toggle_config_by_set", "");
weechat::hook_print("", "", "", 1, "pv_and_highlight", "");
weechat::hook_signal("irc_dcc", "dcc", "");

sub pv_and_highlight
{
    my ($data, $buffer, $date, $tags, $displayed, $highlight, $prefix, $message) = @_;

    # return if message is filtered
    return weechat::WEECHAT_RC_OK if ($displayed != 1);

    # return if nick in message is own nick
    my $nick = "";
    $nick = $2 if ($tags =~ m/(^|,)nick_(.*)(,|$)/);
    return weechat::WEECHAT_RC_OK if (weechat::buffer_get_string($buffer, "localvar_nick") eq $nick);

    # highlight
    if ($highlight eq "1")
    {
        if ($options{beep_highlight} eq "on")
        {
            beep_trigger_whitelist($buffer, $message, $nick, $options{beep_trigger_highlight},
                                   $options{beep_highlight_whitelist}, $options{beep_command_highlight});
        }
    }
    # private message
    elsif (weechat::buffer_get_string($buffer, "localvar_type") eq "private" and $tags =~ m/(^|,)notify_private(,|$)/)
    {
        if ($options{beep_pv} eq "on")
        {
            beep_trigger_whitelist($buffer, $message, $nick, $options{beep_trigger_pv},
                                   $options{beep_pv_whitelist}, $options{beep_command_pv});
        }
    }
    return weechat::WEECHAT_RC_OK;
}

sub dcc
{
    beep_exec_command($options{beep_command_dcc}) if ($options{beep_dcc} eq "on");
    return weechat::WEECHAT_RC_OK;
}

sub beep_trigger_whitelist
{
    my ($buffer, $message, $nick, $trigger, $whitelist, $command) = @_;

    if ($trigger eq "" or $message =~ m/\b$trigger\b/)
    {
        my $serverandnick = weechat::buffer_get_string($buffer, "localvar_server").".".$nick;
        if ($whitelist ne "on" or $options{whitelist_nicks} eq "" or $options{whitelist_nicks} =~ /(^|,)$serverandnick(,|$)/)
        {
            beep_exec_command($command);
        }
    }
}

sub beep_exec_command
{
    my $command = $_[0];
    if ($command =~ /^\$bell/)
    {
        print STDERR "\a";
        ($command) = $command =~ /^\$bell;(.+)$/;
    }
    weechat::hook_process($command, $options{beep_command_timeout}, "my_process", "") if ($command);
}

sub my_process
{
    return weechat::WEECHAT_RC_OK;
}

sub toggle_config_by_set
{
    my ($pointer, $name, $value) = @_;
    $name = substr($name, length("plugins.var.perl.".$SCRIPT_NAME."."), length($name));
    $options{$name} = $value;
    return weechat::WEECHAT_RC_OK;
}

sub init_config
{
    my $version = weechat::info_get("version_number", "") || 0;
    foreach my $option (keys %options_default)
    {
        if (!weechat::config_is_set_plugin($option))
        {
            weechat::config_set_plugin($option, $options_default{$option}[0]);
            $options{$option} = $options_default{$option}[0];
        }
        else
        {
            $options{$option} = weechat::config_get_plugin($option);
        }
        if ($version >= 0x00030500)
        {
            weechat::config_set_desc_plugin($option, $options_default{$option}[1]." (default: \"".$options_default{$option}[0]."\")");
        }
    }
}