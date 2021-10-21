Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633724359B5
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 06:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhJUEGR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 00:06:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47548 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229499AbhJUEGR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 00:06:17 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19L3pf2Z025822;
        Thu, 21 Oct 2021 04:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : cc : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ZZqyUUosUIUi9v0arpGFaayDjjFYOKJIbWjlsGvSDa4=;
 b=iZScvMQkynf7Nplfl8T6hm/w/qCOxYsOq5lzj/pISKmeAdsaNTQm44mNcPpJDOQykps5
 11IBM8jOQeKDv4WzEkpgYfGoPh0ObmG5scPRzJ5HunZrMj+qADhlCDywqBtOYFPvLaGB
 HO0M7mHF3k1r4w8IG3X1eSNMYQnZQxHGn/VQ3j+0hx0e70jQDKrwLSxxu3MWHZW9x0ES
 XT1BypXeEKAjiXdXJlmZDnds215rEdcoTGMUadKiTLXmHUOHf3IoOKL0NMQItmKXVKFB
 ISDhMC/fxSRoLf+DVJdFNKkbRBl3EsvQcT/bnNF3p2t1+jRAWhWVhyLyOxos4qzjQNu6 og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btrfm2ave-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 04:03:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19L41c0E043449;
        Thu, 21 Oct 2021 04:03:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3030.oracle.com with ESMTP id 3bqkv14vg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 04:03:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHkKVVyHOB2vnIbwyRqygAH59P5hOmKtIGqhjGvrXj3gt7QZsQ9E853KkGHDLPdIh4mVCRxRS9YRsu4lsNdgLR+4fOS1gBUTc/3XfVl84pg9kvpFAWKR/bbKSruFplcj3Sn70KenueyxYZ0Bpel+iq5kvAijihml03o4ptgZGHWOmT1pMkQ0D49I51NiRiTa/ugKbBD8SB4c0pM4a7lcuBO1+93zLQpDyeT4i5yT+Ru6EmzRbqVvuhAcng427Rz4lU23YP3y0MvOZr6gLzHAZuaGTJqBtNC7JqZWfia7h7kWRa7m92MvkGs8z7voOwLGVtAfWa2bq7syfHQKd9Rlwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZqyUUosUIUi9v0arpGFaayDjjFYOKJIbWjlsGvSDa4=;
 b=OsB45mgejkg7AqnqiWFaIX/SDfRMNxfMXr6emz8n7iCaHTZKoDjPms4f5wrFGIvfTJBcWCv8snpMoFEo4vGI8rcMzqngDN/OO69eoVX6BpA14LZpi96pPeT63Sxryp10PPr258uUMshdAEwYXrsdP0lV9yf8v2B125Ncy3pgeWj/8vT1trNRBDLlkOpGZBXLpGSsevTj0QiMyhgoaBnGyAvZ4d+5YWwHv2ujHzOJyfLvq7s4FJzFfFj5LUzH6IucZzpJJNG39ozuuq6TT0Xgq/0LE+VzrrEjQyitecPM+KuWfC6ftBd6w/55q8Y+KNb78wUQwVQuvfMWJTBCu9l32w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZqyUUosUIUi9v0arpGFaayDjjFYOKJIbWjlsGvSDa4=;
 b=YPzSsT1VoeSjmOUDirxJy49yurf7qLMxafEhRThHj58nsTPWVXsjNfSvLRrFoYjj+x6jZhj7O71JL4JrrPpjb2uDrKFTYhQU6vpwFR6MWduvggmS4XOTtPGKe71zIuW6NtFqYchK09bUd6VenLsckTC7WeApObofA1CHk9++9TM=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3903.namprd10.prod.outlook.com (2603:10b6:208:181::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 04:03:54 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 04:03:53 +0000
Message-ID: <12503a1b-a28f-cc26-f07d-0914d6952207@oracle.com>
Date:   Thu, 21 Oct 2021 12:03:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] btrfs: sysfs add devinfo/fsid to retrieve fsid from
 the device
Content-Language: en-US
To:     dsterba@suse.cz
References: <cover.1634598572.git.anand.jain@oracle.com>
 <7df68f272490c55349b44a33dd7ac19ccf87560f.1634598572.git.anand.jain@oracle.com>
 <20211020185929.GC30611@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
