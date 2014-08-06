google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(drawChart);
function drawChart() {
  var data = google.visualization.arrayToDataTable([
    ['Thời gian', 'Nhân viên', 'Danh mục', 'Đơn vị'],
    ['2013',  1000,      400, 500],
    ['2014',  1170,      460, 250],
    ['2015',  660,       1120, 900],
    ['2016',  1030,      540, 600]
  ]);

  var options = {
    title: 'Thống kê dữ liệu đồng bộ',
    hAxis: {title: 'Thời gian',  titleTextStyle: {color: '#333'}},
    vAxis: {title: 'Số bản ghi',minValue: 0}
  };

  var chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
  chart.draw(data, options);
}