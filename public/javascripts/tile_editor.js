

TileEditor = {
	
	activeTile: null,
	painting: false,
	
	elemID: function(id) {
	  id = id.id;
	  var elems = id.split("_");
      return elems[elems.length-1];
	},
	
	setupEditor: function() {
		
		$('.definition').bind('click',function(event) {
			$('#definition_' + TileEditor.activeTile).removeClass('selected_definition');
			TileEditor.activeTile = TileEditor.elemID(this);
			$(this).addClass('selected_definition');
				
			});
		$('.edit_tile').bind('click',TileEditor.setTile);
		$('.edit_tile').bind('mousedown',TileEditor.startTile);
		$('.edit_tile').bind('mouseup',TileEditor.endTile);
		$('.edit_tile').bind('mouseenter',TileEditor.paintTile);

	},
	
	setTile: function(event) {
		$(this).children("input.tile_data")[0].value = TileEditor.activeTile;
		
		$(this).children("img")[0].src = $('#definition_' + TileEditor.activeTile).children("img")[0].src;
	},
	
	startTile: function(event) {
		TileEditor.painting=true;
		return false;
	},
	
	endTile: function(event) {
		TileEditor.painting=false;
		return false;
	},
	
	paintTile: function(event) {
		if(TileEditor.painting) {
			var td = this;
			var meth = TileEditor.setTile;
			meth.call(td,event);
		} else { return false; }
		
	}
}

document.onselectstart=new Function ("return false");

$(function() { TileEditor.setupEditor(); });
