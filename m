Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16435693E89
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 07:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBMG5Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 01:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjBMG5O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 01:57:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE63113FB
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Feb 2023 22:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=yVr4dWUB/8SOry8twelL1x6PQfIhHQvHQLRZrcDmKRA=; b=NXIW+yq3txDlROsYbi1bgonal0
        p5FtnGVfRF88c+4oNxoZ6IW5tizJPlxKa7Guk5Yta2RghcTn0OeI38hxwrL4vCmqpmzB3IDbPsueF
        dYbaG8yGnaGtOBWTzYSO27NKIo6cfGCKWS7St0pHB+8nOT4Gpv7iORmA97VuK6jqUibn5LQZv2T+1
        MRukTlNU01L1oqOgv0SqngN2x4/G+nAnWSqvKGIvwksR+ha7L1fJbszTi0ygbFuDRBKi4I9Rbo6QU
        rRvStgGleSbZapOF3AUPUspHY1kXK5XAfR1HgFDPsp/vEkYYjgdifxl1KskcWOyOFPNJrwz3VRRzJ
        5txL1ftA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRSm1-00DOZe-1j; Mon, 13 Feb 2023 06:57:13 +0000
Date:   Sun, 12 Feb 2023 22:57:13 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 04/13] btrfs: add support for inserting raid stripe
 extents
Message-ID: <Y+nfSQ6fxhDooglb@infradead.org>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <96f86c817184925f3d1e625d735058373d90e757.1675853489.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96f86c817184925f3d1e625d735058373d90e757.1675853489.git.johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -58,6 +58,8 @@ struct btrfs_bio {
>  	atomic_t pending_ios;
>  	struct work_struct end_io_work;
>  
> +	struct work_struct raid_stripe_work;

You should be able to reused end_io_work here, as it is only used
for reads currently.

>  
> +static bool delayed_ref_needs_rst_update(struct btrfs_fs_info *fs_info,
> +					 struct btrfs_delayed_ref_head *head)
> +{
> +	struct extent_map *em;
> +	struct map_lookup *map;
> +	bool ret = false;
> +
> +	if (!btrfs_stripe_tree_root(fs_info))
> +		return ret;
> +
> +	em = btrfs_get_chunk_map(fs_info, head->bytenr, head->num_bytes);
> +	if (!em)
> +		return ret;
> +
> +	map = em->map_lookup;
> +
> +	if (btrfs_need_stripe_tree_update(fs_info, map->type))

This just seems very expensive.  Is there no way to propafate
this information without doign a chunk map lookup every time?

> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1687,6 +1687,10 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
>  	u64 *logical = NULL;
>  	int nr, stripe_len;
>  
> +	/* Filesystems with a stripe tree have their own l2p mapping */
> +	if (btrfs_stripe_tree_root(fs_info))
> +		return;

I don't think we should even be able to readch this, as the call to
btrfs_rewrite_logical_zoned is guarded by having a valid
ordered->physical… and that is only set in btrfs_simple_end_io.
So this could just be an assert.

