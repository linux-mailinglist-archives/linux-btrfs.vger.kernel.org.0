Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FEA5B2F5C
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 08:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiIIG5j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 02:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiIIG5f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 02:57:35 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00083.outbound.protection.outlook.com [40.107.0.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FC613B571
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 23:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGiuL6LrOxWKGo/YO9ZTqwIvimAVbmDVovDt1zlSYtcXFPHC6X4BDrgW2AZslclVUEJCpQrUmjz+uOI1oe3x4ZjXvev5Xsh4/ZQYvwt7cccTn0ymAij5PPM8aO9IFF2sBYilsNjXIpHqHsdkL1PwXsgOLRGZ9yuFGr5H7YVkxjhzImxvkKayx4JsteXsBj9ebj63EslmWZhD5VPWiF3kdhp3/bSJ6lb4QCoirwOOB7fsDYuUSo87YCCFnL085nUy3rbyXcvOY8alhL7mtwBi9AzLBL7qQxc45tFW51XuFPEWZ68dvyoe0prJgIaxUH9TRGAeZrJYztPeoINB6Xig8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7EuLVgPlLtnV+UDN1qNJ3nDoz35AXK/cr/PGbMSE+o=;
 b=LEuONaLyfP35t7ul5aLaTz4ecb97qrAAmMTEsWkRm/rYd0jcy3XHCNArsVouCKzPhXDAnKpqglpPz+9MF8juILP+M+e/gMF9O1PtYYiNULmLGsrVNPvnJ/7AnlTyaTNOxZSiJHxB4kYn4x+IWDNNGQjDCfg2OfU9FDr6+Wp4kvEujXhxFE6DG19B5wor4GP4WlqNfxXn/VQhE8RAYxudAV1d5ZhI6L2iApkGfr5RLr1GEjkDSQ6EYvepLPhEURpDleK/i5euE3Jn4MBxjL35ZDa+qNYx4JVPDr5+7poDIP5Vu+Ozuubw+Xq4O1M/YgO2ye/FJW7ohLo1N8NnyAbVJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7EuLVgPlLtnV+UDN1qNJ3nDoz35AXK/cr/PGbMSE+o=;
 b=UJV/734vIWZ1vELm3ij1iGDv2QOpzpHIeGXyDwjJ67bZVhhYnjZTvlz5gix82K36rWi5hRBGwup8ztD2lU/ilF4OtpMf1DsdSqFkl90GAcOTzPFJmQo+6zPO00B0JX5lEE6J6z2ZQH+x1/kL7ik+6UxNPOTqVFXwbbXJdHH41hdxzGHsp3gVWrjnX66gqh8gs1BsVjrapl8kcy2P3v7nwZBSPJUz6SHKx3GPPsShntdLIZUJ3GQNQdoair775BhYF9Uw7LemxpjR2ViprY2ytXhsPoorOnt6RGfS9C6RU6CahtaxuiKjLllWuDjmtxFqPndAbZ4smXyuRE+WY5iSbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB9PR04MB9580.eurprd04.prod.outlook.com (2603:10a6:10:307::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Fri, 9 Sep
 2022 06:57:30 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::f9af:f33a:99ad:e10a]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::f9af:f33a:99ad:e10a%4]) with mapi id 15.20.5612.019; Fri, 9 Sep 2022
 06:57:30 +0000