In-Reply-To: <20211020185929.GC30611@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SI2PR02CA0045.apcprd02.prod.outlook.com (2603:1096:4:196::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 04:03:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fecd0c7b-4cba-4df4-c881-08d99447cc16
X-MS-TrafficTypeDiagnostic: MN2PR10MB3903:
X-Microsoft-Antispam-PRVS: <MN2PR10MB39034CE81B765AE01861BFDCE5BF9@MN2PR10MB3903.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iwBuB6Us824qpYuSWZJEY085A/O9+XFoHATwRw+OEU08mo8FDoQNIekAt7jG4IuI9RLDJL77EQDhVn7GjqiF6YgaunRtwbTznTUo0pCETe+FPZ2rktFYUP0GpUGVlsUyBuUnNt4l3UUugPBtbB66XN3MO3jgj2cCH1LHhyBQt8tWM18KqUxCxueZ6UDrSifkDEfkXXJVypS5zW5d1ua94zrZU0NEIKZk9Ej/R8oGmgXDy3QS3Yr1vi5O8YbZar/Pf+tAyPCPOeY1u9TDuobnkGn+Zuu+uznpxYzhtRvEOqSzt4CYVs/P811YiO5t7OAUfURrvnt92AshiGpPe08pCOO7HtaiHaiC27DnEZJcFSitMbADOgInDGDlF41DaP01Id5BVm9NKKWimUCRgSfu1VR264P0ppiZ/9xfaDzyDzBGhcqmj88tf+aHwxQw411p1DS1E1RZcDaHFaaBoL5eGuNPqloXIrthRAVHNTkdGmFrpgjC1AMf6GHNhhrl8rgSacEKqdqafadTzOc1/eKEiwBkO7I/YegfFrISyKW4Nu34Z4/4wqsJgUkBMSfkjQH53QUYcjh2c05g0jmSbLlCmppEnGRYON6zBpzaOiE2tGjFnPhfyg3EF4EQy6xCqrcReVMGDtCeRFpm507QKUNaCMQRjpsnCfwC5OC+NgxN/2HfOKGrKnoRAMGtirfzbGmw/Wiwj5UfCm8LY0gDeHr6uySeDSAUapQHkuxCEWI3z7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(2906002)(16576012)(66476007)(6486002)(956004)(2616005)(4326008)(6916009)(86362001)(31696002)(66556008)(8936002)(8676002)(31686004)(44832011)(6666004)(36756003)(186003)(66946007)(38100700002)(83380400001)(26005)(316002)(508600001)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ditITzRXUzJtRSszWVhPbHB6N1cvQlIzbmhEd1MyTk5vZVFJbDZCcVhxbm9s?=
 =?utf-8?B?ZUM1ZC93TWhrWlBtdUZMU2hUUmZ4Mm9LWmhBTWxDMjhhbGF3bHFGcEZ1Yldj?=
 =?utf-8?B?TWQvYWVtSURtVW9JMEZ6RTc4U2x3a1VHemVMbHd2UlFreG4zaGhUWWZsWnpo?=
 =?utf-8?B?T1ZZbEduTHg4bVRsWHMrV2o1Z0V5V2VvVlJxamhYSHdQMmljd0FnMXdHS2Rl?=
 =?utf-8?B?WmlUVjE0QVFSUktSZkFVNzVycWMydWJQQWNlOVlXTUw2dE4yMm9jRmxNN0Q1?=
 =?utf-8?B?Vi85MXFBS3h1VUJZVEJPREIrc1hvVEJHUUsvZDYwbWg2NW9PMXNXV2srNkpl?=
 =?utf-8?B?U0VvNHhEbE8zSlltTldUNnJ6MmRYbWdIUmZYYXhIbFNZYXQ1eEFtMmZleTVS?=
 =?utf-8?B?TmU5d1p3VnllL3B5Y3NDMFlJNG4ybHl2WmZnRWNvYXZ0c2RTWTFLMGpjWVUx?=
 =?utf-8?B?cmpYWEtjR2NaVThUeEpDLzgzR2gzVXp6akl2Wk1GNTF4ZVBFalBrNVpReFBj?=
 =?utf-8?B?VjlQbmZDREdpbU9vNWxyOUwxSmtIV2lCTHpPM0NaK25URERqditvSi9idVVT?=
 =?utf-8?B?WU91eXVhMGhVeFBmbkFvd0Z2OWFNRjIrRDZoYUppcXdvaVFFQUx3QWNIT1Vi?=
 =?utf-8?B?SCtHNDNkemlUNTJ3bkJLTTNuYkNxdlBlUXR4ZFdhaURwWmhnSlVLSTdHekI3?=
 =?utf-8?B?aXppOGJHeFJ4RDJOa0wrbWN1bW1ZUEdXaXNJYmJtSCtUb09kWTVNdDJNakRO?=
 =?utf-8?B?VlpTWUhzWmdEZ3hEaDM4YkhtMlF0MnZCUHRCQURQSG8yRHp5WEM4eWliZFNp?=
 =?utf-8?B?R3ZYRlBCRkU3czBDYmdKd3FNdWN4RnQyMFByV2xaNDhvSFpJSjNDNHhsZGZx?=
 =?utf-8?B?RGlONC8wd3pXb0V1SFZLVG01VlkwdXAyNkRtaS8wNk9yWUdTRjFsV3VkUWJ2?=
 =?utf-8?B?aVVaUmlENzZubVFxSFVkdG9maHR0Ujd3UUNDUy9PaU9XQjdsbWFzcVVKSTJ1?=
 =?utf-8?B?SlJ0ZlEwdnB0Z21yMGh2WmZNdDNLUXlSZnBtdnZoU1NQWVd4dTlIWFpSNjV0?=
 =?utf-8?B?cU5RRXVUa0NudXBFQWFYR1J2TlZ4b2xKcEhlbHVSL01oY20yWmVpNG5jQ2ZP?=
 =?utf-8?B?bW1FK3pxL21GLzZsWmtSZVhudGplbGdwMURuVytiTWI3N3loV3IweHpEL2Jh?=
 =?utf-8?B?Y0FoYnNSWGhxZ2tYRUQyb24wVnl2RHlVK3NTSFhMVTFlQllxYm1CbEJrUlZM?=
 =?utf-8?B?Sk1KL3E2U3crdEJlcVoyeUZRWnVrN2NMQlZHZDZ5YzEvQUg1Q3g4TjU5RVRB?=
 =?utf-8?B?VFJrZkk1dTh3eWZvL3prMmtVbEVsSkpBeFBOdFJTamJZcWg4U0VCUUVMWE43?=
 =?utf-8?B?TzJKV3VxTldROTEvYm83TFIzREJMVGpITFF1enVoZk95S1VIa0FRdXMxb1BS?=
 =?utf-8?B?aXMyS0VnUlM3d3BpekVUdWNic3kveHpkUGlhSmhKV3A5L1QrNERzRjhMb2tY?=
 =?utf-8?B?VnlFb3pPTjVNOUN1bk5vVDdnQXhWSlVIc012NE9oOTV6MHBpZU1ic3Q5L1Bl?=
 =?utf-8?B?WGczZ01ZSGZYdkVuWWtwajl6b1dtYXRaNWpMRUpWTXZIZ0JFbWJOUFJwSmhI?=
 =?utf-8?B?cnRmUlNJTlpPSUF1L2pMUnZrZVB4Mzl4VjZwVW9lajczRGZmeiswTmV5RXNm?=
 =?utf-8?B?bWJTejBERkVDVDh2T0Z1ci82alhZejZKMm1jeXhsTHdyUDZNeHFJK0twbzdS?=
 =?utf-8?Q?Caqfobl+GqtmatUvHskwcENj8sLUnxSFWGO1HVw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fecd0c7b-4cba-4df4-c881-08d99447cc16
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 04:03:53.8633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3903
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210016
X-Proofpoint-GUID: ClY6QLc0DtKey9mPRWRjp0q8xyVErHNM
X-Proofpoint-ORIG-GUID: ClY6QLc0DtKey9mPRWRjp0q8xyVErHNM
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/10/2021 02:59, David Sterba wrote:
> On Tue, Oct 19, 2021 at 08:22:10AM +0800, Anand Jain wrote:
>> In the case of the seed device, the fsid can be different from the mounted
>> sprout fsid.  The userland has to read the device superblock to know the
>> fsid but, that idea fails if the device is missing. So add a sysfs
>> interface devinfo/<devid>/fsid to show the fsid of the device.
>>
>> For example:
>>   $ cd /sys/fs/btrfs/b10b02a5-f9de-4276-b9e8-2bfd09a578a8
>>
>>   $ cat devinfo/1/fsid
>>   c44d771f-639d-4df3-99ec-5bc7ad2af93b
>>   $ cat  devinfo/3/fsid
>>   b10b02a5-f9de-4276-b9e8-2bfd09a578a8
> 
> How do you create such setup? I can't reproduce it.
> 
> The simplest seeding:
> 
>    mkfs.btrfs /dev/sdx
>    btrfstune -S 1 /dev/sdx
>    mount /dev/sdx mnt
>    ... the device has the same FSID as is the sysfs directory name
> 
> With a new device and removed the seeding one:
> 
>    btrfs device add /dev/sdy mnt

At this step, we generate a new fsid for the writeable FS. Let's call
it sprout-fsid. (If you check the sys-fs fsid, you will have two fsid
here).

Also, at this step,
the
     fs_info->fs_devices->fsid
changes from seed-fsid to the sprout-fsid.
So, we should make the <mnt> also a writeable without the need to call
'remount,rw' explicitly IMO. What do you think?

>    mount -o remount,rw mnt
>    btrfs device delete /dev/sdx mnt
>    ... both devices have the same fsid as well 


Thanks, Anand




