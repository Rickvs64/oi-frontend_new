<template>
  <div class="home">

    <div id="response">
      <p>Text response.</P>
    </div>

  </div>
</template>

<script>
import axios from "axios"
export default {
  name: "Home",
  data() {
    return {
      messages: [],
      currentMessage: ''
    };
  },
  mounted() {
    
  },
  methods: {
    playAudio(audioFile) {
      var snd = new Audio("data:audio/wav;base64," + audioFile);
      snd.play();
    }
  }
}
</script>