#
# Copyright (C) 2008-2012 Sebastien Helleu <flashcode@flashtux.org>
# Copyright (C) 2011-2012 Nils G <weechatter@arcor.de>
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
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
#
# Display sidebar with list of buffers.
#
# History:
#
# 2012-04-07, Sebastien Helleu <flashcode@flashtux.org>:
#     v3.3: fix truncation of wide chars in buffer name (option name_size_max) (bug #36034)
# 2012-03-15, nils_2 <weechatter@arcor.de>:
#     v3.2: add new option "detach"(weechat >= 0.3.8)
#           add new option "immune_detach_buffers" (requested by Mkaysi)
#           add new function buffers_whitelist add|del|reset (suggested by FiXato)
#           add new function buffers_detach add|del|reset
# 2012-03-09, Sebastien Helleu <flashcode@flashtux.org>:
#     v3.1: fix reload of config file
# 2012-01-29, nils_2 <weechatter@arcor.de>:
#     v3.0: fix: buffers did not update directly during window_switch (reported by FiXato)
# 2012-01-29, nils_2 <weechatter@arcor.de>:
#     v2.9: add options "name_size_max" and "name_crop_suffix"
# 2012-01-08, nils_2 <weechatter@arcor.de>:
#     v2.8: fix indenting for option "show_number off"
#           fix unset of buffer activity in hotlist when buffer was moved with mouse
#           add buffer with free content and core buffer sorted first (suggested  by nyuszika7h)
#           add options queries_default_fg/bg and queries_message_fg/bg (suggested by FiXato)
#           add clicking with left button on current buffer will do a jump_previously_visited_buffer (suggested by FiXato)
#           add clicking with right button on current buffer will do a jump_next_visited_buffer
#           add additional informations in help texts
#           add default_fg and default_bg for whitelist channels
#           internal changes  (script is now 3Kb smaller)
# 2012-01-04, Sebastien Helleu <flashcode@flashtux.org>:
#     v2.7: fix regex lookup in whitelist buffers list
# 2011-12-04, nils_2 <weechatter@arcor.de>:
#     v2.6: add own config file (buffers.conf)
#           add new behavior for indenting (under_name)
#           add new option to set different color for server buffers and buffers with free content
# 2011-10-30, nils_2 <weechatter@arcor.de>:
#     v2.5: add new options "show_number_char" and "color_number_char",
#           add help-description for options
# 2011-08-24, Sebastien Helleu <flashcode@flashtux.org>:
#     v2.4: add mouse support
# 2011-06-06, nils_2 <weechatter@arcor.de>:
#     v2.3: added: missed option "color_whitelist_default"
# 2011-03-23, Sebastien Helleu <flashcode@flashtux.org>:
#     v2.2: fix color of nick prefix with WeeChat >= 0.3.5
# 2011-02-13, nils_2 <weechatter@arcor.de>:
#     v2.1: add options "color_whitelist_*"
# 2010-10-05, Sebastien Helleu <flashcode@flashtux.org>:
#     v2.0: add options "sort" and "show_number"
# 2010-04-12, Sebastien Helleu <flashcode@flashtux.org>:
#     v1.9: replace call to log() by length() to align buffer numbers
# 2010-04-02, Sebastien Helleu <flashcode@flashtux.org>:
#     v1.8: fix bug with background color and option indenting_number
# 2010-04-02, Helios <helios@efemes.de>:
#     v1.7: add indenting_number option
# 2010-02-25, m4v <lambdae2@gmail.com>:
#     v1.6: add option to hide empty prefixes
# 2010-02-12, Sebastien Helleu <flashcode@flashtux.org>:
#     v1.5: add optional nick prefix for buffers like IRC channels
# 2009-09-30, Sebastien Helleu <flashcode@flashtux.org>:
#     v1.4: remove spaces for indenting when bar position is top/bottom
# 2009-06-14, Sebastien Helleu <flashcode@flashtux.org>:
#     v1.3: add option "hide_merged_buffers"
# 2009-06-14, Sebastien Helleu <flashcode@flashtux.org>:
#     v1.2: improve display with merged buffers
# 2009-05-02, Sebastien Helleu <flashcode@flashtux.org>:
#     v1.1: sync with last API changes
# 2009-02-21, Sebastien Helleu <flashcode@flashtux.org>:
#     v1.0: remove timer used to update bar item first time (not needed any more)
# 2009-02-17, Sebastien Helleu <flashcode@flashtux.org>:
#     v0.9: fix bug with indenting of private buffers
# 2009-01-04, Sebastien Helleu <flashcode@flashtux.org>:
#     v0.8: update syntax for command /set (comments)
# 2008-10-20, Jiri Golembiovsky <golemj@gmail.com>:
#     v0.7: add indenting option
# 2008-10-01, Sebastien Helleu <flashcode@flashtux.org>:
#     v0.6: add default color for buffers, and color for current active buffer
# 2008-09-18, Sebastien Helleu <flashcode@flashtux.org>:
#     v0.5: fix color for "low" level entry in hotlist
# 2008-09-18, Sebastien Helleu <flashcode@flashtux.org>:
#     v0.4: rename option "show_category" to "short_names",
#           remove option "color_slash"
# 2008-09-15, Sebastien Helleu <flashcode@flashtux.org>:
#     v0.3: fix bug with priority in hotlist (var not defined)
# 2008-09-02, Sebastien Helleu <flashcode@flashtux.org>:
#     v0.2: add color for buffers with activity and config options for
#           colors, add config option to display/hide categories
# 2008-03-15, Sebastien Helleu <flashcode@flashtux.org>:
#     v0.1: script creation
#
# Help about settings:
#   display all settings for script (or use iset.pl script to change settings):
#      /set buffers*
#   show help text for option buffers.look.whitelist_buffers:
#      /help buffers.look.whitelist_buffers
#
# Mouse-support (standard key bindings):
#   left mouse-button:
#       - click on a buffer to switch to selected buffer
#       - click on current buffer will do action jump_previously_visited_buffer
#       - drag a buffer and drop it on another position will move the buffer to position
#   right mouse-button:
#       - click on current buffer will do action jump_next_visited_buffer
#       - moving buffer to the left/right will close buffer.
#

