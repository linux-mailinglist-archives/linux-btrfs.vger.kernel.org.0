Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEC143F213
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 23:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhJ1V4F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 17:56:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6682 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230476AbhJ1V4E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 17:56:04 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19SKNWWM021616;
        Thu, 28 Oct 2021 21:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yHZ4oWKP6zbF3ba9q21aINpClYO9m6FWNUUDtjilvKE=;
 b=Pq/0unD/ghZRdQu5UGry6MvXD1K+B64YKVi0WEJiuHfTYEW2Go/GGTihqvgA/4xOjAsG
 AnoikiFbxp1uNaAxwb7vmFT6tMODjAY4JJhaCFo9cNxaaGSQkDBilqzwdy8FXiiCiXJa
 CxBLNj/yOETfDh5/UbEfZPkloNOwtUNJO9fDXCDUnpzF4I6gXI9ZKsyCoZxFFivE3IGs
 UG6WY/SyBspS/LBUPmgjr1kmKGT4WTgIrzShABfX4+rrbT2FDA5I3Hwjj2oM6JS7rPAo
 06q9t6jK3RSlfoLc2Y6FTBH/AZnR/vRjGWPq2OOHLd2y2UYAzUO4nKMQqNW0OgYOWlBU 9Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3byja2d4tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 21:53:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19SLq1T3194364;
        Thu, 28 Oct 2021 21:53:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by userp3020.oracle.com with ESMTP id 3bx4gtg174-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 21:53:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHCBFQ+SrElns/lUqxGVcDI8ZfX6klzsPxfk5ZrE4mP16JIFM4hjwacf3moSo5gjkXxyiYx3rLJyf/sL0Y77QpBQnzVK3zRDthbpGmFZRC5VVQmF0+ZTeoK8OgJEb7/chUmgQljC3pthXqZBdzuIe8Zg3L9oLR+wahiGAECUTexNDA2g0lKU82vBUpNmvYQmfuMFFOg2KgDBo6Z/elICeicT1dzIanLyG+RegEOhYdNvWblpVxkulVYtbwstCMEf94oATgpdiU1lSSv8GtnJrcbZVJE5cXNRUvL2Ov97PZ7BIY4qLAMJ2PpGEOxYdpBXHaEq4uXqtTLuVUcKOZz7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHZ4oWKP6zbF3ba9q21aINpClYO9m6FWNUUDtjilvKE=;
 b=CVV5zt3Hp02rjvwri4URCD8auPKwyIcKsWLAn99InkKK4AMoBd4C5V5Uzm5lxtStH8KHPWLqGauQuSRCdaC/gfcLTsHl8P+VqGzhog0QjljWJdPvsAyj4CW79TOXjn4ZPwD9bjkl4/tEEUNAXu/2y2JILYgzvLYt8GhdNquZp87FOheFERdseLoitz3MUQAs0YScT9b0J76+YfGFt788VbAS98h/hh2qR9+MyaUZek4fyFIiDBW8MtgAPhq2y/ni6WGzEqJInG9EDiihwl86+bB2FxlPueZEvQ4EAEZfiOnTidBRpKMTEnE78vbXfyIsdQmDARFDdJAtnzGqsWih6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHZ4oWKP6zbF3ba9q21aINpClYO9m6FWNUUDtjilvKE=;
 b=W6qp8NoxpvtNFVkWyCaydtrGd1gg7buRNTnYjLia5dzJxbHjWQRVACEyo+q0o2vzAKfUGVT4YS7cvwP0rues2NUA1AzeJl2BoJIpoeQQ623AJb1qhD0qAWiFDL53efJKDoHKqOauf3qDfYHOoALIoAFT1FTKa2DVDboU6ScCGRE=
Authentication-Results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10)
 by DS7PR10MB5037.namprd10.prod.outlook.com (2603:10b6:5:3a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 21:53:28 +0000
Received: from DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::9ca1:3e07:1503:e999]) by DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::9ca1:3e07:1503:e999%3]) with mapi id 15.20.4649.015; Thu, 28 Oct 2021
 21:53:28 +0000
