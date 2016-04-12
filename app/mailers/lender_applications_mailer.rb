class LenderApplicationsMailer < ActionMailer::Base
	# Use application_mail.html.erb
	layout 'application_mailer'

	# Automatically inject css styles
	include Roadie::Rails::Automatic
	
	# Mail defaults
	default from: "BorrowTomorrow <staff@borrowtomorrow.io>"

	# Mail when lender application is created
	def created(lenderApp)
		admin_email = 'gsuri@usc.edu'
		@lenderApp 	= lenderApp
		subject 	= 'BorrowTomorrow: New Lender Application'

		mail(to: admin_email, subject: subject) do |format|
			format.html { render 'created' }
		end
	end

	# Mail when lender application status is updated
	def updated(lenderApp)
		@author  	= lenderApp.author
		@lenderApp 	= lenderApp
		template 	= @lenderApp.status

		# Change the subject base on @lenderApp status
		if @lenderApp.approved?
			subject = "BorrowTomorrow: Lender Application Approved!"
	 	elsif @lenderApp.denied?
			subject = "BorrowTomorrow: Lender Application Denied"
		end

		mail(to: @author.email, subject: subject) do |format|
			format.html { render template }
		end
	end
end
