//
//  MF_UIAlertView.m
//  Custom alert view, rewrite of UIAlertView with blocks, optional spinner and custom styles
//
//  Created by moflo on 7/18/14.
//  Copyright (c) 2014 Mobile Flow LLC. All rights reserved.
//

#import "MF_UIAlertView.h"


@implementation MF_UIAlertButton
- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self awakeFromNib];
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
        [self setTitleShadowColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.titleLabel.shadowOffset = CGSizeMake(0.0, 0.0);
        self.reversesTitleShadowWhenHighlighted = YES;

        self.titleLabel.font = [UIFont systemFontOfSize:12];

        self.backgroundColor = [UIColor whiteColor];

	}
	return self;
}

- (void)awakeFromNib
{
	if (self.tag == 100) {
        // Default Button
        self.titleLabel.font = [UIFont boldSystemFontOfSize:12];


	}
	else if (self.tag == 101) {

        //[self setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
        // Add line to the right of the button
        
        // Add vertical line in middle of buttons
        // Dialog decoration, lines above button(s)
        CALayer *lineLayer = [[CALayer alloc] init];
        [lineLayer setBounds:CGRectMake(0, 0, 0.5, self.frame.size.height)];
        [lineLayer setPosition:	CGPointMake(self.frame.size.width-1.0,self.frame.size.height*0.5)];
        [lineLayer setBackgroundColor:[UIColor blackColor].CGColor];
        [[self layer] insertSublayer:lineLayer atIndex:0];

        
	}
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (!gradientLayer) {
        [self awakeFromNib];
    }
    gradientLayer.frame = self.bounds;      // Update layer frame size whenever view's frame is update, ie., after rotation
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

- (void)updateTagType:(int)tag
{
    self.tag = tag;
    // Need to undo the insertion of any gradientLayer
    // [[self layer] insertSublayer:gradientLayer atIndex:0];
    if (gradientLayer) {
        [gradientLayer removeFromSuperlayer];
        gradientLayer = nil;
    }
    
    // Force redraw of layers from as if from nib
    [self awakeFromNib];
    
}

- (void) layoutSubviews {
	[super layoutSubviews];
	[self setNeedsDisplay];
}

- (void) setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	[self setNeedsDisplay];
}

- (void) setSelected:(BOOL)selected {
	[super setSelected:selected];
	[self setNeedsDisplay];
}

- (void) setEnabled:(BOOL)enabled {
	[super setEnabled:enabled];
	[self setNeedsDisplay];
}
@end

@interface MF_UIAlertView ()
@property (nonatomic, copy) completed completedBlock;
@end

@implementation MF_UIAlertView
@synthesize delegate = _delegate;
@synthesize title = _title;
@synthesize message = _message;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _dialogType = MF_UIALertTypeDefault;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

