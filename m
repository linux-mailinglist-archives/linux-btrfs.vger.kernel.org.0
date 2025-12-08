Return-Path: <linux-btrfs+bounces-19583-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE83CAE2D6
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 21:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 771A8300C2B6
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 20:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD6F2F0C70;
	Mon,  8 Dec 2025 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tyxuCFf+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="82V3ZSs7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hUX1XGnp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4PNFJE2c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F0F2E92A3
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765227420; cv=none; b=MlOyqtD/O3R6KGMv+jQbYEDIbdW/JMM4eo1VqeYu/9FSQPif8KhfvDo75hLJLEpn5IdumQHJy5O4JxJDDODj23fXI7jwryW0wIMc4pGQvGyCrb0JdMsaUFyz1B0CGxPdNWN+lEAv2ZtBYwkXHTkkHCVzhq9OpR8zsN+A46e1Kas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765227420; c=relaxed/simple;
	bh=/9I8UmwVwQmJVZO5X9HAordiLAvGVAS3hX5u9gStSgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPLJhXGPTrLLC0pR995JvYSZ4f9/ay77mFmlhO+RNl/SzoN2BNd+t/tqNArrrpbF82ADxkHFa6xZf9+MEtQxgWjUY2218qaUDL842FZKmeahbxpVpk/Vs3Ff+/+BHcr5voY7It+o1f/B4B+pYrTFuGwvpkqqgAQEZ3Vw34K6g3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tyxuCFf+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=82V3ZSs7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hUX1XGnp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4PNFJE2c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F8F433716;
	Mon,  8 Dec 2025 20:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765227416;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00BdJ4c9UnjRA8m7350Fm2xG3DHJqbgG8f6zWFUGr+k=;
	b=tyxuCFf+MyWxjp4srVn01lKA+TgPpTU+4W39z3gnV3LV+Y7vlT2FJyxZKlLIljrKEBOxNP
	xg/ey4gSTf2MOpov4Aki+TOkxAL852HGqU6n1h+O9ZaXE+ZukhAqFerDRWMRbhP6Z6wSZj
	s+uPi7y7/JiUgAwdBgazFWSgeH5G5Rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765227416;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00BdJ4c9UnjRA8m7350Fm2xG3DHJqbgG8f6zWFUGr+k=;
	b=82V3ZSs7Pf7fMSbQZ9eNof+CqDI4I4AC8Y+4fRzTLBhU7TeqxEiy0MB6s8DY2rcB2GnKS7
	qNvY3Q98k1jMS8BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hUX1XGnp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4PNFJE2c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765227415;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00BdJ4c9UnjRA8m7350Fm2xG3DHJqbgG8f6zWFUGr+k=;
	b=hUX1XGnpE4x5foExNlNMe/2bI47X3AphjVgRB9oO1/qk6QE+Pw1BbitQMBHTYTuw7xvy3K
	rggH0kPgMfTaurGFu0KivPU4OIrYB/7pw6TnLeJHFYGjIquQ9uO0ww9rBfGabvJwx+g5pf
	K+MZry8+l79vDUCOuLFwhQvQj4bQWgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765227415;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00BdJ4c9UnjRA8m7350Fm2xG3DHJqbgG8f6zWFUGr+k=;
	b=4PNFJE2cXOoJDIhHkGMkx0jG+Pjn3NHNBN6vS+4e9TUU5+yTFZ1kJ2iBFni5xW1dg6Zs6H
	38AQ7eSJsBYD20Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2039E3EA63;
	Mon,  8 Dec 2025 20:56:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HbG2B5c7N2m8GwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 08 Dec 2025 20:56:55 +0000
Date: Mon, 8 Dec 2025 21:56:53 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs: fix an on-stack path leak and migrate to
 auto-release for on-stack paths
Message-ID: <20251208205653.GE4859@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1764106678.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1764106678.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: 2F8F433716
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Wed, Nov 26, 2025 at 08:20:19AM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Add back an early btrfs_release_path() call in
>   print_data_reloc_error()
>   This is to avoid holding the path (and its extent buffers locked)
>   during time consuming iterate_extent_inodes() calls.
> 
>   And add a comment on that early release, with updated commit message.
> 
> I thought patch "btrfs: make sure extent and csum paths are always released in
> scrub_raid56_parity_stripe()" has already taught us that tag based
> manual cleanup is never reliable, now there is another similar bug in
> print_data_reloc_error().
> 
> This time it is harder to expose, as we always imply if the function
> returned an error, they should do the proper cleanup.
> But extent_to_logical() does not follow that assumption.
> 
> The first patch is the minimal fix for backport, the second patch is
> going to solve the problem by using auto-release for all on-stack btrfs
> paths.
> 
> Qu Wenruo (2):
>   btrfs: fix a potential path leak in print_data_reloc_error()
>   btrfs: introduce BTRFS_PATH_AUTO_RELEASE() helper

Reviewed-by: David Sterba <dsterba@suse.com>

