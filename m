Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A8E414813
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Sep 2021 13:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbhIVLnq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 07:43:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:16686 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235848AbhIVLnq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 07:43:46 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MBcmU1013122;
        Wed, 22 Sep 2021 11:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OZJfjf40oqKgIpTYACc1yQvugb8i6edap6IY7Jp4Cd8=;
 b=jgMPF2qiOSsuKzjn1K7jRFL1pQvWsUPSg9tnQ0lLdjDnhfro/eTVOhwOwddS8iSTX/5v
 1JMH6+1kVB2i0aJqT8Hngp1toF30eykR38hbxCXjMvrEyrpTGivug0fuDWyZdWqpJvyt
 7TbhlkZ5nKCB0r8XrcyWbH/XNMjRQnnCnC5rwsfxQ7x9et4kJuU1CtWGJWiD9egRYXND
 32tJ+UnYlN22xPn0PpTnRH9QW/MC8lu5TaW4wEjuN1MJPg8CfN2BGE+15M5VHSAtJiNU
 hl9QksQfrFX/HnNjrG5dacWIVK7sEhvV0xmSAq3No/8RZ2yuHlMDujuFqE8j6IFoev91 GQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4qk76m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 11:42:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18MBZajX013948;
        Wed, 22 Sep 2021 11:42:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3030.oracle.com with ESMTP id 3b7q5mtkqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 11:42:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJlwvI38uJJShFlZbVgm+6MM4ikpefgBkvYslaXcFP4Vla0OYv/0sI5x8AqG1DZsSIj3A8sj6jM8KJXnrxIIIy6ztMJPEZE3I/yXWKLE/8uMKQBZfy4l7e26Kzt6BUuHzv8eJlN4mYzzNXAzk3RXD0nxFmZJ0tJXY3zOgOSVR+0+80rUHoWGF6OzrAAdoH0FsPGNcAnf7A0/aAxtpg+oplVQTDGjzN0G6FEqwv7ldNctlkDcyK8dlaWkJDM45gExbRjbxY8qU9vS/DsoVYNlcdEhJpf3wMZn7j6Kr+g+5a1eaL/0pcsgA0wvz7jXrbqQBniPXmLkSrZW2q2wjmJd7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OZJfjf40oqKgIpTYACc1yQvugb8i6edap6IY7Jp4Cd8=;
 b=irWve45ej3D5uirSF2UpfiXkiPFQX1whcKXlf9HBHzHOS4SAfTxwVAA9MUsIBqKrYzyPB9HOqgQETQAAvhSattAfH4/HYRzaeqtTWytisfh2Ww+q/DgXmf1IWrH7Q1W08ZDRj+dJSg9v6MGxt7eyxL+YhVEnK/hCcLEKDkA/bX6bnUtiFj+DfkZwDLTCpKHuoMkM1ofRhZXbVu+IMc74NMdqQdGzLyPbF/DyHm9VY25Wd96o1v6VTQFCBpey5TleBFiyto2LGQYyLBpN6him1xfpGb3MmRCwHO1361EobmsvSpoK3VWgmoDPmhoVrrj43gP+k3mq4gZLk9jDSLa1fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZJfjf40oqKgIpTYACc1yQvugb8i6edap6IY7Jp4Cd8=;
 b=XaTy3HVlrjkKWczNsGU22/r8v/vivDuyRvCdtUuXJIj5dDIOkMkBmUUIwyc/oHR48kYa+1Xa2L5aIobiEMZ9eY8XSG6VExHdg+V5ko9U7x+mfK6dOxWqqMdEGkkGjRKRiTq2YB7bC1oGx9rs4W2gYptm7ghmthWcmDTjjnMhO0s=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4079.namprd10.prod.outlook.com (2603:10b6:208:1b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Wed, 22 Sep
 2021 11:42:01 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4500.018; Wed, 22 Sep 2021
 11:42:01 +0000
Subject: Re: [PATCH v6 3/3] btrfs: consolidate device_list_mutex in
 prepare_sprout to its parent
To:     Nikolay Borisov <nborisov@suse.com>
References: <cover.1632179897.git.anand.jain@oracle.com>
 <ec3ecca596bf5d9de5e152942a277ab48915f0cf.1632179897.git.anand.jain@oracle.com>
 <840713c4-48ef-b4e6-91e3-f92158448b7c@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Message-ID: <0ee297d9-84f7-7450-48c4-2703b14ef697@oracle.com>
Date:   Wed, 22 Sep 2021 19:41:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <840713c4-48ef-b4e6-91e3-f92158448b7c@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0111.apcprd06.prod.outlook.com
 (2603:1096:1:1d::13) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR06CA0111.apcprd06.prod.outlook.com (2603:1096:1:1d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 11:42:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 783f00f8-1418-43dc-06e2-08d97dbdfe1c
X-MS-TrafficTypeDiagnostic: MN2PR10MB4079:
X-Microsoft-Antispam-PRVS: <MN2PR10MB407908E2F4D40B65349E5B94E5A29@MN2PR10MB4079.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i4X2q965IZHukVajP5q/wDTRCbaRPALauQ54xkHGlJRjt4UGhsAlZtRH0ThfbqdyhsLyzU7pgT6koBHy8/QYLLu8DQ5QYqRvgDsF/rE6gQKEWiOM05rl10p3IINiLiFV9lMNt+lHTcsRkqOGRSVrAtN3+CmNTlZGHKzsrKYyBgJHuyXXqYslQH3C4UbnZuTgd0xUuwczGkPUzb6rPtlFTuYUtK/jeQuy4OopVyStb8Cj1P+xTqRBezI6EPzkLokg0YrzPMXxE7ehs/UJSKU12SJAlDW37UfqWyUNfDdJDqUiXfQE3qaIKNJj9GcsfIUvTDr617kjE3zRWY/+hz5K1udtFkNy+/L8M532o0PRBuOMYl+OcCgNGajKuaVf7OWty+zSxGLOqsCvsxHfgdjEx7kzjozfeLWZf4eZH+slblogAE3HEJZzgFZ2nytbbqdSjbKKwCjzNv/XPIPvbWt0cA5qxQsewFWPs87Fez6N24XHzIz1kG2yrKM56v8Xi/ggxFNMML8cgj86gYxXAQ+MbONfuxeEHvz2oSo97f7Sw3vMFvlgqRdvl5NkDWMthvXHvpv2RccGFfbXcRWLr2JV729O/8NwN1le5G5YeWWNAx6A4xn596ELqzKfwryLd2YqB3KtBUNr33qZjLbjkz2fzKMh5gUmpKN/M6Lv6zbAlAcce0vXMU03UAUiPaVRTu+F492s/Byh5obqjuvdJwiEPTi13iJuMEDOawdoWUvtrgs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(66946007)(316002)(4326008)(38100700002)(6486002)(186003)(86362001)(16576012)(6916009)(5660300002)(66476007)(6666004)(8676002)(44832011)(2616005)(956004)(53546011)(2906002)(26005)(36756003)(83380400001)(508600001)(8936002)(31686004)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1NjYlBYTUVOQzdxQjhINzF5S3VydGlsNy9WUGlrQ0xmTnZqYWNza2hhVHUy?=
 =?utf-8?B?dkdhejQrMk1vSGpKeUg2VFNVV2VCalplQXF3aFM3OHlrbzRxVGdqTTdrYjJZ?=
 =?utf-8?B?TEYxN1dodVBTTEhJYmg1KzFpdDVadXduNnVHSHEyQTlaV0RXaDI4Nnd0My9S?=
 =?utf-8?B?UVpOTEg0ZmJlQU4yc2FQUFBza3c3ajBJQnBDVk1nZFRncEgraXNMd1Awam95?=
 =?utf-8?B?WmtBc2tKaWhjQ3UxVGpxSk80MWlxMGpFOExaTkxwVGJpMmNVcXRvYUJaYTQ0?=
 =?utf-8?B?MHpiRmNiZkJNVUxwTU0zcFRhRFVhSUxZTVFRM0hkRjBkNkxFMGV4NE9MOHJz?=
 =?utf-8?B?c0hadmpVZlgxSG9tZ3piV2E4cXdIS1NVS3lKOEVlR2lCNE1rQ1QweVlrL3p1?=
 =?utf-8?B?VW1XZkZESldpOWdiak53cUhKSmROWngyWUFJK0xveDFjZGhvY2V1SkNHbHRk?=
 =?utf-8?B?eHdhbkdPUzBRc3BGNTNjYUM4YnNuT0NINFNGT0FYbml5dndHejlycGhEU2Zp?=
 =?utf-8?B?dlpZL3pwVkExMVBwRnpMa21GbnBpUVpBTU51K1FvVXpCN0V2UWZnQTVFejh4?=
 =?utf-8?B?ZFYwQ1hlSnpodmhFSThzMlpYV0NTcUc4UDhqRDF6RklZcVl5TmNQSEhPYTBR?=
 =?utf-8?B?Uk9KQVJEL1g4OFhXVU0yNEhsT1JscjlUdCtJRElvVVoxMCtxZVZZSXJGeVhy?=
 =?utf-8?B?U0s5RDd5UHRmNmtlMlJrRzRyckU0eVpjZFR0YnZSaFNxOTJrd1g3OWF1dEFo?=
 =?utf-8?B?VUJ2T0o2bzUwa2E5aytUUEpEcjVTNXM0b0h1cTQ5Y1BCc2o4K2JMOUJhN1ZN?=
 =?utf-8?B?R2JsZ0ZJQWFFSWl3SlZ5a3l4ZjExdkZBeW56dXA2dERxbE5LMytGSm5TWDRF?=
 =?utf-8?B?cVVWZURBWTNhd0toY2xWYUtuUnJwZEwxdy93bHVJdW9OOVZqTSt6aTNQbG0v?=
 =?utf-8?B?L2RjZ2Y4WDZOTEM4R0M0bzZ5dmlvUk1Jd1NrTlFhRlhESmEySlFweEd6V0ZZ?=
 =?utf-8?B?VTlQVFlUbm1Mbk4yL3RYd3RTcHBxWC9QZjYwZzRXWkEyREFLc1dzdGNlVnhM?=
 =?utf-8?B?MHFFTEN0NnZiSVB2UHVqSWUrVnZaajBIank5ejBJVGVEY2RCNzJFL3F6ZUVR?=
 =?utf-8?B?eVg4OUlWVVpvZXJsbXhoa2dPbkdoMlMrR0xlV3E1ajdiNlB4UUkwaTVxL1V4?=
 =?utf-8?B?T0w3YjN5VzVCNnJhWER4bFlaMHk4M2t0V2t5TWRTVGtzMHpxcEFRVHFsaWVj?=
 =?utf-8?B?Z2xQeUVCMTZEc2pWTmZta1ZzWXdNQk0zS2tSZmRUYnU3N1I5cmFCZzZBZUs4?=
 =?utf-8?B?QkNpVXZoaXpPUk5KWmx2bDk0eExBelVMWm5vQ0JWb2NLMnNicEhZcE95dGlQ?=
 =?utf-8?B?azV5TVliKy9heUhWUm8yY2V5bEhhcHRlREhTMVpUM2d5OU9KMVl2clB2dDVi?=
 =?utf-8?B?bldSYzk1UGYwendRdWtCVUhiVnh6dGhlUkRPUzVJazBOR1I2MUJQMy9YYVFv?=
 =?utf-8?B?RnNadTNPUC94K25wdERyeDd3NCtmNS9EWjVobWVpMkRhNEsxYzVZVXZraG02?=
 =?utf-8?B?OEdhV1M3V3BoT3RQVldLWUNaYmd3cDRNOE1RRXV1UG4rZkxyQ2dNWC9wV3V5?=
 =?utf-8?B?eFlFZUZ3eE9qeHB5MkxXK1dnelNjbThtMExnMFU1NnhERmdKclBJejIyelNF?=
 =?utf-8?B?c2ZGeDR6UTF5ZWc0WVVpWUpIenVDZFZuclpkemJDWWdxOE5GcUJ0NnI4cVhL?=
 =?utf-8?Q?uGiVN3/0aRhVwQ5yPTRXSRDgLHgLu+tZzOE3D7Z?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783f00f8-1418-43dc-06e2-08d97dbdfe1c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 11:42:01.6172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXqIxY2paLPy8PqhlXDrjP+ZSwBbRAyY3j82ARptYOK8J7oO1EL8DZbeyi1qdCQhlvxq5qLQ/STrdxYDwr2a7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4079
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220082
X-Proofpoint-ORIG-GUID: 3kmCK8tGh2JytNAsskDcHqg1xmOiGqMm
X-Proofpoint-GUID: 3kmCK8tGh2JytNAsskDcHqg1xmOiGqMm
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/09/2021 19:01, Nikolay Borisov wrote:
> 
> 
> On 21.09.21 г. 7:33, Anand Jain wrote:
>> btrfs_prepare_sprout() splices seed devices into its own struct fs_devices,
>> so that its parent function btrfs_init_new_device() can add the new sprout
>> device to fs_info->fs_devices.
>>
>> Both btrfs_prepare_sprout() and btrfs_init_new_device() needs
>> device_list_mutex. But they are holding it sequentially, thus creates a
>> small window to an opportunity to race. Close this opportunity and hold
>> device_list_mutex common to both btrfs_init_new_device() and
>> btrfs_prepare_sprout().
>>
>> This patch splits btrfs_prepare_sprout() into btrfs_alloc_sprout() and
>> btrfs_splice_sprout(). This split is essential because device_list_mutex
>> shouldn't be held for btrfs_alloc_sprout() but must be held for
>> btrfs_splice_sprout(). So now a common device_list_mutex can be used
>> between btrfs_init_new_device() and btrfs_splice_sprout().
>>
>> This patch also moves the lockdep_assert_held(&uuid_mutex) from the
>> starting of the function to just above the line where we need this lock.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v6:
>>   Remove RFC.
>>   Split btrfs_prepare_sprout so that the allocation part can be outside
>>   of the device_list_mutex in the parent function btrfs_init_new_device().
>>
>>   fs/btrfs/volumes.c | 46 +++++++++++++++++++++++++++++++---------------
>>   1 file changed, 31 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index e4079e25db70..b21eac32ec98 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -2376,19 +2376,13 @@ struct btrfs_device *btrfs_find_device_by_devspec(
>>   	return btrfs_find_device_by_path(fs_info, device_path);
>>   }
>>   
>> -/*
>> - * does all the dirty work required for changing file system's UUID.
>> - */
>> -static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>> +static int btrfs_alloc_sprout(struct btrfs_fs_info *fs_info,
>> +			      struct btrfs_fs_devices **seed_devices_ret)
> 
> Nope, make the function return a struct btrfs_fs_devices *.
> 

  Ok.

>>   {
>>   	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>>   	struct btrfs_fs_devices *old_devices;
>>   	struct btrfs_fs_devices *seed_devices;
>> -	struct btrfs_super_block *disk_super = fs_info->super_copy;
>> -	struct btrfs_device *device;
>> -	u64 super_flags;
>>   
>> -	lockdep_assert_held(&uuid_mutex);
>>   	if (!fs_devices->seeding)
>>   		return -EINVAL;
>>   
>> @@ -2412,6 +2406,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>>   		return PTR_ERR(old_devices);
>>   	}
>>   
>> +	lockdep_assert_held(&uuid_mutex);
>>   	list_add(&old_devices->fs_list, &fs_uuids);
>>   
>>   	memcpy(seed_devices, fs_devices, sizeof(*seed_devices));
>> @@ -2419,7 +2414,23 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>>   	INIT_LIST_HEAD(&seed_devices->devices);
>>   	INIT_LIST_HEAD(&seed_devices->alloc_list);
>>   
>> -	mutex_lock(&fs_devices->device_list_mutex);
>> +	*seed_devices_ret = seed_devices;
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Splice seed devices into the sprout fs_devices.
>> + * Generate a new fsid for the sprouted readwrite btrfs.
>> + */
>> +static void btrfs_splice_sprout(struct btrfs_fs_info *fs_info,
>> +				struct btrfs_fs_devices *seed_devices)
>> +{
> 
> This function is missing a lockdep_assert_held annotation and it depends
> on the device_list_mutex being held.

  You mean
     lockdep_assert_held(&device_list_mutex);
  and not
     lockdep_assert_held(&uuid_mutex);
  right?

> However looking at the resulting code it doesn't look good, because
> btrfs_splice_sporut suggests you simply add the seed device to a bunch
> of places, yet looking at the function's body it's evident it actually
> finishes some parts of the initialization, changes the uuid of the
> fs_devices. I'm not convinced it really makes the code better or at the
> very least the 'splice_sprout' needs to be changed, because splicing is
> a minot part of what this function really does.

The purpose of the split of btrfs_prepare_sprout() was to use a common 
device_list_mutex. So I tend to avoid any other changes, but I think I 
will do it now based on the comments.

Thanks, Anand
> 
> 
> <snip>
> 

