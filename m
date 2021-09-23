Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2EF415801
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 07:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbhIWF7O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 01:59:14 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:32871 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229645AbhIWF7O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 01:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1632376662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0VRkO+ZZGI5hUHKIuIbpg+lWSczdz4zVAq7h4WOD+Q0=;
        b=fBrUl0Zu7WyN35wzoMEReAcLqbiCGffAVSur1XN4V+7ZMfSl8BEMy0fvbZyRmufhOXxcY2
        vUtVAm7j9OCQQSULsPN5L20rCOAcACcgof4499UMS/zdu5zUK1YCLEJc2WbcqzPMvad63k
        WkGddYFuA4QNUybF5I4zRnu44tz/hvc=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-36-s0wyIts3Mz6h-ZXz4ciQlQ-2; Thu, 23 Sep 2021 07:57:41 +0200
X-MC-Unique: s0wyIts3Mz6h-ZXz4ciQlQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIK81OZDYsFtZpDfrsUCcEsSbEM0OpOPLffmmLqTwidIvq0K5qOqCmgQaBBvdjGCFqOYZCHxOZ35266ZYHy4PSfXV6RVQwGdKiLxBTv6sQI+UC5zlTbCBHSKcnXjM0lHnSUfmEVggnbho0b2dyzfJrFviPSVVDRt1ivLlZPF3viHx//E1gIFWqMDKDAtVEj4YpL67eCpMX9wn1wztimMuQfO5QsdFU8S3lJlgXd61bwTq/BQB1vmGpoGuNlL39wxvFm85LgN6LWsPWMxTdKTiDJqNPCUDri3TOCgWK+kfER8q5q/pW7XtYlG2Tg2VA4S99QVEv8xSrmGu61/kV1YwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0VRkO+ZZGI5hUHKIuIbpg+lWSczdz4zVAq7h4WOD+Q0=;
 b=JdRv/aZi+RwP+IlueG9gfzzFqv1Zw2jGqRS0xGAktwq8u74m0gEKhacC/6jOZlnpZqxXUqBOHdpKJBJxSU1RbViSrT0jvWyphIakLL1Z/jMb/qh5T+PhxdVWLeGVy0v4A0Zs5seCnjMkTL0UbozbkI45kBH3wrCasSmsfSO0oEpJqxOp+9LrSiuSYyWLQ9It9nLkUqw7Q2mZHr06iUVdkGTud3DGTEDK0zDCmr1KK0BboV2Z3A2sAunkPSkIxseINJ+EGkdQ6kJ/JnWAhkq8KxBuLi5O5cRidQGUKyqBgdG496JJAvXWjlTmRkTZpW3FX1PxTJSiP8bLo5TXt34Ghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR0402MB2900.eurprd04.prod.outlook.com (2603:10a6:203:97::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Thu, 23 Sep
 2021 05:57:39 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%5]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 05:57:39 +0000
Message-ID: <77e8ad6d-337f-6a70-2855-754c6d6a2762@suse.com>
Date:   Thu, 23 Sep 2021 13:57:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3 2/3] btrfs: remove btrfs_bio_alloc() helper
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210915071718.59418-1-wqu@suse.com>
 <20210915071718.59418-3-wqu@suse.com>