use strict;
use Encode qw( decode encode );
# -------------------------------[ internal ]-------------------------------------
my $version = "3.3";

my $BUFFERS_CONFIG_FILE_NAME = "buffers";
my $buffers_config_file;
my $cmd_buffers_whitelist= "buffers_whitelist";
my $cmd_buffers_detach   = "buffers_detach";

my %mouse_keys          = ("\@item(buffers):button1*"    => "hsignal:buffers_mouse",     # catch all left mouse button gestures
                           "\@item(buffers):button2"     => "hsignal:buffers_mouse");    # catch right mouse button
my %options;
my %hotlist_level       = (0 => "low", 1 => "message", 2 => "private", 3 => "highlight");
my @whitelist_buffers   = ();
my @immune_detach_buffers= ();
my @buffers_focus       = ();
my %buffers_timer       = ();
my %Hooks               = ();

# --------------------------------[ init ]--------------------------------------
weechat::register("buffers", "Sebastien Helleu <flashcode\@flashtux.org>", $version,
                  "GPL3", "Sidebar with list of buffers", "", "");
my $weechat_version = weechat::info_get("version_number", "") || 0;

buffers_config_init();
buffers_config_read();

weechat::bar_item_new("buffers", "build_buffers", "");
weechat::bar_new("buffers", "0", "0", "root", "", "left", "horizontal",
                 "vertical", "0", "0", "default", "default", "default", "1",
                 "buffers");
weechat::hook_signal("buffer_*", "buffers_signal_buffer", "");
weechat::hook_signal("window_switch", "buffers_signal_buffer", "");
weechat::hook_signal("hotlist_*", "buffers_signal_hotlist", "");
weechat::bar_item_update("buffers");
if ($weechat_version >= 0x00030600)
{
    weechat::hook_focus("buffers", "buffers_focus_buffers", "");
    weechat::hook_hsignal("buffers_mouse", "buffers_hsignal_mouse", "");
    weechat::key_bind("mouse", \%mouse_keys);
}

weechat::hook_command(  $cmd_buffers_whitelist,
                        "add/del current buffer to/from buffers whitelist",
                        "[add] || [del] || [reset]",

                        "  add: add current buffer in configuration file\n".
                        "  del: delete current buffer from configuration file\n".
                        "reset: reset all buffers from configuration file (no confirmation!)\n\n".
                        "Examples:\n".
                        "/$cmd_buffers_whitelist add\n",
                        "add %-||".
                        "del %-||".
                        "reset %-",
                        "buffers_cmd_whitelist", "");

weechat::hook_command(  $cmd_buffers_detach,
                        "add/del current buffer to/from buffers detach",
                        "[add] || [del] || [reset]",

                        "  add: add current buffer in configuration file\n".
                        "  del: delete current buffer from configuration file\n".
                        "reset: reset all buffers from configuration file (no confirmation!)\n\n".
                        "Examples:\n".
                        "/$cmd_buffers_detach add\n",
                        "add %-||".
                        "del %-||".
                        "reset %-",
                        "buffers_cmd_detach", "");

