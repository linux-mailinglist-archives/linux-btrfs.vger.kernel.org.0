Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943FF3562A6
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Apr 2021 06:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhDGEkn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Apr 2021 00:40:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40014 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbhDGEkl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Apr 2021 00:40:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1374ePTE152597;
        Wed, 7 Apr 2021 04:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Ha5oKNo4QirhhmCx5sdkiBEeI8MgDN7kRnfHfY9zrZQ=;
 b=gb/pcjbSR/K4rhvwqx4pnF3LiuYu8aThUsFUD9stSjOKv9YkQO6+SiK+dvzLr/jg4dtT
 OD22nnZIKcM31Y75UsDPoyhVz5TXTnxBzVDQIdRLV3tsHW7EmCcq9vgCuNqhvNgF43wH
 jUDMMvqkObxGOFdCur02kPv8YGJVR7RWVuNLobXZH76n2E/vDk6gTl3DonU59iAzQ1f+
 jYAC0E/w74kgST/XDjaERLa+2WBFr9qyiLn3g9HTr0Q5EIlBDlIcFzr4sJa6lJxn3lF2
 u2cbT2cu/+pyQD/9twFsc0/06VbJMw7Mf3wZkxzIkwgTIdjEVbGGllFP9IlSzdZERNXv rA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37rvag93y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 04:40:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1374ZHMA045208;
        Wed, 7 Apr 2021 04:40:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3020.oracle.com with ESMTP id 37rvb38nhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 04:40:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/2+ateO4r9CRheTGXi1UQLRlS903Jy6y788/k+Jmc7X9EY9b5u0Id5/jG8pLwR0yE9XmGGw19KRTS0dddUEpAsF8uJs68uAwVC0EK0POAqi6z8Jy5+IPnDGIes5GuaYk+uMIFS6KiYdMtkqWurneZ8na1PMAWDx4Ww1QS4outkoCSfyr//aFuSTIuLXtCItZ6yeX1R2N9wLMqG3iowbcUB6TPvMCbGnQzcTTR6WqfWbp46C3E+ghHIq0U0MkJBgBC8y8EC3vf0dd0K1a5ZhLiw/zTTK0cdeZ9wUPcIybbLhVjfn3EALNmQKH5CzOKkYS3Ng5eoTeYOtfNf6LpeGZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha5oKNo4QirhhmCx5sdkiBEeI8MgDN7kRnfHfY9zrZQ=;
 b=UdLE96lmc/h64S6RQksxmzwFAcUZNyc5lNKIJEPZtIeSmpUU1HbBVH/nSjKXzQOPFnDL3+LiUBQwmOHRp9g63nNmwQ/+H9PqrxCGrby9OnvHfZ9xn1S4Po9v52YM50KW6mudar0W9s9PGPb2/nxJ9IfLQAO5Rk3BUgo643apqYifa6ijMvFyA7XEJqyHBxLM6uihouPJQo6j1RArGaD2o2R/AN9kK8SFw8ZczItHjxSgRteV5B89KPGmVvJqrL1fHcI3Czk8r1McAMJb9jjtvyE4thdzJCsf87cMUcdOB9G0X84qmfUb92asWiFh/lUtE8HsY3ICclbb1PaiMm8Klg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha5oKNo4QirhhmCx5sdkiBEeI8MgDN7kRnfHfY9zrZQ=;
 b=RSUdz8DqoWLocRrHWwanLDSCtEqI9PaMYTssNt4YfDb+5UzANT8UoJPSH1safhc+YvOQ6mmLTmgfXZHXrfsqx2S0m96GAbV4nlbLSkvOcB3QH4TQnorkJ7lcdybZgJ7vywPbHnMAYCVi/ygmRBVm7oHtgZUv/JxxeyO8/+wxyzY=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4125.namprd10.prod.outlook.com (2603:10b6:208:1df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.32; Wed, 7 Apr
 2021 04:40:23 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076%6]) with mapi id 15.20.3977.033; Wed, 7 Apr 2021
 04:40:23 +0000
Subject: Re: [PATCH 2/2] btrfs: Use reada_control pointer instead of void
 pointer
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20210406162404.11746-1-rgoldwyn@suse.de>
 <20210406162404.11746-2-rgoldwyn@suse.de>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <9eaa72ae-378e-0898-e64a-137f9f230e38@oracle.com>
