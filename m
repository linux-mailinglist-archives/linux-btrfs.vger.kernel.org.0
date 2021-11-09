Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DE144A258
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 02:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbhKIBRl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 20:17:41 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37022 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241952AbhKIBL6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Nov 2021 20:11:58 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A8In2Yc020247;
        Mon, 8 Nov 2021 17:09:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ziXbtBudFrHwWK7TJZuIqrMfcLAUcrAqdffCXmcE5Jg=;
 b=Al7eqrREQ+Ir85H0RtREYubRf3j4esvyOo0oQDKQ3xR6R1hEv5Me/YG76SOjsxDqP4P5
 iJ262BZaJ/rmUzrdiJZYuQ8KDuoK7zu+AyaN9dIABmTMx5SleV4DfSfRjYtTF0xe0Abk
 +tOK+BX2vEvvl/KixSW7GRq5+XaiiaZqe+8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3c71bfevtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 08 Nov 2021 17:09:10 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 8 Nov 2021 17:09:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVFtQCMOBsZ2BQjtB1T6na8RT7IOFWIK790K3J7tTHmP86xf2WK58bqIDwwaB+MzmjI8u2cwC0jJPxOkqUYFCUqOViEErnSPJPX6jILvLEBWjO7mbpfJknbVWa5pxFuUrajRMZq4MKtLtMLQp9ydu39EFRyHsgXAWQfPVNehVsr98RQq+pATgLSWRvZtgrLcqd822Dv5B5PA5BhweUj8H9MefKM/EXLAgjsp87hIW7ElVXXEpsPvj30RHBgICc7gYnVc7MDV++/WAKGpRqLCvBXSWWBro1m1pmAaU+44YRQv83Dr4QaUcEudOfXOt/A4BKMg4piqChMe3EhR/S21KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziXbtBudFrHwWK7TJZuIqrMfcLAUcrAqdffCXmcE5Jg=;
 b=SM0WOCTxgEB308twyRL2l6AoKgJfteht+bbBgVBHt9aRDKDNqW4Yo9asTq53Opdh/kXBzo1RzPsWEt156qk6LF1CuYOtrkV3LoZpzd7atCWA76IzBjNDVU/x/IsuHyqj1ka3UHTi2jw6tquZuvh9PAHcPOoAiuX04Xm3W3XzXgyfNIJJ3S4G2NBJrQmY9mi9Q/CziXR5AjXXjSXr5oPyoHZ3sa9FYu+HSrM3nGu6y4T2ZQOjb+GKEu9HfoVF/aQq/Kk4bAfCoUaplHNjo3h0+TQLPMb/mtizo2VlUfrL68rpSrCOVdFwBUwucveEEZBIsZSTMft9hN+26qjEM+HYYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
Received: from MW4PR15MB4410.namprd15.prod.outlook.com (2603:10b6:303:bf::10)
 by CO1PR15MB4874.namprd15.prod.outlook.com (2603:10b6:303:e1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Tue, 9 Nov
 2021 01:09:08 +0000
Received: from MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::6d16:2cb6:9c06:c719]) by MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::6d16:2cb6:9c06:c719%3]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 01:09:08 +0000
Message-ID: <e7e91cd0-cb37-3aed-9134-0c82d3521ef1@fb.com>
Date:   Mon, 8 Nov 2021 17:09:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v4 3/4] btrfs: add force_chunk_alloc sysfs entry to force
 allocation
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, <linux-btrfs@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20211029183950.3613491-1-shr@fb.com>
 <20211029183950.3613491-4-shr@fb.com>
 <3b746e80-9799-3631-96d3-b95081d68fc3@suse.com>
