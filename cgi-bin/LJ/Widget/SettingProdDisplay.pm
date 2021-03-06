# This code was forked from the LiveJournal project owned and operated
# by Live Journal, Inc. The code has been modified and expanded by
# Dreamwidth Studios, LLC. These files were originally licensed under
# the terms of the license supplied by Live Journal, Inc, which can
# currently be found at:
#
# http://code.livejournal.org/trac/livejournal/browser/trunk/LICENSE-LiveJournal.txt
#
# In accordance with the original license, this code and all its
# modifications are provided under the GNU General Public License.
# A copy of that license can be found in the LICENSE file included as
# part of this distribution.

package LJ::Widget::SettingProdDisplay;

use strict;
use base qw(LJ::Widget);

use Carp qw(croak);

sub render_body {
    my $class = shift;

    my $remote = LJ::get_remote();
    return unless $remote;

    my $body;
    my $title    = LJ::ejs( $class->ml('setting.prod.display.title') );
    my $apache_r = BML::get_request();
    foreach my $prod (@LJ::SETTING_PROD) {
        if ( $apache_r->notes->{codepath} =~ $prod->{codepaths} && $prod->{should_show}->($remote) )
        {
            $body .=
                  "\n<script language='javascript'>setTimeout(\"displaySettingProd('"
                . $prod->{setting} . "', '"
                . $prod->{field} . "', '"
                . $title
                . "')\", 400)</script>\n";
            last;
        }
    }

    return $body;
}

sub need_res {
    qw(js/settingprod.js
        js/ljwidget.js
        js/ljwidget_ippu.js
        js/widget_ippu/settingprod.js
        stc/widgets/settingprod.css
    );
}

1;
