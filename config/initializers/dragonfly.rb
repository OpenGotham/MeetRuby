require 'dragonfly'
require 'RMagick'
require 'rack/cache'

### The dragonfly app ###
app = Dragonfly::App[:images]
app.register_analyser(Dragonfly::Analysis::RMagickAnalyser)
app.register_processor(Dragonfly::Processing::RMagickProcessor)
app.register_encoder(Dragonfly::Encoding::RMagickEncoder)
app.url_handler.configure do |c|
  c.protect_from_dos_attacks = false
end
### Extend active record ###
Dragonfly.active_record_macro(:image, app)
