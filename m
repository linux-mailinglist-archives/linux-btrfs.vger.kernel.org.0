Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6348421DEE
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 07:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhJEF3i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 01:29:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21112 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230403AbhJEF3h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Oct 2021 01:29:37 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1954UZFd004511;
        Tue, 5 Oct 2021 05:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HNc+gyg0GdB+6wROI1EEdD5lFmWpg4yOwwI2jzrBTvQ=;
 b=uAzs1zYwS5UGhY8M3d+jVeiMw0ofgploRldLwuhFTXUhxNcRXkNqI2BCMxelc4ibFB2T
 QM0pf/G0scCIr3T0b6Dg4iSb8mMcTedpmKwKqfL0wQsGbPmjW/e9hUvRC8GQzhnb1fDN
 qLk/UxAusF4npIyt7mCKaOAzP4E1g2Kz0AYaydz0Ok57nV58mKU4wNtu3hK3a8dctT2Q
 uI9FGWKq0KZfIp6zrufxXaXQvxjmYqUJ4EpGUmhCQEhA5/7l0TAhnRMYiifCTSjRipHG
 KqeSGCRhjfG7Pl2b1alo+XuObuNGbWj+H34cuXoVMxAkRUGdhPUq/VdXtTFP9K6Oi80c rA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dvdsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 05:27:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1955Ed1t007266;
        Tue, 5 Oct 2021 05:27:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by userp3020.oracle.com with ESMTP id 3bf16sfhhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 05:27:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKUFXrfh/dwkHI+WrBDwoKym80bsCqBptEYuKCzVfbfM682rw5+Gy3/cuy65yAvmvYsG1UCDWRZD2SODVKhLTNLUorlFwMq1sxYf27DsKLBxQKTmg9wWgMRL+OEBU2CCRq6OXA+qcFLq61ui9kZjfGOJEe9K8PgbhtqbtXjFFJ7wRp6NASsVoAfwL2DhNMYqxCWOU2kXzkPwp2k0sjr9URNayTtWirz+UwQ9f/EmwdeB3l9/wjLKrkIYo2juxdHEPIZ8e7o7m/YGxVdWUwPRZKPqNX9aQ21XL2kWF3XcfvhIXeM5Y+vOVDSOl3TlYaRRT3/Jmgjb9/79iTQHBPkbEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNc+gyg0GdB+6wROI1EEdD5lFmWpg4yOwwI2jzrBTvQ=;
 b=X/sJeHke1o6RHz2fAMgyaYSV+EPnnK5T/qUBLLKpiTICPBjFnx7Y+6ms7uIy1aURMPI0EhrrM3IlwXfmWunBsVat2qzgGXBK+uf5ZWfukxSCTStgNQjf+Oq5/zUw4vAY3j90YzgnhUbWXrDtG7/mhwPrAMfP6AWL+9Gw+0RYBQR2w7RQ5coaG/poFXVsSFWLbYMbxKYToYJO1gbCxif5uyYxch9svUh0UyvzFhyPTBfcFqUps4Rt/XPeSnN+xynSOb1GiJWAz/Mw+N2q5PoJ5zLoXl3JyHatMYu+CSReHeh65qX+3YxP9EV/v6MPg98Qxynp/bQo+f9X9CqmXH7a0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNc+gyg0GdB+6wROI1EEdD5lFmWpg4yOwwI2jzrBTvQ=;
 b=la8fP2/RAY0urqzy5NyFnEWd5i52yRyE7jQ5IzpM/iy0EMxPG3K0BSAcPa8F/gLEX+02cGkm2oac8HNANFOGasraoAqH3YSSqxnvydcV21OMXVU86HO9xnczeGSzOmxSoaqylUgkzHZyf5Io2FJDxj8fw8sv9z5jwcaddHkMzes=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4093.namprd10.prod.outlook.com (2603:10b6:208:114::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 05:27:41 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 05:27:41 +0000
Subject: Re: [PATCH v3 5/6] btrfs: add a btrfs_get_dev_args_from_path helper
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1633367810.git.josef@toxicpanda.com>
 <5070938448ea0730e642d4dcaad3c1ca95d95394.1633367810.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <f4056e10-6a12-26ee-1fe0-face9eeb870b@oracle.com>
Date:   Tue, 5 Oct 2021 13:27:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <5070938448ea0730e642d4dcaad3c1ca95d95394.1633367810.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:3:17::22) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR02CA0010.apcprd02.prod.outlook.com (2603:1096:3:17::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend Transport; Tue, 5 Oct 2021 05:27:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 710ab8a7-9727-4861-2d0f-08d987c0da15
X-MS-TrafficTypeDiagnostic: MN2PR10MB4093:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4093848B0B0284E1DF895E24E5AF9@MN2PR10MB4093.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tAC5hbpfc+gy6zjUCB+6O83FW8weLX8OEOUum+ZLx1DaOuzikZAYRtyUGr6ubnMX91jhzVwIA3gYR0IP0gSP1m0HmuwCWTPrzXREHn7/Bg4Y3kZVoruediYVy6v23OZ7Aqt70k883Kym5pHcooyHKrEbNu+HzJQ2GoT9Jc1dyAAqOW0kHIo7tlrPjr88pXX8kEYT29/oV2FhNQp/C5H1JmNhqa3dOSpF4NaPR5mcj513WyTXHy9KR50xyR1enT/gCcuxs5kvThp+3kgPysG06oyAcMOsKG/xInzQviRiHkcZ7zvmzdh+Q0w6rs7L5yTqWfgpTY2EVe5/5fikwvQjy5bk58TSHUg60cU3ge9s5faoM+1lnKDZQhVYJs8LinnLzYMfDLlOE5G7izV/4kvJSR4uoFa3DcPg/V55X8D/K84A7rndBKCmcLBYLdVec/xic7qwY6c3KLfqyE1Z3E+wfDTXKlxiPigsXXTn7Ny8/EM2ZnzqwKDqyHAzYaepFkI/OHLEEl/zCiHpkLGtPX+RwDQadXFu28eq27qwjlC5tGLda6u1BXoDEfJ6G4qAF+gqAfSGL/ND9iCcc6zIYOobikuDwtQ24WzoDlbA0ddFE9ISYDK3NGvVSP6olPCJDot9LZklQghc+XZe6422KTQVLlniN8m2+aktquHiUzZ3CM1C6AbEqmq+uaTdYseRicfwqhz7vM4G4F1N1pMZeVyXtswNTAr4fEILjwRIP1VaY553Yk8icl7yEyBDatFxs3cv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(316002)(38100700002)(6666004)(31686004)(16576012)(36756003)(83380400001)(2906002)(6486002)(186003)(2616005)(956004)(8936002)(8676002)(86362001)(44832011)(53546011)(31696002)(66476007)(26005)(66556008)(66946007)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXR6VkV2a1RHUHdnQWRBdXlsQXFrbC9mYUdVajZOTWlKUm5GSnZiQkZoN2N6?=
 =?utf-8?B?ajVsSGY3Tk11MHQ5YkYrVkUvUFNPLzVhdVN5THVGdFdQY2FSREJDYWRsS1Ex?=
 =?utf-8?B?M0NSRUVISzVMU0kyT2tweTR5K2Ewc2k5SHppMGxvOE9ZTm9tVGgwRVRCL1pw?=
 =?utf-8?B?cXlxeHk5NXlhUGFmSUxkaDFEMjQvT3A0SWFGakRNa09TR1BoMWNNMldhek9N?=
 =?utf-8?B?R2pqRjFSNmpnUCtCRkpmWlltTW5qUEhBc2ZKNERIQ2JzSjhOZ1FFT2FRbHJD?=
 =?utf-8?B?WDFDejFtTHBSSFBKbzhYL1RRUUNza0FWRmxKUWZMOHpkakRBckZ5cHk1MWsw?=
 =?utf-8?B?K1JLTGZoek1nQ2F2Q2taUHZaeFBUSHN6UTRPSzhxZzdyZGxtci9PMWxwRDZX?=
 =?utf-8?B?d2tYVEdncHYyQytzN2VhVDlTc1J5OUJWNm5YRUVNc1cxYkhCenZnelZ1bnE2?=
 =?utf-8?B?NW9aVzZtZWJ2V2k2L1UxUXNNYmwrRlkzenBzNnBja2hMOHd5WU5BbmxUUlJC?=
 =?utf-8?B?NUJWZzZvRTB5YXd6NU9zbW1DRy9QVzBTZVhtZVVIV3o2ZjBWSFRLcTRIVWhz?=
 =?utf-8?B?TVVDKzNtamlOZlcvNG1jMnhZbmxXcnU2R25mUXpRM2NzZFI2elN3WTJhYWpo?=
 =?utf-8?B?ajhoMksvU3ZmYXljdUpiRG1oRUpkWDhqOWhXQUhlVVJvTHY4WnRvaU1xZU5B?=
 =?utf-8?B?QkQ5UWYwM0U2aEo1enhEWmIvczJjRlNHeFdFRVFYN09id2ZSTFVJUFV2enR1?=
 =?utf-8?B?T01ZOFNTQmZnUGJyWkJYTVRLZFFKbU1RN0RUVVlqTkY3bVdzT2k3Um5mN2VU?=
 =?utf-8?B?YkVWbS8raFA1OWpKRzZ2SitDR1kxVmNhWmtPeGlRU0REZTVTUmxVNVN6Y09E?=
 =?utf-8?B?dG51ZktkSmNGc0RHOE1PNUkxelNLTFU5VDVPMjF4RnZLNmVOWlMyVEZWV0Zs?=
 =?utf-8?B?enNzcG1keWhSWUtkSVpyT3lVNm1DdytlZE9nL3ZkeHdoMTFNc25zRFNjR3p6?=
 =?utf-8?B?Vms1SkRINXVrcEoyekk1VWc2ZGpzUUtURHVEdGUvdkswWVc2MUtFVFE3a1dI?=
 =?utf-8?B?WndFUmM2emxKakZod0JYeGN2SENQRmc4NlpzRHltZUR3bmtucHA1SC9qeXkr?=
 =?utf-8?B?YkI4RlFqaVV5L2tmbmdRVmRoeVJyemJQL0xHY3F2Mm1qcVFqeFJCSXZSMTFH?=
 =?utf-8?B?MFVsYkphaFR1UUsvWVFYbngwcDRmNVBlbFpVTFUycHArclArck9uUGtnQnFl?=
 =?utf-8?B?czJRK0liaEQ3V2UwWFM3ZXAxejJ5QzU4aG0yRWhwQkU4Q2ZuZjJ0ZGtodm9U?=
 =?utf-8?B?akxCMHFjaFJCbGdZUVpiR1p1WGhTODdWM3lHZUdjNG9aQUUwT1NTTm1nVzEz?=
 =?utf-8?B?NDVQTFdCek1MeDRxRmRscGpSZDVZL3ZsL2xzejJJcDcyVGRWcFVCN0JrNWh5?=
 =?utf-8?B?VzhBK09mUWZrZDlocUlsM3Q2clBJZ21UdW9Yc3RjelFlMjd3WXY4WjMvRE8w?=
 =?utf-8?B?Zm1SbkV3bXdIR1NQTWowQXE4bDMvRjVzWm82N0VuZVhlOHRUdDZQM2NJS09Y?=
 =?utf-8?B?aUFNZmViUXpzRTE4YTlTa055T1ZKYnZPcGdobjlhUk1PZFVZSUNIYzZRRlE4?=
 =?utf-8?B?dFRnSlBrZS8vZWlUWkhZT0l0UnJVRHRHT1IwVG5tNjlBNkpHTjZyUEJ3c29z?=
 =?utf-8?B?Q21xREFYZ3lVR1RQS24wNnFBQkIvOXZRNXQ2QTY0TTlDc0E1Z1hVR04zejhr?=
 =?utf-8?Q?yQaGJdHKfa/p9txR+GQJgEkKLgwGDZ9hqcKrLIg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710ab8a7-9727-4861-2d0f-08d987c0da15
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 05:27:41.6168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7mS25rLwWC3vlIp7mzItOJEwymfgOmmai5Qjg0XCLGBHH/l9e8Yxxv49OZFCRg6EssHGnT1OX83cyG6mjWAUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4093
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050029
X-Proofpoint-GUID: YSm6CouAPmyzvsVoqzTEqunnKG6HxQxj
X-Proofpoint-ORIG-GUID: YSm6CouAPmyzvsVoqzTEqunnKG6HxQxj
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/10/2021 01:19, Josef Bacik wrote:
> We are going to want to populate our device lookup args outside of any
> locks and then do the actual device lookup later, so add a helper to do
> this work and make btrfs_find_device_by_devspec() use this helper for
> now.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/volumes.c | 99 ++++++++++++++++++++++++++++++----------------
>   fs/btrfs/volumes.h |  4 ++
>   2 files changed, 69 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 191360e44a20..e490414e8987 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2324,45 +2324,80 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
>   	btrfs_free_device(tgtdev);
>   }
>   
> -static struct btrfs_device *btrfs_find_device_by_path(
> -		struct btrfs_fs_info *fs_info, const char *device_path)
> +/**
> + * btrfs_get_dev_args_from_path - populate args from device at path
> + *
> + * @fs_info: the filesystem
> + * @args: the args to populate
> + * @path: the path to the device
> + * Return: 0 for success, -errno for failure
> + *
> + * This will read the super block of the device at @path and populate @args with
> + * the devid, fsid, and uuid.  This is meant to be used for ioctl's that need to
> + * lookup a device to operate on, but need to do it before we take any locks.
> + * This properly handles the special case of "missing" that a user may pass in,
> + * and does some basic sanity checks.  The caller must make sure that @path is
> + * properly NULL terminated before calling in, and must call
> + * btrfs_put_dev_args_from_path() in order to free up the temporary fsid and
> + * uuid buffers.
> + */
> +int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
> +				 struct btrfs_dev_lookup_args *args,
> +				 const char *path)
>   {
> -	BTRFS_DEV_LOOKUP_ARGS(args);
> -	int ret = 0;
>   	struct btrfs_super_block *disk_super;
>   	struct block_device *bdev;
> -	struct btrfs_device *device;
> +	int ret;
>   
> -	ret = btrfs_get_bdev_and_sb(device_path, FMODE_READ,
> -				    fs_info->bdev_holder, 0, &bdev, &disk_super);
> -	if (ret)
> -		return ERR_PTR(ret);
> +	if (!path || !path[0])
> +		return -EINVAL;
> +	if (!strcmp(path, "missing")) {
> +		args->missing = true;
> +		return 0;
> +	}
> +
> +	args->uuid = kzalloc(BTRFS_UUID_SIZE, GFP_KERNEL);
> +	args->fsid = kzalloc(BTRFS_FSID_SIZE, GFP_KERNEL);
> +	if (!args->uuid || !args->fsid) {
> +		btrfs_put_dev_args_from_path(args);
> +		return -ENOMEM;
> +	}
>   
> -	args.devid = btrfs_stack_device_id(&disk_super->dev_item);
> -	args.uuid = disk_super->dev_item.uuid;
> +	ret = btrfs_get_bdev_and_sb(path, FMODE_READ, fs_info->bdev_holder, 0,
> +				    &bdev, &disk_super);
> +	if (ret)
> +		return ret;
> +	args->devid = btrfs_stack_device_id(&disk_super->dev_item);
> +	memcpy(args->uuid, disk_super->dev_item.uuid, BTRFS_UUID_SIZE);
>   	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
> -		args.fsid = disk_super->metadata_uuid;
> +		memcpy(args->fsid, disk_super->metadata_uuid, BTRFS_FSID_SIZE);
>   	else
> -		args.fsid = disk_super->fsid;
> -
> -	device = btrfs_find_device(fs_info->fs_devices, &args);
> -
> +		memcpy(args->fsid, disk_super->fsid, BTRFS_FSID_SIZE);
>   	btrfs_release_disk_super(disk_super);
> -	if (!device)
> -		device = ERR_PTR(-ENOENT);
>   	blkdev_put(bdev, FMODE_READ);
> -	return device;
> +	return 0;
>   }
>   
>   /*
> - * Lookup a device given by device id, or the path if the id is 0.
> + * Only use this jointly with btrfs_get_dev_args_from_path() because we will
> + * allocate our ->uuid and ->fsid pointers, everybody else uses local variables
> + * that don't need to be freed.
>    */
> +void btrfs_put_dev_args_from_path(struct btrfs_dev_lookup_args *args)
> +{
> +	kfree(args->uuid);
> +	kfree(args->fsid);
> +	args->uuid = NULL;
> +	args->fsid = NULL;
> +}
> +
>   struct btrfs_device *btrfs_find_device_by_devspec(
>   		struct btrfs_fs_info *fs_info, u64 devid,
>   		const char *device_path)
>   {
>   	BTRFS_DEV_LOOKUP_ARGS(args);
>   	struct btrfs_device *device;
> +	int ret;
>   
>   	if (devid) {
>   		args.devid = devid;
> @@ -2372,18 +2407,14 @@ struct btrfs_device *btrfs_find_device_by_devspec(
>   		return device;
>   	}
>   
> -	if (!device_path || !device_path[0])
> -		return ERR_PTR(-EINVAL);
> -
> -	if (strcmp(device_path, "missing") == 0) {
> -		args.missing = true;
> -		device = btrfs_find_device(fs_info->fs_devices, &args);
> -		if (!device)
> -			return ERR_PTR(-ENOENT);
> -		return device;
> -	}
> -
> -	return btrfs_find_device_by_path(fs_info, device_path);
> +	ret = btrfs_get_dev_args_from_path(fs_info, &args, device_path);
> +	if (ret)
> +		return ERR_PTR(ret);
> +	device = btrfs_find_device(fs_info->fs_devices, &args);
> +	btrfs_put_dev_args_from_path(&args);
> +	if (!device)
> +		return ERR_PTR(-ENOENT);
> +	return device;
>   }
>   
>   /*



> @@ -7049,7 +7080,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
>   	for (i = 0; i < num_stripes; i++) {
>   		map->stripes[i].physical =
>   			btrfs_stripe_offset_nr(leaf, chunk, i);
> -		args.devid = btrfs_stripe_devid_nr(leaf, chunk, i);
> +		devid = args.devid = btrfs_stripe_devid_nr(leaf, chunk, i);
>   		read_extent_buffer(leaf, uuid, (unsigned long)
>   				   btrfs_stripe_dev_uuid_nr(chunk, i),
>   				   BTRFS_UUID_SIZE);
> @@ -7181,7 +7212,7 @@ static int read_one_dev(struct extent_buffer *leaf,
>   	u8 fs_uuid[BTRFS_FSID_SIZE];
>   	u8 dev_uuid[BTRFS_UUID_SIZE];
>   
> -	args.devid = btrfs_device_id(leaf, dev_item);
> +	devid = args.devid = btrfs_device_id(leaf, dev_item);
>   	read_extent_buffer(leaf, dev_uuid, btrfs_device_uuid(dev_item),
>   			   BTRFS_UUID_SIZE);
>   	read_extent_buffer(leaf, fs_uuid, btrfs_device_fsid(dev_item),


  This fix is part of the patch 4/6.

  Otherwise looks good.

Thanks, Anand


> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index fa9a56c37d45..3fe5ac683f98 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -518,9 +518,13 @@ void btrfs_assign_next_active_device(struct btrfs_device *device,
>   struct btrfs_device *btrfs_find_device_by_devspec(struct btrfs_fs_info *fs_info,
>   						  u64 devid,
>   						  const char *devpath);
> +int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
> +				 struct btrfs_dev_lookup_args *args,
> +				 const char *path);
>   struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
>   					const u64 *devid,
>   					const u8 *uuid);
> +void btrfs_put_dev_args_from_path(struct btrfs_dev_lookup_args *args);
>   void btrfs_free_device(struct btrfs_device *device);
>   int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>   		    const char *device_path, u64 devid,
> 

