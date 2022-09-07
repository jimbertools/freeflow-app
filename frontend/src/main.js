import {createApp} from 'vue'
import App from './App.vue'


const initializeFlutterInAppWebViewPolyFill = () => {
    if (window.flutter_inappwebview) {
        return;
    }

    window.flutter_inappwebview = {
        async callHandler(key, ...args) {
            console.log('Webview event called: ', {
                key,
                ...args,
            });
        },
    };
};

let sleep = ms => new Promise(resolve => setTimeout(resolve, ms));

async function startVueApp() {
    initializeFlutterInAppWebViewPolyFill();
    createApp(App).mount('#app')


    // This is needed due rally conditions with webview
    await sleep(1000)

    console.log("Reached this part")

    window.flutter_inappwebview.callHandler('VUE_INITIALIZED');
}


startVueApp();
