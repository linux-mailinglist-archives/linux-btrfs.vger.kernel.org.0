Return-Path: <linux-btrfs+bounces-18763-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC33EC39B8B
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 10:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 259584F512E
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 09:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3842FE04C;
	Thu,  6 Nov 2025 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XqWmXkCW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7yUY7gxN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XqWmXkCW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7yUY7gxN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796A2239E9E
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419767; cv=none; b=FuLgH/QS3bUMKR/7az8hWvKRjOPFlEzu3QIzkMO+C8gMIyBSdPeh7+OGEV/pKh8MrlNuN4Ww/a31amkRJ7P65a0maNC+CBa56kgmBhm45n9pJ0pscVQbTi5HhNGfCFyEkQH9Rlg5qVI6xuQxd1fPevAxno12Lj02IXK06S04gwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419767; c=relaxed/simple;
	bh=TkdwAri3dXWzN7DqIlChoqGRKioggjVaS1vQ+g8UF+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1Z89OpSWQ5HW9A3XHrD2Ll3wP1JqOUG0iYIRM96dTFGgzZXoEcwbueIkJ3e7QWAX3bxl3HI554mOsTqGsMPEI7Oy+gzoH6+zM9QsbVsUGaY0sxerdcEan5sYoM0mzBPEg9cJibXF2bh19zQheiWOHo4dMyKVWQDu/TrKULcqfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XqWmXkCW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7yUY7gxN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XqWmXkCW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7yUY7gxN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 802101F393;
	Thu,  6 Nov 2025 09:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762419763;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qrEyT8IFxJADqeXrIb1RJDgbFde+WaW4TNaDUAATM6w=;
	b=XqWmXkCWJCyNnxkPV97L6dMdqx2w9PDF/pVEOMyfmjhlu4awMSsmew9DsOrp2sv7yOFltc
	ihyg6qW7OEiJj8LlIui2vTGwJ/PlWAau6fxNAUaiIBm5aIxGltv0/UveAVRO/JAtrbXdv8
	Sr5nY/aUrSCKIZRRDV5FP0pQNNZVD3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762419763;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qrEyT8IFxJADqeXrIb1RJDgbFde+WaW4TNaDUAATM6w=;
	b=7yUY7gxNUO7E2CQ4yYFUNYQNj665TDH5CvSkeGse2PY6JvES6ZH3cgg8Av2+YOpBh5j6hn
	eeKA9aVw5nqkOQAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762419763;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qrEyT8IFxJADqeXrIb1RJDgbFde+WaW4TNaDUAATM6w=;
	b=XqWmXkCWJCyNnxkPV97L6dMdqx2w9PDF/pVEOMyfmjhlu4awMSsmew9DsOrp2sv7yOFltc
	ihyg6qW7OEiJj8LlIui2vTGwJ/PlWAau6fxNAUaiIBm5aIxGltv0/UveAVRO/JAtrbXdv8
	Sr5nY/aUrSCKIZRRDV5FP0pQNNZVD3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762419763;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qrEyT8IFxJADqeXrIb1RJDgbFde+WaW4TNaDUAATM6w=;
	b=7yUY7gxNUO7E2CQ4yYFUNYQNj665TDH5CvSkeGse2PY6JvES6ZH3cgg8Av2+YOpBh5j6hn
	eeKA9aVw5nqkOQAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E3AD139A9;
	Thu,  6 Nov 2025 09:02:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IYHSFjNkDGlMeQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 06 Nov 2025 09:02:43 +0000
Date: Thu, 6 Nov 2025 10:02:42 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: extract the parity scrub code into a helper
Message-ID: <20251106090242.GV13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2d2cfb7729a65d88ea8b9d6408611d0cc76e1ab7.1762398098.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d2cfb7729a65d88ea8b9d6408611d0cc76e1ab7.1762398098.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -8.00

