// $(function() {
//   // 現在の年月日を取得
//   var time = new Date();
//   var year = time.getFullYear();
//   var month = time.getMonth() + 1;
//   var date = time.getDate();

//   // 選択された年月日を取得
//   var selected_year = document.getElementById("year").value;
//   var selected_month = document.getElementById("month").value;

//   // 年(初期): 1900〜現在の年 の値を設定
//   for (var i = year; i >= 1900 ; i--) {
//       $('#year').append('<option value="' + i + '">' + i + '</option>');
//   }

//   // 月(初期): 1~12 の値を設定
//   for (var j = 1; j <= 12; j++) {
//       $('#month').append('<option value="' + j + '">' + j + '</option>');
//   }

//   // 日(初期): 1~31 の値を設定
//   for (var k = 1; k <= 31; k++) {
//       $('#date').append('<option value="' + k + '">' + k + '</option>');
//   }

//   // 月(変更)：選択された年に合わせて、適した月の値を選択肢にセットする
//   $('#year').change(function() {
//       selected_year = $('#year').val();

//       // 現在の年が選択された場合、月の選択肢は 1~現在の月 に設定
//       // それ以外の場合、1~12 に設定
//       var last_month = 12;
//       if (selected_year == year) {
//           last_month = month;
//       }
//       $('#month').children('option').remove();
//       $('#month').append('<option value="' + 0 + '">--</option>');
//       for (var n = 1; n <= last_month; n++) {
//           $('#month').append('<option value="' + n + '">' + n + '</option>');
//       }
//   });

//   // 日(変更)：選択された年・月に合わせて、適した日の値を選択肢にセットする
//   $('#year,#month').change(function() {
//       selected_year = $('#year').val();
//       selected_month = $('#month').val();

//       // 現在の年・月が選択された場合、日の選択肢は 1~現在の日付 に設定
//       // それ以外の場合、各月ごとの最終日を判定し、1~最終日 に設定
//       if (selected_year == year && selected_month == month ) {
//           var last_date = date;
//       }else{
//           // 2月：日の選択肢は1~28日に設定
//           // ※ ただし、閏年の場合は29日に設定
//           if (selected_month == 2) {
//               if((Math.floor(selected_year%4 == 0)) && (Math.floor(selected_year%100 != 0)) || (Math.floor(selected_year%400 == 0))){
//                   last_date = 29;
//               }else{
//                   last_date = 28;
//               }

//           // 4, 6, 9, 11月：日の選択肢は1~30日に設定
//           }else if(selected_month == 4 || selected_month == 6 || selected_month == 9 || selected_month == 11 ){
//               last_date = 30;

//           // 1, 3, 5, 7, 8, 10, 12月：日の選択肢は1~31日に設定
//           }else{
//               last_date = 31;
//           }
//       }

//       $('#date').children('option').remove();
//       $('#date').append('<option value="' + 0 + '">--</option>');
//       for (var m = 1; m <= last_date; m++) {
//           $('#date').append('<option value="' + m + '">' + m + '</option>');
//       }
//   });
// });

$(document).on('turbolinks:load', function () {
  // ユーザーの誕生日の閏年を動的に変化させる
  // 誕生日の配列を宣言
  var birth_year = [];
  var birth_month = [];
  var months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  // 現在の年を取得する
  var date = new Date();
  var this_year = date.getFullYear();
  var oldest_year = 1900;

  // 誕生年月の配列を自動生成
  for (var i = this_year; i >= oldest_year; i--) {
    var year = { var: i, txt: String(i) };
    birth_year.push(year);
  }
  for (var i = 1; i <= 12; i++) {
    var month = { var: i, txt: String(i) };
    birth_month.push(month);
  }
  // hamlの年と月のセレクトボックスに配列内容を反映させる
  for (var i = 0; i < birth_year.length; i++) {
    $("<option>", {
      value: birth_year[i].var,
      text: birth_year[i].txt
    }).appendTo('#select_birth_year');
  }
  for (var i = 0; i < birth_month.length; i++) {
    $("<option>", {
      value: birth_month[i].var,
      text: birth_month[i].txt
    }).appendTo('#select_birth_month');
  }

  // 年、もしくは月のセレクトボックスの中身に変更があったら日の内容を変更する
  $('#select_birth_year, #select_birth_month').change(function () {
    // 日が入っているセレクトボックスの中身を空っぽにする
    $('#select_birth_day').empty();
    // 日が入るセレクトボックスにデフォルト値の'--'を入れる
    $("<option>", {
      text: '--'
    }).appendTo('#select_birth_day');
    // ２月の日にち、すなわちmonths[1]を28にセットし直す
    months[1] = 28;
    //　年と月に入力されている情報を取得する
    var year = $('#select_birth_year').val();
    var month = $("#select_birth_month").val();
    // yearとmonth共に数字が入力されている、すなわち共に'--'でないときに実行
    if (year != '--' && month != '--') {
      // monthに２月が選択されている時実行
      if (month == 2) {
        // yearが閏年の時、2月の日付が格納されているmonths[1]の値を29にする
        if (year % 4 == 0 && year % 100 == 0 && year % 400 == 0) {
          months[1] = 29;
        }
      }
      // 日を入れる配列を宣言し、閏年を考慮したデータを格納してhamlの日の
      // セレクトボックスに反映させる
      var birth_day = []
      for (var i = 1; i <= months[month - 1]; i++) {
        var day = { var: i, txt: String(i) };
        birth_day.push(day);
      }
      for (var i = 0; i < birth_day.length; i++) {
        $("<option>", {
          value: birth_day[i].var,
          text: birth_day[i].txt
        }).appendTo('#select_birth_day');
      };
    };
  });
});