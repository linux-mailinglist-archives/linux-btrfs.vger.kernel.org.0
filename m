Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308603C6787
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 02:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhGMAmR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jul 2021 20:42:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26546 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230099AbhGMAmO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jul 2021 20:42:14 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16D0XSIs010374;
        Tue, 13 Jul 2021 00:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9OrhdPjVtblWLZZNoOmg94UTPVTlwg9//EXOvrrvSqo=;
 b=0KWEt5QVqReQP7wagBXhRN4UjSmPWUfXcxPh+eNWixMTwzyEcl8QYzJ+ttgBXmlkOPHE
 XLXhDAG5Q6e/fvzyLQ1PBqKKd6Vjew9XmznpNgya+EIaGe4stQYIw4bcUOFZy9q7we50
 iqLwQP3brcMB252izwNHDVAvKhgFFZ+slRZIhfvjEiN2T0+ztPie1bAKSLjHrFD3p2iH
 gVDSyVDRVTLRotArdGmFReaUityFvlQ17MHTSJsEMi1V6zvB2LEe4LuDJUbK7OeHG4wh
 Q0Q/PvcKi4PfRdFSJHaSW9/o0clPczQ5p0NIVujjHxOUobh/+0XEcoHqKV9YcbmLvJX3 0w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39rnxdhcnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 00:39:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16D0UrcC132301;
        Tue, 13 Jul 2021 00:39:21 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2049.outbound.protection.outlook.com [104.47.56.49])
        by userp3020.oracle.com with ESMTP id 39qnavx1vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 00:39:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpcW0n7qA3Bn0GPWcBab+HmbtggO6vYFvbrb+pmyocHL/d/vI4saSPSx8rmrcjhqpHjxzUd8+Ei2o4pdqdVZVqYS/ap8NLNmGkv5TS2BpK5jVBNp4nuGQu9iHPdz2IqoJH0/L51C/KKdW07+tEJCZqcLgxV+iqm6Kg+W/PcGnqmUwJo85kGgvlNui03YXGY8irOf4oD3XZWEDrNxHWvTJuaIpdjwgYjp8G/s+n5uGknmwSRhqtkLj1ncZW8O+D5jzCC2fTKKTjUJWhVn8W8/SBV7SnkYdkTkdY3y/60arVXKffzSkZ6es0YrBG4xvtoMyV6t5SloJvDGrtOx1KwUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OrhdPjVtblWLZZNoOmg94UTPVTlwg9//EXOvrrvSqo=;
 b=O4dtjUWbLPUKf2wRyY5InBO+TPf0gHduXUbPpa0kekWkSNKjQUHi9W6TicCLmojtH8Z5Ro6RIKv6B1VcihGfh6RB+6dHtU49CBXKXcNo1tHyO7A5B5Gns9g8ZKTylU8m9t+rbacO6jpeIBKGFUctfpckzf3m1KeH/0EpJhDLhN6d2rE8sTAZtcNSHTy6lWTISxZdf08txDN9DDCPdVEKAlPAUjE8q2skIQ6hsHIPeKK5KtmGXweKm2zUoOxMCqrXNNmQ/57xcSEQPkYm8bMrWZCKeK7qZbgJisQBZjvfxTKv6W1Ka0kB0Xp4PFqmN8yuL+o4lRzx/sU674gPEbLaUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OrhdPjVtblWLZZNoOmg94UTPVTlwg9//EXOvrrvSqo=;
 b=iWa5xttkxj1rBzjsAdD2F3xkEFecHrgCHweCiqcz+hx+9+HUkSFjVXPuDX0Qv5N6VVRt7JEe0ElOcX8bDBUAxCUtqLSALCkz4joFnXJC2NmNWcqRDvUpAKeuRsXKlp00oIo+H3YN/7LKXLCQEeBZlmWRjxrRldhsj1nhJAD8E48=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5092.namprd10.prod.outlook.com (2603:10b6:208:326::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Tue, 13 Jul
 2021 00:39:19 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%3]) with mapi id 15.20.4308.026; Tue, 13 Jul 2021
 00:39:19 +0000
Subject: Re: [PATCH v7 12/17] btrfs: reject raid5/6 fs for subpage
To:     Qu Wenruo <wqu@suse.com>
References: <20210712083027.212734-1-wqu@suse.com>
 <20210712083027.212734-13-wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <48002cc6-2e0f-e6d1-11b1-ad156bd40cb6@oracle.com>
