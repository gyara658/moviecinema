// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")



// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
import 'bootstrap'
import '../stylesheets/application'
import '@fortawesome/fontawesome-free/js/all'

// turbolinks:loadでページ読み込み時に実行
document.addEventListener('turbolinks:load', () => {

  // flashメッセージ要素を取得
  const flashMessage = document.querySelector('.alert');

  // フェードアウトさせる（徐々に透過し,非表示にする）関数を定義
  const fadeOutFlashMessage = () => {
    // setIntervalを特定するために返り値を変数timer_idに格納
    const timer_id = setInterval(() => {
      // flashメッセージのstyle属性 opacityを取得
      const opacity = flashMessage.style.opacity;

      if (opacity > 0) {
      // opacityの値が0より大きければ0.02ずつ値を減少させる
        flashMessage.style.opacity = opacity - 0.02;
      } else {
        // opacityの値が0になったら非表示に
        flashMessage.style.display = 'none';
        // setIntervalをストップさせる
        clearInterval(timer_id);
      };
    }, 50); // 今回は0.05秒ごとにsetIntervalを実行
  }

  // flashメッセージがある場合のみ実行
  if (flashMessage !== null) {
    // style属性opacityをセット
    flashMessage.style.opacity = 1;
    // 今回は表示から3秒後に上記で定義したフェードアウトさせる関数を実行
    setTimeout(fadeOutFlashMessage, 3000);
  };
});
