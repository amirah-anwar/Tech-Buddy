class User < ApplicationRecord
	has_many :buddyships
	has_many :buddies, through: :buddyships

	has_many :inverse_buddyships, class_name: "Buddyship", foreign_key: "buddy_id"
	has_many :inverse_buddies, through: :inverse_buddyships, source: :user

	MAJORS = ["American Language Institute","American Studies and Ethnicity","Anthropology","Arabic","Art History","Astronomy","Biological Sciences","Chemistry","Classics","Comparative Literature","Thematic Option","Comparative Studies in Literature and Culture","East Asian Languages and Cultures","East Asian Studies","Economics","English","Environmental Studies Program","French","Freshman Seminars","Geography","Geological Sciences","German","Gender Studies","Greek","Hebrew","History","Human Biology","Interdisciplinary Major Program","International Relations","Persian","Italian","Judaic Studies","Latin","Linguistics","Mathematics","Multidisciplinary Activities","Middle East Studies","Master of Professional Writing","Neuroscience","Neuroscience - Graduate","Ocean Sciences","Physical Education","Philosophy","Physics","Political Science and International Relations","Portuguese","Political Science","Psychology","Religion","Registrar's Office","Slavic Languages and Literatures","Sociology","Spanish","Spatial Sciences","Sophomore Seminar","University of Southern California","Visual Studies","Writing","Accounting","Architecture","Arts,Technology and the Business of Innovation","Integrated Design,Business and Technology","Business Entrepreneurship","Business Administration","Business Communication","Data Sciences and Operations","Finance and Business Economics","Graduate School of Business Administration","Library and Information Management","Marketing","Management and Organization","Human Resource Management","Motion Picture Producing","Cinematic Arts","Animation","Cinema and Media Studies","Interactive Media","Production","Writing","Media Arts and Practice","Communication and Journalism","Communication Management","Communication","Digital Social Media","Journalism","Public Relations","Public Diplomacy","Dance","Advanced Dental Education Conjoint Program","Anatomy","Dentistry","Craniofacial Biology","Dental Biochemistry","Dentistry History","Dental Hygiene","Oral Diagnosis And Radiology","Dental Problem Based Learning","DPHR","Geriatric Dentistry","Occlusion","Orofacial Pain","Orofacial Pain and Oral Medicine","Oral Medicine Oral Diagnosis","Oral Pathology and Radiology","Pediatric Dentistry","Periodontics","Dramatic Arts","Education Counseling","Higher and Postsecondary Education","Education","Aerospace and Mechanical Engineering","Astronautical Engineering","Biomedical Engineering","Chemical Engineering","Civil Engineering","Computer Science","Electrical Engineering","Environmental Engineering","Engineering","Industrial and Systems Engineering","Informatics","Information Technology Program","Materials Science","Petroleum Engineering","Systems Architecting and Engineering","Art","Critical Studies","Design","Category I: Western Cultures and Traditions","Category II: Global Cultures and Traditions","Category III: Scientific Inquiry","Category IV: Science and Its Significance","Category V: Arts and Letters","Category VI: Social Issues","Category A: The Arts","Category B: Humanistic Inquiry","Category C: Social Analysis","Category D: Life Sciences","Category E: Physical Sciences","Category F: Quantitative Reasoning","Category G: Citizenship in a Diverse World","Category H: Traditions and Historical Foundations","General Education Seminar","Gerontology","Graduate Studies","Law","Academic Medicine","Anesthesiology","Biochemistry","Cancer Biology & Genomics","Development,Stem Cells and Regenerative Medicine","Health Promotion and Disease Prevention Studies","Interdepartmental","Medical Biophysics","Medicine","Medical Biology","Medical Sciences","Molecular Microbiology and Immunology","Medical Physiology","Molecular Structure & Signaling (MSS)","Neuroimaging and Informatics","Pain Medicine","Pathology","Physiology and Biophysics","Preventive Medicine","Primary Care Physician Assistant","Stem Cell Biology and Regenerative Medicine","Translational Genomics","Arts Leadership","Music Technology","Sacred Music","Music Teaching and Learning","Choral Music","Composition","Conducting","Music Ensemble","Music History and Literature","Music Industry","Jazz Studies","Performance (Early Music)","Performance (Guitar)","Performance (Keyboard Studies)","Performance (Popular Music)","Performance (Strings)","Performance (Vocal Arts)","Performance (Winds and Percussion)","Music","Screen Scoring","Nursing","Occupational Science and Occupational Therapy","Healthcare Decision Analysis","Molecular Pharmacology and Toxicology","Pharmacy","Pharmaceutical Economics and Policy","Pharmaceutical Sciences","Regulatory Science","Pharmaceutical and Regulatory Science","Biokinesiology","Physical Therapy","Aerospace Studies","Global Policy,Planning and Development","Health Care Management","Military Science","Nautical Science","Naval Science","Policy,Planning and Development","Policy,Planning and Development - Expanded","Urban and Regional Planning","Real Estate Development","Social Work"]
	EDUCATION_LEVELS = ["Freshman", "Sophomore", "Junior", "Senior", "Master", "PhD"]
	STATUS = ["Buddy-less", "Buddied-Up"]
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "missing.jpg"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  validates :name, presence: true, length: { in: 2..50 }

  validates :email, uniqueness:true, format: { with: EMAIL_REGEX,
              message: "format should be: user@example.com" }

  after_save ThinkingSphinx::RealTime.callback_for(:user)

  def skill=(value)
    value.reject!(&:blank?)
    self.send("write_attribute", "skill", value.join(", "))
  end

  def skill
    self.read_attribute(:skill).to_s.split(", ")
  end

  def course_name=(value)
    value.reject!(&:blank?)
    self.send("write_attribute", "course_name", value.join(", "))
  end

  def course_name
    self.read_attribute(:course_name).to_s.split(", ")
  end

end
