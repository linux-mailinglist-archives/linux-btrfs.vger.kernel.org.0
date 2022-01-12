Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2B448BD97
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jan 2022 04:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349005AbiALDS1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 22:18:27 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8398 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348321AbiALDS0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 22:18:26 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BMQUCB019138;
        Wed, 12 Jan 2022 03:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zpxCWEqGExbeg3JKZYN7qvHG5L+0kd+tdlbTuywKVmU=;
 b=HiiGXtZv80JFL1KgRduB4ezwl4oXtwR8ZXEFxm7yMYM6xl1LJ1AMXuIvs91XLzN1KaNz
 6rvP+7MJN43XbTpIh+h4pwYLMhp5q73aCjtJ3NfpvWdtRQ5sBaxQ60e7vUHJXUV19MuN
 0zAvtECDVi36enTdZZ1ioFbWeJeSoM65HjMEdKq493RtcsmLA0aYSD7bmEqRQFWnbe52
 Ticj73HV7NQ2wX2303/LV3mgzH/0+izLZ8Stu00UjJJzWgyVVqNAtALnfo6SGN1TS8Je
 6k2CkouxVI8a5tJ5N5+MSh5K1UK/4BIr4Ao1hXVTkP3U8DauGQyddX2XcbGRQI9scCPN 2A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7nmtqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 03:18:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20C3A16H094122;
        Wed, 12 Jan 2022 03:18:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3020.oracle.com with ESMTP id 3df2e5npg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 03:18:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqAxAnqrY74ZX7wlnrvpXcH6WF2M6nKkM0j+Fs7h/lzrSR8LnRSW72z4f8xFmOkVKKGzDDymynHhFEdQIDaTC1K5wlV9p1QmSafx9OiJF5Oh1gKkoU4V5IlONUTwdfpQsKFYCQDXmkn8iGiDEck5ZJG1WQUgUWTzhGA8TNbojO8pOIDKnS2HnAFsyTwg5u2/9VrnQNJ3W+KzygS/Lup5qPAepf+iFfCor5VXuYHj7+8BYmKy23QxTs1V5JN/SRUAoavw/AdncA9qIYnSHe9NIUMS0uE/Rk6RvDe4fSeC8PgmMvOLuBTAkIxbFgxRAszHniXpE8RmiJC0GLrDCotTmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpxCWEqGExbeg3JKZYN7qvHG5L+0kd+tdlbTuywKVmU=;
 b=RtKNU3exRiIfRwWyao6SgKMYFKv1KsGmXFpgeD7IR8f0DQWTWp+ciYcEqB3XQ+JKNmOQGN7N04Qt1iekb7+GM1QVfw2LXDdMCaZqcDPI7u6XmsOO6TQt4lw93I8ZiDmHP6WeKTN2O/ZGDvHOpLYC6oBcIIlQsZEv99zHapDb0PUd/uH4uwBPJDpgqawQ1na1yBuLe3323gwiw3L2cnKhB4sB4WnDI7uqp/cWyE3k0t1O6LujTHRy/xZB0uW9e1bKkKJqL0dfISbJVQuwgRFw3SWxpFowZqOxMPhk79WP/gs8HeDxAYKOFUHOsps+hWyocBWTujDDoEYm8WKaA0dO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpxCWEqGExbeg3JKZYN7qvHG5L+0kd+tdlbTuywKVmU=;
 b=wTpyLdY9ujOEnmZsOfAqBIkWyTG+DI4Z8gKSwzy66idfRuN0WKwRkAtzaBm0MjABWhnE/4rJ5nFkl97Tsc1+EBDB8FEY64Ge1jYMfMR9rBLcBizOU0l4tb/QpJPbDfslHnPN11mYOsMTEQ4uVYBlPub+eO+R6zM9rPFuypJUZK4=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2994.namprd10.prod.outlook.com (2603:10b6:208:72::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 12 Jan
 2022 03:18:09 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 03:18:09 +0000
Message-ID: <324c7f27-05ee-c4bb-49a7-08c06a356b1c@oracle.com>
Date:   Wed, 12 Jan 2022 11:17:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4 3/4] btrfs: add device major-minor info in the struct
 btrfs_device
