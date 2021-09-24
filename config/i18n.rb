require 'i18n'

I18n.load_path = Dir['./config/locale/*.yml']
I18n.default_locale = :ru
I18n.backend.load_translations
