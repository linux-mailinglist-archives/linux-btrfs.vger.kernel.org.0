Return-Path: <linux-btrfs+bounces-12855-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9028EA7EBB9
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 20:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9476A1884C47
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 18:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C06223335;
	Mon,  7 Apr 2025 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e502Chh4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5TA0jpGB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e502Chh4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5TA0jpGB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40518221717
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050137; cv=none; b=NATRKILKIQchswxUg53a+e48EzHwEiv77hpBGHJNOA6p/qy/sLcwYybS/UD7zVPOQtlpLVTa7fECkgW/nIltsyOH9KpmqVdPqT2MPLTmUttfNMZl20IycoyzuZlpGtQsJcuoeNhykj4WO2iSr73uiqOaG0Fi/8Tt2YxyfqftFJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050137; c=relaxed/simple;
	bh=qU6TXG8tXFHSLlky2uBOhqjfTu8DVcZ2BI26pxHrGig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1fOr8wjlcEvEVckc5pu/CK3TimZeNwCUtaaN4umMJZ1mod7oN1inJzDGbuqumc4KlVbz07pfx7McPEBTzBYzkdDNsMprz8Ed/S8tL8LzNioTAlyNs6Y5F7zzP8ClwhZTT+GXQnW3sCEFepMw9lSHkPXBDms2hIVnWSB00qdOKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e502Chh4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5TA0jpGB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e502Chh4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5TA0jpGB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 306431F388;
	Mon,  7 Apr 2025 18:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744050133;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ogad9YJCZYiOwT7m8nypALtKy6vCtf54RGdvEy/+4gE=;
	b=e502Chh4OcfstUYeoMfKubXB+DR3RD4wwGKx7r4Wn9ZT07v41jQf8NjooeVy3uUxdxK0Mc
	t88Adkvsp9I8xtxAZP9KYIEN6a8u4Brf9RG24YemLOdhVgTgpQBiH2elUjHN9K3pdqrfu7
	OeX7OJStB/fCunnHzXpZxcv/JbIeAj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744050133;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ogad9YJCZYiOwT7m8nypALtKy6vCtf54RGdvEy/+4gE=;
	b=5TA0jpGBP5GNQDsRZIN9sKG6gLYR/th45mRE36up7+Y+HKtvnXCnQHoR8HrdB+qr1Gl+jk
	SaXVrrO3Kj/uaZCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744050133;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ogad9YJCZYiOwT7m8nypALtKy6vCtf54RGdvEy/+4gE=;
	b=e502Chh4OcfstUYeoMfKubXB+DR3RD4wwGKx7r4Wn9ZT07v41jQf8NjooeVy3uUxdxK0Mc
	t88Adkvsp9I8xtxAZP9KYIEN6a8u4Brf9RG24YemLOdhVgTgpQBiH2elUjHN9K3pdqrfu7
	OeX7OJStB/fCunnHzXpZxcv/JbIeAj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744050133;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ogad9YJCZYiOwT7m8nypALtKy6vCtf54RGdvEy/+4gE=;
	b=5TA0jpGBP5GNQDsRZIN9sKG6gLYR/th45mRE36up7+Y+HKtvnXCnQHoR8HrdB+qr1Gl+jk
	SaXVrrO3Kj/uaZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B75F13691;
	Mon,  7 Apr 2025 18:22:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mIY2BtUX9GfDcAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 07 Apr 2025 18:22:13 +0000
Date: Mon, 7 Apr 2025 20:22:11 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/16] btrfs: remove extent_io_tree_to_inode() and
 is_inode_io_tree()
Message-ID: <20250407182211.GZ32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1744046765.git.fdmanana@suse.com>
 <ff5526066ce19b76e1b2b596813d480138e86699.1744046765.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff5526066ce19b76e1b2b596813d480138e86699.1744046765.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Apr 07, 2025 at 06:36:08PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> These functions aren't used outside extent-io-tree.c, but yet one of them
> (extent_io_tree_to_inode()) is unnecessarily exported in the header.
> 
> Furthermore their single use is in a pattern like this:
> 
>     if (is_inode_io_tree(tree))
>         foo(extent_io_tree_to_inode(tree), ...);
> 
> So we're effectively unnecessarily adding more indirection, checking
> twice if tree->owner == IO_TREE_INODE_IO before getting the inode and
> doing a non-inline function call to get tree->inode.

I did like that to document the special case and the conditional values
of inode depending on the tree owner.  The duplicated check of tree
owner will be unduplicated by compiler as it sees both functions.

> Simplify this by removing these helper functions and instead doing
> thing like this:
> 
>    if (tree->owner == IO_TREE_INODE_IO)
>        foo(tree->inode, ...);
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/extent-io-tree.c | 55 ++++++++++++---------------------------
>  fs/btrfs/extent-io-tree.h |  1 -
>  2 files changed, 16 insertions(+), 40 deletions(-)
> 
> diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> index d833ab2d69a1..40da61cf3f0e 100644
> --- a/fs/btrfs/extent-io-tree.c
> +++ b/fs/btrfs/extent-io-tree.c
> @@ -80,23 +80,6 @@ static inline void __btrfs_debug_check_extent_io_range(const char *caller,
>  #define btrfs_debug_check_extent_io_range(c, s, e)	do {} while (0)
>  #endif
>  
> -
> -/*
> - * The only tree allowed to set the inode is IO_TREE_INODE_IO.
> - */
> -static bool is_inode_io_tree(const struct extent_io_tree *tree)
> -{
> -	return tree->owner == IO_TREE_INODE_IO;
> -}

This was added to be clear about the semantics, which somehow still is
from the test condition itself though.

> -
> -/* Return the inode if it's valid for the given tree, otherwise NULL. */
> -struct btrfs_inode *extent_io_tree_to_inode(struct extent_io_tree *tree)
> -{
> -	if (tree->owner == IO_TREE_INODE_IO)
> -		return tree->inode;
> -	return NULL;

The two helpers can be used independently, this was meant to prevent
accidental use of fs_info in place of inode.

It's perhaps personal preference of code readability to use or not use
the trivial helpers, as this is fairly static code I don't care if it
gets simplified like that.

