Return-Path: <linux-btrfs+bounces-15233-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1267AF8288
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 23:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DAC71C87FE8
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 21:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0AA28AB07;
	Thu,  3 Jul 2025 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Swvg7Ldr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wNR1xGUf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gvD+kVio";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bQ7ZGj/t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BBD2AF19
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Jul 2025 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751577622; cv=none; b=BzGCF89PKdtasVtzBeMxF6YuswhlwGahdXIHJn6g+U3jiwkZuQ5yn/oX9DCY/CoXXC4dQbp/mnV1GP1ASX+e1qTMbi+SqidE0EPGua5v4c100akPy8VJz299R6J6UGT+ZkIso/Pix2W145wiuby0z655q7xjzWJJA6/jlCfKOVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751577622; c=relaxed/simple;
	bh=xunz7BknqeisIbhorTpObjbG/C+Z7NIwSMg+uWQMDLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evEwYmoWlVBQ5UDETlvanF1xKbtYU+8Sno+GnGakccCgfxkawubeYor7vli3iOFE5IeORhEQWjfRz3/TIG8gKbkuyv1pzzcdvInxPLgjD68WPKCSiuxZMGv2Lwb6WKBuZfOt7MxQH/Y7hHJJy0m507wDVnwRJnCv/AOGFzMgcp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Swvg7Ldr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wNR1xGUf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gvD+kVio; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bQ7ZGj/t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C809A1F38A;
	Thu,  3 Jul 2025 21:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751577618;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTR4KBMtK/LnZ+RlddevfR1kekrpTmmhOFxcOzWJJqw=;
	b=Swvg7LdrEJC6udaJTdnqCfb5Hia6jte81uv8qLMk1ap9PwsSKZ0W+iicBOPwAInThOhVxB
	EDZDiPKlHgzjLe7uG4ce10JLes/CljlG9xPCbCDZXff1aAog7h+AZinfSGpeztFGHaVbKf
	a8RbsrZJuHrEPAN4qWn94Sq5Dj8jy6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751577618;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTR4KBMtK/LnZ+RlddevfR1kekrpTmmhOFxcOzWJJqw=;
	b=wNR1xGUfOP8gQR9873d/JiWoYqilQA/dj2krQlcPFtCeBhTLg3nvJZOCNrzJuC+dvhNpIZ
	AVlUVktApLyQAjBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751577616;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTR4KBMtK/LnZ+RlddevfR1kekrpTmmhOFxcOzWJJqw=;
	b=gvD+kVioLJvVdwkmaYcLNPPYoII/djm6EyrCcuhxgMqLBtTbH+j6ymGdcFYagiD6XkSsZF
	kxAbvlzXv2Z5FBwwb7Byo8OdD0UmG4jHSkf0CkEzIwrXNXJdC7ULsNd663uhgzwrONKAs/
	aoftaQWFG69E+XijNJoMgD7x0wR5JIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751577616;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTR4KBMtK/LnZ+RlddevfR1kekrpTmmhOFxcOzWJJqw=;
	b=bQ7ZGj/t86XWzjPPR/Fem9JZUF5K75Ok+Y99vh7/riuXjgNyeaQUAvEzr2QnEy06cB6h45
	XprXJiWuWZNsTwBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A61D513721;
	Thu,  3 Jul 2025 21:20:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4x8LKBD0ZmioXAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 03 Jul 2025 21:20:16 +0000
Date: Thu, 3 Jul 2025 23:20:15 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/7] btrfs: accessors: use type sizeof constants directly
Message-ID: <20250703212015.GZ31241@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1751390044.git.dsterba@suse.com>
 <eedbe03f6ee33939841d4bf895519304dfa1c59f.1751390044.git.dsterba@suse.com>
 <20250702175854.GA2308047@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702175854.GA2308047@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:replyto,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Wed, Jul 02, 2025 at 10:58:54AM -0700, Boris Burkov wrote:
> On Tue, Jul 01, 2025 at 07:23:49PM +0200, David Sterba wrote:
> > Now unit_size is used only once, so use it directly in 'part'
> > calculation. Don't cache sizeof(type) in a variable. While this is a
> > compile-time constant, forcing the type 'int' generates worse code as it
> > leads to additional conversion from 32 to 64 bit type on x86_64.
> > 
> > The sizeof() is used only a few times and it does not make the code that
> > harder to read, so use it directly and let the compiler utilize the
> > immediate constants in the context it needs. The .ko code size slightly
> > increases (+50) but further patches will reduce that again.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >  fs/btrfs/accessors.c | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
> > index b54c8abe467a06..2e90b9b14e73f4 100644
> > --- a/fs/btrfs/accessors.c
> > +++ b/fs/btrfs/accessors.c
> > @@ -52,19 +52,17 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
> >  	const unsigned long idx = get_eb_folio_index(eb, member_offset);\
> >  	const unsigned long oil = get_eb_offset_in_folio(eb,		\
> >  							 member_offset);\
> > -	const int unit_size = eb->folio_size;				\
> >  	char *kaddr = folio_address(eb->folios[idx]);			\
> > -	const int size = sizeof(u##bits);				\
> > -	const int part = unit_size - oil;				\
> > +	const int part = eb->folio_size - oil;				\
> 
> nit: the names oil and part are pretty non-sensical to me. Oil used to
> be oip for Offset In Page. Is it Offset In foLio?
> 
> I can't figure out what part should mean.

It confused me the whole time I was looking at the code, it snuck in
with the folio changes, it should have been 'oif' follwing the previous
naming pattern.

> So while I see why you're doing all the changes, I can' help but notice
> that you removed the two named variables with logical names and left the
> confusing ones. :)

So I can sneak in a patch renaming it at the beginning or at the end,
naming it 'oif' or 'foff' (there's the eb related offset as parameter so
we need some kind of distinction).

