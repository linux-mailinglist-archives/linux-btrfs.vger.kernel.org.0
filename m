Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC025F3CFB
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Oct 2022 09:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiJDHBv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Oct 2022 03:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJDHBs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Oct 2022 03:01:48 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E4238464
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Oct 2022 00:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hK0Ig1gNtuoU+L8R3je+kRLuOdNZkmE9HJrcCzRv1Xlq0CAQZ+CU+1mUo+hVEwd4+P1dy6w6CRl5Ai1Ianmc5jvGB+oaZJNLuf3OKobXm7nhGWR35zxcrLcTmRRg/cvHFPdu2HS3duLdmhyIKzx7UK125YLsDPBRioT4FtVFVpsRq66RN4J4OeOkTGBc4VQ81V6of6D/Hpmv9fLmWnk2W+lbRGCjXWqN4mXjsnGEyaK7EB2aW3hSI59H7k0sQBr7srbL/QceYy/TdIzEnihQYmmDlqn7FGeZVsOdvLWK8T8yrB4ES87bEkdYoV91BWkDR59WsvJZ+q3MhbAB8SBlqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxXW5M1rF1swuFSZkCVp/K3TfeGeL0BY6rCA4x7rUI0=;
 b=Ps9zYeR1RlIx55H8YYyQfaQR2RjN2WyrO2UsMaiCsljXnAQFQve2YyFkYX0sZiJCRRsm9ZZFQzz2J5/1TxpKpIKQY3dH+0VR5Uy8KpB+woAq/zhNCXAOVGO+Pi47k4bABZFUFGmpQgdT7Ba9SS0oZNaJuyyCPzqtuECqDUpoNri1SvGLx+mvc9SU1bCJHLne4gJWr3vQc4PyKm63MiLrobnIbOr+q1I2dycNdkPOu1pIsFRikwzU09Y6y3dCIPY/RMSI6GPMXUQxyWdyD1lzVyrClwEyw9SnRhLTLPTwOiCmos93yn1twGxc/zEjXSYTeO1rpSqYp1uLLddByEIhQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxXW5M1rF1swuFSZkCVp/K3TfeGeL0BY6rCA4x7rUI0=;
 b=HtBa+nbfu2WAb9CMOwmr4QNwByIgK5qmxPFO27MPEeqUAsZmxjSXpCCQyI+nMVGN813h+Kl2FoNaQxDuWO/JaOrZw9F0JAZQn8RU4CvMQ+oAR+zc+wJO1mu+9vtjAOy8PRvgt5ZTntK90TSwTiave1MjCzafJUjc+/0xyjm9vwrLWrSj4Am3R2mRIRPBY4w7qv8ySrDJusozlFw0Cz4Sy2nrVisv9zXHOqoBAyFx1D0LXmMIOnz/OBa2sToGSNVq7KzVYFp9Xsnx23YgViyS2XrOsXD4MI2DiDPRvUZS3UN0H6L99bgQ4LhwEBG3uyP1SQLUA2KWef3WFTSgkEs6Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB8PR04MB7017.eurprd04.prod.outlook.com (2603:10a6:10:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Tue, 4 Oct
 2022 07:01:38 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%7]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 07:01:38 +0000