if ($weechat_version >= 0x00030800)
{
    weechat::hook_config("buffers.look.detach", "hook_config", "");
}
# -------------------------------- [ command ] --------------------------------
sub buffers_cmd_whitelist
{
my ( $data, $buffer, $args ) = @_;
    $args = lc($args);
    my $buffers_whitelist = weechat::config_string( weechat::config_get("buffers.look.whitelist_buffers") );
    return weechat::WEECHAT_RC_OK if ( $buffers_whitelist eq "" and $args eq "del" or $buffers_whitelist eq "" and $args eq "reset" );
    my @buffers_list = split( /,/, $buffers_whitelist );
    # get buffers name
    my $infolist = weechat::infolist_get("buffer", weechat::current_buffer(), "");
    weechat::infolist_next($infolist);
    my $buffers_name = weechat::infolist_string($infolist, "name");
    weechat::infolist_free($infolist);
    return weechat::WEECHAT_RC_OK if ( $buffers_name eq "" );                   # should never happen

    if ( $args eq "add" )
    {
        return weechat::WEECHAT_RC_OK if ( grep /^$buffers_name$/, @buffers_list );     # check if buffer already in list
        push @buffers_list,( $buffers_name );
        my $buffers_list = &create_whitelist(\@buffers_list);
        weechat::config_option_set( weechat::config_get("buffers.look.whitelist_buffers"), $buffers_list,1 );
        weechat::print(weechat::current_buffer(), "buffer \"$buffers_name\" added to buffers whitelist");
    }
    elsif ( $args eq "del" )
    {
        return weechat::WEECHAT_RC_OK unless ( grep /^$buffers_name$/, @buffers_list );     # check if buffer is in list
        @buffers_list = grep {$_ ne $buffers_name} @buffers_list;                           # delete entry
        my $buffers_list = &create_whitelist(\@buffers_list);
        weechat::config_option_set( weechat::config_get("buffers.look.whitelist_buffers"), $buffers_list,1 );
        weechat::print(weechat::current_buffer(), "buffer \"$buffers_name\" deleted from buffers whitelist");
    }
    elsif ( $args eq "reset" )
    {
        return weechat::WEECHAT_RC_OK if ( $buffers_whitelist eq "" );
        weechat::config_option_set( weechat::config_get("buffers.look.whitelist_buffers"), "",1 );
        weechat::print(weechat::current_buffer(), "buffers whitelist is empty, now...");
    }
    return weechat::WEECHAT_RC_OK;
}
sub buffers_cmd_detach
{
my ( $data, $buffer, $args ) = @_;
    $args = lc($args);
    my $immune_detach_buffers = weechat::config_string( weechat::config_get("buffers.look.immune_detach_buffers") );
    return weechat::WEECHAT_RC_OK if ( $immune_detach_buffers eq "" and $args eq "del" or $immune_detach_buffers eq "" and $args eq "reset" );
    my @buffers_list = split( /,/, $immune_detach_buffers );
    # get buffers name
    my $infolist = weechat::infolist_get("buffer", weechat::current_buffer(), "");
    weechat::infolist_next($infolist);
    my $buffers_name = weechat::infolist_string($infolist, "name");
    weechat::infolist_free($infolist);
    return weechat::WEECHAT_RC_OK if ( $buffers_name eq "" );                   # should never happen

    if ( $args eq "add" )
    {
        return weechat::WEECHAT_RC_OK if ( grep /^$buffers_name$/, @buffers_list );     # check if buffer already in list
        push @buffers_list,( $buffers_name );
        my $buffers_list = &create_whitelist(\@buffers_list);
        weechat::config_option_set( weechat::config_get("buffers.look.immune_detach_buffers"), $buffers_list,1 );
        weechat::print(weechat::current_buffer(), "buffer \"$buffers_name\" added to immune detach buffers");
    }
    elsif ( $args eq "del" )
    {
        return weechat::WEECHAT_RC_OK unless ( grep /^$buffers_name$/, @buffers_list );     # check if buffer is in list
        @buffers_list = grep {$_ ne $buffers_name} @buffers_list;                           # delete entry
        my $buffers_list = &create_whitelist(\@buffers_list);
        weechat::config_option_set( weechat::config_get("buffers.look.immune_detach_buffers"), $buffers_list,1 );
        weechat::print(weechat::current_buffer(), "buffer \"$buffers_name\" deleted from immune detach buffers");
    }
    elsif ( $args eq "reset" )
    {
        return weechat::WEECHAT_RC_OK if ( $immune_detach_buffers eq "" );
        weechat::config_option_set( weechat::config_get("buffers.look.immune_detach_buffers"), "",1 );
        weechat::print(weechat::current_buffer(), "immune detach buffers is empty, now...");
    }
    return weechat::WEECHAT_RC_OK;
}
sub create_whitelist
{
    my @buffers_list = @{$_[0]};
    my $buffers_list = "";
        foreach (@buffers_list)
        {
            $buffers_list .= $_ .",";
        }
        chop $buffers_list;                                                               # remove last ","
    return $buffers_list;
}

# -------------------------------- [ config ] --------------------------------
sub hook_config
{
    my $detach = $_[2];
    if ( $detach eq 0 )
    {
        weechat::unhook($Hooks{timer}) if $Hooks{timer};
        $Hooks{timer} = "";
    }
    else
    {
        weechat::unhook($Hooks{timer}) if $Hooks{timer};
        $Hooks{timer} = weechat::hook_timer( weechat::config_integer( $options{"detach"}) * 1000, 60, 0, "buffers_signal_buffer", "");
    }
    weechat::bar_item_update("buffers");
    return weechat::WEECHAT_RC_OK;
}

