Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86265B9747
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 11:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiIOJRA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 05:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIOJQ7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 05:16:59 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227A8B16
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 02:16:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xp1hWGGJLixc2EDM6RrjQ+d4cz42zLYNGdo/y9yQhKbKiqhaiD2V8s2iIR5avoXU1T1PgQNEd2H1NXfwYBzn7+zHkxV1o8TKXOiKvEtZxQlRj6TWaZhza+Kz3rjhQyUpYjgUSFmGMTPK20X4iRc1inFSoeEc1kbz+C8RNjGARbQaMUjAEwiJ0qd8HBPGIMr8AYeL/YWbhUgZXre79Tt2jrRStVR5BNqcrqgBABEHLo5HCDqBOex+AiWkzvt7bnQl/kwoc7ky83dcnox/63O8Ir0XawPKw0HFmObPTd9qXOWiT8oFmZT2qt5Nkvw0MlHFZAi249zg58dft7RFT4BnMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hW/zg/PjDx16BhKrInGdpPs63U09zpLoLZrmG7EPDjQ=;
 b=jVnJAyTP8dEczWcyZTVs9c+JUyPVb2Ff5PgpH0yTuTyOJKSng6M8sSfhSU//c/Y5SQDI49Dq5grtr1G8jK+m843nSI8tUWX39CsbzzQOKYgJCn5TetJ7KJVgHTAOE/5GavsAmu/UzHyORrwDDe/sUE6cpS350MxgF2TFdZF8MJKeBGmUW1yeJneJt23zWA5e+YIOf1yTg25XBPmHa2I1IkRAO6L2lvPrRVQ57Gp3sF3ibsZOobqsv2ugQH5XJT2+dYJ3Gtsa26oSY5cTbP5IUuCUbQw79L0idFb1aFXOmsAyFdzzK7uAW7VUYBuQ/RFbdyPt1Bj6aOXuKUZvCfSu1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hW/zg/PjDx16BhKrInGdpPs63U09zpLoLZrmG7EPDjQ=;
 b=dEggy+dYHSh+lbyw4sFX9tCdARBBOrDBlEzdbWYHT4xNogrOIYz/fbuzFgXs7a9mp4z04WCOmyPE+pWU5xhUe2ThuKD8shqhc1xqx1lXO58hkzx3NYOejlAk7rMseHLXM82RjRp6iYoFulsL6fIvrcTLO2tfTFSUzoD+nwDMNVQYuLadl631Bmj3Zhjp6jEfaJHJUDIJpoYaxF2TlAORenIvtyiXs0cYq/I8aJdSRizJeffQgJfLPRFTWuIXu/OKltGh8QSZzncqjtvDDBpJhu184bZmxuoQtvK/e/C2A0bd16GpQcq6EClI9GPtM5K7yoTpD0f9DaUmXgRsvSVsYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 09:16:55 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:16:55 +0000
