Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6963D6D81D8
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 17:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbjDEP3Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 11:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238395AbjDEP3M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 11:29:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B8E65A8
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 08:28:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 42DC42210D;
        Wed,  5 Apr 2023 15:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680708532;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QAY0p6yy+Zw6tEPFfRMZpnIEAAcKLA+WaUmSVrXhkgw=;
        b=y3MUDX+PZxGI0GCLWImoo8G3W/ceYCu4GODEVZJsLGpTaokAqH7w073YOtYXaApQ6yMQnN
        0Ocw+XSVAgEsTW+kmVcI1CMNt9K//BiKtEqEIQ/say3BzXfuOeIRd5k1ewggrfeahasZu/
        el/YSJQUWi9jvUypA3Be5WqMS1KDZUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680708532;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QAY0p6yy+Zw6tEPFfRMZpnIEAAcKLA+WaUmSVrXhkgw=;
        b=5bfKPtHXczwp7SuhGzEVQX+i5jJYPaayKFtz2GCksfI/7Yn4DbzIz1TIo3jtMIcvO2yX6n
        tuqw7t3zJsEViXAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0AF5013A10;
        Wed,  5 Apr 2023 15:28:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IT3PAbSTLWQOLQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 05 Apr 2023 15:28:52 +0000
Date:   Wed, 5 Apr 2023 17:28:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v8 06/12] btrfs: scrub: introduce a helper to verify one
 metadata
Message-ID: <20230405152849.GK19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1680225140.git.wqu@suse.com>
 <eb752c34ca23d5d55ce7df9b43cdcb5f52b97490.1680225140.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb752c34ca23d5d55ce7df9b43cdcb5f52b97490.1680225140.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 31, 2023 at 09:20:09AM +0800, Qu Wenruo wrote:
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
> +	struct btrfs_header *header;
> +
> +	/*
> +	 * Here we don't have a good way to attach the pages (and subpages)
> +	 * to a dummy extent buffer, thus we have to directly grab the members
> +	 * from pages.
> +	 */
> +	header = (struct btrfs_header *)(page_address(first_page) + first_off);
> +	memcpy(on_disk_csum, header->csum, fs_info->csum_size);
> +
> +	if (logical != btrfs_stack_header_bytenr(header)) {
> +		bitmap_set(&stripe->csum_error_bitmap, sector_nr,
> +			   sectors_per_tree);
> +		bitmap_set(&stripe->error_bitmap, sector_nr,
> +			   sectors_per_tree);
> +		btrfs_warn_rl(fs_info,
> +		"tree block %llu mirror %u has bad bytenr, has %llu want %llu",
> +			      logical, stripe->mirror_num,
> +			      btrfs_stack_header_bytenr(header), logical);
> +		return;
> +	}
> +	if (memcmp(header->fsid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE) != 0) {
> +		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
> +			   sectors_per_tree);
> +		bitmap_set(&stripe->error_bitmap, sector_nr,
> +			   sectors_per_tree);
> +		btrfs_warn_rl(fs_info,
> +		"tree block %llu mirror %u has bad fsid, has %pU want %pU",
> +			      logical, stripe->mirror_num,
> +			      header->fsid, fs_info->fs_devices->fsid);
> +		return;
> +	}
> +	if (memcmp(header->chunk_tree_uuid, fs_info->chunk_tree_uuid,
> +		   BTRFS_UUID_SIZE) != 0) {
> +		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
> +			   sectors_per_tree);
> +		bitmap_set(&stripe->error_bitmap, sector_nr,
> +			   sectors_per_tree);
> +		btrfs_warn_rl(fs_info,
> +		"tree block %llu mirror %u has bad chunk tree uuid, has %pU want %pU",
> +			      logical, stripe->mirror_num,
> +			      header->chunk_tree_uuid, fs_info->chunk_tree_uuid);
> +		return;
> +	}
> +
> +	/* Now check tree block csum. */
> +	shash->tfm = fs_info->csum_shash;
> +	crypto_shash_init(shash);
> +	crypto_shash_update(shash, page_address(first_page) + first_off +
> +			    BTRFS_CSUM_SIZE, fs_info->sectorsize - BTRFS_CSUM_SIZE);
> +
> +	for (int i = sector_nr + 1; i < sector_nr + sectors_per_tree; i++) {
> +		struct page *page = scrub_stripe_get_page(stripe, i);
> +		unsigned int page_off = scrub_stripe_get_page_offset(stripe, i);
> +
> +		crypto_shash_update(shash, page_address(page) + page_off,
> +				    fs_info->sectorsize);
> +	}
> +	crypto_shash_final(shash, calculated_csum);
> +	if (memcmp(calculated_csum, on_disk_csum, fs_info->csum_size) != 0) {
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
> +	if (stripe->sectors[sector_nr].generation !=
> +	    btrfs_stack_header_generation(header)) {
> +		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
> +			   sectors_per_tree);
> +		bitmap_set(&stripe->error_bitmap, sector_nr,
> +			   sectors_per_tree);
> +		btrfs_warn_rl(fs_info,
> +		"tree block %llu mirror %u has bad geneartion, has %llu want %llu",
> +			      logical, stripe->mirror_num,
> +			      btrfs_stack_header_generation(header),
> +			      stripe->sectors[sector_nr].generation);

Is return; missing here?

> +	}
> +	bitmap_clear(&stripe->error_bitmap, sector_nr, sectors_per_tree);
> +	bitmap_clear(&stripe->csum_error_bitmap, sector_nr, sectors_per_tree);
> +	bitmap_clear(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
> +}
