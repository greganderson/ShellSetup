(function () {
  const video = document.querySelector("video");
  if (!video) {
    console.warn("No video element found on the page.");
    return;
  }

  const step = 0.1;
  const maxRate = 16;
  const minRate = 0.1;
  let currentSpeed = video.playbackRate;

  document.addEventListener("keydown", function (event) {
    if (event.key === "ArrowUp") {
      currentSpeed = Math.min(maxRate, Math.round((currentSpeed + step) * 100) / 100);
      video.playbackRate = currentSpeed;
      console.log(`Speed: ${currentSpeed.toFixed(1)}x`);
      event.preventDefault();
    }

    if (event.key === "ArrowDown") {
      currentSpeed = Math.max(minRate, Math.round((currentSpeed - step) * 100) / 100);
      video.playbackRate = currentSpeed;
      console.log(`Speed: ${currentSpeed.toFixed(1)}x`);
      event.preventDefault();
    }
  });
})();
