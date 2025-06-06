Return-Path: <linux-btrfs+bounces-14533-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BE2AD077E
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 19:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF8817ADDE
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 17:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE93628A731;
	Fri,  6 Jun 2025 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V9Jl3/Ml";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dihhV7pM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V9Jl3/Ml";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dihhV7pM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987BD28A71B
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749230897; cv=none; b=LX7oR3cWdNEW8ot1KYtr3kifemvsah5SH3KL7AfFxJsxSpX1/VpJNlMwyhve2P/gmnR3opS9ligIZcNkmTEMI1EWmbeNCe7LZmjOMDggqHJgBQwt7RjANqDbM0F7T3zZud/KJwQAJq/EVEYyIc2LEP2NXgZr6TZt10AWEXuc4wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749230897; c=relaxed/simple;
	bh=2OmHS4d4LLkJyCDJRd0Sh2nA9xIIDRgfYtuAClUrl1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WN+c9PGjshAG/WOD5B/a37mhRHZu8enRx87jah+209acnrLBdxdz13PlGAOQYK+iept1/MzVAFWwfGa1kPCAUpf2FvViu6IL07RY21xUIHU9CcI1yH42mpfCpZSIBGlNxVjqzFMRtxxgNUiQD6E3j+0oHlknbZ4uhSCiFwzinDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V9Jl3/Ml; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dihhV7pM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V9Jl3/Ml; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dihhV7pM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C47B7336B1;
	Fri,  6 Jun 2025 17:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749230892;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qep49SCoIb7Px0X63pnsLPhhPKdUjmluUs+NJCFgizs=;
	b=V9Jl3/MlQVoXXhhjRP86nJlbiLlj2JDmEeNQOGHMXZP/5bl5haWhz3MKADVJK+hN/WOFMB
	cpCbJDblrrVK8gK8HZqM8BkYiDUmx+0xK7gpK94E6OK259z8crUdFhmFv4qZra9BuYTy9N
	8eVGYTa87rxN26/93dXorPRRCKf26kM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749230892;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qep49SCoIb7Px0X63pnsLPhhPKdUjmluUs+NJCFgizs=;
	b=dihhV7pMKSJMjLo2E7Iq2gLt9tt0LMWsM/vG+m0D0aoXmhmbrx6l/nkxeTUpKDlU/j/Lt9
	uwr9ZViXFA44m9Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749230892;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qep49SCoIb7Px0X63pnsLPhhPKdUjmluUs+NJCFgizs=;
	b=V9Jl3/MlQVoXXhhjRP86nJlbiLlj2JDmEeNQOGHMXZP/5bl5haWhz3MKADVJK+hN/WOFMB
	cpCbJDblrrVK8gK8HZqM8BkYiDUmx+0xK7gpK94E6OK259z8crUdFhmFv4qZra9BuYTy9N
	8eVGYTa87rxN26/93dXorPRRCKf26kM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749230892;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qep49SCoIb7Px0X63pnsLPhhPKdUjmluUs+NJCFgizs=;
	b=dihhV7pMKSJMjLo2E7Iq2gLt9tt0LMWsM/vG+m0D0aoXmhmbrx6l/nkxeTUpKDlU/j/Lt9
	uwr9ZViXFA44m9Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A86AE1336F;
	Fri,  6 Jun 2025 17:28:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HbecKCwlQ2g7UAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 06 Jun 2025 17:28:12 +0000
Date: Fri, 6 Jun 2025 19:28:11 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: index buffer_tree using node size
Message-ID: <20250606172811.GY4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250512172321.3004779-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512172321.3004779-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
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
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 

On Mon, May 12, 2025 at 07:23:20PM +0200, Daniel Vacek wrote:
> So far we are deriving the buffer tree index using the sector size. But each
> extent buffer covers multiple sectors. This makes the buffer tree rather sparse.
> 
> For example the typical and quite common configuration uses sector size of 4KiB
> and node size of 16KiB. In this case it means the buffer tree is using up to
> the maximum of 25% of it's slots. Or in other words at least 75% of the tree
> slots are wasted as never used.
> 
> We can score significant memory savings on the required tree nodes by indexing
> the tree using the node size instead. As a result far less slots are wasted
> and the tree can now use up to all 100% of it's slots this way.
> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>

This is a useful improvement, so we should continue and merge it. The
performance improvements should be done so we get some idea. Runtime and
slab savings.

One coding comment, please rename node_bits to nodesize_bits so it's
consistent with sectorsize and sectorsize_bits.

>  fs/btrfs/disk-io.c   |  1 +
>  fs/btrfs/extent_io.c | 30 +++++++++++++++---------------
>  fs/btrfs/fs.h        |  3 ++-
>  3 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5bcf11246ba66..dcea5b0a2db50 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4294,9 +4294,9 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
>  {
>  	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
>  	struct extent_buffer *eb;
> -	unsigned long start = folio_pos(folio) >> fs_info->sectorsize_bits;
> +	unsigned long start = folio_pos(folio) >> fs_info->node_bits;
>  	unsigned long index = start;
> -	unsigned long end = index + (PAGE_SIZE >> fs_info->sectorsize_bits) - 1;
> +	unsigned long end = index + (PAGE_SIZE >> fs_info->node_bits) - 1;

This looks a bit suspicious, page size is 4k node size can be 4k .. 64k.
It's in subpage code so sector < page, the shift it's always >= 0. Node
can be larger so the shift result would be 0 but as a result of 4k
shifted by "16k".

>  	int ret;
>  
>  	xa_lock_irq(&fs_info->buffer_tree);
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index cf805b4032af3..8c9113304fabe 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -778,8 +778,9 @@ struct btrfs_fs_info {
>  
>  	struct btrfs_delayed_root *delayed_root;
>  
> -	/* Entries are eb->start / sectorsize */
> +	/* Entries are eb->start >> node_bits */
>  	struct xarray buffer_tree;
> +	int node_bits;

u32 and pleas move it to nodesize.

