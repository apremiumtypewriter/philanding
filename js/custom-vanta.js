window.addEventListener('DOMContentLoaded', () => {
  const vantaContainer = document.getElementById('vanta-bg-container');
  if (window.VANTA && vantaContainer) {
    VANTA.RINGS({
      el: "#vanta-bg-container", // Target the specific container
      THREE: window.THREE, // Explicitly pass THREE object
      mouseControls: true,
      touchControls: true,
      gyroControls: false,
      minHeight: 100.00,
      minWidth: 100.00,
      scale: 1.00,
      scaleMobile: 1.00,
      backgroundColor: 0x121212,
      color: 0x666666,
      ringColor: 0x555555,
      kColor: 0x444444,
      highlightColor: 0x777777,
      baseColor: 0x333333,
      speed: 0.5,
      intensity: 0.3,
      amplitudeFactor: 0.5,
      size: 0.8,
      spacing: 1.5,
    });
  } else if (!vantaContainer) {
    console.log("VantaJS container not found on this page. Vanta will not be initialized.");
  } else {
    console.error("VANTA.js or THREE.js not loaded");
  }
});
