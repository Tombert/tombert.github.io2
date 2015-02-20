---
---
$ ->
        lookup = (lookupText) ->
                Promise.resolve($.get '/feed.xml')
                .then (data) ->
                        items = _.toArray($(data).find('item'))
                        _.map items, (i) ->
                                description: $(i).find('description').text()
                                link:  $(i).find('link').text()
                                title: $(i).find('title').text()
                .then (items) ->
                        _.filter items, (i) -> (i.description.toLowerCase().indexOf(do lookupText.toLowerCase) > -1 or i.title.toLowerCase().indexOf(lookupText.toLowerCase()) > -1 )
                .then (items) ->
                        _.map items, (i) ->
                                i.description = $(i.description).text()
                                index = i.description.toLowerCase().indexOf lookupText.toLowerCase()
                                phrase = i.description.substr(index, lookupText.length)
                                boldPhrase = "<strong>#{phrase}</strong>"
                                i.description = i.description.substr(0, index) + boldPhrase + i.description.substr(index + phrase.length)
                                i.description = "..." + i.description.substring((index - 40), (index + 40)) + "..."
                                return i
                .then (items) ->
                        htmlItems = _.map items, (item) ->
                                "<div class=\"search_item\"><a href=\"#{item.link}\"><h4>#{item.title}</h4></a><div>#{item.description}</div></div>"
                .then (htmlItems) ->
                        $('#results').empty()
                        if htmlItems.length > 0
                                _.each htmlItems, (i) -> $('#results').append($(i))
                        else 
                                $('#results').append($("<h3> There were no articles that have the phrase #{lookupText} </h3>"))
                                
        getSearchParam = (e) -> 
                e.preventDefault()
                $("#searchParam").val()
                
        $("#searching").submit(_.compose(lookup, getSearchParam))


