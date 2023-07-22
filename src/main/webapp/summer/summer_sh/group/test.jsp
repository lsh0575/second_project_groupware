<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css"/>
    <title>Momentom</title>
</head>
<body>
    <form class="hidden" id="login-form">
        <input type="text" required maxlength="15" placeholder="what is your name?"/>
        <button>Log In</button>
    </form>
    <h2 id="clock">00:00</h2>
    <h1 class="hidden" id="greeting"></h1>
    <div id = "quote">
        <span></span>
        <span></span>
    </div>
    <script src="js/clock.js"></script>
    <script src="js/greetings.js"></script>
    <script src="js/quotes.js"></script>
</body>
</html>
const quotes = [
    {
    quote: 'I never dreamed about success, I worked for it',
    author: 'Estee Lauder'
    },
    {
    quote: 'Do not try to be original, just try to be good.',
    author: 'Paul Rand'
    },
    {
    quote: 'Do not be afraid to give up the good to go for the great',
    author: 'John D. Rockefeller'
    },
    {
    quote: 'If you cannot fly then run. If you cannot run, then walk. And if you cannot walk, then crawl, but whatever you do, you have to keep moving forward.',
    author: 'Martin Luther King Jr.'
    },
    {
    quote: 'Our greatest weakness lies in giving up. The most certain way to succeed is always to try just one more time.',
    author: 'Thomas Edison'
    },
    {
    quote: 'The fastest way to change yourself is to hang out with people who are already the way you want to be',
    author: 'REid Hoffman'
    },
    {
    quote: 'Money is like gasoline during a road trip. You do not want to run out of gas on your trip, but you are not doing a tour of gas stations',
    author: 'Tim O Reilly'
    },
    {
    quote: 'Some people dream of success, while other people get up every morning and make it happen',
    author: 'Wayne Huizenga'
    },
    {
    quote: 'The only thing worse than starting something and falling.. is not starting something',
    author: 'SEth Godin'
    },
    {
    quote: 'If you really want to do something, you will find a way. If you do not, you will find an excuse.',
    author: 'Jim Rohn'
    },
];

const quote = document.querySelector("#quote span:first-child");
const author = document.querySelector("#quote span:last-child");

const todayQuote = quotes[Math.floor(Math.random()* quotes.length)];

quote.innerText = todayQuote.quote;
author.innerText = todayQuote.author;