Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E218C415749
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 06:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhIWEG2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 00:06:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9452 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229436AbhIWEG1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 00:06:27 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18N3R6aW006661;
        Thu, 23 Sep 2021 04:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ipH7S0N3EKYAAmERM6qXbMMAulMT++gWMxDu7irtvV0=;
 b=enly/lF7Q/zS4w2XT1miDoiTPPRQQhu1WFWyVkKNkbIX55W+s+ni3oJWm9K8eR2ix2sI
 hSHK0OeHTpu7QdgJeiZoXy2oaz5GCVcNhbUXArwfu0z9koeLIsxjdSZBaMkgGCh1x2dF
 1bM4fnRTAaus1GFKPt56qWLY9DUVPTUDuXmaSlB7qWjMf+G+8vBlpFMhjmmt/UpdJbqx
 7tL2cD9CNM2JkUbQJyLjitOm8kcUVI+dmqIjL4OAKN6Ra+Pu8ozMc2e9A6h6GE9QC1FU
 uF+oKO+fiyMfV8cT9MI/pSRJawvHZRztcGke7TjcporMgnwztAyr+NDLwnB4JIvq97K3 ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4rggu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 04:04:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18N3xbQS187678;
        Thu, 23 Sep 2021 04:04:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by userp3030.oracle.com with ESMTP id 3b7q5nx103-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 04:04:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2VncNehA3fuIxaW/LcACQ0gKuBDKC9hl0q2kl+b4K7swY47/h9bgNkMomqpWC8nF1bjv6UYFlWqgrhGl+tgdvodjkPwKyNDDEdNVAs4EyTHs51IYwejwm/43WuHjF8Oy0e2mpWE7Je4ZmFU8sTCbDAIS5HrPbnF5ryMsEyzolU2pNCfzLQs//dqf+1Nir7OoxEnok5lW0s95Zp6RvaLAd/2na5Hmzhx1S7RtuuiifqdWjm18l4vkDBHQg0c+OSocMH0s2UlTSlFjydbu2xhg6sSS+bBJbtYnWm/Bwm3G8NdLpmSg7QZ2DoTwcLb9U4tvaWK0nnp2sQDFiDThTdjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ipH7S0N3EKYAAmERM6qXbMMAulMT++gWMxDu7irtvV0=;
 b=mfeTxf3ak6c3SuCRt4b+PIJvBrmCPrv9h8HQPsxOUtmUSCJFE4aVjetEqYp0RqAH24eD2iVvItX0Nm5b6vYpvR5ROU5Okt70dp74+H7CHt73kuVyIH+9uMNHa3mkIjAFoM/Hf2rKuB9YZyUwIvOC1ieUJ00l0pca9m6VWiJvuoDDK5gOaFENpNsLhoExctuQcH7hlKqwJ21P0uPEMcFFS+gNd/2OdymdCEIVqyvqOWfIY5pPzl+tQQRDP66EnhOvo9gXjBp8zBx1K2xZTBY1B6s5NcrJO7hagSxVonXkDSHTV71rv1kXPDPi/O+bfQEx8r+k7jSX/lsiSrMDaPQRZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipH7S0N3EKYAAmERM6qXbMMAulMT++gWMxDu7irtvV0=;
 b=nSAnu2ruhXrWoH1326NEOmTm3eP1kj+sEuBSMQLYuvlfDNeflS4QKGJINvPLf8+wFK+tN+gm3TbuRyNvJIQpZT8BVtJv+QbPwR6TeT3SJZ4qs3miewnwGxE8c2g34cJ2BekjyT4GX5wkQ6yVfrtnqCHRnR9oh8S4pacmMu1VwLU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4015.namprd10.prod.outlook.com (2603:10b6:208:1ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 04:04:48 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4500.018; Thu, 23 Sep 2021
 04:04:48 +0000
Subject: Re: [PATCH] btrfs: drop lockdep assert in close_fs_devices()
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.cz, fdmanana@gmail.com
References: <4f7529acd33594df9b0b06f7011d8cd4d195fc29.1627419595.git.josef@toxicpanda.com>
 <94f69f0215f06ecf929c66249810c549e492071c.1632368499.git.anand.jain@oracle.com>
Message-ID: <ee59c8a6-e29d-7b94-7a03-1b27a45307d9@oracle.com>
Date:   Thu, 23 Sep 2021 12:04:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <94f69f0215f06ecf929c66249810c549e492071c.1632368499.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0086.apcprd03.prod.outlook.com
 (2603:1096:4:7c::14) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR03CA0086.apcprd03.prod.outlook.com (2603:1096:4:7c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend Transport; Thu, 23 Sep 2021 04:04:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16f1feb9-4297-4045-2d86-08d97e47492c
X-MS-TrafficTypeDiagnostic: MN2PR10MB4015:
X-Microsoft-Antispam-PRVS: <MN2PR10MB40150D9B849B8EF30A4AA13DE5A39@MN2PR10MB4015.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MTh1kbdMxMpbBq46OqsN5SGrWxq2a3nkEmI5rbuxjEApfZHryIhmTD5d96tTa2iMEJZIkt5ru3kNftNEUgBVxFe/ZJpDjK3Z6diXR65kpFEvnHOTtoNIlNMQT4ZppqOo4rRRcVWM8w4YskdkCjfkw0EZdfvFCFuyGH/d+6izWnydP9yPqs3hEP1oe0MRpD4ZoCTYWD5vvtkU5Gvx7LDHSr+r/VUrwLbW5J2ACPB2t9VJb8Q/W5Ju3m9TH8Xm6vLZMCdssAgwj844rEqsprQWhGaaNLKLcluWOVdkuEgCVV6INQybJ3bwitQL45oqDsmvMkwJY4JInkgcionpF35wQVF41jrw9W52kHEA7bHYXGS010t7ORm1dTDBy68eDWx4qLO2snD5TEapsHYo3q7Ru5OdVbi1xMucgQP5w9gtdJtEyFJOXWSQlUjUojNdAOUo1sZomVDIo5D7zi6x9JJ7KIPFFsu+A1XcJQED0/iG5NF8h4CsKmLjjWFTI9jDyvwqydivLjN6satjjmcck2hGTwebUElpHFEHDXugfG+mv0rSbhEXFovEDytmIUzaK7e3azKawIAIEBtJ+e9qVVe6OIxCDkNHZ6veCMyOMpqHm1u16U9b7JGpUgqbUjuKbM4acHBe7oiznA6r9QS+1Emyv+yBkxxvhW4IcA0Q3faDaFz4R1RItaJl405pLObxE7MCvO/qF100Hb6rG9Xf0s99UMzAk4HQpW00d3SGgJyK3Zk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(31686004)(6666004)(6916009)(36756003)(44832011)(8936002)(508600001)(26005)(38100700002)(16576012)(316002)(86362001)(53546011)(6486002)(8676002)(2616005)(956004)(4326008)(186003)(66476007)(2906002)(83380400001)(66556008)(66946007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmpYdnA5ZFllV21UeTIyd3RLaHBWN2N1d1VxZlYzVFJIOS9hWjlMR3JmaE9z?=
 =?utf-8?B?aWh6SFdSOTk2TzlvRTdPYUdmMmZnbXVpd2V3TEdlcTJ1Sm1LZGRWR05lVUo4?=
 =?utf-8?B?VXJ4cHlQR0FFNVR3MUhHaCttK3NESE5GMjRnYksyY3dKdlFJMzhjTS94YnRm?=
 =?utf-8?B?bWd2ZkJuRWkyb2I5MklzTjRQVlZ1TjJ0eDlUS2NSc3FjQWUxbFJzbUNwRE9X?=
 =?utf-8?B?ZHRGZFZ0azlGOGJjTEJXYUF2ZkgzckgzbDhXUElKeHZ0VnIxb2FBc3gwTThY?=
 =?utf-8?B?cVVNamZvVnhMNy9RNFNYUnMwM3VublFrcjVrN0U5TFB1TWdRY3QzZWJTcTJ2?=
 =?utf-8?B?bERicmhWemtJd1o1TGNxN0o5RkVaWjRvbW43N1c4amJtckYzaFM0TXUvSW1t?=
 =?utf-8?B?Nis4UFphenUyenQ5TkpWckJSazczY1R1ZFI0TXVCcHlMd2RwY3c5TWJMMWRD?=
 =?utf-8?B?VFNyUjA0NVdUenlQRGlHM3AyU09WMUxEcG5aWjVvZUpGYU1PUkJqN1Q2OGFi?=
 =?utf-8?B?Ym01WFdwdjZocUtKVkVkTituMHU0L0lIWFBFSUtrNlJuUjZHb0ZCOXlkbDR2?=
 =?utf-8?B?eXR4MkgxWkZVZysyUTYzV0ZLeEZqQjhGeXkxWHN1OEc5SjBDSlRncUZDVElt?=
 =?utf-8?B?ZHN2SjY0VExqUWc0M3FxTWIwZU5SUWJKNmxVTDNnR2FNRysySmNpazlGYkRR?=
 =?utf-8?B?b3N6bVhwdFRmdWpxak9yNUJIM0lmbC85OWY4L2xxSzNrdkVyTWUybnpEc0li?=
 =?utf-8?B?aUhmcmpsa2JwS04yR2cxUG91OE1rKzBFTUJLc0xsR2xaWEF2WUJ2czhWVk96?=
 =?utf-8?B?WUkxMTJPSmN5akhtWm5EQTJPUUtVZExFeG5VaUlVbHRxbzdhd2kvZ2NDS1hx?=
 =?utf-8?B?aC8wK3NYR3Q0YU1DdnNtTEN1STU2UWtBUWg2ZFAxVTdLb3l5b3FYRkRIN0ox?=
 =?utf-8?B?SXRBSVNnOEN3dURDYkxnRm9BbHgxdFN2dUxROUdpbFhaQWQrYkhwTVE1cUZu?=
 =?utf-8?B?andIc1ZHdEw4amFIcldNVlpvNXV5elUxazhXSS9SRjFtT2JndDBPZjIrdFRK?=
 =?utf-8?B?a2lySzR3R21rMTNlejc4OFI5NHczR0RYUnBiRnBYZEE4UGZmcU1ISkZkRG55?=
 =?utf-8?B?U2ZUUnE2U2hqckE1ZHpMSjlKRzFMRkpSWnRiUnFTTlhKUmdlOGhlZ0JOUWVx?=
 =?utf-8?B?V1RIMi9xbUVvVlMzbmh4d1ozR2FQeDFFNERadHp2QXg2Z3o5ajE3bXdhZGtp?=
 =?utf-8?B?RHZVMDhZNnI0QlB5NGRtSHllYStNNWNqVWJuUW1jb0VPN2xqZGs4Y1AyVWcr?=
 =?utf-8?B?TVcyVFF1Qm02b2ZMdGUwMEJOS2YzZGx2Zzg2Uml2NW1GSDRROGtNN0tyeWVS?=
 =?utf-8?B?OStnNkhqT2hQaDV0M1Ywd0NCeFdNVDJvWVVBNHEzcjVORC9Udlo4WW43MTRP?=
 =?utf-8?B?S1JuTmJOUzNZUzV4djFod3o5WWZieHFNVW4zSE52a2J1czA2NzdlQnRsRGll?=
 =?utf-8?B?MDNnbFhJaGhhZW85THlHdGVXampJYmhpeW1Pdko2Wkc4OEQ3VytDSGNaaGR4?=
 =?utf-8?B?T3MzZVJZSEFRNXJTaEg4S1drRWRuR0FsLy9jT3NhbWNrYTd2WW4rUHlGeHZ5?=
 =?utf-8?B?cjJsRE55eGJPNFFJSnEwQWd4TXorVzJoeWZGVExNSnlhWkpKNnA5VzljMU4r?=
 =?utf-8?B?QmFXcTc5bEJ4UG5zTVBlb0J5M0paM1pxZTdtNy90UWRHVVJJNG8xcFdTcGRD?=
 =?utf-8?Q?LG3Bl/YifvAQQn/2oAZQW2JnMMp3ttW0kv22Ast?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f1feb9-4297-4045-2d86-08d97e47492c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 04:04:48.6011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+MGaLrB98XTrqQz6eSVLO1fT3t0tqmupitZWS+FR8UfEIaRAcIyCiP0kPnvSKIGMwgF7VT0K+yp/IRyTwK6eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4015
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10115 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230022
X-Proofpoint-GUID: gl2grEccKsdQvKzsfRWMmH0j2VzuhZaG
X-Proofpoint-ORIG-GUID: gl2grEccKsdQvKzsfRWMmH0j2VzuhZaG
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Ignore this patch.

  The patch 1/7 in this series is not yet integrated. It will fix the issue.

  [PATCH v2 1/7] btrfs: do not call close_fs_devices in btrfs_rm_device

Thanks, Anand

On 23/09/2021 11:58, Anand Jain wrote:
> btrfs/225, btrfs/164  reports warning due to a lockdep assertion failure:
> 
> [ 5343.002752] ------------[ cut here ]------------
> [ 5343.002756] WARNING: CPU: 3 PID: 797246 at fs/btrfs/volumes.c:1165
> close_fs_devices+0x200/0x220 [btrfs]
> 
> [ 5343.002933] Call Trace:
> [ 5343.002938]  btrfs_rm_device.cold+0x147/0x1c0 [btrfs]
> [ 5343.002981]  btrfs_ioctl+0x2dc2/0x3460 [btrfs]
> [ 5343.003021]  ? __do_sys_newstat+0x48/0x70
> [ 5343.003028]  ? lock_is_held_type+0xe8/0x140
> [ 5343.003034]  ? __x64_sys_ioctl+0x83/0xb0
> [ 5343.003037]  __x64_sys_ioctl+0x83/0xb0
> [ 5343.003042]  do_syscall_64+0x3b/0xc0
> [ 5343.003045]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 5343.003048] RIP: 0033:0x7fe125a17d87
> 
> The patch [1] removed uuid_mutex in btrfs_rm_device(). So now there is no
> uuid_mutex in the call chain leading to close_fs_devices() that has
> lockdep_assert_held(uuid_mutex).
> 
>   [1]  [PATCH v2 2/7] btrfs: do not take the uuid_mutex in btrfs_rm_device
> 
> The lockdep_assert_held(uuid_mutex) in close_fs_devices() was added by the
> commit 425c6ed6486f (btrfs: do not hold device_list_mutex when closing
> devices) as it found that device_list_mutex in close_fs_devices() was
> redundant.
> 
> In the current code the lockdep_assert_held(uuid_mutex) in close_fs_devices()
> in incorrect, remove it.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> David,
>    Pls feel free to either roll this into the patch "[PATCH v2 2/7] btrfs: do not
>    take the uuid_mutex in btrfs_rm_device" or merge it as an independent patch.
>   
>   fs/btrfs/volumes.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 9fea27b9f9be..ac4a9f349932 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1162,8 +1162,6 @@ static void close_fs_devices(struct btrfs_fs_devices *fs_devices)
>   {
>   	struct btrfs_device *device, *tmp;
>   
> -	lockdep_assert_held(&uuid_mutex);
> -
>   	if (--fs_devices->opened > 0)
>   		return;
>   
> 
