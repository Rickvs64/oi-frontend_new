<template>
  <div class="home">

    <div id="response">
      <p id="responseParagraph">Large block of text that's supposed to be multi-line.</P>
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
    this.watchLocalStorage();
  },
  methods: {
    playAudio(audioFile) {
      var snd = new Audio("data:audio/wav;base64," + audioFile);
      snd.play();
    },
    watchLocalStorage() {
      var myobj = this;   // 'This.method()' won't work in a callback.
      window.addEventListener("storage", function(e) {
        if (e.key == "input") {
          myobj.receiveInput(e.newValue);
        }
      }, false)
    },
    receiveInput(input) {
      // Get current time in string format.
      var today = new Date();
      var currentHours = today.getHours();
      var currentMinutes = ('0'+today.getMinutes()).slice(-2);  // JavaScript doesn't have a built-in function for formatting minutes (always 2 digits).
      
      // Construct a message object and add to chat history.
      var message = {content: input.trim(), time: (currentHours + ":" + currentMinutes), fromBot: false, suggestedColor: "#ffffff", audioFile: "", fontSize: 36, font: "Helvetica"}
      this.messages.push(message);
      
      // Send message to back-end.
      this.sendToBot(message);
    },
    sendToBot(message) {
      axios
        .post('http://localhost:8080/test/chat/post', message)
        .then(response => {
          // this.messages.push(response.data);
          this.showNewMessage(response.data);

          if (response.data.audioFile != "") {
            this.playAudio(response.data.audioFile);
          }
        });
    },
    showNewMessage(messageObject) {
      document.getElementById("responseParagraph").innerHTML = messageObject.content;
    }
  }
}
</script>