Date:   Wed, 7 Apr 2021 12:40:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210406162404.11746-2-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:e825:e63d:5d8c:fbe6]
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:e825:e63d:5d8c:fbe6] (2406:3003:2006:2288:e825:e63d:5d8c:fbe6) by SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.4 via Frontend Transport; Wed, 7 Apr 2021 04:40:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a596485-fc7f-4aa6-408f-08d8f97f4182
X-MS-TrafficTypeDiagnostic: MN2PR10MB4125:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4125FDF4A339181527E2A474E5759@MN2PR10MB4125.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9C4u8tdB+eV9fGfzGtxZ1Z83MPhwls/QLwOltSubMKPNffMrF9qTYLy8km2D9kYJ4SiYfRP11mghars/H4WPNmJvTrCQhtZDgATSNDaTbxPimO2m+KhlpGKuzCCX5hwI/GRyouLwFSIrk7EhtIifYKvZs7npyjS++rVQJ2vZQi6x8SvlE+GhT2w+5+naHUOSbGTYNOsK1PdzUd/XrPUvtyzhKoSVqX5eEJJu/63wAURedBIaWV2m4VtGr3tFW4W+OuBjhbEDlFI+aDou5YW3YU8HBr6y5jzdvagBjiCWFlkCSE1nck0LF2t3vdPo+klIDXzNUtMty2zOonyUkLYaBcXuNhhKMLp0R414frRmkSgmCIsb4Uw0/jnNSSSpmHSZicbR8ubANGjmjiuvu0Ch1O9zv7cNgZZO+dWO38buu1XV9E5oVRVl3adad79eEumSmstHyqUcFUBjeZi6CXeOsyVpfK6k56aF894GgBNurzYkpYE1HH7vg3CZsrmttS5u9LOqENZIKipoebVwEMN+7EOm0qTgbYMumg4JXTrIsb2FoynST5Yt/x/zzEgDHHE/IVm/T2xcge1ZK+MDCLY9OkygUMxv6Oy+A0tFAc5pjxigWR9+X4eR5OiSB67xVWLExR11KUhkgGDU+YGCz1P6/MWu7P0Xoa9VMSVuHKU3tdEwPiq4tjWPBr2sxcosnSIcMqCoKCOoQeUv23Oz2D42g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(39860400002)(366004)(83380400001)(44832011)(66946007)(6666004)(36756003)(53546011)(66476007)(2616005)(38100700001)(186003)(2906002)(31696002)(66556008)(5660300002)(8936002)(16526019)(8676002)(4326008)(86362001)(6486002)(478600001)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YVRocnlUeUo0dEJhNTBQd1ZpSEdPL2xEQnYzUWM1b3paQ3NKSlJRckM2U2Ni?=
 =?utf-8?B?enMzbmt3b25waVN0NnNqQkhtVVpnMHZidjJxVXo2NzVtZmNrNFd0RGJBYUpu?=
 =?utf-8?B?YVVnbXlzUk9id0lzVEdKY3Y5Wnl6aHNLNk14ZkFHU3J6dm5oSk9jOXgvb2Uy?=
 =?utf-8?B?TERmeGVISU9IN3RTZmRxY0toWWdvNlc5dnpGL2pLRG9HTnlOb2lNTlVWMzlX?=
 =?utf-8?B?ZE85SXBtNXNwR2s1N29EeDk4WUFhMGZFeGtKTldYdkRsMFRtNFE3RklzdDR0?=
 =?utf-8?B?OUg5OFB2WW9qWmtFSE9teGFNSXhrK0hZNW5ZemVLTUJLcE1MekZOMEdyWFZj?=
 =?utf-8?B?c0hBVjV2WlZvL3lWbXZ2TmVTOExVZUdJRSt0MHBTRXh3RERzVGxZOVhUYlcv?=
 =?utf-8?B?UHV0SExhTVhIOEY3Z0pJeGRRaTdrRWNGb3NXNExBVWZJZktoeGpIT3E4TUNF?=
 =?utf-8?B?L2crb1VRZWcxY2RuUTd4Smc5cVoreUViWDNTN3E0MHBVdkd2bnF2TmpVZnM1?=
 =?utf-8?B?amFSeHlLdWtTYW5RbFh2aUkrdTkvV0dzUEJVZ25oVzBTYzNqS0x2aE8yZG9t?=
 =?utf-8?B?MUdtbjQ5a2llOUVmSWM3clNMSUI5N0w4eGl5R1psbURHMU93SFpqc3B4Y293?=
 =?utf-8?B?QlhoNTFUdldBSjgvN3VHSDdoU1ZYM3VTVndNOWxsN1pUVUNaS0kzRkVVVUtM?=
 =?utf-8?B?MTBUT2VkQldLQmVhaVpDM2hBcDlZd1VsbGhwcEMxOHlRcURKMVdIMTB0ZCtW?=
 =?utf-8?B?Wnd1U0tUS2lTM0drWFlLL1VQOVJ5aU1ia2ZDOXFiYTFadGltMGt0ODJxTW85?=
 =?utf-8?B?cUZDUEo3TWNIaGhMOXRuYjhsL0ZzZHUwSDRFRGhwb3NveExlTEVkSVVua09I?=
 =?utf-8?B?aHlvRTRITlEra29EeE51NFhQWmFkNW9pYkRpSmZ3ZlJyMGJackpGRUpXZ1ph?=
 =?utf-8?B?bUtET3FxTzI4MUNzc0dJZ1BueE14N2tmL3I3L0J1SFJ2TWh5UmtqWHBLUzhJ?=
 =?utf-8?B?Q0hGUkllRWlwV1l2eHFZQnFIbTdsNVNua1lucFVBSXNpUDFmK1hJWXhRbjhm?=
 =?utf-8?B?WjZOQzd6ZDdwQXV0WnNBQmt0L2doV2hkZ2VscGYvNW0yUGRPTlQ0WHlKQWpn?=
 =?utf-8?B?dTlFeFcvMVJRWlRMeml1WmY0WG04UUgrVjFhZzUvdjRFd3pjR1NzZEI5bEto?=
 =?utf-8?B?OVBkY21yQ2FMa3dkSnpOWC9JV2VMOW5NdlJQbjBaSXVxWVFjTzhJRnRndkJw?=
 =?utf-8?B?Y3l5QndXdk5wTGRWTXJvOEpWUnZGcnVXSGpxaGxyUnVpTFN2bVcwcHk5UVB3?=
 =?utf-8?B?b2lMSm0rQUlhZzFzbGs3OXRLc3BuZHVjcmZ6OEZuV3Rrb0NXWXdNeE9lb0Nt?=
 =?utf-8?B?a3BzMFROUFpUWmZvbElram1SdmJRZW9GMFhTaGNHR0NpVnByMG1QbE9RZUJY?=
 =?utf-8?B?NTVvZU83K2pBTmtCdUROYSt2THo4QTgzM2FJNUVaU2NjeWtVZGpzNHZnVWpO?=
 =?utf-8?B?R3NBSDBrMFdLeUVBNysrSTFvL0VEM1VWSmZGdnB2KzhqNCt2WFMyYzk2eisy?=
 =?utf-8?B?YzM3T0FDVlVEUmRSZ1BqUGs0dlc1RTZnMmNPZklvRUdiNHR3MEw4ZTFIWk9v?=
 =?utf-8?B?U1JiZTBVcGorNHZnci9US3crcm8zMnQ0WWVEOE1hZlhUd1c0ZExqd3ZoZm5h?=
 =?utf-8?B?aEZXMWNvNkFGaURtRWx5d2hDSW0rK25kaEpCMnM5bGc2WUxUZHpqNFdaaUNt?=
 =?utf-8?B?NlZsMndpVFFPK3laWnFURFFHUDB0YlVrU0ZHUVVsSDVEMmlNdUhLVGZES2tG?=
 =?utf-8?B?aEVHVDVna2RuL3ZGQjdGbVkzc2h6cW9Tc0JBL1REcUkwQ1dveDNGdG5qdmtB?=
 =?utf-8?Q?sZZQani+CN5ac?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a596485-fc7f-4aa6-408f-08d8f97f4182
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 04:40:23.2255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: piYpoSSUL3bVeKDdfwHRqX6vGjhM+Qs0yFxmoYZrjg/8ELkUBP4mPtR7CWL6eYcrk5HXiu41R0EkQhrXugjtpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4125
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070030
X-Proofpoint-GUID: lVP7qIuApIJJrg4XPkDK3WLDJdZXbREQ
X-Proofpoint-ORIG-GUID: lVP7qIuApIJJrg4XPkDK3WLDJdZXbREQ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104070031
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/04/2021 00:24, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Since struct reada_control is defined in ctree.h,
> Use struct reada_control pointer as a function argument for
> btrfs_reada_wait() instead of a void pointer in order > to avoid type-casting within the function.