sub buffers_config_read
{
    return weechat::config_read($buffers_config_file) if ($buffers_config_file ne "");
}
sub buffers_config_write
{
    return weechat::config_write($buffers_config_file) if ($buffers_config_file ne "");
}
sub buffers_config_reload_cb
{
    my ($data,$config_file) = ($_[0], $_[1]);
    return weechat::config_reload($config_file)
}
sub buffers_config_init
{
    $buffers_config_file = weechat::config_new($BUFFERS_CONFIG_FILE_NAME,"buffers_config_reload_cb","");
    return if ($buffers_config_file eq "");

my %default_options_color =
("color_current_fg" => ["current_fg", "color", "foreground color for current buffer", "", 0, 0,"lightcyan", "lightcyan", 0, "", "","buffers_signal_config", "", "", ""],
 "color_current_bg" => ["current_bg", "color", "background color for current buffer", "", 0, 0,"red", "red", 0, "", "","buffers_signal_config", "", "", ""],
 "color_default_fg" => ["default_fg", "color", "default foreground color for buffer name", "", 0, 0,"default", "default", 0, "", "","buffers_signal_config", "", "", ""],
 "color_default_bg" => ["default_bg", "color", "default background color for buffer name", "", 0, 0,"default", "default", 0, "", "","buffers_signal_config", "", "", ""],
 "color_hotlist_highlight_fg" => ["hotlist_highlight_fg", "color", "change foreground color of buffer name if a highlight messaged received","", 0, 0,"magenta", "magenta", 0, "", "","buffers_signal_config", "", "", ""],
 "color_hotlist_highlight_bg" => ["hotlist_highlight_bg", "color", "change background color of buffer name if a highlight messaged received", "", 0, 0,"default", "default", 0, "", "","buffers_signal_config", "", "", ""],
 "color_hotlist_low_fg" => ["hotlist_low_fg", "color", "change foreground color of buffer name if a low message received", "", 0, 0,"white", "white", 0, "", "","buffers_signal_config", "", "", ""],
 "color_hotlist_low_bg" => ["hotlist_low_bg", "color", "change background color of buffer name if a low message received", "", 0, 0,
        "default", "default", 0, "", "","buffers_signal_config", "", "", ""],
 "color_hotlist_message_fg" => ["hotlist_message_fg", "color", "change foreground color of buffer name if a normal message received", "", 0, 0,"yellow", "yellow", 0, "", "","buffers_signal_config", "", "", ""],
 "color_hotlist_message_bg" => ["hotlist_message_bg", "color", "change background color of buffer name if a normal message received", "", 0, 0,"default", "default", 0, "", "","buffers_signal_config", "", "", ""],
 "color_hotlist_private_fg" => ["hotlist_private_fg", "color", "change foreground color of buffer name if a private message received", "", 0, 0,"lightgreen", "lightgreen", 0, "", "","buffers_signal_config", "", "", ""],
 "color_hotlist_private_bg" => ["hotlist_private_bg", "color", "change background color of buffer name if a private message received", "", 0, 0,"default", "default", 0, "", "","buffers_signal_config", "", "", ""],
 "color_number" => ["number", "color", "color for buffer number", "", 0, 0,"lightgreen", "lightgreen", 0, "", "","buffers_signal_config", "", "", ""],
 "color_number_char" => ["number_char", "color", "color for buffer number char", "", 0, 0,"lightgreen", "lightgreen", 0, "", "","buffers_signal_config", "", "", ""],
 "color_whitelist_default_fg" => ["whitelist_default_fg", "color", "default foreground color for whitelist buffer name", "", 0, 0,"", "", 0, "", "","buffers_signal_config", "", "", ""],
 "color_whitelist_default_bg" => ["whitelist_default_bg", "color", "default background color for whitelist buffer name", "", 0, 0,"", "", 0, "", "","buffers_signal_config", "", "", ""],
 "color_whitelist_low_fg" => ["whitelist_low_fg", "color", "low color of whitelist buffer name", "", 0, 0,"", "", 0, "", "","buffers_signal_config", "", "", ""],
 "color_whitelist_low_bg" => ["whitelist_low_bg", "color", "low color of whitelist buffer name", "", 0, 0,"", "", 0, "", "","buffers_signal_config", "", "", ""],
 "color_whitelist_message_fg" => ["whitelist_message_fg", "color", "message color of whitelist buffer name", "", 0, 0,"", "", 0, "", "","buffers_signal_config", "", "", ""],
 "color_whitelist_message_bg" => ["whitelist_message_bg", "color", "message color of whitelist buffer name", "", 0, 0,"", "", 0, "", "","buffers_signal_config", "", "", ""],
 "color_whitelist_private_fg" => ["whitelist_private_fg", "color", "private color of whitelist buffer name", "", 0, 0,"", "", 0, "", "","buffers_signal_config", "", "", ""],
 "color_whitelist_private_bg" => ["whitelist_private_bg", "color", "private color of whitelist buffer name", "", 0, 0,"", "", 0, "", "","buffers_signal_config", "", "", ""],
 "color_whitelist_highlight_fg" => ["whitelist_highlight_fg", "color", "highlight color of whitelist buffer name", "", 0, 0,"", "", 0, "", "","buffers_signal_config", "", "", ""],
 "color_whitelist_highlight_bg" => ["whitelist_highlight_bg", "color", "highlight color of whitelist buffer name", "", 0, 0,"", "", 0, "", "","buffers_signal_config", "", "", ""],
 "color_none_channel_fg" => ["none_channel_fg", "color", "foreground color for none channel buffer (e.g.: core/server/plugin buffer)", "", 0, 0,"default", "default", 0, "", "","buffers_signal_config", "", "", ""],
 "color_none_channel_bg" => ["none_channel_bg", "color", "background color for none channel buffer (e.g.: core/server/plugin buffer)", "", 0, 0,"default", "default", 0, "", "","buffers_signal_config", "", "", ""],
 "queries_default_fg" => ["queries_default_fg", "color", "foreground color for query buffer without message", "", 0, 0,"default", "default", 0, "", "","buffers_signal_config", "", "", ""],
 "queries_default_bg" => ["queries_default_bg", "color", "background color for query buffer without message", "", 0, 0,"default", "default", 0, "", "","buffers_signal_config", "", "", ""],
 "queries_message_fg" => ["queries_message_fg", "color", "foreground color for query buffer with unread message", "", 0, 0,"default", "default", 0, "", "","buffers_signal_config", "", "", ""],
 "queries_message_bg" => ["queries_message_bg", "color", "background color for query buffer with unread message", "", 0, 0,"default", "default", 0, "", "","buffers_signal_config", "", "", ""],
 "queries_highlight_fg" => ["queries_highlight_fg", "color", "foreground color for query buffer with unread highlight", "", 0, 0,"default", "default", 0, "", "","buffers_signal_config", "", "", ""],
 "queries_highlight_bg" => ["queries_highlight_bg", "color", "background color for query buffer with unread highlight", "", 0, 0,"default", "default", 0, "", "","buffers_signal_config", "", "", ""],
);

my %default_options_look =
(
 "look_whitelist_buffers" =>    ["whitelist_buffers", "string", "comma separated list of buffers for using a differnt color scheme (for example: freenode.#weechat,freenode.#weechat-fr)", "", 0, 0,"", "", 0, "", "", "buffers_signal_config_whitelist", "", "", ""],
 "hide_merged_buffers"  =>      ["hide_merged_buffers", "boolean", "hide merged buffers", "", 0, 0,"off", "off", 0, "", "", "buffers_signal_config", "", "", ""],
 "indenting"            =>      ["indenting", "integer", "use indenting for channel and query buffers. This option only takes effect if bar is left/right positioned", "off|on|under_name", 0, 0,"off", "off", 0, "", "", "buffers_signal_config", "", "", ""],
 "indenting_number"     =>      ["indenting_number", "boolean", "use indenting for numbers. This option only takes effect if bar is left/right positioned", "", 0, 0,"on", "on", 0, "", "", "buffers_signal_config", "", "", ""],
 "short_names"          =>      ["short_names", "boolean", "display short names (remove text before first \".\" in buffer name)", "", 0, 0,"on", "on", 0, "", "", "buffers_signal_config", "", "", ""],
 "show_number"          =>      ["show_number", "boolean", "display channel number in front of buffername", "", 0, 0,"on", "on", 0, "", "", "buffers_signal_config", "", "", ""],
 "show_number_char"     =>      ["number_char", "string", "display a char after channel number", "", 0, 0,".", ".", 0, "", "", "buffers_signal_config", "", "", ""],
 "show_prefix"          =>      ["prefix", "boolean", "show your prefix for channel", "", 0, 0,"off", "off", 0, "", "", "buffers_signal_config", "", "", ""],
 "show_prefix_empty"    =>      ["prefix_empty", "boolean", "use a placeholder for channels without prefix", "", 0, 0,"on", "on", 0, "", "", "buffers_signal_config", "", "", ""],
 "sort"                 =>      ["sort", "integer", "sort buffer-list by \"number\" or \"name\"", "number|name", 0, 0,"number", "number", 0, "", "", "buffers_signal_config", "", "", ""],
 "core_to_front"        =>      ["core_to_front", "boolean", "core buffer and buffers with free content will be listed first. Take only effect if buffer sort is by name", "", 0, 0,"off", "off", 0, "", "", "buffers_signal_config", "", "", ""],
 "jump_prev_next_visited_buffer" => ["jump_prev_next_visited_buffer", "boolean", "jump to previously or next visited buffer if you click with left/right mouse button on currently visiting buffer", "", 0, 0,"off", "off", 0, "", "", "buffers_signal_config", "", "", ""],
 "name_size_max"        =>      ["name_size_max","integer","maximum size of buffer name. 0 means no limitation","",0,256,0,0,0, "", "", "buffers_signal_config", "", "", ""],
 "name_crop_suffix"     =>      ["name_crop_suffix","string","contains an optional char(s) that is appended when buffer name is shortened","",0,0,"+","+",0,"","","buffers_signal_config", "", "", ""],
 "detach"               =>      ["detach", "integer","detach channel from buffers list after a specific period of time (in seconds) without action (weechat â‰¥ 0.3.8 required)", "", 0, 31536000,0, "number", 0, "", "", "buffers_signal_config", "", "", ""],
 "immune_detach_buffers" =>     ["immune_detach_buffers", "string", "comma separated list of buffers which will not get detached automatically. Good with e.g. BitlBee", "", 0, 0,"", "", 0, "", "", "buffers_signal_config_immune_detach_buffers", "", "", ""],
);
    # section "color"
    my $section_color = weechat::config_new_section($buffers_config_file,"color", 0, 0, "", "", "", "", "", "", "", "", "", "");
    if ($section_color eq "")
    {
        weechat::config_free($buffers_config_file);
        return;
    }
    foreach my $option (keys %default_options_color)
    {
        $options{$option} = weechat::config_new_option($buffers_config_file, $section_color,
        $default_options_color{$option}[0],$default_options_color{$option}[1],$default_options_color{$option}[2],
        $default_options_color{$option}[3],$default_options_color{$option}[4],$default_options_color{$option}[5],
        $default_options_color{$option}[6],$default_options_color{$option}[7],$default_options_color{$option}[8],
        $default_options_color{$option}[9],$default_options_color{$option}[10],$default_options_color{$option}[11],
        $default_options_color{$option}[12],$default_options_color{$option}[13],$default_options_color{$option}[14]);
    }

    # section "look"
    my $section_look = weechat::config_new_section($buffers_config_file,"look", 0, 0, "", "", "", "", "", "", "", "", "", "");
    if ($section_look eq "")
    {
        weechat::config_free($buffers_config_file);
        return;
    }
    foreach my $option (keys %default_options_look)
    {
        $options{$option} = weechat::config_new_option($buffers_config_file, $section_look,
        $default_options_look{$option}[0],$default_options_look{$option}[1],$default_options_look{$option}[2],
        $default_options_look{$option}[3],$default_options_look{$option}[4],$default_options_look{$option}[5],
        $default_options_look{$option}[6],$default_options_look{$option}[7],$default_options_look{$option}[8],
        $default_options_look{$option}[9],$default_options_look{$option}[10],$default_options_look{$option}[11],
        $default_options_look{$option}[12],$default_options_look{$option}[13],$default_options_look{$option}[14]);
    }
}

