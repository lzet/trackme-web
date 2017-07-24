module SettingsHelper
  def yesno boolparam
    if boolparam
      return 'yes'
    end
    return 'no'
  end
end
