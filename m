Return-Path: <linux-btrfs+bounces-7684-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E92FA96535E
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 01:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA2A1F240B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 23:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F3518EFDD;
	Thu, 29 Aug 2024 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I3nbuZcl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MBy4siTJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TxHf9qpa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CnxTzLXo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0254918E776
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2024 23:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724973656; cv=none; b=qovRnk48hv9y4w5+Sefx5InGAMAZ3nzp6LPjFg/EgfePN9HOvhLSZhA/XdXNK3MSwEtOLl/UBLdymKjOHcPBVccEd045EkKf/NXV5ERh1ZfY3gHXLGWb9eaCwqHhMUrbEiAkeDoN4mjYYIZmEq7eu46Ay60lSNuiqJE0eaQomFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724973656; c=relaxed/simple;
	bh=jte6Z55jdAcQZ0xFNzcrdpkv6U4eoWRXbWVaetM+dLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/r1slO7TwhThEHxALWZSG9pDzYcTTIOcyJyBeyqrKb5fPwp8qXLE94M5rDVcYjsFodsvGjP9y7HB1SfOP40ukY8ptaD0wNoE+64dCmjuUEltd8MKJiuJ5x5t3bXGrQTXso+6rVRBpGxnnx4TT58+PMF/IaXS3nvK4sMR0avEL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I3nbuZcl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MBy4siTJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TxHf9qpa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CnxTzLXo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C5E61F785;
	Thu, 29 Aug 2024 23:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724973652;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+PLIlfKe9TnG8YFB2PmeTWW7tIof4LpcJz9tZf7WxVY=;
	b=I3nbuZclFT+drrzDz038ytQBLaoBmzU+TM3vYTDBBLQeJMIxrEESCeEfnKjGBxNUDzM7W5
	b2FINVLqBBJY7WpeJlF5RwdbDJtuZrYnCvg10KIKoUsbHikbT5snyLIw+pkBksRx6lNvme
	UTmyMNKDvqmUw+1pll237sEVYjITTkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724973652;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+PLIlfKe9TnG8YFB2PmeTWW7tIof4LpcJz9tZf7WxVY=;
	b=MBy4siTJVz/NJWX8rNhEIErkfNdvD85KVVnUnfDZOJihpKiO9XbSwJdrv5jotzE8rlbD2b
	vfUOgxxE6Q6HmHDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724973651;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+PLIlfKe9TnG8YFB2PmeTWW7tIof4LpcJz9tZf7WxVY=;
	b=TxHf9qpadij3PtfYatMp///CUk0XDQSD1gIIcn9D7pKqy1/ESsmRqDWhJl64YC3KEwewTR
	udSbcrnB/YBGt+yo7ADlWsbxFJoTiIYrSDGU60wVOmV4usCA8XqB0ENA5wA3UndEUQakgQ
	i8O33qVnM4jz2R+3+vG6MP3Dug1pDIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724973651;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+PLIlfKe9TnG8YFB2PmeTWW7tIof4LpcJz9tZf7WxVY=;
	b=CnxTzLXoF0Gtmp3MTUxfS35AEdBqBwbhKJiRMazIfAQJ71IHZ9i2u61XFifnJ2Sfsadomv
	tb1DnTcmunMNNjBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7DCC139B0;
	Thu, 29 Aug 2024 23:20:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NtovNFIC0WYQZQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 29 Aug 2024 23:20:50 +0000
Date: Fri, 30 Aug 2024 01:20:41 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v2 1/3] btrfs: DEFINE_FREE for btrfs_free_path
Message-ID: <20240829232041.GT25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1724785204.git.loemra.dev@gmail.com>
 <6951e579322f1389bcc02de692a696880edb2a7e.1724785204.git.loemra.dev@gmail.com>
 <20240827203058.GA2576577@perftesting>
 <20240828001601.GC25962@twin.jikos.cz>
 <Zs9ZuApvQCH4ITT9@devvm12410.ftw0.facebook.com>
 <20240828175419.GI25962@twin.jikos.cz>
 <Zs9ycrywZ/yIboGO@devvm12410.ftw0.facebook.com>
 <20240829173655.GN25962@suse.cz>
 <20240829184041.GA1560741@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829184041.GA1560741@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -2.50
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,toxicpanda.com,gmail.com,vger.kernel.org,fb.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Aug 29, 2024 at 11:40:41AM -0700, Boris Burkov wrote:
> > > so if we do add a __free, it makes sense to me
> > > to do it by the book. If we really want to avoid this double check, then
> > > we should add a comment saying that btrfs_path will never be released,
> > > so it doesn't make sense to support that pattern.
> > 
> > Sorry I don't understand this, can you please provide pseudo-code
> > examples? Why wouldn't be btrfs_path released?
> 
> I think this is just me not having a good terminology for "we used
> return_ptr or no_free_ptr". Perhaps "gave up ownership" or "gave up
> responsibility" or "canceled free" as "released" is too similar to the
> actual __free action :)
> 
> I don't have any pseudocode materially different from the example in
> cleanup.h with "btrfs_path" substituted in.
> 
> All I'm trying to accomplish in this whole discussion is emphasize that
> the extra IS_ERR_OR_NULL check is not about ensuring that btrfs_path is
> valid, but is about following the best practice for supporting the code
> reduction in the "gave up ownership" happy path. In fact, just "if (_T)"
> would be sufficient in Leo's DEFINE_FREE, for that reason.

I guess I'm reading that with my "counting instructions and branch
prediction efficiency" hat on, if there's such thing. I understand
following best practice, OTOH I can't simply ignore the practical side
of the implementation.

The ERR_PTR will never be stored to path, or there may be counter
examples. What I remember is that path is often allocated at the
beginning of the function so it usually returns -ENOMEM before anything
happens. Also path is I think never a return value but a separate
variable so mixing ERR_PTR does not happen. Please provide examples
where this does not happen, this is something that can cause problems
but I'd rather get rid of that than to take it as an eventual case to
handle.

> My taste preference here is to explicitly acknowledge that we plan to
> never give up ownership of an auto-free btrfs_path, and thus document
> that we are intentionally not including the extra NULL check. Since the
> authors of the library bothered to explicitly call it out as a pattern
> users should follow.
> 
> Thanks for entertaining this discussion, I enjoyed learning more about
> cleanup.h.

Same here, thanks. It's a new pattern and it may help us to simplify the
code, but I'd really want to avoid cases where we bend the code just to
fit the convenience macros, at the cost of making the code less obvious
due to the hidden semantics behind definitons or things like
"return_ptr".

