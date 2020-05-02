/*
* Copyright (c) 2019 brombinmirko (https://linuxhub.it)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: brombinmirko <send@mirko.pm>
*/

public class Shouldidoit.MainWindow : Gtk.ApplicationWindow
{
    private Gtk.Label answer;
    private Gtk.Label answer_text;
    private Gtk.Box main;
    private Gtk.CssProvider css_provider;

    construct
    {
        get_style_context ().add_class ("rounded");
        // set_keep_below (true);

        // set default window size
        set_size_request (450, 350);
        set_resizable (false);

        css_provider = new Gtk.CssProvider ();

        // custom style
        set_css ("#a3be8c", "#7f936d");

        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_USER);

        // create refresh button
        var refresh_button = new Gtk.Button.from_icon_name ("view-refresh-symbolic");

        refresh_button.clicked.connect (() => {
            gen_choice ();
        });

        // create close button
        var close_button = new Gtk.Button.from_icon_name ("close-symbolic");

        close_button.clicked.connect (() => {
            this.destroy ();
        });

        // create main box
        main = new Gtk.Box (Gtk.Orientation.VERTICAL, 10);

        // create elements for answer data
        answer = new Gtk.Label (_("Yes"));
        answer.get_style_context ().add_class ("answer");

        answer_text = new Gtk.Label (_("You should do it!"));
        answer_text.get_style_context ().add_class ("answer_text");

        main.add (answer);
        main.add (answer_text);

        // spacer
        var spacer = new Gtk.Grid ();
        spacer.height_request = 3;

        // headerbar
        var headerbar = new Gtk.HeaderBar ();
        headerbar.pack_start (refresh_button);
        headerbar.pack_end (close_button);
        headerbar.set_custom_title (spacer);

        var headerbar_style_context = headerbar.get_style_context ();
        headerbar_style_context.add_class ("default-decoration");
        headerbar_style_context.add_class (Gtk.STYLE_CLASS_FLAT);

        add (main);
        set_titlebar (headerbar);

        gen_choice ();
    }


    private void set_css (string bg_hex, string fg_hex)
    {
        css_provider.load_from_data(""
            + ".titlebar, .background { background-color: " + bg_hex
            + "; color: #ffffff; border: none; text-shadow: 1px 1px " + fg_hex + "}"
            + ".answer { font-size: 32px; margin-top: 20px;}"
            + ".answer_text { font-size: 22px;}"
        );
    }

    private void gen_choice ()
    {
        int random = Random.int_range(1, 10);

        if ((random % 2) == 0)
        {
            answer.set_text (_("No 👎🏼"));
            answer_text.set_text (_("You shouldn't do it!"));
            set_css ("#bf616a", "#9e555c");
        }
        else
        {
            answer.set_text (_("Yes 👍🏼"));
            answer_text.set_text (_("You should do it!"));
            set_css ("#a3be8c", "#7f936d");
        }
    }
}
