Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74714935AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jan 2022 08:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351637AbiASHn7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jan 2022 02:43:59 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:59742 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351526AbiASHn6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jan 2022 02:43:58 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20J5meqs012909;
        Wed, 19 Jan 2022 07:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : cc : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8NgJN0Rl0An8mVun7Snyw8wnuVKgp+LWnwe9aQ/t/H0=;
 b=wXdF/RwpBfbonEAYIK+ANbB6w0RTsPbRc6mtYveYytwTeCVzbJ/Zr/IUaoLT8ejreEXe
 3T9OR0OtPHYQ42hkWJU7tDeej9SS6OOMKFgMSUJG+TWQGYcg9S9RZpXMuIASrOVAWUUO
 YPZ9W2UmBwm1VEXcVUAHOFpVYaKcsevvo9F8IYwsI1gszr10aW3xE285zGYUxqUONjlX
 uLcVLMlVHPaA/HoEOwtAwdQ5NvCrDfXdqdWbkMhiEZXpfxQ9O9fokF1S+oSWVbg67pRo
 XlAhpC9n3YMfl4PsTcXodPBOID51mj6KN0NtRl2/k/34jU7HNa247csM2q4JCwhF1I3D yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4q4e0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 07:43:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J7etL1070398;
        Wed, 19 Jan 2022 07:43:53 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by aserp3030.oracle.com with ESMTP id 3dkmad87ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 07:43:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIxrRRfDCihWID7d7O1eVSCCag3mpAlEsbm32WOzdyCMeZNUf8Jg4D1qj/sm8egxmiJaKfKtRdf76bhQRDS6U1QM72/0UtYLCS6h5YLiCa5s6UHTx5xpVHhXovaiOYI1mrgDyfB37MqgI4GjA2UEvWY7HgjPdpivryqLKphKn7xehy0BZw/ZTomrwCsIOAowJk+mu+aTDlB28YGdEGElVOEItX+FfGl5Oms/UPozEDwTDXTIMYTSASN9agPdZs2HYndrtqWUQ76VjWa6dRcPWx/poC7wHo6wO18ZbuAvQ0W8yZu75LueZOACNQtCRu75e2rdOXrQwzUFmu1qa1ct9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NgJN0Rl0An8mVun7Snyw8wnuVKgp+LWnwe9aQ/t/H0=;
 b=BryX0Sb03xMoHyIiTfyy21yhUT1tcQGMwG4Ash2TMCpU+L3tWuMN4DFKdWGnLHeSvwak+CcFHdtXOwldO0CQPrZ6VpqmZISXLVY/8eTMzLgUlbmwNJ9wQDGmMMi/1gFzdknfv838FcDFNbtVILabKXrJnlr4L8JzHwbPAOTOCoLZVoYgBi+lcc1wF96wrNwo2Wvp1E0Eq086bus4hDgIdJXqscFvtozgWErn5tU8jOpERujQOdpHl+XNr2WaK5vZ0UHdDyo88gOj8iab91jI3iUrfytFY4L+y2z4e+96KjfpcVRCx1QEzGp5/1fsu4fcBEGABfJWK7uPNqKwc4+e6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NgJN0Rl0An8mVun7Snyw8wnuVKgp+LWnwe9aQ/t/H0=;
 b=xPxyarLhLHThMUVv26uYl0WaVdWoJVdwdzlB/QEZMeCpO/qZkhPApvb84Gyv0blzSwf+T6TOMMQdsUBK94nf67MGtdhAn0c8r0Fih8Cizv1qQdPxv/LXfegcG5mjT2FXBvQtfQwWFSZEEntYREhzuMKkSyNj4wMlk3GMSnSlW3k=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MWHPR1001MB2189.namprd10.prod.outlook.com (2603:10b6:301:36::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.13; Wed, 19 Jan
 2022 07:43:51 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%7]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 07:43:51 +0000
Message-ID: <56f7ab3d-e0da-0bff-2d85-847c89aea3b8@oracle.com>
Date:   Wed, 19 Jan 2022 15:43:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] btrfs: cleanup finding rotating device
Content-Language: en-US
To:     dsterba@suse.cz
References: <1b19262076d9ae10d3ff81f73209249375ae25bc.1642048893.git.anand.jain@oracle.com>
 <d56216c5f955862d31be7c9884222fa9b7a4ddbd.1642060052.git.anand.jain@oracle.com>
 <20220118154330.GN14046@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, nborisov@suse.com
