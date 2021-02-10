Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D635E316C69
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 18:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhBJRVC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 12:21:02 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50866 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbhBJRUk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 12:20:40 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AHA8oo083926;
        Wed, 10 Feb 2021 17:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QVgjsG/YUMAV+54xWyYlRuP4AcnF1W+nesKS0dGNAEo=;
 b=f2xc0+b7lVHQUK18drJzntnX3HVDxeeJ/+bNt9sIgrxBLt/Nxq1Rz8INL7km7eb5/CoB
 nxY+bswIjzaeykkudZ0mZzpjzZFc9dmbxbXBPrwAWougcqN3CZdoQprgR2C8Eie3KeB2
 nTsEzXf1d5pHtQRpEmX34nBzbFGpry8qMVvXTXmgJompB1G0+bUJwG5eMsasDgdVLlMg
 +4tQ6goD+wxE2LzASQbcOjUuqkcCzdu9IYNPFj8yGVgE7rKYb5pQ4bS07D65YyWShEeH
 5uR1r+6ao7ECgTf17mxzWhRayiZP/06ZXmvGHbc6wmqbcKS8i2yRJ+GufDEi1QRIXSL6 mw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36hgmamee2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 17:19:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AH60Qp158633;
        Wed, 10 Feb 2021 17:19:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by aserp3030.oracle.com with ESMTP id 36j4pqe273-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 17:19:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3QtosHADKe+sfyKe1M/0t4H/ihMl3P5iNBUOE5X+tQXSeYuqAKX9V66p0SSnjeC/PaM2Jzi8IpBBTEYyKfibF9oAU7vZyCI7XWXjw0CFRjYsJZ+HGghtPOUr96jHN1hTwN7TJKA9ePQqIYWPajP5TCB7tA7rm/gyX5/S41eNtc0kHvWyBgeLVWp5WfqJ8gYTDBCzaYUFlivVAxgVeY6cz7Ynmxc2LnQfT2NGM5eEm5IP2gcDlowRZY34jaEQZnZr8ou5BWfSGUPqTO7cBA6DXu+LPX2uFtCXnMekVytx9EzOriuNzhR0duYLd3Ilqr2J2uzZoxXjCVS7H9VuAXh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVgjsG/YUMAV+54xWyYlRuP4AcnF1W+nesKS0dGNAEo=;
 b=UOav9T6njRaO8ZN21TT4G32uQMmY9El89YTk868a9mtMBjRbPPtSCY0IVtTZ+TNZLnizmNiL9VIdXGaB39Y3Wh+EW/K+gNNGrStAUklVIUF8qSvU23GlolIUpqE5lp6SRY42+I/eWeHlInXyvWDPatwRbYopwbvqzNwNjp+cN/Ac1gHFk13AhBzaT/90bmHSLch4aBCzxP2TQXZucEFdN+OIEMKc5KfpGndSw7c6MnM7tPTCfuczQHcrqqbILc7bh7DP7qfcoLnu8Lj12eeJQEfap6TLZYmdznl2CquVKQ9E1ht0Og6TNSqwQXF6Iupzby89VRSzCmkH1Q512GQ9wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVgjsG/YUMAV+54xWyYlRuP4AcnF1W+nesKS0dGNAEo=;
 b=ncobahFwdvmPmWxm4XhXJKGbTKgEsucXfpYTvepxXy/sIFY9s8frEbMl+JPKz4xfei4nkeLml9WvJUze2P9rTU2zfDcmOGZs01qj5qF4O/7CbE8iYe76fp8H11MlRrkyP1SiKBt7GY/JKq1bkot7KJWdtH/FmAnSa8LjxWLDTJw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN7PR10MB2737.namprd10.prod.outlook.com (2603:10b6:406:c5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.27; Wed, 10 Feb
 2021 17:19:55 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::9d63:7b79:33d4:a802]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::9d63:7b79:33d4:a802%3]) with mapi id 15.20.3825.032; Wed, 10 Feb 2021
 17:19:55 +0000
Subject: Re: [PATCH v2 3/3] btrfs: fix race between swap file activation and
 snapshot creation
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1612529182.git.fdmanana@suse.com>
 <e7669602a731fc542034cbe933b067326c5aa3ad.1612529182.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <49bc4f75-e1ae-74c3-7a8b-c5aba2457857@oracle.com>
