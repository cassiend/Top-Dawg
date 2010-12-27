#import "Terms.h"

@implementation Terms

@synthesize textView, textView2, textView3, textView4;


- (void)viewDidLoad {
	
	NSString *termsConditions = @"Terms & Condtions";
	
	NSString *termsConditions2 = @"Sponsor: Hooray LLC.";
	
	NSString *termsConditions3 = @"YOU ACKNOWLEDGE AND AGREE THAT, BY ACCESSING OR USING THE SERVICES OR BY ACCESSING ANY CONTENT THROUGH THE SERVICES OR THE SITE, YOU ARE INDICATING THAT YOU HAVE READ, UNDERSTAND AND AGREE TO BE BOUND BY THESE TERMS OF SERVICE, WHETHER OR NOT YOU HAVE REGISTERED WITH HOORAY LLC. IF YOU DO NOT AGREE TO THESE TERMS OF SERVICE, THEN YOU HAVE NO RIGHT TO ACCESS OR USE THE SERVICES.";
	
	NSString *termsConditions4 = @"Our primary goals in collecting information are to provide and improve our application, services, features and content, to administer your Account. We reserve the right to remove content and accounts that we determine in our sole discretion are or may be unlawful, threatening, offensive, obscene or in violation of any party's intellectual property rights, this Code of Conduct or our Terms of Use.";
	NSString *termsConditions5a = @"How You May Use the Service: In using the service, you will:";
	NSString *termsConditions5b =@" • Obey the law";
	NSString *termsConditions5c =@" • Obey any codes of conduct or other notices we provide";
	NSString *termsConditions5d =@" • Obey the Apple Policy, available at http://developer.apple.com/iphone/download.action?path=%2Fiphone%2Fiphone_sdk_3.1.2__final%2Fea0574_iphone_sdk.pdf";
	NSString *termsConditions5e =@" • Keep your service account password secret; and you are solely responsible for the activity that occurs on your account. You must notify Hooray LLC immediately of any breach of security or unauthorized use of your account. Although Hooray LLC will not be liable for your losses caused by any unauthorized use of your account";
	NSString *termsConditions6 = @"Uses of Information: We use the information we collect to provide the services you request. Our services may include the display of personalized content and advertising.";
	NSString *termsConditions7 = @"The monthly winner's submission photo will be shown in the Winner's section in the Top Dawg iPhone app on the first business day after the end of the monthly voting period.";

	NSString *termsConditions8 = @"By uploading your dog’s image you hereby irrevocably assign and transfer to Hooray LLC “Hooray” any and all rights, title and interest in and to all elements of the Entry, including, without limitation, all copyrights, without compensation, unless prohibited by law. In addition, Top Dawg Users represents that s/he has obtained all necessary rights to the photograph, if applicable, and hereby grants Hooray and its affiliated companies and divisions, publication and use rights as described herein. Furthermore, by uploading your photo, if the photo depicts a person next to the dog, App user represents that s/he has obtained all necessary permission, including but not limited to any likeness release and/or written permission to include person in photo. Submissions and photographs will not be acknowledged and will not be received or held \"in confidence\" and a submission does not create a confidential relationship or obligation of secrecy between the user and Hooray or any of its affiliates. If the Top Dawg iPhone app is filmed and/or are on TV or the Internet, User’s hereby grant Hooray to use their name, and or likeness in connection with the filming or air of the coverage.";
	
	NSString *termsConditions9 = @"Hooray reserves the right to disqualify a submission for engaging in any activity which offends the public morals, embarrasses Hooray or violates the law, or is suspected of violating the law of any jurisdiction. By uploading a photo to the Top Dawg application, the user releases and holds harmless Hooray and its respective directors, officers, employees, agents and advertising and promotional agencies from any and all liability or any injuries, including but not limited to loss of life, loss or damage to any property of any kind arising from or in connection with this application.";
	NSString *termsConditions10 = @"General: Hooray is not responsible for problems uploading or downloading any application related information from the Top Dawg iPhone app or for any other technical malfunctions of electronic equipment, computer online systems, servers, or providers, computer hardware or software failures, phone line failure, failure of any electronic upload to be received by Hooray on account of technical problems, traffic, congestion on the Internet and/or the Top Dawg iPhone app, or any other technical problems related to the photo entries including telecommunication miscommunication or failure, and failed, lost, delayed, incomplete, garbled or misdirected communications which may limit the user's ability to participate.";
	NSString *space  = @"\n";
	
	termsConditions = [termsConditions stringByAppendingString:space];
	termsConditions = [termsConditions stringByAppendingString:space];
	termsConditions = [termsConditions stringByAppendingString:termsConditions2];
	termsConditions = [termsConditions stringByAppendingString:space];
	termsConditions = [termsConditions stringByAppendingString:space];
	termsConditions = [termsConditions stringByAppendingString:termsConditions3];
	termsConditions = [termsConditions stringByAppendingString:space];
	termsConditions = [termsConditions stringByAppendingString:space];
	termsConditions = [termsConditions stringByAppendingString:termsConditions4];
	termsConditions = [termsConditions stringByAppendingString:space];
	termsConditions = [termsConditions stringByAppendingString:termsConditions5a];
	termsConditions = [termsConditions stringByAppendingString:space];
	termsConditions = [termsConditions stringByAppendingString:termsConditions5b];
	termsConditions = [termsConditions stringByAppendingString:space];
	termsConditions = [termsConditions stringByAppendingString:termsConditions5c];
	termsConditions = [termsConditions stringByAppendingString:space];
	termsConditions = [termsConditions stringByAppendingString:termsConditions5d];
	termsConditions = [termsConditions stringByAppendingString:space];
	termsConditions = [termsConditions stringByAppendingString:termsConditions5e];
	termsConditions = [termsConditions stringByAppendingString:space];
	termsConditions = [termsConditions stringByAppendingString:space];
	termsConditions = [termsConditions stringByAppendingString:termsConditions6];
	termsConditions = [termsConditions stringByAppendingString:termsConditions7];
	termsConditions = [termsConditions stringByAppendingString:space];
	termsConditions = [termsConditions stringByAppendingString:space];
	termsConditions = [termsConditions stringByAppendingString:termsConditions8];
	termsConditions = [termsConditions stringByAppendingString:space];
	termsConditions = [termsConditions stringByAppendingString:space];
	termsConditions = [termsConditions stringByAppendingString:termsConditions9];
	termsConditions = [termsConditions stringByAppendingString:space];
		termsConditions = [termsConditions stringByAppendingString:space];
	termsConditions = [termsConditions stringByAppendingString:termsConditions10];
	
	self.textView.text = termsConditions;
	self.textView.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
}

- (void)viewDidUnload {
	textView = nil;
}


- (void)dealloc {
    [textView release];
	[super dealloc];
}

@end