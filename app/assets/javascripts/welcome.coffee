# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

hardness =
  'C': 2
  'C#': 4
  'D': 0
  'D#': 4
  'E': 0
  'F': 1
  'F#': 1
  'G': 0
  'G#': 4
  'A': 0
  'B': 1
  'H': 0
  'C2': 0
  'C2#': 1
  'D2': 0
  'D2#': 2
  'E2': 2
  'F2': 2
  'F#2': 2
  'G2': 2
  'G#2': 2
  'A2': 3
  'B2': 3
  'H2': 4
  'C3': 4
  'C#3': 5
  'D3': 6

notes = Object.keys(hardness)

pitch = (note) ->
  notes.indexOf(note)

pitches = (a) ->
  a.map pitch

h = (note) ->
  if note of hardness then hardness[note] else 1000

hh = (n) ->
  n
  .map (n) ->
    h(n)
  .reduce (x,y) ->
    x+y

low = (a) ->
  Math.min(pitches(a)...)

high = (a) ->
  Math.max(pitches(a)...)

transpose = (a, t) ->
  pitches(a).map (p) -> notes[p+t]

$ ->
  $('#notes').bind 'blur keyup', (e) ->
    a = $(@).val().toUpperCase().split(/\ |([A-Z]\d?#?)/g).filter(Boolean)
    transposes = []
    for t in [-low(a)..notes.length - high(a) - 1]
      aa = transpose a,t
      transposes.push {notes: aa, hardness: hh(aa)}
    transposes.sort (n1, n2) -> return if n1.hardness > n2.hardness then 1 else -1
    $('#transposed').empty()
    for t in transposes
      $('#transposed').append "<tr><td>#{t.hardness}</td><td>#{t.notes.join(' ')}</tr>"


