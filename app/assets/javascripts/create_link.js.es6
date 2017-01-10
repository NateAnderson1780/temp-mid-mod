var $newLinkTitle, $newLinkUrl;

$(document).ready(function(){
  $newLinkTitle = $("#link-title");
  $newLinkUrl  = $("#link-url");

  $("#new-link").on('submit', createLink);
  
  $.getJSON('/api/v1/links')
    .then(function(links) {
      links.forEach(renderLink);
    })
    
  attachFilters()
})

function attachFilters(){
  $('#read').on('click', filterReads)
  $('#unread').on('click', filterUnreads)
}

function filterReads(){
  console.log("WIN");
  var checkStatus = $(this).is(':checked')
  $('.link').each(function() {
    var read = $(this).find('.link_read').text().trim()

    if (read === 'true' && checkStatus) {
      $(this).hide()
    } else {
      $(this).show()
    }
  })
}

function filterUnreads(){
  var checkStatus = $(this).is(':checked')
  $('.link').each(function() {
    var read = $(this).find('.link_read').text().trim()

    if (read === 'false' && checkStatus) {
      $(this).hide()
    } else {
      $(this).show()
    }
  })
}

function createLink (event){
  event.preventDefault();

  console.log("win")

  var link = getLinkData();

  $.post("/api/v1/links", link)
   .then( renderLink )
   .then( clearLink )
   .fail( displayFailure )
 }

function getLinkData() {
 return {
   title: $newLinkTitle.val(),
   url: $newLinkUrl.val()
 }
}

function renderLink(link){
  $.when( 
  $("#links-list").prepend( linkHTML(link) )
).then(
    $('.edit-link').first().on('click', editLink)
  ).then(
    $('.mark-read').first().on('click', markRead)
  ).then(
    $('.mark-unread').first().on('click', markUnread)
  ).then(
    $('.delete-link').first().on('click', deleteLink)
  )
}

function linkHTML(link) {
    if(link.read) {
    return `<div class='link' data-id='${link.id}' id="link-${link.id}">
              <p class='link-title'>${ link.title }</p>
              <p class='link-url red'>${ link.url }</p>

              <p class="link_read">
                Read
              </p>
              <p class="link_buttons">
                <button class="mark-unread">Mark as Unread</button>
                <button class='edit-link'>Edit</button>
                <button class='delete-link'>Delete</button>
              </p>
            </div>`}
    else {
      return `<div class='link' data-id='${link.id}' id="link-${link.id}">
                <p class='link-title'>${ link.title }</p>
                <p class='link-url'>${ link.url }</p>

                <p class="link_read">
                  Unread
                </p>
                <p class="link_buttons">
                  <button class="mark-read">Mark as Read</button>
                  <button class='edit-link'>Edit</button>
                  <button class='delete-link'>Delete</button>
                </p>
              </div>`
    }
}

function clearLink() {
  $newLinkTitle.val("");
  $newLinkUrl.val("");
}

function displayFailure(failureData){
  console.log("FAILED attempt to create new Link: " + failureData.responseText);
}

function editLink() {
  console.log("WIN");
  var parent_link = $(this).closest('.link')
  $(parent_link).addClass('edit-box')
  $(parent_link).find('.link-title').attr('contenteditable', true)
  $(parent_link).find('.link-url').attr('contenteditable', true)
  $.when(
    $(this).text('updateLink')
  ).then(
    $(this).off()
  ).then(
    $(this).on('click', updateLink)
  )
}

function updateLink(){
  var parent_link = $(this).closest('.link')
  var id = $(parent_link).data('id')
  var title = $(parent_link).find('.link-title').text();
  var url = $(parent_link).find('.link-url').text();
  $(parent_link).find('.link-title').attr('contenteditable', false);
  $(parent_link).find('.link-url').attr('contenteditable', false);
  $.ajax({
    url: '/api/v1/links/' + id,
    type: 'PUT',
    data: {
      title: title,
      url: url
    }
  }).fail(
    displayFailure
  ).then(
    $(parent_link).removeClass('edit-box')
  ).then(
    $(this).text('Edit')
  ).then(
    $(this).off()
  ).then(
    $(this).on('click', editLink)
  )
} 

function deleteLink() {
  var id = $(this).closest('.link').data('id');
  $.ajax({
    url: '/api/v1/links/' + id,
    method: 'DELETE',
    type: 'json',
  }).then(removeLink.bind(this))
}

function removeLink(){
  $(this).closest(".link").remove()
}

function markRead() {
  console.log("WIN");
  var parent_link = $(this).closest('.link')
  var id = $(parent_link).data('id')
  var title = $(parent_link).find('.link-title').text();
  var url = $(parent_link).find('.link-url').text();
  $.ajax({
    url: '/api/v1/links/' + id,
    type: 'PUT',
    data: {
      read: true
    }
  }).then(
    $(this).parent().siblings('.link_read').text('Read')
  ).then(
    $(this).parent().siblings('.link-url').css('color', 'red')
  ).then(
    $(this).text('Mark As Unread')
    )
}

function markUnread() {
  console.log("WIN");
  var parent_link = $(this).closest('.link')
  var id = $(parent_link).data('id')
  var title = $(parent_link).find('.link-title').text();
  var url = $(parent_link).find('.link-url').text();
  $.ajax({
    url: '/api/v1/links/' + id,
    type: 'PUT',
    data: {
      read: false
    }
  }).then(
    $(this).parent().siblings('.link_read').text('Unread')
   ).then(
    $(this).text('Mark As Read')
   ).then(
     $(this).parent().siblings('.link-url').css('color', 'black')
   )
}

