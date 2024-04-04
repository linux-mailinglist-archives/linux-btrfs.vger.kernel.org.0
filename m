Return-Path: <linux-btrfs+bounces-3935-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1441C898F5A
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 22:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6376CB2910B
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 20:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAD7134CC2;
	Thu,  4 Apr 2024 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="toLIilv9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SWaY+AqJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="toLIilv9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SWaY+AqJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478096D1AB
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Apr 2024 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261081; cv=none; b=tfyb/t8G2fqBTWrAs0Rd8+Hg4qscxefPlGRGpizGSbUtndpshmj/fWnE8smQNkaaHmIBjSzV9KYyVdGrZ3WabYmXyGoeiXqLpUrGe5j8T2ro2u8bbWVQpWfWCpEAVutxhjzE8sAh7yokgthuJz16Zsv1DlknW/Asu8rPLNwdK5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261081; c=relaxed/simple;
	bh=M+Ncpt/1AVEb1iRL7qcHc2MrYaOISuAhk4kfK0q0qtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anR+UR0Id0jdl5xIj1N28riUgJtuf9VduycbIw4c7ptdPp3qPtMyU49OPhSRylFSPNmfMAnjL2zn/lliH4ZHqoSeTEBh0bMcSnXnQ/rD3cIGMYpOxknCrgi8Uq+fnFTxfxmJ36ruUgV1o0GRdPiR50NoD7xC5AvBmq/0aBACfEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=toLIilv9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SWaY+AqJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=toLIilv9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SWaY+AqJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 63C831F443;
	Thu,  4 Apr 2024 20:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712261076;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MLxF74/hII7CLnYkaLme7+1fbZ9743pAXuifC2Lnio4=;
	b=toLIilv9F1DBb3vgpSdUeW7TPhmlfgcpVRNqIXLKgg+oUe9zRJwMmdrM6hYkQsWevtT8wv
	Qc6yrwLgVSwYzF6JQl82iQdS2zJXpDTYQOse9QkcCvosIo/XvABkLfdZCpDmqBCYECzcRj
	m3ywazVjCwd6F2bMtyUvxTU8PS+4TKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712261076;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MLxF74/hII7CLnYkaLme7+1fbZ9743pAXuifC2Lnio4=;
	b=SWaY+AqJQYPF1T/ysJp0nQPhxVlKmvyh736LUMmUpvdk3d8hhwUcz6u5JdzlJGST2d/s39
	o/vvpBlxiFJEXDDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712261076;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MLxF74/hII7CLnYkaLme7+1fbZ9743pAXuifC2Lnio4=;
	b=toLIilv9F1DBb3vgpSdUeW7TPhmlfgcpVRNqIXLKgg+oUe9zRJwMmdrM6hYkQsWevtT8wv
	Qc6yrwLgVSwYzF6JQl82iQdS2zJXpDTYQOse9QkcCvosIo/XvABkLfdZCpDmqBCYECzcRj
	m3ywazVjCwd6F2bMtyUvxTU8PS+4TKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712261076;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MLxF74/hII7CLnYkaLme7+1fbZ9743pAXuifC2Lnio4=;
	b=SWaY+AqJQYPF1T/ysJp0nQPhxVlKmvyh736LUMmUpvdk3d8hhwUcz6u5JdzlJGST2d/s39
	o/vvpBlxiFJEXDDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C60113298;
	Thu,  4 Apr 2024 20:04:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Jv81EtQHD2ZrbwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 04 Apr 2024 20:04:36 +0000
Date: Thu, 4 Apr 2024 21:57:10 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	Julian Taylor <julian.taylor@1und1.de>,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: do not wait for short bulk allocation
Message-ID: <20240404195710.GL14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <3484c7d6ad25872c59039702f4a7c08ae72771a2.1711406789.git.wqu@suse.com>
 <20240328155746.GY14596@twin.jikos.cz>
 <ec65443a-b7ba-4c60-9cbd-23ffd45c8994@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec65443a-b7ba-4c60-9cbd-23ffd45c8994@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Fri, Mar 29, 2024 at 06:59:57AM +1030, Qu Wenruo wrote:
> >> This patch would only call memalloc_retry_wait() if failed to allocate
> >> any page for tree block allocation (which goes with __GFP_NOFAIL and may
> >> not need the special handling anyway), and reduce the latency for
> >> btrfs_alloc_page_array().
> >
> > Is this saying that it can fail with GFP_NOFAIL?
> 
> I'd say no, but never say no to memory allocation failure.

It's contradicting and looks confusing in the code, either it fails or
not.

> >> Reported-by: Julian Taylor <julian.taylor@1und1.de>
> >> Tested-by: Julian Taylor <julian.taylor@1und1.de>
> >> Link: https://lore.kernel.org/all/8966c095-cbe7-4d22-9784-a647d1bf27c3@1und1.de/
> >> Fixes: 395cb57e8560 ("btrfs: wait between incomplete batch memory allocations")
> >> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> Changelog:
> >> v2:
> >> - Still use bulk allocation function
> >>    Since alloc_pages_bulk_array() would fall back to single page
> >>    allocation by itself, there is no need to go alloc_page() manually.
> >>
> >> - Update the commit message to indicate other fses do not call
> >>    memalloc_retry_wait() unconditionally
> >>    In fact, they only call it when they need to retry hard and can not
> >>    really fail.
> >> ---
> >>   fs/btrfs/extent_io.c | 22 +++++++++-------------
> >>   1 file changed, 9 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> >> index 7441245b1ceb..c96089b6f388 100644
> >> --- a/fs/btrfs/extent_io.c
> >> +++ b/fs/btrfs/extent_io.c
> >> @@ -681,31 +681,27 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
> >>   int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
> >>   			   gfp_t extra_gfp)
> >>   {
> >> +	const gfp_t gfp = GFP_NOFS | extra_gfp;
> >>   	unsigned int allocated;
> >>
> >>   	for (allocated = 0; allocated < nr_pages;) {
> >>   		unsigned int last = allocated;
> >>
> >> -		allocated = alloc_pages_bulk_array(GFP_NOFS | extra_gfp,
> >> -						   nr_pages, page_array);
> >> +		allocated = alloc_pages_bulk_array(gfp, nr_pages, page_array);
> >> +		if (unlikely(allocated == last)) {
> >> +			/* Can not fail, wait and retry. */
> >> +			if (extra_gfp & __GFP_NOFAIL) {
> >> +				memalloc_retry_wait(GFP_NOFS);
> >
> > Can this happen? alloc_pages_bulk_array() should not fail when
> > GFP_NOFAIL is passed, there are two allocation phases in
> > __alloc_pages_bulk() and if it falls back to __alloc_pages() + NOFAIL it
> > will not fail ... so what's the point of the retry?
> 
> Yeah, that's also one of my concern.
> 
> Unlike other fses, btrfs utilizes NOFAIL for metadata memory allocation,
> meanwhile others do not.
> E.g. XFS always do the retry wait even the allocation does not got a
> page allocated. (aka, another kind of NOFAIL).
> 
> If needed, I can drop the retry part completely.

The retry logic could make sense for the normal allocations (ie. without
NOFAIL), but as it is now it's confusing. If memory management and
allocator says something does not fail then we should take it as such,
same what we do with bioset allocations of bios and do not expect them
to fail.

