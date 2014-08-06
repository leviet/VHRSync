$(document).ready(function(){
	$(".sync-emp-timekeeping").click(function(event){
		event.preventDefault();
		$.blockUI({ message: '<h1><img src="img/spinner-mini.gif" /> Đang gửi yêu cầu...</h1>' });
		var fromDate = $("#from-date").val();
		var toDate = $("#to-date").val();
		var request = $.ajax({
		  url: "/VHRSync/ReloadEmployeeTimeKeeping?action=syncTimeKeeping&fromDate="+fromDate+"&toDate="+toDate,
		  type: "POST"
		});
		request.done(function(data){
			$.unblockUI();
			$(".message-sync").html(data);
			$('#myModal').modal('show');
		});
	});
	$(".add-request-sync").click(function(){
		$('#add-request-popup').modal('show');
	});
	// $('.table-gsync-time-keeping').block({ message: '<h1><img src="img/spinner-mini.gif" /> Đang tải dữ liệu...</h1>' });
	// var request = $.ajax({
	// 	  url: "/VHRSync/Dashboard",
	// 	  type: "GET"
	// 	});
	// request.done(function(data){
	// 	var dataSet= $.parseJSON(data);
	// 	$.each(dataSet, function(i, n) { n.unshift(0); });
	$('.table-gsync-time-keeping').block({ message: '<h1><img src="img/spinner-mini.gif" /> Đang tải dữ liệu...</h1>' });
	var request = $.ajax({
		  url: "/VHRSync/ReloadEmployeeTimeKeeping?action=initLoad",
		  type: "GET"
		});
		request.done(function(data){
			var columns = new Array();
			$.each(data.columns, function(index, n){
				var col = {"title": n};
				columns.push(col);
			});
			$('.table-gsync-time-keeping').DataTable( {
		    	"data": data.tableData,
		    	"columns": columns,
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
				"aaSorting": [[ 1, 'asc' ]]
			});
			$('.table-gsync-time-keeping').unblock();
			$('.table-content').css("float","left");
		});
    	
    	$.ajax({
			url: '/VHRSync/ReloadEmployeeTimeKeeping?action=getListUser',
			data: "",
			dataType: "JSON",
			type: 'GET',
			success: function(data){
			var get_rc=data;
			$('#user-request').empty();
			$.each(get_rc, function(i, value) {
				//$(‘<option>’).val(value).text(value).appendTo(‘#selectError1′);
				//OR shortly use:
				$('#user-request').append( new Option(value,value) );
				//note: new Option(text to show, value to return);
				$('#user-request').trigger('liszt:updated');
				//we need to trigger because after every updating option,
				//we need to notify chosen.
				 });  
			}
		});

	$.ajax({
			url: '/VHRSync/ReloadEmployeeTimeKeeping?action=getListSource',
			data: "",
			dataType: "JSON",
			type: 'GET',
			success: function(data){
			var get_rc=data;
			$('#data-source').empty();
			$.each(get_rc, function(i, value) {
				//$(‘<option>’).val(value).text(value).appendTo(‘#selectError1′);
				//OR shortly use:
				$('#data-source').append( new Option(value,value) );
				//note: new Option(text to show, value to return);
				$('#data-source').trigger('liszt:updated');
				//we need to trigger because after every updating option,
				//we need to notify chosen.
			});  
		}
	});
	// });

	$("#button-search").click(function(event){
		event.preventDefault();
		var oTable = $('.table-gsync-time-keeping').DataTable();
		oTable.clear().draw();
		var fromDate = $("#from-date-search").val();
		var toDate = $("#to-date-search").val();
		var userRequest = $("#user-request").val();
		var sourceNode = $("#data-source").val();
		$('.table-gsync-time-keeping').block({ message: '<h1><img src="img/spinner-mini.gif" /> Đang tải dữ liệu...</h1>' });
		var request = $.ajax({
		  url: "/VHRSync/ReloadEmployeeTimeKeeping?action=search&fromDate="+fromDate+"&toDate="+toDate+"&userRequest="+userRequest+"&sourceNode="+sourceNode,
		  type: "GET"
		});
		request.done(function(data){
			oTable.rows.add(data.tableData).draw();
			$('.table-gsync-time-keeping').unblock();
		});
	});
});