In-Reply-To: <20220118154330.GN14046@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 701b5773-f3f2-430b-7dd5-08d9db1f6f3e
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2189:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2189BEFC650019601721939DE5599@MWHPR1001MB2189.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ap5sCmXa3FEe9QC4vPYPx4KbSRye0VD7PhIsAkBxo13UtGS115PUH6zAltDnUW1tz6JdvlL6AmhAdS9GTIDKwWftiOF4b3rRL1vxKhMm49jGLzLRx8+KoDrzD+YNFRvCx1eGRmxrGqXUoaRwOnlzasynBgUJLIyQyLJKAFwPhZ7f7JymEta3wWvz4bIY2nqcuNP5ngGRclHlvmYWOKgXenE5kv3c3run4Aw8VHIbfjUDyYgpwhOvQzUrTuInFD74wJJrzgnUs1MCmAFCbTgLhmAr7jr3k/BFHZDYl5HL7m0pHQchX6EEgdOtwl5Si40muCwQYQF3jd4b40fYhzMVnbjLMoyg1UR56ogIQskSE84q0IkLbKEEMqtLiW3coFBLxjxcGs61dJWd8n+ieDBl85+C5RY5nA41TkBMpvdVOX9VKDSpWX373uQXgv7/LQ+tjuFCrCj5LI3aFbGQcR0o6wLfaOKYCLKCIGLcsbdbPwqTIuN72larv9UJAfFllIw51qWlX6ZEHu3GOGphSnFLb+9ui+dY8HuRbzEmMicFDKyyl8PD+KuineMvHFNAZGQYrfCZuwrmPBQ1xz1k2xHFX6Gl2OUGVa3pCwINdDPV6emzhb5WACugGKbPzga2DVYQ+b3X1CHEsVFaTvxuimPJqrPqjHTumwxanZMYeMVGEKfKjE8czUE9aWkdGBFfPH4R1AeqsuqiuIf6d5tJWoFziW63z/YqUwYijr1aFDC6d64=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(6486002)(6506007)(53546011)(36756003)(2906002)(2616005)(44832011)(66556008)(66476007)(66946007)(6916009)(6666004)(6512007)(83380400001)(31686004)(8676002)(316002)(31696002)(86362001)(508600001)(5660300002)(8936002)(186003)(38100700002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3ZvdkxYVnVaUzJ1WVo3cGJkcFd6WHhsaEs3ZTJGLzhiT3VGdU80VU9WT1p3?=
 =?utf-8?B?NUxRZEptRGx5UytHcTA2V0JPZUJkMzF6ZXZiMUVXNGM3ZUtNVVNYWFd3WlZ3?=
 =?utf-8?B?SjNDaDdGaUpqUE4yRWcrdEZrUmowc2lWdG91Q3lBT0hwK2dxek5RRzF6ZmIx?=
 =?utf-8?B?ZEZYYjR1MzBOcjNvWkF3YzVrb3lmK1hpMnROYVRBNENIV1ZvMGt0ZUFzalo2?=
 =?utf-8?B?WEpiaUFZTm1BMHNmMG1XRjI3VzB6OHIzVnZZeWRaRjNVV3UzVFJuSEZhR2x0?=
 =?utf-8?B?YktQNjlkbUpLSzdCdWZtQ0pjVHhzVmVzWWVRc2o4N002MjZPT0hJd0R0bjRR?=
 =?utf-8?B?WE1QM3pBMDVqQlJjcXRqZ0MwbVFZN0M4RTBZWDBwWUhhdkdxcDVpZ1kxTUdF?=
 =?utf-8?B?ZU5tcUJ0U0tDRkRRcUlGa3gvL0R5Sjd6ZWdDZ0dBNjJjVEplNXJReVE1U0tx?=
 =?utf-8?B?YldzS05iTGRFbkdKdnVFZnhyV3crRVVDYzd0aVRWd3RwUXlKOXJzM3FhOXp0?=
 =?utf-8?B?Sk9pdHFnazlxUGZXQ1IxYU5VdFlHc1dVYXVnKzNKeFhoaDhkS3RCUXo5Tnho?=
 =?utf-8?B?c2oyUENPY3d2cGFmR29sajU5Z2pjRTQ1Y1JqbndYbHAzMGVGQXBLT1BpMjI2?=
 =?utf-8?B?SVcrdDNrV250R1JjcFZZcU5NNkhmb0ZGbWxFZHQ0OUc5YVJqQUJ4NmJVQS9W?=
 =?utf-8?B?Q2RnSm5KTnBoSi9CVGMzSHVvbHhiajFXZHVnOHBGYUNYNXFEbFBJOEViVk5V?=
 =?utf-8?B?QXR6aGd6aGo0citoclpVbmd5SmVOTXN2NnkrUnM0WW1pSHE3OHJBZ0dvNVVq?=
 =?utf-8?B?eStEakMvbGhXOG1jY3lYZUYyMFgyVVBpOTA4MFI0U1JwakROUzNTUHcwREgy?=
 =?utf-8?B?T1N3TTJGeVdEMEtXTHp6UFE2b3Q1eEFhUk9EalJUZWlLNWFDR2RXeGo2L0Rj?=
 =?utf-8?B?WHZVWEErWEF4bUNOVlpXZDdqNCt6UXd4M3lVWFRSTWpOeUhqTGRXV0ZZM25W?=
 =?utf-8?B?bDVyK0Y4UlBsQVROWHdzWFBud0hudndVaXdHY0ZKSkM4bUlROEg0L0VtN1FF?=
 =?utf-8?B?REdPb3NrNUQ1TnlQYjRzWG52N3ZoU2FEaGN2WnBEQStFT2tqNzB0N2RFTFVJ?=
 =?utf-8?B?eWx6MWZGUEVwQWtMb1F5Um1JYnJ2YU9ZNGhZZFRvVVJQdUdMV0ppeEtvVEZ0?=
 =?utf-8?B?UFNwdkxsWVFtMGl3akU3dkx0OU9CVnY3Q2NBdzNBSnVCSjA4TEVQOEUwY2hT?=
 =?utf-8?B?ZjdXYUxYY0VHa0hpditJZEgwMWhLZDFJanBOeEZHclpqZXQ3NDhhNUxkeWFn?=
 =?utf-8?B?QVlZWXNQTjFMZmFJcVhKT0ZXOEQ3NHRDZ3FLM0ZxVjZ5ZVJSMnoxdzlLODRZ?=
 =?utf-8?B?a3NISG5kZ0luS2tVUVpNK21veFNpTDkrM1BoVC8xekRTQTZ0K2dtUk1pdExu?=
 =?utf-8?B?VDlIRS9XSXgvYTBBMzVFR3h3SWpBNjNWSElQOWhMWHRINlVJL1pzZVkzbE1H?=
 =?utf-8?B?Z0xhZFJSbkU0ZEZjWVAxUVFzazgzU25Wc2I1cUxtdDAybTVodHozZVhNcFFu?=
 =?utf-8?B?Mzk2Wlh3dHkvYlJvU3BmRjVqZWMrRGlyb3Y0LzRZR1pFK0YxcGdyY3ZIRXJW?=
 =?utf-8?B?NmN5N2VRQjhtN3haUzJnTjEwOWk0ajRiOHVVTlBxRGY4NEZrWGppVEVHTHN2?=
 =?utf-8?B?VjYwdGduRFpVNWo3cmFaNGlOOHNLK29qYjVaYjFEeG5RNzJjRDkrcVNBRlQv?=
 =?utf-8?B?cW5EQjI0QnJqYmlkd2M0N0NTU2RvaVQrWkwxNFNycG9PY0F3c05LTEtCU3ZI?=
 =?utf-8?B?ZnU1L1pyNkIweGN6eWIrVWgvRGJTZ3ZLQyt1d0RTZnRyZ1BDT1JLalFtT294?=
 =?utf-8?B?WUwwZVliSlpxby9mRVo4NXgyT1NyZEpjQ2IxeXhVMnF4S2ZtV3N6U1NFTGVO?=
 =?utf-8?B?NXcwa1BIOVl5dVcxbUEzeHNJYUFhV1Rxc1pCUkg5ejZxV3RoMlNQTTZFL3V5?=
 =?utf-8?B?ZWQvUGJxTGl6UGZITm1BbHVNVEVjSHdDMktTcDhzdkdpUklrektNUDJEdVZr?=
 =?utf-8?B?VXlDeE1McHBhRUdqWWtHYVV1WGJuMnJoZnU4NFpzVi9taVZRL2kxdWJvSVAr?=
 =?utf-8?B?OXpmcnVkS3kyQlhmNEpnUlFkQ1hxS3JpN3JvaUlRVGk2aStVU25MNHhyL2pZ?=
 =?utf-8?Q?RgUu9VPjRc2a7ZHnbfkzYzM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701b5773-f3f2-430b-7dd5-08d9db1f6f3e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 07:43:50.9764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZ67Ofg4VSPzJaIwKIhlAZnQ6vG0v6g91j3iwHMfN9asfnGYksP2tcHPWZBB2wXpc57gsskQNBEsg0JCLViUYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2189
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201190040
X-Proofpoint-GUID: CI2s-NJl_CSezwSiGzJWOOOO1nXCHoDg
X-Proofpoint-ORIG-GUID: CI2s-NJl_CSezwSiGzJWOOOO1nXCHoDg
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18/01/2022 23:43, David Sterba wrote:
> On Thu, Jan 13, 2022 at 03:48:54PM +0800, Anand Jain wrote:
>> The pointer to struct request_queue is used only to get device type
>> rotating or the non-rotating. So use it directly.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2: Eliminate the if statement.
>>
>>   fs/btrfs/volumes.c | 10 ++--------
>>   1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 70b085dff500..34d08c4f7b6c 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -601,7 +601,6 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>>   			struct btrfs_device *device, fmode_t flags,
>>   			void *holder)
>>   {
>> -	struct request_queue *q;
>>   	struct block_device *bdev;
>>   	struct btrfs_super_block *disk_super;
>>   	u64 devid;
>> @@ -643,9 +642,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>>   			set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
>>   	}
>>   
>> -	q = bdev_get_queue(bdev);
>> -	if (!blk_queue_nonrot(q))
>> -		fs_devices->rotating = true;
>> +	fs_devices->rotating = !blk_queue_nonrot(bdev_get_queue(bdev));
> 
> This is an equivalent change, in the new code fs_devices->rotating will
> be always set according to the last device, while in the old code, any
> rotational device will set it to true and never back.
> 

