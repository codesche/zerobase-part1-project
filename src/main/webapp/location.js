
window.onload

function noValueError() {
    if (document.getElementById("location_lnt").value == "" ||
        document.getElementById("location_lat").value == ""){
        alert("값을 입력하세요")
    }
}

function on() {
    if (navigator.geolocation)  {
        navigator.geolocation.getCurrentPosition(showPosition,showError);

    } else{
        alert("Geolocation is not supported by this browser.");
    }

}

function showPosition(pos) {
    document.getElementById("location_lat").value = pos.coords.latitude;
    document.getElementById("location_lnt").value = pos.coords.longitude;
}

function showError(error) {
    switch(error.code) {
        case error.TIMEOUT:
            alert("시간 제한을 초과했습니다.");
            break;
        case error.POSITION_UNAVAILABLE:
            alert("현재 위치를 구할 수 없습니다.");
            break;
        case error.PERMISSION_DENIED:
            alert("위치를 구할 수 있는 권한이 없습니다.");
            break;
        case error.UNKNOWN_ERROR: alert("알 수 없는 에러가 발생하였습니다.");
            break;
        default :
            alert (error.message);
    }
}

