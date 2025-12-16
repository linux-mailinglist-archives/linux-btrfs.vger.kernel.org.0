Return-Path: <linux-btrfs+bounces-19801-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0146CC4922
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 18:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00E5E31064D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 17:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693922EDD5D;
	Tue, 16 Dec 2025 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C1ri0nej";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3cpY+ON9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ufJuV7fP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hWxcUFKq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99432D7DE3
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904457; cv=none; b=MlsulCGtTBvdfFw2hAp97I9ecyIUTStKN+fcOkiP9MVlnsS9um+h/Q36Ixi2nxlif7fIFL2WPJXvk2JdWE5mYAA4uuBQSS/9RXJ8suAvvwaAzFZwWiT7Ccp42pOPpvGrPNLf1F90Kfot+7mhVwTfa7xhObHXLCdaDj9B/GFKe7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904457; c=relaxed/simple;
	bh=JDUfXP73Alj6kHrklqN8TR+pe54n6JwGN1n/CszbQns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JblIYEPddazNKaVxIyhHCjcJ4UHVwK/7+0/YKeN4se4o1P0Xl8qzx2auwOlQuur8QRAMmoMnK+vijVpZo+NY+Pr0FIj+kW/lgD8ARQSf3lTpcXguk9ACF+Dvbtm4Tm8pO4OuPu0Dd8fOD9P78Kb8ocYPkG7778DRguSwPkWhQBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C1ri0nej; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3cpY+ON9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ufJuV7fP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hWxcUFKq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7777D336F6;
	Tue, 16 Dec 2025 17:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765904453;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mH2SHVi4nZf/gbzgBFtMUz+FG4+q8KTQxD/7jnwIcGg=;
	b=C1ri0nej2XdmmLQ32+/CBSGMtvAO0WDm8NYyXBaMgY+FJrfbIn0g3lgWhOWhf4sHeJNs2h
	/lZHXKoZoTsnaOegckUepD4ASnfWtzMOYg0OsmnDoX6ZnzRqhgvj/nVPGzbCBSvOoG6fId
	APEDVROjySU/djj6uQ5nDcXeKJ6R93o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765904453;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mH2SHVi4nZf/gbzgBFtMUz+FG4+q8KTQxD/7jnwIcGg=;
	b=3cpY+ON91ro6x7YMfgW1x2DWyi8gaXATUE9JV/CUbLdv/lXemz5F3IS/afzQRPfFhErx1m
	6sK3ujibS1jGLUCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ufJuV7fP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hWxcUFKq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765904452;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mH2SHVi4nZf/gbzgBFtMUz+FG4+q8KTQxD/7jnwIcGg=;
	b=ufJuV7fPVvW1IwGx2dYXs3qZTGNDOaPNqmYBYB8LPLebg0GSe9+LFxOR+nL6w/04v/CB61
	nCl1yt3+ZDr2CXluM4DzBDhbJL7jIrdVVvVG/9NcXmY2bNL/c+6IHMREhk+rTf9FfrRz3r
	xFbEslRMJEzdl4RwAuMNpC9FGxBA4A4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765904452;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mH2SHVi4nZf/gbzgBFtMUz+FG4+q8KTQxD/7jnwIcGg=;
	b=hWxcUFKqRUSe8BnqABjD/o+jMe2++y7CFhygQNipTIB21Fnoikq7jahjfGuR17xzinqRoP
	4ufD49qmhQWLk9Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 542AC3EA63;
	Tue, 16 Dec 2025 17:00:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E8tlFESQQWmqVwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 16 Dec 2025 17:00:52 +0000
Date: Tue, 16 Dec 2025 18:00:51 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/4] btrfs: don't call btrfs_handle_fs_error() after
 failure to join transaction
Message-ID: <20251216170051.GL3195@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1765899509.git.fdmanana@suse.com>
 <e6a497f1873cb9d8f7c734ffc8d4ab31641a1164.1765899509.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6a497f1873cb9d8f7c734ffc8d4ab31641a1164.1765899509.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 7777D336F6
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Tue, Dec 16, 2025 at 04:33:18PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In btrfs_find_orphan_roots() we don't need to call btrfs_handle_fs_error()
> if we fail to join a transaction. This is because we haven't done anything
> yet regarding the current root and previous iterations of the loop dealt
> with other roots, so there's nothing we need to undo. Instead log an error
> message and return the error to the caller, which will result either in
> a mount failure or remount failure (the only contextes it's called from).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/root-tree.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> index 40f9bc9485e8..a30c7bc3f0e5 100644
> --- a/fs/btrfs/root-tree.c
> +++ b/fs/btrfs/root-tree.c
> @@ -264,8 +264,9 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
>  			trans = btrfs_join_transaction(tree_root);
>  			if (IS_ERR(trans)) {
>  				ret = PTR_ERR(trans);
> -				btrfs_handle_fs_error(fs_info, ret,
> -					    "Failed to start trans to delete orphan item");
> +				btrfs_err(fs_info,
> +			  "failed to join transaction to delete orphan item: %d\n",

btrfs_err and the other helpers don't need "\n"

