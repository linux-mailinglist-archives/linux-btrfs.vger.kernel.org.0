Return-Path: <linux-btrfs+bounces-20299-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCC5D06329
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 22:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78A743028FD1
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 21:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003073321AA;
	Thu,  8 Jan 2026 21:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bb6VGvZF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sCmFsY6o";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L0+38SYq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+tYYT+o6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13102FD7BC
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767906266; cv=none; b=VSamET9wYdv7XYIuVkYR1XwAUPH+NurUuOuXTFXzprRHPfTxUWY6VwLu26KeC4jcqclkf/GygZzzKIum+rocJVy5HhWm26X2t1/1mPuOodsuh1uBPKq2d/9zTzORzJlS+OfPKyujDv28c/s7sm17KVFPztw6chtg+m9F8kBaKMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767906266; c=relaxed/simple;
	bh=CBE0NQF2z2efVcSJj5tsjbRwV8d2f5ZDzdNH9ZVV0GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/bxYJ423fKS8PcDLeQumGGMyNYzwUO4PcREliaFPsh470VTDZwVjTat5g5aC/QHI0ijLapn73BdC3jn1aPGT4R5wpGbww5/zw9P5osBTxLo40UB6XyL+a3tNAguXm3bhFR/tgrCsfxGdSNWAS3Sksb+IbEV+ZNn807sg6seZfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bb6VGvZF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sCmFsY6o; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L0+38SYq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+tYYT+o6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C38B35CF5C;
	Thu,  8 Jan 2026 21:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767906263;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yw52kamqy4AHpwZG9fM64GlBqxOrgJsy1pEYwFRxDz8=;
	b=Bb6VGvZFJvnoUB97/pHsLj7DskBGcaEVLqm24L1a4meomJBhQSsFRZAsZV1ZG/0VUA4i//
	5e9CDeTCOEqlNROa3VJ/5W9IeUCwlZV2vcJEDcaSnzveyZiWjQpoozHwHlp2V6YFRWG1p9
	CHlzWniQRJrHpn8MaMTroWwf9Ui/xZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767906263;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yw52kamqy4AHpwZG9fM64GlBqxOrgJsy1pEYwFRxDz8=;
	b=sCmFsY6oWcsr/PuovxnFE38E8VqG4GIiIbJZM08HkhiE4U+w+uOEDgS3nxbWZh99ABbPSC
	ZZLyElAeEWrGxZCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=L0+38SYq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+tYYT+o6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767906262;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yw52kamqy4AHpwZG9fM64GlBqxOrgJsy1pEYwFRxDz8=;
	b=L0+38SYqWO0B7VmyzYxRNId8DiiA9sYIIhBUqWxuAxhKXpDlokTYb9SSYqnfekfwrjswRq
	cIUK/sYlxWqErGKVPlUFVeFKOM6/WU0L8kdvEHe3pwUC04QJkZcUiFSyQegL6OLFV7aifr
	2hs4Mt8SimFO40gpxTTCocewS9cfo18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767906262;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yw52kamqy4AHpwZG9fM64GlBqxOrgJsy1pEYwFRxDz8=;
	b=+tYYT+o624o6oCNxro8p9N8SEYtwg+0P42jjAvPtZVNENyVCz4N6VeWG/BofwAzITGL25a
	PVfuOcFAU8AZPCCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A59C93EA63;
	Thu,  8 Jan 2026 21:04:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ed8+KNYbYGlBRgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 08 Jan 2026 21:04:22 +0000
Date: Thu, 8 Jan 2026 22:04:21 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/12] btrfs: read eb folio index right before loops
Message-ID: <20260108210421.GJ21071@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1767716314.git.dsterba@suse.com>
 <447e5571c40fef2bd83cc8c1580b2747c9eb41a3.1767716314.git.dsterba@suse.com>
 <20260107220111.GF2216040@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107220111.GF2216040@zen.localdomain>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto]
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: C38B35CF5C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Wed, Jan 07, 2026 at 02:01:11PM -0800, Boris Burkov wrote:
> On Tue, Jan 06, 2026 at 05:20:27PM +0100, David Sterba wrote:
> > There are generic helpers to access extent buffer folio data of any
> > length, potentially iterating over a few of them. This is a slow path,
> > either we use the type based accessors or the eb folio allocation is
> > contiguous and we can use the memcpy/memcmp helpers.
> > 
> > The initialization of 'i' is done at the beginning though it may not be
> > needed. Move it right before the folio loop, this has minor effect on
> > generated code in __write_extent_buffer().
> 
> This seems fine, but also pointless. One right shift that the compiler
> *can* move is causing us real pain?

Compiler can move it but it does not, probably because there's a memory
access. I'm not saying it's causing pain but that there's a fast path
when the eb->addr is valid, then the get_eb_folio_index() is simply not
done. The fast path also will apply to the large folios as this means
the address range covering extent pages is contiguous.

> How often are we reading/writing
> extent_buffers?

For metadata heavy operations all the time, often enough that extent
buffer access shows up in the perf top profiles at the top. The function
read_extent_buffer() itself not as it's for unbounded length reads from
extent buffer but otherwise it's accessing the shared structures.

> Should I be constantly worried about any arithmetic I
> ever do a hair early just to make code easier to read?

No you don't have to worry about that (too much), I assume everybody
writing C is somehow aware of various low level effects of the code but
first it should work then we go optimize that. Doing separate
optimization passes works better as there can be patterns spotted, hot
functions identified etc. We're almost out of possible algorithmic
improvements in the extent buffers realm so instruction level it is.

> Anyway, if you do think it's worth it, you can add
> 
> Reviewed-by: Boris Burkov <boris@bur.io>

Thanks. I unfortunatelly would be bothered by the code left around
because I cannot unsee it. In the long run chipping away anything that
does not need to be there would add up so we have fast code.

