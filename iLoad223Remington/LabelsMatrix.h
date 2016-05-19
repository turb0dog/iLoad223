//
//  NALLabelsMatrix.h
//
// 
//

#import <UIKit/UIKit.h>

@interface LabelsMatrix : UIView {
    NSArray *columnsWidths;
    uint numRows;
    uint dy;
}

- (id)initWithFrame:(CGRect)frame andColumnsWidths:(NSArray*)columns;
- (void)addRecord:(NSArray*)record;

@end