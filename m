Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930A76C268D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 01:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjCUAvC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 20:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCUAvB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 20:51:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBDD31E31
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 17:50:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E468A211E2;
        Tue, 21 Mar 2023 00:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679359788;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MwMD9oLwigzWbYiFhhdfO/MYSgbM8suBCVSI/xPNj9o=;
        b=TPlc8cNh7a5Do4iMwFGjxIjMMTt/O1NUsmSS5DXM0fYUTZ3PRtY4cvClEaps0ZliR+g/Yi
        Hqs5cJQZXGppUMH7N9IwlM47hnvUlqpAC6Vc23sq8wkfH/o53kwVgAAfrwRXmQqLw3cdgp
        H/UKt/HitmbtRpdhOvfmrMTmILNYzOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679359788;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MwMD9oLwigzWbYiFhhdfO/MYSgbM8suBCVSI/xPNj9o=;
        b=dBHol+1n3KNoqXyzLfNv3G+Shs+NMR0QL8VVvw7brDREUJA59zVmX6l8Mj7afCpanDQYWW
        1xOt5xi2WPKkMbBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9AD1D13416;
        Tue, 21 Mar 2023 00:49:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0iYQJCz/GGRgUwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Mar 2023 00:49:48 +0000
Date:   Tue, 21 Mar 2023 01:43:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 09/12] btrfs: scrub: introduce a writeback helper for
 scrub_stripe
Message-ID: <20230321004338.GM10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1679278088.git.wqu@suse.com>
 <40123ebdfdaabedf0d2811e64b28766e38de4148.1679278088.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40123ebdfdaabedf0d2811e64b28766e38de4148.1679278088.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 20, 2023 at 10:12:55AM +0800, Qu Wenruo wrote:
> +static void scrub_write_endio(struct btrfs_bio *bbio)
> +{
> +	struct scrub_stripe *stripe = bbio->private;
> +	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
> +	struct bio_vec *bvec;
> +	unsigned long flags;
> +	int sector_nr = calc_sector_number(stripe, bio_first_bvec_all(&bbio->bio));
> +	int bio_size = 0;
> +	int i;
> +
> +	bio_for_each_bvec_all(bvec, &bbio->bio, i)
> +		bio_size += bvec->bv_len;

The types should match, bv_len is u32 so it should be summed to a u32
type (bio_size).

> +
> +	if (bbio->bio.bi_status) {
> +		spin_lock_irqsave(&stripe->write_error_lock, flags);
> +		bitmap_set(&stripe->write_error_bitmap, sector_nr,
> +				bio_size >> fs_info->sectorsize_bits);
> +		spin_unlock_irqrestore(&stripe->write_error_lock, flags);
> +	}
> +	bio_put(&bbio->bio);
> +
> +	if (atomic_dec_and_test(&stripe->pending_io))
> +		wake_up(&stripe->io_wait);
> +}
> +
> +/*
> + * Submit the write bio(s) for the sectors specified by @write_bitmap.
> + *
> + * Here we utilize btrfs_submit_scrub_write(), which has some extra benefits:
> + *
> + * - Only needs logical bytenr and mirror_num
> + *   Just like the scrub read path
> + *
> + * - Would only result writes to the specified mirror
> + *   Unlike the regular writeback path, which would write back to all stripes
> + *
> + * - Handle dev-replace and read-repair writeback differently
> + */
> +void scrub_write_sectors(struct scrub_ctx *sctx,
> +			struct scrub_stripe *stripe,
> +			unsigned long write_bitmap, bool dev_replace)
> +{
> +	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
> +	struct btrfs_bio *bbio = NULL;
> +	bool zoned = btrfs_is_zoned(fs_info);
> +	int sector_nr;
> +
> +	for_each_set_bit(sector_nr, &write_bitmap, stripe->nr_sectors) {
> +		struct page *page = scrub_stripe_get_page(stripe, sector_nr);
> +		unsigned int pgoff = scrub_stripe_get_page_offset(stripe,
> +								  sector_nr);
> +		int ret;
> +
> +		/* We should only writeback sectors covered by an extent. */
> +		ASSERT(test_bit(sector_nr, &stripe->extent_sector_bitmap));
> +
> +		/* Can not merge with previous sector, submit the current one. */
> +		if (bbio && sector_nr && !test_bit(sector_nr - 1, &write_bitmap)) {
> +			fill_writer_pointer_gap(sctx, stripe->physical +
> +					(sector_nr << fs_info->sectorsize_bits));
> +			atomic_inc(&stripe->pending_io);
> +			btrfs_submit_scrub_write(fs_info, bbio,
> +						 stripe->mirror_num, dev_replace);
> +			/* For zoned writeback, QD must be 1. */

QD means queue depth? I'd rather spell it out, QD is not a common
abbreviation in our code.

> +			if (zoned)
> +				wait_scrub_stripe_io(stripe);
> +			bbio = NULL;
> +		}
> +		if (!bbio) {
> +			bbio = btrfs_bio_alloc(BTRFS_STRIPE_LEN >> PAGE_SHIFT,

					       SCRUB_STRIPE_PAGES

> +					REQ_OP_WRITE, NULL, scrub_write_endio, stripe);
> +			/* Backed by mempool */
> +			ASSERT(bbio);

Not sure if this is the first that does it but we could drop the comment
and assert around btrfs_bio_alloc because it's documented in the
function.

> +
> +			bbio->bio.bi_iter.bi_sector = (stripe->logical +
> +				(sector_nr << fs_info->sectorsize_bits)) >>
> +				SECTOR_SHIFT;
> +		}
> +		ret = bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
> +		ASSERT(ret == fs_info->sectorsize);
> +	}
> +	if (bbio) {
> +		fill_writer_pointer_gap(sctx, bbio->bio.bi_iter.bi_sector <<
> +					SECTOR_SHIFT);
> +		atomic_inc(&stripe->pending_io);
> +		btrfs_submit_scrub_write(fs_info, bbio, stripe->mirror_num,
> +					 dev_replace);
> +		if (zoned)
> +			wait_scrub_stripe_io(stripe);
> +	}
> +}
