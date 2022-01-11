Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367B348ADB1
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 13:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbiAKMhM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 07:37:12 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22618 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238836AbiAKMhM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 07:37:12 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B8dGDN021073;
        Tue, 11 Jan 2022 12:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=P9oXdGciZ26usa/eiYc8pB1nqdyuuV1FrHB3BKCNTvs=;
 b=LgByh8KSfg2LvvU/VBTT+nm8zQEYdSBr8c7ODjHPrdx2o0I6bztqjTSgJKfWce6JLwT5
 h9GeNe/Yv/t89wH4s312S6xpNcmiP7SIzuKotr/VRLRL44i0wyVa8kgCbZWbSaBGYH6l
 TGvsY/H7PEbJXcwehNPdYy82JTuobZlTggIatJTvhscbJDh9J1TLJYT2yO6pYa/dX8SU
 jOdTnBOftiD/lv3GSEAcSognK41vaDxK6hHP/UrKzhRVgjY0ZuCVbQI8nnkbQ+GVrZCX
 tHodSpULHw7gLdYEo06vBlnzIBqD9fMZh96TKpHkqPxecTvFEMvOvreUiO/eaSJ6+2Dc 2g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7njt1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 12:37:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BCVcoD016991;
        Tue, 11 Jan 2022 12:37:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2040.outbound.protection.outlook.com [104.47.74.40])
        by userp3020.oracle.com with ESMTP id 3df42mnhqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 12:37:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KS4Hbg2yiZMOtOIeSu0J4ZH+QCkBstYp8HwptXUxdy3vlclDNoJiJdxkeiLDr6M92nlwM1+H9BFMpaIRfRHft/ubxfvDjCd3Veo60kdhrn/cYAEpkxaRYnTo2Y1u4CninB/DVZFppzP2gKST82DZ0pxQBDDKZsR3Vy7NwESvrlE0zpP8nVoLH/srBP+f2xrhfBn1ykmb1xPe8nJw1wruNYjch3G2BbCT4j6atxz+MNFnsvfQKosuiXxRhqfRAShBWihgjpgj864IBucej9kYq9RzNeSxq+PW5qDbMfSbGvY0xA3r1gjr7J0voiX78NkZobUXPd8me3FuqL/wgw7Irw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9oXdGciZ26usa/eiYc8pB1nqdyuuV1FrHB3BKCNTvs=;
 b=VtbjW1LWNVqao1iaREFJhaP4+Kg03VBwfVH8zpZCOVeMxG6/f+ATaAykBuTpP+dnfm2CiHxRsb5C3Q98132witDLuUANONKDYj4Xy5ia/nA+idwRH88AYs/n3LWng7R5VinPYDXRXy2QMjS0GC7pD/i8HWbTs2vjWx2T4SFdIz7+pwS3wq/WPL89zfudU4jnN3QsPR8QnZ0ViDOEf9QEMveST0uEWcuVFIoS69Nj9qs93FY7CY2hwaHkOvkN1jsDINyIT54EwtOVsbVXjZDIJagOnMBQK20ppaircKdKi1aWCkj5SefC8iEQAe4hyjMkVKIb45I0wWOZW5rqkfOTMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9oXdGciZ26usa/eiYc8pB1nqdyuuV1FrHB3BKCNTvs=;
 b=N5iE1JQXQ0neNRTk88buoQmXfdTC4NX7tc4niUq0z2dsxUorTYPxyYMeKyNE20/7pFxtrnJhwObQu3NjmNkV+MYQvrWSEbVtjZ1g6J6+NMibOKEyzRP9FkfKRKEZNo9ZUCkAX3YvRcN8MGrXibPbjje+BfGxleeEIyfwgYFWj1s=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4094.namprd10.prod.outlook.com (2603:10b6:208:11e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 12:37:00 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 12:37:00 +0000
Message-ID: <b7ea8da6-91e4-2af3-333c-dea16af756ec@oracle.com>
Date:   Tue, 11 Jan 2022 20:36:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [External] : Re: [PATCH v4 2/4] btrfs: redeclare
 btrfs_stale_devices arg1 to dev_t
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, l@damenly.su
References: <cover.1641794058.git.anand.jain@oracle.com>
 <d05f560ad6b65dd6fd7fca0e54271d3d0d8a3f8b.1641794058.git.anand.jain@oracle.com>
 <df5e06aa-5ed4-0df2-9210-ea8d19069cba@suse.com>
 <5656e466-7950-2dd0-11f0-2dadcc191f7c@oracle.com>
 <8050ed8f-200c-5adb-34e6-012100b2e913@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <8050ed8f-200c-5adb-34e6-012100b2e913@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 963b3cab-066e-44fc-67d4-08d9d4ff0fed
X-MS-TrafficTypeDiagnostic: MN2PR10MB4094:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB409441FA57926C5D0A4B7AD5E5519@MN2PR10MB4094.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mt+b/1E0FQ9K5UOhzGZD9uNzdR3mIBJ2k8D+GHY83pxiT+2zGY3NLm380WsjPECrOQTBb7v/Ugu94HNVnyvMe2h5QtZ10voxc0DpS1eZFtcWA7r1PVKV1aaMZJRrbb3W5t+4cXBmLPUNOT2OZ87ggHiUDN1yXZ+JTtyvEASqo+W/44ISHgigGtaldzvXqc0mX6RrQPLsbE6LYzQtX87PvaJCeGu/wdW8FSh9LF0o4BvIym4v+L7Ki649fIc8JUcMSGoUjUKou+4T9zwhdcw16y8POeftsHojXCxlKu0DAU2dJflKkVs6G2WW1HAkJXOd5yRilMDBmsPKez1N4z7NJAy0HR4sL4k2g5b2fcSxpBugTlO84ohEQDpCV6GQXYRpkOU3MfTZirD3NzZqNg40TCLnW+LC2jOhLNL0nJck9msgFQQ1EaxyQSmhzrqjDCskG85UWYlsRKC4KG4G9H8HjJK1BxsnxpcNqk0bK3QtnjFP413p39CBwmQJTzwmmHdahMie/hKXKv6Maln4gVwavW7Z59dDwC91pkH+2i2OnTjVnpRvjU00AJsw1FGJJXGMaDoqNxFUrqjqvqbcJQm1MdvFk6RRFfE5HjjED9LPbEhtE8GFwrdF3V1Fks254GUKV/hFuCXMAeu28gMhU9j0cYo9Mgh9NwjPjcIFzbTymcL+WOEIJ143a6BzEEAklcucCC8UZXMALNFrP5xeG3cKHvH9UPStJX6fuFz2iD2Hj/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(5660300002)(8936002)(66556008)(6486002)(8676002)(6506007)(53546011)(31696002)(508600001)(66946007)(26005)(66476007)(4326008)(316002)(44832011)(2616005)(2906002)(6666004)(86362001)(6512007)(36756003)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDNJeFpjejNVdjZNNHV5VTh2RXpndTFEdnN3bzRac2FZbVd2R0pqSnZ5Ky9w?=
 =?utf-8?B?TW9oQno1eGZOeHNwYjdaUXZQZVZ3bUhhN1prOVpjZ3NXM20vKzRXcDNBTm9Y?=
 =?utf-8?B?b2lJWityY0tjUUd0c3crWGtBQlBaZXR1Y1ZzQ05zd0FpeWk5T09md3lPdFhY?=
 =?utf-8?B?VGJnYm5KK1BocXUrZWJnYXVyTWpoRGdDbGF4U3FRRW5sOW5xUEVvQTNZT2lF?=
 =?utf-8?B?b3NicjJuMVBtOU5nZmQrbm13eFpxTWFtKy9CT0p1KysraFloTzNNbGxydDB1?=
 =?utf-8?B?UjBGN0k2SFRKcVpsVU1idWpVbER6YlZ4OTlJbHdxQStXTFluUHh2amV1QlZH?=
 =?utf-8?B?U2Eyd2VBbEdidE1OcWhTbGdYdDkvSkFERjBUMXBHZ2Mwb0Y4NE40eXhEbFox?=
 =?utf-8?B?YzUxZXlVRi96QkRVcFVMZTdiTGpqcnlVOGlkazZkZXZjMFk3Z1ZacVk4N2Jp?=
 =?utf-8?B?RGQ3US83WlJiNjZrY0RzbWNvRFdyUUpETWtqQlFZakljZFB0ajJyTjFqTy9s?=
 =?utf-8?B?RW9pSDJQVjdDZzRMZmVJWVUyTkZRcEZHWGh0SEV0KzFHVjMxV280V0g2WWZ1?=
 =?utf-8?B?S0J1MjNYL1lxS0hCSnM3aXVQMmhySllQSktFbkQrNytWdEpTSk1Lb1V1dXJU?=
 =?utf-8?B?NlEwZEdKYWJYWXFuTXA2MjlkOGtoSU9PK2tON2tFQmd3TzZQZGlhV0M2TzVs?=
 =?utf-8?B?bmFtN1hlRndVZ2V6U0w1NlI0b0N3YVZNTkhvekplN2x0RFNPWXMrNVNieGN0?=
 =?utf-8?B?R3FqSEdUa3NZdjJMcTFoVXBqbXVUZUVlMjdpaWdWTnpmNktseXdCeXVqeW9j?=
 =?utf-8?B?bnRnclVSM0M4N0tlN25XT2pXR1drQTVQS0Z1WElvV0JMY2FEU0lKckVoSk4r?=
 =?utf-8?B?aXM4MlEwOExCeFF1VEh3QnRDQzc0S1hUcFh2b0RVRWpDWFM0UTdHT1lPRUQz?=
 =?utf-8?B?MnNpRTI5UjNuYVZZTUpYdDlmakcrSEVNR1pYWEtpc0lJb1ZubDFPTGhjdU55?=
 =?utf-8?B?a09JVFpXVVVtK3hLeW52eWR5ZXlYRW5QTWpjTkVQVDZOeFJxV2JrcFVGbzVz?=
 =?utf-8?B?WDBtb1o0QnpCL0RPc29sSXo0THkycnRHd1htUHdUNzJXWG95UTNsdm1HckF1?=
 =?utf-8?B?MVozSnh0ejNsa1dKai9TcEZtR090Z0RlVWVJa056NUp3a29FbjFXV3lUM0FB?=
 =?utf-8?B?b3hsbVpQOTRrWEFhem9LUERUNS9HVzJlRkFES3pHaVB6U1RXbHBjY0lJd2pi?=
 =?utf-8?B?N096cTNCUkQxNFRBZWhmcVREU2s3MXkzd2krdkE1Q2VkK1IzbUR6NEsxUW5L?=
 =?utf-8?B?aGtyUXhQWitsczdnR0h1b09MaUV6Yi9rYzlmV0JWT2ZVT3FVWGhIVDdyZGhH?=
 =?utf-8?B?cVU0Q0UzSFQ4Y1EvUlc1TDJMdU5EaXduV2tiU2MwWDZRajUveGZEQ3pzSCtH?=
 =?utf-8?B?KzhmVXFNTkNyODFTdWtuOVBzdWQ3MnBZaVFwTTFsQlpLdG44QWwvSjd2Qlg0?=
 =?utf-8?B?eWdYZlRoRytVeGl6UVVZQlJIbXdWblJOUmpRWFhNMkc4a2lSSDF3elVYTFJt?=
 =?utf-8?B?T1BjWkRZWnJ3eGo2SlN5Z2dXOWQzMXExQmtQSnRwakF1VmNtckJMZlN5MEhR?=
 =?utf-8?B?cDNRMGs2MzhoTnppYmx1ZTBtcWtiUU1IanhlZlRpckNTOW1TdGg3bmxMU0or?=
 =?utf-8?B?ZmQraTV0QW1Ybm1LaDlGV3d5d1VSVE95QUVXY3NlU3NUVnpJT2NKZ0JPY0JR?=
 =?utf-8?B?ZzlUdmdjUGdaMkw5TzNyOVduWVJZVmFMeThsYllsZVcvdUdmZlQyTFlGY0Yw?=
 =?utf-8?B?TzN5WHBZUmdRdnlBV256Y25CUWtCT1FzZDZPN1ROYnJGbTBHaENaUUx2QTRQ?=
 =?utf-8?B?TlIvV3VzZ1kyQzd0cUZWOUF6aksxRGJ4cHFCeWpveEwyMHQvSHhVeEpWVjFi?=
 =?utf-8?B?MDNNbWt5cWdaU1pLSm1jOTVhQXA1VU13T2RYcTNBWGRKMEx5NGIwdHhVdmsw?=
 =?utf-8?B?NFc2cE8rVzRHejgvNkNldTFSajlEa05IeHJJT0taS1RFbTF5NTFzOW9DNlVk?=
 =?utf-8?B?K2JVVkYwUmhLd216Ykgwckwzd0UvalFnRkF1OG1FNWFaUWhSV2hiM0NtR05V?=
 =?utf-8?B?TnBhR2wrV01DZ3l1VFYwRzRGSjlNUmUwdG81a0ZGVzZkWTZGYkdyRlJSY2xx?=
 =?utf-8?Q?/oe5kprCQ3z1ojJn/GBegDk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963b3cab-066e-44fc-67d4-08d9d4ff0fed
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 12:37:00.2975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsr7Lb4zWR+l0+NUMGDjZlC/TDRvvdv4tVual4CAN7FmHPHfrEx4Pu2rn0XAbFZ1Tr2dtDVlnNLPgnQV9UIixA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4094
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=988 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110075
X-Proofpoint-GUID: RTuj7eT8JdmwDxTwQ2vHrfncD22LG-E_
X-Proofpoint-ORIG-GUID: RTuj7eT8JdmwDxTwQ2vHrfncD22LG-E_
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/01/2022 16:30, Nikolay Borisov wrote:
> 
> 
> On 11.01.22 г. 6:51, Anand Jain wrote:
>>
>>>> @@ -604,14 +599,14 @@ static int btrfs_free_stale_devices(const char
>>>> *path,
>>>>                         &fs_devices->devices, dev_list) {
>>>>                if (skip_device && skip_device == device)
>>>>                    continue;
>>>> -            if (path && !device->name)
>>>> +            if (devt && !device->name)
>>>
>>> This check is now rendered obsolete since ->name is used iff we have
>>> passed a patch to match against it, but since your series removes the
>>> path altogether having device->name becomes obsolete, hence it can be
>>> removed.
>>
>> We have it to check for the missing device. Device->name == '\0' is one
>> of the ways coded to identify a missing device. It helps to fail early
>> instead of failing inside device_matched() at lookup_bdev().
> 
> In this case shouldn't the check be just for if (!device->name) rather
> than also checking for the presence of devt? Also a comment is warranted
> that we are skipping missing devices.

I think you missed the point that %devt is an argument there? It implies 
and frees the device with that matching %devt.
IMO it is straightforward that if %devt present then skips the devices 
without a name.
I will add the comment.

Thanks, Anand