In-Reply-To: <20210915071718.59418-3-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::19) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0284.namprd03.prod.outlook.com (2603:10b6:a03:39e::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Thu, 23 Sep 2021 05:57:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bb0e74d-cb5d-41cc-8c5a-08d97e570ce2
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2900:
X-Microsoft-Antispam-PRVS: <AM5PR0402MB2900664115A2E693C2C6002CD6A39@AM5PR0402MB2900.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qwXaZOH3jQuvNEbZRvV0Iapjl68Qv5Z349azO8oyI2PTJA/zFKDXfetfIxu1wsDZrug8Ha23gDQXdJHMeBisWdLKhT9x6q2LN3IklcOhrBaK2wR7Td92C/8qjJSZD7r0G9qoZyTA41BbnF9K+VzghpwbYinHAjnL4gC6elm7Paz9W94WsInKpAbksuQ5LqzLnl9BlEjMFKREs+oiCPVhWZ/P+xF5DtWvHV4frK/T9NvkrdTzuxSa9SP9UOSRbwHSPfWTp1ZLX4h6zsxIJo8OhMcDcwHTFSQfgHXmKXavrDEhaXrSsGF4CwDF8XP+uv5W80lsRe/RvoXoLAjlpbd4JxlpZd45IPPeGVxSH9p4bwzrHX6ntj8mx0y670XGi1kyRApdeFIYgA0zV6Qo2Ch/pxwEIRXGn5Rxa/mX637oNvdWmnbr+88SdmcCsctmaOOpwbBFnA0q5q7GbQ+a4GERfBxw78Nxgzn9EpY6lT4GEpy/uoEg81w9p5SGsBhkJSyd5rOcSqpncxTTttPVTU21sy1rtlaUO6mjAKx8nAEDkvyjS469LRgTlgLSYMAnxlvB/CXSEQGCQgdsKH+G+7bU7mB+ddvk1aOzflA9cV1JPAtejXxKQwqwBQ+hJif99ECWCVc5nuBjfDe2r66PSwUS8n/GAoJlobgKOl6yBXXECD3yANeU+eVDSZ0xV6Ovzq2RZwL5vN5PceXTrxbqEMhY6RPfYNgxfWVbdiFw2mw2uB+NA3z0vrz/GWi7UZHFbuzG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(16576012)(66946007)(316002)(66556008)(6706004)(6916009)(36756003)(2906002)(8676002)(31686004)(86362001)(53546011)(38100700002)(8936002)(66476007)(186003)(6486002)(26005)(31696002)(83380400001)(2616005)(956004)(6666004)(508600001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RndYZWZYZzNhYXI2Z1NqcXJjendjaW55cTFnWEp0Sis3OFc4QVJieWJORHQ5?=
 =?utf-8?B?aElYT3ZsZ3puN0pkaGdma3ZUZkdBSVNCc3p6RDgvdkp4U09RcktYc2VaUTJ0?=
 =?utf-8?B?SFAvSFZndzltaEswRXdFeGozbmhtcWtGZGNBM0Z6UVZ0RUVQNW12UjlwRkd2?=
 =?utf-8?B?WFRGbWNJSnVkN2g0RW9IRTFnUjA2OGFhNkJMTVBDQjJreDVnT1FIYjlOQ1hD?=
 =?utf-8?B?R211U0paQThBaWliZE84eTZ4OWl1bFEzdWZ0bXQ2V1hjRVFSbVpTRnZJUXNQ?=
 =?utf-8?B?MXozUzVmUnZCZWdraEsvdUZZYU41dEVBSkZ1WUNZWk5qdXZNWGNzT2lCcTNl?=
 =?utf-8?B?QzRpNkcwdDFrZDNEVmFTSGJ5WjZWZ0FPK2toRjJkWFB2cUNNaXV1VkF2alV2?=
 =?utf-8?B?N2RBVmFmMDNuU1Q4dTVHQ3B0WkR2SVB2anhpV0RPUVo0MTlZRmNKNmg2TmQr?=
 =?utf-8?B?azFtTGpjUkZUcWEwYkYrYmtBaE9tL2oxZVpPZFVJVzQ4VSs4ek4rdlYrRkp3?=
 =?utf-8?B?eXRpWWtoY0JnMGwrQWcrMUJYaTVYN2lqcnRvUlpoU2pZUEhRTDloOGtqSmlU?=
 =?utf-8?B?eXNjUGtJVUl5L05mb2FkSEFMdmxGYWpuUW1veXFKTGpOeHNWRFJid0MxY3Vi?=
 =?utf-8?B?M2ZQVTJYaU9uUVBNMXdJN1g4WUdmNXpBWjU0Mm05WGhLSVFZQTNWSURZRGFm?=
 =?utf-8?B?TkhhbG5kdnQ5K01UTTRnVGp4Z1YxS1JtQnJLZDJCZ2tuNnVFeUdheGZYY2sy?=
 =?utf-8?B?K0FYdzNRTEtLT2ZUZGFvTS9BRW5DNTErM0dpS2ZyUTJ2ZnZsWnJlaXl2ektD?=
 =?utf-8?B?aUNyaTRPS0hGTkkvUmx2eGlxVS9mZ1g4cEwxZDFzYU54QkNac1Y0aWxMZllh?=
 =?utf-8?B?cXBxbGc2REdmRnMwdDRpb3RNeCtET1ExNFhUNVZuK1JnWEdEWFRaZElkY0lH?=
 =?utf-8?B?cm02d1Y4eUN6WUNNR0tVSzAzUVg0TWVIWEJaSjM5ZTdCNUhzMGtHVFBiRmpT?=
 =?utf-8?B?aTdyTFpySGNhYlVETjZ3S3ZhUmZLSkNKY2NSRzVXdExVR1crNXN0WWlpeHVD?=
 =?utf-8?B?K21iQmF4NU5LY3FBWnRiUHVpcm02Z2g2NDcwUWRSYWlmQkczTks2ZHEycGw2?=
 =?utf-8?B?ZVAyNkZuY3grYmNKeFU1WHo5ZnpVYjdZakF4OHlMUkJHVzZhUUdZTDZ4UVJp?=
 =?utf-8?B?SlhyZUVadVBFNE03ODFRd3l5ZkpYR0ZSYkVOVVpLSkp2cHQ0aWNSZG9zQ3d1?=
 =?utf-8?B?WCsyV1FXaTExSFM3S1lqL0lBNUZ3RmhYZHZFWmZzV0g0RnQ0RDhPblBsdzk1?=
 =?utf-8?B?N00vZGJPQkJqdzVHZHkyc3d5M1dmY21DY1I2UGxLTU1VMHYwVWg5cFNMZkdY?=
 =?utf-8?B?OWdYSFVrK0d6c2JrLzZQdmVBS2YxblNsTXV2Vlk5U2xTbm9LdWliWTV2TlI4?=
 =?utf-8?B?VVRiaTFZQXExV1pid2RqMlFqSXJ1T3dOTFpodzNTVVE3T01ObEtkMmt4Zmc4?=
 =?utf-8?B?RUxUUU5OTXdndTJFRFlWL0EwbzlPYUlOY1F1WTNzTVpqcnZHcW1xTHB4K1Ba?=
 =?utf-8?B?a3BPdEtpS3pPdDJJV1VBZERtdmtrbDNaOG1hV1ZXYldBZHdjajVoeEtiSzNV?=
 =?utf-8?B?TzFtTnFESXBkTG85UURuSjFHdGM2WUtrQU5tWUNDS1ZRYnYrTnZqWnBxWFkv?=
 =?utf-8?B?Z1lZWXY2dTA4YXJZdHJjWjBlR2xpR0pGbDdOT25EWUNENG1jMWkxY0g5b0Ix?=
 =?utf-8?Q?BEW96zLQ2EQE6I6DjVWvGCcJLwPJZ5LBZILdeTe?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb0e74d-cb5d-41cc-8c5a-08d97e570ce2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 05:57:39.5503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3w9ezwBgLHlLGfjH1fv3IG0t2uuAUcWg/6GnD1ajBDaBhuauNTPqejI1+znU5vF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2900
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/15 15:17, Qu Wenruo wrote:
> The helper btrfs_bio_alloc() is almost the same as btrfs_io_bio_alloc(),
> except it's allocating using BIO_MAX_VECS as @nr_iovecs, and initialize
> bio->bi_iter.bi_sector.
> 
> However the naming itself is not using "btrfs_io_bio" to indicate its
> parameter is "strcut btrfs_io_bio" and can be easily confused with
> "struct btrfs_bio".
> 
> Considering assigned bio->bi_iter.bi_sector is such a simple work and
> there are already tons of call sites doing that manually, there is no
> need to do that in a helper.
> 
> Remove btrfs_bio_alloc() helper, and enhance btrfs_io_bio_alloc()
> function to provide a fail-safe value for its @nr_iovecs.
> 
> And then replace all btrfs_bio_alloc() callers with
> btrfs_io_bio_alloc().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/compression.c | 12 ++++++++----
>   fs/btrfs/extent_io.c   | 33 +++++++++++++++------------------
>   fs/btrfs/extent_io.h   |  1 -
>   3 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 7869ad12bc6e..2475dc0b1c22 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -418,7 +418,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   	cb->orig_bio = NULL;
>   	cb->nr_pages = nr_pages;
>   
> -	bio = btrfs_bio_alloc(first_byte);
> +	bio = btrfs_io_bio_alloc(0);
> +	bio->bi_iter.bi_sector = first_byte >> SECTOR_SHIFT;
>   	bio->bi_opf = bio_op | write_flags;
>   	bio->bi_private = cb;
>   	bio->bi_end_io = end_compressed_bio_write;
> @@ -490,7 +491,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   				bio_endio(bio);
>   			}
>   
> -			bio = btrfs_bio_alloc(first_byte);
> +			bio = btrfs_io_bio_alloc(0);
> +			bio->bi_iter.bi_sector = first_byte >> SECTOR_SHIFT;
>   			bio->bi_opf = bio_op | write_flags;
>   			bio->bi_private = cb;
>   			bio->bi_end_io = end_compressed_bio_write;
> @@ -748,7 +750,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>   	/* include any pages we added in add_ra-bio_pages */
>   	cb->len = bio->bi_iter.bi_size;
>   
> -	comp_bio = btrfs_bio_alloc(cur_disk_byte);
> +	comp_bio = btrfs_io_bio_alloc(0);
> +	comp_bio->bi_iter.bi_sector = cur_disk_byte >> SECTOR_SHIFT;
>   	comp_bio->bi_opf = REQ_OP_READ;
>   	comp_bio->bi_private = cb;
>   	comp_bio->bi_end_io = end_compressed_bio_read;
> @@ -806,7 +809,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>   				bio_endio(comp_bio);
>   			}
>   
> -			comp_bio = btrfs_bio_alloc(cur_disk_byte);
> +			comp_bio = btrfs_io_bio_alloc(0);
> +			comp_bio->bi_iter.bi_sector = cur_disk_byte >> SECTOR_SHIFT;
>   			comp_bio->bi_opf = REQ_OP_READ;
>   			comp_bio->bi_private = cb;
>   			comp_bio->bi_end_io = end_compressed_bio_read;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1aed03ef5f49..d3fcf7e8dc48 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3121,16 +3121,22 @@ static inline void btrfs_io_bio_init(struct btrfs_io_bio *btrfs_bio)
>   }
>   
>   /*
> - * The following helpers allocate a bio. As it's backed by a bioset, it'll
> - * never fail.  We're returning a bio right now but you can call btrfs_io_bio
> - * for the appropriate container_of magic
> + * Allocate a btrfs_io_bio, with @nr_iovecs as maximum iovecs.
> + *
> + * If @nr_iovecs is 0, it will use BIO_MAX_VECS as @nr_iovces instead.
> + * This behavior is to provide a fail-safe default value.
> + *
> + * This helper uses bioset to allocate the bio, thus it's backed by mempool,
> + * and should not fail from process contexts.
>    */
> -struct bio *btrfs_bio_alloc(u64 first_byte)
> +struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs)
>   {
>   	struct bio *bio;
>   
> -	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_VECS, &btrfs_bioset);
> -	bio->bi_iter.bi_sector = first_byte >> 9;

