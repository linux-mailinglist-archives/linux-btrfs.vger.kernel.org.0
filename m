Return-Path: <linux-btrfs+bounces-11972-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74158A4BA16
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 09:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23ECD16E618
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 08:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30DC1EFFA2;
	Mon,  3 Mar 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zPU1jUTC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nb3AJfoH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zPU1jUTC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nb3AJfoH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF6D18C937
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992238; cv=none; b=akzIAI2I06N7KgiSwGHtGtOYwTUvKjwle+vwkeedclPVaxFxacuoNYGJXrmbQJvUhUbl3w2x1peV8P1IpjZRb83nf7uDyHB09g1777Pgny8Qsj5WUrhFQiOm378cm3frFhG4aR7phiW1KZiFm1TNbOis+d/H+fWsnqXo57YCRmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992238; c=relaxed/simple;
	bh=ozQD7NhbvP5n2EDC2J8MM2z9vqAvUBNkp4VGNmTKgZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5IruvfBp+MVlZyarbu93oBKE5TuayWTNWI0EWmbuwpLJsETxPKsSenXdEnk85Hd9nwFzuliT0n+samZxcES/A+pnFf9KhQ5APUZSlcUF7FIfMhSguzccS2xzYFCsK4cUjrOHWFOMntQ5Rlk7Kp9a+VTzDC+OJ5lKGpXt9QLyNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zPU1jUTC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nb3AJfoH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zPU1jUTC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nb3AJfoH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 579611F393;
	Mon,  3 Mar 2025 08:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740992233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4OJQNAwQqnH9E1ug+3mkwEBkyq2DIm/G1zJglXtgNnA=;
	b=zPU1jUTCyKawDTbJzr9lpThqkgvMIeAMXIz0t3wYyx/xCjJbbLv1R5kgN0H9ZAMBUNCGV0
	M7WjBy3uQQU5qiZFAlg7MguOyF9/w77OmGrdwnHqDyq1B9O9P5yMBf/s4jpJHE4e/7Gzir
	Oopytg94IHNjKauKqrpvWosZr+ocPZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740992233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4OJQNAwQqnH9E1ug+3mkwEBkyq2DIm/G1zJglXtgNnA=;
	b=nb3AJfoHPpJF/C7LjfYwTbkHE/FdJ+3BCGw7fEn3qwR5tQ3637E3E8mXXzwIJ1hT1nckSu
	XXd8pmuQ7DwxS4Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zPU1jUTC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nb3AJfoH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740992233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4OJQNAwQqnH9E1ug+3mkwEBkyq2DIm/G1zJglXtgNnA=;
	b=zPU1jUTCyKawDTbJzr9lpThqkgvMIeAMXIz0t3wYyx/xCjJbbLv1R5kgN0H9ZAMBUNCGV0
	M7WjBy3uQQU5qiZFAlg7MguOyF9/w77OmGrdwnHqDyq1B9O9P5yMBf/s4jpJHE4e/7Gzir
	Oopytg94IHNjKauKqrpvWosZr+ocPZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740992233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4OJQNAwQqnH9E1ug+3mkwEBkyq2DIm/G1zJglXtgNnA=;
	b=nb3AJfoHPpJF/C7LjfYwTbkHE/FdJ+3BCGw7fEn3qwR5tQ3637E3E8mXXzwIJ1hT1nckSu
	XXd8pmuQ7DwxS4Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 307F513939;
	Mon,  3 Mar 2025 08:57:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pl9gC+luxWeCdwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 03 Mar 2025 08:57:13 +0000
Date: Mon, 3 Mar 2025 09:57:11 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 1/8] btrfs: disable uncached writes for now
Message-ID: <20250303085711.GT5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1740990125.git.wqu@suse.com>
 <25f0ab13b113ff37ae66cab26be7e458321db74f.1740990125.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25f0ab13b113ff37ae66cab26be7e458321db74f.1740990125.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 579611F393
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,infradead.org:email,twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Mon, Mar 03, 2025 at 07:05:09PM +1030, Qu Wenruo wrote:
> Currently btrfs calls folio_end_writeback() inside a spinlock, to
> prevent races of async extents for the same folio.
> 
> The async extent mechanism is utilized for compressed writes, which
> allows a folio (or part of a folio) to be kept locked, and queue the
> range into a workqueue and do the compression.
> After the compression is done, then submit the compressed data and set
> involved blocks writeback and unlock the range.
> 
> Such the async extent mechanism disrupts the regular writeback behavior,
> where normally we submit all the involved blocks inside the same folio
> in one go.
> Now with async extent parts of the same folio can be randomly marked
> writeback at any time, by different threads.
> 
> Thus for fs block size < page size cases, btrfs always hold a spinlock
> when setting/clearing the folio writeback flag, to avoid async extents
> to race on the same folio.
> 
> But now with the dropbehind folio flag, folio_end_writeback() is no longer
> safe to be called inside a spinlock:
> 
>   folio_end_writeback()
>   |- folio_end_dropbehind_write()
>      |- if (in_task() && folio_trylock())
>         |  Since all btrfs endio functions happen inside a workqueue,
> 	|  it will always pass in_task() check.
> 	|
>         |- folio_unmap_invalidate()
> 	   |- folio_launder()
> 	      !! MAY SLEEP !!
> 	      And there is no gfp flag to let the fs to avoid sleeping.
> 
> Furthermore, for fs blocks < page size cases, we can even deadlock on
> the same subpage spinlock:
> 
>  btrfs_subpage_clear_writeback()
>  |- spin_lock_irqsave(&subpage->lock)
>  |- folio_end_writeback()
>     |- folio_end_dropbehind_write()
>        |- folio_unmap_invalidate()
>           |- filemap_release_folio()
> 	     |- __btrfs_release_folio()
> 	        |- wait_subpage_spinlock()
> 		   |- spin_lock_irq(&subpage->lock);
>                    !! DEADLOCK !!
> 
> So for now let's disable uncached write for btrfs, until we solve
> all problems with planned solutions:
> 
> - Use atomic to trace writeback status
>   Need to remove the COW fixup (handling of out-of-band dirty folio)
>   routine first and align the member to iomap_folio_status structure
>   first.
> 
> - Better async extent handling
>   Instead of leaving the folios locked and set writeback flag after
>   compression, change it to set writeback flags then start compression.
> 
> Fixes: fcc7e3306e11 ("btrfs: add support for uncached writes (RWF_DONTCACHE)")

The commit id will change so it's better to refer to it just by the
subject and not put it to Fixes.

> Cc: Jens Axboe <axboe@kernel.dk>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Thankfully the btrfs uncached writes patch is not yet pushed to
> upstream, I can remove it from for-next branch if this patch got enough
> reviews.
> 
> But I prefer not to, as that commit still contains some good cleanup on
> the FGP flags.

Thanks for catching the problems early.

This is not the cleanest way but in the long run we want the uncached
writes so with the preparatory patch merged and disabled by one line it
should be easier to test it. Also want to keep your analysis of the
deadlock in a visible place like changelog so we can refer to it.

