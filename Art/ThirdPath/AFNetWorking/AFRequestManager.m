//
//  AFRequestManager.m
//  AFNetWorking
//
//  Created by dkq on 16/4/15.
//  Copyright © 2016年 kaiqiang. All rights reserved.
//

#import "AFRequestManager.h"


static AFRequestManager *manager = nil;
@implementation AFRequestManager

+(AFRequestManager *)sharedAFRequestManager{
    
    @synchronized(self) {
        if (!manager) {
            manager = [[self alloc] init];
        }
    }
    return manager;
}

- (void) requestByGet:(NSString *)url andParam:(NSDictionary *)parameters successBlock:(RequestSuccess)successBlock failedBlock:(RequestFailed)failBlock andTime:(NSInteger)time
{
   AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer.timeoutInterval = time;
    
    [session GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if(responseObject!=nil){
            if(successBlock){
                successBlock(dict);
            }
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(error!=nil){
            if(failBlock){
                failBlock(error);
            }
        }
    
    }];

 }



-(void) requestByPost:(NSString *)url andParam:(NSDictionary *)parameters successBlock:(RequestSuccess)successBlock fialedBlock:(RequestFailed)failBlock andTime:(NSInteger)time
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
  session.requestSerializer.timeoutInterval = time;
    
    [session POST:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
       // NSLog(@"%ld",downloadProgress.);
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if(responseObject!=nil){
            if(successBlock){
                successBlock(dict);
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(error!=nil){
            if(failBlock){
                failBlock(error);
            }
        }
        
    }];

}


-(void) requestByPut:(NSString *)url andParam:(NSDictionary *)parameters successBlock:(RequestSuccess)successBlock fialedBlock:(RequestFailed)failBlock andTime:(NSInteger)time
{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
     session.requestSerializer.timeoutInterval = time;
    
    [session PUT:url parameters:parameters
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
              
              NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              if(responseObject!=nil){
                  if(successBlock){
                      successBlock(dict);
                  }
              }
              
              
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              
              if(error!=nil){
                  if(failBlock){
                      failBlock(error);
                  }
              }
          }];
}


-(void) requestByDelete:(NSString *)url andParam:(NSDictionary *)parameters successBlock:(RequestSuccess)successBlock fialedBlock:(RequestFailed)failBlock andTime:(NSInteger)time
{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
     session.requestSerializer.timeoutInterval = time;
    [session DELETE:url parameters:parameters
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
              
              NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              if(responseObject!=nil){
                  if(successBlock){
                      successBlock(dict);
                  }
              }
              
              
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              
              if(error!=nil){
                  if(failBlock){
                      failBlock(error);
                  }
              }
          }];
}




@end
