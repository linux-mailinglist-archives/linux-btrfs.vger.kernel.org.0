Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B416C2663
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 01:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCUAhf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 20:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCUAhe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 20:37:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB3C15557
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 17:37:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 527631F8CD;
        Tue, 21 Mar 2023 00:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679359051;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mn8dVoRimTy+Y6cbShQsn7qqfFZ+wrypJUc3TCkEl6w=;
        b=HAQUxBWIWI3JsK4QfacY7y7XTgOc1jQ4IqkSCK8BF6usDB72qrKVr7TYKF3tq7QYq3n21P
        P5GUYZ5bSllDX6RU5fcABf4gTPpHHDsQ9Lpe7B9+zjgWaa8f4wkVKm+IO3GIH9cCtRun68
        J+13gqlu/cRepOBJVFMT6ExHWRPBrA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679359051;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mn8dVoRimTy+Y6cbShQsn7qqfFZ+wrypJUc3TCkEl6w=;
        b=FI2K6M5JW703NB3yhODnIfGe+Bv0ypuX3l7KPL894fxKg65xEwQLZJC5YfZmzhbVl8aXgE
        KJFa7h6J5kFrsqBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2501213451;
        Tue, 21 Mar 2023 00:37:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XH4CCEv8GGQ7TgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Mar 2023 00:37:31 +0000
Date:   Tue, 21 Mar 2023 01:31:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 06/12] btrfs: scrub: introduce a helper to verify one
 metadata
