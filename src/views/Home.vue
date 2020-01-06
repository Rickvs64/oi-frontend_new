<template>
  <div class="home">

    <div id="response">
      <p>Large block of text that's supposed to be multi-line.</P>
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
    this.openSocket();
  },
  methods: {
    playAudio(audioFile) {
      var snd = new Audio("data:audio/wav;base64," + audioFile);
      snd.play();
    },
    openSocket() {
      var socket = new WebSocket("ws://localhost:8089/socket");
      
      socket.onmessage = function (event) {
        console.log(event.data);
      }
    }
  }
}
</script>