On Thu, Nov 06, 2025 at 01:32:05PM +1030, Qu Wenruo wrote:
> The function scrub_raid56_parity_stripe() is handling the partity stripe
> by the following steps:
> 
> - Scrub each data stripes
>   And make sure everything is fine in each data stripe
> 
> - Cache the data stripe into the raid bio
> 
> - Use the cached raid bio to scrub the target parity stripe
> 
> Extract the last two steps into a new helper,
> scrub_radi56_cached_parity(), as a cleanup and make the error handling
> more straightforward.
> 
> With the following minor cleanups:
> 
> - Use on-stack bio structure
>   The bio is always empty thus we do not need any bio vector nor the
>   block device. Thus there is no need to allocate a bio, the on-stack
>   one is more than enough to cut it.
> 
> - Remove the unnecessary btrfs_put_bioc() call if btrfs_map_block()
>   failed
>   If btrfs_map_block() is failed, @bioc_ret will not be touched thus
>   there is no need to call btrfs_put_bioc() in this case.
> 
> - Use a proper out: tag to do the cleanup
>   Now the error cleanup is much shorter and simpler, just
>   btrfs_bio_counter_dec() and bio_uninit().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/scrub.c | 90 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 52 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index e3612202ba55..8c360d941bd5 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2113,6 +2113,56 @@ static int should_cancel_scrub(const struct scrub_ctx *sctx)
>  	return 0;
>  }
>  
> +static int scrub_raid56_cached_parity(struct scrub_ctx *sctx,
> +				      struct btrfs_device *scrub_dev,
> +				      struct btrfs_chunk_map *map,
> +				      u64 full_stripe_start,
> +				      unsigned long *extent_bitmap)
> +{
> +	DECLARE_COMPLETION_ONSTACK(io_done);
> +	struct btrfs_fs_info *fs_info = sctx->fs_info;
> +	struct btrfs_io_context *bioc = NULL;
> +	struct btrfs_raid_bio *rbio;
> +	struct bio bio;
> +	const int data_stripes = nr_data_stripes(map);
> +	u64 length = btrfs_stripe_nr_to_offset(data_stripes);
> +	int ret;
> +
> +	bio_init(&bio, NULL, NULL, 0, REQ_OP_READ);
> +	bio.bi_iter.bi_sector = full_stripe_start >> SECTOR_SHIFT;
> +	bio.bi_private = &io_done;
> +	bio.bi_end_io = raid56_scrub_wait_endio;
> +
> +	btrfs_bio_counter_inc_blocked(fs_info);
> +	ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, full_stripe_start,
> +			      &length, &bioc, NULL, NULL);
> +	if (ret < 0)
> +		goto out;
> +	/* For RAID56 write there must be an @bioc allocated. */
> +	ASSERT(bioc);
> +	rbio = raid56_parity_alloc_scrub_rbio(&bio, bioc, scrub_dev, extent_bitmap,
> +				BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits);
> +	btrfs_put_bioc(bioc);
> +	if (!rbio) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	/* Use the recovered stripes as cache to avoid read them from disk again. */
> +	for (int i = 0; i < data_stripes; i++) {
> +		struct scrub_stripe *stripe = &sctx->raid56_data_stripes[i];
> +
> +		raid56_parity_cache_data_folios(rbio, stripe->folios,
> +				full_stripe_start + (i << BTRFS_STRIPE_LEN_SHIFT));
> +	}
> +	raid56_parity_submit_scrub_rbio(rbio);
> +	wait_for_completion_io(&io_done);
> +	ret = blk_status_to_errno(bio.bi_status);
> +out:
> +	btrfs_bio_counter_dec(fs_info);
> +	bio_uninit(&bio);
> +	return ret;
> +}
> +
>  static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
>  				      struct btrfs_device *scrub_dev,
>  				      struct btrfs_block_group *bg,
> @@ -2121,16 +2171,12 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
>  {
>  	DECLARE_COMPLETION_ONSTACK(io_done);

This should be deleted as well, as it's in scrub_raid56_cached_parity()

The stack meter says that the new function adds 240 bytes (and has
dynamic stack size) while scrub_raid56_parity_stripe() shrinks only by
24 bytes. So this basically adds 240 - 24 = 216 bytes to the stack.

With the completion removed is another -32 bytes it's down to 184. The
on-stack bio is 112 bytes from that, 184 - 112 = 72 for remaining
variables.

