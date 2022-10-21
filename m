Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D607606DD0
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 04:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJUCe3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 22:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJUCe1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 22:34:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21C4115B
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 19:34:22 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L0F8P2006607;
        Fri, 21 Oct 2022 02:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Dri++owzfYmt+pi1AYzb3TOys66/kmT+DRr8Ri+AwIE=;
 b=PFRJ47dhtR5abXQzXN2zdy9ZZdxLxzbBBhSZobh3SQ524StP2k1W4SeAeIKPIjlewg9a
 AhVqTyeMuO2DJ+cfIUqGX/9G+yDhid/q/BlJCfj6V8QGxH8NHCo2hSj1vo9CJuKhVg/H
 9jDCkDF7KKTzWlywnCsg+EfU3kJRhC3IbKx+81npNJ78LkHdWe2LIasIuGHU2ZuRnt+R
 uHmTLAZwTk1O3hXG93pP/F0osN0JhOGT0cJRNmGjM9McRSRJGDcZUgD2VXXcV8WVDxeq
 ao+LCBx9HGP29S5HDFpMBRDgqwdsltZmrfQstm4M60m65dfI6BWF+/RH4hC8T9E4T1w2 lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99ntk7p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 02:34:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29L1BgVw007211;
        Fri, 21 Oct 2022 02:34:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hrddd51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 02:34:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qvh6nm0rhuNo/KegGOfdl86v6W4wMDtkmbDxJNhHMDKhHXJuN67DRwTr+sJmWwkZHu5eJDJGFBMcteBYHKxQZOP4So9RlFcjpfmZU1xjT85sZ9ZZdKpHd4etld7RYAd1PHWNHCTBVceIyv6VnfUzX2rxDq6siTe+fQXL00+hKcP77h218wmlE9c6BZN4OAJ9TBMuqX/u6ua+2O6fS05xrVhN5r+kgRcdAE2b9MAu4va5Abwn9XccOSVsZKkf0nZcbQPQm9cQP9z3WTla3aa9wRyfq26saoE1xabzXG9Gbf20eUPbqChKsQLcoQbV39oTnZvH1hNGbgVRr52+YxLs5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dri++owzfYmt+pi1AYzb3TOys66/kmT+DRr8Ri+AwIE=;
 b=NnEfIzVy0ATGkAzXfGqAqaC+uowiFOAeT1ZoZOhaADZteHe22S4OK2LUBaVf4lKpXiArUirNnIfRz3a4dWTGRWlMwI6GImXFE8b8wHZ0aIYIYwYiEKvThJ3FqoHvdaZXKYMlV0KIar88bHgxxP66pTC6MHTdofgnO1FkTUhdl5JV1f4sVbaGm5ohvjiO6nFW3xZIntgifeSTR+1J8xI9csO3k4f0OWZdEfg8pDm97DoUX3X5w+X+ukuddmszkVT51O3p45ah0Gk3V07gE6+233fMH6aeTEo8RGlSdPfZkVqpFJE22rwDpLOsGSb6yQpsQ2GfbPmW0YJJ+gsJ3yI3NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dri++owzfYmt+pi1AYzb3TOys66/kmT+DRr8Ri+AwIE=;
 b=L5Af0XUCI+cYJXlAXSPrQE/vNTAv/mnrtQx9DgxeAeMvnaQePgp9/6jLCvDjKd154TPvZIDC4S538bTRp2xq5xeHYNPvn5CxVpG04c84jAUF0xC5s40W6G7TT/HsXPXzpN5tHGVm3VIxiaxdEziH4i0IpZO9/PMAtGeHLpqb+V4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6644.namprd10.prod.outlook.com (2603:10b6:806:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 02:34:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a%6]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 02:34:13 +0000
Message-ID: <ccd4f8c7-8897-838c-1bb3-9837567d2d57@oracle.com>
Date:   Fri, 21 Oct 2022 10:34:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 3/4] btrfs: switch GFP_NOFS to GFP_KERNEL in
 scrub_setup_recheck_block
