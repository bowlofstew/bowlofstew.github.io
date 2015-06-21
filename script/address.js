/* Fills in various address information on the page.
 */

$(document).ready(function() {
    var email = 'henderson.geoffrey@gmail.com';
    $('#email').attr('href', 'mailto:' + email).text(email);
});
