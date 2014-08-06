$(document).ready(function(){
	$('.table-gsync').block({ message: '<h1><img src="img/spinner-mini.gif" /> Đang tải dữ liệu...</h1>' });
		var request = $.ajax({
			  url: "/VHRSync/Dashboard?action=initLoad",
			  type: "GET"
			});
		request.done(function(data){
			var dataSet= data.tableData;
			var mapTable = $.ajax({
			  url: "/VHRSync/data/mapTable.json",
			  type: "GET"
			});
			var dataTableSync = new Array();
			mapTable.done(function(mapData){
				$.each(dataSet, function(i, n) { 
					$.each(mapData.data, function(index, item){
						if(item.table.indexOf(n[2])!=-1){
							n[2] = item.title;
						}
					});
					n.push("<a class='btn btn-success' href='BatchDetail.html?DetailId="+n[0]+"' id='"+n[0]+"'><i class='icon-zoom-in icon-white'></i></a>");
					dataTableSync.push(n);
				});
				var table = $('.table-gsync').DataTable( {
	        	"data": dataTableSync,
	        	"language": {
	            	"url": "/VHRSync/language/datatable.json"
	        	},
	        	"fnDrawCallback": function ( oSettings ) {
					/* Need to redo the counters if filtered or sorted */
					if ( oSettings.bSorted || oSettings.bFiltered )
					{
						for ( var i=0, iLen=oSettings.aiDisplay.length ; i<iLen ; i++ )
						{
							$('td:eq(0)', oSettings.aoData[ oSettings.aiDisplay[i] ].nTr ).html( i+1 );
						}
					}
				},
				"aoColumnDefs": [
					{ "bSortable": false, "aTargets": [ 0 ] }
				],
				"aaSorting": [[ 1, 'asc' ]],
				"columns": [
		            { "title": "STT", "width":"40px", "class": "center"},
		            { "title": "Node", "width":"40px", "class": "center"},
		            { "title": "Bảng đồng bộ" },
		            { "title": "Sự kiện" },
		            { "title": "Số bản ghi"},
		            { "title": "Thời gian bắt đầu"},
		            { "title": "Thời gian kết thúc"},
		            { "title": "Trạng thái", "class": "center" },
		            { "title": "Chi tiết", "class": "center", "width":"60px" }
	        	]
	    	});
		});
		
    	$('.table-gsync').unblock();
    	$('.table-content').css("float","left");
	});
	
	$("#button-search-dashboard").click(function(event){
		event.preventDefault();
		var oTable = $('.table-gsync').DataTable();
		oTable.clear().draw();
		$('.table-gsync').block({ message: '<h1><img src="img/spinner-mini.gif" /> Đang tải dữ liệu...</h1>' });
		var fromDate = $("#from-date").val();
		var toDate = $("#to-date").val();
		var tableSearch = $("#selectTypeData").val();
		var status = $("#selectStatus").val();
		var request = $.ajax({
				url: "/VHRSync/Dashboard?action=search&fromDate="+fromDate+"&toDate="+toDate+"&tableSearch="+tableSearch+"&status="+status,
				type: "GET"
			});
		request.done(function(data){
			var dataSet= data.tableData;
			var mapTable = $.ajax({
			  url: "/VHRSync/data/mapTable.json",
			  type: "GET"
			});
			var dataTableSync = new Array();
			mapTable.done(function(mapData){
				$.each(dataSet, function(i, n) { 
					$.each(mapData.data, function(index, item){
						if(item.table.indexOf(n[2])!=-1){
							n[2] = item.title;
						}
					});
					n.push("<a class='btn btn-success' href='BatchDetail.html?DetailId="+n[0]+"' id='"+n[0]+"'><i class='icon-zoom-in icon-white'></i></a>");
					dataTableSync.push(n);
				});
				oTable.rows.add(dataTableSync).draw();
			});
			
	    	$('.table-gsync').unblock();
	    	$('.table-content').css("float","left");
		});
	});
	$.ajax({
			url: '/VHRSync/Dashboard?action=getOption',
			data: "",
			dataType: "JSON",
			type: 'GET',
			success: function(data){
			var get_rc=data;
			$('#selectTypeData').empty();
			$.each(get_rc, function(i, value) {
				//$(‘<option>’).val(value).text(value).appendTo(‘#selectError1′);
				//OR shortly use:
				$('#selectTypeData').append( new Option(value,value) );
				//note: new Option(text to show, value to return);
				$('#selectTypeData').trigger('liszt:updated');
				//we need to trigger because after every updating option,
				//we need to notify chosen.
			});  
		}
	}); 
});