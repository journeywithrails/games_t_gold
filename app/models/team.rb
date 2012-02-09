class Team < ActiveRecord::Base

  acts_as_taggable
  acts_as_commentable
  #has_attachment prepare_options_for_attachment_fu(AppConfig.team_logo['attachment_fu_options'])
  
  has_attachment  :storage => :file_system,
                  :max_size => 2.megabytes,
                  :thumbnails => { :thumb => '100x100!', :medium => '290x320!' },
                  :processor => :MiniMagick,
                  :content_type => ['image/jpg', 'image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png']
 
  belongs_to :creator, :class_name => 'User'
  has_many :memberships, :dependent => :destroy
  has_many :members, :through => :memberships
  has_many :admins, :through => :memberships, :source => :member,
    :conditions => [ 'memberships.admin = ?', true ]
  has_many :membership_requests, :dependent => :destroy
  has_many :membership_invitations, :dependent => :destroy

  # XXX: Why check parent_id here (and in the after_create callback)? Because attachment_fu
  # creates another instance of this model for every thumbnail specified, but does not
  # include values for the "other" (non-attachment_fu) attributes. So only run validations
  # and callbacks when the instance is the root or parent instance.
  validates_presence_of :name, :if => Proc.new { |team| team.parent_id.nil? }
  validates_uniqueness_of :name, :if => Proc.new { |team| team.parent_id.nil? }
  validates_length_of :name, :maximum => 100, :if => Proc.new { |team| team.parent_id.nil? }
  validates_inclusion_of :content_type, :in => attachment_options[:content_type], :message => "is not allowed", :allow_blank => true
  validates_inclusion_of :size, :in => attachment_options[:size], :message => " is too large", :allow_blank => true

  after_create :give_membership_to_creator

  format_attribute :description
  
  def owner
    creator
  end

  def creator?(user)
    creator == user
  end

  def admin?(user)
    admins.include? user
  end

  def member?(user)
    members.include? user
  end

  protected

    def give_membership_to_creator
      memberships.create! :member_id => creator.id, :admin => true if parent_id.nil?
    end

end