sub build_buffers
{
    my $str = "";

    # get bar position (left/right/top/bottom)
    my $position = "left";
    my $option_position = weechat::config_get("weechat.bar.buffers.position");
    if ($option_position ne "")
    {
        $position = weechat::config_string($option_position);
    }

    # read hotlist
    my %hotlist;
    my $infolist = weechat::infolist_get("hotlist", "", "");
    while (weechat::infolist_next($infolist))
    {
        $hotlist{weechat::infolist_pointer($infolist, "buffer_pointer")} =
            weechat::infolist_integer($infolist, "priority");
    }
    weechat::infolist_free($infolist);

    # read buffers list
    @buffers_focus = ();
    my @buffers;
    my @current1 = ();
    my @current2 = ();
    my $old_number = -1;
    my $max_number = 0;
    my $max_number_digits = 0;
    my $active_seen = 0;
    $infolist = weechat::infolist_get("buffer", "", "");
    while (weechat::infolist_next($infolist))
    {
        my $buffer;
        my $number = weechat::infolist_integer($infolist, "number");
        if ($number ne $old_number)
        {
            @buffers = (@buffers, @current2, @current1);
            @current1 = ();
            @current2 = ();
            $active_seen = 0;
        }
        if ($number > $max_number)
        {
            $max_number = $number;
        }
        $old_number = $number;
        my $active = weechat::infolist_integer($infolist, "active");
        if ($active)
        {
            $active_seen = 1;
        }
        $buffer->{"pointer"} = weechat::infolist_pointer($infolist, "pointer");
        $buffer->{"number"} = $number;
        $buffer->{"active"} = $active;
        $buffer->{"current_buffer"} = weechat::infolist_integer($infolist, "current_buffer");
        $buffer->{"plugin_name"} = weechat::infolist_string($infolist, "plugin_name");
        $buffer->{"name"} = weechat::infolist_string($infolist, "name");
        $buffer->{"short_name"} = weechat::infolist_string($infolist, "short_name");
        $buffer->{"full_name"} = $buffer->{"plugin_name"}.".".$buffer->{"name"};

        unless( grep {$_ eq $buffer->{"name"}} @immune_detach_buffers )
        {
            my $detach_time = weechat::config_integer( $options{"detach"});
            my $current_time = time();
            # set timer for buffers with no hotlist action
            $buffers_timer{$buffer->{"pointer"}} = $current_time
             if ( not exists $hotlist{$buffer->{"pointer"}}
             and weechat::buffer_get_string($buffer->{"pointer"}, "localvar_type") eq "channel"
             and not exists $buffers_timer{$buffer->{"pointer"}}
             and $detach_time > 0);

            # check for detach
            unless ( $buffer->{"current_buffer"} eq 0
            and not exists $hotlist{$buffer->{"pointer"}}
            and weechat::buffer_get_string($buffer->{"pointer"}, "localvar_type") eq "channel"
            and exists $buffers_timer{$buffer->{"pointer"}}
            and $detach_time > 0
            and $weechat_version >= 0x00030800
            and $current_time - $buffers_timer{$buffer->{"pointer"}} >= $detach_time )
            {
                if ($active_seen)
                {
                    push(@current2, $buffer);
                }
                else
                {
                    push(@current1, $buffer);
                }
            }
        }
        else
        {
                if ($active_seen)
                {
                    push(@current2, $buffer);
                }
                else
                {
                    push(@current1, $buffer);
                }
        }

    }   # while end


    if ($max_number >= 1)
    {
        $max_number_digits = length(int($max_number));
    }
    @buffers = (@buffers, @current2, @current1);
    weechat::infolist_free($infolist);

    # sort buffers by number, name or shortname
    my %sorted_buffers;
    if (1)
    {
        my $number = 0;
        for my $buffer (@buffers)
        {
            my $key;
            if (weechat::config_integer( $options{"sort"} ) eq 1) # number = 0; name = 1
            {
                my $name = $buffer->{"name"};
                $name = $buffer->{"short_name"} if (weechat::config_boolean( $options{"short_names"} ) eq 1);
                if (weechat::config_integer($options{"name_size_max"}) >= 1){
                    $name = encode("UTF-8", substr(decode("UTF-8", $name), 0, weechat::config_integer($options{"name_size_max"})));
                }
                if ( weechat::config_boolean($options{"core_to_front"}) eq 1)
                {
                    if ( (weechat::buffer_get_string($buffer->{"pointer"}, "localvar_type") ne "channel" ) and ( weechat::buffer_get_string($buffer->{"pointer"}, "localvar_type") ne "private") )
                    {
                        my $type = weechat::buffer_get_string($buffer->{"pointer"}, "localvar_type");
                        if ( $type eq "" and $name ne "weechat")
                        {
                            $name = " " . $name
                        }else
                        {
                            $name = "  " . $name;
                        }
                    }
                }
                $key = sprintf("%s%08d", lc($name), $buffer->{"number"});
            }
            else
            {
                $key = sprintf("%08d", $number);
            }
            $sorted_buffers{$key} = $buffer;
            $number++;
        }
    }

    # build string with buffers
    $old_number = -1;
    foreach my $key (sort keys %sorted_buffers)
    {
        my $buffer = $sorted_buffers{$key};
        if ( (weechat::config_boolean( $options{"hide_merged_buffers"} ) eq 1) && (! $buffer->{"active"}) )
        {
            next;
        }
        push(@buffers_focus, $buffer);                                          # buffer > buffers_focus, for mouse support
        my $color = "";
        my $bg = "";

        $color = weechat::config_color( $options{"color_default_fg"} );
        $bg = weechat::config_color( $options{"color_default_bg"} );

        if ( weechat::buffer_get_string($buffer->{"pointer"}, "localvar_type") eq "private" )
        {
            if ( (weechat::config_color($options{"queries_default_bg"})) ne "default" || (weechat::config_color($options{"queries_default_fg"})) ne "default" )
            {
              $bg = weechat::config_color( $options{"queries_default_bg"} );
              $color = weechat::config_color( $options{"queries_default_fg"} );
            }
        }
        # check for core and buffer with free content
        if ( (weechat::buffer_get_string($buffer->{"pointer"}, "localvar_type") ne "channel" ) and ( weechat::buffer_get_string($buffer->{"pointer"}, "localvar_type") ne "private") )
        {
            $color = weechat::config_color( $options{"color_none_channel_fg"} );
            $bg = weechat::config_color( $options{"color_none_channel_bg"} );
        }
        # default whitelist buffer?
        if (grep {$_ eq $buffer->{"name"}} @whitelist_buffers)
        {
                $color = weechat::config_color( $options{"color_whitelist_default_fg"} );
                $bg = weechat::config_color( $options{"color_whitelist_default_bg"} );
        }

        $color = "default" if ($color eq "");

        # color for channel and query buffer
        if (exists $hotlist{$buffer->{"pointer"}})
        {
        delete $buffers_timer{$buffer->{"pointer"}};
            # check if buffer is in whitelist buffer
            if (grep {$_ eq $buffer->{"name"}} @whitelist_buffers)
            {
                $bg = weechat::config_color( $options{"color_whitelist_".$hotlist_level{$hotlist{$buffer->{"pointer"}}}."_bg"} );
                $color = weechat::config_color( $options{"color_whitelist_".$hotlist_level{$hotlist{$buffer->{"pointer"}}}."_fg"} );
            }
            elsif ( weechat::buffer_get_string($buffer->{"pointer"}, "localvar_type") eq "private" )
            {
                # queries_default_fg/bg and buffers.color.queries_message_fg/bg
                if ( (weechat::config_color($options{"queries_highlight_fg"})) ne "default" ||
                      (weechat::config_color($options{"queries_highlight_bg"})) ne "default" ||
                       (weechat::config_color($options{"queries_message_fg"})) ne "default" ||
                        (weechat::config_color($options{"queries_message_bg"})) ne "default" )
                {
                  if ( ($hotlist{$buffer->{"pointer"}}) == 2 )
                  {
                      $bg = weechat::config_color( $options{"queries_message_bg"} );
                      $color = weechat::config_color( $options{"queries_message_fg"} );
                  }

                  elsif ( ($hotlist{$buffer->{"pointer"}}) == 3 )
                  {
                      $bg = weechat::config_color( $options{"queries_highlight_bg"} );
                      $color = weechat::config_color( $options{"queries_highlight_fg"} );
                  }
                }else
                {
                      $bg = weechat::config_color( $options{"color_hotlist_".$hotlist_level{$hotlist{$buffer->{"pointer"}}}."_bg"} );
                      $color = weechat::config_color( $options{"color_hotlist_".$hotlist_level{$hotlist{$buffer->{"pointer"}}}."_fg"}  );
                }
            }else
            {
                      $bg = weechat::config_color( $options{"color_hotlist_".$hotlist_level{$hotlist{$buffer->{"pointer"}}}."_bg"} );
                      $color = weechat::config_color( $options{"color_hotlist_".$hotlist_level{$hotlist{$buffer->{"pointer"}}}."_fg"}  );
            }
        }

        if ($buffer->{"current_buffer"})
        {
            $color = weechat::config_color( $options{"color_current_fg"} );
            $bg = weechat::config_color( $options{"color_current_bg"} );
        }
        my $color_bg = "";
        $color_bg = weechat::color(",".$bg) if ($bg ne "");

        # create channel number for output
        if ( weechat::config_boolean( $options{"show_number"} ) eq 1 )   # on
        {
            if (( weechat::config_boolean( $options{"indenting_number"} ) eq 1)
                && (($position eq "left") || ($position eq "right")))
            {
                $str .= weechat::color("default").$color_bg
                    .(" " x ($max_number_digits - length(int($buffer->{"number"}))));
            }
            if ($old_number ne $buffer->{"number"})
            {
                $str .= weechat::color( weechat::config_color( $options{"color_number"} ) )
                    .$color_bg
                    .$buffer->{"number"}
                    .weechat::color("default")
                    .$color_bg
                    .weechat::color( weechat::config_color( $options{"color_number_char"} ) )
                    .weechat::config_string( $options{"show_number_char"} )
                    .$color_bg;
            }
            else
            {
                my $indent = "";
                $indent = ((" " x length($buffer->{"number"}))." ") if (($position eq "left") || ($position eq "right"));
                $str .= weechat::color("default")
                    .$color_bg
                    .$indent;
            }
        }

        if (( weechat::config_integer( $options{"indenting"} ) ne 0 )            # indenting NOT off
            && (($position eq "left") || ($position eq "right")))
        {
            my $type = weechat::buffer_get_string($buffer->{"pointer"}, "localvar_type");
            if (($type eq "channel") || ($type eq "private"))
            {
                if ( weechat::config_integer( $options{"indenting"} ) eq 1 )
                {
                    $str .= "  ";
                }
                elsif ( (weechat::config_integer($options{"indenting"}) eq 2) and (weechat::config_integer($options{"indenting_number"}) eq 0) )        #under_name
                {
                    if ( weechat::config_boolean( $options{"show_number"} ) eq 0 )
                    {
                      $str .= "  ";
                    }else
                    {
                      $str .= ( (" " x ( $max_number_digits - length($buffer->{"number"}) ))." " );
                    }
                }
            }
        }
        if (weechat::config_boolean( $options{"show_prefix"} ) eq 1)
        {
            my $nickname = weechat::buffer_get_string($buffer->{"pointer"}, "localvar_nick");
            if ($nickname ne "")
            {
                # with version >= 0.3.2, this infolist will return only nick
                # with older versions, whole nicklist is returned for buffer, and this can be very slow
                my $infolist_nick = weechat::infolist_get("nicklist", $buffer->{"pointer"}, "nick_".$nickname);
                if ($infolist_nick ne "")
                {
                    my $version = weechat::info_get("version_number", "");
                    $version = 0 if ($version eq "");
                    while (weechat::infolist_next($infolist_nick))
                    {
                        if ((weechat::infolist_string($infolist_nick, "type") eq "nick")
                            && (weechat::infolist_string($infolist_nick, "name") eq $nickname))
                        {
                            my $prefix = weechat::infolist_string($infolist_nick, "prefix");
                            if (($prefix ne " ") or (weechat::config_boolean( $options{"show_prefix_empty"} ) eq 1))
                            {
                                # with version >= 0.3.5, it is now a color name (for older versions: option name with color)
                                if (int($version) >= 0x00030500)
                                {
                                    $str .= weechat::color(weechat::infolist_string($infolist_nick, "prefix_color"));
                                }
                                else
                                {
                                    $str .= weechat::color(weechat::config_color(
                                                               weechat::config_get(
                                                                   weechat::infolist_string($infolist_nick, "prefix_color"))));
                                }
                                $str .= $prefix;
                            }
                            last;
                        }
                    }
                    weechat::infolist_free($infolist_nick);
                }
            }
        }
        $str .= weechat::color($color) . weechat::color(",".$bg);
        if (weechat::config_boolean( $options{"short_names"} ) eq 1)
        {
            if (weechat::config_integer($options{"name_size_max"}) >= 1)                # check max_size of buffer name
            {
                $str .= encode("UTF-8", substr(decode("UTF-8", $buffer->{"short_name"}), 0, weechat::config_integer($options{"name_size_max"})));
                $str .= weechat::color(weechat::config_color( $options{"color_number_char"})).weechat::config_string($options{"name_crop_suffix"}) if (length($buffer->{"short_name"}) > weechat::config_integer($options{"name_size_max"}));
            }
            else
            {
                $str .= $buffer->{"short_name"};
            }
        }
        else
        {
            if (weechat::config_integer($options{"name_size_max"}) >= 1)                # check max_size of buffer name
            {
                $str .= encode("UTF-8", substr(decode("UTF-8", $buffer->{"name"},), 0, weechat::config_integer($options{"name_size_max"})));
                $str .= weechat::color(weechat::config_color( $options{"color_number_char"})).weechat::config_string($options{"name_crop_suffix"}) if (length($buffer->{"name"}) > weechat::config_integer($options{"name_size_max"}));
            }
            else
            {
                $str .= $buffer->{"name"};
            }
        }
        $str .= "\n";
        $old_number = $buffer->{"number"};
    }

    return $str;
}

