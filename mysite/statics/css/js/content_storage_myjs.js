$(function () {
   test()
   function test(){
   $.ajaxSetup({ cache: false });
   $.ajax({
      url:'/get_content_media/',
      type:'get',
      data:{},
      cache:false,
      timeout:10000,
      success:function (result) {
         $("#media_table").html(result.data)
      },
      error:function (result) {
      },
   })
}
}
)