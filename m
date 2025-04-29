Return-Path: <linux-btrfs+bounces-13490-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A321EAA0442
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 09:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE7D1B639BC
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 07:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C26B27602B;
	Tue, 29 Apr 2025 07:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aoIe2fSf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pxJYLPxR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aoIe2fSf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pxJYLPxR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0697227470
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 07:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745911352; cv=none; b=lrJQk5vUU+azHka/mYHEOJCn3oS7UVX5sS44Wr+RsTBXh99G2Iovne9bKYFywgnl1WamLIEeD8MCx0tNNTOOQs1rFyM7o90/G7AOVTmSrBeV3Tgp9LfJI4T0jZgNk7AJUF+VQAIzHMcmi77nI4SHoUL3EYnWK/iC5tCPfPx5nbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745911352; c=relaxed/simple;
	bh=F5veQ0b3GZkvq9QAEHVNl+u7o5lzpneMDlbynbXmrE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzjeWGJ7kd2Zs26dMkIGR6NxgZpjmZObU7ULkIRNnkh7QNlGTP7D1QffPmXSTDN2ERTSmLKZiQgLuk4QamcxzmTX637NfdRdgjBrlvlyUToiWyLj+HUi0dXrERiVjwY1KydDX1319DGBhky8rLqnECI43+iyJqPjsnb/wY8pO1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aoIe2fSf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pxJYLPxR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aoIe2fSf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pxJYLPxR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF0CC21B52;
	Tue, 29 Apr 2025 07:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745911348;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b9/w9vw/uv23dNplzSrOhyRFybaPHFS13AjaQioHqsw=;
	b=aoIe2fSfZB5xgB55Agv3Kwyv6Z6lfarh8GBSgqQpwxY3nnFMkmPsfS04E24uj9kHYmxsXC
	REDqUMBAnusXfPSw2SkyVxhZTU/mwzY0i8jjcN1N+d5yEP8QfU5vYTGScnlPhYJg5Sth5Z
	jeCokcTTyb/73kb7B+gEhQ60qv9eDxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745911348;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b9/w9vw/uv23dNplzSrOhyRFybaPHFS13AjaQioHqsw=;
	b=pxJYLPxRJu0w/JTtvcLhH7QpNd0WqVbnH5IUzuzZ3xE8nbrka1hHW6WE9+NWdKH1xV7MNX
	l0XfUIwy0R7GQsDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aoIe2fSf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pxJYLPxR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745911348;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b9/w9vw/uv23dNplzSrOhyRFybaPHFS13AjaQioHqsw=;
	b=aoIe2fSfZB5xgB55Agv3Kwyv6Z6lfarh8GBSgqQpwxY3nnFMkmPsfS04E24uj9kHYmxsXC
	REDqUMBAnusXfPSw2SkyVxhZTU/mwzY0i8jjcN1N+d5yEP8QfU5vYTGScnlPhYJg5Sth5Z
	jeCokcTTyb/73kb7B+gEhQ60qv9eDxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745911348;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b9/w9vw/uv23dNplzSrOhyRFybaPHFS13AjaQioHqsw=;
	b=pxJYLPxRJu0w/JTtvcLhH7QpNd0WqVbnH5IUzuzZ3xE8nbrka1hHW6WE9+NWdKH1xV7MNX
	l0XfUIwy0R7GQsDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC9CA1340C;
	Tue, 29 Apr 2025 07:22:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RQTnKTR+EGiKbwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 29 Apr 2025 07:22:28 +0000
Date: Tue, 29 Apr 2025 09:22:27 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: merge btrfs_read_dev_one_super() into
 btrfs_read_disk_super()
Message-ID: <20250429072227.GD18094@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1745802753.git.wqu@suse.com>
 <b251d716c8cd93ee8b9ee32fdd399bd0fff28669.1745802753.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b251d716c8cd93ee8b9ee32fdd399bd0fff28669.1745802753.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: CF0CC21B52
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Apr 28, 2025 at 10:45:51AM +0930, Qu Wenruo wrote:
> -struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
> -						   int copy_num, bool drop_cache)
> -{

> -	if (btrfs_super_magic(super) != BTRFS_MAGIC) {
> -		btrfs_release_disk_super(super);
> -		return ERR_PTR(-ENODATA);
> -	}
> -
> -	if (btrfs_super_bytenr(super) != bytenr_orig) {
> -		btrfs_release_disk_super(super);
> -		return ERR_PTR(-EINVAL);
> -	}
> -
> -	return super;
> -}
> -
> -
>  struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev)
>  {
>  	struct btrfs_super_block *super, *latest = NULL;
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1401,48 +1401,62 @@ void btrfs_release_disk_super(struct btrfs_super_block *super)
>  	put_page(page);
>  }
>  
> -static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
> -						       u64 bytenr, u64 bytenr_orig)
> +struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
> +						int copy_num, bool drop_cache)
>  {
> -	struct btrfs_super_block *disk_super;
> +	struct btrfs_super_block *super;
>  	struct page *page;
> -	void *p;
> -	pgoff_t index;
> +	u64 bytenr, bytenr_orig;
> +	struct address_space *mapping = bdev->bd_mapping;
> +	int ret;
>  
> -	/* make sure our super fits in the device */
> -	if (bytenr + PAGE_SIZE >= bdev_nr_bytes(bdev))
> +	bytenr_orig = btrfs_sb_offset(copy_num);
> +	ret = btrfs_sb_log_location_bdev(bdev, copy_num, READ, &bytenr);
> +	if (ret == -ENOENT)
> +		return ERR_PTR(-EINVAL);
> +	else if (ret)
> +		return ERR_PTR(ret);
> +
> +	if (bytenr + BTRFS_SUPER_INFO_SIZE >= bdev_nr_bytes(bdev))
>  		return ERR_PTR(-EINVAL);
>  
> -	/* make sure our super fits in the page */
> -	if (sizeof(*disk_super) > PAGE_SIZE)
> -		return ERR_PTR(-EINVAL);
> +	if (drop_cache) {
> +		/* This should only be called with the primary sb. */
> +		ASSERT(copy_num == 0);
>  
> -	/* make sure our super doesn't straddle pages on disk */
> -	index = bytenr >> PAGE_SHIFT;
> -	if ((bytenr + sizeof(*disk_super) - 1) >> PAGE_SHIFT != index)
> -		return ERR_PTR(-EINVAL);
> -
> -	/* pull in the page with our super */
> -	page = read_cache_page_gfp(bdev->bd_mapping, index, GFP_KERNEL);
> +		/*
> +		 * Drop the page of the primary superblock, so later read will
> +		 * always read from the device.
> +		 */
> +		invalidate_inode_pages2_range(mapping,
> +				bytenr >> PAGE_SHIFT,
> +				(bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
> +	}
>  
> +	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
>  	if (IS_ERR(page))
>  		return ERR_CAST(page);
>  
> -	p = page_address(page);
> +	super = page_address(page);
> +	if (btrfs_super_magic(super) != BTRFS_MAGIC) {
> +		btrfs_release_disk_super(super);
> +		return ERR_PTR(-ENODATA);

This was in the other function but I think we should unify that to
-EINVAL, other filesystems do not distinguish between a failed magic
check and other errors.

