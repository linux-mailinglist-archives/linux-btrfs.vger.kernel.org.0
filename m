Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC56F3D879C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 08:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhG1GBW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 02:01:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28828 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232891AbhG1GBV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 02:01:21 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16S5opIM019838;
        Wed, 28 Jul 2021 06:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=W0DDy9gR3OWLkkxiaVGh+Eum6UwYBdSNMJY/IYuRC4Y=;
 b=IH2+JTcLNM8FnsCMTY7k7INrlr74IvCCsHWSgNEvDIg8uGNy8ly50VpE98iNzmCFDEfZ
 XB9WsPUF9S9feziAkARM7qSqnQBAOmR4wmM//6j9Yhs+/yREO6EFAbVztX9i9faFIAGR
 IKkufsGp5EOGAA27Zal+bjSJ+gFSr2tER1lCMu8QMOB8GOF5ES32e1Wa8p0rQe2/ENFT
 2oCC1jdpFbZDZWLz2xim5lK2Zn4OY7dyGAF7gfacPK18VZd0eAcodkgqBA+OFSvGmai+
 Ue87mySoySLvsjS65cHfEO8ytmXnglvEElVv6km+DX6dDa5egtzJxn//tPX+5FFy0A1D qw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=W0DDy9gR3OWLkkxiaVGh+Eum6UwYBdSNMJY/IYuRC4Y=;
 b=iMU26R9oIL7kNsKBIMfK/Od6WbxMWGfoDsGgQ3Hk4IpNNOZacg0Kqc8c7AVUx87jpiQz
 fK1XEmF8HnOsqQUVfIkQM7s2Qja/sbFq7lDqpHLVh+/ySotJsCTOcWSqiDSlwiGAdVPs
 KXeHvqNd2ldDrjGFR+javbsEzfDHHJv2F+VtN2yE+F2gxE+vcwjlQAtqCdr1n9Art5WA
 mYAR8mfeF/lAvDh6kzoAhNsNmg5KSZgnF5oFZRC0MA0If/6/Vm2Lnnv+1TdWV5zzAmHR
 StF3sFnMA6+FDwLJcvs8bA1Dp01hvMZWUJ/P0BOgAosLGP/Kdxvf6FYo6pvGfIGg4byP EA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a2jkf9tcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 06:01:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16S60vi2155017;
        Wed, 28 Jul 2021 06:01:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3030.oracle.com with ESMTP id 3a2354fjdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 06:01:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsHE0S7GiiZpDn1jjkXMTh5T4Szk9M/Se21c7kBhVO+Ut0ICqHH/O+hIXkD1TzwXVaBjYqmhjh90UcuR2cBi9HNwSfvtzmNxO8jEXWQfFd0Y5ifuZu/tpM/gkzNT8IR8IX5dIyceJWdXqjTvUs54qHHuRFcCnHYDZRlhWxKjDUmqJkgSANdBCp6JLTozhm2F3lqWCoYwnrjGTB/F5RNXJyHTTpDuG2OsIdzEdlLFvVVlpy5fcs7s8Uz3OPbmue3S+JKgVmjkM7MDYmshni8210Gw+grjZ1SEMj777jDC8Ek6H/DTeOfXIUVADMxkav+haF4P/91xQBXzqoBg5gebLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0DDy9gR3OWLkkxiaVGh+Eum6UwYBdSNMJY/IYuRC4Y=;
 b=X/13kjUCGY7Kk9CtrbEEkhHtkkPYW7BiTs+VRfV7LVJvv1xN8QF+wnqe/Wcjoy1bquDdnCJItJRZyA8VoYpK9fADoPgKXwnzzsCpDEv+Jpz59LAtgSDuQvdXLURHEPdW4107Zjlfl9Ou5iy0ZXdt1GA8PZpM0Y4VfHUs+Mr57M/8Vm+uU7RDODZRRWMKUEk5uxRccrarP5hNYSOfaJvfGpmrpde/gnQ3tyMqwmrIPMKWAfEBJ7K/fWnW3OODKOnqy46Ig1O7fboodu+w6tP6KTi9i9HkZ7RsYdZnivLcPOtdc4BI6Fj5fJjvzDvUH7dYhZ86cn12LBdACgIsY4jnuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0DDy9gR3OWLkkxiaVGh+Eum6UwYBdSNMJY/IYuRC4Y=;
 b=Zy+kdP8K08/z2l87b5gZ4yaRUthQ6tOTZVdOujIYdWX5z8rxkDHbXL0CY7IrPxL+sciNCLzdF2RCuX2HTUFlLF6UZ42+7sA8AWE/vdRSekAdDurFZrMHwwGK8+OFd7U5pXAHqtIeNeKOCaNB8shxhQ3Fk64a2JPX97CwQ4ENruA=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 06:01:12 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4373.019; Wed, 28 Jul 2021
 06:01:12 +0000
Subject: Re: [PATCH 5/7] btrfs: Allocate btrfs_ioctl_quota_rescan_args on
 stack
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <cover.1627418762.git.rgoldwyn@suse.com>
 <4bfd049f4d8956c6b257e2cf2a69373c90a0f35e.1627418762.git.rgoldwyn@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a1f6eed2-f78b-bcba-54ff-af78d99876da@oracle.com>