Message-ID: <43314bc4-a231-cb42-c4b4-e59682b55428@suse.com>
Date:   Fri, 9 Sep 2022 14:57:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH PoC 1/9] btrfs: introduce BTRFS_IOC_SCRUB_FS family of
 ioctls
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <cover.1662191784.git.wqu@suse.com>
 <e37ae2c85731ec307869e7c8f87c10d36d51846f.1662191784.git.wqu@suse.com>
 <20220909121701.B343.409509F4@e16-tech.com>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20220909121701.B343.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0071.namprd17.prod.outlook.com
 (2603:10b6:a03:167::48) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DB9PR04MB9580:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e57b82-60a9-40a1-87a7-08da92308fd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ed9QQpwpeOk/V0LOylSl3IO8nKAzOZRAwoz/vvmah0Wd54dxzyyCKjNi+qu8/cM8NZ2pjXkSD/DohF+lNRf6TUkGItnGvXoyFn23Kf9OJbZtQfmHZ+yr0qGpEqjWKolzzq1HNofjQ1gZGYBPTrGGJkBwuvcPRH0m6LEXXEDpwpW70QFVzKtIGwn06mu3QbiL7GR+nihhhnMTR+JNjW4oK8CamCGD+naeC/JJjHMh23UL3X5arSBRpa7tE9bwEiOb8Ig5gX/ON9YM638yOJ8/wEDkysUH2MaerMTxIYLI6pypAh8H8/hvexLcpzmQisvvGs8nVsFiXzCzLceQvnMFamTALTTvx2zPtppK6bmt+r+dogv5hkYloSoMx+4j2Sgoxw83/b42rrKYEGOWsZMLUlMNHHecmGBR+5QpAwNo4bVoHhu+1aQjarIDHYxcQ8fGmVeIBRg+k90md2SiZIh/Do/aVYBpfV5mlvoCUsO5tlLIxxZSKGa5imh85HJC7ZLEDC+ifvt5j2wUfdzSHYrpsBUGguHgJJeTa3dzguJ+Zt/O3vHw+XnY9KeYHmX2xQOHbieHINwLqeW9SsXW1WaM6Cr5Xh8SL5oqr0BhCh325cem7bHYiLwPGFvyKQF8tMq1MhnpW6lZdCN9/xXrW5Jrnsye2ArAyTzzJeqXbtFa2Gpw9AVs5BUAOifQityIE+vmlqCqO5gbyIwutMkzVj6DQu4L8mHnMB59m9joXxQJAUP1jSlycivasCEy3wAgriGEIVokvuP0B6RUNjp6KgTNPT9+RrrZf68Oh1K79wV/Pdk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(366004)(39860400002)(136003)(66946007)(2906002)(53546011)(6486002)(6666004)(41300700001)(6506007)(83380400001)(478600001)(6512007)(2616005)(186003)(8936002)(5660300002)(316002)(8676002)(66476007)(66556008)(36756003)(31696002)(86362001)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1FvWGFPaFFCdlFYNUJhdk1wUEd4RFJIaGRaRXBkTVQvRHo0Z0xpQUEyaHUx?=
 =?utf-8?B?NEJqMkl3WEhVbEtEd2RHclhlZjh6Ti95YkVPb2p4V1NMVUVqeitkbEN2cC9P?=
 =?utf-8?B?TzYvcDY4cVQrRVZpcG1KcFVSRVV1OE9QVDlxaWVHVWhDTFBGcFhGK2lXV2VL?=
 =?utf-8?B?SGlGMGNuSFk1K2VlTWZWUy9zU0pEdWRrUzVUdGxaQTVqQW9vY0s4NFJVWVRC?=
 =?utf-8?B?Y0hmUWszTXJlLzVtZCt6ellSVnJ0Vm9LOVRpNE1YOUpFUDBnb05QbmE3ckdG?=
 =?utf-8?B?ZllIV3BEVUNYVVpBbWhibVVTd3VUNHduck9idjQwZ1drMFMwKzJVTUQrSloy?=
 =?utf-8?B?VWY3eHlyRVJpM1hDb2pjdzZiV2VkSklVOW1sQVdqblU0MnJQSWhLVmdydVYz?=
 =?utf-8?B?MWU1d1hNZm9oOUtWWlJjWk11OFlhN1lWWEZBdkZxYTJZTlMzNm9JVzZ0cFlp?=
 =?utf-8?B?aGgrN1VmL3UvWDJlVXJkK2FkSVNtTEp3bGlwZXRleHRWWHUxTmhqZG1jeGQw?=
 =?utf-8?B?SmFncWVEcnhyMmIrTzNLTGJ4SUxYUldFaEx1TVdmNExUcFhoWXU1NnY0K1pC?=
 =?utf-8?B?OG9Hdlo3ZUIzNlZVRms5K0pRT2NkSlFQaXpaU0VxbmVBY1p4OElBZHVHSFdQ?=
 =?utf-8?B?YjViU0Q1VGltOXNwZm4vY3JUZk1jZHAySHVzVi9qTFVyU0VFU2V1VEZpaU90?=
 =?utf-8?B?a3lSOTU0aWpsQkx6MXVzT1B5em52S2VOYnM5ak54cXJqUmUwTStIYWl3dDcy?=
 =?utf-8?B?MWdYdkVPUyt6aW9kVVJiWUhOSjhFS21pSE5TeG5wa2Y2ZEJWbnFkVUpKWTFz?=
 =?utf-8?B?dXoyazROUGhLOGN4bzlPMjFaQlFZZ0dnODd2OVNHMTJpSDcvbFdzaUhld3JF?=
 =?utf-8?B?c3R2cDVFWFhyZzdsRlNJQWNKM0pMcVVETkYzOStXd2hxZXRvQnh0WnRTMThH?=
 =?utf-8?B?S2VZY05kYXViTFFDVHNxdG5YOC9oVVpTanNWZXBscC8zUVFvSEhSSmc4Rk8v?=
 =?utf-8?B?WHBwekxtbWVZVmxJZENhZ2xQM2NaNi9GdzBXZmdLeFMxUndRRFlRZWxMTzAy?=
 =?utf-8?B?YUd5NmZjVndkR0lzcEgwWXA5bUlvTGd4bzROdnZiaElNOUNGajAyK2J1d2pi?=
 =?utf-8?B?bmkwa1RpYTVnNDhjazZCaWg3Y1JWclZ5NkljSkZ3bDB5Q01WWVU5ZnFhSmgy?=
 =?utf-8?B?ZnpWQ3R4MnVNSXE0NEdIRmVuaXlpZVlSNDRqV1NFZHlRdnFOWWFqV2ZxOEc3?=
 =?utf-8?B?NHlUNnhwbk9WMnVEbmVERzJCSkVUZlpnM3UwekNRczkyeWk2OU5WZUgvRFll?=
 =?utf-8?B?cUM2S0FjRm5vWTh5bUtkQUNZcisyTFgreEhoRWtHbDZlMm5QS2t5SzhtdnFt?=
 =?utf-8?B?N2lWNytyTDUvN2JsNjRENGZWekNZRGliZGF4Y2ROV0JTOGh3WkhyWUhZS1Jr?=
 =?utf-8?B?Qk1CUSt5R3VWQ3UyVlU4dVFud1BJdDlqdkw1RVRSM2J5bXBRcEdMcHJEc0hT?=
 =?utf-8?B?SjNXYWdUYzFuTHZFdUZDbjlUN0wxSzBlWHVRUTBGMHEwa3BjdHRHZmhKWjI0?=
 =?utf-8?B?VEpub2gwdHpKSzNYbTZLKzZKUkpBRmtrV0ZYOWJ2MHVDc2RJNVVwYlpFdHZT?=
 =?utf-8?B?eUJld1hQQWZCTzRJalFwQ2doSmFoQm1sYnJMeTR1d3ljaVlRSnBPU2pEWlQ1?=
 =?utf-8?B?Lzg0STFUVCtjSDk3V1Yxc0xtbklQTlFwMjZUQUFLTlRsSWw3MTk0bzc0d2RN?=
 =?utf-8?B?cnJwdlpaN0xjWDM0dEI1ZkhUc3JBVWNCZ3B6VHhIbTllR3ZpdjhndkhQd3lr?=
 =?utf-8?B?SCtnNVRhT3RpeFhlUFN4RFNxcFFFaWx0T002cDU2eEFzR3ZncC85OUpaVS9a?=
 =?utf-8?B?ZEhOTm5iU3dZQ1liSDlFSTNXU0hWVGRNSnFBeUtFQStEejRMQTVDc1dJY0J5?=
 =?utf-8?B?ZlVHdHpaQTJ6WlBDYlRncFEvMFJsRUlwUkFoWm52bUQyam0xKzFmSmk0TG9n?=
 =?utf-8?B?NUpDVzRzQytzVFA4QWxFbSs5QWpDRGhmcUNZYkFmcDZpMzQvSEZHblZkTlFn?=
 =?utf-8?B?UlB5RjBoQmI5amoxbWVRZWl5aklMMEx5eW53Q2p2VG1uTVdRb1FZN3M0L1M5?=
 =?utf-8?B?MWZTY2xLY0tObUVyeDVQR2RZNHovKzVwbFIwWUZNNTBhOVhPdHR2cTJSTUY5?=
 =?utf-8?Q?DigCUDfcxyyUejB4bvH9Aiw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e57b82-60a9-40a1-87a7-08da92308fd1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 06:57:29.9848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQQBxd+l+qY/TfDxRDuULQfH2cuhLdRo50M2nLjCFJzzQC3geB5uIMk+4kXh47lI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9580
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/9 12:17, Wang Yugui wrote:
> Hi,
> 
>> The new ioctls are to address the disadvantages of the existing
>> btrfs_scrub_dev():
>>
>> a One thread per-device
>>    This can cause multiple block groups to be marked read-only for scrub,
>>    reducing available space temporarily.
>>
>>    This also causes higher CPU/IO usage.
>>    For scrub, we should use the minimal amount of CPU and cause less
>>    IO when possible.
>>
>> b Extra IO for RAID56
>>    For data stripes, we will cause at least 2x IO if we run "btrfs scrub
>>    start <mnt>".
>>    1x from scrubbing the device of data stripe.
>>    The other 1x from scrubbing the parity stripe.
>>
>>    This duplicated IO should definitely be avoided
>>
>> c Bad progress report for RAID56
>>    We can not report any repaired P/Q bytes at all.
>>
>> The a and b will be addressed by the new one thread per-fs
>> btrfs_scrub_fs ioctl.
>>
>> While c will be addressed by the new btrfs_scrub_fs_progress structure,
>> which has better comments and classification for all errors.
>>
>> This patch is only a skeleton for the new family of ioctls, will return
>> -EOPNOTSUPP for now.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/ioctl.c           |   6 ++
>>   include/uapi/linux/btrfs.h | 173 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 179 insertions(+)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index fe0cc816b4eb..3df3bcdf06eb 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -5508,6 +5508,12 @@ long btrfs_ioctl(struct file *file, unsigned int
>>   		return btrfs_ioctl_scrub_cancel(fs_info);
>>   	case BTRFS_IOC_SCRUB_PROGRESS:
>>   		return btrfs_ioctl_scrub_progress(fs_info, argp);
>> +	case BTRFS_IOC_SCRUB_FS:
>> +		return -EOPNOTSUPP;
>> +	case BTRFS_IOC_SCRUB_FS_CANCEL:
>> +		return -EOPNOTSUPP;
>> +	case BTRFS_IOC_SCRUB_FS_PROGRESS:
>> +		return -EOPNOTSUPP;
> 
> Could we add suspend/resume for scrub when huge filesysem?

It's POC, don't expect those.

It's to prove the idea works, and for discussion around how to improve 
the RAID56 scrub situation.

It's not determined to go this path, we may add extra flags without 
introducing a full ioctl number.

> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/09/09
> 
> 
