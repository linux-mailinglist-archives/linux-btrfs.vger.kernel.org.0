Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E26130EEFD
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 09:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbhBDIt6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 03:49:58 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38582 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhBDItU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Feb 2021 03:49:20 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1148igdX008248;
        Thu, 4 Feb 2021 08:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=5EwWBBM2IPvJcVpfLryiQzrs+5eqEh9GKAVISuno9FU=;
 b=VXAqpDtIcFiVzxopwIILpUDz9VWYMm1iWJuxvbRYp7Ob3IRCstaXuMMC4UlPbNk0BAFQ
 Xlj06sxASZjGJ587Yj9z7CxocvpqQ+V6+/EPJSjxPUBaGCO3NZ31/U8+7wHtwia2R/Vs
 jmMYfxtiEDCCGHVpWUly4NKvFQpK1usW2+1TzM6syMegvvC1nxjtYzAj0u8IPWbxmPIl
 c0sGtsrLSc9UAu+euUzpjIh0cWSx0ioYBN+AGDSw3111WNyAopg9hrMjdKkeSpWMsQ/6
 8pdOUbhyI0Y8EGrKwvP4I1mDMvJ8gN8HpoSecrBfQg2EghQI/OXnqk7+BZUJZEuFllOT jQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36cxvr6tfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 08:48:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1148kIT8090218;
        Thu, 4 Feb 2021 08:48:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by userp3020.oracle.com with ESMTP id 36dh7uuf3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 08:48:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWYbAVT1IQ8vc/HFer3LuJeyCC9RXbtggovAvDYSNuL0s71L79WmPJY5ERIfgfM2derl8OEXTu0yXQJfxDLxfqi2nkTpenv+q2DevHs0Cmfsq1mkLbVbLU8fpChm21PihPCAx9+iyg3YJxii79OaRyIqTEmmUdMqJi6NNfdmynRCpBl1TFMOxIPxFf27EqWP1wQdegWE4UDVtRc0l7D8BFNlzC3VzoZqBJ4dHIr1XvS/N70WpRceSm8AXew5L66hH4ALGgbQljDnMd4id6CoUVL6EA8GE1ZAanLNsqoQNPRgdwTmoxvyvg1P2xWu+yoj7+RgwViNEBv0CKFBz3i09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EwWBBM2IPvJcVpfLryiQzrs+5eqEh9GKAVISuno9FU=;
 b=Vfy4skh0HFuXxrD5KDc/75l7J1+7Lu654zpsMgrPGvIgBxVoLAy/LM07tP+4/ZjAVq7gOIXx35gq3c3KmlqsaZsmAbuDZcg/wyOr14VmPS070fvGikEQPsazB1WOOyZf7rPves3OYL7uwA2VdxVNvH+hDpTOJt2DmYH5wWDw/K1yj9hlwfzJYk3eSRWW1aahV1SVovyoxt83JK5YZPTb25ug2BXKh3lbPLTKZll5eACdLMoeYddMSh+mYMjaNmGt0jephZBJ2/j3Rkbyv6JtmOVKCxeuetVLpIlyDuQ8p7tXBx3XG+6gcjcsIZPK8zkZ76orySsgJFfvnik59fb38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EwWBBM2IPvJcVpfLryiQzrs+5eqEh9GKAVISuno9FU=;
 b=UOIR8VxMRpsqAjs+FJrEOhfibWRk3UfrPUHJhLbwTDEM3AM/eNwgoJqbnv15/7ORwucxY3xtEQqdcfkPfRtl1RkCrIQYGTN/DxcK+mFCWy0wK8jDWK6QpPGe9tAyf13Quh9j4L2KMO8Yj4ruGkJ8u/9X3nyvIcYnplBEVlrtp/g=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN6PR10MB1347.namprd10.prod.outlook.com (2603:10b6:404:41::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.23; Thu, 4 Feb
 2021 08:48:31 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3805.028; Thu, 4 Feb 2021
 08:48:31 +0000
Subject: Re: [PATCH 2/4] btrfs: fix race between writes to swap files and
 scrub
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1612350698.git.fdmanana@suse.com>
 <0da379a02fdabaf9ca295a34f7de287b5d5465f7.1612350698.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <169460c5-8e7b-2d0a-119f-87ef403e070f@oracle.com>
Date:   Thu, 4 Feb 2021 16:48:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <0da379a02fdabaf9ca295a34f7de287b5d5465f7.1612350698.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:95d2:4fe9:1102:3228]
X-ClientProxiedBy: SG2PR06CA0103.apcprd06.prod.outlook.com
 (2603:1096:3:14::29) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:95d2:4fe9:1102:3228] (2406:3003:2006:2288:95d2:4fe9:1102:3228) by SG2PR06CA0103.apcprd06.prod.outlook.com (2603:1096:3:14::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Thu, 4 Feb 2021 08:48:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1404a887-7e82-4737-c1e4-08d8c8e9a5ce
X-MS-TrafficTypeDiagnostic: BN6PR10MB1347:
X-Microsoft-Antispam-PRVS: <BN6PR10MB1347375D6DBA04DD21C15328E5B39@BN6PR10MB1347.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zpjE4Fihj6Rqruy1NzBXXh2bGiQHIO0B6Z0Fl5KgpbAcGP3X7WVS8rk0OWvNXp3XyI0EgHrXTSzCk2AlHuJJHECc3zUt1iTiCszpF9nx5Q+WLLTnZ1/VgZX0AqLl/B8SL/brrbVC13q7byKabjcY+hmIGV5kxBBlbWpV6QW4ECef3Lc67RFTC2awKUDqbB0wD21CHpDpsee8cXpthSbEf2q4gIxOc40DGRzX3/ibf0Pbv9f/qrS1oMl7qyW+P4VfvWd5tyN4CK8uS6/YSlu599YLxXLGtMzGk9W9Vx1jsL+URUtAIM12TyrEUqHD1iA4Ghy8n2S03ldoDTMpscGR1/vwSe+dRsOwzmlJ9SrJ7MsM2oUC2+TsX1S+YJ/zzel4n+qkexQ0KhB6+FdCx4WOuTP5HA6mRn8Exp1OUMJ5Ol+KciJnc4IlKRMvFI/aFnuey1OiJPsKGlJDQCs7YJOtPnh13qF4KMw4kqvCVQHhHa9hw9x7YxQmJIChpOIKoQHJjb9ILFtfjsiyBkfD+e5/m7thAB4d5+yjD5lZ+ExFgUyAZwMzGumxwTurFe/eCu9c9XIUni24cUqGOZhVgj7EwEfE9A5Rg/f/UqsJg8CFzmE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(346002)(366004)(136003)(186003)(316002)(16526019)(31686004)(2616005)(66556008)(86362001)(66476007)(36756003)(31696002)(66946007)(5660300002)(53546011)(6666004)(44832011)(478600001)(8936002)(83380400001)(8676002)(2906002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dzR3NUJXSGxidnJsd3RVZ3REbC9oOVdadjJOK3Jud3ZEY0ovRmdteWQ0THJ0?=
 =?utf-8?B?TWJZNlZtY3hSRzNaMWlpWmxvdVRSSHRnb0E3bHVCUkdUYVhCZFBEZFpiL0lZ?=
 =?utf-8?B?MGdheTJTWkVRRkhnUzZENzVkN3BNd1hKU3dkTHlOdnBaekx5NUJPYWJaZFFm?=
 =?utf-8?B?dkh6MVFyVHBwQTlCcGRRNUQxaVVxbGNEek1sdmwxM2F6a0tiUGhqYUJpWGxO?=
 =?utf-8?B?UGRuRVBSZzhiVmJmTW5LRitqRkFDeG5QVzM5ek9jbnkwdUR5TVhMc0tCWFhN?=
 =?utf-8?B?dCtack1sdGJMRnVhZnFZVTdIU1NxNVNTZGVLWjhGTlNjd2dOdmU0U3VZL3pW?=
 =?utf-8?B?UVpVWExkcUc1dnJYbDV6MFNzUTMwNFR2blUwV2dDTEhqSVNhUkxUQjFBREtF?=
 =?utf-8?B?R0JnREtUOVg5RjJ5d1dwYWNRNVZ4NTFxdnpBQ2h6ZHlmanNSU2RhT3FDZ29Q?=
 =?utf-8?B?VHBCS28xRllHUTVJTVZXVlhMcWF0RzhwQis4cmFWV2pIZjN2N08vQnYvL1lN?=
 =?utf-8?B?OVc5N1Q5bCtUbzdJMFo5UTl3SVMwc1NOM20xYVpScmxobzBVTjNqZC9pYnhu?=
 =?utf-8?B?ZkdKb3NWTVo4QlVHN29IYzdhbU5NQlVLMnk0ZTRESFFBK1lXOCtHSnpndnhx?=
 =?utf-8?B?NWJCN1JXTDhBU3dqUWsvQ0RQZ1hMR2NmZVRBQlA3cG5aMDhtdlFRNXlWZHJq?=
 =?utf-8?B?RHZGMWkrZi92UGl4TXg3a3gwVEtiY3VoZ3lvdmlHOWQ1dWN3ditKb0VFOXZT?=
 =?utf-8?B?UW5ZczhLbEdpQ2VHT2ZDR1h0c3FZNDMrTGxBQWtwTFEvSWtOSVBhS3FoaVk4?=
 =?utf-8?B?TVBKN3o5d2NWOUFqcTdZNTEvM2IyNGZxM1ExL1lhM3U0bUo2dkc5QUZnZlNu?=
 =?utf-8?B?bExvZzMrZExxZnljcDZsc0lBN2dPNktKY0xjMmpSQ2dNRmRHMThrZFhCdWt3?=
 =?utf-8?B?UVljUHExUUJHd2t5L3dQeExOUCtqdVFtWi9oK3lpU0dUN2VqRFVKd1l1WCtK?=
 =?utf-8?B?VXhWUU5ValVEQ0RhQmJXSHZTamJYM0xUTzdJVklzRVhYaTVWREFQZ3IySU05?=
 =?utf-8?B?ZTVtRDA4a2ZzS241ZmY1RE9DWmVFZlBUc0pBVkI0MU40MGplYXl5UE8ra1R3?=
 =?utf-8?B?MFhnMFI4QnZIdWNtZ1BGL1NQQVFNTDdTSEROT0dEK3YzMGpMd01JUDRRZVQ0?=
 =?utf-8?B?TGVSVWpQYjZramNRSTFyT3phRk50dmwvMW9MKzFvbGdlN0hUQXFkZDdYWjY5?=
 =?utf-8?B?T0d4V1l2YS8vVXRERlM4TTBac1BHZ092U1JKa011RGp3NkdPbzFMaE43cXFX?=
 =?utf-8?B?ZzlvMTgyZURFeHpBNGVVVzVmTVN4TzJ6L01tMk5pVjNvTWJtNThXbUZxZTRZ?=
 =?utf-8?B?eTFrK04yMFROMzJvZ21SVEFGVzVJLzlydHlVMUVlQ1BBakVtZkVFenhuYjd5?=
 =?utf-8?B?cXRBRk9oTFM1dGZ1MXJ3RXRJaFZ6M1pKcXpLeFIzeFBIcHIxLzFNRzFjRm94?=
 =?utf-8?B?dUFZTUlXNW9XNkQyd25VVlUyc1Z1c2RLckZwRE5tL0xwT2dsOXBLelYxQ1ox?=
 =?utf-8?B?dXAwZ3NTKy93cnJmL0FaZ0FYK3ZSSVlaTWprVXhqNEIrRzdVL2MydmlCMnkz?=
 =?utf-8?B?S3YrckRDZzMvdEE4bUUvdi8wS0NWTTJBZ1FVdDRrYWtnMWRqV29ISEJ0U2Vo?=
 =?utf-8?B?WnVUeDNEeklqK2pwTGdCV0lLZUV0Q0xZK2dybWYzb0pFVVJuNHdqS3lnblE3?=
 =?utf-8?B?TVZmVkR6a0hUZk1hTi90MEdNektteGpaWFNSejNCYjIyOEpyVjFEeFYxTTZX?=
 =?utf-8?B?L1U0YmJNaURnR21xUnUrUDVVS0JEdjh5UlBYeFVuNCtiYXpnbHRIdDVXSFZ1?=
 =?utf-8?Q?soC6KiltftFlu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1404a887-7e82-4737-c1e4-08d8c8e9a5ce
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 08:48:31.1239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nLyvZynVDA+6Pr1tIB5NKLYYPM/HhBCfKIeAbdmPo1gyH7TV1x60YkvNWfMJcA2f2tZY3fP6uJblyB+JQiY1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1347
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040054
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040054
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/3/2021 7:17 PM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When we active a swap file, at btrfs_swap_activate(), we acquire the
> exclusive operation lock to prevent the physical location of the swap
> file extents to be changed by operations such as balance and device
> replace/resize/remove. We also call there can_nocow_extent() which,
> among other things, checks if the block group of a swap file extent is
> currently RO, and if it is we can not use the extent, since a write
> into it would result in COWing the extent.
> 
> However we have no protection against a scrub operation running after we
> activate the swap file, which can result in the swap file extents to be
> COWed while the scrub is running and operating on the respective block
> group, because scrub turns a block group into RO before it processes it
> and then back again to RW mode after processing it. That means an attempt
> to write into a swap file extent while scrub is processing the respective
> block group, will result in COWing the extent, changing its physical
> location on disk.
> 
> Fix this by making sure that block groups that have extents that are used
> by active swap files can not be turned into RO mode, therefore making it
> not possible for a scrub to turn them into RO mode.

> When a scrub finds a
> block group that can not be turned to RO due to the existence of extents
> used by swap files, it proceeds to the next block group and logs a warning
> message that mentions the block group was skipped due to active swap
> files - this is the same approach we currently use for balance.

  It is better if this info is documented in the scrub man-page. IMO.

> This ends up removing the need to call btrfs_extent_readonly() from
> can_nocow_extent(), as btrfs_swap_activate() now checks if a block group
> is RO through the new function btrfs_inc_block_group_swap_extents().
> 
> The only other caller of can_nocow_extent() is the direct IO write path,
> btrfs_get_blocks_direct_write(), but that already checks if a block group
> is RO through the call to btrfs_inc_nocow_writers(). In fact, after this
> change we end up optimizing the direct IO write path, since we no longer
> iterate the block groups rbtree twice, once with btrfs_extent_readonly(),
> through can_nocow_extent(), and once again with btrfs_inc_nocow_writers().
> This can save time and reduce contention on the lock that protects the
> rbtree (specially because it is a spinlock and not a read/write lock) on
> very large filesystems, with several thousands of allocated block groups.
> 
> Fixes: ed46ff3d42378 ("Btrfs: support swap files")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

  I am not sure about the optimization of direct IO part, but as such
  changes looks good.

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

  Thanks, Anand

> ---
>   fs/btrfs/block-group.c | 33 ++++++++++++++++++++++++++++++++-
>   fs/btrfs/block-group.h |  9 +++++++++
>   fs/btrfs/ctree.h       |  5 +++++
>   fs/btrfs/inode.c       | 22 ++++++++++++++++++----
>   fs/btrfs/scrub.c       |  9 ++++++++-
>   5 files changed, 72 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 5fa6b3d540f4..c0a8ddf92ef8 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1150,6 +1150,11 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
>   	spin_lock(&sinfo->lock);
>   	spin_lock(&cache->lock);
>   
> +	if (cache->swap_extents) {
> +		ret = -ETXTBSY;
> +		goto out;
> +	}
> +
>   	if (cache->ro) {
>   		cache->ro++;
>   		ret = 0;
> @@ -2260,7 +2265,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
>   	}
>   
>   	ret = inc_block_group_ro(cache, 0);
> -	if (!do_chunk_alloc)
> +	if (!do_chunk_alloc || ret == -ETXTBSY)
>   		goto unlock_out;
>   	if (!ret)
>   		goto out;
> @@ -2269,6 +2274,8 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
>   	if (ret < 0)
>   		goto out;
>   	ret = inc_block_group_ro(cache, 0);
> +	if (ret == -ETXTBSY)
> +		goto unlock_out;
>   out:
>   	if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
>   		alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
> @@ -3352,6 +3359,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
>   		ASSERT(list_empty(&block_group->io_list));
>   		ASSERT(list_empty(&block_group->bg_list));
>   		ASSERT(refcount_read(&block_group->refs) == 1);
> +		ASSERT(block_group->swap_extents == 0);
>   		btrfs_put_block_group(block_group);
>   
>   		spin_lock(&info->block_group_cache_lock);
> @@ -3418,3 +3426,26 @@ void btrfs_unfreeze_block_group(struct btrfs_block_group *block_group)
>   		__btrfs_remove_free_space_cache(block_group->free_space_ctl);
>   	}
>   }
> +
> +bool btrfs_inc_block_group_swap_extents(struct btrfs_block_group *bg)
> +{
> +	bool ret = true;
> +
> +	spin_lock(&bg->lock);
> +	if (bg->ro)
> +		ret = false;
> +	else
> +		bg->swap_extents++;
> +	spin_unlock(&bg->lock);
> +
> +	return ret;
> +}
> +
> +void btrfs_dec_block_group_swap_extents(struct btrfs_block_group *bg, int amount)
> +{
> +	spin_lock(&bg->lock);
> +	ASSERT(!bg->ro);
> +	ASSERT(bg->swap_extents >= amount);
> +	bg->swap_extents -= amount;
> +	spin_unlock(&bg->lock);
> +}
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 8f74a96074f7..105094bd1821 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -181,6 +181,12 @@ struct btrfs_block_group {
>   	 */
>   	int needs_free_space;
>   
> +	/*
> +	 * Number of extents in this block group used for swap files.
> +	 * All accesses protected by the spinlock 'lock'.
> +	 */
> +	int swap_extents;
> +
>   	/* Record locked full stripes for RAID5/6 block group */
>   	struct btrfs_full_stripe_locks_tree full_stripe_locks_root;
>   };
> @@ -296,6 +302,9 @@ static inline int btrfs_block_group_done(struct btrfs_block_group *cache)
>   void btrfs_freeze_block_group(struct btrfs_block_group *cache);
>   void btrfs_unfreeze_block_group(struct btrfs_block_group *cache);
>   
> +bool btrfs_inc_block_group_swap_extents(struct btrfs_block_group *bg);
> +void btrfs_dec_block_group_swap_extents(struct btrfs_block_group *bg, int amount);
> +
>   #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>   int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
>   		     u64 physical, u64 **logical, int *naddrs, int *stripe_len);
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index ed6bb46a2572..5269777a4fb4 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -523,6 +523,11 @@ struct btrfs_swapfile_pin {
>   	 * points to a struct btrfs_device.
>   	 */
>   	bool is_block_group;
> +	/*
> +	 * Only used when 'is_block_group' is true and it is the number of
> +	 * extents used by a swapfile for this block group ('ptr' field).
> +	 */
> +	int bg_extent_count;
>   };
>   
>   bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index b10fc42f9e9a..464c289c402d 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7204,9 +7204,6 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
>   		*ram_bytes = btrfs_file_extent_ram_bytes(leaf, fi);
>   	}
>   
> -	if (btrfs_extent_readonly(fs_info, disk_bytenr))
> -		goto out;
> -
>   	num_bytes = min(offset + *len, extent_end) - offset;
>   	if (!nocow && found_type == BTRFS_FILE_EXTENT_PREALLOC) {
>   		u64 range_end;
> @@ -9990,6 +9987,7 @@ static int btrfs_add_swapfile_pin(struct inode *inode, void *ptr,
>   	sp->ptr = ptr;
>   	sp->inode = inode;
>   	sp->is_block_group = is_block_group;
> +	sp->bg_extent_count = 1;
>   
>   	spin_lock(&fs_info->swapfile_pins_lock);
>   	p = &fs_info->swapfile_pins.rb_node;
> @@ -10003,6 +10001,8 @@ static int btrfs_add_swapfile_pin(struct inode *inode, void *ptr,
>   			   (sp->ptr == entry->ptr && sp->inode > entry->inode)) {
>   			p = &(*p)->rb_right;
>   		} else {
> +			if (is_block_group)
> +				entry->bg_extent_count++;
>   			spin_unlock(&fs_info->swapfile_pins_lock);
>   			kfree(sp);
>   			return 1;
> @@ -10028,8 +10028,11 @@ static void btrfs_free_swapfile_pins(struct inode *inode)
>   		sp = rb_entry(node, struct btrfs_swapfile_pin, node);
>   		if (sp->inode == inode) {
>   			rb_erase(&sp->node, &fs_info->swapfile_pins);
> -			if (sp->is_block_group)
> +			if (sp->is_block_group) {
> +				btrfs_dec_block_group_swap_extents(sp->ptr,
> +							   sp->bg_extent_count);
>   				btrfs_put_block_group(sp->ptr);
> +			}
>   			kfree(sp);
>   		}
>   		node = next;
> @@ -10244,6 +10247,17 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
>   			goto out;
>   		}
>   
> +		if (!btrfs_inc_block_group_swap_extents(bg)) {
> +			btrfs_warn(fs_info,
> +			   "block group for swapfile at %llu is read-only%s",
> +			   bg->start,
> +			   atomic_read(&fs_info->scrubs_running) ?
> +				   " (scrub running)" : "");
> +			btrfs_put_block_group(bg);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
>   		ret = btrfs_add_swapfile_pin(inode, bg, true);
>   		if (ret) {
>   			btrfs_put_block_group(bg);
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 5f4f88a4d2c8..c09a494be8c6 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3630,6 +3630,13 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>   			 * commit_transactions.
>   			 */
>   			ro_set = 0;
> +		} else if (ret == -ETXTBSY) {
> +			btrfs_warn(fs_info,
> +		   "skipping scrub of block group %llu due to active swapfile",
> +				   cache->start);
> +			scrub_pause_off(fs_info);
> +			ret = 0;
> +			goto skip_unfreeze;
>   		} else {
>   			btrfs_warn(fs_info,
>   				   "failed setting block group ro: %d", ret);
> @@ -3719,7 +3726,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>   		} else {
>   			spin_unlock(&cache->lock);
>   		}
> -
> +skip_unfreeze:
>   		btrfs_unfreeze_block_group(cache);
>   		btrfs_put_block_group(cache);
>   		if (ret)
> 