+ (id)showWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle defaultButtonTitle:(NSString *)defaultButtonTitle otherButtonTitle:(NSString *)otherButtonTitle withBlock:(completed)completedBlock
{
    
    MF_UIAlertView *alert = [[MF_UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:defaultButtonTitle,otherButtonTitle, nil];
    
    alert.completedBlock = completedBlock;

    [alert show];

    return alert;
}

+ (id)showSpinnerWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle withBlock:(completed)completedBlock
{
    MF_UIAlertView *alert = [[MF_UIAlertView alloc] initWithTitle:title message:@"XXX" delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    
    [alert replaceBodyTextWithSpinner];
    
    alert.completedBlock = completedBlock;
    
    [alert show];
    
    return alert;

}


- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<MF_UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... 
{
    // Initialize with empty frame, resize later
    self = [self initWithFrame:CGRectZero];
    
    // Save delegate
    [self setDelegate:delegate];
    
    // Save title & messages
    _title = title;
    _message = message;
    
    // Create a mutuable array of other button titles
    _buttons = [NSMutableArray arrayWithCapacity:2];
    va_list args;
    va_start(args, otherButtonTitles);
    for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*))
    {
        [_buttons addObject:[arg uppercaseString]];
    }
    va_end(args);

    // Create & size the alert UIView based on the button & text settings
    CGFloat viewHeight = 0.0;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    _titleLabel.text = _title;
    _titleLabel.font = [UIFont systemFontOfSize:20.0];
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    _titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.shadowColor = [UIColor lightGrayColor];
    _titleLabel.shadowOffset = CGSizeMake(0.0, 0.0);
    
    _titleLabel.backgroundColor = [UIColor clearColor];
    
    float titleTextHeight = [_titleLabel.text boundingRectWithSize:CGSizeMake(200,44)
                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                        attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize: 20.0] } context:nil].size.height;

    _bodyTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    _bodyTextLabel.numberOfLines = 4;
    _bodyTextLabel.text = _message;
    _bodyTextLabel.font = [UIFont systemFontOfSize:14.0];
    _bodyTextLabel.textAlignment = NSTextAlignmentCenter;
    _bodyTextLabel.textColor = [UIColor blackColor];
    _bodyTextLabel.shadowColor = [UIColor lightGrayColor];
    _bodyTextLabel.shadowOffset = CGSizeMake(0.0, 0.0);
    _bodyTextLabel.backgroundColor = [UIColor clearColor];

    float bodyTextHeight = [_titleLabel.text boundingRectWithSize:CGSizeMake(200,44)
                                                           options:NSStringDrawingUsesLineFragmentOrigin
                                                        attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize: 14.0] } context:nil].size.height;

    [_bodyTextLabel setFrame:CGRectMake(0, 0, 200, bodyTextHeight + 44)];
    
    viewHeight = viewHeight + titleTextHeight + bodyTextHeight;
    
    [self setFrame:CGRectMake(0.0, 0.0, 250.0, viewHeight+120.0)];
    
    _titleLabel.center = CGPointMake(self.center.x, 40.0);
    [self addSubview:_titleLabel];
    
    _bodyTextLabel.center = CGPointMake(self.center.x, 80.0);
    [self addSubview:_bodyTextLabel];
     
    // Magic code to force a rounded rectangle mask on the layer...
    [[self layer] setCornerRadius:8.0f];
    [[self layer] setMasksToBounds:YES];
    
    // Add border with 1.0 pixel width
    [[self layer] setBorderWidth:1.0f];
    [[self layer] setBorderColor:[[UIColor lightTextColor] CGColor]];
    [[self layer] setShadowColor:[[UIColor lightGrayColor] CGColor]];
    [[self layer] setShadowOffset:CGSizeMake(0.0f, 1.0f)];
    [[self layer] setShadowOpacity:0.8f];
    [[self layer] setShadowRadius:2.0f];

    // Add buttons
