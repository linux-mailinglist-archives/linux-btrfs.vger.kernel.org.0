Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F3E7DFAA8
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 20:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377382AbjKBTGd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 15:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377368AbjKBTGb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 15:06:31 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2611AD68
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 12:06:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 4BA4B5C0176;
        Thu,  2 Nov 2023 15:05:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 02 Nov 2023 15:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1698951959; x=1699038359; bh=Ha
        Or9qiy9H2cZMI2EkeNSIevNe0ysszfATLrMA4M95o=; b=gW12UV55UnkqXEgy4Y
        XBOzNM62HWXyIdQCbcVIG4pszPMH8fNymlLkZsyfinBA+8YSPSbMQdSGukApnQNI
        PGhcq701tgGYmS+HfRCNhxUnfL2a+7+ZiUE9RY3Jc5jc3yZhkIIyYo8FWrOCApv5
        lvE67w1Rr1NWppYgK9TqZ8kvhjyZZOTfAzfeHpREQnZ/GUfQHqRhJP85p5nESRBt
        HH8QwOZ+yMM7X3B9P3vwINDgFuibZZFUqA3rzj6izbNUi3LUsYv0RFIPczUCBNtT
        aLsQTpWzN5yv2aKCAOqaP9WjwSiJ2vxDJO5yAorHQJnvrWG51hB2DrB8F+GhjuQc
        n0jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698951959; x=1699038359; bh=HaOr9qiy9H2cZ
        MI2EkeNSIevNe0ysszfATLrMA4M95o=; b=LBkauN0o8kPLO4mt0hcD5ZW/ZvgJV
        8ABREp/JEPfbme3v55y9RhdLfqTocw711+Sq0fjfwNrqGqiQl568B4MM79YSqWdN
        CrD4OJXW2lZmixJJYMp/NFqSZ6bhomG6GfBVmSEQRsUtQ6RT/Nd9KYwuiotW/qTN
        i4td2vPB9uIIEOw94WfBDSGZXQHoXOGhTIMHy0VY0AQHXQXNl8e2CvQpKYpJSIxJ
        RnuFBphR99FaziOUdPmJ7MIZEk/1mRJx1TUY6dtecns7iildk+CGAO6VvuUcka8g
        JWp4G1D81Kwc5vBm6cvrI6vNbUqsyEWC0ChSKOaA9t7It9SOjfYspmiWQ==
X-ME-Sender: <xms:FvNDZQ9AyVvsT2X2nSdE0JsSsTqI9WeY73HXjzCbAodjxvRNv6uiBQ>
    <xme:FvNDZYvcBzzWcuQ1IVP1v8WhXkRmdRYw2fDQ2jz9wmHAfk8i2unn8EcvvpXgs5sGD
    0l63xE4gY4923H56_I>
X-ME-Received: <xmr:FvNDZWAhAnET2MBx9mgrSsVOWJ2trjRrkWsLnDM3kKvKcxUOCBQh5KttGvCtj3UqeqRIU_me67EbX6UpCkqmPZYj4T4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtiedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epleffgeevgeetueegledtueeluddtudekhefhudeuheegfeevieehteevieejueetnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:F_NDZQfiR1Fs9RytGmyuNnDe1poigRNLPgHhdHEnk31wL7y6onADVA>
    <xmx:F_NDZVNLZd3FTBMUBCu9mX_X76Pue0uBjYiz72NvkRNtmPFUhP239g>
    <xmx:F_NDZalAODENne8eYd01jeHQq_XS7YDZUUoflo8Qw_-KJrWE4L1gRQ>
    <xmx:F_NDZXUKLn8OWKmCaKZMAPxAuFyF_0KdBMFEeLfeOn38gVP6X64ySA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Nov 2023 15:05:58 -0400 (EDT)
Date:   Thu, 2 Nov 2023 12:07:20 -0700
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tree-checker: add type and sequence check for
 inline backrefs