Date:   Wed, 28 Jul 2021 14:01:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <4bfd049f4d8956c6b257e2cf2a69373c90a0f35e.1627418762.git.rgoldwyn@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0152.apcprd06.prod.outlook.com
 (2603:1096:1:1f::30) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0152.apcprd06.prod.outlook.com (2603:1096:1:1f::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 06:01:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a4c944e-70de-4822-f82d-08d9518d1a0b
X-MS-TrafficTypeDiagnostic: MN2PR10MB4128:
X-Microsoft-Antispam-PRVS: <MN2PR10MB412890C08931A7C24E2C74C0E5EA9@MN2PR10MB4128.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oFzHab9xFK9OrjyictDjv7skK0Xx8nhJcfknvsQP1X+/1hOQRYc0uoYBVw25O14zJc+VNro5S6tnx4JT0TAzK4zuWLEukT2R/gYEdWMX9jngpIWvxtOsNOZHT0vUm0t6z7fi0/48gQi7P0pZ1uZjHHbNe634bfSMJ82hJUVo1hFVVnoW4RD2GaBBZRzCQAkjRFJ5AZSRAxdZGeXZL9siZlwzBdruzip4jRNpUMy6WonhauAWi2HxmjHpVxFaysvfV108tx9/QSi61oI6PSugBuCDbWYGbWUmaAjUQBq5K5iXjjqkLsgo3YR65pDeB6LLKLXeTfeEbAKvWZhD2H2TkQz3v0MyvBJ/ZNx5SMpu+2yA7ITay9H/XWJrKdTC5HqK51agOe+CeY5R0/muc6B3H/+4VVfQ4WEE4boH+byhLcjfs+YhNTOLS77MbBzYmkAEDv31YiQPDxBlbK9U0LV55ujRbBFArfZt9OQ00oMIBAjYWlCx9uJ4Cmjne0zV3YMWZWknmuCfAfWjL5csGwMpB8NU6R8LLReyEqfy6WkI9taEEObR6ITWS8xbdFoWCw3OyoNHs7DSA5hh6PuDyMCCryDyWAiRKVNEvE8PTRcQ99l+baI0MMcM20LSDgsY7cDNHbM2N71DXk1KStlLQD8799ENfYrCQfFbz88h+EYecju9zKx3HPOmg12K6xRFCkGy9NOd84f+zWTLoJ2rsaGhZ2nOmrsaqNxwxwmYip2KM74=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(396003)(39860400002)(136003)(36756003)(2906002)(31696002)(86362001)(186003)(2616005)(31686004)(4326008)(26005)(38100700002)(956004)(6666004)(44832011)(83380400001)(8936002)(6486002)(66476007)(8676002)(66556008)(478600001)(5660300002)(53546011)(316002)(16576012)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVU5czhrK25KWXcrMkMrMmxrSC9zRy9qZG9zUmRJeFVCdDB2ckFSWU53Ykto?=
 =?utf-8?B?eWdZNGRqc3NhVTZRRmVrZDlUa1UwU3B5Q1JDYWZ4Q2JYQ29Wa2I1MlpkRVpB?=
 =?utf-8?B?MldHMisvdHRmMDRlcmNJWnZuZjdNOUpPdk5JakE1U3JUSzF2cEd1b3djS0Va?=
 =?utf-8?B?RWtESER1bTRvTFl5UTZDdGRFeWhLYUhDWE9jTmtmY0dSbWQ5akdKeGE5VUdX?=
 =?utf-8?B?TlA3NUptNlRyQ1FINnpoYTJZdU93OUIraFBTNGhMNDF4NGxJYTdNZGpqK3pF?=
 =?utf-8?B?UkcvcW9ZNWN2ZlRMUGlKNEwxNzJDM1NwOWJNMG1iVWpaNlY0Z1ZuVURTTXgz?=
 =?utf-8?B?NTVpNjQwUGhKYk9ZbzF4VFc3U0JpRmNTS1ZHLzB4KzNuOXp4S2xRSUIvam5x?=
 =?utf-8?B?Uk1mN2ZrcEpRVFJZL21FTlIzZG05T0VpeFhXRERhekJVTDRGRkE5WnJaSmZO?=
 =?utf-8?B?UnYxdncrN0pCZXhJWUN3R0o5VWRVOWhzUE5OTW10QnY0eWVid01DMnhjSHVC?=
 =?utf-8?B?VS9NYUZRVFBuUjBTZlhoMi9HN1hxVCs5OHExeTI3WFh2ZHRlZWxFaEtZQ2sw?=
 =?utf-8?B?WWRmRllncmJNNHh2SmhBV3pVa051bHRKN0FpWUsxc1dBS1ZwRGIxWkNzL1lO?=
 =?utf-8?B?NFRFT0pTWm9OQkprWG9KOFphNjBHTkdXdTA1VkFhN2lVRktPYXJZU3JqYmk5?=
 =?utf-8?B?SlpzakhYWjM4Q1NiSzU1WnpVUVlyM0paUFB3TnpXaUUwMG5ZWkt2aHZEN0pt?=
 =?utf-8?B?WmN2NG8rQ2w4S2Z6MGhJMU9OSU4xZkdIdGE1MVAvdmlhOGtyZk9IbEw2OFNO?=
 =?utf-8?B?cytvOStSZ3VMMGNndUZ1ajZnUlo0T0t4d21mc3JtRmp4ZVFnK3dBRnRCbUZG?=
 =?utf-8?B?ejZCUFIyN2YrK2EwNkJ5cEJVQTFwenp6dm9uSGN2aCtvQ2t0T1RKemJZYmk0?=
 =?utf-8?B?VDgvVFdSZmpDaHFwZnkzTmsrMFVqVmdrcTFXYmhFZS9oeTJWWVhsV1I4NE9i?=
 =?utf-8?B?Tk15cHQ2VE93QWtBSnZ6ZHBiS3FPR2JXMWN2SlBjcmx2OElHZ3Y0R2M5djh3?=
 =?utf-8?B?UjRQWENkeVZtdkVhd1FKRjhuR0p2WEFHNjhzL0xiTUdUeUlhQWlWWUJhMDl1?=
 =?utf-8?B?aUQ2Q1VkU3JMK3k1M3ZzN1E3WmNsUmF4VnZSaU4xSWNVYnBuUE5CNzBLQi9w?=
 =?utf-8?B?K0lKdUxlak0vYXcwRWt0TFB1dEt6Sy9wUk15NHgzZVprU04vOUVKYndjWWtG?=
 =?utf-8?B?ZTUrbU1pZWh5Nmk0TUNzbEFLMnlWVFNuMGttd0VXMUMwL3JWNm9IMmxrNjhF?=
 =?utf-8?B?czhEaTJtbU1PL3d2L3R3d3NEK2VqY2RZWWMyZERmKzE3YWtzYnhVdS9oTllH?=
 =?utf-8?B?b0NUc0QvZzNVN2NrNmkxYTRranZqTUovRHdqNkVjRldHNzJkRzc3L0RZWVZ3?=
 =?utf-8?B?ZE05djFveWZaVFViZXBhNWtzSVZvZUJMdElVN1BBa1BGSHZOb1k2d2Y4SUtD?=
 =?utf-8?B?K0FGeHo1OTRDQTN3TTN5K1FuSVRieHA2aDJLQUU3ektPUE5DeEY0VWJsKy9S?=
 =?utf-8?B?RTVFdExiaW0wTWRFZ2VJeFM0dEk2dTE4aEVSbHQxWmVuMjJTUTRqR2hjNEU4?=
 =?utf-8?B?Vi9HcFVFd05QM1BnQzhuQ1lrNzM4WjFnOTBWaGQvYkhHSzBGT01LR0VjWjJO?=
 =?utf-8?B?Q2V3UXhuUDVwQ1ZmYmFJejBRSmY2VW9yYTJqaWpRMmFIeG8vSFFnLy95bGdl?=
 =?utf-8?Q?6ito4wrG2ZSmmtj5MMWgyz7UoXMlHBXhC1DWctO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4c944e-70de-4822-f82d-08d9518d1a0b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 06:01:12.0091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPA16aJ+ss3LcsLUDKS0z4obj+lxnytIZ6axrbaKBxRDetiVOVELVqCEuJEPTIvuZGRN48wYs6rMxotNDFog5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4128
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10058 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280034
X-Proofpoint-GUID: sVkO1BRmlblgT7F4fQputXpiAS3ICGan
X-Proofpoint-ORIG-GUID: sVkO1BRmlblgT7F4fQputXpiAS3ICGan
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/07/2021 05:17, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Instead of using kmalloc() to allocate btrfs_ioctl_quota_rescan_args,
> allocate btrfs_ioctl_quota_rescan_args on stack.
> 
> sizeof(btrfs_ioctl_quota_rescan_args) = 64
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

> ---
>   fs/btrfs/ioctl.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 9c3acc539052..291c16d8576b 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4390,25 +4390,20 @@ static long btrfs_ioctl_quota_rescan(struct file *file, void __user *arg)
>   static long btrfs_ioctl_quota_rescan_status(struct btrfs_fs_info *fs_info,
>   						void __user *arg)
>   {
> -	struct btrfs_ioctl_quota_rescan_args *qsa;
> +	struct btrfs_ioctl_quota_rescan_args qsa = {0};
>   	int ret = 0;
>   
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>   
> -	qsa = kzalloc(sizeof(*qsa), GFP_KERNEL);
> -	if (!qsa)
> -		return -ENOMEM;
> -
>   	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
> -		qsa->flags = 1;
> -		qsa->progress = fs_info->qgroup_rescan_progress.objectid;
> +		qsa.flags = 1;
> +		qsa.progress = fs_info->qgroup_rescan_progress.objectid;
>   	}
>   
> -	if (copy_to_user(arg, qsa, sizeof(*qsa)))
> +	if (copy_to_user(arg, &qsa, sizeof(qsa)))
>   		ret = -EFAULT;
>   
> -	kfree(qsa);
>   	return ret;
>   }
>   
> 

