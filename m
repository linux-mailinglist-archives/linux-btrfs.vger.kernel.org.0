Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E64D3D87EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 08:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbhG1Gar (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 02:30:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9930 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231484AbhG1Gaq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 02:30:46 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16S6HNuI011072;
        Wed, 28 Jul 2021 06:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bubflW+rIW+IeFFeUkK84fjIWql0D37zLOrpPPvVThQ=;
 b=THfXIFrmfL8jD0KmfPWbBNetpPqZq4aXMzOk/Dpds6Oos8qRO7mOBt2ZCLc2TbRSdOan
 iej5la+kheUNvl8JitqiKeZFut8AkvD5fFsmIUC4hLU42I1mDGGAc8AoXUvCxXtYRHqy
 NFgMTA5XujEzr6IhNeYrJA7bC3PNo7AHWyD0O2IGWuWAzas6YvGjZEeaT/1ouqVrYzTK
 QUE3HC6Lhyd5l5pIJDV02Kt7u8cmhAF23Y8bNrlfBXpu8OEdSIeq5O8i1LYmrAUtrfYX
 w98H1HON7zAohthfy4FZIt1Cvf/lF0QtK+nOpIbimb7ieOSxCmTkVPLrtE3ZUrFZPQnU uw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=bubflW+rIW+IeFFeUkK84fjIWql0D37zLOrpPPvVThQ=;
 b=NTY4eHa5FS/zFpi+aJRhf3v91rZDTzEfqvx1xVFVEV4gj2uhp3+iaAQEc+7HkYCFKnF+
 sc4qHOEmlUeehs5ds3Gr14DtTYaH/UV/USQ5cNmtmLyTK87cQM+FFLSWfLmAcv4VKY81
 ONNtLKjP358k3RtMfGEKWYHisTTTZyTduaAOkHyfs7eZ3Mxq7LDyHBX7KbtcKfDUfuzP
 Cn5W0zJTabq0IZbhS7GVgwVMm7/wB3gkgzGRHNuC3db5s2yY/LJmXHHtqrIgHRhvXW7T
 CVEi1pLcHlwjhEEL8rp85soTf2vd+58av33+nYHvtPD2t/VSOF1JDZeL6lEoEqYdz4ci YA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a234w3nqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 06:30:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16S6EwAx003796;
        Wed, 28 Jul 2021 06:30:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3030.oracle.com with ESMTP id 3a2354gtqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 06:30:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W84g8yrxXcSMwJEk7nKPG3rrLngN3rLDzzrVdT0z4BJ5aMDKaA8BRAroffJNtptF5qM9q3RDgsId64LkDEXV9LhNnH89bGJkofCSeASUr+qNY0TFB1jVN1+BjTiQSDccm2ejon3xlYWAH/3BwMbcvvLbwJ4sMXyoqCQui0AKWKG0VX9TuMYY8sw1fUDHCTPSjebkLOg/MTjeEUJ9j9bpvUJtm/46+TXt7041KqGtBVZjzEiUZBCD7IAJYg3I61rG9pAqOZtclrBcdFSm8IZRsI5pkX0a5j7rUPk5i6YcqLucalpnDXSgIzX181QoZ43lr+LuUnIlgd0K/n+PaTQQdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bubflW+rIW+IeFFeUkK84fjIWql0D37zLOrpPPvVThQ=;
 b=KJXZzYAhEHKDiciFH6jVliRyrHY46MSIoAykfM1cyYBJeO9OetrUtjk2dwMqYvhAYvL9dbv41i+CUEWmLjQ/u7PgAHep3+Yigcbn+5RLU/wnquytAmMs1OLtnLSjZ5CknC8IBJsNP1Qg5ht3fzUTN/Xy+lHSlvkSpQ8T4GVapg6n+0DFJhryOAl18Li1gpySTnVY0gTb7kj8ahcrQ/B5y/e3nlm+CgTmNs6/bKOO76Fw+VcWJ9gskKCRaKOK501RNDCerJeT3Vd+SBQGMaALfWBvf/8LSMdPe3OguAUtfk2b5oFgIqW7jhMgGQCr5Xks2Fm+YVOlCxfrFEVJKGkmcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bubflW+rIW+IeFFeUkK84fjIWql0D37zLOrpPPvVThQ=;
 b=ym9LMeziqZEqPKtYC2PTizYxzQiLYHSZrb4AWhVL2S8ZOtgV3aUkn4ySh/Gouj4lWZ5Afb+2pvZEAotI123192CY9jpmaB6CACgM9T2uepGlH/dFAO0gn0hDrLnKDBP5OJEQF5+PDhP9lqe8ukZNFJJOYRIQA2MCZthWGffCOcA=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3426.namprd10.prod.outlook.com (2603:10b6:208:31::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Wed, 28 Jul
 2021 06:30:36 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4373.019; Wed, 28 Jul 2021
 06:30:36 +0000
Subject: Re: [PATCH 7/7] btrfs: Alloc backref_ctx on stack
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <cover.1627418762.git.rgoldwyn@suse.com>
 <d1a4e43de270f291d97b1c00b7ca3b32ce699009.1627418762.git.rgoldwyn@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <2a84f005-5a23-cdd1-c0cf-a80b4882280b@oracle.com>
Date:   Wed, 28 Jul 2021 14:30:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <d1a4e43de270f291d97b1c00b7ca3b32ce699009.1627418762.git.rgoldwyn@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0164.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::20) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR01CA0164.apcprd01.prod.exchangelabs.com (2603:1096:4:28::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 06:30:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3d67cd0-b69c-4d37-1d78-08d9519135b2
X-MS-TrafficTypeDiagnostic: BL0PR10MB3426:
X-Microsoft-Antispam-PRVS: <BL0PR10MB3426C0F71644816423C8F39EE5EA9@BL0PR10MB3426.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:451;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ux478uU412A7a1cgTfgtOC/edFo6zP+M04xLrNEdGWs1e8Q9bfq4X1K+KVA2GuGwvzFHV9/XpY6kD76fWIIqLM1ADJM9KryzVJe3PY8HK4ISkETLXBtSpT3qoI0PiGWGtotbY79Uk7kbIpCxpaD3+rZ64GChdYOGk72v6FCf5CzeBybm1Iar/uz4jdpnXYHvWJedUowLdPnIxPLk2CNr017jHbH5A77SVZOOv/fQ5rEMRR2Ogg0+0FtmNxkG1nTWcymB3jMJ1vXQCs+AmymUEkql7de/HoINo7Hwb01xAg+GiXOnckndsOWbDYrtiswen2daTnR/hK1acseQPnrcPnnBzLF1ZELAq0Oxb3MyCYtpXO4Y4DKcU84Qov62DwJLNuUrzT2vvdzAtL8jPfErq5LjfvhPztiFosjlL7J5KLDXVu16seuuHT15p7MgoGUvS7Th0wDYr80+uGMPEz86oU0vdT3NUcNZs2aKWkjGJcPLD2VNnvdKLUoeWUuO44JHeLeJweI5URFB2bwvJCQJDbbN18hXhYqEb5H03IzSWlRnqUkHAOG3l7pzTdnLgTAtUVzuWtA6BKWfS7F9ncwN62R5wglMDfXqA4u70rpcFkZcosgfdoUUkUWQYA3wKroBSleqLFOH2KSZbRPgPXPIG0G7JGgPr2Bv5HfGaR1gV0E45qXEbcSXskzuzQUVl0zLKEW0An8orrkzoIHgXO25nQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(396003)(376002)(136003)(16576012)(36756003)(4326008)(2906002)(86362001)(478600001)(316002)(6486002)(6666004)(66946007)(2616005)(31696002)(53546011)(956004)(44832011)(5660300002)(8676002)(186003)(31686004)(83380400001)(66556008)(8936002)(26005)(38100700002)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alF4SzhDZUowamk2cVFlYU5QSHlDS0FrM3lJaTVWUDRKTmFQNDhCQmREWnRT?=
 =?utf-8?B?TWd5RitWZXZjaWVVQXVWWkEycis1eGZHdFVBejVSNk1Fc3VXd1o2eHBQL2th?=
 =?utf-8?B?RHhGR3JhZWF3eVNmUFRsQW9VcmNzNmk4ZmsvaVc5Qk51TktKdURKNVh5NXVP?=
 =?utf-8?B?T2hwQU9VZnB4UG9mVlVLSlRQR3dJemwzRUd2dGpjSVpzYTVTOExpZ3VTVng5?=
 =?utf-8?B?NlVZZlRZa01GUUw4SG5qWnh6UzZ2WVBVS2JRTUxBL2l5QUhpaTNuSWNYdzJJ?=
 =?utf-8?B?cjdmdnhkR0w0L2xWaERORUl0RGNRZVltLzlVL2EvdkJIV05yTERKaVJNQ2x2?=
 =?utf-8?B?azQrK2k1T0l4R0hUZnFzajhUc29FMXIrL1ZkWDJPWHZNQ0xHUUVXWHl1YnJ2?=
 =?utf-8?B?aVp2Y3Q3VUlNaVUvZkRCdFRPcmVXNExINENvQXQvazUxUVdwRFg2TnJWakxQ?=
 =?utf-8?B?MUxpNDI5S1BZL01iM0JHbE9LQm5xaTZ0S2IvTjVhRGtZd3gxLzZpMU5iQjZR?=
 =?utf-8?B?MHIxNkZEVWw5c01DTmIvbW10QWVvc3FYYytoOG0wUmpCb0YwMEhIQThFcGln?=
 =?utf-8?B?RkZNcTEyWjdCdWdPcHBKMWxrbUxMcG9YdDhqMWpKQnMrdTl5R2lpUS9TQkxT?=
 =?utf-8?B?emtOaFc1OEM0cUVoZnVRV1Z1ODVlM214aWo1NDd6ejhPbzlwSFRBMTVCaG1k?=
 =?utf-8?B?R1ZWSnhHUkJRT1NNT3BnTTBvOUIzbFQ4VXVjWUU0b2tKOHNBNS9MRmFpWjV6?=
 =?utf-8?B?enQyNGpJV1dCK1RRMmVDOTZrYXJ0WU1URHhGcVZOYlhzb0hUSlFtT0l1SkZk?=
 =?utf-8?B?RHoxNG1NNnNkVG5ObXJacDlmN1lMQlpkdWF1emg4azRES1U3OHRiYWZiUVVY?=
 =?utf-8?B?REZnZlNBNDJzSkY5OWdkcHVFSDVmZ3hQUDVZRFNiRU1JQjdmT1FNeVFXYkhN?=
 =?utf-8?B?eC8wTFg4TXI0Ym5jYzlBNVRrNHFJQ1VrUGNKaCtrZ1VQK3UzQTJrL3ovT2VK?=
 =?utf-8?B?RVVLclExMGdmOU9SZS9CdmtRYkp0NG85eXJJSXVSeGlSZGJwYXE4VTQ2L2Y3?=
 =?utf-8?B?OFFDUWQ2TklPMzJEQ2t2TTY3RlZLZzhYR2ovMVgxRS9JNU51WGdrWXFZT1FT?=
 =?utf-8?B?Qk9CSjE4SU9uRWMvZFRxM0txOG82SDRJdmRHbVpDeEc2S21PaWd1VVVJTGZu?=
 =?utf-8?B?cEdBbG9ST0RZdGxrUE0zVFN4RURZalI5ckZocThrdG5ETkM2ZTZtdXI2d1Zq?=
 =?utf-8?B?NHBaOTMxMUwvanpveUNCb2U1aFBCVTZlUEp2eG9udXhGNWFCRGt0dDJvWEdN?=
 =?utf-8?B?NG5qK2dFLytHNVluUk40cTRpT2l5Y3FEUk5jWkN4Skhrb21sZ2NMNnFXckwx?=
 =?utf-8?B?SmxNaEZPaHkxNmRON2RwRmdJV0lSdDg1eUFlN2x4ckZ2QzJwT0JVcy9jdWJk?=
 =?utf-8?B?Zmx1Tkp1STZHbFVzSHl4Wkd6U3RzOWVGK2xKTjVMWTNmYTUwbURaN0RUQk5T?=
 =?utf-8?B?WTYvYUh2dXFkbE91UUxyUUVRZkZzeUJZT1Q1eHk0UjdiK3Zaa0tsRzdSbloz?=
 =?utf-8?B?dGE0ZEJpUThhUWxkVDYvYjJGUC9QckUrdHNSckNUUkkwOUJCVmFwWHRDZ2lI?=
 =?utf-8?B?c0ZLbTcrOUc2NStFKzAyKzFmajhqMUxuakhrY2k0K1NjdENvdGg2cm1rYm5H?=
 =?utf-8?B?bTkzZGxnd3ZHdUV0SENuUEVxcFhzWHpuN21HdmFOWG1YT0dvWE5ITVN5c2Qv?=
 =?utf-8?Q?0pmeTBLYx8kbjs79yz6hWgwfDErIfu9Nc6tbB31?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d67cd0-b69c-4d37-1d78-08d9519135b2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 06:30:36.3296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtzH1dND0cwa06qB9lVHMcpEnweGSwdFOGyjv4Aprh0jpH63rrSvGf3qhGmd/TV9HKmK9rmOomGjKTgLtHES9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3426
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10058 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280036
X-Proofpoint-ORIG-GUID: _qPyXysIla1rDk8a4xWZ53m-LxBKLD_I
X-Proofpoint-GUID: _qPyXysIla1rDk8a4xWZ53m-LxBKLD_I
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/07/2021 05:17, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Instead of using kmalloc() to allocate backref_ctx, allocate backref_ctx
> on stack.
> 
> sizeof(backref_ctx) = 48
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Looks good.
  Reviewed-by: Anand Jain <anand.jain@oracle.com>

> ---
>   fs/btrfs/send.c | 29 +++++++++++------------------
>   1 file changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 6ac37ae6c811..e0553fa27f85 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -1307,7 +1307,7 @@ static int find_extent_clone(struct send_ctx *sctx,
>   	u64 flags = 0;
>   	struct btrfs_file_extent_item *fi;
>   	struct extent_buffer *eb = path->nodes[0];
> -	struct backref_ctx *backref_ctx = NULL;
> +	struct backref_ctx backref_ctx = {0};
>   	struct clone_root *cur_clone_root;
>   	struct btrfs_key found_key;
>   	struct btrfs_path *tmp_path;
> @@ -1322,12 +1322,6 @@ static int find_extent_clone(struct send_ctx *sctx,
>   	/* We only use this path under the commit sem */
>   	tmp_path->need_commit_sem = 0;
>   
> -	backref_ctx = kmalloc(sizeof(*backref_ctx), GFP_KERNEL);
> -	if (!backref_ctx) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -
>   	if (data_offset >= ino_size) {
>   		/*
>   		 * There may be extents that lie behind the file's size.
> @@ -1392,12 +1386,12 @@ static int find_extent_clone(struct send_ctx *sctx,
>   		cur_clone_root->found_refs = 0;
>   	}
>   
> -	backref_ctx->sctx = sctx;
> -	backref_ctx->found = 0;
> -	backref_ctx->cur_objectid = ino;
> -	backref_ctx->cur_offset = data_offset;
> -	backref_ctx->found_itself = 0;
> -	backref_ctx->extent_len = num_bytes;
> +	backref_ctx.sctx = sctx;
> +	backref_ctx.found = 0;
> +	backref_ctx.cur_objectid = ino;
> +	backref_ctx.cur_offset = data_offset;
> +	backref_ctx.found_itself = 0;
> +	backref_ctx.extent_len = num_bytes;
>   
>   	/*
>   	 * The last extent of a file may be too large due to page alignment.
> @@ -1405,7 +1399,7 @@ static int find_extent_clone(struct send_ctx *sctx,
>   	 * __iterate_backrefs work.
>   	 */
>   	if (data_offset + num_bytes >= ino_size)
> -		backref_ctx->extent_len = ino_size - data_offset;
> +		backref_ctx.extent_len = ino_size - data_offset;
>   
>   	/*
>   	 * Now collect all backrefs.
> @@ -1416,12 +1410,12 @@ static int find_extent_clone(struct send_ctx *sctx,
>   		extent_item_pos = 0;
>   	ret = iterate_extent_inodes(fs_info, found_key.objectid,
>   				    extent_item_pos, 1, __iterate_backrefs,
> -				    backref_ctx, false);
> +				    &backref_ctx, false);
>   
>   	if (ret < 0)
>   		goto out;
>   
> -	if (!backref_ctx->found_itself) {
> +	if (!backref_ctx.found_itself) {
>   		/* found a bug in backref code? */
>   		ret = -EIO;
>   		btrfs_err(fs_info,
> @@ -1434,7 +1428,7 @@ static int find_extent_clone(struct send_ctx *sctx,
>   		    "find_extent_clone: data_offset=%llu, ino=%llu, num_bytes=%llu, logical=%llu",
>   		    data_offset, ino, num_bytes, logical);
>   
> -	if (!backref_ctx->found)
> +	if (!backref_ctx.found)
>   		btrfs_debug(fs_info, "no clones found");
>   
>   	cur_clone_root = NULL;
> @@ -1458,7 +1452,6 @@ static int find_extent_clone(struct send_ctx *sctx,
>   
>   out:
>   	btrfs_free_path(tmp_path);
> -	kfree(backref_ctx);
>   	return ret;
>   }
>   
> 

