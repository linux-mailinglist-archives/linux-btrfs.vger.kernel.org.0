Return-Path: <linux-btrfs+bounces-15232-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD04AF8286
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 23:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E752E3AF8D9
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 21:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5989254B19;
	Thu,  3 Jul 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cbo1S7Wn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kCQI5wK5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BGXXR14V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j/eVJe1B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B64D2AF19
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Jul 2025 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751577401; cv=none; b=FJRF+abuuM3bEr5qJAJhYP4ZVRX78ktKlgTG1/TSJ2i3rQk1K55grC8dYVc3rubPGMRRnOMPSLAy1wIP8eCnFOW0nGVa6El9uTrRO7mWrDsCP+KJ4FOvk5FEVinWITC81J8tmwRDuhZB6114ZWCGuwhQFY3YMkSbr2rlOGXQzZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751577401; c=relaxed/simple;
	bh=AfBCnAn2hag6ea23nfGtQdAYIBMBM85QmARxOshHD1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbJuSTA2HpQgghC/u2bYNxUPkpT11LlSXzQQpm8CzK2z6uAuQsVjgZ+cTJsJdAbk/X8UyUXXygZa7GMUbl3cjBt15EkMn6/Xhc/9aBn4QLl32IFSvwnLwlWK7squb3eZPhttiuhn5XVNNM09w8oirasiVBwEUnmOTPO4Yv/txmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cbo1S7Wn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kCQI5wK5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BGXXR14V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=j/eVJe1B; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7DA931F38A;
	Thu,  3 Jul 2025 21:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751577395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/vdoMpnMYJ/NpHaCOTmQu4n2+Ql72AClRPiMcPzQxk=;
	b=cbo1S7WnlSNzD73J6cP7kEmYzRsyduZAN7n0eWUxrJ79Kg10iVxCy1adNOAH/jXszo4SFF
	EaH6LXiXOg46y0Q6mwZ+VZ4r6xWkkOJwH4Lf3a/xTl8C8w4dcYj1b/01HiTwq4k/OQ0lqd
	uASxKosnZmGUHQw9gNZdJlIS8XJmTYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751577395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/vdoMpnMYJ/NpHaCOTmQu4n2+Ql72AClRPiMcPzQxk=;
	b=kCQI5wK5cGTB4H07iE4S+40FWqP8nEQYt+ojN1gH+17hJH4CoKEGdAInwaBu0vZA0hSecb
	34+weV1HtmB81iAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751577394;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/vdoMpnMYJ/NpHaCOTmQu4n2+Ql72AClRPiMcPzQxk=;
	b=BGXXR14V6bd2fLXEhcgEeA5OuwgsXO/bOZAjazMyV5MsFYr/S614pFknCDbQAgYPrcdhvq
	qaBVPoVD3UwxEOZEzvLny1PNxI3A4A0CXO6MiDgVh5Q409wzHFVqJBJc4vhZCRd1UG64i3
	2JzUqMvYNlc1xfY9jEflG4sQ2/BauIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751577394;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/vdoMpnMYJ/NpHaCOTmQu4n2+Ql72AClRPiMcPzQxk=;
	b=j/eVJe1BBC2vc0HdpydUgdowXDZcrnCDpiD650ImsI+gqrIGfLNQmlqkBfqyj5W0Q3qB7V
	cISGIZuVpeXm97CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64F3A13721;
	Thu,  3 Jul 2025 21:16:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SRBtGDLzZmipWwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 03 Jul 2025 21:16:34 +0000
Date: Thu, 3 Jul 2025 23:16:33 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/7] btrfs: accessors: inline eb bounds check and factor
 out the error report
Message-ID: <20250703211633.GY31241@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1751390044.git.dsterba@suse.com>
 <a4b1c3cd286c9217d277e67af4c11a321af6863a.1751390044.git.dsterba@suse.com>
 <20250702180055.GB2308047@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702180055.GB2308047@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Wed, Jul 02, 2025 at 11:00:55AM -0700, Boris Burkov wrote:
> > @@ -56,7 +51,10 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
> >  	const int part = eb->folio_size - oil;				\
> >  	u8 lebytes[sizeof(u##bits)];					\
> >  									\
> > -	ASSERT(check_setget_bounds(eb, ptr, off, sizeof(u##bits)));	\
> > +	if (unlikely(member_offset + sizeof(u##bits) > eb->len)) {	\
> > +		report_setget_bounds(eb, ptr, off, sizeof(u##bits));	\
> 
> For full no-change compatibility would it make sense to also ASSERT
> here? (or stuff it in report, these are the only two users)

I'm not claiming no-change here and it's implied by the changelog that
the behaviour and outcome depend on CONFIG_BTRFS_ASSEERT which I wanted
to unify.

I see the point that it should keep the assert here when things go
wrong, during development. However, the type of errors it would catch is
quite rare. Most btree items are accessed by the set/get helpers with
fixed sizes, or the read_extent_buffer/write_extent_buffer with variable
length (and they have their own bounds checks and reports).

I can add an assert or rather a debug warning to the report function so
we get a noisy report. The reason I'd like use DEBUG_WARN for that is
that we get a noisy report but don't crash so we can also observe what
happens if the function returns a this is what would happen with
non-assert configs.

For future plans, this error case will also somehow mark the filesystem
as "we have a serious problem" and let it shut down. Qu has some work
for that pending so I'll connect the two once it's done.

My idea, before the shutdown works, was to set a filesystem bit and
detect it at transaction commit to abort early. The reason is that the
set/get helpers are used everywhere without error checking, so it would
be more sensible to catch that in some selected points.

> > @@ -76,7 +74,10 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
> >  	const int part = eb->folio_size - oil;				\
> >  	u8 lebytes[sizeof(u##bits)];					\
> >  									\
> > -	ASSERT(check_setget_bounds(eb, ptr, off, sizeof(u##bits)));	\
> > +	if (unlikely(member_offset + sizeof(u##bits) > eb->len)) {	\
> > +		report_setget_bounds(eb, ptr, off, sizeof(u##bits));	\
> > +		return;							\
> > +	}								\
> 
> Would a helper macro to reduce this duplication be useful? Seems
> borderline but worth mentioning. Next time you improve it you won't
> have to hit two spots.

I don't see much reason for that, the definitions are next to each
other and once the token versions got removed the code it's basically on
one screen, hard to miss the other location.

