<template>
  <div class="home">
    <h1>OI-Chatbot</h1>

    <div class="msg-group center" id="chat-history">

      <div class="card">
        <div class="card-body">
          <h6 class="card-subtitle mb-2 text-muted text-left">Chatbot - (time)</h6>
          <p class="card-text float-left">Sample message from chatbot.</p>
        </div>
      </div>
      <div class="card">
        <div class="card-body">
          <h6 class="card-subtitle mb-2 text-muted text-right">You - (time)</h6>
          <p class="card-text float-right">Sample message from user.</p>
        </div>
      </div>

      <div v-for="message in messages" :key="message">
        <div class="card" :style="{'background-color':message.suggestedColor}">
          <div class="card-body">
            <h6 class="card-subtitle mb-2 text-muted text-right" v-if="!message.fromBot">You - {{ message.time }}</h6>
            <h6 class="card-subtitle mb-2 text-muted text-left" v-if="message.fromBot">Chatbot - {{ message.time }}</h6>
            <p class="card-text float-right" v-if="!message.fromBot">{{ message.content }}</p>
            <p class="card-text float-left" v-if="message.fromBot">{{ message.content }}</p>
          </div>
        </div>
      </div>

    </div>
    
    <div class="input-group">
      <textarea id="input-box" class="form-control" rows="1" placeholder="Say something..." v-model='currentMessage' @keyup.enter='submitMessage()'></textarea>
      <span class="input-group-btn">
        <button class="btn btn-secondary" type="button" v-on:click='submitMessage()'>Send</button>
      </span>
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
    submitMessage() {
      // Check for invalid input text and exit function accordingly.
      if (!this.currentMessage) {
        return;
      }
      
      // Get current time in string format.
      var today = new Date();
      var currentHours = today.getHours();
      var currentMinutes = ('0'+today.getMinutes()).slice(-2);  // JavaScript doesn't have a built-in function for formatting minutes (always 2 digits).
      
      // Construct a message object and add to chat history.
      var message = {content: this.currentMessage.trim(), time: (currentHours + ":" + currentMinutes), fromBot: false, suggestedColor: "#ffffff", audioFile: "", fontSize: 36, font: "Helvetica"}
      this.messages.push(message);

      // Scroll to the bottom.
      this.scrollToBottom();
      
      // Send message to back-end.
      this.sendToBot(message);
      
      // Clear variable and input field.
      this.currentMessage = '';
      // console.log(this.messages);
    },
    sendToBot(message) {
      axios
        .post('http://localhost:8080/test/chat/post', message)
        .then(response => {
          this.messages.push(response.data);
          this.scrollToBottom();
          if (response.data.audioFile != "") {
            this.playAudio(response.data.audioFile);
          }
        });
    },
    scrollToBottom() {
      document.getElementById('chat-history').scrollTop = document.getElementById('chat-history').scrollHeight;
    },
    playAudio(audioFile) {
      var snd = new Audio("data:audio/wav;base64," + audioFile);
      snd.play();
    }
  },

  watch: {
    messages: function() {
      setTimeout(() => {
        this.scrollToBottom();
      }, 100)
    }
  }
}
</script>