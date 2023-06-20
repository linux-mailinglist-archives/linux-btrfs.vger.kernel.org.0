Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF320736825
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 11:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjFTJoF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 05:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjFTJnx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 05:43:53 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7B4130
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 02:43:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hv4ibH3aGYikteaQ4RZhOEgQvOukWRxihZpu4zb/hV8Aw1GVSCYMZO7llFJABvOWDuO1Qd2+IUkNXtq95itVW48F44s9ogmN/BhsMsgPVapdavRzNdFLI20mZ4wzUzxq20rZSzBS6aEfuVAVJcMNYbwktl7t6RFhK/GZ1mFIXTm0RdjZW8cqUhFlaza67+mPAbCUnN7YxqdEtSbqwUh3WUMjHysk3t6BbfxUVVUm1BLR78FzOP27beZKx8R14O3wUyqR9p5JfAToI6yISh4wKsr/9U07bRnjDPyRguK+hi91yIWP9pa94XHnpOZmBR3uxLM/VQKcoAKAdRALv+PVyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fq10sZFYhZHhqpLur5f84XVGdLhpf8FPX45RrI5jiEI=;
 b=oGCXXQJ6fwV12BwoV/HUtQOO+87/Twi6Zd48TR9Q1dSQgpELHbMdWaTAKFgIMeWuOt8XOotexUm1iGkLyFdxsniu2f6qHdsrydtjwLAMQ3hHl2qaO3ceotD88tBPWfPHzCE+rpnhWZU8WvZRIacUYTjuHlZXiDOiC2bAWP83S7l/9R1LOE8MdE94hhQMdVokbZIGyR1/77Da5edRNn0WXoXnn5i8kWtwrd8n//mEGhSWtTGOA8R1o7hzdkSV7H8tmfgKfJrmXzAd1JT8oew4b6SvLnZfJ1xWACTGgUwccmHUAxSH8lG+C/nMXBqV+GaEPEQ3Zsiwdf0u1gfx9xavOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq10sZFYhZHhqpLur5f84XVGdLhpf8FPX45RrI5jiEI=;
 b=cpaLbAv+jCdqPT7ZTcU0flrEVxxCWcoFBw6LH6wUqmsIqDPEPLWP01o1F24bDnUMmJ73zZmxEu6wQepGSB4aF0/dAbufTZvZzrhg/edETyV898tfMMaiNHJw3SBQ1FQvzxu6iQWAb6vlkYEJAihcmiUmMrTH3DUTW8RI7Ww77eRLGND5I+9/SViGCzL1H/j5T1tFW3kaBZX7x7XtHVaUbgOTf1bpl7Mas30YglgGdVVzadBRMm77cQTjZXkc+Fyg+oyadBQYmtR0h1S2EMUnp+TusY6Mmq0T3hOr4jpwka3cYhRZiyxVor216U3KbRJ/WKJAyPY//+DTSclmo6r3zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PA4PR04MB8030.eurprd04.prod.outlook.com (2603:10a6:102:cc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 09:43:45 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:43:45 +0000
