Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B733166B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 13:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhBJMbb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 07:31:31 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:45086 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhBJM3l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 07:29:41 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11ACOBvu070236;
        Wed, 10 Feb 2021 12:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RJRy3kOkPhLY8vylfKd7ToqaoYQfkS0gu1YD2WL1e3Y=;
 b=sgc4O79FEWdLHvOeZbP1iyCoDyvkvM4M1nz3pbK0EKcpyZRyHE9ADdQImSNGDcaecoCU
 V5ySX8+BJtv/c/SNZXx2D13yiHBUJqzi3ND0TjFEY6qpxkgF/kgjuSTfXCbdoLDtPl/s
 iiVLNRJxuCUQ8JKWcR9OT8rQ0afmGcdMLhke6pRKg6AmAHBrsB6l0CSq9VGozFQgpOKI
 Iz/ArndW35xYIPK1VmKLQPYfSOKiHsUS7AxqfocEe9wOdbmLMh45kyjp8GHC+gNI6RL2
 nn7b1ivnQBS0MwqHkQsMtcn5fSSnNFDkD6WqarzYdr9fuVzhYqsa0zL8EboUqXC/7btM qQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36hkrn34d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 12:28:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11ACQgjD111308;
        Wed, 10 Feb 2021 12:28:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by userp3020.oracle.com with ESMTP id 36j4vsr9y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 12:28:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNN4Y756OLfsv64BqLdi0tOiub053hhZNg740evJBcDP4H0IFke9qcwCjKOUi8cMcN7XvlPrwXeg3GjmxqD/d67NhlW+XioAW7UocCsT/7QW7OJwgE/03H4ZfAbWY76EUlJiR8xvL9efnZHTTosqRvG2zXz576qmYwFmbazLoALW32rKajtvqF03UK4G3hG5pn4RtYKFQ5txsbFb2QxoyqHW2d1O0ZVeAEx3+T8hBa25tqRvaNFuNlsIE9dKxktgXNu0CHD+cXojhajgImgF4M+hUzPYAveDXlMYMefjjWAXyZWTarPxXnt8RXS+JJneiPH+dCAjq0/bH8UVHN27Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJRy3kOkPhLY8vylfKd7ToqaoYQfkS0gu1YD2WL1e3Y=;
 b=HOkkHmp4B/IYBp5S89H5mu57uD3HFXu1Hg2+BZEqtPEcuugymiqWbG49J6WO7cp4EP/KrhtbhsdRW85e53BkLQwUGgEywWnL2GGcT0ZrMeiYLaTaCoy3uVRKC0TjO8kEqq8MuT1xGUgMxxTMxmhXGmzaPqEtfJsrZsjEaZAFVrE8MWhdJwObmMAq9mmIbj6VNR1LMThnU1FgoSBiQK9pKL8kTiyIwOafUzg9Ru0++c9z5B9dFZx/IR+lepn3FyFllO2pPLwqHT/hVzbWJU88dHaGehgzGs+5w5zvSyY1F4P7lwsHEXP9MDv2kXW6QGc/7hRCXcZgCY7A0hQoibIztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJRy3kOkPhLY8vylfKd7ToqaoYQfkS0gu1YD2WL1e3Y=;
 b=W2SCtVHluIXJNLoIfYYJXL+smRlDli4u/dmfL5f7v8LUzek/pCilwdmwB1m0k3smD28AxaANwNQUV+GkC3ztvQUFSJ1C/GanrX9lBjN+ImALPJrpAVfWyHyv8R5p/zRjWnkhqPotRPUvPPgzXf2pJh1vocaECZNREtDBH6nm9gY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN0PR10MB5237.namprd10.prod.outlook.com (2603:10b6:408:12f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Wed, 10 Feb
 2021 12:28:52 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::9d63:7b79:33d4:a802]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::9d63:7b79:33d4:a802%3]) with mapi id 15.20.3825.032; Wed, 10 Feb 2021
 12:28:52 +0000
Subject: Re: [PATCH v2 1/3] btrfs: avoid checking for RO block group twice
 during nocow writeback
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1612529182.git.fdmanana@suse.com>
 <39ee54263f0ccc622359774e974073f2318c66e2.1612529182.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <5f2dded1-d72b-de1f-cda6-df87abe38ec2@oracle.com>
Date:   Wed, 10 Feb 2021 20:28:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <39ee54263f0ccc622359774e974073f2318c66e2.1612529182.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:7932:39e4:bc3:8319]
X-ClientProxiedBy: SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16)
 To BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:7932:39e4:bc3:8319] (2406:3003:2006:2288:7932:39e4:bc3:8319) by SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Wed, 10 Feb 2021 12:28:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce8ac07d-e358-40ed-c703-08d8cdbf6ca1
