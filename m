Return-Path: <linux-btrfs+bounces-20300-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F46D06380
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 22:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D792301F8C7
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 21:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E87D332EBB;
	Thu,  8 Jan 2026 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ss7Y7txD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PCEBGhtV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ss7Y7txD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PCEBGhtV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69643330321
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767906874; cv=none; b=XfpX101Jk8xAXGJTswZdM39K78dMV98/W6xr1lCpNfdIgjJuWjIkeVGOoH1flWRm+mna1jaeqiVZAHlQiM1CWeZBn9blIYlmzQDgb1T87hg8z7e5AEkxfJVqnwCgaC6TD82CX3Z0gVX8QI5yWoEUM+lVbKBFRRVGaqh57Yqp+1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767906874; c=relaxed/simple;
	bh=4tL9vkcvRzmY0ASfquJBvLoKARrLRUJgQflsEcxTJ94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uC3U1b19lZRZtRcpwT0g7fuEk0w3iMgLHOybfghZFc6mTm6JrBZiKlJ5SVO2xbYcSgk4HTfn+HQIjBOILsyuR7wC2PNDZW8DUM7O2i36g4pTZATVEMriW/A9T1xisKz8OqjBJi8PP4+e114H9GThBljN02OuiFquyaCA5P4ASDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ss7Y7txD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PCEBGhtV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ss7Y7txD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PCEBGhtV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C19415CC59;
	Thu,  8 Jan 2026 21:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767906871;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKR0gSGYYtFezK46DBvHfRfhHJpOzzSBG7hXAh5Ta7A=;
	b=ss7Y7txDhLXerbDiahnFiRotb/UUblQjawPy9Tdr/GplammLoClPIzXpQA0S5+q2aW6seR
	dvrjIE0y6sLrx35eXzRB1C8v9GFJJPlLaXCxwStXg4BJ2FUw60FZSYdKM4oy7GYfZ6+IhX
	u8C19cpFrTIytGvMNnNjnCSBSFqSFRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767906871;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKR0gSGYYtFezK46DBvHfRfhHJpOzzSBG7hXAh5Ta7A=;
	b=PCEBGhtVBhB7YTxt5FSEBrXxsXM5zVlaZdird6fMEYyPdEw9uiKPfTm56/pszVbMW1TNs1
	cg04gLjZ1hZTa3Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767906871;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKR0gSGYYtFezK46DBvHfRfhHJpOzzSBG7hXAh5Ta7A=;
	b=ss7Y7txDhLXerbDiahnFiRotb/UUblQjawPy9Tdr/GplammLoClPIzXpQA0S5+q2aW6seR
	dvrjIE0y6sLrx35eXzRB1C8v9GFJJPlLaXCxwStXg4BJ2FUw60FZSYdKM4oy7GYfZ6+IhX
	u8C19cpFrTIytGvMNnNjnCSBSFqSFRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767906871;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKR0gSGYYtFezK46DBvHfRfhHJpOzzSBG7hXAh5Ta7A=;
	b=PCEBGhtVBhB7YTxt5FSEBrXxsXM5zVlaZdird6fMEYyPdEw9uiKPfTm56/pszVbMW1TNs1
	cg04gLjZ1hZTa3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A43C43EA63;
	Thu,  8 Jan 2026 21:14:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Fy3yJzceYGl9TwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 08 Jan 2026 21:14:31 +0000
Date: Thu, 8 Jan 2026 22:14:30 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/12] btrfs: zlib: remove local variable nr_dest_folios
 in zlib_compress_folios()
Message-ID: <20260108211430.GK21071@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1767716314.git.dsterba@suse.com>
 <6a4a71802a5f26209bed59b492fd07029d52686f.1767716314.git.dsterba@suse.com>
 <20260108183725.GH2216040@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108183725.GH2216040@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.com:email,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

On Thu, Jan 08, 2026 at 10:37:25AM -0800, Boris Burkov wrote:
> On Tue, Jan 06, 2026 at 05:20:32PM +0100, David Sterba wrote:
> > The value of *out_folios does not change and nr_dest_folios is only a
> > local copy, we can remove it. This saves 8 bytes of stack.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >  fs/btrfs/zlib.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> > index bb4a9f70714682..fa35513267ae42 100644
> > --- a/fs/btrfs/zlib.c
> > +++ b/fs/btrfs/zlib.c
> > @@ -158,8 +158,7 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
> >  	struct folio *in_folio = NULL;
> >  	struct folio *out_folio = NULL;
> >  	unsigned long len = *total_out;
> > -	unsigned long nr_dest_folios = *out_folios;
> > -	const unsigned long max_out = nr_dest_folios << min_folio_shift;
> > +	const unsigned long max_out = *out_folios << min_folio_shift;
> >  	const u64 orig_end = start + len;
> >  
> >  	*out_folios = 0;
> 
> I may be missing something, but it looks like it does change here?
> Then it only gets set to nr_folios at the out: label. So in the other
> two uses of nr_dest_folios, *out_folios is wrong.

You're right, the "*out_folios = 0" would have to be removed as well.
The wording was incorect, what I meant is that it was not changed until
the out label, as you say. The nr_folios and valid entries in folios are
always in sync (regarding the code flow) so removing the out_folios
initialization should be sufficient.