sub buffers_signal_buffer
{
my ($data, $signal, $signal_data) = @_;
    # check for buffer_switch and set the detach time or remove detach time
    if ($weechat_version >= 0x00030800)
    {
        if ($signal eq "buffer_switch")
        {
            my $pointer = weechat::hdata_get_list (weechat::hdata_get("buffer"), "gui_buffer_last_displayed"); # get switched buffer
            my $current_time = time();
            if ( weechat::buffer_get_string($pointer, "localvar_type") eq "channel")
            {
                $buffers_timer{$pointer} = $current_time;
            }
            else
            {
                delete $buffers_timer{$pointer};
            }
        }
        if ($signal eq "buffer_opened")
        {
            my $current_time = time();
            $buffers_timer{$signal_data} = $current_time;
        }
        if ($signal eq "buffer_closing")
        {
            delete $buffers_timer{$signal_data};
        }
    }

    weechat::bar_item_update("buffers");
    return weechat::WEECHAT_RC_OK;
}

sub buffers_signal_hotlist
{
    weechat::bar_item_update("buffers");
    return weechat::WEECHAT_RC_OK;
}


sub buffers_signal_config_whitelist
{
    @whitelist_buffers = ();
    @whitelist_buffers = split( /,/, weechat::config_string( $options{"look_whitelist_buffers"} ) );
    weechat::bar_item_update("buffers");
    return weechat::WEECHAT_RC_OK;
}
sub buffers_signal_config_immune_detach_buffers
{
    @immune_detach_buffers = ();
    @immune_detach_buffers = split( /,/, weechat::config_string( $options{"immune_detach_buffers"} ) );
    weechat::bar_item_update("buffers");
    return weechat::WEECHAT_RC_OK;
}

