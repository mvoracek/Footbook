//
//  AddPhotosViewController.m
//  Footbook
//
//  Created by Matthew Voracek on 1/29/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
//

#import "AddPhotosViewController.h"
#import "PhotoCollectionViewCell.h"

@interface AddPhotosViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *photoArray;
    NSMutableArray *dataForImages;
    __weak IBOutlet UICollectionView *photoCollectionView;
    __weak IBOutlet UIActivityIndicatorView *spinner;
}

@end

@implementation AddPhotosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadPhotos];
}

-(void)loadPhotos
{
    [spinner startAnimating];
    
    NSURL *url = [NSURL URLWithString:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=688e3c3cb5d57f1a49a8caaaacba3879&tags=shoes&license=1%2C2%2C3%2C4%2C5%2C6&extras=url_q&format=json&nojsoncallback=1"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         photoArray = [NSJSONSerialization JSONObjectWithData:data
                                                      options:NSJSONReadingAllowFragments
                                                        error:&connectionError][@"photos"][@"photo"];
         for (NSDictionary *photo in photoArray)
         {
             NSURL *photoURL = [NSURL URLWithString:photo[@"url_q"]];
             UIImage *image = [UIImage new];
             image = [UIImage imageWithData:[NSData dataWithContentsOfURL:photoURL]];
             [dataForImages addObject:image];
         }
         
         [photoCollectionView reloadData];
         [spinner stopAnimating];

     }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return photoArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoID" forIndexPath:indexPath];
    
    cell.imageView.image = dataForImages[indexPath.row];
    
    return cell;
    
}

@end