#define kDefaultButtonHeight 37
#define kDefaultButtonWidth 58
#define kDefaultButtonVertOffset 0
    int totalNumberOfButtons = 1 + [_buttons count];
    
    _cancelButton = [[MF_UIAlertButton alloc] initWithFrame:CGRectMake(0, 0, kDefaultButtonWidth, kDefaultButtonHeight)];
    _cancelButton.tag = 101;
    [_cancelButton setTitle:[cancelButtonTitle uppercaseString] forState:UIControlStateNormal];
    [_cancelButton setTitle:[cancelButtonTitle uppercaseString]forState:UIControlStateSelected];
    [_cancelButton addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
    _cancelButton.center = CGPointMake(self.center.x, self.frame.size.height - kDefaultButtonHeight*.5 - kDefaultButtonVertOffset);

    [self addSubview:_cancelButton];
    
    if ([_buttons count]) {
        _defaultButton = [[MF_UIAlertButton alloc] initWithFrame:CGRectMake(0, 0, kDefaultButtonWidth, kDefaultButtonHeight)];
        _defaultButton.tag = 100;
        [_defaultButton setTitle:[_buttons objectAtIndex:0] forState:UIControlStateNormal];
        [_defaultButton setTitle:[_buttons objectAtIndex:0] forState:UIControlStateSelected];
        [_defaultButton addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
        _defaultButton.center = CGPointMake(self.center.x, self.frame.size.height - kDefaultButtonHeight*.5 - kDefaultButtonVertOffset);
        [self addSubview:_defaultButton];
    }
    
    if ([_buttons count] == 2) {
        _firstOtherButton = [[MF_UIAlertButton alloc] initWithFrame:CGRectMake(0, 0, kDefaultButtonWidth, kDefaultButtonHeight)];
        _firstOtherButton.tag = 101;
        [_firstOtherButton setTitle:[_buttons objectAtIndex:0] forState:UIControlStateNormal];
        [_firstOtherButton setTitle:[_buttons objectAtIndex:0] forState:UIControlStateSelected];
        [_firstOtherButton addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
        _firstOtherButton.center = CGPointMake(self.center.x, self.frame.size.height - kDefaultButtonHeight*.5 - kDefaultButtonVertOffset);
        [self addSubview:_firstOtherButton];
        
    }
    
    
    // Dialog decoration, lines above button(s)
    CALayer *lineLayer = [[CALayer alloc] init];
    [lineLayer setBounds:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    [lineLayer setPosition:	CGPointMake(self.frame.size.width/2,self.frame.size.height - kDefaultButtonHeight - 1.0)];
    [lineLayer setBackgroundColor:[UIColor blackColor].CGColor];
    [[self layer] insertSublayer:lineLayer atIndex:0];

    // Adjust frame & centers of buttons
    if (totalNumberOfButtons == 1) {
        [_cancelButton setFrame:CGRectMake(0, 0, self.frame.size.width, kDefaultButtonHeight)];
        _cancelButton.center = CGPointMake(self.center.x, self.frame.size.height - kDefaultButtonHeight*.5 - kDefaultButtonVertOffset);
        [_cancelButton updateTagType:101];
    }
    else if (totalNumberOfButtons == 2) {
        [_cancelButton setFrame:CGRectMake(0, 0, self.frame.size.width*0.5, kDefaultButtonHeight)];
        _cancelButton.center = CGPointMake(self.center.x-self.frame.size.width*0.25, self.frame.size.height - kDefaultButtonHeight*.5 - kDefaultButtonVertOffset);
        [_cancelButton updateTagType:101];
        [_defaultButton setFrame:CGRectMake(0, 0, self.frame.size.width*0.5, kDefaultButtonHeight)];
        _defaultButton.center = CGPointMake(self.center.x+self.frame.size.width*0.25, self.frame.size.height - kDefaultButtonHeight*.5 - kDefaultButtonVertOffset);
        [_defaultButton updateTagType:100];
        
    }
    else if (totalNumberOfButtons == 3) {
        [_cancelButton setFrame:CGRectMake(0, 0, self.frame.size.width*0.33, kDefaultButtonHeight)];
        _cancelButton.center = CGPointMake(self.center.x-self.frame.size.width*0.33, self.frame.size.height - kDefaultButtonHeight*.5 - kDefaultButtonVertOffset);
        [_cancelButton updateTagType:101];
        [_firstOtherButton setFrame:CGRectMake(0, 0, self.frame.size.width*0.33, kDefaultButtonHeight)];
        _firstOtherButton.center = CGPointMake(self.center.x, self.frame.size.height - kDefaultButtonHeight*.5 - kDefaultButtonVertOffset);
        [_firstOtherButton updateTagType:101];
        [_defaultButton setFrame:CGRectMake(0, 0, self.frame.size.width*0.33, kDefaultButtonHeight)];
        _defaultButton.center = CGPointMake(self.center.x+self.frame.size.width*0.33, self.frame.size.height - kDefaultButtonHeight*.5 - kDefaultButtonVertOffset);
        [_defaultButton updateTagType:100];

    }
    
    

    
    // Create background textured view
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _backView = [[UIView alloc] initWithFrame:window.frame];
    CAGradientLayer *gradientLayerBackground = [[CAGradientLayer alloc] init];
    [gradientLayerBackground setBounds:[_backView bounds]];
    [gradientLayerBackground setPosition:	CGPointMake([_backView bounds].size.width/2,[_backView bounds].size.height/2)];
    //[gradientLayer setStartPoint: CGPointMake(0.5,0.2)];	
    //[gradientLayer setEndPoint:	CGPointMake(0.5,0.75)];	
    gradientLayerBackground.colors = [NSArray arrayWithObjects:
                            (id)[UIColor colorWithRed:11/255.0 green:36/255.0 blue:41/255.0 alpha:0.2].CGColor,
                            (id)[[UIColor colorWithRed:11/255.0 green:36/255.0 blue:41/255.0 alpha:0.7] CGColor], nil];
    gradientLayerBackground.locations = [NSArray arrayWithObjects:
                               (id)[NSNumber numberWithFloat:0.0], 
                               (id)[NSNumber numberWithFloat:1.0], nil];
    [[_backView layer] insertSublayer:gradientLayerBackground atIndex:0];

    return self;
}

- (void) replaceBodyTextWithSpinner
{
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.frame = _bodyTextLabel.frame;
    [spinner startAnimating];
    _bodyTextLabel.hidden = YES;
    [self addSubview:spinner];
    
}

- (void)setDelegate:(id /*<MF_UIAlertViewDelegate>*/)delegate {
    if (_delegate != delegate) {
        _delegate = delegate;
        
        delegateRespondsTo.alertViewClickedButtonAtIndex = [_delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)];
        delegateRespondsTo.delegateHasValidView = [_delegate respondsToSelector:@selector(view)];
        if (delegateRespondsTo.delegateHasValidView) {
            UIView *delegateView = [_delegate performSelector:@selector(view) withObject:nil];
            delegateRespondsTo.delegateViewSupportsAddSubView = [delegateView respondsToSelector:@selector(addSubview:)];
        }
        delegateRespondsTo.delegateHasValidWindow = [_delegate respondsToSelector:@selector(window)];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}
*/

- (void)show
{
    // Display the alert in the delegate view
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window) {
        CGPoint center;
        if (delegateRespondsTo.delegateViewSupportsAddSubView) {
            UIView *view = [_delegate performSelector:@selector(view) withObject:nil];
            center = view.center;
        }
        else {
            center = window.center;
        }
        // Create a backing UIView, add to the main window
        [window addSubview:_backView];
        self.center = CGPointMake(center.x, center.y-20);
        self.transform = CGAffineTransformMakeScale(0.4, 0.4);
        self.alpha = 0.5;
        [window addSubview:self];
        [UIView animateWithDuration:0.15 
                         animations:^{
                             _backView.alpha = 1.0;
                         } 
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:0.15 animations:^{
                                 self.transform = CGAffineTransformMakeScale(1.2, 1.2);
                                 self.center = center;
                                 self.alpha = 1.0;
                             }
                                completion:^(BOOL finished){
                                    [UIView animateWithDuration:0.10 animations:^{
                                        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                    }];
                             }];
                         }];

    }
}

