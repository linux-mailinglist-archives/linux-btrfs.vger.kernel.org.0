Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0118B7458B7
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 11:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjGCJq0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 05:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjGCJqX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 05:46:23 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1BEE50
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 02:46:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cfv5wFGRr5eMnsMyAkxepFFlD+X2Fono7sLvF6UpNGSOe9lq0nCOw5mAEXPPQhynfMb+xxjGvEG0OxvpydM+As2wgBtnuclxCJn93U6Hej6Imfbn2Meu/LfuQVXpzn+5a1y9mXif247EP/UVSZtGYWgZ+DgA7WhbspSxzgh7qH4nz8zhwaukb+FFp4dOJT9nJ3lTo1PqA7llcQSQGRdfBDG5A1/SQyUXGq5o1J0YK7Z2ghJfueIdvoQctNcMtsqQdNfQb5O/uzbWhXz6AFPxMgXt4u3tn7RxGsAfwgZV7bfhlY2nrlJEHsWMG5cfqTjmix1CYsDSvnADfIf+2Vo4fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MY+GU/x6Txs7LwOlPCWKLnr7jcc8efR5mLSH7QKYnIs=;
 b=Pd+jjmcFJnyuHsY8kallMxd9UufY2RPMmwwPDtJWSRKk8vGBh2+v33xwSWKCHkKaT2JOwmmouh6mB9bxijcotQmL9OuDvuhKkRWayb5dsg4lZTs7ia0ZOqDYPvAK987fDXadoHLi9hwq2NHkEandapOEOU+UaYn1Iw3OeOlAp56gSqo6HJ5+3ewR/cWAAJA0/9b0vBHxZbUwSoslUnjPzg+CIM4xQ/ZcRK0VfwNK3B4gelVVmIWwb+eE+/cZzA/mTdU5X+68eqqQ1MY7LxtsWWOcuBKiWc4Cn2AdAIFF6+NbAwA+Lm+6aozseK8WWcFt0zoT2W0w4VPJ4a1M9PvOIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY+GU/x6Txs7LwOlPCWKLnr7jcc8efR5mLSH7QKYnIs=;
 b=MT/RUXBUhfFs7nSQJzXTArAChiCcMbm6B0rLGAs34ykdDLeJ8TmgAvWi3Hr62S742kJ+hZE3V+xQU/CPn9yianF6D7KS8zHOEQCO45r9uya5WzPER0V/waYGMzj4DGGL3vpIG1bBDzoJok1vGVWK380CZUCOzMxhyJoApFqSFxQZqHIg5QxISTTO6sPOpNfwShoDvSJtc+AIyoYA2xkEq7f+roxJC0fkLnWcPOt57aECGA10xFhHqTJDJMPq4CAgKkBFYKULyGccdhqRPWeNKVDiQK83RH+s/b6VtDPAvTVQm1v0wGReRTWpYOEYuWK2zyRcQ4f3+WB3b3gPS4GjYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PR3PR04MB7353.eurprd04.prod.outlook.com (2603:10a6:102:82::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 09:46:15 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 09:46:15 +0000
Message-ID: <a1549aa4-8fd7-86a0-51bf-da24c92f4f14@suse.com>
Date:   Mon, 3 Jul 2023 17:46:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 05/14] btrfs: add the ability to read P/Q stripes directly
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1688368617.git.wqu@suse.com>
 <0d54adfb390b3c9ffd8ff8f98db43de51df9c33e.1688368617.git.wqu@suse.com>
