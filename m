Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BE7485B60
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 23:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244742AbiAEWLi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 17:11:38 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58123 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244755AbiAEWKj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 17:10:39 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A3515C019B;
        Wed,  5 Jan 2022 17:10:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 05 Jan 2022 17:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=S8eO72u6xqHcufS9xv6OLzz+P6s
        qdBx8kaenKpq8WNU=; b=03yXLG0FYYzYWeaQR/4ZzzX/+5GYiyG3jufcVhS3N6S
        mg7VWJUcwiw+08FGV49M6rcGdQKQno0PmnEdPOTrB6aD2zLs/U31D+2ggYWv/jKZ
        IDdu+LRQW8gXeHwzQ0Kg6kGb8LhkGcI6sh8OHFvBQVKVJj9QYzpA/2OGu4UzUrhO
        SJQK6So70L+1D1z9G58LlwRzPyQu3rrxtg/whnVxStXb9TtdB4VVWYHLJTaKfKAn
        UaLnsWbxa613Z9h4E58UBCD7yGbw/OhxND0BaZqysUnJuOE1LlZseK1stqYdcAsI
        R1dmVoHYgwL9oDhoY6RXJ3T5OEmTy5wklHn1tx2ruDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=S8eO72
        u6xqHcufS9xv6OLzz+P6sqdBx8kaenKpq8WNU=; b=dL0HN1QMr3YC2GbaYgZFiS
        lSP+xOaTDDGgaM//0YlxQXvHDdyIeEci7RyZuj7ASowvhMInRMmwkOABkBJbUK31
        Ix2Wa/doKwGvbi/Pwx4jSxyZJV9ninVM6RsjnMaRrHqu6+7DLlsDzluMr26ho04s
        hh0KaFK6Z9B9v4oIXRgYxbDHsLl3dlhiA2nppGE3w06vrCqeuH9/BH0m48cmhjR8
        x20JnxZo1PxG26PlMviu/kD9VaWyOU3KfhJ4AnXw9AyH7ye5s0pNZ9jMwMRbJ0Yl
        V0INZB0F7PoKcldpkaaVH8Wgb7rUah/yfABNcHqLAfn28pGOfwPFq7iebWAgUS4A
        ==
X-ME-Sender: <xms:XBfWYcDjCFXNGRH16uvZNUSvhZCGRkG8kUg2CGUcYm_dXceeXuk1ow>
    <xme:XBfWYeiUXe41e7cxUW730iw7LE32BaSFiELLn0oc3mR5bH4SsPt3qF6wuMolB19wX
    Piu9rVKvCY5ASUeK9I>
X-ME-Received: <xmr:XBfWYfku4f5glaWsvogpwI8P_mW9_rphn1otsLrreYu9G85zWeO-5STOyduYDngivPPBjy2hoOC_eFz1sP-Js371q7kktw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefjedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephe
    duveelkeeiteelveeiuefhudehtdeigfehkeeffeegledvueevgefgudeuveefnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:XBfWYSwihFYUTRUMEhhW4yk80ILCxJgkSUiLxBNB7Uvf7D6vYNfLiA>
    <xmx:XBfWYRTZyXFgqhS3DrYq2yLjXjc-Mc3jPduc6Ow9kM6jv4BQufWyUA>
    <xmx:XBfWYdYBUMOGjsgrG6D6zGlwfz_6wuFZXZSw8LRheWbqJFJ5ws4buw>
    <xmx:XhfWYQG5dofUpfYSaXoVnZu2J37yBdks_AkPRhJg9vjIk3isEQpqUw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jan 2022 17:10:36 -0500 (EST)
Date:   Wed, 5 Jan 2022 14:10:34 -0800
From:   Boris Burkov <boris@bur.io>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH 1/6] btrfs: add flags to give an hint to the chunk
 allocator
Message-ID: <YdYXWlp+naKtzV+E@zen>
References: <cover.1639766364.git.kreijack@inwind.it>
 <377d6c51cb957fbad5627bb93ff0a76ce9ba79da.1639766364.git.kreijack@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <377d6c51cb957fbad5627bb93ff0a76ce9ba79da.1639766364.git.kreijack@inwind.it>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 17, 2021 at 07:47:17PM +0100, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> Add the following flags to give an hint about which chunk should be
> allocated in which a disk:
> 
> - BTRFS_DEV_ALLOCATION_HINT_PREFERRED_DATA
>   preferred data chunk, but metadata chunk allowed
> - BTRFS_DEV_ALLOCATION_HINT_PREFERRED_METADATA
>   preferred metadata chunk, but data chunk allowed
> - BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY
>   only metadata chunk allowed
> - BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY
>   only data chunk allowed

Weighing in on the naming discussion:

I think DATA_ONLY > ONLY_DATA, with my best argument for this subjective
opinion being that it follows the example of read-only.

Therefore, I think you should go with DATA_ONLY, DATA_PREFERRED,
METADATA_ONLY, METADATA_PREFERRED. Definitely put ONLY/PREFERRED on the
same side of DATA/METADATA for all four, regardless of which you choose.

Looks good otherwise.

> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwid.it>
> ---
>  include/uapi/linux/btrfs_tree.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> index 5416f1f1a77a..55da906c2eac 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -386,6 +386,22 @@ struct btrfs_key {
>  	__u64 offset;
>  } __attribute__ ((__packed__));
>  
> +/* dev_item.type */
> +
> +/* btrfs chunk allocation hint */
> +#define BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT	2
> +/* btrfs chunk allocation hint mask */
> +#define BTRFS_DEV_ALLOCATION_HINT_MASK	\
> +	((1 << BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT) -1)
> +/* preferred data chunk, but metadata chunk allowed */
> +#define BTRFS_DEV_ALLOCATION_HINT_PREFERRED_DATA	(0ULL)
> +/* preferred metadata chunk, but data chunk allowed */
> +#define BTRFS_DEV_ALLOCATION_HINT_PREFERRED_METADATA	(1ULL)
> +/* only metadata chunk are allowed */
> +#define BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY		(2ULL)
> +/* only data chunk allowed */
> +#define BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY		(3ULL)
> +
>  struct btrfs_dev_item {
>  	/* the internal btrfs device id */
>  	__le64 devid;
> -- 
> 2.34.1
> 
