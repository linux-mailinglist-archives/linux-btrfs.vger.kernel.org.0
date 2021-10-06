Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44876423A1F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 10:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbhJFJAv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 05:00:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3820 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237620AbhJFJAt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Oct 2021 05:00:49 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19688o5x029506;
        Wed, 6 Oct 2021 08:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7UuH6uXLFukiBy3HVBRT5nxMj6ZWKcyRXRemkqifavY=;
 b=bBu7JORTGNCNn5ukWXfTMYry9HmLBpFix1dPBr6lVCtwjBo7aCbY2QhpdKWjIZYYI9v0
 P6ROEWkg1DQpef8IgoVhCi6pBGJotO78tzoxHuta+Hrvsir+2zWNFoUqY8Dc4UrClsc6
 9UvZWI595d0S6TtkzTI1W+vSCvXs7p+COUciNWq76OFuK1HhfGbfjvppSg6oPGRApMRs
 ZArBMqtqklEYTrQVzMfyQXKNdQzg3EIld5A6YaX53ZiIPjDXA1mbTg//TOmgKT7tByYH
 bQGRaoAIB5IsZuVuXeKa+0GgSj6tUwyt/gL1RmMXcwR5JUEjG/QGAk6duNoKkVpMI6uv ZA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bh1drt51j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 08:58:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1968siqS016525;
        Wed, 6 Oct 2021 08:58:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by userp3020.oracle.com with ESMTP id 3bf16uncv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 08:58:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ew/XqfxUN2q4Yt/dNlaLUObpSgD0o5mTX9uIt/v1APXNpq8gKmAfaUxP0A1uD277Q6vE2rmkZcklKrAS7Si02FET3tMXQOAWJGiF0UskBE1oayQW55FWGvJ9sRF7bUoXOXg4A6Rc+xpCqd3nlkjaeIiK/XKtuXW8nCvL4+uUADc+t2E9UcW7oMXRDUJW3a8nzB/57Xd7U9wV698j6bvjRP1r9wGdAnwIXBi75sX7Qv3GqS700SrqcJKueA32I6rqP8rV3+lNtF0B8BlytZ1cM4mJncGLv2EQ6ly8SXal0LfA9zrM/79f/+7Ccv8BpPevOE+g0/1OV097qScCbNOrhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UuH6uXLFukiBy3HVBRT5nxMj6ZWKcyRXRemkqifavY=;
 b=GgsOxT3gjZuTsRinMkxSHFUfLmGtH1FFXD4WJGXT1x/sqSzTiRsAsTuf/w68Or1IYORSqReRi/+RO7g7HbVmpny3ROTHk7MxnU5YV8uyMD/f7UPjRm+2ecOCqHR2qUE9uVi8kkdbzXwWU1rplamUwMzgOStu5I+XoUjLpUEw2CiFbIFIBcR36AeUEQhDURnMTc9KvzS06GgOm1yPaJJlKUN2cQJufxuSIJVfwuuVT97l17j3SPY7J/9+epys7zDw2dx954JeCcZ7CTJCrhtZOhhOKc9ng+I41hmIiOnW3ALPt80UwuEkAsHnQi9w0UkzyWJTl+Hihocv/jjcCMaKeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UuH6uXLFukiBy3HVBRT5nxMj6ZWKcyRXRemkqifavY=;
 b=ByG6QkgMt5GFRHVVeUD3Z7sitg/Sc4efJtAY++jbJp4rlqvYjfxQSDJBfmwZwSLLmTLeOoPNZ+ATGAWYuo8aoIt7djcD5A1XVhDMK4ZQv3A1Ivt1Xjn1aAO5uPmUBvgmbO1PAdPeDCCvUp9E4+CFrs5kg8BVF9ttb3Q3aRU/kAQ=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2913.namprd10.prod.outlook.com (2603:10b6:208:31::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Wed, 6 Oct
 2021 08:58:51 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 08:58:51 +0000
Subject: Re: [PATCH v4 5/6] btrfs: add a btrfs_get_dev_args_from_path helper
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1633464631.git.josef@toxicpanda.com>
 <b8fd2ecac3156cb0ea8d717f481182b25dce8841.1633464631.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <b317a828-ab99-7b78-5858-59032f58c767@oracle.com>
Date:   Wed, 6 Oct 2021 16:58:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <b8fd2ecac3156cb0ea8d717f481182b25dce8841.1633464631.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR02CA0125.apcprd02.prod.outlook.com (2603:1096:4:188::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend Transport; Wed, 6 Oct 2021 08:58:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91098bdf-8f9a-454a-0964-08d988a7845d
X-MS-TrafficTypeDiagnostic: BL0PR10MB2913:
X-Microsoft-Antispam-PRVS: <BL0PR10MB2913E299C22CAC68FB363C2DE5B09@BL0PR10MB2913.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3x4uADj9uczIUg2+TVI2Yfg4AkEw6pMa7JOqh8eEiZoDcfsYiqPgX65QL0Yd2lw//4J9O0OFjbXrGEC9WH45vig7DkyBMaf6AkqUmcj0VshgWmJSsNAzW/eFUysTU3HyJ8m6JraQaC0ndMsIvMBILWuaxTPgypVTEoCMKOU7U5PsjHAiC0R8Ev4RUUu77ikiOnEivxK2dO0b6FOzROffq37cjq3Dp0tV9NIf2oLcMMael0oYqFRJOYBzd1wGDRiTQjt2wTYdprBHX1uMKJMyHE9MGRdNJHsp6LRRcvM4uDEXCVy8oSoSoUMiNSzgW3N+m04lDIE/6UDvnvNDftVtTAZOVM8P66vSbAdS58hE5hrGnckhcmU5+qjghybLgL796MUdrpctY4HY+mViNhFNXGl0yeXFvP4Snb/lXp336dAicYC2y+Js8EGhM/FF2xqp0NlI9K4EPyhaBG1xI5+4UOZjYk/2i+Ztc0gzn5a5LzQ9pU5ls4QdqkRii77C62exWyyar+hGRQXBAB8+N4Xk9p74+W4bo4ffJViC3V4F+FQcB9SGf3Bg7ccOa945fSra7sG1d4CyKe53zn071sxC+pqgKMNXaBDzTuqEuMw1i+vycYe9nXdWyo3QchhnkbbAxk7hFA41iVDErbvHWL3lpcCRRw1vDcdtrd7xklkggJ30O6gt1Itx8UsiSa7N9z0kn+B6EgTcYGgK3ip1y6mcWC/A4vB1pTZiQ47QO+6rLubf+WUa8pf2ZX9hMpbbHE2P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(36756003)(44832011)(16576012)(53546011)(186003)(86362001)(66946007)(31686004)(508600001)(38100700002)(2616005)(31696002)(316002)(6666004)(8676002)(5660300002)(83380400001)(26005)(2906002)(956004)(8936002)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0RUQ0FwaXAzQkVFK3B6bC84UFBTVW8waXJQNEp0Si9EY1c3enVOWVpVcjRp?=
 =?utf-8?B?aTZKN01CY1lLeXRvRTVYUjRzUEZVdTF0VERHUW5QMTUrc1FvVytsL0s0aHNJ?=
 =?utf-8?B?M0VLYUVoY00vcCtwZmx4eXlraWFNTHN1RmtMeVRPVGtKWjFlREtiTzhKSVcz?=
 =?utf-8?B?OXJKUnorNzltclorTFRhWmlveE5uZzdLWkx5RXgycTVqQzhIMHpGRDk2d2c5?=
 =?utf-8?B?UWhZS21EZVFxVEZodmZwZTJ2TktwNlRINWphMEhKeHY4NmdLU1A3eUtOZmNL?=
 =?utf-8?B?Tm9oQXlKVWl1YXdHM3dOd0Zoc0ttRzZYZkFVMEswSVhUQXNUSFVmR0tMT2FT?=
 =?utf-8?B?S3RYaUlzcE9BM0o2M0cwK2l4cUFyUmYwSWZWU1NPdXlqNXZ5YzJ2YUcvcC9Z?=
 =?utf-8?B?alM5UnA0ZUd3V3dnR2Y2NVNsZFVtTHc0MXhEZHBOWnNHck9pOXlJakYweUh5?=
 =?utf-8?B?RGhmWXUwVDJjN09qenVaMEJVRHZoSGpKMnpwcHo1MlV3aURSbTZ3NElGby83?=
 =?utf-8?B?MC9Xbk56TW95ZWdNVDB2ZExFSllnUUsrOWdPWE8ydm1nMG5ZZFBhc2R6Tzdh?=
 =?utf-8?B?NDQ2dFg4TXlSY1VPdldOdTExMTNLS1Jia1U1VU41NEI2SkY2V3REOEw2eHZj?=
 =?utf-8?B?YTV2WkxMSlpuenhmTzU1clpReDZaL3IrOWZoUGtaVjZEajhlS1Y4RnUyTTEx?=
 =?utf-8?B?TUhjdEpzeXdBSkdWL2NPaWRIRFc3SDJXL0w0Q0xBNWRvKzVKOElySytrWHRn?=
 =?utf-8?B?a3c5RU9hUmFNNDR3eW54Z2dpOEdtOEtGbnBrK2hNcXo0TVRUTVV3Rml2SW5k?=
 =?utf-8?B?bjR1MmV2YXpCQWxkOVpVclhhem1BOVA4d0Zwb3p0RllTSXdhT3Q5SWZlOXJK?=
 =?utf-8?B?VGF1NWpEQUwxeWJWQ21IUlBFeGp2NWJMVCs4WXRCK2xXVXUzS2R5YUdiTExw?=
 =?utf-8?B?d0xwMFNKZHlyMENOUzBQbFlMRlFBWmIySnFXa0MrZjhPZnJuTjRlVGJXTkt4?=
 =?utf-8?B?eVVMN0ZYS2YwazlQaHV2Qm42ejZHenQySzJrWlM5ZmJBMmg4R2F2anduMUV5?=
 =?utf-8?B?L2Q4dC9Tb0paRFVnOG0veGNJL0M2UzBrWjVkb2UrTllaK29ZeDFTT213UmJ6?=
 =?utf-8?B?blo2Z1J6RFdjVUNCZE4rdFdWZ1U4RTJUQlB2NTJXVTRmNTl2Y04wazBoc1hp?=
 =?utf-8?B?a3NDTHUrWXhsbG4xM0NOWHAxTGdydmpFSUFUZ3Q4SkQrUmMvdXdoanRZUTkr?=
 =?utf-8?B?NHNYYWZBcXFUSmFPcnViV1RrUzIwNmcrZ1l6dWxnWmYxVWNLSmhKY3ZaTVBn?=
 =?utf-8?B?RXNRQmpMcThxYkFpR1d2bHNWU082SjRwZEdiSkNDTTBGTzdQRUZyZFF5VHN5?=
 =?utf-8?B?YjFKSW9PR2JjakJqcExJT3FUdVRTSnQvL3BCNjkzNEErUnhOekNZOUFvRk91?=
 =?utf-8?B?V2N3Q1cxZy9sVnJyOUNTbW1TWE52UktzQ011WTNtejNBYi9MUE9GK1hyblJW?=
 =?utf-8?B?ZlZSZTFpVElhWWtjbS9JNVlZS1VHKzc2SFZOakdJSEs1OGdNbHZCbTJ3bnFl?=
 =?utf-8?B?WTdmN3VvU3d4dDd2VXJtaXFTYVozU1RYZk9UNzNyWHVPUm5NV09hd2twdzV5?=
 =?utf-8?B?WlROb29QTjBvTkhOMW5JeUlsRVNTc0c4R3ptUnJSUkV5QWJLM0k5NEk4WDcz?=
 =?utf-8?B?eW8zL1MxK2tXeitZRkdQN2pDOGpDa1ZXcjJRbTNVek9Ec2c3TUpjVTJuL0tm?=
 =?utf-8?Q?SYQE1DbUAzjHP2TdJVHSU9fvP7OJq3U3VkEVuTX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91098bdf-8f9a-454a-0964-08d988a7845d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 08:58:51.4825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wL2n1TVXkki4UyAPHv5RGgYXR1VGi9RXBJd97EtibZy8vORcI1dV71OYqoFMUVQR5MJm6QbiSRZhjQYof2Fpug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2913
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060057
X-Proofpoint-GUID: s9TlmMqMhlZg4SxQRfJFF6qpQfzCOCz3
X-Proofpoint-ORIG-GUID: s9TlmMqMhlZg4SxQRfJFF6qpQfzCOCz3
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/10/2021 04:12, Josef Bacik wrote:
> We are going to want to populate our device lookup args outside of any
> locks and then do the actual device lookup later, so add a helper to do
> this work and make btrfs_find_device_by_devspec() use this helper for
> now.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand



> ---
>   fs/btrfs/volumes.c | 95 ++++++++++++++++++++++++++++++----------------
>   fs/btrfs/volumes.h |  4 ++
>   2 files changed, 67 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a729f532749d..e490414e8987 100644
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

