Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5925B974E
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 11:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiIOJVc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 05:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiIOJV3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 05:21:29 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140070.outbound.protection.outlook.com [40.107.14.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A747F89924
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 02:21:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnZ+4iV+0LaUtYSg/jnOQMzWFp8yTpM77ZHTOGjhfMBP0R6CL9FNEUSGbiRU3pBzIH37thWJVntC/l/G+c6DDF0QvVpRmW7O7dGSGsAFD6dDxzPDj8PVeomZTHluTfSvcOzLK5UylG9TXcHSudBoaouAnZaPYBlQ4ZrGWJK+A5d5akSvGDI4ySN2pT2o4gQZcl51wauEPHQ9qEah1XNhmp+hB3rjF8iLgkbrRVkDSJqzd9h3xAunbkqgec5cgwZ5xrB43j/7tDKA2fnBb7w4NIkw4vMyBiGPLmP+npWX23s0MAWXSpes2Nmz6i6yWkP+6sLFOp5CTRb7Ys/nzlLLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNulqePAwE05J/CapB5vP5XO7957bzHPA5/J0sUYlAI=;
 b=Zj4xwQ3lWPwr1fE5R8PhMfofPQaBzlNEFlC3SlOREdhlpYNodsHkljnRoEz1DWtOyF2AmWr6wtkOobf6EfbF7QL/NhLe9iq4tcfspawaUdUugUGbYLfXPqAqKvQ+rMsWCmvLBJzYCW41iyToJO+Ob67Wd0gVZ/rLEWAz4iJtUFzE5+tYbmAy/7KvBtBVlgOm9k8j9WL/ljLpoH8rxTbxNAjG3zf3psEpnj0uL8X1mkZTl6IoajCKrpGcjvNHCL/WvR7/k8N10A/mEjFWiGL8xuLooRg7ZC71zkl1NB2VlnmZ5y0qSjqJCdoVxsu0VYk+tKQmCGvWlXt17zCQXJG8MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNulqePAwE05J/CapB5vP5XO7957bzHPA5/J0sUYlAI=;
 b=c924LXgppm+8zzZew+fGBo3V9k7fokJn3oBl/MGo+H6ZCk0Y4iMEAesvdAu2uAI0RiolZDHGnnXD0eeZbuAe/gt4oYUsqc6ufAWIVQhzinJbbTtM6q8xS4rnbyP97fld9JNU5c+qUpRfG+yJ0pJjkxrNr28FWVmaMR9BbupayZdg7hUTq97e+EjV+CJdduz80Cr+zVYmi8gBaSg4Yo8yYn5OSzd+FRQ5HMRjjpfLNjugoHkBWXyIdsEfMwmWS9DBFAYLK9W8hEETLmTk2ByhnG2HSr8MrLJ9Y535VgBlSaCUWS6ylN4ZFHEsqeWSk6DFv49geaNh4sMM3pr0bDOJYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PA4PR04MB9486.eurprd04.prod.outlook.com (2603:10a6:102:27d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 09:21:25 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:21:25 +0000
Message-ID: <3929da6f-686f-9545-ffde-81f3aa3586ca@suse.com>
Date:   Thu, 15 Sep 2022 17:21:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 11/17] btrfs: move flush related definitions to
 space-info.h
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663167823.git.josef@toxicpanda.com>
 <a946709036f0527dba6ec810e9cd61b19d267d6c.1663167823.git.josef@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <a946709036f0527dba6ec810e9cd61b19d267d6c.1663167823.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::29) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PA4PR04MB9486:EE_
