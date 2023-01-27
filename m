Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33BA67EF55
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 21:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjA0ULW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 15:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjA0UK6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 15:10:58 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93D04996F
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 12:10:34 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A55A95C0353;
        Fri, 27 Jan 2023 15:10:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 27 Jan 2023 15:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674850232; x=1674936632; bh=Yf9Sah/03Z
        egx19oRF/Krg9uu656PbVENq4kiGe8EjQ=; b=n7fBh6GSV2f6q3qZbXKa69fbem
        i4cPy/WTBIHhJUm1yTnzFvJJoDq42yRZSBoRtmvrB/crt//CcXQE74PuJ+YaeVun
        FTR3NvHJlj/oyntQbCBYlGvYePjP3QqKNzsNEmshOJMJRGMPNyQ73Byw5zQryR9N
        uh0eHnpGu+YJO0iwpPC2p+jWDtswK6YPXeZ10A9oUnl/qHt+oLYB1GZ7AURln4Ym
        mpo5JeuBus5DlzrCpcN9M9hqC/KQUxzn2SgZ4DS9b6poSWMM7869f0G0HG6CVY2d
        4gM2m1cozp+NBWQEojU8erP2H7nK8kfZjHyYU4RDeQz0IiP8YgDhrRR9CAng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674850232; x=1674936632; bh=Yf9Sah/03Zegx19oRF/Krg9uu656
        PbVENq4kiGe8EjQ=; b=Uo01/Rp5HmRfy0K2kymURy1NQUpJZmodDOV8yt1EqkBg
        XDV8qw+RYI4EYoPd+6+nJOp+4noDNN29AMArZQeNqS4+FTA6MAdN9F6Q5iejEFtT
        mhGkrscUJJCKxy6mOKfAA1jov5TaSPIHuLV1y6cNInbWEs96vKW4tlZJhWOGhN0y
        HCagj6qyX27d6rWgsiL47sbgc5hDUq8jJoWJaWkbxHYkx0b3QAw4/h3RhLajIy2z
        qwUHlFaGULXuowFPVGmFPKlOZMgr+vvYbpSINw9GDi5hVm81kU9Ne3n5CB9i7qkb
        IJ/g6XbbFcjCXyXFXHO75uFbU6avSis5m2DwQb/BOg==
X-ME-Sender: <xms:uC_UYywoQP815rcaB_gDCf-IfEJCIhK2gSRWWyirA-5raJPt6WRvZQ>
    <xme:uC_UY-S-7so3u9dUGui_ga30PEDsE9ut-VfWX50NjZQdxasbESrgpp4cmP4xGgadn
    MQStBfZ16Qn9tAzp1Q>
X-ME-Received: <xmr:uC_UY0V3uJBj9jKAdzPaL9FPMGXX8-SmL_l19lBQIxJYwhZePymA-EYG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddviedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:uC_UY4gyMmgID4UEzo_1h8naZLmIHTlftlq828RhaiPo_hReq7LkoA>
    <xmx:uC_UY0B4aTiQVe_d9uewfnkZyc9PAkL1v7MBS6UoD2veEZ6QZ3weCA>
    <xmx:uC_UY5JP2KLpr_u7Y81vvFVEQN7T7f1oHkMDy4949uFfss11xbzAWQ>
    <xmx:uC_UY_pXIXpiskZmozcNoCb6uIoDejy6I1JtQdVpsPyw2i2SqrbVgg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jan 2023 15:10:32 -0500 (EST)
Date:   Fri, 27 Jan 2023 12:10:30 -0800
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: handle missing chunk mapping more gracefully
Message-ID: <Y9QvpElwgi5+bjCv@zen>
References: <7ff90508841683ca3aaeb5c84e27d7d823218146.1670389796.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ff90508841683ca3aaeb5c84e27d7d823218146.1670389796.git.wqu@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 07, 2022 at 01:09:59PM +0800, Qu Wenruo wrote:
> [BUG]
> During my scrub rework, I did a stupid thing like this:
> 
>         bio->bi_iter.bi_sector = stripe->logical;
>         btrfs_submit_bio(fs_info, bio, stripe->mirror_num);
> 
> Above bi_sector assignment is using logical address directly, which
> lacks ">> SECTOR_SHIFT".
> 
> This results a read on a range which has no chunk mapping.
> 
> This results the following crash:
> 
>  BTRFS critical (device dm-1): unable to find logical 11274289152 length 65536
>  assertion failed: !IS_ERR(em), in fs/btrfs/volumes.c:6387
>  ------------[ cut here ]------------
> 
> Sure this is all my fault, but this shows a possible problem in real
> world, that some bitflip in file extents/tree block can point to
> unmapped ranges, and trigger above ASSERT().
> 
> [PROBLEMS]
> In above call chain, there are 2 locations not properly handling the
> errors:
> 
> - __btrfs_map_block()
>   If btrfs_get_chunk_map() returned error, we just trigger an ASSERT().
> 
> - btrfs_submit_bio()
>   If the returned mapped length is smaller than expected, we just BUG().
> 
> [FIX]
> This patch will fix the problems by:
> 
> - Add extra WARN_ON() if btrfs_get_chunk_map() failed
>   I know syzbot will complain, but it's better noisy for fstests.
> 
> - Replace the ASSERT()
>   By returning the error.
> 
> - Handle the error when mapped length is smaller than expected length
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Looks good to me, you can add
Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/bio.c     | 6 +++++-
>  fs/btrfs/volumes.c | 5 ++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index b8fb7ef6b520..8f7b56a0290f 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -246,7 +246,11 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
>  		btrfs_crit(fs_info,
>  			   "mapping failed logical %llu bio len %llu len %llu",
>  			   logical, length, map_length);

nit: for these WARN_ON(1)s, how about changing them from
if (cond) {
        btrfs_crit(<msg>);
        WARN_ON(1);
        <return error>;
}

to

if (WARN_ON(<cond>)) {
        btrfs_crit(<msg>);
	<return err>
}

> -		BUG();
> +		WARN_ON(1);
> +		ret = -EINVAL;
> +		btrfs_bio_counter_dec(fs_info);
> +		btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
> +		return;
>  	}
>  
>  	if (!bioc) {
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index aa25fa335d3e..f69475fb1bc1 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3012,6 +3012,7 @@ struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
>  	if (!em) {
>  		btrfs_crit(fs_info, "unable to find logical %llu length %llu",
>  			   logical, length);
> +		WARN_ON(1);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> @@ -3020,6 +3021,7 @@ struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
>  			   "found a bad mapping, wanted %llu-%llu, found %llu-%llu",
>  			   logical, length, em->start, em->start + em->len);
>  		free_extent_map(em);
> +		WARN_ON(1);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> @@ -6384,7 +6386,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>  	ASSERT(op != BTRFS_MAP_DISCARD);
>  
>  	em = btrfs_get_chunk_map(fs_info, logical, *length);
> -	ASSERT(!IS_ERR(em));
> +	if (IS_ERR(em))
> +		return PTR_ERR(em);
>  
>  	ret = btrfs_get_io_geometry(fs_info, em, op, logical, &geom);
>  	if (ret < 0)
> -- 
> 2.38.1