Content-Language: en-US
To:     kreijack@inwind.it, linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, nborisov@suse.com,
        l@damenly.su
References: <cover.1641794058.git.anand.jain@oracle.com>
 <9dca55580c33938776b9024cc116f9f6913a65cf.1641794058.git.anand.jain@oracle.com>
 <03c7c3d2-5abe-0087-90d9-698c77a98fc4@libero.it>
 <ebd02efc-0ff0-0954-a7e6-308757d70e49@oracle.com>
 <f8d4c133-e76b-656f-9c13-174a79298a92@inwind.it>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <f8d4c133-e76b-656f-9c13-174a79298a92@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94fd8b49-545c-4164-8368-08d9d57a2890
X-MS-TrafficTypeDiagnostic: BL0PR10MB2994:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB299447825D1A780DB5EF2C02E5529@BL0PR10MB2994.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tZSrtyOximop3Rt/ilCqm8rawTQp0D0VVLPRezwJh4erSp4uwkbtQZYnsBQYx6axNEw5kFwIkFL0JGgMAAOZ3Jx+yNANHx4GiNKyr6f/lKLxlPjfK5RbNi3T4xUh9PwbT+RAS9YvKIfPwNLxxTBf939j7UKVYwk3lITt9v/by4VMac2ofuehAYtztDQ41T3wl75ffnpOKvLoJ/dIM/i0mH6z6NWfxgDj5+TL5UyVztVfkFZ16zCe+iRiv4x50CfLgshwj5Iy+iFO/APaHZ5gXhH2mDoAKV33PH948DVMKtC++VUIdAGNN/km7wXotU4yGvDtwyXyxzrABDmbv7MOCqrdFKFPevoPUEpy3FchlibcNsIPgm6M8LKXmQy3q0lYtN7z1QGw+C6P/pv8wFWUa4X2lBnhLGXJlZefPgBqx7Yoi7nCbwh/3hanBC3SFkbEFwL/YGc3fNy19gI6fStnaqSLKeDZWJRWw36J7SP5YI1fX4iuuKvrUykbYTJoFvas2OzxykQDHbtX3LLwS4GAQ/obDBmEBKyUrsCwntR7Y5rDL8R5+pGgbM6H19OGeOtB1rSp42Ml1M/vK7PnvS6EGwmfdWIplvLNFcw2C3DmwL+39LChwXQZ2zmXbnw5FxnJcd/ZRyhvyoBUd43HtkVVxGCSPOjkaCvTeqKnQD5CO7tDR7bZQAHxBAzjoEJUkrfuN15esCTidvNGmZKGYMGgEcP54p11pxmF97q/7zDy8fc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(508600001)(31686004)(4326008)(6512007)(31696002)(44832011)(38100700002)(66556008)(8676002)(6666004)(186003)(6486002)(2616005)(66946007)(83380400001)(36756003)(8936002)(316002)(86362001)(6506007)(53546011)(5660300002)(66476007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlFERE5WTG5tSkFCL1FRcnREWTBiS0JsRUk3ZmVPY0tacGFiQnZaeXp6Sjhv?=
 =?utf-8?B?NWZFNlB3RFJLb1Z0c1FJWG9sdm4yS0s1aFNkTlNQRTEwOS8xN2d1Y1hYY1cz?=
 =?utf-8?B?bDJXeGw5blJ4cGtCaFFjR1hxNDlaTlZaQTUzdEU3OU9BaTR2eXVjZDBhU29l?=
 =?utf-8?B?RmZCbzhuWlYvR3R3TFRoRENJVGVUV2pjaW1OUUpYdTIzdTlENEsya1R6N3V3?=
 =?utf-8?B?TVYwTmM3YnA0c1NQZ0ptOGd6d1F2OVA2VGM4aFlKbnNJNGVIZnNXNktqeEZh?=
 =?utf-8?B?eEpuRjkwZFlua0NadndyRURKZW52VU5hNVhpaklvVjF2SXNtYk8rdUV0SGtm?=
 =?utf-8?B?Y3VnTzA0YzhBWEZNcE9NeWh6TGdvaXhZUDBrQXhnUERnbXZGQi9wVHFMTy8w?=
 =?utf-8?B?TTB4M2ZSYlZJcmtVUXdmdlB3OE9IeHNVSm10RVFHbGJVVlRNbkEwSVhmTGNl?=
 =?utf-8?B?ZHVzWGhSYyt3anNpQzluNDhHUng1S2V6eEw1WFFxRElMeE5McXBqSGdvOFR1?=
 =?utf-8?B?cUhlbXJFeFJ6YVdzSlhQL3BhOW4xVUdqd1dxVlVjeFZvclRHY29BalFoK0ZT?=
 =?utf-8?B?cWtDZnJnNTVWRU1hUEM1Q3g1VkZVNmxOMkthT2phTmowc1pOMnRjSXFxVUVT?=
 =?utf-8?B?NktQeTlSbDY1ekVSZ20wVHBwWUU1VHNpM3I2bDBLMHc0TkFPYjl5THhDcGNi?=
 =?utf-8?B?ZzU3ZjZhRllxbXJieGRQZ2xRQjhIOGRzS1VUS1hJN2JPdVEvYW52VUovSGR1?=
 =?utf-8?B?R2NqeHRIZ3MyMkZUcVVXZ014dzJRWlNickFzQ2hzeHBuWjFGNS8yejVSRG5a?=
 =?utf-8?B?WW80bXhlQUhVWFhNamNkTGg2SmVrUWVmUDZPd0xRajQrN2hmL0JqWXRKSHZy?=
 =?utf-8?B?QlVNcExKaEhLejl0dEtqNDRVcVlxemcxL1NTbE9qeHNnb0hvWFRmcXZ5c3Rm?=
 =?utf-8?B?L0hqV2tIYnJuWGxXNkx6TjBTd21ORGxjNlZVamdKbHB3bmpYaHBHeWlScGM5?=
 =?utf-8?B?OUxCa0xGWWh6SDFEaEJGQ0h5bSttSzVhMU04a1FrbTIzanMyWjFuL3E1VE5Z?=
 =?utf-8?B?Tkd2Y3ZhRXloUVU0K2EwSkNlMVdJWkU4NVdiMVM3and0V1dkalR5TnMvT1Fm?=
 =?utf-8?B?UWs2QWpnVjBLRVdFR3hJYzJ6WkFzWWxZaEMxY0NNQlA3ck1tSTE4Z0FlQS91?=
 =?utf-8?B?VWxKL2ZwOEFJQXBnL3ZsZCs4Yk5INUsxK2NxMCtnWWU0SGNoUjdLUEtpT0V2?=
 =?utf-8?B?TS9wclpwT3pvUnEwdFlsSVVwNW16c2h4RUZtKzBuV0FwTDF0SEduU0FJRlo0?=
 =?utf-8?B?dEc1QXJBak5DT2VNNGs4V0VzaHgzTFlxNUo1K05ZdktHK1Njbng2QzBDZU9T?=
 =?utf-8?B?KzN1bE5qay9VcTBZTnhMY0hFaGk5YWFYWit5NUlCWWJEdVloRjI1YnlLWDVi?=
 =?utf-8?B?M3kzbWp6c24zQW1NSUF0cm0vclkvMUx6Z0FWc2kxajM5NStMKzdBdnVMNHRM?=
 =?utf-8?B?bDc0OWdvbDc1K29sV3lmU21JT0FBMDZRekRIV0dnSVl5MWwxVVB5c2VGMmxK?=
 =?utf-8?B?bmxEK1JNY3FCSFZyeEoyMGJyZ1djeTJVZXFDQmhNTHRLZzBLQ1l2QTZ4ZjNO?=
 =?utf-8?B?eStQVWowY05BbmUzbENCSUZSdHNySGF4UGFWTSt3VE9ld1VwRlkrVDdXZTRY?=
 =?utf-8?B?R1ZZUnU2eFRQZmhyTUJPQzJ4eDVjOFlsVDRrRVRPZHhCanUwcXVrYVQvdndk?=
 =?utf-8?B?a0dvVEYyL0hrd2dhaENZUDM4QzRaOGZsR0xFT2V3bzJVWDNzd0tZS1RzVVVF?=
 =?utf-8?B?SVZXK1NmNDQrT1d2Q2J2d1haTktSR0xaSEZCckhUMG9kcklSOXIvYzVyOXdn?=
 =?utf-8?B?dlFrZVIwWE41OEhhZW9HbWFrWC9PeEt4elUzbjBQZHYvZjF4L0wzcUxHWVdL?=
 =?utf-8?B?OGNaM0Nlb21JdlN0QndKVnJ1dkM4UkZYT3QwLzZxOVVBY1AvNkJPd3FhUWFn?=
 =?utf-8?B?ODl2TCtzMThhMTBWVk5KbHNWTkwvM25nUzE5bEp4czZiMlFUN21TdVQySEpk?=
 =?utf-8?B?YzE1R2FwclV1RjdZeEQ3M3FFaDVNbEd5M0diZERicG1HZEVaU3hPSVlGcTNJ?=
 =?utf-8?B?UkdkUlJ4eE9Uc1g1VnY3YnQvTHZ5MFl6SDRaSXRDKzl5bEZRUlprS09CS2Vj?=
 =?utf-8?Q?FJeUCJPR5EkDm+P+JoiVCOY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fd8b49-545c-4164-8368-08d9d57a2890
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 03:18:09.5900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86/ucyFJ+qhTYmlsCr540BuCSmP+amQuddsuf63+ayYaWDoEPVLu93hpBiVUveh38bBsKaMbFzujirXok3++hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2994
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201120016
X-Proofpoint-GUID: 6l62-3HxseC2lcOAzYN7w1X2qEUlsWAb
X-Proofpoint-ORIG-GUID: 6l62-3HxseC2lcOAzYN7w1X2qEUlsWAb
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12/01/2022 01:18, Goffredo Baroncelli wrote:
> On 11/01/2022 06.27, Anand Jain wrote:
>>
>>>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>>>> index 76215de8ce34..ebfe5dc73e26 100644
>>>> --- a/fs/btrfs/volumes.h
>>>> +++ b/fs/btrfs/volumes.h
>>>> @@ -73,6 +73,8 @@ struct btrfs_device {
>>>>       /* the mode sent to blkdev_get */
>>>>       fmode_t mode;
>>>> +    /* Device's major-minor number */
>>>> +    dev_t devt;
>>>
>>> What is the relation between
>>>
>>>      device->devt
>>>
>>> and
>>>
>>>      device->bdev->bd_dev
>>>
>>> ?
>>
>>   Both are same. device->bdev gets an update at the time device open. 
>> Otherwise, it is null.
>>
>>> I assumed that there are situation where there is no a device 
>>> connected to a btrfs_device
>>> structure (e.g. a degraded mounted filesystem where a device is 
>>> missing); in this case
>>> does devt == 0 ?
>>
>>   Even for the missing device we do call add_missing_dev() -> 
>> btrfs_alloc_device() that will ensure devt == 0.
>>
>>> But are there cases where devt != 0 (a device is associated to a 
>>> block device structure) and bdev == NULL ?
>>
>>   It is possible- When we unmount, the btrfs_device continues to exist 
>> and, both device->name and device->devt shall not be NULL/0; However, 
>> device->bdev will be NULL; If the device is scanned again with a 
>> different uuid, then the free_stale_device() is called to check and 
>> free the old/stale struct btrfs_device.
> 
> Ok, I think that this case (where devt!=0 and bdev==NULL) should be 
> inserted as comment in the structure before the devt field.

I will add but, did you find any pitfall for breaking such a case?
Or are you submitting any patch based on this rule?
