
1.报名成功返回时返回到完全相同的滚动位置 add by:gz  20201127
$(window).scroll(function () {
    //set scroll position in session storage
    sessionStorage.scrollPos = $(window).scrollTop();
});
var init = function () {
    //get scroll position in session storage
    $(window).scrollTop(sessionStorage.scrollPos || 0)
};
window.onload = init;
