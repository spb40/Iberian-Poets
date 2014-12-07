  var ge;
    google.load("earth", "1", {"other_params":"sensor=false"});
    
    function init() {
  google.earth.createInstance('map3d', initCB, failureCB);
}

    function initCB(instance) {
      ge = instance;
      ge.getWindow().setVisibility(true);
      google.earth.addSideDatabase(
      ge, 'https://mapsengine.google.com/01970453336832355976-11613121305523030954-4/kh/',
    sideDatabaseSuccess,
    sideDatabaseFail,
    {
      userName: '',
      password: ''
    }
);
    }

    function failureCB(errorCode) {
    }
    
    function sideDatabaseFail() {
    }

    
    function sideDatabaseSuccess() {
      var lookAt = ge.createLookAt('');
      lookAt.setLatitude(40);
      lookAt.setLongitude(-4);
      lookAt.setRange(5000000);
      ge.getView().setAbstractView(lookAt);
    }

    google.setOnLoadCallback(init);