X-MS-Office365-Filtering-Correlation-Id: ca23ac9d-89a2-426e-0234-08da96fba9b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wK+fqewv2fSLo6eXPX0hyZ199xghzvDKCLicOK6K0jS2VfWWPdYyot0eNtbhh8wLG5/VZKyfeNEagd0TZ8KAGf1M9lNTGnT8/za7FK0yQdcyyDpAD7WdCtOnBpCv5sNkKuEqTcgS7k1KRvGw4xS5PT2onY4U9M2LrTBOcTjoEE2V1QyNMvJ9am0dPhvIF4qUT87VewEEQW+neO1N/ccjnaNyz222yIMhlW9nuKuZIChCtxzdXdmHNfT3wSfdDyC+F+a5tVd1M0h+IpYqavAnwZ1r3PU+45k5phQvNnCy8x6rdZskqloNWU4LEoBTQRu6Vag7p32eDsssKfNev4GB9AwaFKgegakzcbiSPeop0tkS4hSkSJutlRiVae1KBEJJO0X1xtNmnaBwfkqj3rvllrpBbgKfXY4lTVRVKZmTQAXc0gE/MjUZzSUNCC6NRdRuimrUDvN0Apf1Sq2pQSoh14pX0gfJFDMteOJ82TB40JOoHvjyxw1jhgWMKHBJ1zrat5e0rPeNIVzHE7VyHZcGWzAc7dAF/gVDkwdXdhnS74rxPed14zeiXDMx9/UnE5Utzn5uWyqbObcLqRjG3xgVpZ17/Kq2dCwf8WpsOUCBr6FlnAvf9pHLChCUo6QnmTB3h9jKjqJVSPlMRicrS1emngHlg+C4gj/SUurcqwI8eRD71Fr006Le8j+HRZdFYqs9kdL82yqq5qigE2vJOL9xGYQwPFKkn8/tP+QNniXO84YELl6NrjMjhvPJ3i67A0lBrFGwW7Oqyj78gDXC+t4R9OHZroG5CssyQVZh9nvAukM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(31686004)(5660300002)(83380400001)(38100700002)(6486002)(66946007)(86362001)(8676002)(31696002)(6512007)(66556008)(53546011)(66476007)(6666004)(478600001)(36756003)(8936002)(316002)(41300700001)(2906002)(186003)(6506007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1pVa1lXdkN3azdmZC9wT1NUWkZQZ2RjN2ZaQzJKWjg1TlVLV3htamlKcHVk?=
 =?utf-8?B?RDNYT0oxTThDUjVKNUZtNjVseW1MWWxoZDJ5MHpYZVBvejNNZkthY2s5S29v?=
 =?utf-8?B?OGg1R2pONzdLR0xaQ0JEMjF2S3N3bnFKN25GbzVpby9YaHRRald0Q3BBRnZN?=
 =?utf-8?B?QWp6RGJFYUZ2cDBkZGo0NSs3eHArOEp0MG42Z3p6a1VLY2NpaERQV25OUkR3?=
 =?utf-8?B?M2RYc2lZWXlLN2FBa0tCUDg0UTlqT1FIZDBqc1ExMkl5WkkrTE5jWUhQeGZM?=
 =?utf-8?B?OGJxK0UzR3ZMOVJRbmpNZkN2ZkgrK1IxNXVjVUJySFZyTGhrUVBmczhhZG9i?=
 =?utf-8?B?MlBCK1hXd3UzL1NzSmR1cVBrcU5WWWRmUDFhQ3VEVE1xcXU2bHcwc0xGRHVW?=
 =?utf-8?B?UGh5VWx6Y3dNM0tqdjhDT1VDaXcxdVF4cGc1L05wK2k5RzRNNkpIUGZUMDdK?=
 =?utf-8?B?WnFZcldGU3prTlhVd2czT2RyQndlOGw3MmF5a3dEK3g4YkhmN3d1L2FGT0pz?=
 =?utf-8?B?eHZISW5uM0p5OVUyemdqNjU0MlpMOCs2MDVGd2lMYlBSMEt2QnI1WE05ZlpE?=
 =?utf-8?B?TFNDang2cG5YdmxVajV0ejBiZGdpSmJzR2NzR0RDczlGdkNYbUdleUFvNi9I?=
 =?utf-8?B?R2Q3TmhrN09qa2ZSeGpienVZTlFWcmNkSUU3bFR6QkFwaUJPbkJsNGY0cjR1?=
 =?utf-8?B?Z0ZNSmZzUnhpR1IrblEyd1BNUEdPaDY3RDdldFg3UThTUVpOZ2tTYm45RCtK?=
 =?utf-8?B?Wmh1UnVDd016ZXB3Vnl0V1BRVkFsVUYxRzI4QnJWRXNORzF5c1RxYXpuaHRk?=
 =?utf-8?B?ZjBUNitzK0F5QXFGV3Z5UEFHS2hJREFnY2d4TFQxTVQwVlpFOHBYbG1TUzBq?=
 =?utf-8?B?VTdaaXhlcmNNTFBxbmtJWk1jTmRNK3Z2YTlqUlVvVi9JSHAzanl4WFlzY1R0?=
 =?utf-8?B?Z3RwcE5qTWl5UFUrc0FXUzJJdTVtZm1Vc1ZEc21MR1k0dlZpcVFLdkF4eXRL?=
 =?utf-8?B?aDk5MXBFL2tZcmV4bjFaVmpxRnpsT3dNM0xsQ1YvYm40WFc3VHN1bjJPUkRS?=
 =?utf-8?B?cU94V1JUNnFmdEcxUkJQUXFrMmE5LzdSTGdRQ1VaNGZCc1ZOYXdWaVNDK3Yv?=
 =?utf-8?B?S1BsamF6c1ZlYWZtVUl0VWEyZmdqWTFXV1lERVFFczhxUkRCNkdocU9qMkQ2?=
 =?utf-8?B?dTdtR1FNVGtHRXByOUl2NUhFT2grK3V0US85WVVSYytRdjc1Q0dNb1lRdHJ0?=
 =?utf-8?B?Y0dNTStuaitMdUpGME5EUkNGLzE3c3R3UldjOUt3VTBRVFBBc3dSNWVSMHhq?=
 =?utf-8?B?WFVaSWFWZDZyZlBFODdGUGVJeXY1TkZrMU5oNWVGSGNUQXpTQWdaV1ovenBU?=
 =?utf-8?B?VzRPeU4zTFI2TGRadFlpYUN1c29Uc094NTN5WEI4Qld0VUk0YVNwREpMRWRH?=
 =?utf-8?B?aFN5R1RrQ2RBdURZMkduS3NCYlpqUWJOelJueHZRankyU21YRkhPM3J2NG1Y?=
 =?utf-8?B?S0lGUVp0dTJIdDdFWUpUbU1aamlxYWpUSjJ3UXNjczF2eVREMjV0aDh3a3hV?=
 =?utf-8?B?TEwyd2lkWXEzTlA2d20xVmF5T2txcFBLK1JYSTNBczEvLzRXTnlvcUpBdHRl?=
 =?utf-8?B?SEoyWFZ5Zy9zNnJLSkduT3k3dlg2dytuNW1TQVorTzNENXVFWVV1QUw2NmJv?=
 =?utf-8?B?OWdZVVFUYnpQS3VTZE1HMG9reFB5dC9ISy9QSXpHbUI1ZnE5UExUNUVIQnZo?=
 =?utf-8?B?emNUR3ZOZk5uUzVtNTVqNCtOV3BGbWdxWXJpOWdKeFg0akdyQllxUXZwNnlm?=
 =?utf-8?B?amEvaVFsbjBHNkJMem82eEM2T1lYYWhWelU5RzFWcEpVVmtseUJzUlpoR0pm?=
 =?utf-8?B?ckMvTVk2RUxEQ0YrcnVCZHJPMGRVY2NLelRtY3dXOENna0RESUtNSkptM3JW?=
 =?utf-8?B?dHZYUllBWGl0ZlJiemRiZFIrMEo3TzZCOEdlR2Y1YmVKQXBSRjF5Z1J4eU5w?=
 =?utf-8?B?TmxTSWZnSEhOUEJUdlFxdERrZmNweG45V0ZkWkdwYUZ3QS84eGQwN2tBdkFl?=
 =?utf-8?B?UlVQV2F2b0RKa2dSZkJBWHhycngvR1FFdGppV3hvdE9DRHI1OTdtS21vNXA4?=
 =?utf-8?B?SjlHS1k4V3FMbERBR2pQTFFsb0hBNkdUQUZpNmwrcUdPdEp6cEI5bndvcVJ6?=
 =?utf-8?Q?H2FaQZTXFkSMapRSGVEcpYA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca23ac9d-89a2-426e-0234-08da96fba9b6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:21:25.5687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xw8EncmZHlHD+AT+Qjkbi+9yIJq4mXLi4Ek2glJ4S8Tl5/dxizLlucLf2ePT6qsN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9486
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/14 23:06, Josef Bacik wrote:
> This code is used in space-info.c, move the definitions to space-info.h.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good overall, but one new header makes me wonder:

> ---
>   fs/btrfs/ctree.h         | 59 ----------------------------------------
>   fs/btrfs/delayed-inode.c |  1 +
>   fs/btrfs/inode-item.c    |  1 +
>   fs/btrfs/props.c         |  1 +
>   fs/btrfs/relocation.c    |  1 +
>   fs/btrfs/space-info.h    | 59 ++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/super.c         |  1 +
>   7 files changed, 64 insertions(+), 59 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 60f8817f5b7c..d99720cf4835 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2654,65 +2654,6 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
>   
>   void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
>   
> -/*
> - * Different levels for to flush space when doing space reservations.
> - *
> - * The higher the level, the more methods we try to reclaim space.
> - */
> -enum btrfs_reserve_flush_enum {
> -	/* If we are in the transaction, we can't flush anything.*/
> -	BTRFS_RESERVE_NO_FLUSH,
> -
> -	/*
> -	 * Flush space by:
> -	 * - Running delayed inode items
> -	 * - Allocating a new chunk
> -	 */
> -	BTRFS_RESERVE_FLUSH_LIMIT,
> -
> -	/*
> -	 * Flush space by:
> -	 * - Running delayed inode items
> -	 * - Running delayed refs
> -	 * - Running delalloc and waiting for ordered extents
> -	 * - Allocating a new chunk
> -	 */
> -	BTRFS_RESERVE_FLUSH_EVICT,
> -
> -	/*
> -	 * Flush space by above mentioned methods and by:
> -	 * - Running delayed iputs
> -	 * - Committing transaction
> -	 *
> -	 * Can be interrupted by a fatal signal.
> -	 */
> -	BTRFS_RESERVE_FLUSH_DATA,
> -	BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE,
> -	BTRFS_RESERVE_FLUSH_ALL,
> -
> -	/*
> -	 * Pretty much the same as FLUSH_ALL, but can also steal space from
> -	 * global rsv.
> -	 *
> -	 * Can be interrupted by a fatal signal.
> -	 */
> -	BTRFS_RESERVE_FLUSH_ALL_STEAL,
> -};
> -
> -enum btrfs_flush_state {
> -	FLUSH_DELAYED_ITEMS_NR	=	1,
> -	FLUSH_DELAYED_ITEMS	=	2,
> -	FLUSH_DELAYED_REFS_NR	=	3,
> -	FLUSH_DELAYED_REFS	=	4,
> -	FLUSH_DELALLOC		=	5,
> -	FLUSH_DELALLOC_WAIT	=	6,
> -	FLUSH_DELALLOC_FULL	=	7,
> -	ALLOC_CHUNK		=	8,
> -	ALLOC_CHUNK_FORCE	=	9,
> -	RUN_DELAYED_IPUTS	=	10,
> -	COMMIT_TRANS		=	11,
> -};
> -
>   int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
>   				     struct btrfs_block_rsv *rsv,
>   				     int nitems, bool use_global_rsv);
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index cac5169eaf8d..a411f04a7b97 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -14,6 +14,7 @@
>   #include "qgroup.h"
>   #include "locking.h"
>   #include "inode-item.h"
> +#include "space-info.h"
>   
>   #define BTRFS_DELAYED_WRITEBACK		512
>   #define BTRFS_DELAYED_BACKGROUND	128
> diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
> index 0eeb5ea87894..366f3a788c6a 100644
> --- a/fs/btrfs/inode-item.c
> +++ b/fs/btrfs/inode-item.c
> @@ -8,6 +8,7 @@
>   #include "disk-io.h"
>   #include "transaction.h"
>   #include "print-tree.h"
> +#include "space-info.h"
>   
>   struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
>   						   int slot, const char *name,
> diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
> index 055a631276ce..07f62e3ba6a5 100644
> --- a/fs/btrfs/props.c
> +++ b/fs/btrfs/props.c
> @@ -10,6 +10,7 @@
>   #include "ctree.h"
>   #include "xattr.h"
>   #include "compression.h"
> +#include "space-info.h"
>   
>   #define BTRFS_PROP_HANDLERS_HT_BITS 8
>   static DEFINE_HASHTABLE(prop_handlers_ht, BTRFS_PROP_HANDLERS_HT_BITS);

>   struct btrfs_space_info {
>   	spinlock_t lock;
>   
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index be7df8d1d5b8..2add5b23c476 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -49,6 +49,7 @@
>   #include "discard.h"
>   #include "qgroup.h"
>   #include "raid56.h"
> +#include "space-info.h"

Why super.c needs this header?

The moved code is definition for btrfs_reserve_flush_enum and 
btrfs_flush_state, but I didn't see any direct usage inside super.c.

Is it for trace event?

Or you just did the same search using "FLUSH" as keyword and got hit on 
FLUSHONCOMMIT?

Thanks,
Qu

>   #define CREATE_TRACE_POINTS
>   #include <trace/events/btrfs.h>
>   