sub buffers_signal_config
{
    weechat::bar_item_update("buffers");
    return weechat::WEECHAT_RC_OK;
}

# called when mouse click occured in buffers item: this callback returns buffer
# hash according to line of item where click occured
sub buffers_focus_buffers
{
    my %info = %{$_[1]};
    my $item_line = int($info{"_bar_item_line"});
    undef my $hash;
    if (($info{"_bar_item_name"} eq "buffers") && ($item_line >= 0) && ($item_line <= $#buffers_focus))
    {
        $hash = $buffers_focus[$item_line];
    }
    else
    {
        $hash = {};
        my $hash_focus = $buffers_focus[0];
        foreach my $key (keys %$hash_focus)
        {
            $hash->{$key} = "?";
        }
    }
    return $hash;
}

# called when a mouse action is done on buffers item, to execute action
# possible actions: jump to a buffer or move buffer in list (drag & drop of buffer)
sub buffers_hsignal_mouse
{
    my ($data, $signal, %hash) = ($_[0], $_[1], %{$_[2]});
    my $current_buffer = weechat::buffer_get_integer(weechat::current_buffer(), "number"); # get current buffer number

    if ( $hash{"_key"} eq "button1" )           # left mouse button
    {
      if ($hash{"number"} eq $hash{"number2"})
        {
            if ( weechat::config_integer($options{"jump_prev_next_visited_buffer"}) eq 1 )
            {
                if ( $current_buffer eq $hash{"number"} )
                {
                    weechat::command("","/input jump_previously_visited_buffer");
                }
                else
                {
                    weechat::command("", "/buffer ".$hash{"full_name"});
                }
            }
            else
            {
                weechat::command("", "/buffer ".$hash{"full_name"});
            }
        }
        else
        {
            move_buffer(%hash);
        }
    }
    elsif ( ($hash{"_key"} eq "button2") && (weechat::config_integer($options{"jump_prev_next_visited_buffer"}) eq 1) )# right mouse button
    {
        if ( $current_buffer eq $hash{"number2"} )
        {
            weechat::command("","/input jump_next_visited_buffer");
        }
    }
    else
    {
            move_buffer(%hash);
    }
}
sub move_buffer
{
  my %hash = @_;
  my $number2 = $hash{"number2"};
  if ($number2 eq "?")
  {
      # if number 2 is not known (end of gesture outside buffers list), then set it
      # according to mouse gesture
      $number2 = "999999";
      $number2 = "1" if (($hash{"_key"} =~ /gesture-left/) || ($hash{"_key"} =~ /gesture-up/));
  }
  my $ptrbuf = weechat::current_buffer();
  weechat::command($hash{"pointer"}, "/buffer move ".$number2);
}