Message-ID: <20231102190720.GA113907@zen.localdomain>
References: <23fbab97bd9dbce7869e858cb59d96a7238db57e.1698105469.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23fbab97bd9dbce7869e858cb59d96a7238db57e.1698105469.git.wqu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 24, 2023 at 12:41:11PM +1030, Qu Wenruo wrote:
> [BUG]
> There is a bug report that ntfs2btrfs had a bug that it can lead to
> transaction abort and the filesystem flips to read-only.
> 
> [CAUSE]
> For inline backref items, kernel has a strict requirement for their
> ordered, they must follow the following rules:
> 
> - All btrfs_extent_inline_ref::type should be in an ascending order
> 
> - Within the same type, the items should follow a descending order by
>   their sequence number
> 
>   For EXTENT_DATA_REF type, the sequence number is result from
>   hash_extent_data_ref().
>   For other types, their sequence numbers are
>   btrfs_extent_inline_ref::offset.
> 
> Thus if there is any code not following above rules, the resulted
> inline backrefs can prevent the kernel to locate the needed inline
> backref and lead to transaction abort.
> 
> [FIX]
> Ntrfs2btrfs has already fixed the problem, and btrfs-progs has added the
> ability to detect such problems.
> 
> For kernel, let's be more noisy and be more specific about the order, so
> that the next time kernel hits such problem we would reject it in the
> first place, without leading to transaction abort.
> 
> Link: https://github.com/kdave/btrfs-progs/pull/622
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/tree-checker.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index a416cbea75d1..981ad301d29d 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -31,6 +31,7 @@
>  #include "inode-item.h"
>  #include "dir-item.h"
>  #include "raid-stripe-tree.h"
> +#include "extent-tree.h"
>  
>  /*
>   * Error message should follow the following format:
> @@ -1276,6 +1277,8 @@ static int check_extent_item(struct extent_buffer *leaf,
>  	unsigned long ptr;	/* Current pointer inside inline refs */
>  	unsigned long end;	/* Extent item end */
>  	const u32 item_size = btrfs_item_size(leaf, slot);
> +	u8 last_type = 0;
> +	u64 last_seq = U64_MAX;
>  	u64 flags;
>  	u64 generation;
>  	u64 total_refs;		/* Total refs in btrfs_extent_item */
> @@ -1322,6 +1325,17 @@ static int check_extent_item(struct extent_buffer *leaf,
>  	 *    2.2) Ref type specific data
>  	 *         Either using btrfs_extent_inline_ref::offset, or specific
>  	 *         data structure.
> +	 *    All above inline items should follow the order:
> +	 *
> +	 *    - All btrfs_extent_inline_ref::type should be in an ascending
> +	 *      order
> +	 *
> +	 *    - Within the same type, the items should follow a descending
> +	 *      order by their sequence number
> +	 *      The sequence number is determined by:
> +	 *      * btrfs_extent_inline_ref::offset for all types  other than
> +	 *        EXTENT_DATA_REF
> +	 *      * hash_extent_data_ref() for EXTENT_DATA_REF
>  	 */
>  	if (unlikely(item_size < sizeof(*ei))) {
>  		extent_err(leaf, slot,
> @@ -1403,6 +1417,7 @@ static int check_extent_item(struct extent_buffer *leaf,
>  		struct btrfs_extent_inline_ref *iref;
>  		struct btrfs_extent_data_ref *dref;
>  		struct btrfs_shared_data_ref *sref;
> +		u64 seq;
>  		u64 dref_offset;
>  		u64 inline_offset;
>  		u8 inline_type;
> @@ -1416,6 +1431,7 @@ static int check_extent_item(struct extent_buffer *leaf,
>  		iref = (struct btrfs_extent_inline_ref *)ptr;
>  		inline_type = btrfs_extent_inline_ref_type(leaf, iref);
>  		inline_offset = btrfs_extent_inline_ref_offset(leaf, iref);
> +		seq = inline_offset;
>  		if (unlikely(ptr + btrfs_extent_inline_ref_size(inline_type) > end)) {
>  			extent_err(leaf, slot,
>  "inline ref item overflows extent item, ptr %lu iref size %u end %lu",
> @@ -1446,6 +1462,10 @@ static int check_extent_item(struct extent_buffer *leaf,
>  		case BTRFS_EXTENT_DATA_REF_KEY:
>  			dref = (struct btrfs_extent_data_ref *)(&iref->offset);
>  			dref_offset = btrfs_extent_data_ref_offset(leaf, dref);
> +			seq = hash_extent_data_ref(
> +					btrfs_extent_data_ref_root(leaf, dref),
> +					btrfs_extent_data_ref_objectid(leaf, dref),
> +					btrfs_extent_data_ref_offset(leaf, dref));
>  			if (unlikely(!IS_ALIGNED(dref_offset,
>  						 fs_info->sectorsize))) {
>  				extent_err(leaf, slot,
> @@ -1475,6 +1495,24 @@ static int check_extent_item(struct extent_buffer *leaf,
>  				   inline_type);
>  			return -EUCLEAN;
>  		}
> +		if (inline_type < last_type) {
> +			extent_err(leaf, slot,
> +				   "inline ref out-of-order: has type %u, prev type %u",
> +				   inline_type, last_type);
> +			return -EUCLEAN;
> +		}
> +		/* Type changed, allow the sequence starts from U64_MAX again. */
> +		if (inline_type > last_type)
> +			last_seq = U64_MAX;
> +		if (seq > last_seq) {
> +			extent_err(leaf, slot,
> +"inline ref out-of-order: has type %u offset %llu seq 0x%llx, prev type %u seq 0x%llx",
> +				   inline_type, inline_offset, seq,
> +				   last_type, last_seq);
> +			return -EUCLEAN;
> +		}
> +		last_type = inline_type;
> +		last_seq = seq;
>  		ptr += btrfs_extent_inline_ref_size(inline_type);
>  	}
>  	/* No padding is allowed */
> -- 
> 2.42.0
> 

I believe this breaks simple quotas EXTENT_OWNER_REF_KEY items which
have type 188 but come in before the other inline items.

For a repro, btrfs/301 (available in the master fstests branch) fails
with the patch but passes without it.
