// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import Rails from "rails-ujs";
Rails.start();
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('DOMContentLoaded', function() {
  const form = document.getElementById('register-form');
  const penname = document.getElementById('penname');
  const email = document.getElementById('email');
  const password = document.getElementById('password');
  const passwordConfirmation = document.getElementById('password_confirmation');
  const successMessage = document.getElementById('success-message');

  if (form) {
    form.addEventListener('submit', function(e) {
      e.preventDefault();
      let valid = true;

      // ペンネーム
      if (!penname.value.trim()) {
        document.getElementById('penname-error').textContent = 'ペンネームは必須です';
        valid = false;
      } else {
        document.getElementById('penname-error').textContent = '';
      }

      // メール
      const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!email.value.trim()) {
        document.getElementById('email-error').textContent = 'メールアドレスは必須です';
        valid = false;
      } else if (!emailPattern.test(email.value)) {
        document.getElementById('email-error').textContent = 'メールアドレスの形式が正しくありません';
        valid = false;
      } else {
        document.getElementById('email-error').textContent = '';
      }

      // パスワード
      if (!password.value) {
        document.getElementById('password-error').textContent = 'パスワードは必須です';
        valid = false;
      } else if (password.value.length < 8) {
        document.getElementById('password-error').textContent = '8文字以上で入力してください';
        valid = false;
      } else {
        document.getElementById('password-error').textContent = '';
      }

      // パスワード確認
      if (!passwordConfirmation.value) {
        document.getElementById('password_confirmation-error').textContent = 'パスワード確認を入力してください';
        valid = false;
      } else if (password.value !== passwordConfirmation.value) {
        document.getElementById('password_confirmation-error').textContent = 'パスワードが一致しません';
        valid = false;
      } else {
        document.getElementById('password_confirmation-error').textContent = '';
      }

      if (valid) {
        successMessage.textContent = '登録が完了しました！（仮）';
        form.reset();
      } else {
        successMessage.textContent = '';
      }
    });
  }
});

// --- YouTubeプレイヤー・検索窓用JS ---
document.addEventListener('turbo:load', function() {
  // YouTube動画IDまたはURLから動画IDまたはプレイリストIDを抽出
  function extractYouTubeInfo(input) {
    if (!input) return { type: null, id: null };
    // プレイリストID抽出
    const listMatch = input.match(/[?&]list=([a-zA-Z0-9_-]+)/);
    if (listMatch) {
      return { type: 'playlist', id: listMatch[1] };
    }
    // 動画ID抽出
    const urlPattern = /(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?|shorts)\/|.*[?&]v=)|youtu\.be\/)([\w-]{11})/;
    const idPattern = /^[\w-]{11}$/;
    const urlMatch = input.match(urlPattern);
    if (urlMatch) return { type: 'video', id: urlMatch[1] };
    if (idPattern.test(input)) return { type: 'video', id: input };
    return { type: null, id: null };
  }

  // 動画またはプレイリストを再生
  const playBtn = document.getElementById('youtube-play-btn');
  if (playBtn) {
    playBtn.addEventListener('click', function() {
      const input = document.getElementById('youtube-input').value.trim();
      const info = extractYouTubeInfo(input);
      const player = document.getElementById('youtube-player');
      if (info.type === 'video' && player) {
        player.src = `https://www.youtube.com/embed/${info.id}`;
      } else if (info.type === 'playlist' && player) {
        player.src = `https://www.youtube.com/embed?listType=playlist&list=${info.id}`;
      } else if (player) {
        player.src = '';
        alert('有効なYouTube動画ID、URL、またはプレイリストURLを入力してください');
      }
    });
  }

  // YouTube API連携による動画検索
  const searchBtn = document.getElementById('youtube-search-btn');
  if (searchBtn) {
    searchBtn.addEventListener('click', function() {
      const query = document.getElementById('youtube-search-query').value.trim();
      const resultsDiv = document.getElementById('youtube-search-results');
      resultsDiv.innerHTML = '';
      if (!query) return;
      // YouTube Data API v3で検索
      const apiKey = 'AIzaSyBPA288uB7fMxoRlqzLNdFqQ1h-7hUnFb4';
      const maxResults = 5;
      const url = `https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&q=${encodeURIComponent(query)}&maxResults=${maxResults}&key=${apiKey}`;
      fetch(url)
        .then(res => res.json())
        .then(data => {
          if (!data.items) {
            resultsDiv.innerHTML = '<span style="color:red;">検索結果がありません</span>';
            return;
          }
          data.items.forEach(function(item) {
            const videoId = item.id.videoId;
            const title = item.snippet.title;
            const thumb = item.snippet.thumbnails.default.url;
            const el = document.createElement('div');
            el.style.display = 'flex';
            el.style.alignItems = 'center';
            el.style.cursor = 'pointer';
            el.style.marginBottom = '6px';
            el.innerHTML = `<img src="${thumb}" style="width: 60px; height: 45px; margin-right: 8px;"> <span>${title}</span>`;
            el.addEventListener('click', function() {
              const player = document.getElementById('youtube-player');
              if (player) player.src = `https://www.youtube.com/embed/${videoId}`;
            });
            resultsDiv.appendChild(el);
          });
        })
        .catch(err => {
          resultsDiv.innerHTML = '<span style="color:red;">検索に失敗しました</span>';
        });
    });
  }

  // ページ遷移時にiframeをリセット
  document.addEventListener('turbo:before-cache', function() {
    const player = document.getElementById('youtube-player');
    if (player) player.src = '';
  });
});
