# encoding: utf-8

module LocaleHelpers
  def locale_status(locale)
    active_locale?(locale) ? 'active' : 'inactive'
  end

  def default_locale?(locale)
    default_locale == locale
  end

  def active_locale?(locale)
    I18n.locale == locale
  end

  def available_locales
    %i(en es)
  end

  def default_locale
    :en
  end
end
