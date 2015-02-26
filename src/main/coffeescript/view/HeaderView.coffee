class HeaderView extends Backbone.View
  events: {
    'click #show-pet-store-icon'    : 'showPetStore'
    'click #show-wordnik-dev-icon'  : 'showWordnikDev'
    'change #select_baseUrl'        : 'showSelectedApi'
    'click #explore'                : 'showCustom'
    'click #chooseFromList'         : 'showDropDown'
    'keyup #input_baseUrl'          : 'showCustomOnKeyup'
    'keyup #input_apiKey'           : 'showCustomOnKeyup'
  }

  initialize: ->
    $('#input_baseUrl').hide()
    $('#input_apiKey').hide()
    $('#chooseFromList').hide()

  showPetStore: (e) ->
    @trigger(
      'update-swagger-ui'
      {url:"http://petstore.swagger.wordnik.com/api/api-docs"}
    )

  showWordnikDev: (e) ->
    @trigger(
      'update-swagger-ui'
      {url:"http://api.wordnik.com/v4/resources.json"}
    )

  showCustomOnKeyup: (e) ->
    @showCustom() if e.keyCode is 13

  showCustom: (e) ->
    e?.preventDefault()
    @trigger(
      'update-swagger-ui'
      {url: $('#input_baseUrl').val(), apiKey: $('#input_apiKey').val()}
    )

  showSelectedApi: (e) ->
    selectedText = $('#select_baseUrl option').filter(':selected').val()
    if  selectedText == "Other"
     @showInputTextBox()
    else
      e?.preventDefault()
      @trigger(
        'update-swagger-ui'
        {url: selectedText, apiKey: $('#input_apiKey').val()}
      )

  showInputTextBox: ->
    $('#select_baseUrl').hide()
    $('#input_baseUrl').show()
    $('#chooseFromList').show()

  showDropDown: ->
    $('#input_baseUrl').hide()
    $('#select_baseUrl').show()
    $('#chooseFromList').hide()

  update: (url, apiKey, trigger = false) ->
    $('#input_baseUrl').val url
    #$('#input_apiKey').val apiKey
    @trigger 'update-swagger-ui', {url:url} if trigger
