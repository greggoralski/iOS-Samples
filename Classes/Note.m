/*
     File: Note.m 
 Abstract: Model class to represent a note.
  
  Version: 1.4 
  
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple 
 Inc. ("Apple") in consideration of your agreement to the following 
 terms, and your use, installation, modification or redistribution of 
 this Apple software constitutes acceptance of these terms.  If you do 
 not agree with these terms, please do not use, install, modify or 
 redistribute this Apple software. 
  
 In consideration of your agreement to abide by the following terms, and 
 subject to these terms, Apple grants you a personal, non-exclusive 
 license, under Apple's copyrights in this original Apple software (the 
 "Apple Software"), to use, reproduce, modify and redistribute the Apple 
 Software, with or without modifications, in source and/or binary forms; 
 provided that if you redistribute the Apple Software in its entirety and 
 without modifications, you must retain this notice and the following 
 text and disclaimers in all such redistributions of the Apple Software. 
 Neither the name, trademarks, service marks or logos of Apple Inc. may 
 be used to endorse or promote products derived from the Apple Software 
 without specific prior written permission from Apple.  Except as 
 expressly stated in this notice, no other rights or licenses, express or 
 implied, are granted by Apple herein, including but not limited to any 
 patent rights that may be infringed by your derivative works or by other 
 works in which the Apple Software may be incorporated. 
  
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE 
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION 
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS 
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND 
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS. 
  
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL 
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, 
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED 
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), 
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE 
 POSSIBILITY OF SUCH DAMAGE. 
  
 Copyright (C) 2010 Apple Inc. All Rights Reserved. 
  
 */

#import "Note.h"

@implementation Note

@synthesize delegate;
@dynamic created,modified,title,text;

/**
 *
 */
- (void) updateNoteText:(NSString*) text
{ if( text!=nil )
  { NSManagedObject* textObj = [self valueForKey:@"text"];
    
    [textObj setValue:text forKey:@"data"];
    
    NSArray*  lines     = [text componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    NSString* firstLine = [lines objectAtIndex:0];
    
    self.title = firstLine==nil ? text : firstLine;
    
    [delegate noteWasUpdated:self];
  } // of if
} // of updateNoteText:

/**
 *
 */
- (NSString*) getNoteText
{ NSManagedObject* textObj = [self valueForKey:@"text"];
  NSString*        result  = [textObj valueForKey:@"data"];
  
  return result;
} // of getNoteText:
@end


@implementation TextToDataTransformer


+ (BOOL)allowsReverseTransformation 
{ return YES; }

+ (Class)transformedValueClass 
{	return [NSData class]; }


- (id)transformedValue:(id)value 
{	NSData *data = [value dataUsingEncoding: NSUTF8StringEncoding];
	
  return data;
}


- (id)reverseTransformedValue:(id)value 
{ NSString* result = [[NSString alloc] initWithData:value encoding:NSUTF8StringEncoding];

	return [result autorelease];
}

@end