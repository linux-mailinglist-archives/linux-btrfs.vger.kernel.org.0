Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CCD64997A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 08:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiLLHWe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 02:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiLLHWd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 02:22:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ACDB4BB
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Dec 2022 23:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PTng3a7jF/BjMsK8EGviXw5JfnFN2E/6Unz0VIwVM3g=; b=Ls6h5GLqws1HmSIW9jahldyqMI
        SdWWiMKiFm/MiQ88wqQGwftjULRR2wZ5pS82+SpOcIWEu/GmFg67toykNdc/wRmTbk5fSI3tOPmYz
        RUHKiVG1GJVE3IwnS31Het3aIJJ5KfJC+5aVtf0BpCWLTbwa//xinVGXe6E+Xv8xy3qhkXeCyJ2nG
        t46kGMH6nZ1jf4WN4lW97lDmLW3a1mSD+PCt7M94CYlLp/SZEd3wuGuUgjNDlQZapLHsKe9B2eMcC
        MlogYes+FHq5AQzyPV9F7NxuoSkb9fsevgJXBzKL5MZDq23viOSM5H3+RthlCCsYYiq5N2gv/psnN
        14PEKLlg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4d8x-009N4z-Sv; Mon, 12 Dec 2022 07:22:31 +0000
Date:   Sun, 11 Dec 2022 23:22:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v4 3/9] btrfs: add support for inserting raid stripe
 extents
Message-ID: <Y5bWt7ENo2OkKK+v@infradead.org>
References: <cover.1670422590.git.johannes.thumshirn@wdc.com>
 <238cc419b3cbc18c4a93ad7827d33961fafd4196.1670422590.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <238cc419b3cbc18c4a93ad7827d33961fafd4196.1670422590.git.johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 07, 2022 at 06:22:12AM -0800, Johannes Thumshirn wrote:
> @@ -372,6 +388,15 @@ static void btrfs_orig_write_end_io(struct bio *bio)
>  	else
>  		bio->bi_status = BLK_STS_OK;
>  
> +	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
> +		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
> +
> +	if (btrfs_need_stripe_tree_update(bioc->fs_info, bioc->map_type)) {
> +		INIT_WORK(&bbio->raid_stripe_work, btrfs_raid_stripe_update);
> +		schedule_work(&bbio->raid_stripe_work);

This needs to be on a specific workqueue (or maybe multiple if/when
metadata and freespace inodes are supported).  Note that end_io_work
isn't currently used for writes, so you can reuse it here.

Also note that I do hav a patchset that defers all writes to a workqueue
here instead of doing separate deferals just for ordered extents or
direct I/O, so maybe we can eventually skip the separate workqueue for
the stripe tree entirely.

>  	bio->bi_private = &bioc->stripes[dev_nr];
>  	bio->bi_iter.bi_sector = bioc->stripes[dev_nr].physical >> SECTOR_SHIFT;
>  	bioc->stripes[dev_nr].bioc = bioc;
> +	bioc->size = bio->bi_iter.bi_size;

So we could just use the saved_iter for the main bbio for the size and
logical if we also set that for writes.

Also right now the ordered extent is split for each actually submitted
bio for zone append writes, so you could just use that as well.  That
beeing said, I think we could actually stop doing that split with the
stripe tree, as there is no updated of the L2P mapping in the chunk tree
any more.

Can someone more familiar with the btrfs internals chime in here if
there might be a way to in fact stop updating the chunk tree entirely
as that should help reducing the write amp a bit?

> +static int add_stripe_entry_for_delayed_ref(struct btrfs_trans_handle *trans,
> +					    struct btrfs_delayed_ref_node *node)
> +{
> +	em = btrfs_get_chunk_map(fs_info, node->bytenr, node->num_bytes);
> +	if (!em) {
> +		btrfs_err(fs_info,
> +			  "cannot get chunk map for address %llu",
> +			  node->bytenr);
> +		return -EINVAL;
> +	}
> +
> +	map = em->map_lookup;
> +
> +	if (btrfs_need_stripe_tree_update(fs_info, map->type)) {

It seems like the chunk_map lookup is only needed to figure out if
the chunk needs a stripe tree update, which seems rather inefficient.
Can't we find some way to stash away that bit from the submission path
instead of rediscovering it here?
