Return-Path: <linux-btrfs+bounces-14423-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E16AACCDA8
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 21:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D2317120E
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 19:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB88E1F3BA4;
	Tue,  3 Jun 2025 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ou5e2IUt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VfQwGX41";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OM9c5LKM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y5AkqZ1c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6426A86359
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748979433; cv=none; b=rOD2jRvEUsfd+IEyCGmIE3JvzTpouUutEVDUZ03O+Yxw0f2QcBQpp36iCttwr4dHuMTVpxD5Jj+48yBqzoKWqUjElD7El1eqec5RU+Ze9PHFmWmN58RqyUJi6RVosAzmLzFUm01zJf+aQPPLbs/LTytJ0HnGHPM4uQbrntS1cRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748979433; c=relaxed/simple;
	bh=ZPvFtDD5er7tAzagy0bu9lW0LvAbE+nJzVXB8Pd/uGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMpB+mx/LS5pGS2MYuTkY29A0ncVwVlvhlEZyt7Ws02V5Stl3FxQb9QXKaeo+PYJ+ePC8RUP/B9U14whuzpcjQXKbS49BjBrkFuMhBfPeIqhxc7HsWfV0JBVxiDjspeGiaBbY3IxN1zgxCp1qpaRq4asCfwKWI0VEqoAJxX81H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ou5e2IUt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VfQwGX41; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OM9c5LKM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y5AkqZ1c; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED04E1F443;
	Tue,  3 Jun 2025 19:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748979429;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tzm5A2Px5qYYjiKvYPp13DWjjz56mEdTo0/7X1vXm+I=;
	b=ou5e2IUtWD9lFWOrVqpeVdi+M2XKyJbsS9gOlX6y+jdZti5bhRhNbZC1yFqKs6W3LDmcx1
	w2Er7rPND/fDph+ARurnXVAR4Cq1l5kxU51x6irQxIeCKCIM8IMz+SJDh3Rd1sc4bLF4fb
	NYPdfjuk6uVGxOHLeg4TwQ2G6lHPjvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748979429;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tzm5A2Px5qYYjiKvYPp13DWjjz56mEdTo0/7X1vXm+I=;
	b=VfQwGX419ot5fWtZujcCR1XAUwT497SNKO7iRNRaYGwczeN5JccGkydnizzk8rPZi6GXdR
	J7SoUH4fyQs1IvAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OM9c5LKM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Y5AkqZ1c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748979428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tzm5A2Px5qYYjiKvYPp13DWjjz56mEdTo0/7X1vXm+I=;
	b=OM9c5LKMw2w3wUJI04KGWsXZBD+Ea4oh6JDBvKA5Ht//RZzIH4hve4Ypu2jpjKbuSjNxDH
	MwxH1EEhT3LhOveWA2gYNrXwGPtXsQ4fXVbA+EovWE26TkiH7PHi/uCgo1VoWHjkhV8NyZ
	5ebZXJQtibarDPoESebEboeI124kvuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748979428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tzm5A2Px5qYYjiKvYPp13DWjjz56mEdTo0/7X1vXm+I=;
	b=Y5AkqZ1ckqhjl24FY90i+u6LYTOePZs08V9V79x2ByDJ20NnHBFxM7+/7xSQs+8MAWWzVh
	1RUXSRhPnSc8hQAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0CE713A92;
	Tue,  3 Jun 2025 19:37:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8wHFMuROP2i2AwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 03 Jun 2025 19:37:08 +0000
Date: Tue, 3 Jun 2025 21:36:59 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: add helper folio_end()
Message-ID: <20250603193659.GK4037@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1748938504.git.dsterba@suse.com>
 <bb27f76180bb5bc365b4917310c7bc283ba91c6b.1748938504.git.dsterba@suse.com>
 <20250603185442.GA2633115@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603185442.GA2633115@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid,suse.cz:replyto,suse.com:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: ED04E1F443
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.21

On Tue, Jun 03, 2025 at 11:54:42AM -0700, Boris Burkov wrote:
> On Tue, Jun 03, 2025 at 10:16:17AM +0200, David Sterba wrote:
> > There are several cases of folio_pos + folio_size, add a convenience
> > helper for that. Rename local variable in defrag_prepare_one_folio() to
> > avoid name clash.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >  fs/btrfs/defrag.c | 8 ++++----
> >  fs/btrfs/misc.h   | 7 +++++++
> >  2 files changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> > index 6dca263b224e87..e5739835ad02f0 100644
> > --- a/fs/btrfs/defrag.c
> > +++ b/fs/btrfs/defrag.c
> > @@ -849,7 +849,7 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
> >  	struct address_space *mapping = inode->vfs_inode.i_mapping;
> >  	gfp_t mask = btrfs_alloc_write_mask(mapping);
> >  	u64 folio_start;
> > -	u64 folio_end;
> > +	u64 folio_last;
> 
> This is nitpicky, but I think introducing the new word "last" in in an
> inconsistent fashion is a mistake.
> 
> In patch 2 at truncate_block_zero_beyond_eof() and
> btrfs_writepage_fixup_worker, you have variables called "X_end" that get
> assigned to folio_end() - 1. Either those should also get called
> "X_last" or this one should have "end" in its name.

Ok, then the "-1" should be renamed to _last, so it's "last byte of the
range", but unfortunatelly the "_end" suffix could mean the same.

> >  	struct extent_state *cached_state = NULL;
> >  	struct folio *folio;
> >  	int ret;
> > diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
> > index 9cc292402696cc..ff5eac84d819d8 100644
> > --- a/fs/btrfs/misc.h
> > +++ b/fs/btrfs/misc.h
> > @@ -158,4 +160,9 @@ static inline bool bitmap_test_range_all_zero(const unsigned long *addr,
> >  	return (found_set == start + nbits);
> >  }
> >  
> > +static inline u64 folio_end(struct folio *folio)
> > +{
> > +	return folio_pos(folio) + folio_size(folio);
> > +}
> 
> Is there a reason we can't propose this is a generic folio helper
> function alongside folio_pos() and folio_size()?

We can eventually. The difference is that now it's a local convenience
helper while in MM it would be part of the API and I haven't done the
extensive research of it's use.

A quick grep (folio_size + folio_end) in fs/ shows

     24 btrfs
      4 iomap
      4 ext4
      2 xfs
      2 netfs
      1 gfs2
      1 f2fs
      1 buffer.c
      1 bcachefs

where bcachefs has its own helper folio_end_pos() with 19 uses. In mm/
there are 2.

> Too many variables out
> there called folio_end from places that would include it?

I found only a handful of cases, so should be doable.

