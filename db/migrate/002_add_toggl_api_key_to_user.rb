class AddTogglApiKeyToUser < ActiveRecord::Migration
  def up
    UserCustomField.create!(
      name: 'Toggl API Key',
      field_format: 'string',
      min_length: 32,
      max_length: 32,
      regexp: '',
      default_value: '',
      is_required: 0,
      visible: 1,
      editable: 1,
      is_filter: 0
    )
  end

  def down
    UserCustomField.find_by_name('Toggl API Key').destroy
  end
end
