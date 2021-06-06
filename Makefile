envFile="$(shell ls -a | grep .env)"

ifeq ("$(shell echo ${envFile})" , "$(shell echo .env)")
  include .env
  export
else
  AD_UNIT_ID=ca-app-pub-3940256099942544/2934735716
endif


bootstrap: install-gems xcodegen set-pods-keys install-pod install-carthage
execute-xcodegen-and-pod: xcodegen install-pod

# cocoapods
install-pod:
	bundle exec pod install --repo-update

# carthage
install-carthage:
	bundle exec carthage update --platform iOS

# gem
install-gems:
	rm -rf vendor/
	gem install -N bundler
	bundle install

xcodegen:
	swift run --package-path CLI/_xcodegen -c release xcodegen 

set-pods-keys:
	bundle exec pod keys set "AdUnitID" ${AD_UNIT_ID} LongWeekend
