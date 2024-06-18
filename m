Return-Path: <linux-btrfs+bounces-5796-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B3790DABD
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 19:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F1B1C232BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 17:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF97A13FD72;
	Tue, 18 Jun 2024 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oWu0RuKH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o2QGpGUD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oWu0RuKH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o2QGpGUD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D7C50246
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732011; cv=none; b=bY68mIM+39LePaKDYQ8piHdGQsORdYek7tnnabCHRbC4CbdV0ogQoIXF/I5GLjT6hVCfrE1DGLyJ1fuU3WbCfG67rOH7EDcLSGpVpECaD/xpbaalUGZAbYfrga3rkuwM0xUVSDNt6F5SN8xtEtHzCHj245vXn3Xp+UyoZbPJ8NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732011; c=relaxed/simple;
	bh=Qj1tKKbgMZo58vZizhviEQN26023qoV8looMZTNtW5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjmV/Wt5zvLlfcOWqfc7IA8Uk1RlefsFnjMHwTzXP4iBbEituBkhhV0rkXb2IDdtNjwIyj2v/stff1Xkl8Rk9mRJAebpnC/OFPpdV6XaUH1oUI7sh+i+E2hEAj5mmPDEoHV5j+38uj+pJHKy7yZxGJbVv+5/Ke1Pxgo8lgKyvro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oWu0RuKH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o2QGpGUD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oWu0RuKH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o2QGpGUD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D535219CF;
	Tue, 18 Jun 2024 17:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718732008;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25AhSH+lX9+dn3fHjufxC7GzndOl94fdTPthvlV2fqA=;
	b=oWu0RuKHHBP0a4Ocvrk8um8XgHzCqyyKXvojEqfzgBqvMw4HZlAr5z/FNi8NU8PL4S03Wj
	P2+27wTg1oXvzCFDn4BzfjtdkIHWbZhubB956/N7Vtu2G2px87u8esHo6T3QieKdY1OMgG
	BOdANj0oKqAlxwqVg5GLtnb3++QwtrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718732008;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25AhSH+lX9+dn3fHjufxC7GzndOl94fdTPthvlV2fqA=;
	b=o2QGpGUDk11WdveRwxfxWqJ30EOvx3BfxeL5EHZtzXyXIoH5xcZrOm7IKswYxeiBynqKLf
	z1tD79nyYeAPGlCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718732008;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25AhSH+lX9+dn3fHjufxC7GzndOl94fdTPthvlV2fqA=;
	b=oWu0RuKHHBP0a4Ocvrk8um8XgHzCqyyKXvojEqfzgBqvMw4HZlAr5z/FNi8NU8PL4S03Wj
	P2+27wTg1oXvzCFDn4BzfjtdkIHWbZhubB956/N7Vtu2G2px87u8esHo6T3QieKdY1OMgG
	BOdANj0oKqAlxwqVg5GLtnb3++QwtrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718732008;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25AhSH+lX9+dn3fHjufxC7GzndOl94fdTPthvlV2fqA=;
	b=o2QGpGUDk11WdveRwxfxWqJ30EOvx3BfxeL5EHZtzXyXIoH5xcZrOm7IKswYxeiBynqKLf
	z1tD79nyYeAPGlCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4729813AA0;
	Tue, 18 Jun 2024 17:33:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kmstEejEcWYBLwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 18 Jun 2024 17:33:28 +0000
Date: Tue, 18 Jun 2024 19:33:27 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: remove NULL transaction support for
 btrfs_lookup_extent_info()
Message-ID: <20240618173327.GJ25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <053ee6d9b396be679070a5540b3452ee6e11a7d6.1718695906.git.fdmanana@suse.com>
 <a35d5db1edc40dff98f30a46ada610ec4604114d.1718706031.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a35d5db1edc40dff98f30a46ada610ec4604114d.1718706031.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Tue, Jun 18, 2024 at 11:22:01AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There are no callers of btrfs_lookup_extent_info() that pass a NULL value
> for the transaction handle argument, so there's no point in having special
> logic to deal with the NULL. The last caller that passed a NULL value was
> removed in commit 19b546d7a1b2 ("btrfs: relocation:
> Use btrfs_find_all_leafs to locate data extent parent tree leaves").
> 
> So remove the NULL handling from btrfs_lookup_extent_info().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Remove the transaction abort logic check for NULL transaction too.
> 
>  fs/btrfs/extent-tree.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 58a72a57414a..21d123d392c0 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -126,11 +126,6 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
>  	if (!path)
>  		return -ENOMEM;
>  
> -	if (!trans) {
> -		path->skip_locking = 1;
> -		path->search_commit_root = 1;
> -	}
> -
>  search_again:
>  	key.objectid = bytenr;
>  	key.offset = offset;
> @@ -171,11 +166,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
>  			btrfs_err(fs_info,
>  			"unexpected extent item size, has %u expect >= %zu",
>  				  item_size, sizeof(*ei));
> -			if (trans)
> -				btrfs_abort_transaction(trans, ret);
> -			else
> -				btrfs_handle_fs_error(fs_info, ret, NULL);

I have a WIP to remove btrfs_handle_fs_error() and for this one I
remember there was a NULL passed somehow to the function, it was
indirectly from the tree walking helpers. But I can't find it and after
another look there seems to be a valid pointer passed all times.

Reviewed-by: David Sterba <dsterba@suse.com>

