<template>
  <div class="wrapper">
    <custom-button button-text="Get location" @click="addWebViewClick('retrieveLocation')" color="#AF87CE"
                   logo="fas fa-map-marker-alt"></custom-button>
    <div class="divider"></div>
    <div class="flutter-location">
      <span style="font-weight: bold">Location:</span>
      <div>
        <span class="text-sm">Longitude: </span>
        <span class="location-longitude text-sm"> {{ locationData?.['longitude'] }}</span>
      </div>
      <div>
        <span class="text-sm">Latitude: </span>
        <span class="location-latitude text-sm"> {{ locationData?.['latitude'] }}</span>
      </div>
    </div>

    <div class="bordered divider"></div>

    <custom-button button-text="Upload an image" @click="addWebViewClick('uploadFile')" color="#EA1A7F"
                   logo="fas fa-upload"></custom-button>
    <div class="divider"></div>
    <div style="display: flex; justify-content: center">
      <img v-if="uploadImageSrc" style="max-width: 100%; max-height: 100px;" alt="Upload a picture"
           id="flutter-file-uploader" :src="uploadImageSrc">
    </div>

    <div v-if="uploadImageSrc" class="divider"></div>
    <div class="bordered"></div>
    <custom-button button-text="Take a picture" @click="addWebViewClick('takePicture')" color="#7471c9"
                   logo="fas fas fa-camera"></custom-button>
    <div class="divider"></div>
    <div style="display: flex; justify-content: center">
      <img v-if="takeImageSrc" style="max-width: 100%; max-height: 100px;" alt="Upload a picture"
           id="flutter-take-picture" :src="takeImageSrc">
    </div>

    <div v-if="takeImageSrc" class="divider"></div>
    <div class="bordered"></div>
    <custom-button button-text="Get accellero values" @click="addWebViewClick('retrieveAccellero')" color="#FEC603"
                   logo="fas fa-magnet"></custom-button>

    <div class="divider"></div>
    <div class="flutter-accellero">
      <span style="font-weight: bold">Accellero:</span>
      <div>
        <span class="text-sm">X: </span>
        <span class="accellero-x text-sm"> {{ accelleroData?.['x'] }}</span>
      </div>
      <div>
        <span class="text-sm">Y: </span>
        <span class="accellero-y text-sm">{{ accelleroData?.['y'] }}</span>
      </div>
      <div>
        <span class="text-sm">Z: </span>
        <span class="accellero-z text-sm">{{ accelleroData?.['z'] }}</span>
      </div>
    </div>

    <div class="divider bordered"></div>

    <custom-button button-text="Authenticate" @click="addWebViewClick('authenticate')" color="#A8F387"
                   logo="fas fa-lock"></custom-button>
    <div class="divider"></div>
    <div >
      <span style="font-weight: bold;">Authenticated: </span>
      <div>
        <span class="text-sm">Succeed: </span>
        <span class="flutter-authenticated text-sm"> {{ authenticationData }}</span>
      </div>
    </div>

    <div class="divider bordered"></div>
    <custom-button button-text="Scan QR" @click="addWebViewClick('scanQR')" color="#16D6FA"
                   logo="fas fa-qrcode"></custom-button>
    <div class="divider"></div>
    <div>
      <span style="font-weight: bold;">QR: </span>
      <div>
        <span class="text-sm">Scanned data: </span>
        <span class="flutter-scan-qr text-sm"> {{ qrData }}</span>
      </div>
    </div>

    <div class="large-divider bordered"></div>

    <custom-button button-text="Reset data" @click="addWebViewClick('clearData')" color="#e01d34"
                   logo="fas fa-trash"></custom-button>


    <div class="divider"></div>

  </div>
</template>

<script>
import CustomButton from "./components/CustomButton";
import {ref} from "vue";

export default {
  name: 'App',
  components: {
    CustomButton
  },
  setup() {
    let uploadImageSrc = ref(null);
    let takeImageSrc = ref(null);
    let locationData = ref(null);
    let accelleroData = ref(null);
    let authenticationData = ref(null);
    let qrData = ref(null);

    const handleRetrieveLocation = () => {
      window.flutter_inappwebview.callHandler('RETRIEVE_LOCATION').then(function (data) {
        locationData.value = data;
      })
    };

    const handleUploadFile = () => {
      window.flutter_inappwebview.callHandler('UPLOAD_FILE').then(function (data) {
        uploadImageSrc.value = "data:image/png;base64," + data;
      });
    };

    const handleTakePicture = () => {
      window.flutter_inappwebview.callHandler('TAKE_PICTURE').then(function (data) {
        takeImageSrc.value = "data:image/png;base64," + data
      });
    };


    const handleAuthenticate = () => {
      window.flutter_inappwebview.callHandler('AUTHENTICATE').then(function (data) {
        authenticationData.value = data;
      });
    };


    const handleScanQR = () => {
      window.flutter_inappwebview.callHandler('SCAN_QR').then(function (data) {
        qrData.value = data;
      });
    };

    const handleAccellero = () => {
      window.flutter_inappwebview.callHandler('RETRIEVE_ACCELLERO').then(function (data) {
        accelleroData.value = data
      });
    };

    const handleClearData = () => {
      window.flutter_inappwebview.callHandler('CLEAR_DATA')
    };


    const addWebViewClick = (type) => {
      window.vueInstance = this;

      switch (type) {
        case 'retrieveLocation':
          handleRetrieveLocation();
          break;

        case 'uploadFile':
          handleUploadFile();
          break;

        case 'takePicture':
          handleTakePicture();
          break;

        case 'authenticate':
          handleAuthenticate();
          break;

        case 'scanQR':
          handleScanQR();
          break;

        case 'retrieveAccellero':
          handleAccellero();
          break;

        case 'clearData':
          handleClearData();
          break;

        default:
          handleClearData();
          break;
      }
    };

    return {
      uploadImageSrc,
      takeImageSrc,
      locationData,
      accelleroData,
      authenticationData,
      qrData,
      addWebViewClick
    }
  },
}
</script>

<style>

html {
  font-family: 'Poppins', sans-serif;
}

.wrapper {
  padding: 24px;
}

.divider {
  margin-top: 16px;
  margin-bottom: 16px;
}

.large-divider {
  margin-top: 48px;
  margin-bottom: 48px;
}

.text-sm {
  font-size: 12px;
}

.bordered {
  margin-top: 16px;
  margin-bottom: 16px;
  border-bottom: 0.5px solid #a6acba;
}
</style>
