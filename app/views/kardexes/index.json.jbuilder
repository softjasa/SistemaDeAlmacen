json.array!(@kardexes) do |kardex|
  json.extract! kardex, :id, :date, :detail, :income, :output, :residue
  json.url kardex_url(kardex, format: :json)
end
