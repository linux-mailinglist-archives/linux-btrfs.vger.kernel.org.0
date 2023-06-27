Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38D473F63A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 09:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjF0H5d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 03:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjF0H51 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 03:57:27 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2042.outbound.protection.outlook.com [40.107.105.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CF11FCA
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 00:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXOYNr8gQgdXMZj+YqwadkKkmamrKQiFmUogi8u2DjYqnFC659UJd3jX6Woqzd2rU/XdAWiy3fzBAb/E85LRenu7Rzzui4ErKrHFcwJGZB2YkW4IxxiVMSO/aVlhLNG1aScwivF/Ce1jUSU6XsY2GQpBZqDA5TxZ9Eujg/bkG74KOnjejyth5FPlcUbWpexiVL4i3RDs+mg8PKQL2G0esLvlHtMgQRUFsCowNJF1ayDoCcLhcob63A1zswSDBIAofGWaS4uz6sRpsyxpUHM6W9AfVUG0JI54OjE7+b+xFkfzTApTjKnj+bWpsPEWvpLziDRfBeOoYTX4Btzu6MdrSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSEhHNObhaZu2I/Fqmvw+q7Gh1uY0k646LNda1m9y7k=;
 b=ZtuvWx9H/PjhW7T9cdBzJJ7ocKJY4DSSwDEBdg3uvhogj7W7CdyyugV3LpK4+/3cgDQQbirFaF5qsuBethNUe+MsbzTEQX0cgLt7iFxC63q4BUAJs8qm+30HH1eG7s8/d2efpC2RENWqFT6elFdNWfA5MfrMKM/5SMdaRoq9qw08HWbo3cNDi4oug3T+RBmG4nlwvRW5aWpjIudszOpABZYwTTB0rLNBO9keIH7T5I2Czz5PY+CUCejrU+UyHcl1/DL6eax1Sxo/d1xbKQDcWAPBKd9GuFHMbXu5wgN1oO0seV5L9X/1XH7tgY6MOohTYSASeq+YQyjenAEpRLoM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSEhHNObhaZu2I/Fqmvw+q7Gh1uY0k646LNda1m9y7k=;
 b=Rbel9dKS+5TofUiXIEsNk1MAI44vVz7zBgrDkCR6yop4IDW825DEUsPdM3yHaAJ/NPQOWjMbmA2boOEEV8ZGt7yTYkd1Ty5+vJhjDZk5aa0VUAkJ4b2IKuI0XoZfnQwpZ6DHgELmxOXrdf3Z74178q5mFMiDji6snMspr5NFY8XYC3yJ9Hk9R/uW+LbpjDhvA0TXDCxFFgrwZXscqbj4lpWApvl6xRYSJMnwJ+0MCFwgnzu+c8/rxWUaam8KgwlIyN7pKiwYFXJqEJFRto0q1L921VglAGAfQrn0IQqxtrAwRSHOd1vDdecEtHVgQ8jFgZ6ySlGNUvfsWUqVR9khWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by VI1PR04MB6832.eurprd04.prod.outlook.com (2603:10a6:803:139::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 07:57:22 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%7]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 07:57:21 +0000
Message-ID: <9b1b917c-c92c-b2ac-b972-e2a47f7b4ce5@suse.com>
Date:   Tue, 27 Jun 2023 15:57:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: add comments for btrfs_map_block()
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <4564c119bf29d7646033a292c208ffcab6589414.1687851190.git.wqu@suse.com>
In-Reply-To: <4564c119bf29d7646033a292c208ffcab6589414.1687851190.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0086.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::26) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|VI1PR04MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: f945c517-2f92-47a5-a561-08db76e422df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rzbcai4TJqr0Ht0ixNdVE2Asss76/592lYQUHeUXO3+zwaxMP6yjXqLkhbcXBjPkT8gYF0m5HZPXiI6a8rhuc1fD8vT0MfENnL1MUFkg/Aq9ZSgrjExr2xZjl4qc8T5WcY72mhyPXPoWXiyxSXN4aRv468Em+T5fnSuZd3j9a04bk+rwAfjtfJZITRfm2ILY5qvn9m26SgNHxmxNLpGxXLXAYwc8hW406d5T6OyIIxDvWNbekixtNLMPa30c5TJUZCtxAi5UHWAAvMsWwuggi/nPZWE4Eb568rZlyqbg5rhDZz3PXDwznzuNYj6nm6rHDoGnChJ8I3+FYEqq3t/HlyxkYW+at1MrqLK62fmeyMG+L7qfV2rm9qcO51R7xpFbdlaO47xVGHuUP2iGmdXGbGabl2qFBtp81/fdk1b7Z4H+HCsWGKXtTCVKMoCTm3stDCufGk1OeoMTxkHUbZdLPRJOTtMMDYnOmrvVf8Ikxft5yaNtjBfGXfce1jXZ6Y8MdrsHNntkXUufKtzk5wohLpkKeuP7Cq8vq4v4MTFRJEDHetTdMLJk/fLqqx3fqdRhpX2Xwc+PfDz0bmlij7wtOc/wBSXBProkdvn6QMOOhdfH4lv9gQ2SoimgBJ7yn83jcpZLUn5EdFoTrQFbNkiawg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199021)(31686004)(186003)(2906002)(41300700001)(66476007)(6666004)(8676002)(36756003)(6916009)(316002)(6486002)(2616005)(478600001)(31696002)(86362001)(38100700002)(8936002)(5660300002)(83380400001)(66946007)(66556008)(6506007)(53546011)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkVrdTdQVGNNMGxWdXpZQlQxQWRUV002aGkvM0dKSDUreEVNVjBsMnl4UjVo?=
 =?utf-8?B?M3B6NkFJQVYxUG1rN0h0QTdHeHN6aUVqRVZYNEdEWmIrN1BFeWh2ZVBiNEFY?=
 =?utf-8?B?eEFzSVJ2TjZuL1BLRjZSV0RYazZTN09qcEpjMHZXaEZYOHFOQStEeTVTS2hn?=
 =?utf-8?B?VWVVYjA5S3FTM0N4Mm1ZZ1RSOVZXSkpSMjIrajkvbUc4a1F5ZWFORHlBY0VF?=
 =?utf-8?B?WHAzWWtVVDBHb01ZZGxKUjVyaENkYkhwM3MwbVRUZWIwVDFNRngyR255eXlv?=
 =?utf-8?B?VmNvR0FtS2ozd0JwelVrN1RnQk9TZCttRENnQ1F5TXpGUXVDMVo3TklVT2tG?=
 =?utf-8?B?MEFhMGFvQk4vc2VXTTMwOE9saEt3YUNnbmZkOHpYSThhTm4vVUtHS0dIWmhF?=
 =?utf-8?B?MzlYS3grM1MyM1Z6SmM4b3Vnam1xUGxac2J5ZFFNT2xWQ3NMNjMzTGNqMmoy?=
 =?utf-8?B?NXdqZzV0b281Q05BVkd3YjZyTUM1ZkdlZU9HbjVmUlE0MzdFZ0JRblRjMFMz?=
 =?utf-8?B?MFRSM1ZGQWNobmRUU2NWMmVTUHM0R1gveHRxSHRpLzFuT0RtYnpZVi9zcDcw?=
 =?utf-8?B?NU1icWU2eE5tcGVRSkFrZ1hFNTlsZEZ6NHU1aEtUSnYvcXlibEtXWnZrWlpj?=
 =?utf-8?B?cWh5Qzk1OTY3MTFYNkNlNmtWOFRlek9QYzdvNW90ZE91blhmbTQrenFWYXQ3?=
 =?utf-8?B?cFpwVk9OUVJKZXlhdmtMVXk4VUc1aTk2UjE5UEd1NTU0bFlXODJzWUFLVGZV?=
 =?utf-8?B?bHVybDJ3RkxCeFlvVTNFNzc3RGQyd1l6Y1pwSU9aMEFUUmR0dzlGUDkzTXFt?=
 =?utf-8?B?Z2VhSDFZMExVeEgyakRVek9kekZ1aWpRTWJFdFo4ejI4a3dhK01tRGxFZkhx?=
 =?utf-8?B?bFByc2w4elRmWERMQlI0Ti94aGpoZnNJajd4RzJSd0VKQ3ZHQWdLbG5wZzV2?=
 =?utf-8?B?aXVTTDhtUU5ldjY2aWc3d2dpdGtLVld6aW5mSHY0VllNRllaZXdtN1FTUDE4?=
 =?utf-8?B?bVlHRDZieXpPSnROTDRZamxyT2NrSWk4dHQ4MmFKdzMyeWdjbEhhdmFvRi9i?=
 =?utf-8?B?akhpKzFuMGxBS283V1ZaeHF4U1g3dXQ3Z08vNFlhUTFNZFlHQ1B3QlR6Q1hx?=
 =?utf-8?B?V2I0cDUzZHlHOU14cEpaU2ZMblE5MUI4QVU0enNEckxqUU1mYUV5SjJ3NWZl?=
 =?utf-8?B?SkE4blJLd2JCamF4bjlZR2pkbytLRlJuRHRvNlVUcUJoaTl5dzFXRHJERER5?=
 =?utf-8?B?VzZ2R25MZjRSU1REVHZxNUU2U2pkeXlYckdiQjcydHFrVlJVaEx2ZGdHb1Rq?=
 =?utf-8?B?a3owd2s0UGk3UzE0ZThkQTY3MWFzdHk0aEdyU0hJY1Z6MlJrMVE4aFpWeHdN?=
 =?utf-8?B?Q2lCQStaOHdCWEh0b0FtZk83WDlidnc1UXF6Um50eGVTT1pBRHVRZlpBTGpD?=
 =?utf-8?B?cVJWaEVOeVRqYnphcVh4MWw1bVhhelkrWkJnME9VcGlFMDhZLzBGS1pTZGlv?=
 =?utf-8?B?Qm5kenM3VjQ0YnlGYU1VWU45RG8vOTB6NkFFd2dwQ2xsdG9CZWs3TExQb2FG?=
 =?utf-8?B?TzNmK3NoRHNDL1RQd0IxTkxWdFFZalJIdmxHY3pKQSswbEpZZjVOS3A4RGE3?=
 =?utf-8?B?amVUakljL1hlU1VDTi9mcHVnL2RITE41SElpc0dZcld4TVAyYnBMSzFsa2xl?=
 =?utf-8?B?aEcvUmhWbVFzOUdUV1N4ZGJ3S05XZVlZVnU3YTh5UWNjb0FheFJsbGxTQUZ3?=
 =?utf-8?B?emRsWWtzblFsaHpReXN6TG5BTjBTTHZYMjgyNEhlSGd3Yy92SWJWYkp6Z0Zz?=
 =?utf-8?B?dndNNWNpL2Z3UklPWHlZTEZMeGFTWVZscjFjTUIzNW1iRVlZZkR5ZWcyYW5Z?=
 =?utf-8?B?T3lmcGdxTEtSd01lelcyTU8wQUxWUTd4bkVzNXVObm5jSlYzbC9ObE1RN3JB?=
 =?utf-8?B?Y29JREhzbEN0S3hlOWVFK1VCR1gyb2ZiYzR4OFZ3cjhnTWhkSE5rRDRQd1di?=
 =?utf-8?B?elVRY2RUWEhudXZBSEp3U2YvYzNOTGpQb0R1TFQ4Ulltd25FM1lFODJCeC8y?=
 =?utf-8?B?QXFNbE5SL3cycGdBNmdhcWpiTUlRZDBMNGg3cGx5Q3d4cWQ2MmhkbTlyRlFZ?=
 =?utf-8?Q?8gc2JPkDdnTrRSkFmf+KsDpNm?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f945c517-2f92-47a5-a561-08db76e422df
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:57:21.8107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MohM6YQxiVkx800M3JdWBDaSEcpDLyPsCLeUNqnsRbfH86A3ANqZ7r8bKb6qoWu6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6832
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/27 15:34, Qu Wenruo wrote:
> The function btrfs_map_block() is a critical part of the btrfs storage
> layer, which handles mapping of logical ranges to physical ranges.
> 
> Thus it's better to have some basic explanation, especially on the
> following points:
> 
> - Segment split by various boundaries
>    As a continuous logical range may be split into different segments,
>    due to various factors like zones and RAID0/5/6/10 boundaries.
> 
> - The meaning of @mirror_num
> 
> - The possible single stripe optimization
> 
> - One deprecated parameter @need_raid_map
>    Just explicitly mark it deprecated so we're aware of the problem.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> There would be a follow up patch, to add one new case for
> @mirror_num, where for RAID56 we allow mirror_num > num_copies, as a way
> to read P/Q stripes directly for the incoming scrub_logical.

