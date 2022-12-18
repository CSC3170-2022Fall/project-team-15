// 实现任务列表界面、工作流列表界面、包装/特效界面三个界面的隐藏和显示，当一个界面显示时，另外两个界面将隐藏
$("#task_list_click").click(function () {
    $("#task_list").attr('class', 'row flex-wrap');
    $("#task_list_click").attr('class', 'nav-link active')
    $("#task_setting").attr('class', 'row flex-wrap visually-hidden');
    $("#task_setting_click").attr('class', 'nav-link')
    $("#aipack").attr('class', 'row flex-wrap visually-hidden');
    $("#aipack_click").attr('class', 'nav-link')
});
$("#task_setting_click").click(function () {
    $("#task_list").attr('class', 'row flex-wrap visually-hidden');
    $("#task_list_click").attr('class', 'nav-link')
    $("#task_setting").attr('class', 'row flex-wrap');
    $("#task_setting_click").attr('class', 'nav-link active')
    $("#aipack").attr('class', 'row flex-wrap visually-hidden');
    $("#aipack_click").attr('class', 'nav-link')
});
$("#aipack_click").click(function () {
    $("#task_list").attr('class', 'row flex-wrap visually-hidden');
    $("#task_list_click").attr('class', 'nav-link')
    $("#task_setting").attr('class', 'row flex-wrap visually-hidden');
    $("#task_setting_click").attr('class', 'nav-link')
    $("#aipack").attr('class', 'row flex-wrap');
    $("#aipack_click").attr('class', 'nav-link active')
});

//导入包装按钮
function choosePack(pack_name) {
    $("#choose_pack").attr('value', pack_name);
};

//提交创建工作流内容的按钮
$("#submit_createTask").click(function () {
    $.ajaxSetup({cache: false});
    $.ajax({
        url: '/ai_cut_taskCreate/',
        type: 'POST',
        data: {
            'task_name': $("#task_name").val(),
            'choose_pack': $("#choose_pack").val()
        },
        dataType: 'json',
        cache: false,
        timeout: 10000,
        success: function (result) {
            alert(result.data)
        },
        error: function (result) {
            alert(data)
        },
    })
})

//显示所有工作流
$(function () {
        get_taskflow()
        function get_taskflow() {
            $.ajaxSetup({cache: false});
            $.ajax({
                url: '/get_ai_cut_taskflow_list/',
                type: 'get',
                data: {},
                cache: false,
                timeout: 10000,
                success: function (result) {
                    $("#taskflow_list").html(result.data)
                },
                error: function (result) {
                },
            })
        }
    }
)

//显示所有当前正在执行的任务
$(function () {
    get_tasklist()
        function get_tasklist() {
            $.ajaxSetup({cache: false});
            $.ajax({
                url: '/get_task_list/',
                type: 'get',
                data: {},
                cache: false,
                timeout: 10000,
                success: function (result) {
                    $("#task_list_table").html(result.data)
                },
                error: function (result) {
                },
            })
        }
})