X-MS-TrafficTypeDiagnostic: BN0PR10MB5237:
X-Microsoft-Antispam-PRVS: <BN0PR10MB5237726683D7C2B90CAD51A2E58D9@BN0PR10MB5237.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cOeCkFgtBLtqECc4oBXbmIRU5Km87DRYgRirsdvAGEY0cbns1VNz7ShA9NVlvxm5e1/sURhCVKUzrtapvGs9cbVfIbHrElopNQPS0TShuRbXPqfPCVoDiQ0YQTdfX54INglNQ3Zxpkbsuir2UhYi51WOiJkEp8RP1YVnYMrbdKUw4TGivhhN1Cj3rpLk5LndT7HXy9oSPw9UMgiw0JuT2crFuCFnFT3Nna2aiGQ7Cfaw8RQBrDhJdu9o/5OumkPj8aMHLqCdw8NTHnWwXYOndXVFKNeBHEFLH4rnXTbv78ziioiiQDkNEUV5FFZnzMjSFBrXqATwoY3xeh/za0hJpdBkS0nRzS2az5okbjotarP64RqTPgBycUffAediOcBD2T26OFrS/bI+tuZ17Yqpz7tepo5MO+TyAWk3Ojd9kRE2LzeTeF0Y6NZNuCqZCnYK1PlLoKPVbdfQ+WgF2N0MOpCJlx4JrU/t/QXmUkRwumy67ApM0SKRqGTRAKXxnOBFo0kVxdcs/8ukQgelgtN0bnWnEgOlI+YnP0DfN1Ke8uD3XAO6jmgBZJQ+5t+Uw9WORSSHI9QotWLlH410Q+KsTdK7l4p/zFvbjhj4BrRYqQY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(136003)(376002)(366004)(53546011)(66556008)(66476007)(6666004)(2906002)(44832011)(66946007)(478600001)(6486002)(8676002)(8936002)(86362001)(36756003)(31686004)(2616005)(186003)(83380400001)(16526019)(5660300002)(31696002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TS9mUTJSTE9rdXdSQWFscHh4cDhCZWk1QXdxOTJ3bERIcW16anZUQ0l0bVZQ?=
 =?utf-8?B?cDlqSzh1UnVGVHB1ODJQVmtBSkYrN1Z1QkowL3A0NjJoSEtULytLdkdsTHFG?=
 =?utf-8?B?QlRkNkRUVWw4Ynl3RGNTTUh6V2o0aTZ2WTR6RlU4TU95dWY0MHBSaXNlc2JL?=
 =?utf-8?B?aDRsTWpobTZJZlBKazJ5TXJJS0NFQVFyaWxTbi8veTgwYTVZeTNDUVRrU2ps?=
 =?utf-8?B?dk05UEJiMTBPVUphd0pDeERXZWlieU9VNGRJWSt5UEJNcFU0YjVXT0xDaUZu?=
 =?utf-8?B?YmFvWXVXaHdxOGZoRFZKS0RrZlRFN0NEVnYxczhJU2tmQzRJdUdhZ2RUWUov?=
 =?utf-8?B?YXFYaXZ6dG43Q3EzZEJkc0M5UE42cFF1SXMxTEhGME1CWFhHQmdycEluYzVK?=
 =?utf-8?B?YmgxNXRleUErYVBXMmxUcXlUSWVxOEhVQ004T0oybWk3SWhpYVYzbHVuTjhN?=
 =?utf-8?B?MHpIM3RZS0RaN1lCclRHVk9RQ0hiUHlEWEpPd3prcXg5d3JBYU5CQk9TZGJt?=
 =?utf-8?B?ay9HdHI2ejVUQ0NxVklPMktBR3ZLTVcvaGR3anNOelJKV2VjelBmYlBPQTVC?=
 =?utf-8?B?SDlibWhHMDRGa0RJaUo5aFpnMnNtZUd3ZTR1K2pvVWc3d0ZLb0NiQUI2ZC9w?=
 =?utf-8?B?Q0gydkpVZkdoeFlOdHY2N0dOYXQrYTlxSWJEUnVNNG5Ubk8wcDlCU2xDWEdS?=
 =?utf-8?B?OXNQVTZMMDFvbCtNWU9VeE1QWjVmVU1zOVFpQytzbG56RjFlOFVpc0h5V3VW?=
 =?utf-8?B?a0V5S2t2V1J2bXdnRVc5bEhKL2N0aS9UZndhY1JDWlJIdzBIRzF0TWtUWnNE?=
 =?utf-8?B?elNiWGZ4ZXFoTGhPcG9yQW9zcjZ3Mmt1bW1QZXlkSVpIam5QOUxVOEYweU96?=
 =?utf-8?B?KzM3QzZjUUo1SitBWVFaNVdFbHJVdlFUN0R1MnY2dHRxNjdZN3JoMGdFM0tC?=
 =?utf-8?B?L0xzem53UElpcEV6NHROQXMrdll3amloWTVIT2JUdTNvWWRKanJuZGFNVGdz?=
 =?utf-8?B?TXM5azFWUURZQUUwUHk2OStYaklGd1pQYmxrYVRLVmRyMXdkK3hrdFNyeGpZ?=
 =?utf-8?B?cTN6Vm9BS0x5RW1IRUJ2RUQ4OGJtSDBpQzZiQkEva2dQZ05vQzQ1NEl0TDVa?=
 =?utf-8?B?QllyRjN3QmhqbEc3SEZKeEJ3bHJJNjNHWkpEOEUrS0FPZHB2MXdaNmFwZXdB?=
 =?utf-8?B?TjZYMzlmem1JeUF1V3ZZSGpJTURJQWlDb1JRb0Z3ckFjV1E0c1g1Sk9YZFhM?=
 =?utf-8?B?cTdxZEtncm9YbVhPREdOUkZjVldCdXJTeDJsRDRac25JbVNWaW9Xd0FoOS9a?=
 =?utf-8?B?dDVzMlQ1SEtydTBtZ2dlUSt3bXFQU3NKbW5kY1FwTnc4aEFHbjFST2Z2S0ly?=
 =?utf-8?B?Q0ZXWi9ReVNxQUZmeURLQld3UlZVWExpZXNwTllJSThHbjc3ZU9aa0dEcjU3?=
 =?utf-8?B?ZEViVndqcnpSQkNwcXlJU0xhL05EVEhrei9ZanhPeVdQU2UyL2lXMlNGUkNm?=
 =?utf-8?B?OCtOSmw2L3hhOVlpazc3OUFtdmZtOGJ1ZzkwendxY1RLeDE5N0d4ZEY1TnlG?=
 =?utf-8?B?MmhsSU1FT0lKaGE4dTc0V0ZUYU9WLzR4MlBPWlNQOFdlWUpxM21CVGZRbkN3?=
 =?utf-8?B?NDg5OU1nNXdPWGpsNmNNR2VLRXFhNDhJbmpjVHBkWWlSQ241QkgrWTNFNFp2?=
 =?utf-8?B?cG54bDk4cGdYdC9qVExTRnQwUUZ1WXNUOTJiZ01jdGZvMVVtQXE1b0Z4WitY?=
 =?utf-8?B?YktKbDN4dkoyWEZGNEJwTzVhMlVCbk1oL1o5UHF3RVVMUkxHRDVMbnVSR2Ji?=
 =?utf-8?B?NjVoNndCNHFlZHFFZUNRM2toeEJWMUxETm40MG5HSVBXWWl4ZVRSVWJSWExS?=
 =?utf-8?Q?ouKOETTSFSrP5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8ac07d-e358-40ed-c703-08d8cdbf6ca1
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 12:28:52.0913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +J1bxSxRi1E1T3pF8mzNMTCX6K1Wb+xe92kNu8OFOVrgpl46KPD71cO5/5pdGEuzniQtaqaXhBIRdRU77oxb3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5237
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100121
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100121
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/02/2021 20:55, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During the nocow writeback path, we currently iterate the rbtree of block
> groups twice: once for checking if the target block group is RO with the
> call to btrfs_extent_readonly()), and once again for getting a nocow
> reference on the block group with a call to btrfs_inc_nocow_writers().
> 
> Since btrfs_inc_nocow_writers() already returns false when the target
> block group is RO, remove the call to btrfs_extent_readonly(). Not only
> we avoid searching the blocks group rbtree twice, it also helps reduce
> contention on the lock that protects it (specially since it is a spin
> lock and not a read-write lock). That may make a noticeable difference
> on very large filesystems, with thousands of allocated block groups.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Look like btrfs_inc_nocow_writers() came in later and made the
RO check redundant.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
>   fs/btrfs/inode.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 04cd95899ac8..76a0151ef05a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1657,9 +1657,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>   			 */
>   			btrfs_release_path(path);
>   
> -			/* If extent is RO, we must COW it */
> -			if (btrfs_extent_readonly(fs_info, disk_bytenr))
> -				goto out_check;
>   			ret = btrfs_cross_ref_exist(root, ino,
>   						    found_key.offset -
>   						    extent_offset, disk_bytenr, false);
> @@ -1706,6 +1703,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>   				WARN_ON_ONCE(freespace_inode);
>   				goto out_check;
>   			}
> +			/* If the extent's block group is RO, we must COW. */
>   			if (!btrfs_inc_nocow_writers(fs_info, disk_bytenr))
>   				goto out_check;
>   			nocow = true;
> 

