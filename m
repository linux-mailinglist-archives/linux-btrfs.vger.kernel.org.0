Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61DE3BC594
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jul 2021 06:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhGFEhP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jul 2021 00:37:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52542 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229730AbhGFEhP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Jul 2021 00:37:15 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1664VkmP015033;
        Tue, 6 Jul 2021 04:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=2q36am8vGojaYvv58KkjGslewrrEKAaEOW+8DneRgCM=;
 b=G6kw7koLkFxDMVQJOmNPjpzlcyoVODylCBwPUmlo5yShucnIwFaY38ozkVb5j51+9WfY
 2CsGR3fPS4BWw+1seyQV/1P89bz0WQ4mPxx7TLPbYodmK0sT4lai1gWAybO+4jRfBIqx
 5GkEMfPgqTcShKqhXwevuM7TOPUztBT22zxDamCERrQ5T8exiyvpxVFXwGBdimfOq0Sx
 GuC5ukbk+rcYigQVwbA/ixIQwn79/kTENSl6Onngdy7Z4hudr+Laf/UYkiQaMS2niFie
 KTVWMnZiZ2rCU4ZkA5xJWBx/jvNWsWM44/1uPULwR1Jq1rE1upul/vL9t0eoPr8OoGBQ +Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39kw5k1kn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jul 2021 04:34:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1664U3qB159352;
        Tue, 6 Jul 2021 04:34:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by userp3030.oracle.com with ESMTP id 39jd10mjmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jul 2021 04:34:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IS4Zle1NdXIcP8LwQ7cKEWrs6aDfcLi7dzHgv0psrGCEMSIccm7ZZ3FQYouOrteSbdSTTJUSRhFvE2yBc7csBc18MJMzTtqvxcAFKPkJPunnhjDsKSTz1qOLC5mil4rc+ZYAyDp1tGKskQrnLHgxvNLaedtjDszhoIk6ygt6aTcQn9a1SDNd8UtoRQL6ZgzK0QUSvwpPPy48JiF2bQEmBJ5u5ZZdxEhIFEynVhZFqemAthwd2gwZXHaiewg65e+038psYk/I0F7FMYFsrprEQg0gzYQEJMhVnNkcE172pQ9ywBYsRIxJIugGNXZfphAW+m8BK/Zc6npd+oaEW+P9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2q36am8vGojaYvv58KkjGslewrrEKAaEOW+8DneRgCM=;
 b=BmYt2CbvEqxAmFiSA8kBopLIphz72c/Y3kmektLaCwziHRUTznnC+ZynNqYZ3Ew75RsdEhxkn+cY4w638o7UrBxWC40z08kTirVU6xOdCQl5FbaY47SDVSkm3y/520aw5yNAOpUjTgg4OEw9CvB4k7uWdr433dl88KporeeXsR0Goapzz0xi0EEBlYi5zTsp+llbYwJRkjwao2gSbP1DZ4c1fsx4uSe2BHRqDiTQe5c1eVrxjsY857YPhgcFya5gaJQ3AXlF7RnLMRRn6WMXJs78KIXSQjrw5Cx6bQInd5qS2VJag9ESzRGiuDh2aY57SYglXRwkXoi7Oa2a1BCidQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2q36am8vGojaYvv58KkjGslewrrEKAaEOW+8DneRgCM=;
 b=fhLMQPq9rKdOXes3l4Vh0nmFUEPcSzwjXKNxod1poMylWei9B3YORWJx3zUdombBmQKMYW6bsMzCENxtes4sYRcEp1AnDRA1s5zTve4IH6TtlJ+8Tp8zuskDMvVPKAis4sjT909E+PHbbGzKt67pAMGGYAbhjsQ+I4f0J3dhDEw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5282.namprd10.prod.outlook.com (2603:10b6:208:30e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Tue, 6 Jul
 2021 04:34:31 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 04:34:31 +0000
Subject: Re: [PATCH 2/2] btrfs: change btrfs_io_bio_init inline function to
 macro
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1625237377.git.anand.jain@oracle.com>
 <0ae479ebdecf5501937b5d93449a782d96864cce.1625237377.git.anand.jain@oracle.com>
 <05870252-7ab1-0306-7360-a6edeed2b168@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a9f156a1-354b-6555-ba71-da6c92235d09@oracle.com>
Date:   Tue, 6 Jul 2021 12:34:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <05870252-7ab1-0306-7360-a6edeed2b168@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR02CA0066.apcprd02.prod.outlook.com
 (2603:1096:4:54::30) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR02CA0066.apcprd02.prod.outlook.com (2603:1096:4:54::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Tue, 6 Jul 2021 04:34:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0218267c-eee0-4abf-7c45-08d9403758df
X-MS-TrafficTypeDiagnostic: BLAPR10MB5282:
X-Microsoft-Antispam-PRVS: <BLAPR10MB528225875A720E6CBDC34E4AE51B9@BLAPR10MB5282.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /URimQtsOnsqD4YhIgiYDl1eAGDujoXATI/Zvs+mdEBwYeNc/hk6kHbYbWjhhrOaENEhf5Zqaq+MWLg2704m5hnqp4C2Xy4hA2cy5/HhgHyKDh8WbfUO1/gsrvWzV6sHeoCVyO5tj2gWdACG6+K8wtJPiRbgV0s1sYPVzv0gdGzj8HUkksI67zSEGdSqQDMhPuxbDJxqX/aSNOYc1E+SUdYpu016B3/NXTG+BebA2w9jjmUHOlzgeBJ137dJVJ1uYtnNdyAoH4Jc8frKx5wDRyQm0Y6Cm7z3C6zeJsPr3gZpcUzZtDX/XVoEFh4uIFXAKsPoYHYWweHyLyZTBlZ9xdNXmH5ygcao62DsvWebPShjtCER1CfZ/wUXgABI4xk1ZohSgai/WJhliCCdJDf7bKpagAETEIuF74PGw3EczWI+Z6gTYvBilD20wkdmLG6NqPTz1jGFSfgKTiXvigFHtvvsTjzp1gdslBtKc8H+/LzwfDe7kEAvvgTkHHppMPj8Kpkj1ozNMj/EgKXkW2tj4pxuNp0cayJBvmzAoB3dWMoUKiNhnNvOCHrVr0kHTg8gvU/WzL9Nd+3McBrr5GDCQE8YD3faWj4IB3uP3GvNqryPE33qk2Jv1r1KJ2UQYlxYfb5QnamucQpDp17zWy+l45C9SvreBPoWnd6kIS3MPxx+j/goghraNuJ4oFKCj1Lh8hmg8elh6e9z8JdOSyNNzmxnsBTZrYtR6SEoX8nRlYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(346002)(396003)(366004)(38100700002)(44832011)(16576012)(6486002)(66556008)(316002)(83380400001)(6666004)(36756003)(66946007)(66476007)(31696002)(2616005)(2906002)(86362001)(956004)(26005)(16526019)(478600001)(31686004)(8936002)(53546011)(186003)(8676002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnNjUzJTTzZ6aVhNOVY2Y3NUNE1udHhEb1pleG1kejhYK0dmWDAySnVtbGJI?=
 =?utf-8?B?WVNmYnJYaEI1bWJqTTBtb1QrOGlSZTlmK3VVRzJFU3ljMi82THhXcC9KUEhy?=
 =?utf-8?B?WGNtZ1QzREJVclF0Vm8vL1MyWUNRZUlGT2VZckRITml0MkFNeEREUUdFSmFF?=
 =?utf-8?B?dm9MT3NTKzU1Z3lhWkNkajY4OHJmeHM4MnpqWk1BTG4yZzZET3FoVW1PdzZP?=
 =?utf-8?B?OE0zRklyNTRvVFpvMEp4NXNuU2RDUHN1NFliZ2ZCd0NWU3Y4Ry9NUWxIWTVG?=
 =?utf-8?B?TVA3aFkzTEZPeHlDNUgwWG1kbkp2ZjBFM0o0aGdxWkpzOXA2YTJJUzkzOEM4?=
 =?utf-8?B?MC9NbFR2ck4rNThiN1VZNXdBaTU3QnZ0akkwUWxJcE9ZMExkMUZtdXJTSWZY?=
 =?utf-8?B?VWNsdngydUQ3SEpPU1ptdFBUa2ROZXIyWUtYWllNYmVyUHQwNE9LZStEK0N2?=
 =?utf-8?B?UzFpajY1TGpScG1XUkRNSFZOYVFVcWN5ZnlIaXo2clhwWjNVdWR0YW8yY1FZ?=
 =?utf-8?B?cDhSY3I5YWsxU3BubEkxQ3pHYTRIWGJYMTBhM3hta3hpaGo4NkE0eUNhanV1?=
 =?utf-8?B?STVhekNzK2FKNFRjVTM5YlV2dWtIM2F4VHl4bnYwWGFhTzRkN0hRSXRCb29C?=
 =?utf-8?B?aXBGYjFWV2VmcmhaQ0Q0T0szcnJQcndrQ3BSK2xYWFZwWHFLTzRQV2IwSnNr?=
 =?utf-8?B?NmZ4MEVYNFo4SDdSQis1MUp4WGp2L2xhaHZXZkFBWkRvWU1wdVBURHQvelJ2?=
 =?utf-8?B?YmU1M1J0NC9uYU15K05IL05yaXYzL2ZjMTlTZndlYkhGSnI4MFRscE91UTZD?=
 =?utf-8?B?d0xIbkJ4bzh0dGRibEt6SXZsRWxlc2VxaWtycHVpMjk5QjNFVVlJSHRRZ1oy?=
 =?utf-8?B?UktkcHdNeG1meEgrd0JoWDAzSmtNVVJqQU91RGorZmU0OFBVRGppQkRRNzhQ?=
 =?utf-8?B?aHp3VzRCVGVIaDZKb2dTeUlKSnB4WkpNTFFoVW5Lbm9IaFZiNXNmbGNGK2gr?=
 =?utf-8?B?eVkvTkhLSFI4OWFqVEF6aUMxQnpwY0JtZGVTcUhMcVZCTGJYVndxMStHelgz?=
 =?utf-8?B?akphMjA3U3J2NThpODVKZ3NXU3JKb2xJYjR5S1Nmdnd2NEx1dWxyMFdxemNa?=
 =?utf-8?B?T2JQMjNnbGRNRjNQOWJVOFZGT0Q5UzVBZEIvSG9jTDZISVgzTHllWk8vQXNt?=
 =?utf-8?B?dzhvU0FnUE83bHUxL1ZIMmdoR3JOblhYN1d6WmFmdGtCMVN4ODdmT1BkME4r?=
 =?utf-8?B?VHE4ZVgyTGVEQ1g5czRSa2QraWpBR1JWMlB2RkJYOHFUOEp2c3JmbDREUHFR?=
 =?utf-8?B?akd5ek0xbWI5Ym0waWJPdEhieklHb200eXR0NzV5d3RXVmROT0ZDUGZ2d3NX?=
 =?utf-8?B?bThBNVV6b0RFRzlJaUo1R3N1c1BSeDN2dyswdERYOVR3MjVCVmxnRHhxZjJa?=
 =?utf-8?B?MjJ2NlBZSFRId040NnVDaitxUVVXRWltR2VkbTJ6Qmo5SU45djBsb25pNThB?=
 =?utf-8?B?RTBOK3k2L29JdVdldjZidlpFdGoxRWtZdER2aEpFR0gyM3YyNTVJOXJRVDUw?=
 =?utf-8?B?RzJBYjVJenBnZkpOYkdSbjVybDJ3eHZySktIOVdINVZxU0lub0FGWGs2cWRM?=
 =?utf-8?B?T3NmRk1lTEt0cWVZZEdFZ3IwdW5mK2ZjT21jNjJTS2lBd0ZTSFVOcENvQldl?=
 =?utf-8?B?ZjQzbEJEQllqdEJTSE9Wcld3Tjg3TUZUb1lwYzJGcnAyc1VCUThyY3hIOTlz?=
 =?utf-8?Q?GxpLLhgrb5Xvy5h5hYLHIf4lTT6UisJLKAJveQj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0218267c-eee0-4abf-7c45-08d9403758df
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 04:34:31.1610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /w8ta0Csyu38vfpg0I9ZbIoX7/CQI2DREczqSxYOJyWjpeAQuFvxMiLCX+fCSwTwmHJ8nLL6C3T3j2zAZBjaCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5282
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10036 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107060020
X-Proofpoint-GUID: 68D9XPsCT-7E90khOlQo5YDunti_9nTQ
X-Proofpoint-ORIG-GUID: 68D9XPsCT-7E90khOlQo5YDunti_9nTQ
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5/7/21 10:05 pm, Nikolay Borisov wrote:
> 
> 
> On 4.07.21 г. 15:04, Anand Jain wrote:
>> btrfs_io_bio_init() is a single line static inline function and initializes
>> part of allocated struct btrfs_io_bio. Make it macro so that preprocessor
>> handles it and preserve the original comments of the function.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/extent_io.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 9e81d25dea70..8ed07cffb4a4 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -3110,10 +3110,7 @@ static void end_bio_extent_readpage(struct bio *bio)
>>    * new bio by bio_alloc_bioset as it does not initialize the bytes outside of
>>    * 'bio' because use of __GFP_ZERO is not supported.
>>    */
>> -static inline void btrfs_io_bio_init(struct btrfs_io_bio *btrfs_bio)
>> -{
>> -	memset(btrfs_bio, 0, offsetof(struct btrfs_io_bio, bio));
>> -}
>> +#define btrfs_io_bio_init(bbio)	memset(bbio, 0, offsetof(struct btrfs_io_bio, bio))
>>   
>>   /*
>>    * The following helpers allocate a bio. As it's backed by a bioset, it'll
>>
> 
> 
> What do we gain by this change? The compiler is perfectly able to inline
> btrfs_io_bio_init.
> 

The gain is macro is guaranteed to be inline-ed. A function with the 
inline prefix isn't.
