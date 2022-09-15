Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51CB5B9815
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 11:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiIOJvR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 05:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiIOJuz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 05:50:55 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BF29C1DA
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 02:48:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAu4rCSgK3fbB1peb2PkE8V8/ZT5eo4R85d9/gLRLO8x5Ihe9/SDFabdIgS0yuwTx88b7jdujQDyKWj9d/BxMU4Ecf16UvmVNBSIS9xCzjpHQNdFr0jm1yWkbuEzQ0fWWcYwh4dVc5ugdTIT7R4vumV0eVfvmoo4jK7n9H2rd44G3M2DN8ik93Vf7dZwx/HdfvcPqjn7Z5+y8yBl1KqiJ0ERXScY4FW7SlVctiBx60jrCyxnrkr8wcItr3/WGIZlDHty5FaO/AF8PFWb4g2NzuClTWB06cctlFyD1M+cliTzJDrfQ/FZU0AmLx92d6aBfuapO1DaCgNZkduWuxCw/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skaQXa+ltFgL4MuuL9wJ2SzcgBz8mqSFE+cb0G8e6YU=;
 b=ZxyQSPIW4uhtPm8zfxzoXH/HxDJwBMv63z7zFK7yJD0oNWzrbMH3NlY065OgGKQ9njH/zf+heWM43G6ilxIJrT1VNIDmkNVf14A4M76WJVfsWs4P2OgQS7EJ29MGdBS7PfhU20mXPVC83p7qwZFdNa5p6dOkxIOLpoFmQ9GF+MXcVdxaQIAKebSIvPh9vbkFzMWnOyK6KfS2MLjFm43hYH62lkm5lJokt787h6Sb9sF49J2rEppUZ4BGbbQ0pK0F3zwhW9XWo1dd4je7IUzMYIG/BQg4S+FrZGy9FuxqtVLqOByy3JJpsVNU7dmbPqPz9sreJyi10wwXjeuXHmgIqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skaQXa+ltFgL4MuuL9wJ2SzcgBz8mqSFE+cb0G8e6YU=;
 b=TjOs6C63y7XAYwxTKx5ip2gv5txp9RnPo9YEZk3q/qvYZy6Z1dOK10bfsQZLhT2x70r4ZYdi0SDxmiGw8XP32TV4MA3U8sAu0IJMgczdHUICGZ7WXNLBsny23DJQZOK+EF1JvryjfEl4j4MeDwLp88kG9SnQqIkkvX2r0OIIG50v++ZNNPGGbmx3FMKnZwLbM0xphwroCgkQYSVfa8Fb+PirfciW8HSkoRHI0uJwBjGX/RkigsYSJg5rWmRnMJYxj/0H1UBQhBe8C7wqAvSAYGSCqRl0/FWvh7youx+DCPbYt6kjNUl0Ooo26nIC/5mpIMaIHH5ICOte53GZRLcmEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM7PR04MB6822.eurprd04.prod.outlook.com (2603:10a6:20b:108::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 09:48:09 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:48:09 +0000
Message-ID: <1f65c1a8-8d08-6aff-1764-b2549f195183@suse.com>
Date:   Thu, 15 Sep 2022 17:47:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 00/17] btrfs: initial ctree.h cleanups, simple stuff
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663167823.git.josef@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <cover.1663167823.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0035.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::48) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM7PR04MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: be3c01ab-a22b-46da-3df9-08da96ff6587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 19+MzDFjLFyyV0pDXajWYXPWynEcb9Rcv5TIY3EBknUaQTGfFA+k+luha4E4yUKSNU3b9DLyyhagIKEO/twhg+Iq/yoinlwucpp7lUiilu5RmYMvj+m/oPbh+mlu12+YDZQRphMgivPtbJkfPRKUWtDPyPVDWIZFx/QtaiOg6fXpw8KDWOu24bOYtlgRyJE+qlJ5amJoI5W1Rjs2bPj5lItFBIoCrDpYmAUXZa7TfNth+lwlFoqrpekUmGwAa9KHchdI99p8yB6PbojAMqMJIJmA9T8uz/rKvAl6/6LKEJFtQx/Vpu4Ns4R8Fp4K3L7UGslogLticGBr9yLPqyDD5fMHAU1FYLSl2lTjMTxswpk8TcQqyzad6pNetFtOkRAXRFjqaThVw4oAdEB/4URSVo6bLqXMhNV2hPPJPBpbO5spsJwGWQRX6hnGvCazCdTgJ13JmrKaZlNvajtT84E85n1jxYwKH1qj/fIbV5JgvVAMqJnMyGSU97940ExVDB2ezA9qmEKv8Lp61qFw8OwqvgvRW6wxPNWB/BxubfuJddLMjURiwLaCeDBFMnFQ7gv8GwCTN0dS2XyZh+kuJUJyBH7hRQkC5W6lIvX6vEpyXxxVwo3EV81sLrjLC9Yg4g+IHJVIEgi80HTRJDxNNeul5fn3yLtiCi/p5Ya6KJiKQtAHUudqHaJPRx+d/rIab1PbMD0b+xdib2YbZtSujMkuI5fskfn9kJJKoAbmAQFZHsp08uCt9svSv2T4Cg4+xp8WdqZyHJlNjzyWcPupeigMy1du88dsd6vDK0ijQJHNrmc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199015)(31686004)(36756003)(86362001)(83380400001)(66946007)(31696002)(6486002)(2906002)(38100700002)(186003)(66556008)(8936002)(66476007)(8676002)(478600001)(6512007)(6666004)(2616005)(316002)(53546011)(6506007)(41300700001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cksydHcrQzkxc093L2ZkR2R0Yy9ISFRwNzZQaFBJQW9DQzhDbzdKL0xzOWdC?=
 =?utf-8?B?VTNhMk1qR1BwTHFnSithazBHemxoa1RuRFNJRFRQeENvNXJ4d21tV29mbkEr?=
 =?utf-8?B?KzF4d3BVMEF6R1BTMGd4Q1BHRHJreGpPYlZscHVuSFovMEVTL1BQRGJScHVn?=
 =?utf-8?B?aUVyTTBpdjhHZk8xMjUwZnVMKzNJUTBkNzhiejFNTHNuQzFmZFdNNmNKNVp6?=
 =?utf-8?B?c2FVSzR2OStHeE00eDZtWEtDcGl3NVgyOUFudFZubjB4T0VIVFlZSFVnK0sr?=
 =?utf-8?B?cTB3MzBCYitxSGIvRTNNV2t6L201V2ZQcmdOdzN6V0p4NjEzU2VqODVHTmI0?=
 =?utf-8?B?bFB6M1VBa205QVI2U1prdlZJY1hWa0t3MnpGTWlJTUhEaWpSaTNyVXZUb1BS?=
 =?utf-8?B?bkdtWFpzM01GcjFJQ04wM2RmRDU3QVp0RG51eHdnMkgyaS94YXZ5VHk4V1ZM?=
 =?utf-8?B?dXJ1ZWtEeGpwQld3QkRzVXFndUg1dk9HZW41YnVUR1ZvMy9DZHJjb0ZOa3lC?=
 =?utf-8?B?VnFlY1dqMFhCT055dWlMSUx3RXg2ckt5aW9lVDd4WllidnRZcXFORjZXYWQ1?=
 =?utf-8?B?U3QyUGM4VkpEam5yZnJwUmdGbDlwdVZhYVBORVZyQzRseWw4emlYQ2RVQU9R?=
 =?utf-8?B?VkloMGpvcit3QlAvNzdwMGM4NzgwMkZqQXlrdUlyTC9qTnF6WEJLUzVnMDBX?=
 =?utf-8?B?YVA4M2pieGZMS01sWENWeldXZzdwd3djenAxeUg3SyszQ2VBSkc4UFhLT2ZU?=
 =?utf-8?B?ZThxci83NE1QNlI5Q1ZLR3dtbUU0T2ZZbitvcG5QVDV4UUt3eHZHQkdabVNY?=
 =?utf-8?B?enAydUlUU0k3WStsRld2OHQwbGZHcWkrcnhlNDhoWTFrYVhBd05CMDBoU1Vp?=
 =?utf-8?B?QXZmNG94NVJwbEduTVlxRDl5aitYRm1KL2p4SlNydkxIYlVub2NPWW5XTWZF?=
 =?utf-8?B?Z3ppU0lRUlZDdUZoMzhxODBTbkFReFlVVy9ZM05aYjJPUnZ5ZFROeGIyZ2lZ?=
 =?utf-8?B?WHRDNTlyelRGbnRQa1lRUVdTN0ZZZ29UYkhmdzFBKzd3UVpiS0l3eHNGOExO?=
 =?utf-8?B?Q01hemFLN2xLdnFVaVJTRGV4blphNDNBdFBrWGI0aEU2ZVhPRXprZnplUExL?=
 =?utf-8?B?WEwyMTRRV2d0YlI5cHFFTVBLR0kzRlNJc2QzeVNpRkg1dmdXNG92UDBEZ2t4?=
 =?utf-8?B?eTA3S1NXcTFEMi9RM3JEdTArVjZKanVYeDFjOTRnV0VJdWQxZDEzdVBPZ3pI?=
 =?utf-8?B?WDc0djh2YXpZdWVZMGFkNDRjajE2U2Fhc0JlK2VBc3drdWhLdlM4Qms0S0Rk?=
 =?utf-8?B?MG9RT2Nqa3dpcWJXamRrbUVleGs2SnFSTm1ldk9pRCsvUEFnOWpVY3FSTmdj?=
 =?utf-8?B?eFFVS3JZK2ZWT3Yyb1hjQWJCeVE4SEZXV1pDR3dOVjVGRVJNdE1UOFNoYTVn?=
 =?utf-8?B?anFvaVZFODZqUjBuUXRQVHpUbU5JWXBmMzJRWW5iTmFlaGxIOEdBK3AzVkpm?=
 =?utf-8?B?NlF5c3NqWHhzek9kTE9hU1ozVldqZ1pMUHhLeSs4UWlqU3E3UlFMTHMxdW5x?=
 =?utf-8?B?bHpqSXRzYko0ZloyR2VZenY4eXl6dkZ3SnJXN2Q4YTBrNzhPK1QvTWtCTDU4?=
 =?utf-8?B?M21XdDY0SCswaTF4WXhLYWREK054eGpSS0dIQkZoZ3o1UTd6aGJkekVBRS85?=
 =?utf-8?B?STNzM1o5U2ZnUlVNY1VKUGRpK09vamg0K1QvdE5lZTRtMWlxRm9iR2Z5dXdx?=
 =?utf-8?B?S0VyRis2dDRMLzlvMU9JR29OYUlid0ZsNW1jZHBubHVGbyt0MjRFZGJqWlR5?=
 =?utf-8?B?SXRNY3VyemJDSVVKWjdkaGpGNkVCYkdKN052eDJtWkhzNzZjcEVpZ3gwWnd0?=
 =?utf-8?B?anBVTmFuUFAwSk4wd1BwTTg3azA4Z01SeTBsVERNQXp2UVp0Qi9aRWoraVpj?=
 =?utf-8?B?eDNzbEluSzVnRldjc2Z2MENnY0lobytuMFBuR1Nxak9FVzUrdS9GdXR2Z2hL?=
 =?utf-8?B?cVd0WnUxMVplM3phbEgzVjRXWXRXZ2oyTVp3UnNKaVBKZ213NU9kSU52d24z?=
 =?utf-8?B?VThNQlNZR0hNQldQa3pydFlFQ0FYWE1DT3M2TEF1Q2RucDR2dEhMZzY1eXhU?=
 =?utf-8?B?Z2VmelErbHhZdWtjU29vb0JtcytpUFNJUXRYQThEUUtRMHBiMWU5UDBCaVIr?=
 =?utf-8?Q?pnLWkEjrqRFEMv8WwgKDPuQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3c01ab-a22b-46da-3df9-08da96ff6587
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:48:09.3503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YePRGymVWQYGlsdLeybLuwrpOxO8t0AmKamtBjwO5EHVKMAPrhZu9rfXFunzCeZZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6822
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
> Hello,
> 
> This is the first part in what will probably be very many parts in my work to
> cleanup ctree.h.  These are the smaller changes, mostly removing code that's not
> used anymore, moving some stuff that's local to C files that don't need to be in
> the header at all, and moving the rest of the on-disk definition stuff to
> btrfs_tree.h.  There's a lot of patche here, but they're all relatively small,
> the largest being the patch to move the on-disk definitions to btrfs_tree.h,
> which is not very large compared to patches in the next several series.  This
> has been built and tested, it's relatively low risk.  Thanks,

Looks good overall to me.

Just 3 small points of concern:

- About btrfs_tree.h usage.

   Really hope David can make it clear that, that UAPI header is for ALL
   on-disk format definition.

   I'm not buying the old reason that the UAPI header is only for tree
   search ioctl, and really want to move the whole super block definition
   into UAPI header.

   (And I also think all upstream fses should have a concentrated UAPI
    header too, just to make new comers easier to hack)

- Some tiny inline functions got unexported

   May not be a big thing though, just want to make sure we have no other
   choice but make them uninlined.

- Extra error tags in init_btrfs_fs()

   Just like open_ctree(), it's when but not whether to have wrong jump.
   Thus a new series to make those cachep related exit function
   conditional. (aka, we can call them unconditionally at error path)

Thanks,
Qu
> 
> Josef
> 
> Josef Bacik (17):
>    btrfs: remove set/clear_pending_info helpers
>    btrfs: remove BTRFS_TOTAL_BYTES_PINNED_BATCH
>    btrfs: remove BTRFS_IOPRIO_READA
>    btrfs: move btrfs on disk definitions out of ctree.h
>    btrfs: move btrfs_get_block_group helper out of disk-io.h
>    btrfs: move maximum limits to btrfs_tree.h
>    btrfs: move BTRFS_MAX_MIRRORS into scrub.c
>    btrfs: move discard stat defs to free-space-cache.h
>    btrfs: move btrfs_chunk_item_size out of ctree.h
>    btrfs: move btrfs_should_fragment_free_space into block-group.c
>    btrfs: move flush related definitions to space-info.h
>    btrfs: move btrfs_print_data_csum_error into inode.c
>    btrfs: move trans_handle_cachep out of ctree.h
>    btrfs: move btrfs_path_cachep out of ctree.h
>    btrfs: move free space cachep's out of ctree.h
>    btrfs: move btrfs_next_old_item into ctree.c
>    btrfs: move the btrfs_verity_descriptor_item defs up in ctree.h
> 
>   fs/btrfs/block-group.c          |  12 +
>   fs/btrfs/block-group.h          |  11 +-
>   fs/btrfs/btrfs_inode.h          |  26 ---
>   fs/btrfs/ctree.c                |  26 +++
>   fs/btrfs/ctree.h                | 388 ++------------------------------
>   fs/btrfs/delayed-inode.c        |   1 +
>   fs/btrfs/disk-io.c              |   7 +
>   fs/btrfs/disk-io.h              |   8 +-
>   fs/btrfs/free-space-cache.c     |  28 +++
>   fs/btrfs/free-space-cache.h     |  11 +
>   fs/btrfs/inode-item.c           |   1 +
>   fs/btrfs/inode.c                |  57 ++---
>   fs/btrfs/props.c                |   1 +
>   fs/btrfs/relocation.c           |   1 +
>   fs/btrfs/scrub.c                |  11 +
>   fs/btrfs/space-info.h           |  59 +++++
>   fs/btrfs/super.c                |  24 +-
>   fs/btrfs/transaction.c          |  17 ++
>   fs/btrfs/transaction.h          |   2 +
>   fs/btrfs/volumes.c              |   7 +
>   fs/btrfs/volumes.h              |   2 +-
>   include/uapi/linux/btrfs_tree.h | 226 +++++++++++++++++++
>   22 files changed, 476 insertions(+), 450 deletions(-)
> 