Date:   Tue, 13 Jul 2021 08:39:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210712083027.212734-13-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0216.apcprd06.prod.outlook.com
 (2603:1096:4:68::24) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0216.apcprd06.prod.outlook.com (2603:1096:4:68::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend Transport; Tue, 13 Jul 2021 00:39:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 559577b7-d6f1-40f5-c5f4-08d94596a680
X-MS-TrafficTypeDiagnostic: BLAPR10MB5092:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5092912AB8C987268A594F50E5149@BLAPR10MB5092.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVkyp/B1XXMmlgebh1fAL548lS1sGd8kUNR8DBM+0tGSu6pY17sLi5CCkSplUCsTjoiVCb4srlfK/d8Hoz01+uxx4iYmu/XDKmTUYbnRyCJf0YT/8zoa7xPaCtSj8zJtDJEV7aaVbG5r6ye+BgG1xhLtVLkSagLm7dHaBsUFl1HusBnqthpQTJI2MvGhihuAvUXYV5C/Jv+B7cvfPKN5UaPPr/ZIFIXzpjnqUMezY3yuIq0KZhrgQzNMdkItLowTzy6kip8TxjbsqJwFcZC06j2zPOZN51E71G8C2HQ8t7tpC7TC3TBACNv3es3haEyT80y6tV8C7VdASbEznxr4dKYOK94wjBtOrnZWSwfeXd6DQ4HeGg3+AiL39h+isTecMCmO6KflmB33V9KWYkPz6dACVkkryd7DLQka9ao+cNNKy67tEefrpU9AToaQgJWjpwgKs1gJ+BHD/OPZkKA15gKn/O+4MJpKVZQQKvalOV8Jbhe7e2FgIGuZpPhxgMYA0jECZZUdEwBFpJoajAHeRK+pQU/kDwnqemIElynAyyBCdHoHG8s5ypy8Feu1jK2UM8aUAfSD18DebEX8T+6D0moVCkMtY6ItwXE6OAJE8kwWh5q//EFO5cM7CFBaI7lMj1hdIHdnrAlB3CoGp+97ly4hh3k2xKH9Zf233X0E7vztZFDdRkXeaDxfwHBs6XfvGyuOd3iDinbypjYC5+Omfw3cpOEMo1j+WR8+Pptmis8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(39860400002)(396003)(366004)(5660300002)(66946007)(8676002)(2906002)(8936002)(31686004)(6916009)(6666004)(2616005)(66476007)(66556008)(956004)(16576012)(36756003)(4326008)(31696002)(44832011)(6486002)(53546011)(38100700002)(478600001)(83380400001)(86362001)(26005)(186003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXZMZkQ1TDJRRzk1SDk1MjV1ODhjejJKVTRSb3h2VG5ud0l2ZUdLNndGRzZi?=
 =?utf-8?B?MnFIbWdqSk1HMlo4elBvZ0xJRnFGTU5DNmh3RXdFazc0Q3ZCTURmV09NbER1?=
 =?utf-8?B?QVVxZlRXY1VPR0FZdCtDd09oZmtzZjNVM2lId1NwVzJwSWhyZkE2VldrLzVi?=
 =?utf-8?B?YjNBNHhTeiszeDhFejJ2Zkt0OGU4Qi9RODB0ZlAvVDBYY2NRdVo3QXZmTThs?=
 =?utf-8?B?dC9NVThabVI1USt3OThyMzNTQmtRYUtXZFNqNGxuQXEzU1VVajJtNzlRUldv?=
 =?utf-8?B?WUNZeEtDbGNhVXRWMk53V240andqeGJ2OVVvN1pOSUlZcVNnVWZRQlRXQmt1?=
 =?utf-8?B?Q3JScXhvcmtZTGsyMkJoeFZLVHlwQXFlcDV5Qk9VRVhZM09sRVJPU3VzZ0NJ?=
 =?utf-8?B?d28zNkhwY1hOZTk0eEtuSE5XcFB5ZSs5d09MUHNqV09xa3lVTW5GRFNpclJS?=
 =?utf-8?B?aEZrbWNHdFRwdlJiTkpSOU9ZcHB6SllSeWV6bmlHVENGZ1FvcHdDWGNXV1M1?=
 =?utf-8?B?QTlhR3JNQW1QaXBORjQyVWd5aVhDSFVqMzl6Z3RndlIwaURUQjhNOWpzcjJO?=
 =?utf-8?B?WXcrRTV0NVlBdFQraTBBV29WV2NhQTNoSnJSWUJqdXgzRk15RWhJQVQyakZL?=
 =?utf-8?B?Nmw5d2hjRXVHNzFMTmlCQUVXQkgxSndyMHdCYkpKOGdyVEl0NHFPelBubGRK?=
 =?utf-8?B?cEhwK3BMTkMrZVo2QnBuNlFVOHl6cTIzeGNSbldzZFkzRFk1NWFtbUc1VXhu?=
 =?utf-8?B?Q01JKzdVem9LcFFlSGxqcGg0SUtrbFpWRE1oRVFIMExrdzlQUGYzdXVxcXhl?=
 =?utf-8?B?WWxDdDZUckpBOUZKYVZBSlBsUmxJWXEyRHBsNVhRK3dhUngxNmd3ekNla0t4?=
 =?utf-8?B?dlBsaVdUT3ZjWHc4NGN4Z2laOHBaMlhaWFpndlFsVUZQNEh4Vk1JR2JHSUdT?=
 =?utf-8?B?NVlIZm1tVEpQcDhDMUhLM0Q3a3BCMjBzWXNHVHp5UHl3WUxlUFhJQzdTaGRE?=
 =?utf-8?B?RHcyd2tOTVVCMEkvN201bGtMQnNucm1GZm02blVUVzF2ZkxLTmdLTWkvUTVT?=
 =?utf-8?B?eWdVUDgrb3lSTncrenVYdGJFV0xia2hrTTlXSHovd1FTOC9hM0hGODZtM040?=
 =?utf-8?B?U3Btd2tXYlhDcEd2bHpFejQzWEZjaURzQWNJSS9kMFNic2x4bXJWVlJWbFBy?=
 =?utf-8?B?OUQwK2R1ckZicjhDWFA0NnpQTDhZd0E2NUxKSHhmVm5ZZVNNNVVNR0xGblVU?=
 =?utf-8?B?TGR3NDRZenpXRTRwOXk0NWtXZUU1OWM4Sk90VmVJQk8xRG1QUnU0V1NOWElp?=
 =?utf-8?B?dzNtVzltQUI0NUlHRk1UVG9WRms1cXNzVDVDTVNIaC9PV2poVFFpOFRrbmVC?=
 =?utf-8?B?eUtOM2Fuai90TVUzbWRUa1FRKzQ1aE1STWd4V0hObkplRStaZ3Z4U0ZTdEx4?=
 =?utf-8?B?Ulo3OUFzRG50YkY2bjhKbTdxZ2lYKzc3WjlmMkJpdFZkM3VDMkFpY3d1bllR?=
 =?utf-8?B?aHdYVkI0dUp1b0RoTU8zQVk5ZkV1dWlpMmVNVmhFNjU2ZU0vTG5SSWNmOHJR?=
 =?utf-8?B?dHR3amJkT0dIQXZPVFprU1M2S0J5NjVlL0k2MHN2bTlYRGs5QW0xVkpqemFK?=
 =?utf-8?B?UFpJdHRSR052dnZlTnlYV29ycm1JWG56dXZOR0Qyc2pTaHBVS0NOd0Qzb0hn?=
 =?utf-8?B?WTE2MUlYbE9SMlZ1WldBdktsRXpraTNOTXY0dmYyaVQ4TTNHZk1XakEwWkZB?=
 =?utf-8?Q?p3CKHcZ/GRzu0Tc4s1xu2wHFThdX/F9I+FkJ8Dt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559577b7-d6f1-40f5-c5f4-08d94596a680
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 00:39:19.5969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J80T6m8Co0w76sI5rVdUBZdndNgFtVT5qhdvZ3aKldH53RQN20FX/HVUM0qW+l+KvoV5UXDl0Bukk/3vmf7N3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5092
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10043 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107130001
X-Proofpoint-GUID: 5mu710L9k60L_lI8tnDwSZaGdc940llp
X-Proofpoint-ORIG-GUID: 5mu710L9k60L_lI8tnDwSZaGdc940llp
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/07/2021 16:30, Qu Wenruo wrote:
> Raid5/6 is not only unsafe due to its write-hole problem, but also has
> tons of hardcoded PAGE_SIZE.
> 
> So disable it for subpage support for now.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.

> ---
>   fs/btrfs/disk-io.c | 10 ++++++++++
>   fs/btrfs/volumes.c |  7 +++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b117dd3b8172..3de8e86f3170 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3402,6 +3402,16 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>   			goto fail_alloc;
>   		}
>   	}
> +	if (sectorsize != PAGE_SIZE) {
> +		if (btrfs_super_incompat_flags(fs_info->super_copy) &
> +			BTRFS_FEATURE_INCOMPAT_RAID56) {
> +			btrfs_err(fs_info,
> +	"raid5/6 is not yet supported for sector size %u with page size %lu",
> +				sectorsize, PAGE_SIZE);
> +			err = -EINVAL;
> +			goto fail_alloc;
> +		}
> +	}
>   
>   	ret = btrfs_init_workqueues(fs_info, fs_devices);
>   	if (ret) {
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index f820c32f4a0d..279d5048b092 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3982,6 +3982,13 @@ static inline int validate_convert_profile(struct btrfs_fs_info *fs_info,
>   	if (!(bargs->flags & BTRFS_BALANCE_ARGS_CONVERT))
>   		return true;
>   
> +	if (fs_info->sectorsize < PAGE_SIZE &&
> +		bargs->target & BTRFS_BLOCK_GROUP_RAID56_MASK) {
> +		btrfs_err(fs_info,
> +	"RAID5/6 is not supported yet for sectorsize %u with page size %lu",
> +			  fs_info->sectorsize, PAGE_SIZE);
> +		return false;
> +	}
>   	/* Profile is valid and does not have bits outside of the allowed set */
>   	if (alloc_profile_is_valid(bargs->target, 1) &&
>   	    (bargs->target & ~allowed) == 0)
> 