It turns out that, if we allow mirror_num -1 to indicate P, and -2 for Q 
it can be much easier to do the calculation.

But that future feature should not affect this patch anyway.

Thanks,
Qu

> 
> Thus I believe it's better to explicit explain @mirror_num_ret at least.
> 
> Also if @need_raid_map can be finally removed, we can also remove the
> corner case for special op == READ && !need_raid_map case where
> mirror_num == 2 means P stripe.
> ---
>   fs/btrfs/volumes.c | 39 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index ed15c89d4350..efac9293446d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6227,6 +6227,45 @@ static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *
>   			stripe_offset + ((u64)stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
>   }
>   
> +/*
> + * Map one logical range to one or more physical ranges.
> + *
> + * @length:		(Mandatory) mapped length of this run.
> + *			One logical range can be split into different segments
> + *			due to factors like zones and RAID0/5/6/10 stripe
> + *			boundaries.
> + *
> + * @bioc_ret:		(Mandatory) returned btrfs_io_context structure.
> + *			which has one or more physical ranges (btrfs_io_stripe)
> + *			recorded inside.
> + *			Caller should call btrfs_put_bioc() to free it after use.
> + *
> + * @smap:		(Optional) single physical range optimization.
> + *			If the map request can be fulfilled by one single
> + *			physical range, and this is parameter is not NULL,
> + *			then @bioc_ret would be NULL, and @smap would be
> + *			updated.
> + *
> + * @mirror_num_ret:	(Mandatory) returned mirror number if the original
> + *			value is 0.
> + *
> + *			Mirror number 0 means to choose any live mirrors.
> + *
> + *			For non-RAID56 profiles, non-zero mirror_num means
> + *			the Nth mirror. (e.g. mirror_num 1 means the first
> + *			copy).
> + *
> + *			For RAID56 profile, mirror 1 means rebuild from P and
> + *			the remaingin data stripes.
> + *
> + *			For RAID6 profile, mirror > 2 means mark another
> + *			data/P stripe error and rebuild from the remaining
> + *			stripes..
> + *
> + * @need_raid_map:	(Deprecated) whether the map wants a full stripe map
> + *			(including all data and P/Q stripes) for RAID56.
> + *			Should always be 1 except for legacy call sites.
> + */
>   int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>   		    u64 logical, u64 *length,
>   		    struct btrfs_io_context **bioc_ret,
