Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22914B3111
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 23:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiBKWy1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 17:54:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiBKWy1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 17:54:27 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE3DC63
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 14:54:24 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 473185C0120;
        Fri, 11 Feb 2022 17:54:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 11 Feb 2022 17:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=3lV7RC3LktyGDjXXBXYYldaBV0fume72jWZDZG
        /Bjpo=; b=x+ivgoFjqOrk0uT7ePGZHh6coeJ5hKXn2UuhVF+qBmO+vpU/mGZ4k1
        Imq5H+xso1uqlSWpr8r1CUZ3lmgPtY4QTjtYjRiu5fOhr+Jrx08eNyth7JpAJLgx
        0vBxuJpEraX6sA8jv+dBO7moHdZycAbVIWKB8xXox8HsdFnnkidMBTvNEkrZ2TBF
        beUUH1ZFoYtRQwfhsbWTsrNKkyiT0tK4SWuMLq6ZaL+CFWKWHD0YOkquj5bXmHEI
        6eku2ph8yJ7zFmZwD5J+66qda/YJQtMYTRYOYQcw+6AJQC64i7lA0mNMgkRpMLww
        NQFvYFQiy9xno/0VoqMdTfQQqkR+KWGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3lV7RC3LktyGDjXXB
        XYYldaBV0fume72jWZDZG/Bjpo=; b=hwLYO2cn4SyRAFP8ikXeYlnIxtF6K9m1Y
        r5PPZkZgS/XpzQW1sxGqQW8We8DLQQ8WyY/6k38FqgdsjYpS6YukF/TenUmH/FxX
        igjlAlYZ0JZJZdvvsk1hIn+sVxulF1bj4jw+aw81JDNMTRSkgMbORUQwYsOMLDDr
        xxXMVbLY6fWKBwVB4BH7vvgD5gERaQvwUq9ITIxrO1p9339isy9iEb0DxkMR8O4n
        Ohu0qm5s8LZmTjfpsajDYlwLu2ij3ygONRAoyn6/9T67I4gzUofMTCn8w2NEauTJ
        TFNV5PzVysapbZseZ1P2A2mEU4hHIh0xZEO0t1gE50uq/jft8UaHw==
X-ME-Sender: <xms:IOkGYutBFOBkPrbKPLDhIdsByL2WFyQ779OVfvTYqzPwEM8QNYfnwA>
    <xme:IOkGYjdPc3Jt9sARfvKkJugoo0jF9AalJGVLTjZvyyFNbn-ss6TK_y8MdPvrTUL0S
    -_Oy4AfM6SSqqBIrGg>
X-ME-Received: <xmr:IOkGYpx8WAQLHARyE5msUkTw8yFjQKmTH2mThzJOR7n5d-cOWZGmxAj-sGS6maXYUdssWtkjjt8UqBUL3vzkiLtNu18XAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieeggddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeehud
    evleekieetleevieeuhfduhedtiefgheekfeefgeelvdeuveeggfduueevfeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:IOkGYpOiVMaJhhBi45HCpzuX8UWsUtiswkwqBl_sJkcgzPZWM2mATw>
    <xmx:IOkGYu8O4RE-NCqJLyi5jOoLb2JzlYLe0_C-DjtfdyDPYrh_sbI8bQ>
    <xmx:IOkGYhWyeFfB4oBdaohqE7gwQiDhLT7Xbo4jIQmTPB8u3NKHHQY_dA>
    <xmx:IOkGYklNeAntuUONSYMXMEu3wD1MsMM3Z81meNpvz-oVoxWtoyxpZg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 17:54:23 -0500 (EST)
Date:   Fri, 11 Feb 2022 14:54:22 -0800
From:   Boris Burkov <boris@bur.io>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 6/8] btrfs: do not double complete bio on errors during
 compressed reads
Message-ID: <YgbpHjBvf49gtEbC@zen>
References: <cover.1644532798.git.josef@toxicpanda.com>
 <800ebbe66b4998ec1ac7122cc201c4404d737f18.1644532798.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <800ebbe66b4998ec1ac7122cc201c4404d737f18.1644532798.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 10, 2022 at 05:44:24PM -0500, Josef Bacik wrote:
> I hit some weird panics while fixing up the error handling from
> btrfs_lookup_bio_sums().  Turns out the compression path will complete
> the bio we use if we set up any of the compression bios and then return
> an error, and then btrfs_submit_data_bio() will also call bio_endio() on
> the bio.
> 
> Fix this by making btrfs_submit_compressed_read() responsible for
> calling bio_endio() on the bio if there are any errors.  Currently it
> was only doing it if we created the compression bios, otherwise it was
> depending on btrfs_submit_data_bio() to do the right thing.  This
> creates the above problem, so fix up btrfs_submit_compressed_read() to
> always call bio_endio() in case of an error, and then simply return from
> btrfs_submit_data_bio() if we had to call
> btrfs_submit_compressed_read().
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/compression.c | 14 +++++++++-----
>  fs/btrfs/inode.c       | 12 ++++++++----
>  2 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index ee1c6f870a03..9551658ac3a1 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -808,7 +808,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  	u64 em_len;
>  	u64 em_start;
>  	struct extent_map *em;
> -	blk_status_t ret = BLK_STS_RESOURCE;
> +	blk_status_t ret;
>  	int faili = 0;
>  	u8 *sums;
>  
> @@ -821,9 +821,12 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  	read_lock(&em_tree->lock);
>  	em = lookup_extent_mapping(em_tree, file_offset, fs_info->sectorsize);
>  	read_unlock(&em_tree->lock);
> -	if (!em)
> -		return BLK_STS_IOERR;
> +	if (!em) {
> +		ret = BLK_STS_IOERR;
> +		goto out;
> +	}
>  
> +	ret = BLK_STS_RESOURCE;

I think the error handling logic with all the special exit paths makes
it worthwhile to set ret at each individual 'goto failX'.

>  	ASSERT(em->compress_type != BTRFS_COMPRESS_NONE);
>  	compressed_len = em->block_len;
>  	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
> @@ -858,7 +861,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  		cb->compressed_pages[pg_index] = alloc_page(GFP_NOFS);
>  		if (!cb->compressed_pages[pg_index]) {
>  			faili = pg_index - 1;
> -			ret = BLK_STS_RESOURCE;
>  			goto fail2;
>  		}
>  	}
> @@ -938,7 +940,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  			comp_bio = NULL;
>  		}
>  	}
> -	return 0;
> +	return BLK_STS_OK;
>  
>  fail2:
>  	while (faili >= 0) {
> @@ -951,6 +953,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  	kfree(cb);
>  out:
>  	free_extent_map(em);
> +	bio->bi_status = ret;
> +	bio_endio(bio);
>  	return ret;
>  finish_cb:
>  	if (comp_bio) {
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 24099fe9e120..69fa71186e72 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2542,10 +2542,14 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
>  			goto out;
>  
>  		if (bio_flags & EXTENT_BIO_COMPRESSED) {
> -			ret = btrfs_submit_compressed_read(inode, bio,
> -							   mirror_num,
> -							   bio_flags);
> -			goto out;
> +			/*
> +			 * btrfs_submit_compressed_read will handle completing
> +			 * the bio if there were any errors, so just return
> +			 * here.
> +			 */
> +			return btrfs_submit_compressed_read(inode, bio,
> +							    mirror_num,
> +							    bio_flags);
>  		} else {
>  			/*
>  			 * Lookup bio sums does extra checks around whether we
> -- 
> 2.26.3
> 
