# frozen_string_literal: true
require "test_helper"

class MatchingSchemaTranslationsTest < Minitest::Test
  def test_matching
    offenses = analyze_theme(
      ThemeCheck::MatchingSchemaTranslations.new,
      "sections/product.liquid" => <<~END,
        {% schema %}
          {
            "name": {
              "en": "Hello",
              "fr": "Bonjour"
            },
            "settings": [
              {
                "id": "product",
                "label": {
                  "en": "Product",
                  "fr": "Produit"
                }
              }
            ]
          }
        {% endschema %}
      END
    )
    assert_offenses("", offenses)
  end

  def test_missing
    offenses = analyze_theme(
      ThemeCheck::MatchingSchemaTranslations.new,
      "sections/product.liquid" => <<~END,
        {% schema %}
          {
            "name": {
              "en": "Hello",
              "fr": "Bonjour"
            },
            "settings": [
              {
                "id": "product",
                "label": {
                  "en": "Product"
                }
              }
            ]
          }
        {% endschema %}
      END
    )
    assert_offenses(<<~END, offenses)
      settings.product.label missing translations for fr at sections/product.liquid:1
    END
  end
end
