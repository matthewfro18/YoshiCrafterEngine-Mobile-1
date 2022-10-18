package funkin.scripting.events;

import funkin.game.Note;
import funkin.game.Character;

class NoteHitEvent extends CancellableEvent {
    @:dox(hide) public var animCancelled:Bool = false;
    @:dox(hide) public var deleteNote:Bool = true;
    @:dox(hide) public var unmuteVocals:Bool = true;
    @:dox(hide) public var enableCamZooming:Bool = true;

    /**
        Whenever a miss should be added.
    **/
    public var misses:Bool = true;
    /**
     * Note that has been pressed
     */
    public var note:Note;
    /**
     * Character that pressed the note
     */
    public var character:Character;
    /**
     * Whenever the Character is the player
     */
    public var player:Bool;
    /**
     * Note Type name (null if default note)
     */
    public var noteType:String;
    /**
     * Direction of the press (0 = Left, 1 = Down, 2 = Up, 3 = Right)
     */
    public var direction:Int;
    /**
     * Score gained after note press.
     */
    public var score:Int;
    /**
     * The amount of health that'll be gained from pressing that note. If called from `onNoteMiss`, the value will be negative.
     */
    public var healthGain:Float;

    /**
     * Creates a new NoteHitEvent.
     */
    public function new(note:Note, character:Character, player:Bool, noteType:String, direction:Int, healthGain:Float, unmuteVocals:Bool = true, score:Int = 350) {
        super();

        this.note = note;
        this.character = character;
        this.player = player;
        this.noteType = noteType;
        this.direction = direction;
        this.healthGain = healthGain;
        this.unmuteVocals = unmuteVocals;
        this.score = score;
    }

    /**
     * Prevents the default sing animation from being played.
     */
    public function preventAnim() {
        animCancelled = true;
    }

    @:dox(hide)
    public function cancelAnim() {preventAnim();}

    /**
     * Prevents the note from being deleted.
     */
    public function preventDeletion() {
        deleteNote = false;
    }
    @:dox(hide)
    public function cancelDeletion() {preventDeletion();}

    /**
     * Prevents the vocals volume from being set to 1 after pressing the note.
     */
    public function preventVocalsUnmute() {
        unmuteVocals = false;
    }
    @:dox(hide)
    public function cancelVocalsUnmute() {preventVocalsUnmute();}

    /**
     * Prevents the vocals volume from being muted in case its a parameter of `onNoteMiss`
     */
    public function preventVocalsMute() {
        unmuteVocals = true;
    }
    @:dox(hide)
    public function cancelVocalsMute() {preventVocalsMute();}

    /**
     * Prevents the camera zoom every 4 beats from enabling.
     */
    public function preventCamZooming() {
        enableCamZooming = false;
    }
    @:dox(hide)
    public function cancelCamZooming() {preventCamZooming();}
}