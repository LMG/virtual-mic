#!/usr/bin/gjs

const Lang = imports.lang;
const Gtk = imports.gi.Gtk;


const Application = new Lang.Class({
    Name: 'MixMic',
    
    _init: function() {
        this.application = new Gtk.Application();
        
        this.application.connect('activate', Lang.bind(this, this._onActivate));
        this.application.connect('startup', Lang.bind(this, this._onStartup));
    },
    
    _buildUI: function() {
        this._window = new Gtk.ApplicationWindow({ application: this.application,
                                                    title: "MixMic: mix your mics" });
        this.label = new Gtk.Label({ label: "Hello World" });
        this._window.add(this.label);
        this._window.set_default_size(200, 200);
    },
    
    _onActivate: function() {
        this._window.show_all();
    },
    
    _onStartup: function() {
        this._buildUI();
    }
});

let app = new Application();
app.application.run(ARGV);
