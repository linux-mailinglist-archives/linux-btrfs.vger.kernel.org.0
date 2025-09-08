Return-Path: <linux-btrfs+bounces-16733-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 059BEB49869
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 20:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3C23B2F7E
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 18:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4515331B13F;
	Mon,  8 Sep 2025 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uh+IySZG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vr0Gn2Sh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uh+IySZG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vr0Gn2Sh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC98314B76
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757356622; cv=none; b=lNWovUJyrJVYSrG18PoYbJRsif1M78T02k8vxCQZCmiuczRfdFYHZPsXyvUvN0Ltg7TTzxHIW1OMVwCvSYPQKXm+innjHoFnQcy2ASzXcNj+4eeeqM1zWCs371VuV3JQhm7s6zunr/2cznDaKwAXiDbRgMO5PJvttUYionFoIaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757356622; c=relaxed/simple;
	bh=dNPd2jaIoSxmMwM6gZwoW01LukoBINlkeqPz3vWUTw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgIDVRctoOP0jBZuGgDKJFqYjWCF56ue1j229uQ+pYL8CYNrUZNYHGIEemAMvW+lxB0WtzjDYW2//SCa2Kaz1nrjX5ZfdIsaqUF/94fna6uKv1cd4jDSsYs0fC221FCx7LD4JUt8jhSiz9HKDyZwpL3anxTSv4vlZC6vrEjtWs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uh+IySZG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vr0Gn2Sh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uh+IySZG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vr0Gn2Sh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9BD272808E;
	Mon,  8 Sep 2025 18:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757356616;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G82WHAZamp3Qi5/JZDJfeWWFJSIuocxuyYdN+PzYvAY=;
	b=uh+IySZG+KA8k9Y/wuO0JXtd4ulbMRTNn94jgmt41AoXxXgR4JM4ECYc5w2gCKvD1vlvPX
	0xq58gxOg5Ud2t793AYRkhMlyZgDMxorvTjmXd9jjI/iVKOrkvPobO5ENggVmMMILoGOhE
	UMSTOIqXmEBzsor9jjq4NFtn13uJwpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757356616;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G82WHAZamp3Qi5/JZDJfeWWFJSIuocxuyYdN+PzYvAY=;
	b=vr0Gn2SheIgEO3lrh1g+XntVFQbV789RAvIACBOcLwr32yYdX9xKOgeV/QMPt+hn4lkpeN
	r4XngDq/UmOTivAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757356616;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G82WHAZamp3Qi5/JZDJfeWWFJSIuocxuyYdN+PzYvAY=;
	b=uh+IySZG+KA8k9Y/wuO0JXtd4ulbMRTNn94jgmt41AoXxXgR4JM4ECYc5w2gCKvD1vlvPX
	0xq58gxOg5Ud2t793AYRkhMlyZgDMxorvTjmXd9jjI/iVKOrkvPobO5ENggVmMMILoGOhE
	UMSTOIqXmEBzsor9jjq4NFtn13uJwpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757356616;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G82WHAZamp3Qi5/JZDJfeWWFJSIuocxuyYdN+PzYvAY=;
	b=vr0Gn2SheIgEO3lrh1g+XntVFQbV789RAvIACBOcLwr32yYdX9xKOgeV/QMPt+hn4lkpeN
	r4XngDq/UmOTivAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E3B013A54;
	Mon,  8 Sep 2025 18:36:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rkarHkgiv2g0FgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 08 Sep 2025 18:36:56 +0000
Date: Mon, 8 Sep 2025 20:36:55 +0200
From: David Sterba <dsterba@suse.cz>
To: David Laight <david.laight.linux@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: replace max_t()/min_t() with clamp_t() in
 scrub_throttle_dev_io()
Message-ID: <20250908183655.GT5333@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250901150144.227149-2-thorsten.blum@linux.dev>
 <20250906122458.75dfc8f0@pumpkin>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906122458.75dfc8f0@pumpkin>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.50

On Sat, Sep 06, 2025 at 12:24:58PM +0100, David Laight wrote:
> On Mon,  1 Sep 2025 17:01:44 +0200
> Thorsten Blum <thorsten.blum@linux.dev> wrote:
> 
> > Replace max_t() followed by min_t() with a single clamp_t(). Manually
> > casting 'bwlimit / (16 * 1024 * 1024)' to u32 is also redundant when
> > using max_t(u32,,) or clamp_t(u32,,) and can be removed.
> > 
> > No functional changes intended.
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  fs/btrfs/scrub.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> > index 6776e6ab8d10..ebfde24c0e42 100644
> > --- a/fs/btrfs/scrub.c
> > +++ b/fs/btrfs/scrub.c
> > @@ -1369,8 +1369,7 @@ static void scrub_throttle_dev_io(struct scrub_ctx *sctx, struct btrfs_device *d
> >  	 * Slice is divided into intervals when the IO is submitted, adjust by
> >  	 * bwlimit and maximum of 64 intervals.
> >  	 */
> > -	div = max_t(u32, 1, (u32)(bwlimit / (16 * 1024 * 1024)));
> > -	div = min_t(u32, 64, div);
> > +	div = clamp_t(u32, bwlimit / (16 * 1024 * 1024), 1, 64);
> 
> That probably ought to have a nack... although it isn't different.
> bwlimit is 64bit, if very big dividing by 16M will still be over 32 bits.
> and significant bits will be lost.
> 
> Just use clamp() without all the extra (bug introducing) (u32) casts.

Clamp without type works best, thanks. The bug with large values could
happen, but the input value is expected to be in gigabytes range.