Message-ID: <8d8ea30d-67f2-46cb-62d0-82ad12ab6413@suse.com>
Date:   Thu, 15 Sep 2022 17:16:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 10/17] btrfs: move btrfs_should_fragment_free_space into
 block-group.c
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663167823.git.josef@toxicpanda.com>
 <50ba0e87399977ef84a5d3787666fc6ce6c5cf3a.1663167823.git.josef@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <50ba0e87399977ef84a5d3787666fc6ce6c5cf3a.1663167823.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::10) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS8PR04MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: c0550468-7fd1-4b6a-10a6-08da96fb0897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JmZskvgkKeYedOMKaNw2n3BBEJPK+0w3ecxER7Ra+0x0op0lRi6o20vxH0J2WCHU1KIfc2HIJ2qb0k6ncbpXgb1t7SfOFIuSXlU2ucjXNwPlMhHB8xE7oLkU3m07yqpSGrmgoo44VpsRn2iRuv8hutU1wN85zGsw+2pQsmS8A8Ck17yIrxjl6RDPFo5fjEdMlHjQLnPO9VplCM5Hd510EddOVRqnc1n7ZVYJkB6DLJyErx9CtxljyOvrTJHoMOFV5qhjYz6+SuB/U7MxC58w0Xi00jeFo7xZDOwLX8ugKaCnpzZ2XoxbKYxqiGeSCNUPqkxRylhgCT/yElUkh18J3fnywKunDZAzKpL0r8XSVzWsgbpqzFc31apoxPcqxXNWgFTymAQWelq7uQZE2kLyRmtQqgBHgJk+AsvKEoP72G7PVlSe5PljTduKTDqgmvahzkgs7WbPjLJtwA12Ch5RFkN7C18yQeWrWzMCih1ALg4APxD2LASkcwKD18VwRD16S+mqJZuqjxom3V5cdGNWfTwCC/pWzpJoJPX8Hb7HSHEttxrGIz9JXHecPLJoEIlRbdf507lVa7vjD6pDpof7AdQUGIMBI455gm7W/BqvBAaiO6aRV1k+nWU/4DxC0Foyr4sFwHH6P7d/6Mo+S8MszisVoaMrmoPbLOBudo6gnn9yIcIYyyKGTOQlIW+SaB/zQfrOr1YZzOwDvCdJ2LfLp6feyHYogW7U4VhNmKicGNPr76yaIkgarQq1UWtZVM7vdQ3gz7wK39p3ZRHEL1/2HqX2GHxfT9otoCKU2TrsWuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199015)(66946007)(36756003)(38100700002)(83380400001)(53546011)(6486002)(31686004)(66556008)(5660300002)(6666004)(41300700001)(66476007)(8676002)(186003)(86362001)(31696002)(316002)(478600001)(8936002)(2906002)(6512007)(2616005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkFNeFdEcXRSVm54OHhoQmNhQWRpSzZQZmtaRzlGRUZUWGYxUWRoTEdGdkY4?=
 =?utf-8?B?WFpxZjZ0dHpwUGF5aUJOY24yK29ZZHlla2NlMlc0ZUVTSWlzbEh5OTdVaHhW?=
 =?utf-8?B?ZVRkTVJ3SWF6RzBjUlZlSjlKdWZNU3AvVWRPZWpheG9OQlEyekFwVXBOaUw1?=
 =?utf-8?B?K2lrL3NkYjBsQmVSYTRtL0k2MTk5TCtSZzZrSUpGRzFQSkFCLzJ3T280aDdY?=
 =?utf-8?B?Q3EreW8vZC80ZzBTL3Z1UmtrczhsMllBUTdudWdHVjRmcG1ZT3ZSNHhnbEdE?=
 =?utf-8?B?OTZPY0pQS0piWno0cHpZWUZFRGs4KzRwVlU5R1VPcHhYdWdZRUVjZ1VCc3FS?=
 =?utf-8?B?VHZMQS95VnVWaTNLREptdHVNR01sNzY4ZkI3NzBPQXBxS2FNWUl2cUdsT2ll?=
 =?utf-8?B?RU5VY1JnRW95b0t6WEQwQnBqVzV5R0psL2cxdmhsNDE1VGhaVk5haXdBT3B1?=
 =?utf-8?B?anRJc3l4M1YxYUNmbnBNYVZxWG9LQVRlWjYrRlBtbmM3Q25EVlE2MTVFbkhZ?=
 =?utf-8?B?S0VXZXpTWG5xMnNrVXB0T0lWZDZDeG56WlVHR3VWcnpEd0N6QTZYdXdvdTJt?=
 =?utf-8?B?Y2lJcmF4YkJVZ1MyNndacmgwM0dvRnd0QkRwenhiWU54M0tYQWE1ZnFmTmpS?=
 =?utf-8?B?d3BEaTU5VUNvb0tFY01TUEtIQXZOZ3grbmUvZUJRbDBJUmhlelRFOHlKZkll?=
 =?utf-8?B?WnpEM0JFay9XaWRhSmVTcXNBbmtsUG1aSDl3bWgrV0swKzhWZ3Urb3hnVi9V?=
 =?utf-8?B?UWk2YjkvdWFUYnQ4aG1XWktNL0NNRzdwNHBHUDkvKy9ZbnRKUnh2clJZWm51?=
 =?utf-8?B?WE5pM3hLWEYrMk0xS2JVeHhKNUhlNzBIcnlXakZCalJXUWQzWUtOOGF3bGp5?=
 =?utf-8?B?RHhiVCtQNFl3b1BzT0hTSUZ1ZGp1bE1qaHAydDQ5OFBZajNkS0lLU1FYdlM1?=
 =?utf-8?B?R3RNL21JSUtBL3Axd2RBU3BFc2dJQWRTa2d6bjh2dkRXalhkS1U4clJ4b0Y3?=
 =?utf-8?B?c1V6MDBYWE5CWXFwenNRSG16OGtCVXo4MS9TT1pTV0gxdUJkNWdCRURhc1lW?=
 =?utf-8?B?MUdZZ3VGQzE5aTV5TWRITkM3NFpUUWhnOTNHcThvUnYxYTd1KzNBY3F3WUJm?=
 =?utf-8?B?NEh0N1NGeGtLY2ZYY2grcXVLZk9BeGJJQUhzQUlEZkp6TXh0SWljd1JidGNT?=
 =?utf-8?B?L2VxZTdJOXFOb01RaHN2d1d2cC9QckdsekdmYkVPTTRkOVBCdXI1V3R2RHZU?=
 =?utf-8?B?Vm9Zbno4Vmt0Z042WWlHcTVFdVpZVncwZ0tLRkhQK3ZyL3lwTFFEaE1MSWhm?=
 =?utf-8?B?Nms4Y2hFTjRmUjgwZUVsNTgyS2hpemxLWlpXblovMUlHbkFoSmtnTzk5MGx6?=
 =?utf-8?B?QVVJbGx3Y3N2TjMybXNrb2NjdEpWaG5yQnpZT1NzSUh5a2YycjcxbXZUUUZL?=
 =?utf-8?B?L1ZIS1NxdUR4dm9Tb1E5T1dLL2NZQlBGZ3BDMXJFRXdpQ2EwSjdSWGhzSVRR?=
 =?utf-8?B?Qm9Zc3JlNUwrZUtlT2NNSUM0TVJ3YmVvOEsweXZEbXFRN3BLNHNYZ1E4UTZM?=
 =?utf-8?B?VThWNDlYTmpEanRNZlhLaUVNM3I3Z091QTJ4TzA1SjhuZ1NnWlNnZnVTdnVu?=
 =?utf-8?B?c1A3Qk5WK1NLZmc0MVhaRDFoaVlOdGJCdVJidE1YQzVrci9xVWI5cTFYZXpo?=
 =?utf-8?B?bmRSdXdHRVltRlIyNm95U0RQb1pyRkEvZVhNTEVsVjFvT3l4Y2hoV1crSmZN?=
 =?utf-8?B?dk80cVoxUHZtUVV2K1lBRkVUWGN6Wk82YjU5dEhLRktrL2d3U21ZYnF0VTRa?=
 =?utf-8?B?cy9KY2Y0UUVaRnpiRkNtVzN5bXppOWxLUm1HaWgxS0UxWmVoRy9Id0srWHJ6?=
 =?utf-8?B?WXFPQzZPaUlMNTUzb2JSeVF0TUhteTRaQzNVM2lpV1gzUk43L3NTeHJuaFhE?=
 =?utf-8?B?aU12b1d6K2V2VzVMWEdDOTdGMURQTkFVL05yRUVsZFlxSGwxRGNtdmtLcEZo?=
 =?utf-8?B?MjRScFFXTmgvNFY3VGpUeS9JdW9BSG5OV2UySEdvNEsvYWlBWGdFYlVzMzhp?=
 =?utf-8?B?WGV2TEt2b1F2NDdkU0Q4aGVaVlkralh4UmJSa1VnK1dpWlRpMlFOTS9BZnN5?=
 =?utf-8?B?Y2Rlb1FGYUVnYU9aOXpmUWNUSjZUV01Gc1dtWmdzK1ZqTisrNzhxdHphQTJB?=
 =?utf-8?Q?tGCL3k9mBaDybYe/0lbXwM8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0550468-7fd1-4b6a-10a6-08da96fb0897
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:16:55.2359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhZv8t4+5PHB74fX6eVSUBV07fMLb+CJrVSeurzAn0JTUpiVdLCax+1U7BKexPnf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8198
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
> This function uses functions that are not defined in block-group.h, move
> it into block-group.c in order to keep the header clean.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/block-group.c | 12 ++++++++++++
>   fs/btrfs/block-group.h | 11 +----------
>   2 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index c52b6e245b9a..c91f47a45b06 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -18,6 +18,18 @@
>   #include "raid56.h"
>   #include "zoned.h"
>   
> +#ifdef CONFIG_BTRFS_DEBUG
> +int btrfs_should_fragment_free_space(struct btrfs_block_group *block_group)
> +{
> +	struct btrfs_fs_info *fs_info = block_group->fs_info;
> +
> +	return (btrfs_test_opt(fs_info, FRAGMENT_METADATA) &&
> +		block_group->flags & BTRFS_BLOCK_GROUP_METADATA) ||
> +	       (btrfs_test_opt(fs_info, FRAGMENT_DATA) &&
> +		block_group->flags &  BTRFS_BLOCK_GROUP_DATA);
> +}
> +#endif
> +
>   /*
>    * Return target flags in extended format or 0 if restripe for this chunk_type
>    * is not in progress
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 4d4d2e1f137b..e34cb80ffb25 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -242,16 +242,7 @@ static inline bool btrfs_is_block_group_data_only(
>   }
>   
>   #ifdef CONFIG_BTRFS_DEBUG
> -static inline int btrfs_should_fragment_free_space(
> -		struct btrfs_block_group *block_group)
> -{
> -	struct btrfs_fs_info *fs_info = block_group->fs_info;
> -
> -	return (btrfs_test_opt(fs_info, FRAGMENT_METADATA) &&
> -		block_group->flags & BTRFS_BLOCK_GROUP_METADATA) ||
> -	       (btrfs_test_opt(fs_info, FRAGMENT_DATA) &&
> -		block_group->flags &  BTRFS_BLOCK_GROUP_DATA);
> -}
> +int btrfs_should_fragment_free_space(struct btrfs_block_group *block_group);
>   #endif
>   
>   struct btrfs_block_group *btrfs_lookup_first_block_group(
