//
//  NALLabelsMatrix.m
//
//  
//

#import "LabelsMatrix.h"

@implementation LabelsMatrix

- (id)initWithFrame:(CGRect)frame andColumnsWidths:(NSArray*)columns{
    NSLog(@"------ initWithFrame:LabelsMatrix ------------");
    

    self = [super initWithFrame:frame];
    if (self) {
        numRows = 0;
        self->columnsWidths = columns;
		self->dy = 0;
		self->numRows = 0;
    }
    
    return self;
}


- (void)addRecord: (NSArray*)record {
    NSLog(@"------ addRecord:LabelsMatrix ------------");
    
    if(record.count != self->columnsWidths.count){
        NSLog(@"!!! Number of items does not match number of columns. !!!");
        return;
    }
    
    uint rowHeight = 30;
	uint dx = 0;
	
    NSMutableArray* labels = [[NSMutableArray alloc] init];
    
	//create the items/columns of the row
    for(uint i = 0; i < record.count; i++) {
        float colWidth = [[self->columnsWidths objectAtIndex:i] floatValue];	//colwidth as given at setup
        CGRect rect = CGRectMake(dx, dy, colWidth, rowHeight);
		
		//adjust x for border overlapping betwen columns
		if(i > 0){
			rect.origin.x -= i;
		}
        
        //--------------------------------------------
        
        UILabel* col1 = [[UILabel alloc] init];
        [col1.layer setBorderColor:[[UIColor colorWithWhite:0.821 alpha:1.000] CGColor]];
        [col1.layer setBorderWidth:1.0];
		col1.font = [UIFont fontWithName:@"Helvetica" size:12.0];
		col1.frame = rect;
        
		//set the left and right margins and the alignment for the label
		NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
		style.alignment = NSTextAlignmentNatural;
		style.headIndent = 10;
		style.firstLineHeadIndent = 10.0;
		style.tailIndent = -10.0;
		
		//special treatment for the first row
        if(self->numRows == 0){
            style.alignment = NSTextAlignmentCenter;
			col1.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
            col1.font = [UIFont boldSystemFontOfSize:14.0f];
        }
		
		NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:[record objectAtIndex:i] attributes:@{ NSParagraphStyleAttributeName : style}];
		
        col1.lineBreakMode = NSLineBreakByCharWrapping;
        col1.numberOfLines = 0;
		col1.attributedText = attrText;
		[col1 sizeToFit];
        
		//used to find the height of the longest label
        CGFloat h = col1.frame.size.height + 10;
        if(h > rowHeight){
            rowHeight = h;
        }
        
		//make the label width the same as the column's width
		rect.size.width = colWidth;
        col1.frame = rect;
        
        [labels addObject:col1];
		
		//used for setting the next column x position
		dx += colWidth;
    }
    
    
	//create all labels the same size and then add to the view
    for(uint i = 0; i < labels.count; i++){
        UILabel* tempLabel = (UILabel*)[labels objectAtIndex:i];
        CGRect tempRect = tempLabel.frame;
        tempRect.size.height = rowHeight;
		tempLabel.frame = tempRect;
        [self addSubview:tempLabel];
    }
	
    self->numRows++;
	
	//adjust y for border overlapping between rows
	self->dy += rowHeight-1;
	
	//resixe the main view to fit the rows
	CGRect tempRect = self.frame;
	tempRect.size.height = dy;
	self.frame = tempRect;
    NSLog(@"------ addRecord:LabelsMatrix --->  numRows = %i", numRows);
}

@end