Message-ID: <9a67b056-c57d-c033-5040-50dd61e3c518@oracle.com>
Date:   Fri, 29 Oct 2021 05:53:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2 2/2] btrfs: use ilog2() to replace if () branches for
 btrfs_bg_flags_to_raid_index()
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211027052859.44507-1-wqu@suse.com>
 <20211027052859.44507-3-wqu@suse.com>
 <514d1330-6af8-4d48-fef6-f2732d7f186d@oracle.com>
 <f229e88f-5483-9f2d-00eb-9da45f9bca4e@gmx.com>
 <91627cd8-279b-30a1-7e10-adb43f5a2027@oracle.com>
 <10908a2e-30bb-1960-60fd-c225191be7c3@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <10908a2e-30bb-1960-60fd-c225191be7c3@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To DM6PR10MB4123.namprd10.prod.outlook.com
 (2603:10b6:5:210::10)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SI2PR02CA0038.apcprd02.prod.outlook.com (2603:1096:4:196::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Thu, 28 Oct 2021 21:53:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 344a5cfa-b903-48fe-5893-08d99a5d6025
X-MS-TrafficTypeDiagnostic: DS7PR10MB5037:
X-Microsoft-Antispam-PRVS: <DS7PR10MB50371F4A52202F78E531C4A7E5869@DS7PR10MB5037.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RzPwST6L+GMtYKYmy4VkPFcWzHwNudlNZsPfY1YQ2Amu6i6FIxoDTRgmzS5xt/bDk+lJ3/L7JYrCM/bNYRdkqqP/HoZsfVkl+wWtmjxR+3S7o/h8CIzRTpniJI3j5DBqjcyUg2hK2cpBB0uDLGDsF2RvquKznNoS3+Qbn1Ye76hrBo5dv4Oy5AewC4TTkW2t3Xax2SrGlIuJbi6eESsrXgqanlVsQKhwDYDwp0HRojm1NqlS6MhSHP+bdFBFAnX745kaq0GSNk4inki3FbfzsdUc6y9C/mTbYN0gOvHGCIenvNfjxhF/vPUR9o9bg2QNxW50LcYTSMfE4ydtZDXyn7/x0811hwrZXMF6xih5KF1J+VD2LBM5N1SC4o6m1dzHh5dJkQopk6rhLbP6HO0esy0qicJUx7v8D2Wxf6kzf43UpSZDmBAuM73EYVY9lxrfOVjzQjf5UraOOlbC2syRXat8XWLvYKtrNVYbrzJcNqgG4E5p7mx8fsiZcbzjeYxEV3ejLY9vExeV7DnXzshTJXiq+4z1Au1legPIaEHXmyJg1n5i5siy9tEUslRB1/GMaBO2DCiYzgeoffpqF6Obhuwc8lLOeGr04hU6ytpniIQ0FK7MhanSZabvcQNloJ+/C3PorS+XvqyiPpCNODOHD9Yrxg/ldaACHox2OXdQnGiZMQyOtKf9NjORQnXjrrSrByej+H730uCT6o90pZ4YYluJgmZwYm9IZko+qEv4b9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4123.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(83380400001)(66476007)(66556008)(44832011)(6666004)(53546011)(956004)(16576012)(8676002)(5660300002)(31686004)(110136005)(66946007)(26005)(36756003)(2906002)(316002)(86362001)(6486002)(8936002)(186003)(31696002)(38100700002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXlybHlqU1M5SWFsZkZlRnFFUVVwaGtWRmorbGNCTXVrMTZkdUN6UmVYZjB4?=
 =?utf-8?B?Y2lMMWlMWEM4YmZoZkR0VXFIcGI1eVE5R1haQURMNXNERXRDbHgzTlFkSkVq?=
 =?utf-8?B?VkQxbktNS3cxZ3czZ2tXdnFEUjY3RTFrUVFLQ0lFOEZ0S2NYNjRPMS8xRWFi?=
 =?utf-8?B?b25TKzEwM3NSak9QV3RoZGtsblB1Zmx2WGRWM3BiSEFZSzE3RDZKeVdzZ1hh?=
 =?utf-8?B?Q0ZQNlJ4VnVGdm4reHlScWZoc3phcHBoZ3ZBSHNTVkhMNkVjTStEMGJjOVVG?=
 =?utf-8?B?Y0luYkdUbktCRkIrNkEzN2pYcms5NHFubTkxaHp4bWhCNVM2MDZ5UnlGV2p2?=
 =?utf-8?B?c0FKTDl6dDJxV3NCMnpBY21qVVhXU2d5NzdvTDFxTDhhNjlObmhWV01CNUhV?=
 =?utf-8?B?ZFd5THhZbEQxS1FQeEpscjl4ZzdHRUIwbUlBL2lDUDQvS1hnQkFHSFYrZGRT?=
 =?utf-8?B?bG40aFVDcWpKMXN4YUpFQkFnUW5jLytnNWIyb0c4SXFsTmljUTd3VTJad2pi?=
 =?utf-8?B?QzdwRmN2WVhYTHpCOWJrQllZUTJZcWgyTHc3bVlYanc3bmJMN0t6U0Z2cmJY?=
 =?utf-8?B?VmFrMUtDU1NpNnVRVXpQQkRCSjBubFU1aVF3K0x3VC85L2tBSllsb0kyOHNJ?=
 =?utf-8?B?SkEvZnFnTWZjbzR1SWZlMGpBNTZiZzNvd2lrVkNqMVJ4c0Noc3hCUElvS1Nt?=
 =?utf-8?B?eW1sYXlrNWE5d2FrYXVBOUFaZHkvM2tnRW0yS2toNlovK1psd3hOeEwzK01o?=
 =?utf-8?B?cHhZN1Z4M0pkcVNnbi9tRC8vRHF5SVpqK0dRUW9kd0cwU005SWVpbnMxT0ZG?=
 =?utf-8?B?QTFzNWVEM0VIdkZ2NHhQNFFnWTR3RzFxbDM2S2YwVW44a0t1MitnNHRpTWNl?=
 =?utf-8?B?NEdaOE15ZmU0NFVVS21NN1lUbUlvay91dDBrTWlYYkt2NnlLRjNUR1hremdj?=
 =?utf-8?B?YlNYK1pJcTVDN29aQ09ZSjR5K3M3RXVqbUVCUWxUc2E0a2RpZnViZFYzSmVv?=
 =?utf-8?B?R0ZEbkV1MmF1enR5eG9IT0VnZXBXb2x2MnF4dUJCNVIrV09HZytXMmUzOURy?=
 =?utf-8?B?SzZRdjFMWE9iYVRZTjZQb2RzOUpRUEFDelRkbFUvY0Zpa3kzSW12U1VST28r?=
 =?utf-8?B?S01EWHlWUlFPMis5MUovS3pPcWZWRU5qVXA2S2VRbmsweU8xMU40b0xWWDJx?=
 =?utf-8?B?TEg5aFA3cTNpL05iU0ZjREFXYmpZRy9EZWljdFdUaURuR3Examx3SzZPK1hM?=
 =?utf-8?B?MFhUTFk0UGhoU1Buam01WjF5VWU5Z0RFbTY2S3NMRm05UWN2anNUdUdmUW1l?=
 =?utf-8?B?WHA5WlYyUWlxanpSY2I5eUNTNzQ0NjFRWDVUZTgxS1JrbTQ2WHBJUlVzRW9i?=
 =?utf-8?B?dlptenovK0RGbC9vWnFaLzVMMjIzZmNlNUYxa1pabmZiTkNxSzE2UGxGRm9Y?=
 =?utf-8?B?dCtTRW1mL1NOc1lSZ0djTFI4T2FTWlQzYTJkUzgvM0sxSW16bGMxYzl3UHdy?=
 =?utf-8?B?UTY5akFNeSttU1Z2VVhrb1hueHBPS3hGZS9pZk82czdtV3ZlcVdNTWJ2cEVn?=
 =?utf-8?B?TDB1ZUUxb3hOZmd1WFc1bExwZEhNbXRpUlVjNHMxL284TWZxVnQ5R1NtNHVY?=
 =?utf-8?B?QVBEYTMwTzUwMmt2OU5HMG1ZMGlLKzV1djQ2dlJFdVkzN3I3TnlKQjQrcURz?=
 =?utf-8?B?cG1DVE5ZNUxpVXFlMFRmNDd0S0NNRU5SdVMwTVBpSFA3dGdyYlVKYk1UUWFF?=
 =?utf-8?B?dXhCSE9hWmo0TU9FekorNEFkMU5nWnNvNDZETFBGdm9MNzNXTEVhMWxPWG1Z?=
 =?utf-8?B?aFZKdHJtSWdiT1JEQkZ3bkR6WnZ2V2czdTEyc0E3dTdtOFB5OEtyYWpGaVdO?=
 =?utf-8?B?ckRJVW5WQm9SR21QSnMzcUdBNjNBU2taQk5wNXZiNEV1TWcyM2pqWkM3ZXp2?=
 =?utf-8?B?S205aWpTTDl6QnE5RHZaU3diL2x2OHhrR2RTQkViamRWUUVaMUN3aUtMMWpE?=
 =?utf-8?B?T3dnSDNaZ2pPdEdySWdDS1F3UmpXeG9qTXNXSlo0YkN3NTFPV3h4b0psYkRj?=
 =?utf-8?B?ek1FTDZ6YlY2VlZ3TW9uQUZSYXpGOUZUSG9IbmhRdVE3anpHbENxZ0NocndN?=
 =?utf-8?B?L242Rjh1K0phRUEyNFI5RWdGeDA1RE93WDRQay9YVzJvMHV4MHBDd0V1eS9E?=
 =?utf-8?Q?ANUg3Ls0YOA8FcEpOhrAwZc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344a5cfa-b903-48fe-5893-08d99a5d6025
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4123.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 21:53:28.8876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odaEH8W6QKg3wEupYNfsevjkfGDZnJSVPKz+B/J0cp0wnF0OfgEL2onbOUHgY4ozY/2P2pDvWujo5Ua29m8L7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5037
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10151 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110280114
X-Proofpoint-GUID: cqLbEV8Ccn6S7q7gQIsTg6b_LXGB2cRx
X-Proofpoint-ORIG-GUID: cqLbEV8Ccn6S7q7gQIsTg6b_LXGB2cRx
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/10/2021 15:10, Qu Wenruo wrote:
> 
> 
> On 2021/10/28 09:04, Anand Jain wrote:
>>
>>
>> On 27/10/2021 18:41, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/10/27 17:23, Anand Jain wrote:
>>>> On 27/10/2021 13:28, Qu Wenruo wrote:
>>>>> In function btrfs_bg_flags_to_raid_index(), we use quite some if () to
>>>>> convert the BTRFS_BLOCK_GROUP_* bits to a index number.
>>>>>
>>>>> But the truth is, there is really no such need for so many branches at
>>>>> all.
>>>>> Since all BTRFS_BLOCK_GROUP_* flags are just one single bit set inside
>>>>> BTRFS_BLOCK_GROUP_PROFILES_MASK, we can easily use ilog2() to 
>>>>> calculate
>>>>> their values.
>>>>>
>>>>> Only one fixed offset is needed to make the index sequential (the
>>>>> lowest profile bit starts at ilog2(1 << 3) while we have 0 reserved 
>>>>> for
>>>>> SINGLE).
>>>>>
>>>>> Even with that calculation involved (one if(), one ilog2(), one 
>>>>> minus),
>>>>> it should still be way faster than the if () branches, and now it is
>>>>> definitely small enough to be inlined.
>>>>>
>>>>
>>>>   Why not just use reverse static index similar to
>>>>
>>>> const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
>>>> <snip>
>>>> }
>>>
>>> Sorry, I didn't get the point.
>>>
>>> Mind to share more details?
>>>
>>
>> Something like
>>
>> /* Must match with the order of BTRFS_BLOCK_GROUP_XYZ */
>> +enum btrfs_raid_types {
>> +       BTRFS_RAID_RAID0,
>> +       BTRFS_RAID_RAID1,
>> +       BTRFS_RAID_DUP,
>> +       BTRFS_RAID_RAID10,
>> +       BTRFS_RAID_RAID5,
>> +       BTRFS_RAID_RAID6,
>> +       BTRFS_RAID_RAID1C3,
>> +       BTRFS_RAID_RAID1C4,
>> +       BTRFS_RAID_SINGLE,
>> +       BTRFS_NR_RAID_TYPES
> 
> OK I got your point.
> 
> But the point here is, I don't want to enum btrfs_raid_types to hide the
> value and rely on us to make it in proper order.
> 
> Thus that's why my version have all the ilog2() values.
> 
> And in that case, it's just a difference between the shift value and
> where we put RAID_SINGLE.

  Agree. If some commit misses the order, we are in the soup.

  More comments below.

> 
>> +};
>>
>> btrfs_bg_flags_to_raid_index(u64 flags)
>> {
>>         int ret;
>>      flags = flags & BTRFS_BLOCK_GROUP_PROFILE_MASK;
>>
>>         ret = ilog2(flags);
>>         if (ret == 0)
>>                 return  BTRFS_RAID_SINGLE;
> 
> In fact, ilog2(0) behavior is undefined, and should be avoided.
> 
> In this case, we still need to check if (flags == 0), and just change
> the shift value.
> 
> Thanks,
> Qu
> 
>>
>>         return ret - 3;
>> }
>>
>> Should work. No?
>>
>> Thanks, Anand
>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Thanks, Anand
>>>>
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>> ---
>>>>>   fs/btrfs/space-info.h |  2 ++
>>>>>   fs/btrfs/volumes.c    | 26 --------------------------
>>>>>   fs/btrfs/volumes.h    | 42 
>>>>> ++++++++++++++++++++++++++++++++----------
>>>>>   3 files changed, 34 insertions(+), 36 deletions(-)
>>>>>
>>>>> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
>>>>> index cb5056472e79..5a0686ab9679 100644
>>>>> --- a/fs/btrfs/space-info.h
>>>>> +++ b/fs/btrfs/space-info.h
>>>>> @@ -3,6 +3,8 @@
>>>>>   #ifndef BTRFS_SPACE_INFO_H
>>>>>   #define BTRFS_SPACE_INFO_H
>>>>> +#include "volumes.h"
>>>>> +
>>>>>   struct btrfs_space_info {
>>>>>       spinlock_t lock;
>>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>>> index a8ea3f88c4db..94a3dfe709e8 100644
>>>>> --- a/fs/btrfs/volumes.c
>>>>> +++ b/fs/btrfs/volumes.c
>>>>> @@ -154,32 +154,6 @@ const struct btrfs_raid_attr
>>>>> btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
>>>>>       },
>>>>>   };
>>>>> -/*
>>>>> - * Convert block group flags (BTRFS_BLOCK_GROUP_*) to
>>>>> btrfs_raid_types, which
>>>>> - * can be used as index to access btrfs_raid_array[].
>>>>> - */
>>>>> -enum btrfs_raid_types __attribute_const__
>>>>> btrfs_bg_flags_to_raid_index(u64 flags)
>>>>> -{
>>>>> -    if (flags & BTRFS_BLOCK_GROUP_RAID10)
>>>>> -        return BTRFS_RAID_RAID10;
>>>>> -    else if (flags & BTRFS_BLOCK_GROUP_RAID1)
>>>>> -        return BTRFS_RAID_RAID1;
>>>>> -    else if (flags & BTRFS_BLOCK_GROUP_RAID1C3)
>>>>> -        return BTRFS_RAID_RAID1C3;
>>>>> -    else if (flags & BTRFS_BLOCK_GROUP_RAID1C4)
>>>>> -        return BTRFS_RAID_RAID1C4;
>>>>> -    else if (flags & BTRFS_BLOCK_GROUP_DUP)
>>>>> -        return BTRFS_RAID_DUP;
>>>>> -    else if (flags & BTRFS_BLOCK_GROUP_RAID0)
>>>>> -        return BTRFS_RAID_RAID0;
>>>>> -    else if (flags & BTRFS_BLOCK_GROUP_RAID5)
>>>>> -        return BTRFS_RAID_RAID5;
>>>>> -    else if (flags & BTRFS_BLOCK_GROUP_RAID6)
>>>>> -        return BTRFS_RAID_RAID6;
>>>>> -
>>>>> -    return BTRFS_RAID_SINGLE; /* BTRFS_BLOCK_GROUP_SINGLE */
>>>>> -}
>>>>> -
>>>>>   const char *btrfs_bg_type_to_raid_name(u64 flags)
>>>>>   {
>>>>>       const int index = btrfs_bg_flags_to_raid_index(flags);
>>>>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>>>>> index e0c374a7c30b..7038c6cee39a 100644
>>>>> --- a/fs/btrfs/volumes.h
>>>>> +++ b/fs/btrfs/volumes.h
>>>>> @@ -17,19 +17,42 @@ extern struct mutex uuid_mutex;
>>>>>   #define BTRFS_STRIPE_LEN    SZ_64K
>>>>> +/*
>>>>> + * Here we use ilog2(BTRFS_BLOCK_GROUP_*) to convert the profile
>>>>> bits to
>>>>> + * an index.
>>>>> + * We reserve 0 for BTRFS_RAID_SINGLE, while the lowest profile,
>>>>> ilog2(RAID0),
>>>>> + * is 3, thus we need this shift to make all index numbers 
>>>>> sequential.
>>>>> + */
>>>>> +#define BTRFS_RAID_SHIFT    (ilog2(BTRFS_BLOCK_GROUP_RAID0) - 1)
>>>>> +

David may need this to be.

#define BTRFS_BG_FLAG_TO_INDEX(f) \
	ilog2(f >> (ilog2(BTRFS_BLOCK_GROUP_RAID0) - 1))


>>>>>   enum btrfs_raid_types {
>>>>> -    BTRFS_RAID_RAID10,
>>>>> -    BTRFS_RAID_RAID1,
>>>>> -    BTRFS_RAID_DUP,
>>>>> -    BTRFS_RAID_RAID0,
>>>>> -    BTRFS_RAID_SINGLE,
>>>>> -    BTRFS_RAID_RAID5,
>>>>> -    BTRFS_RAID_RAID6,
>>>>> -    BTRFS_RAID_RAID1C3,
>>>>> -    BTRFS_RAID_RAID1C4,
>>>>> +    BTRFS_RAID_SINGLE  = 0,
>>>>> +    BTRFS_RAID_RAID0   = ilog2(BTRFS_BLOCK_GROUP_RAID0 >>
>>>>> BTRFS_RAID_SHIFT),

BTRFS_RAID_RAID0   = BTRFS_BG_FLAG_TO_INDEX(BTRFS_BLOCK_GROUP_RAID0),
::
etc.

>>>>> +    BTRFS_RAID_RAID1   = ilog2(BTRFS_BLOCK_GROUP_RAID1 >>
>>>>> BTRFS_RAID_SHIFT),
>>>>> +    BTRFS_RAID_DUP     = ilog2(BTRFS_BLOCK_GROUP_DUP >>
>>>>> BTRFS_RAID_SHIFT),
>>>>> +    BTRFS_RAID_RAID10  = ilog2(BTRFS_BLOCK_GROUP_RAID10 >>
>>>>> BTRFS_RAID_SHIFT),
>>>>> +    BTRFS_RAID_RAID5   = ilog2(BTRFS_BLOCK_GROUP_RAID5 >>
>>>>> BTRFS_RAID_SHIFT),
>>>>> +    BTRFS_RAID_RAID6   = ilog2(BTRFS_BLOCK_GROUP_RAID6 >>
>>>>> BTRFS_RAID_SHIFT),
>>>>> +    BTRFS_RAID_RAID1C3 = ilog2(BTRFS_BLOCK_GROUP_RAID1C3 >>
>>>>> BTRFS_RAID_SHIFT),
>>>>> +    BTRFS_RAID_RAID1C4 = ilog2(BTRFS_BLOCK_GROUP_RAID1C4 >>
>>>>> BTRFS_RAID_SHIFT),
>>>>>       BTRFS_NR_RAID_TYPES
>>>>>   };
>>>>
>>>>
>>>>> +/*
>>>>> + * Convert block group flags (BTRFS_BLOCK_GROUP_*) to
>>>>> btrfs_raid_types, which
>>>>> + * can be used as index to access btrfs_raid_array[].
>>>>> + */
>>>>> +static inline enum btrfs_raid_types __attribute_const__
>>>>> +btrfs_bg_flags_to_raid_index(u64 flags)
>>>>> +{
>>>>> +    u64 profile = flags & BTRFS_BLOCK_GROUP_PROFILE_MASK;
>>>>> +
>>>>> +    if (!profile)
>>>>> +        return BTRFS_RAID_SINGLE;
>>>>> +
>>>>> +    return ilog2(profile >> BTRFS_RAID_SHIFT);

return BTRFS_BG_FLAG_TO_INDEX(profile);

Otherwise looks good.

Thanks, Anand


>>>>> +}
>>>>> +
>>>>>   struct btrfs_io_geometry {
>>>>>       /* remaining bytes before crossing a stripe */
>>>>>       u64 len;
>>>>> @@ -646,7 +669,6 @@ void btrfs_scratch_superblocks(struct
>>>>> btrfs_fs_info *fs_info,
>>>>>                      struct block_device *bdev,
>>>>>                      const char *device_path);
>>>>> -enum btrfs_raid_types __attribute_const__
>>>>> btrfs_bg_flags_to_raid_index(u64 flags);
>>>>>   int btrfs_bg_type_to_factor(u64 flags);
>>>>>   const char *btrfs_bg_type_to_raid_name(u64 flags);
>>>>>   int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
>>>>>
>>>>