Message-ID: <08631b0f-62c6-7f8f-342f-88d97a188e07@suse.com>
Date:   Tue, 20 Jun 2023 17:43:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: fix a u32 overflow when writing into RAID56 chunks
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <ca680432cb92db7b57345fbd919e47032a78edf5.1687242592.git.wqu@suse.com>
In-Reply-To: <ca680432cb92db7b57345fbd919e47032a78edf5.1687242592.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0191.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::35) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PA4PR04MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 02121fb6-6cfe-4157-7bcd-08db7172d714
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KyjSHxlAfIYudB+T3/hHQOkfosXWAOntIuqAupnTAAyKicfgKDYTzKF6SoVcRGNCirw93DAZHkwgrOAGoD5foYu7K9yrKAul5y5gqHUe0AFKJHY3SnGTb1peh3saLYUOfx8z2MXmLyBmJtH/wq6I/kIL0D8iNEcMF1ogru2LwltPsz5Dtfh4WEl9eDl+zn4IIBKg43PEupr69SaZ+Zoa5VgdKCkQWrKyQWTDrTlbGshUa5bhKl60k4Sp0hUhncMEp+IVAyIctaJoveVlKkI0y2TKA3qZFvIlS9JJT6YiY3jaYi2ocrs4ccKy4wK7kdNpAe6G73tw4v2fYlfWfOKau0b9J80fScgbR6GzuU3fVjmqzY9C2KiFE2+SMjys6LOPV6oEjv7iL3J+/GBVsWBb1fuC2LMaoheUawpDf+nHdXJRj0B4ytz6dBxAHGwIckE4pD/4+hYpJpuvW89jztYJ9ru5IvX/rhBrZcTfCJCRGvDQe2MgAJQER3TZz7TYN32+Sxk4D5WCrEeBzqeHGdw3AcspjWhxCPsmcjFvgQ+ld1CwXo1UOuH5rG4tO0RyQYI8UyF9AxFcP9o/ikgEN3wPSnoXj+OVQ3MAy3ptbbtUBf5PwKltaqzhkwTdlCyz0wM8mi6MhrI/cAXwKO5cZ9x9+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199021)(6486002)(107886003)(478600001)(2616005)(6666004)(83380400001)(6512007)(53546011)(6506007)(186003)(2906002)(5660300002)(36756003)(38100700002)(4326008)(66946007)(31696002)(316002)(86362001)(8936002)(8676002)(41300700001)(6916009)(66476007)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anl6Yi9Xc2MyL2VUMDhyK29UUkpLOTZhY3VqWDdNVUpxVFowZHNCdzY5b2Rv?=
 =?utf-8?B?K0xEMWdHWHgwd040NkxCVFZQNkNza1lJbExpSXRMMUFjb2FUM2ZLNlBkOGp3?=
 =?utf-8?B?andYS2tXbFN4WEVOWUkwUStiOEltL0ZLbnUyQ1E3VkRMejduelpGQWtWbjF3?=
 =?utf-8?B?ZVRGNWYwYXVoSHVlalJTZEc4SmpVRjRlaERrUjB2SCtOeHhLWDBzYWwzRXQr?=
 =?utf-8?B?WFRvTk9rcU1nOXlSbzdLeGc3ZlFjbmVxeGcyS1N2QTc2NzlJbUxpcEhKbVJU?=
 =?utf-8?B?b1RwTFV1S3NmYVhZR21IcWdleis3SDlBNWNkSnNjb3E4SjRTQXN0UnBhZHl3?=
 =?utf-8?B?c1JiKzBGOUxySzFEdDRoMDBuSkdlZmNuODMxY1B2bkJhWFlIZTJqV2tpSWtV?=
 =?utf-8?B?b3dmQ1V0NXJXQmlnMk95VS8veGVCcEZxMWo4YVFaSEdNalVUMkdzNzdScGp6?=
 =?utf-8?B?U1FRSFNqUkZ1cER6NEFIQkplbnMrTnBhM1JBMEI3N2hHRTBLOXRsN2szM1cy?=
 =?utf-8?B?TkdiMzgxa1RGOGVhbEJTT1FzUm1USk9tZjNMYmdSNTNXKzFjVElUWFA5NU8z?=
 =?utf-8?B?VGZqNkY2V1J3V2hVZFRaaXVRM1ErN3hMNU1nazQ4dlRPSXBiVmJyalROUUhI?=
 =?utf-8?B?TVdmMEZJS1dZazZjbmQ2Nk92d1JFM2puSFB6UjhxUlZ3RlNCc1BaODR3c21C?=
 =?utf-8?B?YnFUVldzZTR6bkN1R29DeS9OejFiNXN1MzJyK2k1NG5aTDNCNm1pMUsrZ1lJ?=
 =?utf-8?B?TkJsVW5VTzZmUVpnd2tiZG5sUWxRZDB3TlFJL1ZPWjNtUU1MZC9scCs4SnM3?=
 =?utf-8?B?SDdrTkdGbEltc2Njek4wYU9YdGJKamhyOXRPOVg0a3F0c2ptSzVHVEhtS1hG?=
 =?utf-8?B?SkN3Q0FmSmpqYXlIWFFMMU1IRU1lTHFWVC91RWtxTk1rOXIzSzZ2cjU3WUZa?=
 =?utf-8?B?azQvdjM0L2IwcWNzN1V6VkFEOVZudFAvTGpxRzNwTzdVdVNWS0U3M0FienYv?=
 =?utf-8?B?WHhXaG1td3E5TEFlOVdJcEJhRDNDNDQwTjFWRnorRjdJRTMreGg1U3pMRzFZ?=
 =?utf-8?B?elNFSmJ3MUVHYUsxTmF3L1pkZ1l3MHRZYklwbFhrTWt5UjRaeDJPcXNNYjhP?=
 =?utf-8?B?TS9HR2l3blpHOGt4WGZnSDF0RGFBZ2wvQmJRNVRsenZtUWtxOXp6VGVVcTJB?=
 =?utf-8?B?OHgrSjJtSldwMEI4SWFYSHlBSXNoZktkUWRkSWhpRm5BOUtjcXN4Ylh6QjBE?=
 =?utf-8?B?TVB0SEtIQVhBaFZmN21RcDBoV0JXVERITDBDYkdMT21FdFVDNkNIRHp0eFVK?=
 =?utf-8?B?RW9EeGJtQk5tR084VUs5ZktuV25qWFp1OC9KTFRyM0ZlZnJtVU80c2R5OVBO?=
 =?utf-8?B?SzZsY0xJZUp6Zk1ualVkSzN5RFdFT0pzMXJocWl3K1kzSGtSQjVpaFBHS1VL?=
 =?utf-8?B?V2swZyttclpWVzF0bzhycTdveHVzK2VRZTU1WVduQmNqbm4yOEtBeW9yK1Vl?=
 =?utf-8?B?UEZmTC9vTE10SUluOFV4bktCa2cwVHJiSmczRVpETnRGbzFEK3JXSEt5cHps?=
 =?utf-8?B?cnk5dnhzRndBODExa3dvZEVpTTFmN2V0MjJmMWNLUmZuTWZGWGZZbHcwMFE3?=
 =?utf-8?B?MWxDUGk0Z2dzVTg4SjlZODNkYTVuRWoxSGtta2xFbFlGUXQrZHBDallqeFhh?=
 =?utf-8?B?QkZKU0hjczlnT3lub3VxZEE4OTBzd1NseUpjcTlheXpldUg4QitFR3pLdldi?=
 =?utf-8?B?K0RpOS8zQmJtSW1yNkk0TG5IM0hUbkFHWkRSeTB3NCthV0gyUmZMMHNnSnoz?=
 =?utf-8?B?ODcwRzdmWlNHMWo1dWxZMGRjQldRTFNva2ZKMXVocmVIaWwyMUpNQlVkdEQv?=
 =?utf-8?B?NlJXRkZRZ0NvRUZLSzJGVkt3VEtWQXZmOFlJazJKY1pCV3ViT3RodnlDMlRz?=
 =?utf-8?B?M3NBemdzSUpXTXVYTElWb3hSaStHZEw0MW5KMEc3eFBETXBYNEp6bUpISmdh?=
 =?utf-8?B?bjB1QTZObU83cFg2R2V5RmR4MWxmenZhcEx1aTZvODlUSGtVNWdRZThKNUlB?=
 =?utf-8?B?UGlwc1YzcXJTRU9MZ2xzODR2QUFGMUxKNFhHazE3REZCQkRrWU50U3ZETlpI?=
 =?utf-8?Q?B92dXpGTXqk1TQzLDsVSKAxGh?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02121fb6-6cfe-4157-7bcd-08db7172d714
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 09:43:45.4948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /r7p3u2jn0VU2Z0t0cukEhysnQbhvp57iKAmZV9hupJOxKrUtdU9T7jf+zevXwYC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8030
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Please discard this patch.

