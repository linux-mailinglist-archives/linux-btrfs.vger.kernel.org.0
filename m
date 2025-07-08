Return-Path: <linux-btrfs+bounces-15334-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41226AFCF49
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 17:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B483A490F
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 15:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542BC261595;
	Tue,  8 Jul 2025 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZbO6WzWa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cpHKGZ5y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="opjyNf8g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EV/ZxpoP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0818A21B908
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988672; cv=none; b=B2yOwULL04gQS4AxNjqAvtORnEhFUyksDBZr9Mv2/TVTrMi3cJ+d2E7mF3WmYcpM7nmjAKv/ZYu97oxLCcIXFfUfTx6pB7BOt+2rSlsWfrpMazEJ7NYTx/vxulXR41FFMhUhVbrHm85c3pb7Sma6ZT1fCzAfdKOdqfTNYSrEpAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988672; c=relaxed/simple;
	bh=6pAIP7b4b3IbAtViMucafSL3zxftQzEN5jFVVO5o1es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjrFjSscT7ROety7kOo6c3VMabsrf5J3ucuhurBxhivW4giRhV3FKeYbbMhRtsS2HYrJwuRieSo+gBdllxaBrzOpLY4tC6lmGYmaRr6JGtzdF8MySAg0sBnVujDZaNaUCyLWsLoggMp4YMJ0UBILWKMogWJ67O7fGPGxOIezAHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZbO6WzWa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cpHKGZ5y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=opjyNf8g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EV/ZxpoP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB2F31F38D;
	Tue,  8 Jul 2025 15:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751988669;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2LdDDK4Twgf+C7pRRc5kUjrRhLgHk3V1KIqPwBR8Zl4=;
	b=ZbO6WzWaBhgWksPmO1CijgFVgpIB8m3EnKjfZPAgsLq6rwcpvNQnR/j4scDyxOe1mouryC
	HPLh29OcMKxyIncZ0sBhPM7f9IflFOsfIMjFhn5ynb2qCGQcGbuDiv17fjEC3sYxgOqtAk
	K+5fgFpR+ia+Wq06nbkk0zx6CistGPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751988669;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2LdDDK4Twgf+C7pRRc5kUjrRhLgHk3V1KIqPwBR8Zl4=;
	b=cpHKGZ5yrX0To3RR7amJHBj3pkaKuKkeK1Vx39nrMA5ZOahMEeUnjkwZLuQHDp3yKrNEyL
	7p95Uv5otMKW8NAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=opjyNf8g;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="EV/ZxpoP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751988668;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2LdDDK4Twgf+C7pRRc5kUjrRhLgHk3V1KIqPwBR8Zl4=;
	b=opjyNf8ga4nRFdzud0ncrrDSI6LavOrPjilVolF0w3VeGcci2WhoApBMMHfq99e11J8c3a
	162LdGGLhtVtPJ8vkhJH44wJr0/BaHo3gjJG70xJro+wpToUJBSbFEXcL+axPmGvxvwWY3
	uT3QVhyt+03KPq5DSfBz3rE16iqbsPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751988668;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2LdDDK4Twgf+C7pRRc5kUjrRhLgHk3V1KIqPwBR8Zl4=;
	b=EV/ZxpoPBngdo4kCOSEp40vfAaRZSo3szG28CaOyIcRg4WZggwTtbdV2h5vLk8TdYM5Pda
	e77LhSuW9PpAEBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6B2E13A54;
	Tue,  8 Jul 2025 15:31:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5mcGNLw5bWj9XQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 08 Jul 2025 15:31:08 +0000
Date: Tue, 8 Jul 2025 17:30:59 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] btrfs: use bdev_rw_virt() to read and scratch
 the disk super block
Message-ID: <20250708153059.GP4453@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1751965333.git.wqu@suse.com>
 <4726b5e8f9eb9eb985afb3a34f9e76ab7eadd1ed.1751965333.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4726b5e8f9eb9eb985afb3a34f9e76ab7eadd1ed.1751965333.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: EB2F31F38D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21

On Tue, Jul 08, 2025 at 06:36:32PM +0930, Qu Wenruo wrote:
> Currently we're using the block device page cache to read and scratch
> the super block.
> 
> This makes btrfs to poking into lower layer unnecessarily.
> 
> Change both btrfs_read_disk_super() and btrfs_scratch_superblock() to
> kmalloc() + bdev_rw_virt() to do the read and write.
> 
> This allows btrfs_release_disk_super() to be a simple wrapper of
> kfree().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/volumes.c | 46 +++++++++++++++++++++-------------------------
>  fs/btrfs/volumes.h |  5 ++++-
>  2 files changed, 25 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 31aecd291d6c..47f11e3c4a98 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1326,18 +1326,10 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>  	return ret;
>  }
>  
> -void btrfs_release_disk_super(struct btrfs_super_block *super)
> -{
> -	struct page *page = virt_to_page(super);
> -
> -	put_page(page);
> -}
> -
>  struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
>  						int copy_num, bool drop_cache)
>  {
>  	struct btrfs_super_block *super;
> -	struct page *page;
>  	u64 bytenr, bytenr_orig;
>  	struct address_space *mapping = bdev->bd_mapping;
>  	int ret;
> @@ -1362,14 +1354,19 @@ struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
>  		 * always read from the device.
>  		 */
>  		invalidate_inode_pages2_range(mapping, bytenr >> PAGE_SHIFT,
> -				      (bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
> +					(bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
>  	}
>  
> -	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
> -	if (IS_ERR(page))
> -		return ERR_CAST(page);
> +	super = kmalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
> +	if (!super)
> +		return ERR_PTR(-ENOMEM);
> +	ret = bdev_rw_virt(bdev, bytenr >> SECTOR_SHIFT, super, BTRFS_SUPER_INFO_SIZE,
> +			   REQ_OP_READ);
> +	if (ret < 0) {
> +		btrfs_release_disk_super(super);
> +		return ERR_PTR(ret);
> +	}
>  
> -	super = page_address(page);
>  	if (btrfs_super_magic(super) != BTRFS_MAGIC ||
>  	    btrfs_super_bytenr(super) != bytenr_orig) {
>  		btrfs_release_disk_super(super);
> @@ -2134,21 +2131,20 @@ static u64 btrfs_num_devices(struct btrfs_fs_info *fs_info)
>  static void btrfs_scratch_superblock(struct btrfs_fs_info *fs_info,
>  				     struct block_device *bdev, int copy_num)
>  {
> -	struct btrfs_super_block *disk_super;
> -	const size_t len = sizeof(disk_super->magic);
> +	struct btrfs_super_block *super;
>  	const u64 bytenr = btrfs_sb_offset(copy_num);
>  	int ret;
>  
> -	disk_super = btrfs_read_disk_super(bdev, copy_num, false);
> -	if (IS_ERR(disk_super))
> -		return;
> -
> -	memset(&disk_super->magic, 0, len);
> -	folio_mark_dirty(virt_to_folio(disk_super));
> -	btrfs_release_disk_super(disk_super);
> -
> -	ret = sync_blockdev_range(bdev, bytenr, bytenr + len - 1);
> -	if (ret)
> +	super = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
> +	if (!super) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	ret = bdev_rw_virt(bdev, bytenr >> SECTOR_SHIFT, super,
> +			   BTRFS_SUPER_INFO_SIZE, REQ_OP_WRITE);

Can we keep this as before, i.e. only clearing the magic? The additional
memcpy shouldn't be a problem, this is one write per device removal. The
remains of the superblock can be used for restoration or later analysis,
wipefs also only removes the signature, I'd like to keep the
compatibility.

