// 入力された価格に応じて販売手数料と販売利益の計算
$(function(){
  $(document).on("input", '#price_calc', function(){    //リアルタイムで表示したいのでinputを使う、入力の度にイベントが発火するようになる
    var data = $('#price_calc').val(); //val()でフォームのvalueを取得(数値)
    var profit = Math.round(data * 0.9)  //手数料計算を行う、dataにかけているのが０.９なのは手数料が１０％のため
    var fee = (data - profit) //入力した数値から計算結果（profit)を引く、これが手数料となる
    $('.right_bar').html(fee) //  手数料の表示｡html()は追加ではなく､上書き｡入力値が変わる度に表示も変わるようにする｡
    $('.right_bar').prepend('¥') // 手数料の前に¥マークを付けたいので
    $('.right_bar_2').html(profit)
    $('.right_bar_2').prepend('¥')
    $('#price').val(data) 
    $('#profit').val(profit)// 計算結果を格納用フォームに追加｡もし､入力値を追加したいのなら､今回はdataを引数に持たせる｡
    $('#commission').val(fee)
    if(profit == '') {   // もし､計算結果が''なら表示も消す｡
    $('.right_bar_2').html('');
    $('.right_bar').html('');
    }
  })
})