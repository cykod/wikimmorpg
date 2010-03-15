// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

Smorpglish = {
	init:function(everyone,player,room) {
			this.tilesize = 50;
		this.room = room;
	
		this.setupCanvas();
		
		this.room.setup(this.paper);
		
		this.player = new Player(player);
		this.player.setup(this.room,this.paper);
		this.beings = { };
		this.beings[player.id] = this.player;
		this.setupKeybindings();
		
		for(var i=0;i < everyone.length;i++) {
			var person = everyone[i];
			if(player.id != person.id) {
				this.beings[person.id] = new Being(person);
				this.beings[person.id].setup(this.room,this.paper);
			}
			
		}
	

	},
	
	setupCanvas: function() {
		
	  this.paper = Raphael("gameboard",
							this.room.width * this.tilesize, 
							this.room.height * this.tilesize
							)
	},
	
	setupKeybindings: function() {
		var player = this.player;
		
		shortcut.add("Right", function() { player.move(0,1); });
		shortcut.add("Left", function() { player.move(0,-1); });
		shortcut.add("Up", function() { player.move(-1,0); });
		shortcut.add("Down", function() { player.move(1,0); });
	},
	
	animateTo:function(object_id,details) {
		if(this.beings[object_id] && object_id != this.player.object_id) {
			this.beings[object_id].animateTo(details.x,details.y);
		}
	}
}

Room = $.klass({
	initialize:function(room_id,tiles) {
		this.tiles = tiles;
		this.height =tiles.length;
		this.width = tiles[0].length;
	},
	
	setup: function(paper) {
		this.board = paper.set();
		for(var row=0;row<this.height;row++) {
			for(var col=0;col<this.width;col++) {
			  var tl = this.tiles[row][col]
			  tl.img = paper.image(tl.url,
						  col*Smorpglish.tilesize,
						  row*Smorpglish.tilesize,
						  Smorpglish.tilesize,
						  Smorpglish.tilesize);
			  this.board.push(tl.img);
			}
			
		}
		
	},
	
	tryMove: function(row,col) {
		return !this.tiles[row][col].solid;
	 }

});

Being = $.klass({
	initialize: function(details) {
		this.object_id = details.id;
		this.row = details.row;
		this.col = details.col;
		this.details = details;
	},
	moveTo: function(destx,desty) {
	  var destx = destx * Smorpglish.tilesize;
	  var desty = desty *  Smorpglish.tilesize;
	  var player = this;
	  this.image.animate({ x: destx, y: desty },20, function() {  player.moving = false; });

 },

 animateTo: function(destx,desty) {
	  var destx = destx * Smorpglish.tilesize;
	  var desty = desty * Smorpglish.tilesize;
	  this.image.animate({ x: destx, y: desty },200);
 },

 setup: function(room,paper) {
	url = "/images/" + this.details.occupation + ".png";
	this.image = paper.image(
		  url,
		  this.col*Smorpglish.tilesize,
		  this.row*Smorpglish.tilesize,
		  Smorpglish.tilesize,
		  Smorpglish.tilesize);
    room.board.push(this.image);
  }
})

Player = $.klass(Being, {
 initialize: function($super,details) {
	$super(details);
 },


 tryMove: function(diffy,diffx) {
	return Smorpglish.room.tryMove(this.row + diffy,this.col + diffx)
 },

 move: function(diffy,diffx) {
	if(!this.moving && this.tryMove(diffy,diffx)) {
		this.moving = true;
		var player = this;
		
		var destx = this.col + diffx;
		var desty = this.row + diffy;
		this.animateTo(destx,desty);
		jQuery.getJSON('/move' ,{ diffx: diffx, diffy: diffy }, function(d,st) { player.effectMove(d,destx,desty); }  )
	}
 },	

 effectMove: function(moveData,destx,desty) {
	 if(moveData.x) {
   	 	this.col = moveData.x;
	 	this.row = moveData.y;
	}
	 this.moving = false;
	 
	 if(destx != this.col || desty != this.row) {
		 this.moveTo(this.col,this.row);
  	 }
	
 }


});