Content-Language: en-US
In-Reply-To: <0d54adfb390b3c9ffd8ff8f98db43de51df9c33e.1688368617.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0197.apcprd06.prod.outlook.com (2603:1096:4:1::29)
 To AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PR3PR04MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 786fe2db-3f3d-4df3-7dd6-08db7baa5776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zuP5HshJ0Qyrrh2IHtStHvOwoJzB7Ta7neR1X7rGOyv40QMV8UYbcu5Ud5Qq/pvCrRG5Ue1rbm7G9dbikv10bDohV4Tp8Kq9g1NwGs104F1XRAXOX/d5OF0AsiedVaGlL4ne3BCUyyFPmC3KYfVlcMtRqvXqoi+DCWE5dceP5oJ93pGIxtF//3TzdlRhFZSc9l78ZnGeCFkDLH39YoXHPGItxJQSWRVMingGpmBylJq5KE+dbmIRJgS/B/wt7DBwb16nu/ckVtFmzVG1u1y361TJ5EiqAYrB1YoWE+aQqUeNIDqDxwHoQ1BjXBcIIeJq2pycDi5Lz89oUPcPalHNRXqXTgfEJGlBr3OLwbvRjLxfi5MeG0cUu7DH0p+m7kqk4MM74u1Nl9ZhqOk9OIYG/+hsgXTVAZdHyd+mPGbGunt5bFIzyZ3m9T2AE8C418puOEAL5d1Daz3XiqowEb91oTdth2Rc6GT2PkCN19QQ/8KOTYhJ4GbHUVWHzBO7MKIt5XyaeclU/x7wq5Lqv9VyzlB1erTS50UDO3JLjCEPiph3VzJbQf4jBBQmI3gYByAQRrbemX8EXj0DJztgF8M3sI/0GEWMB6bj8xeXkEgLJyAfewxoIipD/5+Kn0a5XwRaqGx9AGdUvZrPmMHBg+lSJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(31686004)(478600001)(6666004)(6512007)(6506007)(31696002)(86362001)(2616005)(186003)(38100700002)(6916009)(66556008)(66946007)(66476007)(83380400001)(6486002)(53546011)(316002)(5660300002)(8676002)(8936002)(41300700001)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG1YcHQ2UndMN0M3YXptRHdId1FMM3M2ekVkQ0cvSG5Xb24yYXR5cGc0eDc3?=
 =?utf-8?B?WVprcFFSaWJMaGFwVk5Mam5uT1YwL2dOL2E4M0Z0SkNyQUxjOHZTaWdlOUpi?=
 =?utf-8?B?WUFDdm1Qb1ZHTkFrbmtZY2FZWnJBTXBrd1FNVENRQmN2UVI5cDk4TWxlMzds?=
 =?utf-8?B?aVBiWGw2NVAvSU9SaE53VDhJdStWVnVWVDFRSkxyM1ZJaE9VenRmd0xBMVVJ?=
 =?utf-8?B?NWxUUWx2ZzFYcHo3YzI1Rk1lU1VCZktZdmJmVEdENXBrd1RhbURaQ3JUZ0ov?=
 =?utf-8?B?MFNuMmVJL3QxKy9oTXlLMDhRakRTSGtBbDR5MW9oMzllM2NJTkZaeUJFd2x4?=
 =?utf-8?B?dERqODI4NHZtRGNhdUNHYnBwbktpb1owM2lSWGpEVGZmTmFNYmw2RDhnRlJN?=
 =?utf-8?B?WllCMWRodnVwMGQwQkpSZWYrRXRlVFNxNXkyM2Y1T3V0VEhMdFd2RVlUSlJ0?=
 =?utf-8?B?NHF2dHpweklpS0lodnR5YnNHM29GalBham1Fa1dscjhuVDcvWmovY2VkY2xZ?=
 =?utf-8?B?a2thTThVWUttYkFTaUVwQVQwQld0TmVSNG5hTVhjbUFDUldBdWo4dDFZdmFF?=
 =?utf-8?B?TWpVSCtYWmNVa1BsYmt1UlNvK3UzKzRKZVlYVnBtUFMrQm1rdWk3ZWVrKzRw?=
 =?utf-8?B?SlpPOU42STNrQ3BxSDBHTldRQm5Qa1BlVjYrY3lTS0ZseVVOeG85WkdJeE5K?=
 =?utf-8?B?YUFXa05CYzJud3RXQXgzckxzd0tZUkhIdDd1ZndjQlFheEZhU1JnNFJHNG9p?=
 =?utf-8?B?R3dlV2hrazh1OG5VWFc0bitFRHdSODVWUnhWWUxZSXJFRjZidU5TYnBaNnMr?=
 =?utf-8?B?NmhqMWZNK2w5eU5zR0ZTWjhsOW11WTFmSWZEN2p4Rm81bHJzcC9GamNMTWRN?=
 =?utf-8?B?cDd5eURkbXJTd0x6MFo4S1VRTWF4OGQwU1dhS2xIcUdrTCtKQU51RjF4OVow?=
 =?utf-8?B?aXZtR2ViSi9wbHZFR2dQWW5hNUJBNWVKQ285VjdFdW8xaXMzbTIvSSsyYU9T?=
 =?utf-8?B?a2kwa1NYUFA3RERZTU5OOE9NcEI5eUpoTHAwQTFTeFZvT095QWtjbGVQUlRE?=
 =?utf-8?B?ZkJuRUFpSDdxRTlYMW0zb2pDU0REbWhycnpNaE1kSXJ4WW9rc013UWVaajBJ?=
 =?utf-8?B?QUxTYndtVnhYWkoybkpERnk0WVhLbmN1aVdjdnBINi92aVJWeDNBdTNhb1M1?=
 =?utf-8?B?dFFnZzFMTmo1enpYSjI5VlFrS1pFcGVlMGhtY3FuL1RSVEJMRHZrOUt5L1M0?=
 =?utf-8?B?dzJXL2VFOVZsSHlZVmRRVUI5SkJzck9XTzk0OTFGZFZORE9vY05zSGRBak1U?=
 =?utf-8?B?SWlwUGVuZGYzdTJhQUIrNUdFOU4vNG1yYk9JTEZvQVIzYkNvbnR0elRsN0lt?=
 =?utf-8?B?bFhuTmVWejB3NHJ1T3hKSXZZTWJrZWpyU0hiL3I2ZTJFUXlwM0NkZDVKcUFW?=
 =?utf-8?B?YkhjTVJHait5c0hJOEltQ01xclM2UzJWM25uRkF0a2M4SHVmNkQ2U0dKeklE?=
 =?utf-8?B?UEIyQlVGSEkyQlBlbWVrNVZ1b01jVGdwU2wwcThYMGsyUjdDNk44cEpQTDg4?=
 =?utf-8?B?VjlTYnZlNFlVaTBkQmJ6eVByYWlBeE15STBlbmo5UW5xU3B2amQ3d2JaTG1D?=
 =?utf-8?B?VDBPRTNJbmdQOTVRNGpRT2t3eENQNE1NMDZYQUtHdE1Bd3dDS2hqQUZ6VEVO?=
 =?utf-8?B?U2JUOEhRZ3dkaGNMOVRUNVFTS1dNL1EvMEFjb2NRLy9ac2VkUGh4Q2JwclNa?=
 =?utf-8?B?MEN0a0pXbWZCNERSOW9xVVdwNXRIUG96cVo1Z3IzdWJiNngwd0dUd2VOODJX?=
 =?utf-8?B?eThJRDcyV04wbmxzRXhOQWo2aW1Vd1J5Nmp5WFJaQUNKU3hDbFNtOFFFNzFY?=
 =?utf-8?B?WHZOMnd6cTFJUnFMbmNUZW4wSEo3T0dsUDFCVURTdkNHZ3BHUE9KQmlwSFp6?=
 =?utf-8?B?ejcxeXd6MTk5N0l0QU1HL0xiMDVJeWdKL0NINEtiSEtWOXFJNU5NRnQxMzdZ?=
 =?utf-8?B?ZUI5dTFyTDc1cVgyVWVrbjJJOTQxa2hUajA0alE5TFZ4OGRDQW5HbVo3VE1Q?=
 =?utf-8?B?N0syUFJRT2lrWGJrM3FSRUVzOUV1Z05lR3NFeXIvRE1rY2xTSFpHQ0NldEJp?=
 =?utf-8?Q?XvAEUFGDCmY6TgiHc+kSpZuS4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786fe2db-3f3d-4df3-7dd6-08db7baa5776
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 09:46:15.0933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChiGoFU27hDo1yDkp+io3qEwN1zhXx6Bjrby5ljf+damwjeKs5Achw+KaWP5II48
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7353
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/3 15:32, Qu Wenruo wrote:
> Currently there is no way to read P/Q stripes of a RAID56 full stripe
> directly.
> 
> Normally caller should call btrfs_map_block() directly and fetch the
> physical location directly of the P/Q stripes.
> 
> But for the recent scrub rework, it's no longer that elegant as the full
> scrub code is based on mirror_num based solution, thus this patch would
> add two special mirror_num for this usages:
> 
> - Mirror -1 for P stripes
> - Mirror -2 for Q stripes
> 
> Both mirrors only support read for now, and caller should make sure the
> range start is stripe aligned.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/scrub.c   |  2 +-
>   fs/btrfs/volumes.c | 30 +++++++++++++++++++++++++++++-
>   2 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 1864856abb13..41c514db0793 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1601,7 +1601,7 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
>   	int mirror = stripe->mirror_num;
>   
>   	ASSERT(stripe->bg);
> -	ASSERT(stripe->mirror_num > 0);
> +	ASSERT(stripe->mirror_num);
>   	ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state));
>   
>   	bbio = btrfs_bio_alloc(SCRUB_STRIPE_PAGES, REQ_OP_READ, fs_info,
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index cd632b3f579f..c22007bd830b 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6251,10 +6251,12 @@ static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *
>    *
>    *			For RAID56 profile, mirror 1 means rebuild from P and
>    *			the remaining data stripes.
> + *			And mirror -1 means read P stripes directly, -2 means
> + *			read Q stripes directly.
>    *
>    *			For RAID6 profile, mirror > 2 means mark another
>    *			data/P stripe error and rebuild from the remaining
> - *			stripes..
> + *			stripes.
>    *
>    * @need_raid_map:	(Used only for integrity checker) whether the map wants
>    *                      a full stripe map (including all data and P/Q stripes)
> @@ -6297,6 +6299,12 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>   		goto out_free_em;
>   	}
>   
> +	/* Only allow mirror_num < 0 for RAID56. */
> +	if (mirror_num < 0 && !(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)) {
> +		free_extent_map(em);
> +		return -EINVAL;
> +	}
> +
>   	data_stripes = nr_data_stripes(map);
>   
>   	map_offset = logical - em->start;
> @@ -6382,6 +6390,26 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>   				  logical;
>   			stripe_index = 0;
>   			stripe_offset = 0;
> +		} else if (mirror_num < 0) {
> +			/* Only allow READ for direct P/Q operations. */
> +			ASSERT(op == BTRFS_MAP_READ);
> +			/*
> +			 * Caller should make sure the range start is stripe
> +			 * aligned.
> +			 */
> +			ASSERT(stripe_offset == 0);
> +
> +			/*
> +			 * Stripes of @bioc is already sorted, stripes[0] is the
> +			 * first data stripe and stripes[@data_stripes] is the
> +			 * P stripe.
> +			 * So we only need to update the @stripe_index to the
> +			 * specified stripe, and set @stripe_nr/@stripe_offset
> +			 * to 0, so we can return the beginning of the P/Q stripe.
> +			 */
> +			stripe_offset = 0;
> +			stripe_nr = 0;

Oh, the stripe_nr calculation is wrong, it still needs to take full 
stripe number into consideration.

Would update this patch in my branch.

Thanks,
Qu

> +			stripe_index = data_stripes + (-mirror_num - 1);
>   		} else {
>   			/*
>   			 * Mirror #0 or #1 means the original data block.
