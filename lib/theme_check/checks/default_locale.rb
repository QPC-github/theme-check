# frozen_string_literal: true
module ThemeCheck
  class DefaultLocale < JsonCheck
    def on_end
      return if @theme.default_locale_json
      add_offense("Default translation file not found (for example locales/en.default.json)")
    end
  end
end
