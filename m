Return-Path: <linux-btrfs+bounces-11939-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F229CA49BD2
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 15:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06F516A801
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 14:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3434A26E15C;
	Fri, 28 Feb 2025 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wqFZ4oRs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7jjC+wOW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wqFZ4oRs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7jjC+wOW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CDD1AA1FA
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752613; cv=none; b=X9j+UFCKHf7BK7uwHctACnVvZyYoBHonindBJ9A5xBJVSoTLXvndilX+Kicl8G26BKnLV0ktBooz52G5mIRFheJqww5bc5fxixYPnFkKYhmi9QmrUuVD51ABV0Cjs567peY6KoUj8T875GVTwu139LwsW42lmlLs7GRY4Sd8GgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752613; c=relaxed/simple;
	bh=sGQZVklRnQRE+dFVP6IUKT5Vqpw44FER22UEbXfUCWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eon/bGyJ8HWPKiVWHndpR/2awQk/vEvNUzzqrH+TeSS9I1L28zSDArzT3M0axtuifoOlGZApMJaIK/UMTBCkRi2z5O/SZ/6o6jQKy9hY1Azi8D0k0z8qzBoVBcZ3y4tUOfXlF8sn8pUcQWXd1N4mDBGmmpYl4YHWZ7cp9j0L3O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wqFZ4oRs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7jjC+wOW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wqFZ4oRs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7jjC+wOW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17FAB1F37E;
	Fri, 28 Feb 2025 14:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740752610;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EDnmbr+qxwsft2tDTPbXB0zdOeJn9vSDG0sNO8yG4Pw=;
	b=wqFZ4oRsojjAqwKXKHSkH5sKj7NFbono3L027D5HpaYNkYctnzufiPcqsTGnT4EKbb3U5c
	Y3LyLD6jTdXiUHP+jlCOK9K4ET9iCnSeYcrrgBDwu6+IsCHlmdIzmUPvx8VHg/d6PFA3fA
	mDCwNGYI8/yeAWHZ3bGSGezVlXbAZcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740752610;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EDnmbr+qxwsft2tDTPbXB0zdOeJn9vSDG0sNO8yG4Pw=;
	b=7jjC+wOW1b5jsbJ9CCxLjOR8gXS1e3czwS6xBvloD2BpIuj5BQPJ+HCPGHKtnZ/ZAfbinf
	voiQl3O3sZbWPnBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740752610;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EDnmbr+qxwsft2tDTPbXB0zdOeJn9vSDG0sNO8yG4Pw=;
	b=wqFZ4oRsojjAqwKXKHSkH5sKj7NFbono3L027D5HpaYNkYctnzufiPcqsTGnT4EKbb3U5c
	Y3LyLD6jTdXiUHP+jlCOK9K4ET9iCnSeYcrrgBDwu6+IsCHlmdIzmUPvx8VHg/d6PFA3fA
	mDCwNGYI8/yeAWHZ3bGSGezVlXbAZcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740752610;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EDnmbr+qxwsft2tDTPbXB0zdOeJn9vSDG0sNO8yG4Pw=;
	b=7jjC+wOW1b5jsbJ9CCxLjOR8gXS1e3czwS6xBvloD2BpIuj5BQPJ+HCPGHKtnZ/ZAfbinf
	voiQl3O3sZbWPnBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8363137AC;
	Fri, 28 Feb 2025 14:23:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vntsOOHGwWfONAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 28 Feb 2025 14:23:29 +0000
Date: Fri, 28 Feb 2025 15:23:24 +0100
From: David Sterba <dsterba@suse.cz>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 1/2] btrfs: add mapping_set_release_always to inode's
 mapping
Message-ID: <20250228142324.GK5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1740168635.git.rgoldwyn@suse.com>
 <77c012d4216eb9f04e1d3cb5991bdb2cd4e7d50d.1740168635.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77c012d4216eb9f04e1d3cb5991bdb2cd4e7d50d.1740168635.git.rgoldwyn@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Fri, Feb 21, 2025 at 03:20:52PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Set mapping_set_release_always() on inode's address_space during
> inode initialization so release_folio() is always called.

This is a bit terse for an explanation but is correct. I had to look up
what it does, basically adds a flag so that folio_needs_release() is
always true.

> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/extent_io.c | 2 +-
>  fs/btrfs/file.c      | 2 +-
>  fs/btrfs/inode.c     | 3 +++
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 7b0aa332aedc..d1f9fad18f25 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -491,7 +491,7 @@ static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio *folio)
>  	if (!btrfs_is_subpage(fs_info, folio->mapping))
>  		return;
>  
> -	ASSERT(folio_test_private(folio));
> +	ASSERT(mapping_release_always(folio->mapping));
>  	btrfs_folio_set_lock(fs_info, folio, folio_pos(folio), PAGE_SIZE);
>  }
>  
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 2bf57f0e92d2..5808eb5bcd42 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -832,7 +832,7 @@ static int prepare_uptodate_folio(struct inode *inode, struct folio *folio, u64
>  	 * The private flag check is essential for subpage as we need to store
>  	 * extra bitmap using folio private.

The comment mentions private but but you're removing it so it needs an
update too.

>  	 */
> -	if (folio->mapping != inode->i_mapping || !folio_test_private(folio)) {
> +	if (folio->mapping != inode->i_mapping || !mapping_release_always(folio->mapping)) {
>  		folio_unlock(folio);
>  		return -EAGAIN;
>  	}
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ace9a3ecdefa..6424d45c6baa 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5602,6 +5602,8 @@ static int btrfs_init_locked_inode(struct inode *inode, void *p)
>  	btrfs_set_inode_number(BTRFS_I(inode), args->ino);
>  	BTRFS_I(inode)->root = btrfs_grab_root(args->root);
>  
> +	mapping_set_release_always(inode->i_mapping);
> +
>  	if (args->root && args->root == args->root->fs_info->tree_root &&
>  	    args->ino != BTRFS_BTREE_INODE_OBJECTID)
>  		set_bit(BTRFS_INODE_FREE_SPACE_INODE,
> @@ -6673,6 +6675,7 @@ static int btrfs_create(struct mnt_idmap *idmap, struct inode *dir,
>  	inode->i_fop = &btrfs_file_operations;
>  	inode->i_op = &btrfs_file_inode_operations;
>  	inode->i_mapping->a_ops = &btrfs_aops;
> +	mapping_set_release_always(inode->i_mapping);
>  	return btrfs_create_common(dir, dentry, inode);
>  }
>  
> -- 
> 2.48.1
> 