Oh. The previous status gets overwritten based on the current device
non-rot check. This is not good. My bad. However, V1 is ok could you
pls consider that?

Also, there is a bug in the original code - If we have at least one
rotating device (HDD) we won't enable SSD benefit. However, if that
HDD is deleted later on, we won't still enable the SSD status. This
bug can be fixed easily on top of the patch

  '[PATCH 1/2] btrfs: keep device type in the struct btrfs_device'

  I will wait for some comments before fixing this.

Thanks, Anand

>>   
>>   	device->bdev = bdev;
>>   	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>> @@ -2590,7 +2587,6 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
>>   int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path)
>>   {
>>   	struct btrfs_root *root = fs_info->dev_root;
>> -	struct request_queue *q;
>>   	struct btrfs_trans_handle *trans;
>>   	struct btrfs_device *device;
>>   	struct block_device *bdev;
>> @@ -2666,7 +2662,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>   		goto error_free_zone;
>>   	}
>>   
>> -	q = bdev_get_queue(bdev);
>>   	set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
>>   	device->generation = trans->transid;
>>   	device->io_width = fs_info->sectorsize;
>> @@ -2714,8 +2709,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>   
>>   	atomic64_add(device->total_bytes, &fs_info->free_chunk_space);
>>   
>> -	if (!blk_queue_nonrot(q))
>> -		fs_devices->rotating = true;
>> +	fs_devices->rotating = !blk_queue_nonrot(bdev_get_queue(bdev));
> 
> Same here.
> 
>>   
>>   	orig_super_total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
>>   	btrfs_set_super_total_bytes(fs_info->super_copy,
>> -- 
>> 2.33.1
