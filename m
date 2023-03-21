Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A464B6C2651
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 01:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjCUA3G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 20:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCUA3F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 20:29:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331DC59D9
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 17:29:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8269C1F8D7;
        Tue, 21 Mar 2023 00:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679358542;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mnDm14Id7F5YCcprFtIqtt6Y7Z/6Wt4iJdCJ+fetatk=;
        b=GGKwQzGdnu1B3r6oPzDkPwOtxa8Bc/HKflrBRNGQzFlZGLjJ+Oz0XQVigSWqZ88aancUKb
        QsFXebMGm7NucYQ2lNrdjPtB7lnnKgAqIt3CBTSmZO7cBIeTerc6fetR3QDuSSjYtRliw7
        3LoaEv710SZ49xpm1him3KN7uW3oCmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679358542;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mnDm14Id7F5YCcprFtIqtt6Y7Z/6Wt4iJdCJ+fetatk=;
        b=7ZdsUsjmOBP22SBNq1ToJ899FHRHHypI4YHWDH5+ComAp4E0odH1mOHQ4J/V8W4WVY7BMz
        bntcCuSmOm2F+DDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A63213451;
        Tue, 21 Mar 2023 00:29:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EYAlEU76GGTZSgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Mar 2023 00:29:02 +0000
Date:   Tue, 21 Mar 2023 01:22:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 04/12] btrfs: scrub: introduce the structure for new
 BTRFS_STRIPE_LEN based interface
Message-ID: <20230321002252.GK10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1679278088.git.wqu@suse.com>
 <14da54c24f582455626e24612740f71e894b896a.1679278088.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14da54c24f582455626e24612740f71e894b896a.1679278088.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 20, 2023 at 10:12:50AM +0800, Qu Wenruo wrote:
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -70,6 +70,88 @@ struct scrub_ctx;
>   */
>  #define BTRFS_MAX_MIRRORS (4 + 1)
>  
> +/* Set when @mirror_num, @dev, @physical and @logical is set. */
> +#define SCRUB_STRIPE_FLAG_INITIALIZED		(0)
> +
> +/* Set when the read-repair is finished. */
> +#define SCRUB_STRIPE_FLAG_REPAIR_DONE		(1)

This is could be an enum, the values are used as bit numbers so a linear
sequence starting at 0.

> +/*
> + * Represent one continuous range with a length of BTRFS_STRIPE_LEN.
> + */
> +struct scrub_stripe {
> +	struct btrfs_block_group *bg;
> +
> +	struct page *pages[BTRFS_STRIPE_LEN / PAGE_SIZE];

Please define this out as a separate constant, named like SCRUB_STRIPE_PAGES

> +	struct scrub_sector_verification *sectors;
> +
> +	struct btrfs_device *dev;
> +	u64 logical;
> +	u64 physical;
> +
> +	u16 mirror_num;
> +
> +	/* Should be BTRFS_STRIPE_LEN / sectorsize. */
> +	u16 nr_sectors;
> +
> +	atomic_t pending_io;
> +	wait_queue_head_t io_wait;
> +
> +	/* Indicates the states of the stripe. */

Maybe also mention that the states are SCRUB_STRIPE_FLAG_* bits

> +	unsigned long state;
> +
> +	/* Indicates which sectors are covered by extent items. */
> +	unsigned long extent_sector_bitmap;
> +
> +	/*
> +	 * The errors hit during the initial read of the stripe.
> +	 *
> +	 * Would be utilized for error reporting and repair.
> +	 */
> +	unsigned long init_error_bitmap;
> +
> +	/*
> +	 * The following error bitmaps are all for the current status.
> +	 * Every time we submit a new read, those bitmaps may be updated.
> +	 *
> +	 * error_bitmap = io_error_bitmap | csum_error_bitmap | meta_error_bitmap;
> +	 *
> +	 * IO and csum errors can happen for both metadata and data.
> +	 */
> +	unsigned long error_bitmap;
> +	unsigned long io_error_bitmap;
> +	unsigned long csum_error_bitmap;
> +	unsigned long meta_error_bitmap;
> +
> +	/*
> +	 * Checksum for the whole stripe if this stripe is inside a data block
> +	 * group.
> +	 */
> +	u8 *csums;
> +};
> +
>  struct scrub_recover {
>  	refcount_t		refs;
>  	struct btrfs_io_context	*bioc;
> @@ -266,6 +348,64 @@ static void detach_scrub_page_private(struct page *page)
>  #endif
>  }
>  
> +static void release_scrub_stripe(struct scrub_stripe *stripe)
> +{
> +	int i;
> +
> +	if (!stripe)
> +		return;
> +
> +	for (i = 0; i < BTRFS_STRIPE_LEN >> PAGE_SHIFT; i++) {

Here the suggested SCRUB_STRIPE_PAGES constant would be used as well.

> +		if (stripe->pages[i])
> +			__free_page(stripe->pages[i]);
> +		stripe->pages[i] = NULL;
> +	}
> +	kfree(stripe->sectors);
> +	kfree(stripe->csums);
> +	stripe->sectors = NULL;
> +	stripe->csums = NULL;
> +	stripe->state = 0;
> +}
> +
> +int init_scrub_stripe(struct btrfs_fs_info *fs_info, struct scrub_stripe *stripe)
> +{
> +	int ret;
> +
> +	memset(stripe, 0, sizeof(*stripe));
> +
> +	stripe->nr_sectors = BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits;
> +	stripe->state = 0;
> +
> +	init_waitqueue_head(&stripe->io_wait);
> +	atomic_set(&stripe->pending_io, 0);
> +

Extra newline.

> +
> +	ret = btrfs_alloc_page_array(BTRFS_STRIPE_LEN >> PAGE_SHIFT,

				     SCRUB_STRIPE_PAGES

> +				     stripe->pages);
> +	if (ret < 0)
> +		goto error;
> +
> +	stripe->sectors = kcalloc(stripe->nr_sectors,
> +				  sizeof(struct scrub_sector_verification),
> +				  GFP_KERNEL);
> +	if (!stripe->sectors)
> +		goto error;
> +
> +	stripe->csums = kzalloc((BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits) *
> +				fs_info->csum_size, GFP_KERNEL);
> +	if (!stripe->csums)
> +		goto error;
> +	return 0;
> +error:
> +	release_scrub_stripe(stripe);
> +	return -ENOMEM;
> +}