Date:   Thu, 11 Feb 2021 01:19:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <e7669602a731fc542034cbe933b067326c5aa3ad.1612529182.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:7932:39e4:bc3:8319]
X-ClientProxiedBy: SG2PR03CA0148.apcprd03.prod.outlook.com
 (2603:1096:4:c8::21) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:7932:39e4:bc3:8319] (2406:3003:2006:2288:7932:39e4:bc3:8319) by SG2PR03CA0148.apcprd03.prod.outlook.com (2603:1096:4:c8::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.11 via Frontend Transport; Wed, 10 Feb 2021 17:19:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 960515c3-2dc5-4e86-de3a-08d8cde81598
X-MS-TrafficTypeDiagnostic: BN7PR10MB2737:
X-Microsoft-Antispam-PRVS: <BN7PR10MB2737FFBB46802DBC1D9E274DE58D9@BN7PR10MB2737.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ng6TfxXAZQzWZO87rhyyr+N5eZoh7VzxyZ37UB/iAsG1rnKuXXv1MwQPAx1ubePorzVrjgYAN8q3mJV5fPqwY2Ex7Av8SDe3WnEbcvZZh9g0etbiFswiR0CmBm/WYiQQa69WFRsidJXmwn56xIULAODbmp79WTWMspvyLrwoM78cJjiDfE7uSHJpOkGZ483NEBDos2Bkxp+k1IPGadSo5wfNbGCBRN92QGXcPHC4AN1g0809x9gZrLozvcE3BneDcdx/ZET4l8m0C3ksByCgHns/sikP86Kc+WGDzUIEDZOB2u2+V2UN9wzMhRMR6V/a2oP+rOOuJjrBvQkoPqb7pr9k2WhjScplVPTKIHsVAjf1DdZYw9KZYrWdMXjW+hxnrWQXJSQxV8LRqWId5JzxPBnXho1EYTwSYXZtaiPTFPi9SMdoKHDCOyxaVVmffdhBNmERXhZMp94AZyeiphsvmWY2uwsAjXqnVF5resuVc4J7MaSzo829T/3/Qp/fr9SQjod0F5o0p3xtufsJwYsZVHFOsMoMaMrAv7RB77sE2so+rEUbkvhGIfQup3xhB8YREd8FHli/eBbDJoWqI80WxXfO5K9VxbEhRg+gp5uckIw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(39860400002)(396003)(136003)(86362001)(2906002)(66946007)(5660300002)(66476007)(316002)(66556008)(8676002)(6486002)(2616005)(31686004)(36756003)(8936002)(478600001)(16526019)(186003)(44832011)(53546011)(6666004)(31696002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QnpKQkZROFp5eDY1WlVKYzdZWjNpZzY2T2NDK1NKUlVGL0pzNjRMakg3cE10?=
 =?utf-8?B?UC9CYzRXRGZaZzFDaWNWRXZLZk5WRmF1MU81MFJCU0lCNUxZYkgyZVVON0xq?=
 =?utf-8?B?UVpRQTl6bEs0anBCeUtxWFhVYlVLM1RoVUMrQlF3Wk9zTGFwZjBPRnA3ZUUz?=
 =?utf-8?B?UGh2MlV5Qm91cWpMcWhuSCtQWGpZUU5uTnM3enMwSnBjVStPdzdnK1R5U240?=
 =?utf-8?B?eGhOYjhHVVMwR2toRVVDTjRvTWFYa0d1SlgvWEgzTmlvODVPbndLQ3p6VUVC?=
 =?utf-8?B?dFExYnFKcm0rbi8zT1h5VVU5eTUyNWh6RDg0VWpWMzF2OTg0VG1Pb1ppSEJP?=
 =?utf-8?B?eEFWR21OcTJMZmVnT3JjSW52TE5vQ2FMY2ZNenhEbVlpRVJ4MkVtMkIzV0VH?=
 =?utf-8?B?RUtHTWYvSWhqNTkvQ2RwQzdUSElETllEc0lGblFDQ3RQRFU5VnVuZVR5bks4?=
 =?utf-8?B?dWZXK1NIb2krMittMUwvNWcrQ1ZIdklSMGtib1JpancwQnR4cVMvZVlncytW?=
 =?utf-8?B?dy8wWjN5K3B1dGxLWVZvS0lxZnJYZHRacGs0eFJQd2hySXJFMkw5dy85aVlt?=
 =?utf-8?B?Vys4aEFWME1ZYWdkZ09WcVNDc3g2YmxjVkFyVFo2NDBSdGpIeTFmTE1qR3RI?=
 =?utf-8?B?QytBamk4TDBja2V0a0cvbDNaZDVPWXh0WEhjTTQxY2NubnVyVkFUNlJKRUs0?=
 =?utf-8?B?dXFRbE00dWtuK1d4WEFpQnRpa25rOHNKMlh5Wkg0S2svUFhrMElxcjRoNVdP?=
 =?utf-8?B?WllxL0Y5dFIwZE5QVGhxNFcrVjBDbGhGTnJrNjI2RFZhK3hraFYyVFhGVHZu?=
 =?utf-8?B?bHRDU3hCZlVmaFZqUy9tSDRtOVphQnJNaUFOdTF3bEFXekhUSTUvQXY4dUdM?=
 =?utf-8?B?cnFiR1BXUGx1RzFJeEEyWCtkOFpQTTJnL3BpOHNJQmZtN1EwYXVrYUJ1VzJL?=
 =?utf-8?B?cWxTVCt3YnhSNFVzcWJRcnFmZDVOblo1WUhxbDhKVSswZHh3b1JGdkZlWlQv?=
 =?utf-8?B?NmErbzdUdyt5QkhEcWFCWlBOUEtrV1lVbHJBUEZLSFRTNnl4NXpvOFNTSTVB?=
 =?utf-8?B?UFlLZ09LNnJGTkRGanpkZkxORkFXQTVrSUZ2TmEyaWlaMHoxdWtDU2lvajJF?=
 =?utf-8?B?K2NOMzlVS1J6MkR6aHEzaWk5MVpCdVlseUJ3Mlk2emI1UkU0b3d6d1c5QnV4?=
 =?utf-8?B?NUxydzJzUEVNWHpZNHRmOXk5alVOUVpIbW5wNHk5bHM4WjV4UmxvMHJjOWhR?=
 =?utf-8?B?aWRxSHZWTzdmdmlkOTgrei92SFhIN0Y3MkxBaEl2alh6aU1kd2VZYTVNQ05T?=
 =?utf-8?B?WE9oMFgwc1JORXdnWmVlNXJtMGRkUUNudVFkajV4bnZpNlM5aXNIdUJSWVhB?=
 =?utf-8?B?WDJyb1VqYXpiY0RYNEFpZU82RGEyc3pWM1V5WUNERkdacERudFhxb2VnRm04?=
 =?utf-8?B?MkU3NWFIdzJVZjNMS2xUWXBiclVZTlhaVlhpa3FMbFZxTkZTVFk1aUJjZnN1?=
 =?utf-8?B?QXowUm0wL3M3R0daS2o4STNHdXBZQ2FveG5BeGRUNjRhZmZTTFdUOWsrYnVa?=
 =?utf-8?B?UFBoUUhiOEhJV2tKelZNWExONmcyaE05VWVudUM1WWpuYy9JcVcwY2ErdUkz?=
 =?utf-8?B?NEU1T3hlL3ZOdWNiM1NtMHVyQStvSGJyL280cDJOc3JmV1pCNEtHcGdvRTI4?=
 =?utf-8?B?YmNwa3JsQXNnOXpaQi93eXFCVWtISTJ4MTBOcnBWZ3FwRWVPckZLaU9xMHN3?=
 =?utf-8?B?VzdPMVBqSXhhcHYvWDVIMnZRZGd2NFN6eHJPb002MkUyTXB1M3BrVDB2WlU4?=
 =?utf-8?B?TjZxVisvM1VvVm9wTXZGT2ZSZm5QMGFEMXhPd0trcGNmY0x1QlFPK3JpOVRO?=
 =?utf-8?Q?XiuwmvNHtwyyM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960515c3-2dc5-4e86-de3a-08d8cde81598
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 17:19:55.3600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UmdXYMwBEWXfrAspXiL6VFKshQ1kuewK4ozvu1og3E31JLyYmb+rXeml6eCsC3/VjTGtPfQu7szDWqPaSfPrHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2737
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100158
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100158
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/02/2021 20:55, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When creating a snapshot we check if the current number of swap files, in
> the root, is non-zero, and if it is, we error out and warn that we can not
> create the snapshot because there are active swap files.
> 
> However this is racy because when a task started activation of a swap
> file, another task might have started already snapshot creation and might
> have seen the counter for the number of swap files as zero. This means
> that after the swap file is activated we may end up with a snapshot of the
> same root successfully created, and therefore when the first write to the
> swap file happens it has to fall back into COW mode, which should never
> happen for active swap files.
> 
> Basically what can happen is:
> 
> 1) Task A starts snapshot creation and enters ioctl.c:create_snapshot().
>     There it sees that root->nr_swapfiles has a value of 0 so it continues;
> 
> 2) Task B enters btrfs_swap_activate(). It is not aware that another task
>     started snapshot creation but it did not finish yet. It increments
>     root->nr_swapfiles from 0 to 1;
> 
> 3) Task B checks that the file meets all requirements to be an active
>     swap file - it has NOCOW set, there are no snapshots for the inode's
>     root at the moment, no file holes, no reflinked extents, etc;
> 
> 4) Task B returns success and now the file is an active swap file;
> 
> 5) Task A commits the transaction to create the snapshot and finishes.
>     The swap file's extents are now shared between the original root and
>     the snapshot;
> 
> 6) A write into an extent of the swap file is attempted - there is a
>     snapshot of the file's root, so we fall back to COW mode and therefore
>     the physical location of the extent changes on disk.
> 
> So fix this by taking the snapshot lock during swap file activation before
> locking the extent range, as that is the order in which we lock these
> during buffered writes.
> 
> Fixes: ed46ff3d42378 ("Btrfs: support swap files")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
>   fs/btrfs/inode.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 715ae1320383..a9fb6a4eb9dd 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -10116,7 +10116,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
>   			       sector_t *span)
>   {
>   	struct inode *inode = file_inode(file);
> -	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
> +	struct btrfs_root *root = BTRFS_I(inode)->root;
> +	struct btrfs_fs_info *fs_info = root->fs_info;
>   	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
>   	struct extent_state *cached_state = NULL;
>   	struct extent_map *em = NULL;
> @@ -10167,13 +10168,27 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
>   	   "cannot activate swapfile while exclusive operation is running");
>   		return -EBUSY;
>   	}
> +
> +	/*
> +	 * Prevent snapshot creation while we are activating the swap file.
> +	 * We do not want to race with snapshot creation. If snapshot creation
> +	 * already started before we bumped nr_swapfiles from 0 to 1 and
> +	 * completes before the first write into the swap file after it is
> +	 * activated, than that write would fallback to COW.
> +	 */
> +	if (!btrfs_drew_try_write_lock(&root->snapshot_lock)) {
> +		btrfs_exclop_finish(fs_info);
> +		btrfs_warn(fs_info,
> +	   "cannot activate swapfile because snapshot creation is in progress");
> +		return -EINVAL;
> +	}
>   	/*
>   	 * Snapshots can create extents which require COW even if NODATACOW is
>   	 * set. We use this counter to prevent snapshots. We must increment it
>   	 * before walking the extents because we don't want a concurrent
>   	 * snapshot to run after we've already checked the extents.
>   	 */
> -	atomic_inc(&BTRFS_I(inode)->root->nr_swapfiles);
> +	atomic_inc(&root->nr_swapfiles);
>   
>   	isize = ALIGN_DOWN(inode->i_size, fs_info->sectorsize);
>   
> @@ -10319,6 +10334,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
>   	if (ret)
>   		btrfs_swap_deactivate(file);
>   
> +	btrfs_drew_write_unlock(&root->snapshot_lock);
> +
>   	btrfs_exclop_finish(fs_info);
>   
>   	if (ret)
> 