To:     dsterba@suse.cz
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1666103172.git.dsterba@suse.com>
 <aed6063361919c409c72b208d361be0a5d094b3a.1666103172.git.dsterba@suse.com>
 <d21439a6-1adf-50ff-c409-b87ef87f54c8@oracle.com>
 <20221020163511.GM13389@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20221020163511.GM13389@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: fd7bc128-138f-4baf-8d12-08dab30cbdca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8EJK6Vr8NFvRfa1nOOLocrcl9rkAs0R3+6xtovyu93Hh53fu/d36FvA53p3OHM/ZAIHd3OaAe0svhWf7vRfGWQTaTOKEA8yqHLZdiwbzEz/LoVooLZAasTPqJGiXZkIp16s6k0rA6zhvSsOsJOzTt68EJ4P4tYoPbxQkBtfTSiiMPWYhL1ehXKDHJlOz9BZDIKKsiDedLbmwyb5PCnJOrO7TI/+A1wulayUhnKwRgXAjjADf4rZvQJlglwGhsF9zAccZNajw4JeT54GR6kE8Btb0ONAKbm5d2vzYf21gBCga0zrQ9oBkoY8jE+sne73ncoUhkYeg+PsTIfmAK6ghFX2f/x+Pe1ortc+BCdJ2hMrN3d54i3vuOAnYVOyhowKyCbamLiZMisxqdyo7w5EXSUdD75tw7s4Aaj3zJtNH23ocPgIq1xnqh2E8uujQSVvbSRs0LhsMhXU99rvcr+QGy2vbpLwEHyq2bvjyOhYMts0p2dcCjxKeH/VRd3/BKG2RhlQ09S/i1qMJ1onMyx1j7ag12ZE/7BCTfWiKvYwPcHU+N+b7+W+cBczYNhtYWB4pbuG1NSByqep/VaUQKFa/LM5mGHFgfqgwGKTY+irjreqn7gXRVUV80dAmElW18fIIHqV39UjCpEGL2YyaFuhuuc1m4HeBJ6B6cCTfmlOhfUVggP58s6X3bTAO3V9HLzIBo8gyAzM8bLjG9tZQLFzUaMuYBXWlkt9NhJIgyfiUxkgJqkrjE65/I7faypfBIFL4p1gWAyGMaILuRK58P9uRHGL4xrAmYFR+8st2wjxoFF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199015)(38100700002)(36756003)(86362001)(6666004)(2906002)(31696002)(44832011)(66476007)(478600001)(8936002)(41300700001)(316002)(66556008)(66946007)(4326008)(8676002)(6916009)(5660300002)(83380400001)(6512007)(6486002)(26005)(6506007)(53546011)(2616005)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnRhMlF5SGtnUlE5QjB6b0ZZb1d4NnI4bHdiMDJJU09maE5ycWZGVUNQUG1q?=
 =?utf-8?B?M1YrM1o5YWpQdUtpZFVxc0ViQlo4Rk54UDBRZlJqSjE5ZmI5UXBXdlNrbDJ6?=
 =?utf-8?B?dFZ3L2JXL3F0ZTZBTXIxR2VpN0svNGNWczVSalNpZHdna0hJUU1YY2FuZXZ3?=
 =?utf-8?B?d3NHNnB3V3B5QTh3bXhlSkRGdFM1YlJpK0NFTHBBYXUrLzFRcVBaQTMrRnlL?=
 =?utf-8?B?QnYxdDNSTG5mU2h6dTZNekVMaHJXTGlNelRSWWcvUmpvSzFNUnAzUmxhejRW?=
 =?utf-8?B?ZlhFQ1pBSGZ1UUxxSkpCNzNJVmQxdkw5dWtmSml2WmIzcnJoVGFET0g0RDRZ?=
 =?utf-8?B?THlpTDJxUSs1WkF1VG5WdlRTWHhPdjRtMjdiOWFQc2hhTFFDRUFKa3FDM085?=
 =?utf-8?B?RVdhS2JYY01NbXhRZFRVcmVZaDEyY0pldEoyUnAwRmZ3bStCdlR0UG9pSXpH?=
 =?utf-8?B?eGJkbm9IN2Zhd0hSWldud3lSaHlFM05YazBIandReXNrcy9VVHVjSU9ZRXBY?=
 =?utf-8?B?cjNCZzI5alpmbFJjd2pOc1BzZVFQQmhWYjVlVHBIcCtmdmd1QUxVSk0wV0g4?=
 =?utf-8?B?SWk0bXRieSs5VlFQNDd4UUZmeHlZVUxCNXBUNkhDWmgrYk9XYmFwTjh4WFAx?=
 =?utf-8?B?ZjBFZW9Ud0xMWmQxb3ViSlFkMWRpNHdML1lHWnNtSnJlcVEzQmp1RzN2QWdG?=
 =?utf-8?B?dytHb1Rqbng2b1AwZFFHcjVUKy9FdzhBTWFoZk4reFZObDF3OUd4akxpdjNU?=
 =?utf-8?B?WVRON3NqVFFTMWlPY1hTYlRnOVRjdjY1aHgyRWUrREdka2Jkdm1yd25jNFJk?=
 =?utf-8?B?R1loeFFrMUhSd1VCYWlJNldpTWNCM3RBTkN5K2ZVYzJhd2ZadjdOZXhPS3J3?=
 =?utf-8?B?NmtMMkNhUDhTcHdFWXFEZE4vZXRGbkdZRGxqcjJOS2FibVB5eStqNWJaRm81?=
 =?utf-8?B?Sk11YTJ5OFo2RHdPaTJKeHdHdFZ0OVpJS0VRWjFWcWttVVA3VmpzODlYZklI?=
 =?utf-8?B?WktXakpwYmVlUWx2d2pneHg0MGF1RE9sejNOaFBlcjZmMzNCRDFKS0k0VkdM?=
 =?utf-8?B?MHVVY2ZzN00yVW9qYW1TUUdvNW5uTGcxeGpiRnpUci91R296aVdJdS8vSXV6?=
 =?utf-8?B?SUxuNWEvVExUQzZZTTRqd2ZVK2xNMnBpRTZFUnlGaUFzSnVKemt5aXJsV0pH?=
 =?utf-8?B?bStkRDJocm52RktSTzdabXNCZDFBOFZBcEVURFJ2SmVlU3d1WXZ1bC9WWk43?=
 =?utf-8?B?clRRbmZ4MU1neHFNLzYxdEFuRmtwN0xPcUZiQWs3UWgrU3FCMWlxWVFjOUpx?=
 =?utf-8?B?eDN3WHN4dnVlN0UySVF6ZVlQOEtJSWRMZTl3WnBvR25sdVZxOTlkLzdLRG5x?=
 =?utf-8?B?KzB0RjZibUcyL1A0Yzd4K09QOGdhNldyZTErMnpneTkxOTFwR1VEYkxqcVRk?=
 =?utf-8?B?cVBYYzVZV0xha1lrZkxjbStQUFkrRkYwWWdrZFpTNDFZSlNhZnlMUmtCbkxF?=
 =?utf-8?B?RGNxNUJ6WnRCUlNheDhlN1dpMGt5akptYVE5K3RtK01SMXBMZG9mNzFubm4z?=
 =?utf-8?B?eGQ5UHYrVGxMbEhxWnAxdExYVExmMXN4UDE5SDV1bFVhTVlmREZ2U3IrcTJp?=
 =?utf-8?B?UlRXWEpRL0NtbGdQSnA1azJpQVJzUnpEaGthUkdkQzRpYlVKVVd1VHFFdUhs?=
 =?utf-8?B?N2JrUHRWbDRZUEJKWHlZNkJSR3p4S1duemlJc3lpVW5RNHl1TFVKT1JoaTli?=
 =?utf-8?B?S3BhQXVTa2tMMWFaazZPVUVHQmFxb2NDdytVQUlTTFF0d01qWmNMSkMxUlYy?=
 =?utf-8?B?RGU1S2g4QVJld29zRFFYSWlsVCszRDZSd1FtQUxqdGxnZWoyem5mVnhnL2JD?=
 =?utf-8?B?ZTlzRFJtTWF4RDZSSTRzbVg0YnhsS1hnYkJSbHo5OWNyczhSb2Fpd0VNTDJQ?=
 =?utf-8?B?WkZVaHhuOE5keWwyOXdkQzRRNGJXS2lJSnlCUDMyNkJHa1JqTHFEMlM4MmF4?=
 =?utf-8?B?WkxUWkZnSG5raExOL3dWYTFPREcvYkRRKzNMMUNqa2V5SEs2VmZLKytLOUJr?=
 =?utf-8?B?aUVRemlaZ2FkdjRPM1pzcjRyNWpHOVRucGp5U2VoYWVmZUJtbTh0WkJpZVdO?=
 =?utf-8?Q?122hcV0OqYOXXkDpbNZb9A8oP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7bc128-138f-4baf-8d12-08dab30cbdca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 02:34:13.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCq2v0YYMoKU1167RNnPKpbyR4Zf2RLGiMhuYNf3f+8n2VnaKw5/KajYHoOnJMk7PxQWLd1XMv2WfgOqusvveg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_13,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=883
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210012
X-Proofpoint-ORIG-GUID: 84Aju7sAFKaO4l1fAM0Aj8iV8da4jJqH
X-Proofpoint-GUID: 84Aju7sAFKaO4l1fAM0Aj8iV8da4jJqH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21/10/2022 00:35, David Sterba wrote:
> On Thu, Oct 20, 2022 at 03:27:31PM +0800, Anand Jain wrote:
>> On 18/10/2022 22:27, David Sterba wrote:
>>> There's only one caller that calls scrub_setup_recheck_block in the
>>> memalloc_nofs_save/_restore protection so it's effectively already
>>> GFP_NOFS and it's safe to use GFP_KERNEL.
>>>
>>> Signed-off-by: David Sterba <dsterba@suse.com>
>>> ---
>>>    fs/btrfs/scrub.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>>> index 9e3b2e60e571..2fc70a2cc7fe 100644
>>> --- a/fs/btrfs/scrub.c
>>> +++ b/fs/btrfs/scrub.c
>>> @@ -1491,7 +1491,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
>>>    			return -EIO;
>>>    		}
>>>    
>>> -		recover = kzalloc(sizeof(struct scrub_recover), GFP_NOFS);
>>> +		recover = kzalloc(sizeof(struct scrub_recover), GFP_KERNEL);
>>
>>
>> I didn't get why GFP_KERNEL is better here, or would it make any
>> difference, given that we are already (and rightly) in the
>> memalloc_nofs_save() scope.
> 
> You said what's the reason, so I can only repeat the patterns:
> 
> 1) plain GFP_NOFS, with notice that it does not work with kvalloc
> 2) memalloc_nofs_save/k.alloc(GFP_KERNEL)/memalloc_nofs_restore
> 
> I.e. GFP_NOFS in the memalloc_nofs_ protection is redundant because we
> get th NOFS protection and can safely use GFP_KERNEL. 



> Because we want to
> minimize use of GFP_NOFS or completely switch to scoped nofs, but this
> requires other changes and we do that incrementally.

  Ok. Got it.