Message-ID: <adabb9da-b330-c259-7afe-a21bea9888a6@suse.com>
Date:   Tue, 4 Oct 2022 15:01:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] btrfs-progs: fsfeatures: properly merge -O and -R
 options
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <2391326a30c1a9b9b77074b16bb195f8866b3db1.1664864278.git.wqu@suse.com>
In-Reply-To: <2391326a30c1a9b9b77074b16bb195f8866b3db1.1664864278.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::36) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DB8PR04MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: ff901c4a-3c74-4342-0bd2-08daa5d64836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OFEbiGiLX+wHllK2PVqpvGE7mYojoS/Ghuixj7E8EwiyvdtvaNAgjp/3xnK0anmbQHoALkRXZUUTXju9ejzXdAk1aR0MRZnSCOk57ezkqmnMuGrxctXeZLimB/1pR+fKkw2aGmsdxHwNMFIkKiwA5UD1SOFCUSEyQs2+ukjJ28uymQr46IZJIiy2YVr7WvutSdAx8zU+XMJh3mTwzUHhV2IQ/yHUMpXTGAEsc5mdJsaMzGZMrQNet712oxVtrqDKgvQgIIREx8sfAd2PHtSrUjjK8Fu7qTcG8Xt2HFYUCCCuUarLBr8u6oCqjX9hv9lEr4ESq3qLXwWGW8nm3+tyY2trTwSHD9DqDw3h3OIabFMOgWrf5Z9jp2BQWttRuka8KnFmjEtr8OsWTowVR8rpIGRdUdRtnJztb/Qkt1K5jKUd1wdbK9RryN2HYt28g7pUgw3anrVD13okIQS9ZUNLnHlHOsbTaw1LHOYJJHyrd8jvkuSXjgUafVBQ4PAPDswYbX5cm4XcWaxqi+0zjRs7Ro8oFrdvmMgpdO6DbKZsiXGSPf2Lq4wOhrYE6uKCz+/M9Hp2j5cK/feE4mM9w/Pkbkhm9CyulmAKcPgpLXThUke50ud6qDWHFygNEFogU/k1WZu4pnbxanIf6FfzsICx7OKZJRbRJg6hXrbM5nSslyJZe6fK6BM1QU9W8YS5TXaJikEsVjRKNDv6px7PCP7OfNomX4Tg4tFLX2f5y083ltvl6osqa501yFAYiFREQ7sdjmbGVyJT+OXOQYjw+pDHk260Cg025EN2IzQ9kRnLz9MezOplYd67LQldK3Tn+nS1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199015)(6486002)(31686004)(478600001)(6512007)(66556008)(66476007)(186003)(8676002)(66946007)(6666004)(8936002)(2906002)(6506007)(5660300002)(53546011)(6916009)(36756003)(316002)(2616005)(966005)(30864003)(86362001)(83380400001)(38100700002)(41300700001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUtGTDBSVyt2RzRSSXd2djJaQzl6Rm8yak51d1p4bUw5RTlPeUVKQTRlK1BM?=
 =?utf-8?B?THV1YWphRDNYQWE5Zm5PWjkrN0srd2txaVJwb013bXkvQ2QzcHhMY0EwK09r?=
 =?utf-8?B?SnFJRU9nS211ZStuTWJWSzZDSnFCcFBWR1ZRWGF3bzdQMlZVMkRtY1ZUV3hK?=
 =?utf-8?B?YTk4WnVDeEZMTGwyRGdrVWpEMG1IcXNEbFhRWHRXdTRXNEhaS1VMczhiZ3ow?=
 =?utf-8?B?TDJKYXZFTlM3RnhiWW4vT0g1VFJPMjZUTFN1eU4zNGxHKzViNFVBZTRXUnNm?=
 =?utf-8?B?WEc2eW0ySFQ1dU9vOXMvdTdKUmpoTUowYm1hSE5WeUIvanA4UHp5Z1pDamI1?=
 =?utf-8?B?T3gvNS9hYUwreDViNklnNkNlYm1VbUg3WENQM0VDcUt2Q3Z4dUFLWG04Z0Rv?=
 =?utf-8?B?SnAxdWJzR2hHOFpRWVltMHgxWXJvWElGM2E1MGFMQ0N5M2NEZWd6UVNPYjJy?=
 =?utf-8?B?Ti9jTDdQR3J3Uk5HcWxmUytXUzU0YklYV0xxV25hK0s1SWIwT2lGRWlhcUh4?=
 =?utf-8?B?QUlCa1FoNTRxN3RBeWJuQXhvZFRMTEtSNVpneVhrdWg0eE1rQnozQktHTnh3?=
 =?utf-8?B?cHd0LzBzOVliVzBTb21nWHdzanVHWjJJbTdBSStWeHBEYU4vTXJYa0x4ektt?=
 =?utf-8?B?aVVVUktyam5ONXN1emRqRHRXYkR1SFhzdkdmK1gwVXl6aCtPaENYOEVHaHJN?=
 =?utf-8?B?WHdEUW9IeGIrbmRtSnRRTGQ3ZkpBV2dpUGp2eW53Y044U2R4a1dFU3MxK1pI?=
 =?utf-8?B?WEM5cW51OUt3M2VYdmh1Zi82WTI3Zjkya1dmWnRYcWlpZGJyakVYaFZ2azdX?=
 =?utf-8?B?bktGMkRRdFVRa3R1ZEFPS1o4WUZMUEk2dzF5N0dmNEQ3OTNHejlmQ1hQR25y?=
 =?utf-8?B?dEVGcm1PNEsyQ3IxUGhMdllrck11WFVtbmw2a0Z2ckxTQStKVDhiK21TaVUy?=
 =?utf-8?B?WmVjT3A5QmZZS2xFc2dvVXFteko3YTloVGZtOTZTcFJuVkY5S3Z4RVpIWjRh?=
 =?utf-8?B?SjZ4Tk9NeXkzYmVYeHlyRkMwbHJkUndWZW9NUE8zQkF5SWgra1VCR0huUlQ2?=
 =?utf-8?B?SGt2dlpLK1MwUzZEZHVWWWx4T2I5cGkwWEI0VkVYYmc1WFlEWTJKZEVJSzUv?=
 =?utf-8?B?YWhFN0Q0MjYwRnZMUHZzWkVhdXhvY2luWnZSUzh6bjdXNEU1d1NER3J4azVS?=
 =?utf-8?B?aHd1K2FkeWE0WUVFWkhmQjlnYkNBTmhGWkd6aVlRKzM2ZFl6SzFNYzgwSVZN?=
 =?utf-8?B?NXFtaU10ZnRZOU9YdlRITkY3UW56OVNUcmVVMWNybzdlbVJ4emZtUGoyVzhG?=
 =?utf-8?B?WWk3OEhMVUhwS25HNmtXczJ1bmJBZlpDa3A0VXNUMHE0eFd3TEovL0NpVG4r?=
 =?utf-8?B?ajM0bmxGdHhSNjh2Z2U5YlZYRVZnc1h2UXMzb1l5NEoyZVFXOHVOOU83elEv?=
 =?utf-8?B?clFsazlPb3dVYjVrWHgxRGI3R241Z0huejdyOXNMN2ZmeFdqaG1ORlJBTGpH?=
 =?utf-8?B?RDJCKzZKRHNJYUgwRXpoTnJpeFhLcUtYc1k0Wks5NDVwZTVJdFZ3eEhGcDZX?=
 =?utf-8?B?VjRpNzhMbUh0eDIzdmJFRFJWWDZZWDlIc0taeThQR0dBM01ML0ZaWUhHZkEx?=
 =?utf-8?B?Mk9HamtDRG5iSVVYUTRKK1JLeTl0Y3VDU0hWZ29DUzc1a21vaTVCNDdnNmFr?=
 =?utf-8?B?aU1RUnE5UFNRb0hWc2RaMTErUFhlQUNUdTNCY2Rwelh5Si9DVW5zb0FhWHdX?=
 =?utf-8?B?a1A2RHFDY3FUNWhBYXpQQnBxdFVNc0wxSzRGRVFlQkY1NWJTb2lwWmZkQVRL?=
 =?utf-8?B?NDgrUkhuUGVQUFQzWkgrTzQ5anR6MTNzVUkvN2N3WkFDaGFnUGUyNUxWVExz?=
 =?utf-8?B?QVBZbGxtaTlSK05ISHF1YmltdGFVZVA5UGUzcXVCOHNtRVh3amtBMFpMRE9V?=
 =?utf-8?B?cmVDVVJDMkl3aFFXSjdST2xoTVB2S2xGY0xFK1doMnA0ZVB1Z0RrTlZDMEdm?=
 =?utf-8?B?SGM5bjNUenFGY3pUd3Q5WjcwcjNMWVFlN1R6eVZ4SkFmVjBwZ3FNcm5mZ1Vh?=
 =?utf-8?B?SmI2WkQ4MWp3MFYzb2hGWVRTTlBuNXdPT3NkZ2FoYWN2azhUMTFVdTZiaWFL?=
 =?utf-8?B?U2hGNGhEdjlJUFpUWHFkQ1dGU1QvTUIvMnM3YXU0cTZ5VkVEVy9IeDFHMGE5?=
 =?utf-8?Q?9rlgvKA1jDejjCSju/Zz7TM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff901c4a-3c74-4342-0bd2-08daa5d64836
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 07:01:38.2713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9Vuqs9c76/1MV1kdzIKbmj9LTenj2cpNzwfzP2+swpaCI5ZMtSzCMoGrR54Cpsq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7017
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/4 14:21, Qu Wenruo wrote:
> [BUG]
> Commit "btrfs-progs: prepare merging compat feature lists" tries to
> merged "-O" and "-R" options, as they don't correctly represents
> btrfs features.
> 
> But that commit caused the following bug during mkfs:
> 
>    $ mkfs.btrfs -f -O block-group-tree  /dev/nvme0n1
>    btrfs-progs v5.19.1
>    See http://btrfs.wiki.kernel.org for more information.
> 
>    ERROR: superblock magic doesn't match
>    ERROR: illegal nodesize 16384 (not equal to 4096 for mixed block group)
> 
> [CAUSE]
> Currently btrfs_parse_fs_features() will return a u64, and reuse the
> same u64 for both incompat and compat RO flags for experimental branch.
> 
> This can easily leads to conflicts, as
> BTRFS_FEATURE_INCOMPAT_MIXED_BLOCK_GROUP and
> BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE both share the same bit
> (1 << 2).
> 
> Thus for above case, mkfs.btrfs believe it has set MIXED_BLOCK_GROUP
> feature, but what we really want is BLOCK_GROUP_TREE.
> 
> [FIX]
> Instead of incorrectly re-using the same bits in btrfs_feature, split
> the old flags into 3 flags:
> 
> - incompat_flag
> - compat_ro_flag
> - generic_flag
> 
> The new @generic_flag will represent a unified fs feature, so we can
> return a single u64 to represent all features, no matter if it's a pure
> runtime one (like quota tree), or a incompat one (most features), or a
> compat RO one (like free space tree, block group tree).
> 
> This also means, any caller of btrfs_parse_fs_features() should use
> BTRFS_FEATURE_GENERIC_* flags to check if one feature is enabled, not
> the direct BTRFS_FEATURE_INCOMPAT_* nor BTRFS_FEATURE_COMPAT_RO_* flags.
> 
> Also we introduce two new helpers:
> 
> - btrfs_generic_features_to_incompat_flags()
> - btrfs_generic_features_to_compat_ro_flags()
> 
> So mkfs/convert can easily grab the needed flags.
> 
> Finally, since we now have a generic features, update mkfs to properly
> output the features.
> 
> If we have experimental features enabled, we just output a unified
> "Features:" line, while keep the old separate one for non-experimental
> build.
> As btrfs_parse_runtime_features() and btrfs_parse_fs_features() can all
> handle the output correctly, for both experimental and non-experimental
> builds.
> 
> Please note that, mkfs/009 will fail as there is a bug that --rootdir
> doesn't work correctly, and inserted a metadata backref for a regular
> data extent.
> 
> That bug is there at least from v5.18 release. That will be addressed
> seperately.

This one is indeed a separate problem.

The cause is that, we directly use the reported inode of the rootdir 
file as btrfs inode objectid.

Normally it's fine, but for my test environment, if I rebooted, /tmp 
will be almost empty, and new temporary rootdir will has an ino number 
lower than 256.

Such inode number smaller than 256 will be treated as owner for tree 
blocks, thus causing the problem.

I believe most of our testing environment has high enough inode numbers 
in their /tmp directory, thus not triggering the bug.

I'll address the long existing bug in another patch.

Thanks,
Qu

> 
> Please fold this patch into the offending one.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix convert test failure due to missing allowed features
> 
> v3:
> - Fix a bug that we can not unset free-space-tree for non-experimental
>    build
> 
> - Fix a bug that free-space-tree compat RO flags are not properly set
>    for non-experimental build
> ---
>   common/fsfeatures.c | 190 +++++++++++++++++++++++++++-----------------
>   common/fsfeatures.h |  59 ++++++++------
>   convert/common.c    |  10 ++-
>   convert/main.c      |  32 ++++----
>   mkfs/common.c       |  41 +++++-----
>   mkfs/common.h       |   9 ++-
>   mkfs/main.c         |  64 ++++++++-------
>   7 files changed, 236 insertions(+), 169 deletions(-)
> 
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 6dc7207e9800..5f8941d70fb6 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -51,22 +51,22 @@ enum feature_source {
>   	RUNTIME_FEATURES,
>   };
>   
> -enum feature_compat {
> -	/* Feature is backward compatible, read-write */
> -	FEATURE_COMPAT,
> -	/* Feature is backward compatible, read-only, filesystem can be mounted */
> -	FEATURE_COMPAT_RO,
> -	/* Feature is backward incompatible, filesystem cannot be mounted */
> -	FEATURE_INCOMPAT
> -};
> -
>   /*
>    * Feature stability status and versions: compat <= safe <= default
>    */
>   struct btrfs_feature {
>   	const char *name;
> -	u64 flag;
> -	enum feature_compat compat;
> +	/*
> +	 * Normally at least one of the flag should be set for
> +	 * incompat/compat_ro_flags.
> +	 * Although there are exceptions like QUOTA and LIST_ALL.
> +	 */
> +	u64 incompat_flag;
> +	u64 compat_ro_flag;
> +
> +	/* This is the real flag mkfs should check. */
> +	u64 generic_flag;
> +
>   	const char *sysfs_name;
>   	/*
>   	 * Compatibility with kernel of given version. Filesystem can be
> @@ -92,8 +92,8 @@ struct btrfs_feature {
>   static const struct btrfs_feature mkfs_features[] = {
>   	{
>   		.name		= "mixed-bg",
> -		.flag		= BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS,
> -		.compat		= FEATURE_INCOMPAT,
> +		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS,
> +		.generic_flag	= BTRFS_FEATURE_GENERIC_MIXED_GROUPS,
>   		.sysfs_name	= "mixed_groups",
>   		VERSION_TO_STRING3(compat, 2,6,37),
>   		VERSION_TO_STRING3(safe, 2,6,37),
> @@ -103,8 +103,7 @@ static const struct btrfs_feature mkfs_features[] = {
>   #if EXPERIMENTAL
>   	{
>   		.name		= "quota",
> -		.flag		= BTRFS_RUNTIME_FEATURE_QUOTA,
> -		.compat		= FEATURE_COMPAT_RO,
> +		.generic_flag	= BTRFS_FEATURE_GENERIC_QUOTA,
>   		.sysfs_name	= NULL,
>   		VERSION_TO_STRING2(compat, 3,4),
>   		VERSION_NULL(safe),
> @@ -114,8 +113,8 @@ static const struct btrfs_feature mkfs_features[] = {
>   #endif
>   	{
>   		.name		= "extref",
> -		.flag		= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF,
> -		.compat		= FEATURE_INCOMPAT,
> +		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF,
> +		.generic_flag	= BTRFS_FEATURE_GENERIC_EXTENDED_IREF,
>   		.sysfs_name	= "extended_iref",
>   		VERSION_TO_STRING2(compat, 3,7),
>   		VERSION_TO_STRING2(safe, 3,12),
> @@ -123,8 +122,8 @@ static const struct btrfs_feature mkfs_features[] = {
>   		.desc		= "increased hardlink limit per file to 65536"
>   	}, {
>   		.name		= "raid56",
> -		.flag		= BTRFS_FEATURE_INCOMPAT_RAID56,
> -		.compat		= FEATURE_INCOMPAT,
> +		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_RAID56,
> +		.generic_flag	= BTRFS_FEATURE_GENERIC_RAID56,
>   		.sysfs_name	= "raid56",
>   		VERSION_TO_STRING2(compat, 3,9),
>   		VERSION_NULL(safe),
> @@ -132,8 +131,8 @@ static const struct btrfs_feature mkfs_features[] = {
>   		.desc		= "raid56 extended format"
>   	}, {
>   		.name		= "skinny-metadata",
> -		.flag		= BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA,
> -		.compat		= FEATURE_INCOMPAT,
> +		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA,
> +		.generic_flag	= BTRFS_FEATURE_GENERIC_SKINNY_METADATA,
>   		.sysfs_name	= "skinny_metadata",
>   		VERSION_TO_STRING2(compat, 3,10),
>   		VERSION_TO_STRING2(safe, 3,18),
> @@ -141,8 +140,8 @@ static const struct btrfs_feature mkfs_features[] = {
>   		.desc		= "reduced-size metadata extent refs"
>   	}, {
>   		.name		= "no-holes",
> -		.flag		= BTRFS_FEATURE_INCOMPAT_NO_HOLES,
> -		.compat		= FEATURE_INCOMPAT,
> +		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_NO_HOLES,
> +		.generic_flag	= BTRFS_FEATURE_GENERIC_NO_HOLES,
>   		.sysfs_name	= "no_holes",
>   		VERSION_TO_STRING2(compat, 3,14),
>   		VERSION_TO_STRING2(safe, 4,0),
> @@ -152,8 +151,9 @@ static const struct btrfs_feature mkfs_features[] = {
>   #if EXPERIMENTAL
>   	{
>   		.name		= "free-space-tree",
> -		.flag		= BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE,
> -		.compat		= FEATURE_COMPAT_RO,
> +		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
> +				  BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID,
> +		.generic_flag	= BTRFS_FEATURE_GENERIC_FREE_SPACE_TREE,
>   		.sysfs_name = "free_space_tree",
>   		VERSION_TO_STRING2(compat, 4,5),
>   		VERSION_TO_STRING2(safe, 4,9),
> @@ -163,8 +163,8 @@ static const struct btrfs_feature mkfs_features[] = {
>   #endif
>   	{
>   		.name		= "raid1c34",
> -		.flag		= BTRFS_FEATURE_INCOMPAT_RAID1C34,
> -		.compat		= FEATURE_INCOMPAT,
> +		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_RAID1C34,
> +		.generic_flag	= BTRFS_FEATURE_GENERIC_RAID1C34,
>   		.sysfs_name	= "raid1c34",
>   		VERSION_TO_STRING2(compat, 5,5),
>   		VERSION_NULL(safe),
> @@ -174,8 +174,8 @@ static const struct btrfs_feature mkfs_features[] = {
>   #ifdef BTRFS_ZONED
>   	{
>   		.name		= "zoned",
> -		.flag		= BTRFS_FEATURE_INCOMPAT_ZONED,
> -		.compat		= FEATURE_INCOMPAT,
> +		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_ZONED,
> +		.generic_flag	= BTRFS_FEATURE_GENERIC_ZONED,
>   		.sysfs_name	= "zoned",
>   		VERSION_TO_STRING2(compat, 5,12),
>   		VERSION_NULL(safe),
> @@ -186,9 +186,9 @@ static const struct btrfs_feature mkfs_features[] = {
>   #if EXPERIMENTAL
>   	{
>   		.name		= "block-group-tree",
> -		.flag		= BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE,
> -		.compat		= FEATURE_COMPAT_RO,
> -		.sysfs_name = "block_group_tree",
> +		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
> +		.generic_flag	= BTRFS_FEATURE_GENERIC_BLOCK_GROUP_TREE,
> +		.sysfs_name	= "block_group_tree",
>   		VERSION_TO_STRING2(compat, 6,0),
>   		VERSION_NULL(safe),
>   		VERSION_NULL(default),
> @@ -198,8 +198,8 @@ static const struct btrfs_feature mkfs_features[] = {
>   #if EXPERIMENTAL
>   	{
>   		.name		= "extent-tree-v2",
> -		.flag		= BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2,
> -		.compat		= FEATURE_INCOMPAT,
> +		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2,
> +		.generic_flag	= BTRFS_FEATURE_GENERIC_EXTENT_TREE_V2,
>   		.sysfs_name	= "extent_tree_v2",
>   		VERSION_TO_STRING2(compat, 5,15),
>   		VERSION_NULL(safe),
> @@ -209,10 +209,9 @@ static const struct btrfs_feature mkfs_features[] = {
>   #endif
>   	/* Keep this one last */
>   	{
> -		.name = "list-all",
> -		.flag = BTRFS_FEATURE_LIST_ALL,
> -		.compat	= FEATURE_INCOMPAT,
> -		.sysfs_name = NULL,
> +		.name		= "list-all",
> +		.generic_flag	= BTRFS_FEATURE_GENERIC_LIST_ALL,
> +		.sysfs_name	= NULL,
>   		VERSION_NULL(compat),
>   		VERSION_NULL(safe),
>   		VERSION_NULL(default),
> @@ -223,15 +222,17 @@ static const struct btrfs_feature mkfs_features[] = {
>   static const struct btrfs_feature runtime_features[] = {
>   	{
>   		.name		= "quota",
> -		.flag		= BTRFS_RUNTIME_FEATURE_QUOTA,
>   		.sysfs_name	= NULL,
> +		.generic_flag	= BTRFS_FEATURE_GENERIC_QUOTA,
>   		VERSION_TO_STRING2(compat, 3,4),
>   		VERSION_NULL(safe),
>   		VERSION_NULL(default),
>   		.desc		= "quota support (qgroups)"
>   	}, {
>   		.name		= "free-space-tree",
> -		.flag		= BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE,
> +		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
> +				  BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID,
> +		.generic_flag	= BTRFS_FEATURE_GENERIC_FREE_SPACE_TREE,
>   		.sysfs_name = "free_space_tree",
>   		VERSION_TO_STRING2(compat, 4,5),
>   		VERSION_TO_STRING2(safe, 4,9),
> @@ -241,9 +242,10 @@ static const struct btrfs_feature runtime_features[] = {
>   #if EXPERIMENTAL
>   	{
>   		.name		= "block-group-tree",
> -		.flag		= BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE,
> -		.sysfs_name	= "block_group_tree",
> -		VERSION_TO_STRING2(compat, 6,1),
> +		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
> +		.generic_flag	= BTRFS_FEATURE_GENERIC_BLOCK_GROUP_TREE,
> +		.sysfs_name = "block_group_tree",
> +		VERSION_TO_STRING2(compat, 6,0),
>   		VERSION_NULL(safe),
>   		VERSION_NULL(default),
>   		.desc		= "block group tree to reduce mount time"
> @@ -251,10 +253,9 @@ static const struct btrfs_feature runtime_features[] = {
>   #endif
>   	/* Keep this one last */
>   	{
> -		.name = "list-all",
> -		.flag = BTRFS_FEATURE_LIST_ALL,
> -		.compat	= FEATURE_COMPAT_RO,
> -		.sysfs_name = NULL,
> +		.name		= "list-all",
> +		.generic_flag	= BTRFS_FEATURE_GENERIC_LIST_ALL,
> +		.sysfs_name	= NULL,
>   		VERSION_NULL(compat),
>   		VERSION_NULL(safe),
>   		VERSION_NULL(default),
> @@ -280,7 +281,7 @@ static const struct btrfs_feature *get_feature(int i, enum feature_source source
>   	return NULL;
>   }
>   
> -static int parse_one_fs_feature(const char *name, u64 *flags,
> +static int parse_one_fs_feature(const char *name, u64 *generic_flags,
>   				enum feature_source source)
>   {
>   	const int array_size = get_feature_array_size(source);
> @@ -291,10 +292,10 @@ static int parse_one_fs_feature(const char *name, u64 *flags,
>   		const struct btrfs_feature *feat = get_feature(i, source);
>   
>   		if (name[0] == '^' && !strcmp(feat->name, name + 1)) {
> -			*flags &= ~feat->flag;
> +			*generic_flags &= ~feat->generic_flag;
>   			found = 1;
>   		} else if (!strcmp(feat->name, name)) {
> -			*flags |= feat->flag;
> +			*generic_flags |= feat->generic_flag;
>   			found = 1;
>   		}
>   	}
> @@ -302,7 +303,7 @@ static int parse_one_fs_feature(const char *name, u64 *flags,
>   	return !found;
>   }
>   
> -static void parse_features_to_string(char *buf, u64 flags,
> +static void parse_features_to_string(char *buf, u64 generic_flags,
>   				     enum feature_source source)
>   {
>   	const int array_size = get_feature_array_size(source);
> @@ -313,7 +314,7 @@ static void parse_features_to_string(char *buf, u64 flags,
>   	for (i = 0; i < array_size; i++) {
>   		const struct btrfs_feature *feat = get_feature(i, source);
>   
> -		if (flags & feat->flag) {
> +		if (generic_flags & feat->generic_flag) {
>   			if (*buf)
>   				strcat(buf, ", ");
>   			strcat(buf, feat->name);
> @@ -321,17 +322,17 @@ static void parse_features_to_string(char *buf, u64 flags,
>   	}
>   }
>   
> -void btrfs_parse_fs_features_to_string(char *buf, u64 flags)
> +void btrfs_parse_fs_features_to_string(char *buf, u64 generic_flags)
>   {
> -	parse_features_to_string(buf, flags, FS_FEATURES);
> +	parse_features_to_string(buf, generic_flags, FS_FEATURES);
>   }
>   
> -void btrfs_parse_runtime_features_to_string(char *buf, u64 flags)
> +void btrfs_parse_runtime_features_to_string(char *buf, u64 generic_flags)
>   {
> -	parse_features_to_string(buf, flags, RUNTIME_FEATURES);
> +	parse_features_to_string(buf, generic_flags, RUNTIME_FEATURES);
>   }
>   
> -static void process_features(u64 flags, enum feature_source source)
> +static void process_features(u64 generic_flags, enum feature_source source)
>   {
>   	const int array_size = get_feature_array_size(source);
>   	int i;
> @@ -339,43 +340,45 @@ static void process_features(u64 flags, enum feature_source source)
>   	for (i = 0; i < array_size; i++) {
>   		const struct btrfs_feature *feat = get_feature(i, source);
>   
> -		if (flags & feat->flag && feat->name && feat->desc) {
> -			printf("Turning ON incompat feature '%s': %s\n",
> -				feat->name, feat->desc);
> +		if (generic_flags & feat->generic_flag && feat->name && feat->desc) {
> +			char *type_str;
> +
> +			if (feat->compat_ro_flag)
> +				type_str = "compat ro";
> +			else if (feat->incompat_flag)
> +				type_str = "incompat";
> +			else
> +				type_str = "runtime";
> +
> +			printf("Turning ON %s feature '%s': %s\n",
> +				type_str, feat->name, feat->desc);
>   		}
>   	}
>   }
>   
> -void btrfs_process_fs_features(u64 flags)
> +void btrfs_process_fs_features(u64 generic_flags)
>   {
> -	process_features(flags, FS_FEATURES);
> +	process_features(generic_flags, FS_FEATURES);
>   }
>   
> -void btrfs_process_runtime_features(u64 flags)
> +void btrfs_process_runtime_features(u64 generic_flags)
>   {
> -	process_features(flags, RUNTIME_FEATURES);
> +	process_features(generic_flags, RUNTIME_FEATURES);
>   }
>   
>   static void list_all_features(u64 mask_disallowed, enum feature_source source)
>   {
>   	const int array_size = get_feature_array_size(source);
>   	int i;
> -	char *prefix;
>   
> -	if (source == FS_FEATURES)
> -		prefix = "Filesystem";
> -	else if (source == RUNTIME_FEATURES)
> -		prefix = "Runtime";
> -	else
> -		prefix = "UNKNOWN";
> -
> -	fprintf(stderr, "%s features available:\n", prefix);
> +	fprintf(stderr, "features available:\n");
>   	for (i = 0; i < array_size - 1; i++) {
>   		const struct btrfs_feature *feat = get_feature(i, source);
>   		const char *sep = "";
>   
> -		if (feat->flag & mask_disallowed)
> +		if (feat->generic_flag & mask_disallowed)
>   			continue;
> +
>   		fprintf(stderr, "%-20s- %s (", feat->name, feat->desc);
>   		if (feat->compat_ver) {
>   			fprintf(stderr, "compat=%s", feat->compat_str);
> @@ -556,7 +559,7 @@ int btrfs_check_nodesize(u32 nodesize, u32 sectorsize, u64 features)
>   		error("illegal nodesize %u (not aligned to %u)",
>   			nodesize, sectorsize);
>   		return -1;
> -	} else if (features & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS &&
> +	} else if (features & BTRFS_FEATURE_GENERIC_MIXED_GROUPS &&
>   		   nodesize != sectorsize) {
>   		error(
>   		"illegal nodesize %u (not equal to %u for mixed block group)",
> @@ -603,3 +606,40 @@ int btrfs_tree_search2_ioctl_supported(int fd)
>   	return ret;
>   }
>   
> +u64 btrfs_generic_features_to_incompat_flags(u64 generic_features)
> +{
> +	u64 ret = 0;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(mkfs_features); i++) {
> +		const struct btrfs_feature *feature = &mkfs_features[i];
> +
> +		if (generic_features & feature->generic_flag)
> +			ret |= feature->incompat_flag;
> +	}
> +	return ret;
> +}
> +
> +u64 btrfs_generic_features_to_compat_ro_flags(u64 generic_features)
> +{
> +	u64 ret = 0;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(mkfs_features); i++) {
> +		const struct btrfs_feature *feature = &mkfs_features[i];
> +
> +		if (generic_features & feature->generic_flag)
> +			ret |= feature->compat_ro_flag;
> +	}
> +	/*
> +	 * For non-experimental build, compat RO flags are only in runtime
> +	 * features array.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(runtime_features); i++) {
> +		const struct btrfs_feature *feature = &runtime_features[i];
> +
> +		if (generic_features & feature->generic_flag)
> +			ret |= feature->compat_ro_flag;
> +	}
> +	return ret;
> +}
> diff --git a/common/fsfeatures.h b/common/fsfeatures.h
> index fd7defc14031..44cad72c8285 100644
> --- a/common/fsfeatures.h
> +++ b/common/fsfeatures.h
> @@ -21,34 +21,42 @@
>   #include <stdio.h>
>   #include "kernel-lib/sizes.h"
>   
> -#define BTRFS_MKFS_DEFAULT_NODE_SIZE SZ_16K
> -#define BTRFS_MKFS_DEFAULT_FEATURES 				\
> -		(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF		\
> -		| BTRFS_FEATURE_INCOMPAT_NO_HOLES		\
> -		| BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
> -
> -#define BTRFS_MKFS_DEFAULT_RUNTIME_FEATURES			\
> -	(BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE)
> -
>   /*
> - * Avoid multi-device features (RAID56), mixed block groups, and zoned mode
> + * Since our fsfeatures can contain both incompat and compat_ro flags,
> + * there has to be a generic feature flags.
>    */
> -#define BTRFS_CONVERT_ALLOWED_FEATURES				\
> -	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF			\
> -	| BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL			\
> -	| BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO			\
> -	| BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD			\
> -	| BTRFS_FEATURE_INCOMPAT_BIG_METADATA			\
> -	| BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF			\
> -	| BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA		\
> -	| BTRFS_FEATURE_INCOMPAT_NO_HOLES)
> +#define BTRFS_FEATURE_GENERIC_MIXED_GROUPS	(1 << 0)
> +#define BTRFS_FEATURE_GENERIC_QUOTA		(1 << 1)
> +#define BTRFS_FEATURE_GENERIC_EXTENDED_IREF	(1 << 2)
> +#define BTRFS_FEATURE_GENERIC_RAID56		(1 << 3)
> +#define BTRFS_FEATURE_GENERIC_SKINNY_METADATA	(1 << 4)
> +#define BTRFS_FEATURE_GENERIC_NO_HOLES		(1 << 5)
> +#define BTRFS_FEATURE_GENERIC_FREE_SPACE_TREE	(1 << 6)
> +#define BTRFS_FEATURE_GENERIC_RAID1C34		(1 << 7)
> +#define BTRFS_FEATURE_GENERIC_ZONED		(1 << 8)
> +#define BTRFS_FEATURE_GENERIC_BLOCK_GROUP_TREE	(1 << 9)
> +#define BTRFS_FEATURE_GENERIC_EXTENT_TREE_V2	(1 << 10)
> +/* This should be the last one. */
> +#define BTRFS_FEATURE_GENERIC_LIST_ALL		(1 << 15)
>   
> -#define BTRFS_FEATURE_LIST_ALL		(1ULL << 63)
> +#define BTRFS_MKFS_DEFAULT_NODE_SIZE SZ_16K
> +#define BTRFS_MKFS_DEFAULT_GENERIC_FEATURES 		\
> +	(BTRFS_FEATURE_GENERIC_EXTENDED_IREF |		\
> +	 BTRFS_FEATURE_GENERIC_NO_HOLES |		\
> +	 BTRFS_FEATURE_GENERIC_SKINNY_METADATA |	\
> +	 BTRFS_FEATURE_GENERIC_FREE_SPACE_TREE)
>   
> -#define BTRFS_RUNTIME_FEATURE_QUOTA		(1ULL << 0)
> -#define BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE	(1ULL << 1)
> -#define BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE	(1ULL << 2)
> +#define BTRFS_MKFS_DEFAULT_RUNTIME_GENERIC_FEATURES	\
> +	(BTRFS_FEATURE_GENERIC_FREE_SPACE_TREE)
>   
> +/* Avoid multi-device features, mixed block groups, and zoned mode */
> +#define BTRFS_CONVERT_ALLOWED_GENERIC_FEATURES		\
> +       (BTRFS_FEATURE_GENERIC_QUOTA |			\
> +        BTRFS_FEATURE_GENERIC_EXTENDED_IREF |		\
> +        BTRFS_FEATURE_GENERIC_SKINNY_METADATA |		\
> +        BTRFS_FEATURE_GENERIC_NO_HOLES |		\
> +        BTRFS_FEATURE_GENERIC_FREE_SPACE_TREE |		\
> +        BTRFS_FEATURE_GENERIC_BLOCK_GROUP_TREE)
>   
>   void btrfs_list_all_fs_features(u64 mask_disallowed);
>   void btrfs_list_all_runtime_features(u64 mask_disallowed);
> @@ -60,8 +68,11 @@ void btrfs_parse_fs_features_to_string(char *buf, u64 flags);
>   void btrfs_parse_runtime_features_to_string(char *buf, u64 flags);
>   void print_kernel_version(FILE *stream, u32 version);
>   u32 get_running_kernel_version(void);
> -int btrfs_check_nodesize(u32 nodesize, u32 sectorsize, u64 features);
> +int btrfs_check_nodesize(u32 nodesize, u32 sectorsize, u64 generic_features);
>   int btrfs_check_sectorsize(u32 sectorsize);
>   int btrfs_tree_search2_ioctl_supported(int fd);
>   
> +u64 btrfs_generic_features_to_incompat_flags(u64 generic_features);
> +u64 btrfs_generic_features_to_compat_ro_flags(u64 generic_features);
> +
>   #endif
> diff --git a/convert/common.c b/convert/common.c
> index 6d5720083192..6589df6914ed 100644
> --- a/convert/common.c
> +++ b/convert/common.c
> @@ -27,6 +27,7 @@
>   #include "kernel-shared/volumes.h"
>   #include "common/path-utils.h"
>   #include "common/messages.h"
> +#include "common/fsfeatures.h"
>   #include "mkfs/common.h"
>   #include "convert/common.h"
>   #include "ioctl.h"
> @@ -143,7 +144,10 @@ static int setup_temp_super(int fd, struct btrfs_mkfs_config *cfg,
>   	btrfs_set_super_csum_type(&super, cfg->csum_type);
>   	btrfs_set_super_chunk_root(&super, chunk_bytenr);
>   	btrfs_set_super_cache_generation(&super, -1);
> -	btrfs_set_super_incompat_flags(&super, cfg->features);
> +	btrfs_set_super_incompat_flags(&super,
> +			BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL |
> +			btrfs_generic_features_to_incompat_flags(
> +				cfg->generic_features));
>   	if (cfg->label)
>   		__strncpy_null(super.label, cfg->label, BTRFS_LABEL_SIZE - 1);
>   
> @@ -582,8 +586,8 @@ static int insert_temp_extent_item(int fd, struct extent_buffer *buf,
>   	struct btrfs_disk_key tree_info_key;
>   	struct btrfs_tree_block_info *info;
>   	int itemsize;
> -	int skinny_metadata = cfg->features &
> -			      BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA;
> +	int skinny_metadata = cfg->generic_features &
> +			      BTRFS_FEATURE_GENERIC_SKINNY_METADATA;
>   	int ret;
>   
>   	if (skinny_metadata)
> diff --git a/convert/main.c b/convert/main.c
> index 471580721e80..f3ab33fecb85 100644
> --- a/convert/main.c
> +++ b/convert/main.c
> @@ -1129,8 +1129,8 @@ static int convert_open_fs(const char *devname,
>   }
>   
>   static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
> -		const char *fslabel, int progress, u64 features, u16 csum_type,
> -		char fsid[BTRFS_UUID_UNPARSED_SIZE])
> +		const char *fslabel, int progress, u64 generic_features,
> +		u16 csum_type, char fsid[BTRFS_UUID_UNPARSED_SIZE])
>   {
>   	int ret;
>   	int fd = -1;
> @@ -1170,15 +1170,15 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
>   "blocksize %u is not equal to the page size %u, converted filesystem won't mount on this system",
>   			blocksize, getpagesize());
>   
> -	if (btrfs_check_nodesize(nodesize, blocksize, features))
> +	if (btrfs_check_nodesize(nodesize, blocksize, generic_features))
>   		goto fail;
>   	fd = open(devname, O_RDWR);
>   	if (fd < 0) {
>   		error("unable to open %s: %m", devname);
>   		goto fail;
>   	}
> -	btrfs_parse_fs_features_to_string(features_buf, features);
> -	if (features == BTRFS_MKFS_DEFAULT_FEATURES)
> +	btrfs_parse_fs_features_to_string(features_buf, generic_features);
> +	if (generic_features == BTRFS_MKFS_DEFAULT_GENERIC_FEATURES)
>   		strcat(features_buf, " (default)");
>   
>   	if (convert_flags & CONVERT_FLAG_COPY_FSID) {
> @@ -1226,7 +1226,7 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
>   	mkfs_cfg.nodesize = nodesize;
>   	mkfs_cfg.sectorsize = blocksize;
>   	mkfs_cfg.stripesize = blocksize;
> -	mkfs_cfg.features = features;
> +	mkfs_cfg.generic_features = generic_features;
>   	mkfs_cfg.leaf_data_size = __BTRFS_LEAF_DATA_SIZE(nodesize);
>   
>   	printf("Create initial btrfs filesystem\n");
> @@ -1822,7 +1822,7 @@ int BOX_MAIN(convert)(int argc, char *argv[])
>   	int progress = 1;
>   	char *file;
>   	char fslabel[BTRFS_LABEL_SIZE] = { 0 };
> -	u64 features = BTRFS_MKFS_DEFAULT_FEATURES;
> +	u64 generic_features = BTRFS_MKFS_DEFAULT_GENERIC_FEATURES;
>   	u16 csum_type = BTRFS_CSUM_TYPE_CRC32;
>   	u32 copy_fsid = 0;
>   	char fsid[BTRFS_UUID_UNPARSED_SIZE] = {0};
> @@ -1892,7 +1892,8 @@ int BOX_MAIN(convert)(int argc, char *argv[])
>   				char *orig = strdup(optarg);
>   				char *tmp = orig;
>   
> -				tmp = btrfs_parse_fs_features(tmp, &features);
> +				tmp = btrfs_parse_fs_features(tmp,
> +						&generic_features);
>   				if (tmp) {
>   					error("unrecognized filesystem feature: %s",
>   							tmp);
> @@ -1900,16 +1901,19 @@ int BOX_MAIN(convert)(int argc, char *argv[])
>   					exit(1);
>   				}
>   				free(orig);
> -				if (features & BTRFS_FEATURE_LIST_ALL) {
> +				if (generic_features &
> +						BTRFS_FEATURE_GENERIC_LIST_ALL) {
>   					btrfs_list_all_fs_features(
> -						~BTRFS_CONVERT_ALLOWED_FEATURES);
> +						~BTRFS_CONVERT_ALLOWED_GENERIC_FEATURES);
>   					exit(0);
>   				}
> -				if (features & ~BTRFS_CONVERT_ALLOWED_FEATURES) {
> +				if (generic_features &
> +				    ~BTRFS_CONVERT_ALLOWED_GENERIC_FEATURES) {
>   					char buf[64];
>   
>   					btrfs_parse_fs_features_to_string(buf,
> -						features & ~BTRFS_CONVERT_ALLOWED_FEATURES);
> +						generic_features &
> +						~BTRFS_CONVERT_ALLOWED_GENERIC_FEATURES);
>   					error("features not allowed for convert: %s",
>   						buf);
>   					exit(1);
> @@ -1984,8 +1988,8 @@ int BOX_MAIN(convert)(int argc, char *argv[])
>   		cf |= noxattr ? 0 : CONVERT_FLAG_XATTR;
>   		cf |= copy_fsid;
>   		cf |= copylabel;
> -		ret = do_convert(file, cf, nodesize, fslabel, progress, features,
> -				 csum_type, fsid);
> +		ret = do_convert(file, cf, nodesize, fslabel, progress,
> +				 generic_features, csum_type, fsid);
>   	}
>   	if (ret)
>   		return 1;
> diff --git a/mkfs/common.c b/mkfs/common.c
> index 1e8bf4d599e3..047c67d85cdf 100644
> --- a/mkfs/common.c
> +++ b/mkfs/common.c
> @@ -84,8 +84,8 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
>   	int blk;
>   	int i;
>   	u8 uuid[BTRFS_UUID_SIZE];
> -	bool block_group_tree = !!(cfg->runtime_features &
> -				   BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE);
> +	bool block_group_tree = !!(cfg->generic_features &
> +				   BTRFS_FEATURE_GENERIC_BLOCK_GROUP_TREE);
>   
>   	memset(buf->data + sizeof(struct btrfs_header), 0,
>   		cfg->nodesize - sizeof(struct btrfs_header));
> @@ -372,19 +372,18 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>   	u32 array_size;
>   	u32 item_size;
>   	u64 total_used = 0;
> -	u64 ro_flags = 0;
> -	int skinny_metadata = !!(cfg->features &
> -				 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA);
> +	int skinny_metadata = !!(cfg->generic_features &
> +				 BTRFS_FEATURE_GENERIC_SKINNY_METADATA);
>   	u64 num_bytes;
>   	u64 system_group_offset = BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
>   	u64 system_group_size = BTRFS_MKFS_SYSTEM_GROUP_SIZE;
>   	bool add_block_group = true;
> -	bool free_space_tree = !!(cfg->runtime_features &
> -				  BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE);
> -	bool block_group_tree = !!(cfg->runtime_features &
> -				   BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE);
> -	bool extent_tree_v2 = !!(cfg->features &
> -				 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2);
> +	bool free_space_tree = !!(cfg->generic_features &
> +				  BTRFS_FEATURE_GENERIC_FREE_SPACE_TREE);
> +	bool block_group_tree = !!(cfg->generic_features &
> +				   BTRFS_FEATURE_GENERIC_BLOCK_GROUP_TREE);
> +	bool extent_tree_v2 = !!(cfg->generic_features &
> +				 BTRFS_FEATURE_GENERIC_EXTENT_TREE_V2);
>   
>   	memcpy(blocks, default_blocks,
>   	       sizeof(enum btrfs_mkfs_block) * ARRAY_SIZE(default_blocks));
> @@ -405,7 +404,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>   	if (!free_space_tree)
>   		mkfs_blocks_remove(blocks, &blocks_nr, MKFS_FREE_SPACE_TREE);
>   
> -	if ((cfg->features & BTRFS_FEATURE_INCOMPAT_ZONED)) {
> +	if ((cfg->generic_features & BTRFS_FEATURE_GENERIC_ZONED)) {
>   		system_group_offset = zoned_system_group_offset(cfg->zone_size);
>   		system_group_size = cfg->zone_size;
>   	}
> @@ -449,20 +448,18 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>   	btrfs_set_super_stripesize(&super, cfg->stripesize);
>   	btrfs_set_super_csum_type(&super, cfg->csum_type);
>   	btrfs_set_super_chunk_root_generation(&super, 1);
> -	if (cfg->features & BTRFS_FEATURE_INCOMPAT_ZONED)
> +	if (cfg->generic_features & BTRFS_FEATURE_GENERIC_ZONED)
>   		btrfs_set_super_cache_generation(&super, 0);
>   	else
>   		btrfs_set_super_cache_generation(&super, -1);
> -	btrfs_set_super_incompat_flags(&super, cfg->features);
> -	if (free_space_tree) {
> -		ro_flags |= (BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
> -			     BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID);
> -
> +	btrfs_set_super_incompat_flags(&super,
> +			btrfs_generic_features_to_incompat_flags(
> +				cfg->generic_features));
> +	if (free_space_tree)
>   		btrfs_set_super_cache_generation(&super, 0);
> -	}
> -	if (block_group_tree)
> -		ro_flags |= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE;
> -	btrfs_set_super_compat_ro_flags(&super, ro_flags);
> +	btrfs_set_super_compat_ro_flags(&super,
> +			btrfs_generic_features_to_compat_ro_flags(
> +				cfg->generic_features));
>   
>   	if (extent_tree_v2)
>   		btrfs_set_super_nr_global_roots(&super, 1);
> diff --git a/mkfs/common.h b/mkfs/common.h
> index fbacc25e0012..0a020e7775a7 100644
> --- a/mkfs/common.h
> +++ b/mkfs/common.h
> @@ -78,10 +78,11 @@ struct btrfs_mkfs_config {
>   	u32 sectorsize;
>   	u32 stripesize;
>   	u32 leaf_data_size;
> -	/* Bitfield of incompat features, BTRFS_FEATURE_INCOMPAT_* */
> -	u64 features;
> -	/* Bitfield of BTRFS_RUNTIME_FEATURE_* */
> -	u64 runtime_features;
> +	/*
> +	 * Bitfield of generic features, BTRFS_FEATURE_GENERIC_*.
> +	 * This covers all incompat and compat_ro flags.
> +	 */
> +	u64 generic_features;
>   	/* Size of the filesystem in bytes */
>   	u64 num_bytes;
>   	/* checksum algorithm to use */
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 228c4431fd9e..01218a8ce438 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -998,8 +998,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	u64 system_group_size;
>   	/* Options */
>   	bool force_overwrite = false;
> -	u64 runtime_features = BTRFS_MKFS_DEFAULT_RUNTIME_FEATURES;
> -	u64 features = BTRFS_MKFS_DEFAULT_FEATURES;
> +	u64 generic_features = BTRFS_MKFS_DEFAULT_GENERIC_FEATURES;
>   	enum btrfs_csum_type csum_type = BTRFS_CSUM_TYPE_CRC32;
>   	char fs_uuid[BTRFS_UUID_UNPARSED_SIZE] = { 0 };
>   	u32 nodesize = 0;
> @@ -1108,7 +1107,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   				char *orig = strdup(optarg);
>   				char *tmp = orig;
>   
> -				tmp = btrfs_parse_fs_features(tmp, &features);
> +				tmp = btrfs_parse_fs_features(tmp,
> +						&generic_features);
>   				if (tmp) {
>   					error("unrecognized filesystem feature '%s'",
>   							tmp);
> @@ -1116,7 +1116,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   					goto error;
>   				}
>   				free(orig);
> -				if (features & BTRFS_FEATURE_LIST_ALL) {
> +				if (generic_features &
> +						BTRFS_FEATURE_GENERIC_LIST_ALL) {
>   					btrfs_list_all_fs_features(0);
>   					goto success;
>   				}
> @@ -1127,7 +1128,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   				char *tmp = orig;
>   
>   				tmp = btrfs_parse_runtime_features(tmp,
> -						&runtime_features);
> +						&generic_features);
>   				if (tmp) {
>   					error("unrecognized runtime feature '%s'",
>   					      tmp);
> @@ -1135,7 +1136,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   					goto error;
>   				}
>   				free(orig);
> -				if (runtime_features & BTRFS_FEATURE_LIST_ALL) {
> +				if (generic_features&
> +				    BTRFS_FEATURE_GENERIC_LIST_ALL) {
>   					btrfs_list_all_runtime_features(0);
>   					goto success;
>   				}
> @@ -1204,7 +1206,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	if (device_count == 0)
>   		print_usage(1);
>   
> -	opt_zoned = !!(features & BTRFS_FEATURE_INCOMPAT_ZONED);
> +	opt_zoned = !!(generic_features & BTRFS_FEATURE_GENERIC_ZONED);
>   
>   	if (source_dir_set && device_count > 1) {
>   		error("the option -r is limited to a single device");
> @@ -1257,7 +1259,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	"Zoned: %s: host-managed device detected, setting zoned feature\n",
>   			       file);
>   		opt_zoned = true;
> -		features |= BTRFS_FEATURE_INCOMPAT_ZONED;
> +		generic_features |= BTRFS_FEATURE_GENERIC_ZONED;
>   	}
>   
>   	/*
> @@ -1295,27 +1297,28 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	}
>   
>   	/*
> -	 * FS features that can be set by other means than -O
> +	 * Generic features that can be set by other means than -O
>   	 * just set the bit here
>   	 */
>   	if (mixed)
> -		features |= BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS;
> +		generic_features |= BTRFS_FEATURE_GENERIC_MIXED_GROUPS;
>   
>   	if ((data_profile | metadata_profile) & BTRFS_BLOCK_GROUP_RAID56_MASK) {
> -		features |= BTRFS_FEATURE_INCOMPAT_RAID56;
> +		generic_features |= BTRFS_FEATURE_GENERIC_RAID56;
>   		warning("RAID5/6 support has known problems is strongly discouraged\n"
>   			"\t to be used besides testing or evaluation.\n");
>   	}
>   
>   	if ((data_profile | metadata_profile) &
>   	    (BTRFS_BLOCK_GROUP_RAID1C3 | BTRFS_BLOCK_GROUP_RAID1C4)) {
> -		features |= BTRFS_FEATURE_INCOMPAT_RAID1C34;
> +		generic_features |= BTRFS_FEATURE_GENERIC_RAID1C34;
>   	}
>   
>   	/* Extent tree v2 comes with a set of mandatory features. */
> -	if (features & BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2) {
> -		features |= BTRFS_FEATURE_INCOMPAT_NO_HOLES;
> -		runtime_features |= BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE;
> +	if (generic_features & BTRFS_FEATURE_GENERIC_EXTENT_TREE_V2) {
> +		generic_features |= BTRFS_FEATURE_GENERIC_NO_HOLES;
> +		generic_features |= BTRFS_FEATURE_GENERIC_FREE_SPACE_TREE;
> +		generic_features |= BTRFS_FEATURE_GENERIC_BLOCK_GROUP_TREE;
>   
>   		if (!nr_global_roots) {
>   			error("you must set a non-zero num-global-roots value");
> @@ -1324,9 +1327,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	}
>   
>   	/* Block group tree feature requires no-holes and free-space-tree. */
> -	if (runtime_features & BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE &&
> -	    (!(features & BTRFS_FEATURE_INCOMPAT_NO_HOLES) ||
> -	     !(runtime_features & BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE))) {
> +	if (generic_features & BTRFS_FEATURE_GENERIC_BLOCK_GROUP_TREE &&
> +	    (!(generic_features & BTRFS_FEATURE_GENERIC_NO_HOLES) ||
> +	     !(generic_features & BTRFS_FEATURE_GENERIC_FREE_SPACE_TREE))) {
>   		error("block group tree requires no-holes and free-space-tree features");
>   		exit(1);
>   	}
> @@ -1336,19 +1339,19 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   			exit(1);
>   		}
>   
> -		if (features & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS) {
> +		if (generic_features & BTRFS_FEATURE_GENERIC_MIXED_GROUPS) {
>   			error("cannot enable mixed-bg in zoned mode");
>   			exit(1);
>   		}
>   
> -		if (features & BTRFS_FEATURE_INCOMPAT_RAID56) {
> +		if (generic_features & BTRFS_FEATURE_GENERIC_RAID56) {
>   			error("cannot enable RAID5/6 in zoned mode");
>   			exit(1);
>   		}
>   	}
>   
>   	if (btrfs_check_nodesize(nodesize, sectorsize,
> -				 features))
> +				 generic_features))
>   		goto error;
>   
>   	if (sectorsize < sizeof(struct btrfs_super_block)) {
> @@ -1537,8 +1540,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	mkfs_cfg.nodesize = nodesize;
>   	mkfs_cfg.sectorsize = sectorsize;
>   	mkfs_cfg.stripesize = stripesize;
> -	mkfs_cfg.features = features;
> -	mkfs_cfg.runtime_features = runtime_features;
> +	mkfs_cfg.generic_features = generic_features;
>   	mkfs_cfg.csum_type = csum_type;
>   	mkfs_cfg.leaf_data_size = __BTRFS_LEAF_DATA_SIZE(nodesize);
>   	if (opt_zoned)
> @@ -1583,7 +1585,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   		goto error;
>   	}
>   
> -	if (features & BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2) {
> +	if (generic_features & BTRFS_FEATURE_GENERIC_EXTENT_TREE_V2) {
>   		ret = create_global_roots(trans, nr_global_roots);
>   		if (ret) {
>   			error("failed to create global roots: %d", ret);
> @@ -1733,7 +1735,7 @@ raid_groups:
>   		}
>   	}
>   
> -	if (runtime_features & BTRFS_RUNTIME_FEATURE_QUOTA) {
> +	if (generic_features & BTRFS_FEATURE_GENERIC_QUOTA) {
>   		ret = setup_quota_root(fs_info);
>   		if (ret < 0) {
>   			error("failed to initialize quota: %d (%m)", ret);
> @@ -1771,11 +1773,19 @@ raid_groups:
>   		if (opt_zoned)
>   			printf("  Zone size:        %s\n",
>   			       pretty_size(fs_info->zone_size));
> -		btrfs_parse_fs_features_to_string(features_buf, features);
> +		btrfs_parse_fs_features_to_string(features_buf,
> +						  generic_features);
> +
> +#if EXPERIMENTAL
> +		printf("Features:           %s\n", features_buf);
> +		btrfs_parse_runtime_features_to_string(features_buf,
> +				generic_features);
> +#else
>   		printf("Incompat features:  %s\n", features_buf);
>   		btrfs_parse_runtime_features_to_string(features_buf,
> -				runtime_features);
> +				generic_features);
>   		printf("Runtime features:   %s\n", features_buf);
> +#endif
>   		printf("Checksum:           %s",
>   		       btrfs_super_csum_name(mkfs_cfg.csum_type));
>   		printf("\n");
