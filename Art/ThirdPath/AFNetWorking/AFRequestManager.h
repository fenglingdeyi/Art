//
//  AFRequestManager.h
//  AFNetWorking
//
//  Created by dkq on 16/4/15.
//  Copyright © 2016年 kaiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^RequestSuccess) (NSDictionary * result);
typedef void(^RequestFailed) (NSError *error);

@interface AFRequestManager : NSObject

+(AFRequestManager *)sharedAFRequestManager;



/**
 *  get 请求
 *
 *  @param url          接口名
 *  @param dic          参数
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */

- (void) requestByGet:(NSString *) url andParam:(NSDictionary *) parameters successBlock:(RequestSuccess) successBlock failedBlock:(RequestFailed) failBlock andTime:(NSInteger)time;


/**
 *  post 请求
 *
 *  @param url         接口名
 *  @param parameters
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */
- (void)requestByPost:(NSString *) url andParam:(NSDictionary *) parameters successBlock:(RequestSuccess) successBlock fialedBlock:(RequestFailed) failBlock andTime:(NSInteger)time;

/**
 *  put 请求
 *
 *  @param url          接口名
 *  @param dic          参数
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */


-(void) requestByPut:(NSString *)url andParam:(NSDictionary *)parameters successBlock:(RequestSuccess)successBlock fialedBlock:(RequestFailed)failBlock andTime:(NSInteger)time;


/**
 *  Delete 请求
 *
 *  @param url          接口名
 *  @param dic          参数
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */

-(void) requestByDelete:(NSString *)url andParam:(NSDictionary *)parameters successBlock:(RequestSuccess)successBlock fialedBlock:(RequestFailed)failBlock andTime:(NSInteger)time;



@end
