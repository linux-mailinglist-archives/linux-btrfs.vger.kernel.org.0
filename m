Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4D942E43F
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Oct 2021 00:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhJNWhO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 18:37:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60976 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230125AbhJNWhN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 18:37:13 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19EL9q7Z022056;
        Thu, 14 Oct 2021 22:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9T53/qgf+gYTQI+rdAYv+AHLpzcywQx/cdB2WzAyftU=;
 b=ydrc8PZ+OGaEqKbnNUb6RcXvSFZpJm4qYgJgDrCS/BDAoc7Ze1AcKkpT14y7E1TMjLXj
 I99eo9ycR3plX+7fVMX+ljv4k6geTsx5VrjGYgHGXoMSxtEQqbE0j67CAtl98A1hTAIi
 ffaKirZojIpUgARJ7FoaOkDZzpK94uegep6Ik9dUOdsC4ITZFeGs4wETW9hQ1zhpYdXP
 PKgwoCj4q9C9t7EkPfTK+1DQMpkzoyZStvSjcVLVfni8sgGmxXajqq/JvUTfwucAgaRy
 pvmt1FYLwoSrPel9fXHF1cK1qYbroP4UYQ9Rew5Lw2TLwAf8d+p1tswYG2Rj+R81lSFd kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bpfvedh63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 22:35:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19EMVFsc160014;
        Thu, 14 Oct 2021 22:35:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by userp3030.oracle.com with ESMTP id 3bkyvdh0nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 22:35:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmSx7rmgcTOONceYmnnqUcoj9MNc4WJGG+25PpTqVm2kPHB4HytzLIDKeD/eCHnFg8duUvCdM2sNqCmUPFbfrcbSa8V7fgwLB26s6OTh9Iio+F9Qc+jbAlANLmi3lFnDdnjg15KCGlLhAzoNd1ioiu9YtGfF+mGhW/IPVnNxqYsYvWTaCoZpIVCj52ItmWxh2kTgMPEkJhpDGs1t8vRBCUvYHKcWxKgg1t4UnUGs6lq6ij/eFbVsLN2HZzcmxfkffHG2k4rgYVTjnE1JM3RgLHoCkdBCI20vxJRi69rMA+Xia7GEitvImONld/+G73sxscKxCLZLIL7T7ngi8rtS/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9T53/qgf+gYTQI+rdAYv+AHLpzcywQx/cdB2WzAyftU=;
 b=d2pxZvYy8WGhYsGkOCYK3gapqeQSj2riLPH4KICsOC4mEmw5d3OsJIoWa1EaSaqCRow3t71jWeQ1zfDzpZLusZv8g4soBXW9hgSSmvRms+sUbGQBj2FFgTo5wFlr35qzzKbwWvLmtw7Zrro1qgj2kKKdPFeQXNDT6wVbPBabfHSRZlX/FUAaPjq8oex+lJgAhid2V8sP8mWUf10RyPWYp4Jl5YAjBTcIo1jVCnGOSlgGCEOvHtrDlsYTtP1EIP1CLf9NAVl8c7EJNEX5NutTqL9OzNO1Y1o/h+xeHEc8lHRolbFELzF32MxcD85Pr/iVPRP7ndhyO3N81QcZRyyXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9T53/qgf+gYTQI+rdAYv+AHLpzcywQx/cdB2WzAyftU=;
 b=vBs+MQECHfSBYVuQOLUTPfkWAjVFoe5aeqyc1o2pukq/lin71gP9tOcZrKD+9WAqHTzmNxOh392bfaQfIWkVKxC1CkM83oZguXJRfpXQcn78XLk7ru7lkzkXG8Hpi9LhP4DeCBOs7iyL+N7gpKMlIJfV+cvLV2TJk0zzjb/DBGg=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4851.namprd10.prod.outlook.com (2603:10b6:208:332::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Thu, 14 Oct
 2021 22:35:00 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4587.026; Thu, 14 Oct 2021
 22:35:00 +0000
Subject: Re: [PATCH v8] btrfs: consolidate device_list_mutex in prepare_sprout
 to its parent
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20211013080137.Bbt1omPCnM-ICZCnqrgjTq-2Rj4YbsM6OCm1MMBtG4o@z>
 <YWhNG9SowUp5nTxz@localhost.localdomain>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <1a168ce1-20b6-aabf-76ae-ea9914264f06@oracle.com>
Date:   Fri, 15 Oct 2021 06:34:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YWhNG9SowUp5nTxz@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SI2PR02CA0040.apcprd02.prod.outlook.com (2603:1096:4:196::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Thu, 14 Oct 2021 22:34:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b4db5e3-2915-4b56-7c55-08d98f62db8a
X-MS-TrafficTypeDiagnostic: BLAPR10MB4851:
X-Microsoft-Antispam-PRVS: <BLAPR10MB48518DD41F09C9DE51AB1C62E5B89@BLAPR10MB4851.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7Dt6JSZ/xy7Sf+hWRvu4U87Of50LBpqU/i+p1z5fNi4/ZQ/btAQWvbAqzWEX3jioQgu2QVdlJ9f/j0Vbnh9CiaipkG3p4OpB3VaL6vUvboO4KkePSZ4KvKPdP4NE/5f0vzz1A9OTvS5SzzxWsblgXnwTrysVsKx3ozXkIQnCese9FSCFJY1V1fKZoEZwRNxD775eCUBirHm0MEuvzcmrrEA5WGQ9vCCE2ejJFQVVI/n96YXmEfSY5EbV6pZHOkdIBganU6oCpLxvN4f73vAZj6quaQpGOyjEfJNkZ8GCkd5+0Lld/snEUShS58uLqLBWBN41GuLfuGIWA85dUu+hQXiJIOX3c9+7NOgxJlRH5ABwREyOjK3uMJrNZ0Q0NMoHOacTSlao6GCBntu63WP8Gl2JURSnL2sRKNSGHXm7I2ZpUfdnuSjj5MbSOtvRGRCAlUACNU4qdtOI2xK7YEQT9q8iSQFpdqnhHqSsgCnhAC7eyw7wTt4ABVmYlAC+sUhZ72zS4HLUjPvz44w5sjLo50z4zR/y/buglicxgBhFslth2mVQ8rAwxsKepgDm4VcnUhUq1Trn/z7ntbDm9gHdNYQ1U7okg2ohBkBqzC3P1EQ/+6fOvFw0oUBeyKuszviBPbH6uRbko6r/3miGHwKePHKwwxayhQRypmtdwR1yD+IH/dIl/0F3kE6zC/+NBA7UW9q+PlLXOdNw5MUrg7AZdtcn1YIzMfi2rASFsRWtww=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(5660300002)(53546011)(38100700002)(66556008)(31686004)(44832011)(6486002)(956004)(36756003)(83380400001)(508600001)(2906002)(4326008)(6916009)(66476007)(8676002)(2616005)(6666004)(31696002)(86362001)(186003)(16576012)(316002)(8936002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RS9qOVVpSXVVNDBSTlBRcWhvSmF1NC9acjJwcXBUYjVheFBwSGxXOGdQdWNL?=
 =?utf-8?B?aXQ0aUJ6TTVsaTdnUVFYb1RwSjlyUDI3L1dQT3JHYzNFaS9jRUxZdHdOWTRZ?=
 =?utf-8?B?aG5IRlRHTS8vdzJ0MjdCN0k5bW5Uc2pzc25zbmlGN1pNSmVWaUxRSUxkTU1N?=
 =?utf-8?B?Q3g4WWdJRk11L2haYnZucFQwejVnRXJpQm5BRmFlRnJRRUtmUllEMUg5NGJY?=
 =?utf-8?B?SWN5Q3hubGxiUVNsSzh1bmZ5L0Y2MXh3dThmS0RFalBEWlFRc3YveHlqQmFs?=
 =?utf-8?B?ekJreFY0eUpGaENEZWJBa0VMbFA1QmRyamhjc3hMMEg1Sk1aKzNlVXlLVy84?=
 =?utf-8?B?TytIRDhkd21ScVBWcVpDRXg1V1ZQVFAzendXeC9PZzMxdUZXUFN0ZXJaaG02?=
 =?utf-8?B?M2Q5dmlQTWxIZ0dzQ3YxRnovdEZyMWJjSGtBM1pYWGZtRVBZUnJSRG9ZS3kr?=
 =?utf-8?B?Zkl6REI1cUpFb0ZUeFBVSGhubSswRm00Q2JwSmlKQmZmT0lsUzM1MVlHa1Vo?=
 =?utf-8?B?K1gvVzR2L2Q4NUJrNEhmMy9sQTByaitpMG5lRlY5U1N4RWtSUm9WK2VyaGlo?=
 =?utf-8?B?b2h5TmVEOWtxMUVCZlo3bG0vRm9XeUVzR1FoMEdWdEM4TTFlZWxpOWVweTE4?=
 =?utf-8?B?UzljQVBOMDQ3RVFwWlV4LzhGUDc3ayt0TUZPUHVTODVSdjhWUEZCc3lEcWdI?=
 =?utf-8?B?RDJEamJvT1BEUE5YVkpFeVg3cmtDdzR2OEh4ZVdPMWZlWSt6bTR4QS9FRTdO?=
 =?utf-8?B?MWdMRWcxdzVxcHNIL3hJeWdWN0t4bUMvTlpOM3ZFbVNtcFpha3dLWmx4WG1m?=
 =?utf-8?B?blh1SjZFajBobU02TTBSTkorMTZubnF5ZXM1YkVyaHlqUExYaFpaL2JqUEVQ?=
 =?utf-8?B?VEd0SkVLdmxuYm1oN3QrUjhvL2ZSK1hBazl3VngxUVBDNTVMSEF0REVGdFlt?=
 =?utf-8?B?c2hVSUVVMElLY2tDYUhsTmI5VHdLWWJ5bUpMb0ZxWjB1YjlHbWtMNXorcW5j?=
 =?utf-8?B?amJ3UG1HZkxjNzQ0ZFNwUjFyNHkrN2dETTBkT2dPY0xleVR0NVB3VXZHbVlo?=
 =?utf-8?B?Rzk2Mm50RXpqT0hId2hMNHNQUlVTSEdRc2RBKzczUDFGV1ZKWXRreTVtMlZG?=
 =?utf-8?B?L25QSWxGck8zYlRiNWlYa1dEbU02N1ptdnpwS1I3L1lCZ3dpTWFKMURIcEgv?=
 =?utf-8?B?bUpSYzM1cWpOZFhESXpENlF2TTZNRFhyZ1ZjT24vY2RmTkZWTURyZG9wZjlG?=
 =?utf-8?B?MDJpbzJVd0ljTHovUUkzejBtSkFsSGFMQVZmeks0YklFd1c1Y3Q4WTE1RDEx?=
 =?utf-8?B?eWV2K201YUQzNGpOMlREMVUreEI0ZDRnZVFEQXlXUmlyS2M2dlB5c3B2Tlpy?=
 =?utf-8?B?dDM3dkpHOVJxcDZTTnVYTWViMFJPbXU0bHo1TXhCT1hwRFFMRXJZNXMyYlVY?=
 =?utf-8?B?Q3FtZ3R1N0IyRzZKTDhmazFwZTRFVFF1a0oyRnlRYm9VNmthT3o1NlJtZmpu?=
 =?utf-8?B?Y0tCWEc3WldVM0hTeVNHT21NWE9TTTUxejZlUE1IWTdjT2FrSnJNNjN5djYy?=
 =?utf-8?B?c2tZRHY2d2JaTURDcERNOEEwU2F0Uzg5ampJMUpvSXpvQ1BmRkMxNkFYdGVF?=
 =?utf-8?B?c0FwY0cxV2lPVkxzR2c5RTBuczJBdWVtNUZRMWQrR0dqQ1AvVDliZG9Fb1V6?=
 =?utf-8?B?TGlYM2sweXJ1ZXVzSzI0aVVtWStMc2V5NHVOL1U4STZKRjExN1pMTDFDaDJq?=
 =?utf-8?Q?6W/oBDLd0DJt1e05VHCNLURe6prsURAINouNX+r?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4db5e3-2915-4b56-7c55-08d98f62db8a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 22:35:00.5645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9zWfJkRR/53wRGPcidJklW39eHH6gM37a1Q2yTMd2ZT6c9qCJd3FQ4GyyXkdSMQrCPiXkAMVAsSm1u4R+rYuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4851
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10137 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110140125
X-Proofpoint-GUID: 32d-8mtsmTvWljQrDg11dtNZyQxh_zl1
X-Proofpoint-ORIG-GUID: 32d-8mtsmTvWljQrDg11dtNZyQxh_zl1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14/10/2021 23:30, Josef Bacik wrote:
> On Wed, Oct 13, 2021 at 04:01:37PM +0800, Anand Jain wrote:
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
>> This patch splits btrfs_prepare_sprout() into btrfs_init_sprout() and
>> btrfs_setup_sprout(). This split is essential because device_list_mutex
>> shouldn't be held for allocs in btrfs_init_sprout() but must be held for
>> btrfs_setup_sprout(). So now a common device_list_mutex can be used
>> between btrfs_init_new_device() and btrfs_setup_sprout().
>>
>> This patch also moves the lockdep_assert_held(&uuid_mutex) from the
>> starting of the function to just above the line where we need this lock.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v8:
>>   Change log update:
>>   s/btrfs_alloc_sprout/btrfs_init_sprout/g
>>   s/btrfs_splice_sprout/btrfs_setup_sprout/g
>>   No code change.
>>
>> v7:
>>   . Not part of the patchset "btrfs: cleanup prepare_sprout" anymore as
>>   1/3 is merged and 2/3 is dropped.
>>   . Rename btrfs_alloc_sprout() to btrfs_init_sprout() as it does more
>>   than just alloc and change return to btrfs_device *.
>>   . Rename btrfs_splice_sprout() to btrfs_setup_sprout() as it does more
>>   than just the splice.
>>   . Add lockdep_assert_held(&uuid_mutex) and
>>   lockdep_assert_held(&fs_devices->device_list_mutex) in btrfs_setup_sprout().
>>
>> v6:
>>   Remove RFC.
>>   Split btrfs_prepare_sprout so that the allocation part can be outside
>>   of the device_list_mutex in the parent function btrfs_init_new_device().
>>
>>   fs/btrfs/volumes.c | 73 +++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 53 insertions(+), 20 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 8e2b76b5fd14..10227b13a1a6 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -2378,21 +2378,14 @@ struct btrfs_device *btrfs_find_device_by_devspec(
>>   	return btrfs_find_device_by_path(fs_info, device_path);
>>   }
>>   
>> -/*
>> - * does all the dirty work required for changing file system's UUID.
>> - */
>> -static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>> +static struct btrfs_fs_devices *btrfs_init_sprout(struct btrfs_fs_info *fs_info)
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
>> -		return -EINVAL;
>> +		return ERR_PTR(-EINVAL);
>>   
>>   	/*
>>   	 * Private copy of the seed devices, anchored at
>> @@ -2400,7 +2393,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>>   	 */
>>   	seed_devices = alloc_fs_devices(NULL, NULL);
>>   	if (IS_ERR(seed_devices))
>> -		return PTR_ERR(seed_devices);
>> +		return seed_devices;
>>   
>>   	/*
>>   	 * It's necessary to retain a copy of the original seed fs_devices in
>> @@ -2411,9 +2404,10 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>>   	old_devices = clone_fs_devices(fs_devices);
>>   	if (IS_ERR(old_devices)) {
>>   		kfree(seed_devices);
>> -		return PTR_ERR(old_devices);
>> +		return old_devices;
>>   	}
>>   
>> +	lockdep_assert_held(&uuid_mutex);
> 
> There's no reason to move this down here, you can leave it at the top of this
> function.  Fix that up and you can add
> 

  I thought placing the lockdep_assert_held()s just before the critical
  section that wanted the lock makes it easy to reason. In this case, it
  is the next line that is

       list_add(&old_devices->fs_list, &fs_uuids);

  No? I can move it back if it is unnecessary.


> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks, Anand

> 
> Thanks,
> 
> Josef
> 
