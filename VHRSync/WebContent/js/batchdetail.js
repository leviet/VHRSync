$(document).ready(function(){
	var locationSearch = location.search;
	var batchId = parseInt(locationSearch.split("=")[1]);
	if(batchId>0){
		$('.table-striped').block({ message: '<h1><img src="img/spinner-mini.gif" /> Đang tải dữ liệu...</h1>' });
		var requestDetail = $.ajax({
			url: "/VHRSync/BatchDetail?action=viewDetail&BatchId="+batchId
		});
		requestDetail.done(function(data){
			data = $.parseJSON(data);
			var columnOutgoingBatch = new Array();
			var columnIncomingError = new Array();
			var columnData = new Array();
			$.each(data.outgoing_batch.column, function(index, n){
				var col = {"title": n};
				columnOutgoingBatch.push(col);
			});
			$.each(data.incoming_error.column, function(index, n){
				var col = {"title": n};
				columnIncomingError.push(col);
			});
			$.each(data.data.column, function(index, n){
				var col = {"title": n};
				columnData.push(col);
			});
			var outgoing_table = $(".ougoing-batch-table").DataTable({
				"data": data.outgoing_batch.table,
				"columns": columnOutgoingBatch,
				"language": {
            		"url": "/VHRSync/language/datatable.json"
        		},
				"scrollX": true
			});
			var error_table = $(".incomming-error-table").DataTable({
				"data": data.incoming_error.table,
				"columns": columnIncomingError,
				"language": {
            		"url": "/VHRSync/language/datatable.json"
        		},
				"scrollX": true
			});
			var data_table = $(".data-table").DataTable({
				"data": data.data.table,
				"columns": columnData,
				"language": {
            		"url": "/VHRSync/language/datatable.json"
        		},
				"scrollX": true
			});
			$('.table-striped').unblock();
			$('.box-content').css("float","left");
			$(".box-content").width($(".box-header").width());
		})
	}else{
		alert("BatchID không hợp lệ");
		window.location("Dashboard.html");
	}
});