I'm very surprised that, bbio->logical is not initialized here.

This means, except two call sites which manually initialize 
bbio->logical, all other sites don't have bbio->logical set from the 
very beginning.

I guess I need another patch to set the logical bytenr for all btrfs_bio 
allocator.

Thankfully it doesn't cause any new regression, but any unitizlied 
member can always cause unexpected behavior when new use cases are added.

In fact this uninitialized @logical is already cause my RFC patchset 
("btrfs: refactor how we handle btrfs_io_context and slightly reduce 
memory usage for both btrfs_bio and btrfs_io_context") to crash.

As in that patchset, we require bbio->logical to lookup the mirror device.

I'll merge the proper initializer into the next version of that patchset.

Thanks,
Qu

> +	ASSERT(nr_iovecs <= BIO_MAX_VECS);
> +	if (nr_iovecs == 0)
> +		nr_iovecs = BIO_MAX_VECS;
> +	bio = bio_alloc_bioset(GFP_NOFS, nr_iovecs, &btrfs_bioset);
>   	btrfs_io_bio_init(btrfs_io_bio(bio));
>   	return bio;
>   }
> @@ -3148,16 +3154,6 @@ struct bio *btrfs_bio_clone(struct bio *bio)
>   	return new;
>   }
>   
> -struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs)
> -{
> -	struct bio *bio;
> -
> -	/* Bio allocation backed by a bioset does not fail */
> -	bio = bio_alloc_bioset(GFP_NOFS, nr_iovecs, &btrfs_bioset);
> -	btrfs_io_bio_init(btrfs_io_bio(bio));
> -	return bio;
> -}
> -
>   struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
>   {
>   	struct bio *bio;
> @@ -3307,14 +3303,15 @@ static int alloc_new_bio(struct btrfs_inode *inode,
>   	struct bio *bio;
>   	int ret;
>   
> +	bio = btrfs_io_bio_alloc(0);
>   	/*
>   	 * For compressed page range, its disk_bytenr is always @disk_bytenr
>   	 * passed in, no matter if we have added any range into previous bio.
>   	 */
>   	if (bio_flags & EXTENT_BIO_COMPRESSED)
> -		bio = btrfs_bio_alloc(disk_bytenr);
> +		bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
>   	else
> -		bio = btrfs_bio_alloc(disk_bytenr + offset);
> +		bio->bi_iter.bi_sector = (disk_bytenr + offset) >> SECTOR_SHIFT;
>   	bio_ctrl->bio = bio;
>   	bio_ctrl->bio_flags = bio_flags;
>   	bio->bi_end_io = end_io_func;
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index ba471f2063a7..81fa68eaa699 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -278,7 +278,6 @@ void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end);
>   void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
>   				  struct page *locked_page,
>   				  u32 bits_to_clear, unsigned long page_ops);
> -struct bio *btrfs_bio_alloc(u64 first_byte);
>   struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs);
>   struct bio *btrfs_bio_clone(struct bio *bio);
>   struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
> 

