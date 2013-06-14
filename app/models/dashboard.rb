class Dashboard < ActiveRecord::Base
  self.primary_key = :repository

  has_and_belongs_to_many :panes, foreign_key: :repository

  def self.find_or_bootstrap(repository)
    dashboard = find_by_repository(repository)
    return dashboard if dashboard.present?

    transaction do
      dashboard = create! do |d|
        d.repository = repository
        create_default_panes.each do |pane|
          d.panes << pane
        end
      end
    end
    dashboard
  rescue ActiveRecord::RecordNotUnique
    find_by_repository(repository)
  end

  DEFAULT_CARD_NAMES = [
    'yapplabs/github-issues',
    'yapplabs/github-stars'
  ]
  def self.create_default_panes
    DEFAULT_CARD_NAMES.map do |name|
      Pane.create! do |p|
        p.card_manifest_name = name
      end
    end
  end
end