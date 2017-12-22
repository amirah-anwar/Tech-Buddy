ThinkingSphinx::Index.define :user, with: :real_time do
	indexes skill
	indexes course_code
	indexes course_name
	indexes major
	indexes education_level
	indexes :name
	indexes goal

	has id, as: :user_id, type: :integer
end