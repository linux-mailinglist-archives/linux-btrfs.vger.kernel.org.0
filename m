Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6617D4DACBB
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 09:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344038AbiCPIpj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 04:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237580AbiCPIpi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 04:45:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04952344D4
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 01:44:24 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22G891Ca017375;
        Wed, 16 Mar 2022 08:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Hgl14TS75pMouF4L87CiZL8zwQdtWJOyu1RBj9Zp5Vs=;
 b=hMxRLD7pBq7d1N+Je3JANo5mRc6euhCx3yUWr+QEf89wus0ul/W60ORAvrJSoTS2mfx/
 UO0JcaObDyxeb5iJVma5wsHRuPTtQbS89nOU2NrdVFwFUDl9/7NKVPzLAwc+NBKnkcjZ
 0ySzhLpwLaIdQBWNHgjL8+7ssM5+64CjL1+I76YQ5kOeOX7DlujIwp3Zve2/uYOKMTN+
 VbHwKdHTmOSvWY/CjXyuYxlrcKC2Wwjv4wpl8rj7qMx4kh5+RSwpvK1rJo1Q+X556sch
 GygLtKu8kZwzQv6ALSu62SVmX1wq1LVoLffwQGfHmu6OHyEMfC6HTNmHYaknCOvhLtNj ZQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rdaqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 08:44:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22G8g31A149116;
        Wed, 16 Mar 2022 08:44:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by aserp3020.oracle.com with ESMTP id 3et64khjwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 08:44:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nanWDdu410m+FCYWdUb4ucAuCxDXFIeLJfRnItk0PKnaWS3AEJzATOnrKU2jBzfev9Ind+fLDl4uXDa34yHmltFHRfoVua4S59nygQSuj2oeKtsqUymE/QmUsuc2xUMK6tzigu/Phoo/4xWyeat2lwF+bax8eFnVrCnRz7jDUvHHxcIWAhBnEdECK8fIWdyJLhgnxEDZkd1mnOpiH+N9c1Hl2L4lBiFWguaj2vi514G8rybXxjw45jV9sVMk/FYRbBT2/j4tW2KnAS/Tm3yQyfid1lfLOY4qXVehR9JM2zFlv/NfggABa2oggUhE2dDWj6h3xjgNYfd3oxatHtI9wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hgl14TS75pMouF4L87CiZL8zwQdtWJOyu1RBj9Zp5Vs=;
 b=OcM6h55+7nS+tmmcXKQHIgXcshc8WV6rsOxuBljiwrqq+CgWOubp01v+PJoxDxQgGloDuPunoe77Lz7hh7RnmOhxw5wiw14kRwyVfri5JIqMxba86ZsND50GealLzoBr1AS5NcJ2a7DzWu/5tLOuRrNoqJpfDzuIwAc+SORUkgTsygNmyDSwxPSyRg/+q1SIFuDzbjoQITTRs2jwikwBitLRdZNhPW2i9bNt+NBsmkMestPDxXjcoj+VIETRE3uIRUfqDa36rbVmFlz04T5z/MSQnnqlkcYHv2n59zaC9vh7Inpwt0gel/PmBdBDlseMDblPymglI4g0bczB9WO89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hgl14TS75pMouF4L87CiZL8zwQdtWJOyu1RBj9Zp5Vs=;
 b=lB945qtGtEiNr0YoLVxVvFYxqlJ9Yy8wwxPmv3Jdreoyk5y0K9dTKYkGbFXozc2XxEhbWa/AACF202Og2NkdW1qc5oS6Kke6cNsbF/wKD6G43ut3umyl98ztO/dtSGfb+xVqs23GH50RhEDWZL/ipnR3hPCX7s2Fur+ITK/jfGw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN8PR10MB3683.namprd10.prod.outlook.com (2603:10b6:408:b8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Wed, 16 Mar
 2022 08:44:16 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 08:44:16 +0000
Message-ID: <38df9c37-ce1f-f7b9-f9d9-93128ecab500@oracle.com>
Date:   Wed, 16 Mar 2022 16:44:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: zoned: use alloc_list instead of rcu locked
 device_list
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <f7108349f3a7d690166c88691c5dc1932cab3610.1647267391.git.johannes.thumshirn@wdc.com>
 <20220315200330.GW12643@twin.jikos.cz>
 <4af521e5-82e3-f21d-ede2-9da3fd990fe9@oracle.com>
 <PH0PR04MB741638373ACE0D828C9A59529B119@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <PH0PR04MB741638373ACE0D828C9A59529B119@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:3:18::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a91b830-2694-4c8b-0688-08da0729275a
X-MS-TrafficTypeDiagnostic: BN8PR10MB3683:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3683AFEDF6542290CB491AA8E5119@BN8PR10MB3683.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZYTg58cGa6VaXzJNqOPUdya2f51UnAsGbot3UNdzP4+1MMyZayv7zpxmSeZ0V2O2LD4gar07x6fbKctvUzrvtDN9vPzndnNqHNmOEXBSQPpU9AJnxfJKqUk2g0V2kSms+m/CnYmAaTxJbzKwT7vPA+YpOA9smE6ehgopUUzmKFn0tqTUWJ6W+Cb1GSmZ56JbICuJpSgNX4C9L379/KCZt17SyfcnN1QC+d/YEGJSMj85KCsQysjGfUbYkhd/S5fDct2SPa/cj4fAWysUBM62kSspsVlP5Bitje+euQTG+GeqaHeR+n7e8LlFOXQ4pVGe+luLWws2MloF6KOLzV2oatFaltdkuhY5rz/5Dj6ADPPFJNzzrPOYQfATRmKdcdtEJvAWAmnmb5ZMFM/iAyHwUoTV8fQFLEBoYb1mEtG5iZNRH9ho4is4vRmb7+dz7M47jYXTrnvb7i2tZ5673oHp3xGUMekYwLhyOAwSU0wOL2z32TZ+5Hrr0qfgZd4RCnXGzBcS7KRzUxVya9A1V1mLCQkRzpFQL0LwG6MwBVlCA9SbQyqcr9dUWhoxXktMjMPexTEvBLS7ANgc/ymuACzbzGkqQgw5qP5uoL51fHBLP0lSvnYGA8fDHvNlal+gKc/LrZ50izYmDP7kyCA4OhjaPY0DHN2aCBClzMbPAjgdeOxhsuwSpUd0OtHmK+/GeWWMaZEpn4FOrISBcJrc2Z9CNRyK+G28btmRyMnhThy2rtI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(316002)(6512007)(44832011)(110136005)(2616005)(31696002)(83380400001)(26005)(186003)(38100700002)(86362001)(5660300002)(6666004)(508600001)(66476007)(66946007)(4326008)(8676002)(66556008)(8936002)(36756003)(53546011)(31686004)(6506007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUF6YkpEaEpMNmtaZldSd2tpeERwUXFBRDNsbU5lWVg4b3NpREdmdkk1RndM?=
 =?utf-8?B?bzJrVlA2d0JJM3AxUU10WVBRRjFHNmR6M3NsczNSWUc3Qkw5S3JjbWJYTHpF?=
 =?utf-8?B?QkFUcTlZdzdlYkovUm1CMEZheVRiWTZEaGh4YmE4cGtYUGpJVk5LenhVNW9M?=
 =?utf-8?B?MUhmK0JhWVMwLzc0d1NzSGdBeklGOVZ3b0N5MUNWTERsd1lMMWpLK1JNTkRs?=
 =?utf-8?B?d3h4dG43N1VkRC9NSjdCMmFtT1hnQUJmQmNrdlJxWjZzM0NUWGZkbzR0UUpk?=
 =?utf-8?B?STVnUGMwMnJ5clU1YXE2T3o4K2g2aDkwYW5kZ1dDK3d0YkI5RXZUSW1iM2ZZ?=
 =?utf-8?B?K0wyaEJsYzlhdUg3a1duL25EM3JmUGRFQytlbUpjditCTWlhc1FYSm9KRldT?=
 =?utf-8?B?OGpHb2hmWGtnazJNMk9ha0pHT1M5RGxiU1JyRzlTb1VncExoRGR1ZkEyQkhw?=
 =?utf-8?B?ZzZnb1pLd1BwenM5cVdMMGhEemRJNXVaMDVITUVVMHJOTGdMdTNwWldDSys3?=
 =?utf-8?B?UlpHNEN0ZkVmUkhqSjBsalN4YWJSQmFsaUFiQjJiSlRQamxwR0lYd0VlMGxY?=
 =?utf-8?B?K0toaVZBVXFuYWxiRW9XdnB2K0tPMFd0V0FTemFXcXd2Sm1EaGRiQ1YyeGxn?=
 =?utf-8?B?MldqTDVoTzJ5TnVpSGo1RGxMaHAyalZPYkR3cG83TCtlZ20zWnZ5VjdxbTRI?=
 =?utf-8?B?THFhZEVQakdpbFhEa2d0SjlJTnl5UnE1bFFvSXBoRUxPakZuRklFRWtQNGhl?=
 =?utf-8?B?R1pBY0xNZWY4NTJRSm0zREJTUHlzT2pZZ2NnZzB5NytOZFFSSVZiSmpITjhk?=
 =?utf-8?B?K1J4RUdQWVpUZVZtTTlYTEFzZlM0TWpCT21SWFVlSkFpOFBPb3ZUYzVMa1Bz?=
 =?utf-8?B?eW5yZFhnZ3NlWkxuVVVuenJnN1F4cDBaaUhPSUx4T1lqQlV2cDgrcUZrenVF?=
 =?utf-8?B?VWtYVmZvbzFBNEZrc1E1Zm5XOGZuMWNyKytyWW50elNGcG9yZDhvc0J6TTdJ?=
 =?utf-8?B?aVFNeHYrUGpZbTF1U1RHdEYrbGw4N3NLeW1rZmVtR0djZE14aGVBTGU0bTNB?=
 =?utf-8?B?bGFMcjU4K2NqSTg0VUNuK3ZUdzd2dW82dURRZ2VOcGRhK2lsRVUrUWF1SE9v?=
 =?utf-8?B?SkhxZW9DY1RDdHc3VXE1UzU1SlUxTWF6V0lPT053Q3J2aDEwNVhtSTVidS9W?=
 =?utf-8?B?dE1VMzV5Zm54VVk4aCsvaEZzdVIvZFJBb1hRQUFrL2lIYXN5MXJrQjgxUVBm?=
 =?utf-8?B?d2t2YXRPSy84eDJza3RvQUc2dkpVTTlVb0tNZzlWQ3dBY1NMdnlJSmdnMHpq?=
 =?utf-8?B?M2RhNkVOaEpwNkcrcFNtVmhPRnVLV3ZOS1Z1TWdhTWlHU1M1YTh5bDZjaWhw?=
 =?utf-8?B?SkpzRGRURkFuYjJ5UWlFT3NUN3M2RitnRjVTc29JVDQ3dDFuZUt3ekQ1UW5X?=
 =?utf-8?B?ZCtWR0VGTU1aRmxKWEZzbDl0WEQvSE5lUHVyckNpT3VicDkrdGJJbU5NdDRV?=
 =?utf-8?B?ZlBsb3lZRmpRd3pHQTBWYlpqR1dUdi9DZHF0SG82bVVuSzZPcVNqYzl5M1U4?=
 =?utf-8?B?QTBqS0pCQVhPUkVhbzdTYm9GQ3YycDcycVdqMlNKVDZtVTlVV2FuU3hhVkFm?=
 =?utf-8?B?ODAwRGZPeWxqV0VaMW1ISVN0Q2FsYzVkMVptbndJTUYraGpIOU5FeE1ZSmQ0?=
 =?utf-8?B?alRSSE5KOWtad1FUUGY1a2JBSXNxZTB6UFJ0c1UxUytnR05qSko4YkxHUExW?=
 =?utf-8?B?OHJsMUpYMzY5WVNnSHgvM0lOZ1RlS2xmRGdoS3A0MU1EVFNvRzdrU3Z6SnV2?=
 =?utf-8?B?YTYyVHFWWDRBTVg3RWtvS0dBdkFBem9vbGZhZW16QnBVbjdKcXRPTTJjeUpi?=
 =?utf-8?B?cFk3bnR2eTJhMWtUb2tndlY1MTZyejZ4cUI1TXltU25XK1VINUV2WnFueGpv?=
 =?utf-8?Q?CU0o9LVPTojjF+P6MhoNbp01ZdfGHXAm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a91b830-2694-4c8b-0688-08da0729275a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 08:44:16.4422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tizY3/Kqby47vopqE0+7p40P8BNLCdZlVTgWwI22fmD23cGNKeQxzVKZhD8XEo22F5mYk/rsWA9R2OXudLm0xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3683
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160053
X-Proofpoint-GUID: crZNY0LlPtRp9sHjlXirgoDBdinmTwsZ
X-Proofpoint-ORIG-GUID: crZNY0LlPtRp9sHjlXirgoDBdinmTwsZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16/03/2022 16:39, Johannes Thumshirn wrote:
> On 16/03/2022 09:37, Anand Jain wrote:
>> On 16/03/2022 04:03, David Sterba wrote:
>>> On Mon, Mar 14, 2022 at 07:16:47AM -0700, Johannes Thumshirn wrote:
>>>> Anand pointed out, that instead of using the rcu locked version of
>>>> fs_devices->device_list we cab use fs_devices->alloc_list, prrotected by
>>>> the chunk_mutex to traverse the list of active deviices in
>>>> btrfs_can_activate_zone().
>>>>
>>>> Suggested-by: Anand Jain <anand.jain@oracle.com>
>>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>
>>> With updated changelog added to misc-next, thanks.
>>
>>
>> Misc-next hit an NPD for new chunk alloc.
> 
> 
> Thanks for the change, but how did you trigger it? A.k.a why didn't it
> trigger for me?
> 

Well, not much. Write enough so to new chunks.

-------
nullb 4096 64 4 8
Created /dev/nullb0
mkfs.btrfs -f -q -dsingle -msingle /dev/nullb0
mount /dev/nullb0 /btrfs
dd if=/dev/zero of=/btrfs/tf1
dd: writing to '/btrfs/tf1': No space left on device
-------

Thanks, Anand

> [...]
> 
>> We should use fs_devices->alloc_list with dev_alloc_list as below.
>> Also, missing devices aren't part of dev_alloc_list, so we don't have
>> to check for if (!device->bdev).
>>
>> --------------
>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>> index 7da630ff5708..c29e67c621be 100644
>> --- a/fs/btrfs/zoned.c
>> +++ b/fs/btrfs/zoned.c
>> @@ -1984,12 +1984,9 @@ bool btrfs_can_activate_zone(struct
>> btrfs_fs_devices *fs_devices, u64 flags)
>>
>>           /* Check if there is a device with active zones left */
>>           mutex_lock(&fs_info->chunk_mutex);
>> -       list_for_each_entry(device, &fs_devices->alloc_list, dev_list) {
>> +       list_for_each_entry(device, &fs_devices->alloc_list,
>> dev_alloc_list) {
>>                   struct btrfs_zoned_device_info *zinfo = device->zone_info;
>>
>> -               if (!device->bdev)
>> -                       continue;
>> -
>>                   if (!zinfo->max_active_zones ||
>>                       atomic_read(&zinfo->active_zones_left)) {
>>                           ret = true;
>> -------------
>>
>> With this fixed you may add
>>
>> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> Thanks I'll update the patch