- (void)doButton:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSLog(@"MF_UIAlertView, button=%d",button.tag);
    int button_tag = 0;
    if (button == _cancelButton) {
        button_tag = 0;
    }
    else if (button == _defaultButton) {
        button_tag = 1;
    }
    else if (button == _firstOtherButton) {
        button_tag = 2;
    }
    
    
    if (delegateRespondsTo.alertViewClickedButtonAtIndex) {
        [_delegate alertView:self clickedButtonAtIndex:button_tag];
    }
    
    [UIView animateWithDuration:0.10
                     animations:^{
                         _backView.alpha = 0.5;
                         self.alpha = 0.2;
                         self.transform = CGAffineTransformMakeScale(0.4, 0.4);
                     }
                     completion:^(BOOL finished){
                         [_backView removeFromSuperview];
                         [self removeFromSuperview];
                         
                         if (_completedBlock) {
                             _completedBlock(button_tag);
                         }
                     }
     ];
    
    _titleLabel = nil;
    _bodyTextLabel = nil;
    _cancelButton = nil;
    _defaultButton = nil;
    _firstOtherButton = nil;
    
}

- (void) dismiss
{
    [UIView animateWithDuration:0.10
                     animations:^{
                         _backView.alpha = 0.5;
                         self.alpha = 0.2;
                         self.transform = CGAffineTransformMakeScale(0.4, 0.4);
                     }
                     completion:^(BOOL finished){
                         [_backView removeFromSuperview];
                         [self removeFromSuperview];
                         
                     }
     ];
    
    _titleLabel = nil;
    _bodyTextLabel = nil;
    _cancelButton = nil;
    _defaultButton = nil;
    _firstOtherButton = nil;

}
@end