yep.

> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>


Reviewed-by: Anand Jain <anand.jain@oralce.com>


> ---
>   fs/btrfs/ctree.h | 2 +-
>   fs/btrfs/reada.c | 6 ++----
>   2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 2acbd8919611..8bf434a4f014 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3699,7 +3699,7 @@ struct reada_control {
>   };
>   struct reada_control *btrfs_reada_add(struct btrfs_root *root,
>   			      struct btrfs_key *start, struct btrfs_key *end);
> -int btrfs_reada_wait(void *handle);
> +int btrfs_reada_wait(struct reada_control *rc);
>   int btree_readahead_hook(struct extent_buffer *eb, int err);
>   void btrfs_reada_remove_dev(struct btrfs_device *dev);
>   void btrfs_reada_undo_remove_dev(struct btrfs_device *dev);
> diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
> index 0d357f8b65bc..9bfa47cd3920 100644
> --- a/fs/btrfs/reada.c
> +++ b/fs/btrfs/reada.c
> @@ -998,9 +998,8 @@ struct reada_control *btrfs_reada_add(struct btrfs_root *root,
>   }
>   
>   #ifdef DEBUG
> -int btrfs_reada_wait(void *handle)
> +int btrfs_reada_wait(struct reada_control *rc)
>   {
> -	struct reada_control *rc = handle;
>   	struct btrfs_fs_info *fs_info = rc->fs_info;
>   
>   	while (atomic_read(&rc->elems)) {
> @@ -1018,9 +1017,8 @@ int btrfs_reada_wait(void *handle)
>   	return 0;
>   }
>   #else
> -int btrfs_reada_wait(void *handle)
> +int btrfs_reada_wait(struct reada_control *rc)
>   {
> -	struct reada_control *rc = handle;
>   	struct btrfs_fs_info *fs_info = rc->fs_info;
>   
>   	while (atomic_read(&rc->elems)) {
> 

