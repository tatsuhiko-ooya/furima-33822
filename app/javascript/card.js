const pay = () => {
  if (document.getElementById("charge-form")) {
    Payjp.setPublicKey("pk_test_de983ae17c143122bfd2e698")
    const form = document.getElementById("charge-form")
    form.addEventListener("submit",(e) => {
      e.preventDefault();
      const formResult = document.getElementById("charge-form");
      const formData = new FormData(formResult);

      const card = {
        number: formData.get("order_address[number]"),
        cvc: formData.get("order_address[cvc]"),
        exp_month: formData.get("order_address[exp_month]"),
        exp_year: `20${formData.get("order_address[exp_year]")}`
      }
      Payjp.createToken(card, (status, response) => {
        if (status == 200) {
          token = response.id
          console.log(token)
        }
      }) 
    })
};
}
window.addEventListener("load", pay);