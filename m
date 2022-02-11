Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C57D4B306D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 23:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbiBKW2S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 17:28:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbiBKW2Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 17:28:16 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EE5D51
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 14:28:13 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 49E245C01A0;
        Fri, 11 Feb 2022 17:28:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 11 Feb 2022 17:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=y7tvgdnPlFPloXX/T9v8234Xg569DOcd6+TxTy
        PCc4A=; b=UR7i+VTC76Ye1+W/S0C9TTf8Z+C7Ro+yQnzipMZmLnau5fyUsOYD4L
        Q8J/0qTT61I0vCeQn65G2d0dw+vuTL0+jdLuQVIn5GcJnf0P67hwm+YQezvZj5vG
        /l3eWVDj2oboAYfAE1s5zdOWSFoOAJvChA/JzhFog6wT22dC9iboAreCrR8AZPOb
        BEgFsiPMZwWWUxmyL48G184vSOFNixTIDOpzcW9CVwoZ5ZLHYK70jYztq7FfLPQr
        YbOsxWFCdK6ni5mvI3CwyQMqqd8FEtuuGTC2dfgVg1W//YP2ENpuyatduxk0dSix
        q7IEcQSXAJGZk3hkXB/1hScRgTKKhJCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=y7tvgdnPlFPloXX/T
        9v8234Xg569DOcd6+TxTyPCc4A=; b=Ulwgnlt4nWI59O6oVniPfh1WkKdhjpmDn
        wN1NpEcf2hq+IyTo/wPcemuy+h3xUYlzKJAO3Jopdp1wFodq60H4dp+TyBK8QqQT
        AnFTW2KXNf0IClRbnzDkAH22ap/uo3PjrSTdTEIuEelbKF20e4Xrf0Q2P7UkVoHJ
        C7OnHCgIkB5NhjH33jwdpxFpFjoepb6W0tRoTcVDsIN/kmkybbNrjKR6RW/Lieei
        4Fu1CuUkTt3dkmPOWMHtNjMxIyeVP78vo9G82unmBE8zsgCUYm1KFJihsOSzRaJu
        Creg8jSnPGB753n7RtKfmjwQtZRMiwwr4y200+dXLLqDQyUgAZmrg==
X-ME-Sender: <xms:_OIGYhhbXwiSWNTCiiO8Ldj7p_kKNa5DkoWG2g4kYEDoOYrE1kg3mQ>
    <xme:_OIGYmB1h0405YkGJa3c3ldjRDFgtJvDxQsDLj5jNs_L4hU5Aj-ivKrhUV08i_xCX
    hpMlOsl-rhIJUr9bGc>
X-ME-Received: <xmr:_OIGYhGSAY9--Zb5uYi-fNNXW7bR18QYt50u4v8rU6-gjLARlJqCuN85bjABXz98Zmk1DMtz-9A9_hJGYqkHtdLmNc1H-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieefgdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephe
    duveelkeeiteelveeiuefhudehtdeigfehkeeffeegledvueevgefgudeuveefnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:_OIGYmTjdffJFGjOmsihaALMNNFQ2F6VtbQi5TLBlON_GPdR1A7TyA>
    <xmx:_OIGYuxt8dsNYiB0nElbujAA3gcK1bJeczcVQOP6vQ_HYpoQEX0zLg>
    <xmx:_OIGYs5xBA2orhZJR5Hd4YR4MEheoc1i5pGnLlmvlwjGULY-DoVOxQ>
    <xmx:_OIGYjp3ODMjteC6E6G42BaRDcmFTKDFmGpZnCtCAdZM-eQq8Iplag>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 17:28:11 -0500 (EST)
Date:   Fri, 11 Feb 2022 14:28:10 -0800
From:   Boris Burkov <boris@bur.io>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/8] btrfs: handle csum lookup errors properly on reads
Message-ID: <Ygbi+r6iBCDJ9X4b@zen>
References: <cover.1644532798.git.josef@toxicpanda.com>
 <9aa5cdf08820eeb53feb0457bc6994231a7ff9fd.1644532798.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9aa5cdf08820eeb53feb0457bc6994231a7ff9fd.1644532798.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 10, 2022 at 05:44:20PM -0500, Josef Bacik wrote:
> Currently any error we get while trying to lookup csums during reads
> shows up as a missing csum, and then on the read completion side we spit
> out an error saying there was a csum mismatch and we increase the device
> corruption count.
> 
> However we could have gotten an EIO from the lookup.  We could also be
> inside of a memory constrained container and gotten a ENOMEM while
> trying to do the read.  In either case we don't want to make this look
> like a file system corruption problem, we want to make it look like the
> actual error it is.  Capture any negative value, convert it to the
> appropriate blk_sts_t, free the csum array if we have one and bail.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/file-item.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index efb24cc0b083..e68be492109d 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -368,6 +368,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
> +	struct btrfs_bio *bbio = NULL;
>  	struct btrfs_path *path;
>  	const u32 sectorsize = fs_info->sectorsize;
>  	const u32 csum_size = fs_info->csum_size;
> @@ -377,6 +378,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
>  	u8 *csum;
>  	const unsigned int nblocks = orig_len >> fs_info->sectorsize_bits;
>  	int count = 0;
> +	blk_status_t ret = BLK_STS_OK;
>  
>  	if ((BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM) ||
>  	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state))
> @@ -400,7 +402,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
>  		return BLK_STS_RESOURCE;
>  
>  	if (!dst) {
> -		struct btrfs_bio *bbio = btrfs_bio(bio);
> +		bbio = btrfs_bio(bio);
>  
>  		if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
>  			bbio->csum = kmalloc_array(nblocks, csum_size, GFP_NOFS);
> @@ -456,6 +458,13 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
>  
>  		count = search_csum_tree(fs_info, path, cur_disk_bytenr,
>  					 search_len, csum_dst);
> +		if (count < 0) {
> +			ret = errno_to_blk_status(count);
> +			if (bbio)
> +				btrfs_bio_free_csum(bbio);
> +			break;
> +		}
> +
>  		if (count <= 0) {

This new error handling doesn't quite mesh with the existing logic, IMO.

1) count <= 0 is redundant with count < 0 above and it's confusing to
think about whether this code runs for count < 0.

2) it really is not running the nodatacow thing for the reloc inodes for
negative return values anymore. Is that desirable? I found the original
commit about it:
'Btrfs: fix nodatasum handling in balancing code'
and it looks like that one cared about the 0 case, not the negative
case, but that's not what the logic or comment suggest as they are.

I think if you switch it to explicitly:
< 0 -> error; run the new bail code.
== 0 -> not found; deal with reloc, warn otherwise.
and make a single comment covering it, then it would make sense to me.

>  			/*
>  			 * Either we hit a critical error or we didn't find
> @@ -491,7 +500,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
>  	}
>  
>  	btrfs_free_path(path);
> -	return BLK_STS_OK;
> +	return ret;
>  }
>  
>  int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
> -- 
> 2.26.3
> 
