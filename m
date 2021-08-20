Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920CD3F28B7
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 10:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhHTIyE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 04:54:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58144 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233287AbhHTIyD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 04:54:03 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17K8qEs9001515;
        Fri, 20 Aug 2021 08:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uy/L/m8xXVExtUaBb3KByp/NHTPnFo+M9rH8ATGKQxo=;
 b=lbZrieYrmqMlBHABxkUSy9PRx2vhtUAQYkpsDI28QscAXUVJ2MRCv2WlloQtsKhovXew
 vSSdBDEXZXcDHAswqr6cfbIGocRXuPCiLayOWihVGIo+YXphnOCTDx3jotBJ9V/GhesO
 szXze9faiAKk+zJu0BdOdGSV2gNPhNErjpP9Z6Pr9p+hEo37YNBnCxn93VUjZBPByML3
 5qZ/yWplLdvzXagVFMJTMeXRrNgDdXkliOOCvWlrnqEWTTcVREpdYHMemul7WTBOkuIt
 DvZ2BLmGdiNs1hxQRQqlsXER9a6muD8Zktpk4LhjlshfzFZ4e/8/uGDLQBOwdiqVhZPK Sg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=uy/L/m8xXVExtUaBb3KByp/NHTPnFo+M9rH8ATGKQxo=;
 b=hSxws/98qtCfwJEhxGtcHTmCpHg0wjtJHZsTtxj5QH8KPVu7kJlEFv6Lr8OHc7IjnJ50
 1zHlb3SEt/fOCTuzwlUTbn6GKtcuW+MSJGqb2FMFrAOHz+/U+j26M9HT7ojtwgUdWEj1
 9zKjnhwsobISa3r3Y9KDbLAAF4YB1J9nFzWN8/TvsLer24ctVRVeo5btwijU3+dX1UlV
 tlRPHuSWp2tLP84edejAXK02K9aZySkqtJM58lEqhJ+TEf7JI+x35a1YvW1eEHVjmMkm
 4rkpcB6kSihqDlvVV7FstE8JAOsWu+1BWHBqwTGcXGlLs2HXHrQ24BUIAcIgjo/x9enu LA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ahs40hwea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 08:53:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17K8p5HI169124;
        Fri, 20 Aug 2021 08:53:18 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by aserp3030.oracle.com with ESMTP id 3ae3vn6376-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 08:53:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FndC7xgpzoFxOCkH75/EdLSO7y9BImidZXtGq6nDzQhyo0bSHWc7XGRZsjbWe+YQvJPxgfoCdC6JUjvXjlu4Asb6BNrIN5rJ8rIf9UfLnbmE+3cUUsGJkklMrVQSEYvHoT/jzXbsr5AXt9tzGslw/XmNjAPfd9/J8YsMlbPtvnjsPvFlsM43+BwmrDUzZOhT1hwpAfEYxeo7joRYF5nEEWDFqqCNJWDuuRdCujNEHOLhPfX9MdCddkerd9E96no6WUNb8TeGjNsI/bG+qh3Af9FpNP6TsBm32+YG4VAenK3MUm+6A/rlLoK70YWaQ3VYWmsdHldnWdUYXFPA7lPXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uy/L/m8xXVExtUaBb3KByp/NHTPnFo+M9rH8ATGKQxo=;
 b=OUuoUXULaY2AFMe3K5EPgrHy+RcxXMuteQqbhILKVLgCpiZN4jJp68oQCQK+PUp168bsF+z7i8i5nyqz40cz1ebDJAM0AKKBLuU/gbkMShJyHeyExQZ2OMafEXj+V12hzI/xtGZ6HRRpLZjhORCUn9SWudyVSY6IgeMTmNbx0CUeNrRhCWdoLavUCsYrhYxcej/Q4wdLqhJ/aRDa/c0lkiapq/3kIpBdMMtK31jdDSqMM4VS1Ekp1fQrSM87wL0OMXoDlrWiU0vcHocMtisMlNEqSU/RLAUzIefIIDa648U1P4tv9XG8FvORHrq6hJCU3S398YPd2xoSL0YH4El4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uy/L/m8xXVExtUaBb3KByp/NHTPnFo+M9rH8ATGKQxo=;
 b=NumsQHT6bPMXpugKo2DQc/s8OqAv3aLr/wziR4GokIHygfERpUN+MAEyu6LmnzC0pjhKBiFQJX36+GFrzEEiklW2R1AjSKm31EkocILw3vZajBIF8NvZhONLKXLtQC46JgcNQ8D5T27oWXfjD2+1hchC0IrLd5KO+z18lJBNAi0=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4096.namprd10.prod.outlook.com (2603:10b6:208:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Fri, 20 Aug
 2021 08:53:16 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Fri, 20 Aug 2021
 08:53:16 +0000
Subject: Re: [PATCH RFC 2/3] btrfs: consolidate device_list_mutex in
 prepare_sprout to its parent
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1629396187.git.anand.jain@oracle.com>
 <8b8e72c87d0ee97da1b2e243a24b68d84d0ac3b9.1629396187.git.anand.jain@oracle.com>
 <y28weeg4.fsf@damenly.su>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <4b891418-b8d1-6e3f-ae71-b1dface98ae2@oracle.com>
Date:   Fri, 20 Aug 2021 16:53:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <y28weeg4.fsf@damenly.su>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0088.apcprd06.prod.outlook.com
 (2603:1096:3:14::14) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0088.apcprd06.prod.outlook.com (2603:1096:3:14::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 08:53:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ff2e330-52b3-4742-912e-08d963b7f355
X-MS-TrafficTypeDiagnostic: MN2PR10MB4096:
X-Microsoft-Antispam-PRVS: <MN2PR10MB40961A4FE96043479F25E52BE5C19@MN2PR10MB4096.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3HjD3yNzRM4lJDJoq5p5Ksq8MBgb3EsZhtn/OdVsW07nghp5TIHkdLHyvpy6wkhO4+AEzxdd2fpXignvNgkNL7ypBNuXp+CJaTkk4fEUBQtDokyBpeR5ConnKA6YZUCheGM0Vyrd5kxWfAgoikB65nXcoHyHupSyaNfYDIu3yGVlPvR3wJw0ITZx/8jeSUXgRIIa0CHa3di8qIZIeDEv3bqxjC7XPB+K72N+liXVr2vb5n268ye6mNvOyWLq8VKFdpByDTmBK6nyNCYNQFTJ276ETiSjDQRFjuoVFX/tmg2+0kimhb0IYhq6uK1Jfroh24ZqmdoYtMwzGAv5imO3tRlqEY+WDQ7pC8l9LMHTVaw4BgRA+hM6bWlu/p69s8XbC9MwLB/U6Xbqw3g00oX8Wwbu05wmBJu/rdHgEf7XcuxueD4W1bKxdXvREMMsSs1arBtE9YNQQJGmacVh5RYRS2aahPxJC3etoWnJLeftfjIIHpBjr7Oii5HiEs+LzXop/pSvGoFbpdmjNyZDK2sJ0tqDXbhoOFv/6xyIZRqfLT+IUQKHeFBTlU5BKTh03fXYDBRLG0TiqflAS/Hs33utqyTaTdqv0S+0HWXTL54XRs6neqddc6koAHWtGctDHAQj89+QJPdBhh2Pe4oFreNhxay+EFh/gGcOTZ6zG/W+86YSYybZUB7N4c3Cxu467YW8Tr6/mvT2gNyi3xcu3+pq5IPtJtTEGvUJfTlYampIo9mqldR7A9SN/zLtYVWoiAZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(39860400002)(366004)(136003)(36756003)(2906002)(316002)(83380400001)(31686004)(4744005)(16576012)(8676002)(6916009)(8936002)(86362001)(31696002)(956004)(6666004)(38100700002)(478600001)(186003)(66476007)(26005)(66556008)(2616005)(66946007)(6486002)(44832011)(5660300002)(4326008)(781001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU50bWhJNjhtbGhBNzJ5a3pydC9NZlVmaEVqN2svTkMrak1KTUdXc2RPTXRD?=
 =?utf-8?B?UFdOTGxIcFNTTU9MRDgrRUcrcnVLWUFuRFFvZWtreS9vbmY3aFRQeGNWOUNi?=
 =?utf-8?B?K3ZLbFRDSnN1VnJkMzN1NzRqMG1Hc0p5c3Y0SEdGczhReHJWZW1MNG56VjB1?=
 =?utf-8?B?T1Bid0wzOUdES01yV0ZidlZNSlF1Tzg0TnBuZnI1WmFXcjJtcktEQVB5NFBm?=
 =?utf-8?B?c3o0bm1uRkhrajBvSDJ5WFI4elNoMmFOL3RJVm5TWEIyVnVSelFXTTJhUEZi?=
 =?utf-8?B?dVl1ZGFvU2ZHTk5McC9NQUlDcG1rc2Yyd0lKMkJvOGxsd1N5U1ZOdytkMmJ6?=
 =?utf-8?B?SGpjUlpGVHhCTU5qdHc3bi9nYkIrcGpHU1R2bXZPbDFaSmJlMGdNTEdKcTBy?=
 =?utf-8?B?VkhOU1Vwa3gxUDBuSzh0V1FCb3RITVppVWtqVWRXTytJQWhySDZwaE9xZUE3?=
 =?utf-8?B?REZzdmNQL3pJd2lxZ3gxWnZvNDB5WVM2RDhiU3ZBUVlOOUdMdGtnY3V0UWVI?=
 =?utf-8?B?ZEYvcnc0T3A0SzR5STRXT2ppSXI4WTVxVnN2aUQwNkYwbjh6REpRc1BuRjF5?=
 =?utf-8?B?YlNOeXdpUHF5L3B3M013YlFtc3pQQm5UdkgrRSt5TVRueUIvV1ZMRkMzNTFv?=
 =?utf-8?B?bFJPVlIzaU1aUkVHUkJ5aUk2emh4Y3MzbDZYelA3eFppbDBMTUtYLzNBcDgy?=
 =?utf-8?B?QVd5OUZmbEpqTlV1aThuSTBURitSbk9DallWM3lzL0RhYW1iVjRkUEhhL1R6?=
 =?utf-8?B?ZjdzSjdobzloaEpRNkRZU3VmMCtmYmdrcVk2RmZNbzRTaTI3UDdwQU5pWlV4?=
 =?utf-8?B?WXZiNmRkN1JMbXp0aEd0Mzdtb1VKZ29Fc3JTVnZRQW1nN2xMS3JWQUk5Q2Rz?=
 =?utf-8?B?SER3WXMyME8zallpSE5ScllrdkZHdk9ZeVE3dTdLMDJJWlBwVFdOT1JpTTZk?=
 =?utf-8?B?aHhoUUFkb2tqM1drSmI4R2FnRTVsUjJ3WXBteFdpZTd2QWNlOWlBNUM2dExT?=
 =?utf-8?B?aFdHWkpadEFVNkM3V0NuNmRYcHlnbFB3WE1hNTBVcFJ4Mjk4akZVSFNraWNG?=
 =?utf-8?B?QXpsbHpLSDdqQjFjQWhESmNQZHZQV0dORGR2TDlVakRXMkFDeWtPejM1MlJl?=
 =?utf-8?B?Qk5RZFBMNGVmM1VybU1FcW9TRVd5RXpIaUk4M3Q4MW0wMTRrWnZyNGVFeFFo?=
 =?utf-8?B?SWUvcVBGbGZ5NEMxM1UwRENXOUdScFpwL3FzUGVsQ0pCU3liQnJ3S0QxK1ds?=
 =?utf-8?B?bGFRV1VnNnpIOGR1NU12L0lGdm54UWJMS21yZndUVUpxUlI4VGE1V0d4bFdB?=
 =?utf-8?B?blVJV2dueGZjZjRmRXRLOWhSdEgwbU0vMGVRcCtEWWxReXNoY21FaThZTFZx?=
 =?utf-8?B?ckxLZW5qRGFiZ3VUb21hV2hwWEZ5bXRhNW0xNVBYa2lwWHpReGxzQmFVQks2?=
 =?utf-8?B?TWJPZ3pBdi94OWp1MHB3blFrV2E2dEJvQ09nQkJTeldPNGhDdUxmK2VPZ05L?=
 =?utf-8?B?eC9LRitDS2s2djR4aE15czdveWIvM3JGTzJoSnVTN29SVkNJZE9xVGhIeXlh?=
 =?utf-8?B?R1NIbjZ6ek9HYXlKZzdndnA2Tmk0Q0txandaN2tBVzQ1NWVoT3JFb281cHow?=
 =?utf-8?B?MStPbjFHRmlWbGNUQjdGbXVpVk1rVmNGRWt5VVRrYzBGY2JuTjN0MEFoWkZT?=
 =?utf-8?B?YmFtV0pySXR5M3VvS0VVY3d0TW5hd3JLNTVmMzFGN3VDb21USXpkZGFXd3dI?=
 =?utf-8?Q?pc9pQZ9LdY8ZHd+JFSCbuvxWZvZKG3fCDg3JNYw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff2e330-52b3-4742-912e-08d963b7f355
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 08:53:16.4283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDKHMDwInY504SsAjqpP5Kf0dWtG34iaqmZJazCnPBGn13SgzWN9j2itUGP0H2TwFRlQCXi9LcKgQr+egvniFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4096
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108200050
X-Proofpoint-GUID: njcXnncX6I4w-pOEyG7-AaPGKt7dbd_L
X-Proofpoint-ORIG-GUID: njcXnncX6I4w-pOEyG7-AaPGKt7dbd_L
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



>> @@ -2366,6 +2366,8 @@ static int btrfs_prepare_sprout(struct 
>> btrfs_fs_info *fs_info)
>>      u64 super_flags;
>>
>>      lockdep_assert_held(&uuid_mutex);
>> +    lockdep_assert_held(&fs_devices->device_list_mutex);
>> +
>>
> Just a reminder: clone_fs_devices() still takes the mutex in misc-next.
   As I am checking clone_fs_devices() does not take any lock.
  Could you pls recheck?


>> @@ -2588,6 +2588,7 @@ int btrfs_init_new_device(struct btrfs_fs_info 
>> *fs_info, const char *device_path
>>      device->dev_stats_valid = 1;
>>      set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
>>
>> +    mutex_lock(&fs_devices->device_list_mutex);
>>      if (seeding_dev) {
>>          btrfs_clear_sb_rdonly(sb);
>>          ret = btrfs_prepare_sprout(fs_info);
>>
> the erorr case:
> if (ret) {
>     mutex_unlock(&fs_devices->device_list_mutex);
>     ...
> }

  Right. I missed it will fix.

Thanks.
