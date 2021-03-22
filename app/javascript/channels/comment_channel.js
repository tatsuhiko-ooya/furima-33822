import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const ul = document.getElementById("message-items")
    const userName = data.user.nickname
    const linkUserName = `<a class="comment-user-name" href="#">${userName}</a>`
    const html = data.comment.message
    const time = data.comment.created_at

    const newLi = document.createElement("li")
    newLi.setAttribute("class","message_item")

    const messageBody = document.createElement("div")
    messageBody.setAttribute("class", "message-body")

    const messageBodyText = document.createElement("div")
    messageBodyText.setAttribute("class", "message-body-text")
    messageBodyText.insertAdjacentHTML('afterbegin', html);

    const messageBodyTime = document.createElement("div")
    messageBodyTime.setAttribute("class", "message-body-time")
    messageBodyTime.insertAdjacentHTML("afterbegin", time)

    messageBody.appendChild(messageBodyText)
    messageBody.appendChild(messageBodyTime)

    newLi.appendChild(messageBody)
    newLi.insertAdjacentHTML("afterbegin", linkUserName)

    ul.appendChild(newLi)
    document.getElementById("comment_message").value = ''




  }
});