From:   Stefan Roesch <shr@fb.com>
In-Reply-To: <3b746e80-9799-3631-96d3-b95081d68fc3@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR19CA0026.namprd19.prod.outlook.com
 (2603:10b6:208:178::39) To MW4PR15MB4410.namprd15.prod.outlook.com
 (2603:10b6:303:bf::10)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c9::13dd] (2620:10d:c091:480::1:7cd1) by MN2PR19CA0026.namprd19.prod.outlook.com (2603:10b6:208:178::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Tue, 9 Nov 2021 01:09:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b650fee-8d25-44c1-07c7-08d9a31d8812
X-MS-TrafficTypeDiagnostic: CO1PR15MB4874:
X-Microsoft-Antispam-PRVS: <CO1PR15MB487417549A79E7B319116EDFD8929@CO1PR15MB4874.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZd9FKGAjpGTlFHd0KW0lT6YxquyCPKihTjWuc6kWJJKjvmFLgvbP/7uxoWU65u4qeeD/mJjLjgwHmr2iLZZAiTqJ9rbm7lsJzooov3IIJAJat1Pv+uEh4DybBnTue+ET228x6DZXXTTI1PBfS3uCT7RkvlLI/R3i9mzBFbqOKLsPvKZ+wGPxyI1bHpsB4TexCRPIz8BcNFeJdgOd3vOS+TVncFO1eZleKLu7JOAE6DOdDIWG41EiRGNtEZiztopQDEyyxH/LCZ96KmF35UBlhXW9d1diFtWWpd36bRWSCFZujcsxIOFnIbQhW2Hi7WeYYrQ6mvUegg5Yoo0povGmlOmRN9jLIusFwIyPxUoPfXxbdkanK9ZFPmGjDwvl9jxy0iwwVqW1ZQBlpENwxhLT7g61SFEypQXBmtOLKrAadD2pyK5Y1ilG56i3DBjJ5pn5BzuFGww2pgZuktKuMdS3p9XR2at/eMBHoO4+1zrxgKHRXYQh5Aywj1luBKeEx03h/rBhL94+0CkruGBeYARliDY10USdBV3v0m4nbQSJC0eNzFA1GZbc/dD/gfib1vYI4aduTvVOMEvLK0lH9nAUyynL7x6/Dp2l2IRZaiH+1Ee2ZzwdRGcm52EctZ5c4rE0O7DvbsfBh0lXfn+qZhxqdMwCil/xceusryw+Pf83J/1l8Ve53Oipri7PKcRUD1KbJdP3E+hBw9Yk81VvR+YPAlzTaE1kWD3a4Drd33HauU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4410.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(8936002)(66476007)(2906002)(66946007)(6486002)(6636002)(5660300002)(86362001)(31696002)(66556008)(316002)(8676002)(508600001)(38100700002)(2616005)(31686004)(83380400001)(6666004)(186003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UklJWHVZZWdsRTFNYTQ1dU8yVXVSOGRnYXhSaCtLWUlGTzIzNDJqeE1tQmtq?=
 =?utf-8?B?QzdUN0FPVVdZNUtQcTJpcW1tRkNBN2hvKzIyZ1ExVHFwbVlNT3RDcUJIaU5Y?=
 =?utf-8?B?L1hodTdIM0hxaU41ZUhuMmc4QXd0UFczdzN4SmVCQ1REazRoUFFETGdSTWkr?=
 =?utf-8?B?RTJQbGpXdlEvMnZ2a3BRcXVkSy9NVzdKSHVzREpPMzVnOHBrVEFlUy8zTWJJ?=
 =?utf-8?B?KzYxbmovMEVjbFZ4bkpicEZLbUxNdTBhYTRZY25PaHlqMjg4QlgvTDhOekJk?=
 =?utf-8?B?TDNuNHdSSGJGakJMMGgrTTcwRFdEd1JHRFJ6WXAyaUxyRnRIMVZqYWE2clhL?=
 =?utf-8?B?bEcvbUJna3o0MDlnQi9JTTdqd1lxTncvSWk1Qm56cTM3MVkyZGhEUUFJQU93?=
 =?utf-8?B?and1Q0Y5OUFCT3UwSjYvZ1lqSUxZRzFyVktoeWNhcG1BUm1YMWNOZGNudE5E?=
 =?utf-8?B?QjJySzU5ZmpBOWVmM2ErNUFvdisxcmgxZk5lY21tL2NmWEZ5aW5raGZDbW1S?=
 =?utf-8?B?RWRyQUNNQzBKL2kvNmVhYy8xc3NsZm92cUVhYTd1OUlNdjBVWE9EMUwyQXF3?=
 =?utf-8?B?Y1JMQ0ZkODk4eDBIWHhoaWdhdzRnc2tUOFM4bEYzVDB2anBFaDNxZVpRSk9a?=
 =?utf-8?B?SWhtUkFPdmhhcnRya2VERHBCS1MzbXdPSjdVS2xhaWpOY2tNemZ1SnpNSW8r?=
 =?utf-8?B?YkpCTjNNMzc2Ri9KeU5vaDlWZUVtYVYzeTU0eFUrVVhIclVGYkVRTUkxc1NE?=
 =?utf-8?B?OFZtZXYxL1RhTitHNjRaVjJwS0VOaTVlUVZXSDRPMzZHbGlldERxK2RiTEpo?=
 =?utf-8?B?bkJtMEd6cHQxaDVRSk50d2daMjNNNVNreVRSTjRPTDl1d0lUeTFFVG10b05y?=
 =?utf-8?B?c3Z1LzFnVVJNUFNkbzlPV1JDOVk0bnB2eVEwNjhvMUdLM2ZtdVV0emJWTW96?=
 =?utf-8?B?azhucTAxZUFjUkNSRjdRYjYxM29aUnB5anNFUmtSaXFIWGNDQ0xiQUNLQnlM?=
 =?utf-8?B?aGszN0xCL1VpZGFwa05pTUxyWngrUXpxeHVHZ0J6ZWFMcXE4U2FXa2lTL2Rz?=
 =?utf-8?B?ZWRJWFNwRXk5WHNtZzhPeDVsb2NNbXRseGZTbDVTSUhLYkF4ZUFFTklPMXho?=
 =?utf-8?B?Rng4ZnZzYXZnV1p6bFlESmFrc3E2Vzk5RlFyVmFwTXMwMWdsMEY4MStGMXUx?=
 =?utf-8?B?L1M2Vjhqc2l1aVBxTDA4TnM0V0NhT2FvWDZhQ3lkU1RnTGZwK1EwVkZFazJ1?=
 =?utf-8?B?am1kdHNnNXExcnRjN3pLSDJtNnNldElEL2NQY3dDSmNqdmMwRVhsUVFKOGk4?=
 =?utf-8?B?SVAvQnFwODgvN0t5cUk4QTZjaWRhMFVubHZPTkpVUVFabVB4d1pyempycFlR?=
 =?utf-8?B?MjBTTklqUW9UWXViL3VyRUdYamQva1NEZmNGZHo1MThMSURPcG1ub25aTWZ5?=
 =?utf-8?B?azJrTXBDWkt5UDhhQUVyaHovRGVkSCtDMFc5T1Vjd0Jnb1hrMHpBKzBwQnZx?=
 =?utf-8?B?MkZDWjFJOWs2L0F6dE8xSmYwRWpvNXVFM2dIaUx3bU1GWGxlWkErL0czK3pY?=
 =?utf-8?B?aXl5QWJzbkI5blBteDBINVRCRXVSOUtUZVQyWWpMUEtuRCtlUWVFQSttTldi?=
 =?utf-8?B?UXZMcXdPam9lcmpweUlXMjRlL1pRZC8zbXg0N1dLbUV0VUk3Q2RsMFNtTmZ4?=
 =?utf-8?B?Uk1vZTJTZmY5dTNXZWs1QUIyV0VyekZWTzExNHN0TklyTE14Qk5manBadWhM?=
 =?utf-8?B?b3pBV2Y2L05XRkIxakUwajRPNFVLMmlESVhaVS8ycjBNUmtlSXFXNDZ1MzAv?=
 =?utf-8?B?SjVHNVZYYkZLRUJXTVM0dlBIL1hrajdBOHk5QWxWSzVvMERBaWJtL1ZtOTky?=
 =?utf-8?B?Z0Zham9aZDUwYW5XVndsUHowSksxdi8yWHBtZ3pTTlM1RFZneEQxOXZDb3ZM?=
 =?utf-8?B?RW9tLzJPZW5sUTJSTXRtaktnSlpmdnNkWENaMGtla0pyVW9VWTExYUlkUjk0?=
 =?utf-8?B?OEhZbWZUcVFha2JQUDBCSzBBRDdLR1dmd21lcVg0cUMraDdndk1nQmJjdWpx?=
 =?utf-8?B?WlE0MEh1ODV2TTUwQzViWkg5ckk3MUFoeUVwdXFHOWlDWlorWmJaV1JPZmht?=
 =?utf-8?Q?LnWsQsLToFeQqxeu7Xoss4JpN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b650fee-8d25-44c1-07c7-08d9a31d8812
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4410.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 01:09:08.5024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zZZPZdZyPX1LUl1uAX/wuVfdWIhUVxn2U0H6yCZtQTp/vYTiY0nAvQxO4KSZf4N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4874
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: eVBhH9QgeuvhAeMym70Ayau7VKXiOqAM
X-Proofpoint-GUID: eVBhH9QgeuvhAeMym70Ayau7VKXiOqAM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_07,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090003
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/5/21 3:04 AM, Nikolay Borisov wrote:
> 
> 
> On 29.10.21 г. 21:39, Stefan Roesch wrote:
>> This adds the force_chunk_alloc sysfs entry to be able to force a
>> storage allocation. This is a debugging and test feature and is
>> enabled with the CONFIG_BTRFS_DEBUG configuration option.
>>
>> It is stored at
>> /sys/fs/btrfs/<uuid>/allocation/<block_type>/force_chunk_alloc.
>> ---
>>  fs/btrfs/sysfs.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 65 insertions(+)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 3b0bcbc2ed2e..983c53b76aa6 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -771,6 +771,64 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
>>  	return val;
>>  }
>>  
>> +#ifdef CONFIG_BTRFS_DEBUG
>> +/*
>> + * Return if space info force allocation chunk flag is set.
> 
> nit: Well this is a dummy function which simply returns 0. I guess what
> makes sense is to simply make the show op a NULL, i wonder if sysfs can
> handle this gracefully though.
> 
> <snip>
>

This is possible however I need to also change the file mask, so the user can
only write to the file. I'll make the change.
 
