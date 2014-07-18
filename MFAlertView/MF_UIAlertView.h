//
//  MF_UIAlertView.h
//  Custom alert view, rewrite of UIAlertView with blocks, optional spinner and custom styles
//
//  Created by moflo on 7/18/14.
//  Copyright (c) 2014 Mobile Flow LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    MF_UIALertTypeDefault,      // White dialog
    MF_UIAlertTypeBlack,        // Black dialog
    MF_UIAlertTypeBlue          // Blue dialog
} MF_UIAlertDesignType;

@interface MF_UIAlertButton : UIButton
//! UIButton subclass to add gradient.
{
	CAGradientLayer *gradientLayer;
}
- (void)updateTagType:(int)tag;
@end

@protocol MF_UIAlertViewDelegate;

typedef void (^completed)(int selectedButton);

@interface MF_UIAlertView : UIView {
@private
    id <MF_UIAlertViewDelegate> _delegate;
    UILabel   *_titleLabel;
    UILabel   *_bodyTextLabel;
    CGPoint    _center;
    MF_UIAlertButton  *_cancelButton;
    MF_UIAlertButton  *_defaultButton;
    MF_UIAlertButton  *_firstOtherButton;
    NSMutableArray *_buttons;
    UIView *_backView;
    
    struct {
        unsigned int alertViewClickedButtonAtIndex:1;
        unsigned int delegateHasValidView:1;
        unsigned int delegateViewSupportsAddSubView:1;
        unsigned int delegateHasValidWindow:1;
    } delegateRespondsTo;

    MF_UIAlertDesignType *_dialogType;
}

@property(nonatomic,strong) id <MF_UIAlertViewDelegate> delegate;    // weak reference
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *message;   // secondary explanation text

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<MF_UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

+ (id)showWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle defaultButtonTitle:(NSString *)defaultButtonTitle otherButtonTitle:(NSString *)otherButtonTitle withBlock:(completed)completedBlock;

+ (id)showSpinnerWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle withBlock:(completed)completedBlock;

// Set delegate method
- (void)setDelegate:(id <MF_UIAlertViewDelegate>)delegate;

// shows popup alert animated.
- (void)show;

// Dismisses the popup, animated
- (void)dismiss;

- (void)doButton:(id)sender;

@end


@protocol MF_UIAlertViewDelegate <NSObject>
@optional

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(MF_UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
