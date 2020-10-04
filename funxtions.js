var request = require('request');

request({
  method: 'POST',
  url: 'https://rzp_test_8IbZwSARRQ1LA4:XOTsMIygDiER9mXXLBND6EXp@api.razorpay.com/v1/payments/pay_FhHAjeahvjVfRW/refund',
  formData:{
      amount:500
  }
}, function (error, response, body) {
  console.log('Status:', response.statusCode);
  console.log('Headers:', JSON.stringify(response.headers));
  console.log('Response:', body);
});