Message-ID: <20230321003121.GL10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1679278088.git.wqu@suse.com>
 <247d7a3f94cc940a8dceb03bc6357f9577c7d394.1679278088.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <247d7a3f94cc940a8dceb03bc6357f9577c7d394.1679278088.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 20, 2023 at 10:12:52AM +0800, Qu Wenruo wrote:
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2157,6 +2157,122 @@ static int scrub_checksum_data(struct scrub_block *sblock)
>  	return sblock->checksum_error;
>  }
>  
> +static struct page *scrub_stripe_get_page(struct scrub_stripe *stripe,
> +					  int sector_nr)
> +{
> +	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
> +	int page_index = sector_nr << fs_info->sectorsize_bits >> PAGE_SHIFT;

This needs ( ) to make it clear what you mean and actually shifts are
safer to be done on unsigned types (for sector_nr).

> +
> +	return stripe->pages[page_index];
> +}
> +
> +static unsigned int scrub_stripe_get_page_offset(struct scrub_stripe *stripe,
> +						 int sector_nr)
> +{
> +	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
> +
> +	return offset_in_page(sector_nr << fs_info->sectorsize_bits);
> +}
> +
> +void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr)
> +{
> +	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
> +	const unsigned int sectors_per_tree = fs_info->nodesize >>
> +					      fs_info->sectorsize_bits;
> +	const u64 logical = stripe->logical + (sector_nr << fs_info->sectorsize_bits);
> +	const struct page *first_page = scrub_stripe_get_page(stripe, sector_nr);
> +	const unsigned int first_off = scrub_stripe_get_page_offset(stripe, sector_nr);
> +	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
> +	u8 on_disk_csum[BTRFS_CSUM_SIZE];
> +	u8 calculated_csum[BTRFS_CSUM_SIZE];
> +	struct btrfs_header *h;

Please don't use single letter variables for anything else than integer
array indexes, like i. Here it it's hdr or header. Though it's probably
copied from the old code, new code should improve the style.

> +	int i;
> +
> +	/*
> +	 * Here we don't have a good way to attach the pages (and subpages)
> +	 * to a dummy extent buffer, thus we have to directly grab the members
> +	 * from pages.
> +	 */
> +	h = (struct btrfs_header *)(page_address(first_page) + first_off);
> +	memcpy(on_disk_csum, h->csum, fs_info->csum_size);
> +
> +	if (logical != btrfs_stack_header_bytenr(h)) {
> +		bitmap_set(&stripe->csum_error_bitmap, sector_nr,
> +			   sectors_per_tree);
> +		bitmap_set(&stripe->error_bitmap, sector_nr,
> +			   sectors_per_tree);
> +		btrfs_warn_rl(fs_info,
> +		"tree block %llu mirror %u has bad bytenr, has %llu want %llu",
> +			      logical, stripe->mirror_num,
> +			      btrfs_stack_header_bytenr(h), logical);
> +		return;
> +	}
> +	if (memcmp(h->fsid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE)) {

For memcmp please use explicit == 0 or != 0

> +		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
> +			   sectors_per_tree);
> +		bitmap_set(&stripe->error_bitmap, sector_nr,
> +			   sectors_per_tree);
> +		btrfs_warn_rl(fs_info,
> +		"tree block %llu mirror %u has bad fsid, has %pU want %pU",
> +			      logical, stripe->mirror_num,
> +			      h->fsid, fs_info->fs_devices->fsid);
> +		return;
> +	}
> +	if (memcmp(h->chunk_tree_uuid, fs_info->chunk_tree_uuid,
> +		   BTRFS_UUID_SIZE)) {

Same

> +		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
> +			   sectors_per_tree);
> +		bitmap_set(&stripe->error_bitmap, sector_nr,
> +			   sectors_per_tree);
> +		btrfs_warn_rl(fs_info,
> +		"tree block %llu mirror %u has bad chunk tree uuid, has %pU want %pU",
> +			      logical, stripe->mirror_num,
> +			      h->chunk_tree_uuid, fs_info->chunk_tree_uuid);
> +		return;
> +	}
> +
> +	/* Now check tree block csum. */
> +	shash->tfm = fs_info->csum_shash;
> +	crypto_shash_init(shash);
> +	crypto_shash_update(shash, page_address(first_page) + first_off +
> +			    BTRFS_CSUM_SIZE, fs_info->sectorsize - BTRFS_CSUM_SIZE);
> +
> +	for (i = sector_nr + 1; i < sector_nr + sectors_per_tree; i++) {
> +		struct page *page = scrub_stripe_get_page(stripe, i);
> +		unsigned int page_off = scrub_stripe_get_page_offset(stripe, i);
> +
> +		crypto_shash_update(shash, page_address(page) + page_off,
> +				    fs_info->sectorsize);
> +	}
> +	crypto_shash_final(shash, calculated_csum);
> +	if (memcmp(calculated_csum, on_disk_csum, fs_info->csum_size)) {

Same

> +		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
> +			   sectors_per_tree);
> +		bitmap_set(&stripe->error_bitmap, sector_nr,
> +			   sectors_per_tree);
> +		btrfs_warn_rl(fs_info,
> +		"tree block %llu mirror %u has bad csum, has " CSUM_FMT " want " CSUM_FMT,
> +			      logical, stripe->mirror_num,
> +			      CSUM_FMT_VALUE(fs_info->csum_size, on_disk_csum),
> +			      CSUM_FMT_VALUE(fs_info->csum_size, calculated_csum));
> +		return;
> +	}
> +	if (stripe->sectors[sector_nr].generation != btrfs_stack_header_generation(h)) {
> +		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
> +			   sectors_per_tree);
> +		bitmap_set(&stripe->error_bitmap, sector_nr,
> +			   sectors_per_tree);
> +		btrfs_warn_rl(fs_info,
> +		"tree block %llu mirror %u has bad geneartion, has %llu want %llu",
> +			      logical, stripe->mirror_num,
> +			      btrfs_stack_header_generation(h),
> +			      stripe->sectors[sector_nr].generation);
> +	}
> +	bitmap_clear(&stripe->error_bitmap, sector_nr, sectors_per_tree);
> +	bitmap_clear(&stripe->csum_error_bitmap, sector_nr, sectors_per_tree);
> +	bitmap_clear(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
> +}
