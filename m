Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCED153754
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 19:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgBESQJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 13:16:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgBESQI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Feb 2020 13:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8biGRU2XKrspDXuOjuNYPmKw+66dSCjTAhdlJQNlOGE=; b=UF4f/JhsXY8Wdr/fdn11k5lKMH
        MbkNjNrH1FSUxuqmjO93f9bXlL8Wp78955NqA7GVsEZeuEORFWx1UY2UaUYcNvY/1x7IEN4uYSKqR
        fz98EAlFMgM/e0q88ERLX6cG9KLZpsB5APIUpZi5eYStuZBwLUQW4z8qNWddDas7MCkrKSk/tQOvW
        dvjHw8gh/6asQ9TQBLnigmuSV2406+pcgQLwaVr1P7uc+VQPN553j1fkMHwKAHkijTIjikMBNiv4A
        4PtOSYlQuHlxEPn0b4X1XLowoBlWzU27FrJ2alEgfDIibg2LSDtZ9PDrMFauUHjJ7Sb7oXiV+Fux7
        v0cCXc6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izPDZ-0004Yx-Lj; Wed, 05 Feb 2020 18:16:05 +0000
Date:   Wed, 5 Feb 2020 10:16:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] btrfs: use BIOs instead of buffer_heads from
 superblock writeout
Message-ID: <20200205181605.GA11348@infradead.org>
References: <20200205143831.13959-1-johannes.thumshirn@wdc.com>
 <20200205143831.13959-3-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205143831.13959-3-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 05, 2020 at 11:38:28PM +0900, Johannes Thumshirn wrote:
> +static void btrfs_end_super_write(struct bio *bio)
>  {
> +	struct btrfs_device *device = bio->bi_private;
> +	struct bio_vec *bvec;
> +	struct bvec_iter_all iter_all;
> +	struct page *page;
> +
> +	bio_for_each_segment_all(bvec, bio, iter_all) {
> +		page = bvec->bv_page;
> +
> +		if (blk_status_to_errno(bio->bi_status)) {

Nit: this could simply check bio->bi_status without a conversion.

> +			btrfs_warn_rl_in_rcu(device->fs_info,
> +					     "lost page write due to IO error on %s",
> +					     rcu_str_deref(device->name));

But maybe you want to print the error here?

> +	gfp_mask = mapping_gfp_constraint(mapping, ~__GFP_FS) | __GFP_NOFAIL;

Same comment on the ask as in the previous patch.

> +		u8 *ptr;

I'd use a typed pointer here again..

> +		ptr = kmap(page);
> +		memcpy(ptr, sb, BTRFS_SUPER_INFO_SIZE);

With which you could do a struct assignment here and very slightly
improve type safety.

> @@ -3497,9 +3506,23 @@ static int write_dev_supers(struct btrfs_device *device,
>  		op_flags = REQ_SYNC | REQ_META | REQ_PRIO;
>  		if (i == 0 && !btrfs_test_opt(device->fs_info, NOBARRIER))
>  			op_flags |= REQ_FUA;

Question on the existing code:  why is it safe to not use FUA for the
subsequent superblocks?

> +
> +		/*
> +		 * Directly use BIOs here instead of relying on the page-cache
> +		 * to do I/O, so we don't loose the ability to do integrity
> +		 * checking.
> +		 */
> +		bio = bio_alloc(gfp_mask, 1);
> +		bio_set_dev(bio, device->bdev);
> +		bio->bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
> +		bio->bi_private = device;
> +		bio->bi_end_io = btrfs_end_super_write;
> +		bio_add_page(bio, page, BTRFS_SUPER_INFO_SIZE,
> +			     offset_in_page(bytenr));

Missing return value check.  But given that it is a single page and
can't error out please switch to __bio_add_page here.

> +		bio->bi_opf = REQ_OP_WRITE | op_flags;

You could kill the op_flags variable and just assign everything directly
to bio->bi_opf.
