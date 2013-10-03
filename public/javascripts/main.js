$(document).ready(function() {
//  On Time, Now Boarding, All Aboard, Delayed
//  Cancelled, Info to follow, TBD, Late
//  Arriving, Arrived, Departed, Hold, End

  $('td[status="now boarding"]').parent('tr').addClass('success');
  $('td[status="all aboard"]').parent('tr').addClass('danger');
  $('td[status="delayed"]').parent('tr').addClass('warning');

  $('td[status="cancelled"]').parent('tr').addClass('danger');
  $('td[status="info to follow"]').parent('tr').addClass('warning');
  $('td[status="late"]').parent('tr').addClass('warning');

  $('td[status="arriving"]').parent('tr').addClass('success');
  $('td[status="arrived"]').parent('tr').addClass('success');
  $('td[status="departed"]').parent('tr').addClass('danger');

  $('td[status="hold"]').parent('tr').addClass('warning');
  $('td[status="end"]').parent('tr').addClass('danger');
});