There are some other u32 stripe_nr << BTRFS_STRIPE_LEN situations which 
also need to be fixed.

Would send out an update to address them all.

Thanks,
Qu

On 2023/6/20 14:37, Qu Wenruo wrote:
> [BUG]
> David reported an ASSERT() get triggered during certain fio load.
> 
> The ASSERT() is from rbio_add_bio() of raid56.c:
> 
> 	ASSERT(orig_logical >= full_stripe_start &&
> 	       orig_logical + orig_len <= full_stripe_start +
> 	       rbio->nr_data * BTRFS_STRIPE_LEN);
> 
> Which is checking if the target rbio is crossing the full stripe
> boundary.
> 
> [CAUSE]
> Commit a97699d1d610 ("btrfs: replace map_lookup->stripe_len by
> BTRFS_STRIPE_LEN") changes how we calculate the map length, to reduce
> u64 division.
> 
> Function btrfs_max_io_len() is to get the length to the stripe boundary.
> 
> It calculates the full stripe start offset (inside the chunk) by the
> following command:
> 
> 		*full_stripe_start =
> 			rounddown(*stripe_nr, nr_data_stripes(map)) <<
> 			BTRFS_STRIPE_LEN_SHIFT;
> 
> The calculation itself is fine, but the value returned by rounddown() is
> dependent on both @stripe_nr (which is u32) and nr_data_stripes() (which
> returned int).
> 
> Thus the result is also u32, then we do the left shift, which can
> overflow u32.
> 
> If such overflow happens, @full_stripe_start will be a value way smaller
> than @offset, causing later "full_stripe_len - (offset -
> *full_stripe_start)" to underflow, thus make later length calculation to
> have no stripe boundary limit, resulting a write bio to exceed stripe
> boundary.
> 
> [FIX]
> Convert the result of rounddown() to u64 before the left shift.
> 
> Reported-by: David Sterba <dsterba@suse.com>
> Fixes: a97699d1d610 ("btrfs: replace map_lookup->stripe_len by BTRFS_STRIPE_LEN")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/volumes.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index b8540af6e136..b9cd41ac9d5e 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6199,15 +6199,17 @@ static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
>   		 * not ensured to be power of 2.
>   		 */
>   		*full_stripe_start =
> -			rounddown(*stripe_nr, nr_data_stripes(map)) <<
> +			(u64)rounddown(*stripe_nr, nr_data_stripes(map)) <<
>   			BTRFS_STRIPE_LEN_SHIFT;
>   
>   		/*
>   		 * For writes to RAID56, allow to write a full stripe set, but
>   		 * no straddling of stripe sets.
>   		 */
> -		if (op == BTRFS_MAP_WRITE)
> +		if (op == BTRFS_MAP_WRITE) {
> +			ASSERT(*full_stripe_start + full_stripe_len > offset);
>   			return full_stripe_len - (offset - *full_stripe_start);
> +		}
>   	}
>   
>   	/*
