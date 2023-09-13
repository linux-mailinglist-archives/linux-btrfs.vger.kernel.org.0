Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D940F79EFB1
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 19:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjIMRA6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 13:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjIMRAp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 13:00:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0982129;
        Wed, 13 Sep 2023 09:59:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 45E56218DF;
        Wed, 13 Sep 2023 16:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694624390;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mMKuhVl931rFlZh8vsg1gw1/iTS337b9TgDW53uAJjY=;
        b=CHvQ2CATESpbijhMMH+yJWfgqAU+8+O7nMquIrPnG0N54etKQNSKm1kF2EVrg0/Er1X/J9
        12G29DstMSM/5B6y2IN2T+bEIDogRv8GEe8ySs1d12fq3Shj34+yqBik2OVYZSL+sgpuoF
        mRLMRuwHpt3+YUtr4Dc214ZYB1W20C8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694624390;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mMKuhVl931rFlZh8vsg1gw1/iTS337b9TgDW53uAJjY=;
        b=axdq2CEMTrMwN3NlMkF+mp0CXg4BkS9qgkC9G5mn3V3cx6+BjNhcZNjAX1gAi6HrzjUKYZ
        T5NUGDn7hBE7BYDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1047113582;
        Wed, 13 Sep 2023 16:59:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BZ9ZA4bqAWVRLQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Sep 2023 16:59:50 +0000
Date:   Wed, 13 Sep 2023 18:59:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 06/11] btrfs: implement RST version of scrub
Message-ID: <20230913165948.GS20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-6-647676fa852c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911-raid-stripe-tree-v8-6-647676fa852c@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 11, 2023 at 05:52:07AM -0700, Johannes Thumshirn wrote:
> A filesystem that uses the RAID stripe tree for logical to physical
> address translation can't use the regular scrub path, that reads all
> stripes and then checks if a sector is unused afterwards.
> 
> When using the RAID stripe tree, this will result in lookup errors, as the
> stripe tree doesn't know the requested logical addresses.
> 
> Instead, look up stripes that are backed by the extent bitmap.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/scrub.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index f16220ce5fba..5101e0a3f83e 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -23,6 +23,7 @@
>  #include "accessors.h"
>  #include "file-item.h"
>  #include "scrub.h"
> +#include "raid-stripe-tree.h"
>  
>  /*
>   * This is only the first step towards a full-features scrub. It reads all
> @@ -1634,6 +1635,56 @@ static void scrub_reset_stripe(struct scrub_stripe *stripe)
>  	}
>  }
>  
> +static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
> +					    struct scrub_stripe *stripe)
> +{
> +	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
> +	struct btrfs_bio *bbio = NULL;
> +	int mirror = stripe->mirror_num;
> +	int i;
> +
> +	atomic_inc(&stripe->pending_io);
> +
> +	for_each_set_bit(i, &stripe->extent_sector_bitmap, stripe->nr_sectors) {
> +		struct page *page;
> +		int pgoff;

This should be unsigned int.

> +
> +		page = scrub_stripe_get_page(stripe, i);
> +		pgoff = scrub_stripe_get_page_offset(stripe, i);

You can probably move the initializations right to the declarations, I
think we have that elsewhere too.

> +		/* The current sector cannot be merged, submit the bio. */
> +		if (bbio &&
> +		    ((i > 0 && !test_bit(i - 1, &stripe->extent_sector_bitmap)) ||
> +		     bbio->bio.bi_iter.bi_size >= BTRFS_STRIPE_LEN)) {
> +			ASSERT(bbio->bio.bi_iter.bi_size);
> +			atomic_inc(&stripe->pending_io);
> +			btrfs_submit_bio(bbio, mirror);
> +			bbio = NULL;
> +		}
> +
> +		if (!bbio) {
> +			bbio = btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_READ,
> +				fs_info, scrub_read_endio, stripe);
> +			bbio->bio.bi_iter.bi_sector = (stripe->logical +
> +				(i << fs_info->sectorsize_bits)) >> SECTOR_SHIFT;
> +		}
> +
> +		__bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
> +	}
> +
> +	if (bbio) {
> +		ASSERT(bbio->bio.bi_iter.bi_size);
> +		atomic_inc(&stripe->pending_io);
> +		btrfs_submit_bio(bbio, mirror);
> +	}
> +
> +	if (atomic_dec_and_test(&stripe->pending_io)) {
> +		wake_up(&stripe->io_wait);
> +		INIT_WORK(&stripe->work, scrub_stripe_read_repair_worker);
> +		queue_work(stripe->bg->fs_info->scrub_workers, &stripe->work);
> +	}
> +}
