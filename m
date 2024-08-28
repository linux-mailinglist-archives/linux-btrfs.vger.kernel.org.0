Return-Path: <linux-btrfs+bounces-7632-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAD5962F15
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 19:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00D67B21746
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 17:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018E21A707E;
	Wed, 28 Aug 2024 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wiRup2dX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1wzCU3e/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OH0uwNDw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+2iAAOvU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170FC149C53
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867667; cv=none; b=nZLFpq2Yb3K1Uq1wr4BncJm2XzVD4C6G++j+2lolcYNaaJmLUnnGlCTMVQagoIBetMkD+sthoTT/Dz1w4fJlkFQ9tjdB3HmCvv1XPkxeox0+JnpTVxpQhWMDpzdl0p8Aqcujcwp4w00EHVsy0A2Ld6cBFazOgDWd2CtnCxF7OP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867667; c=relaxed/simple;
	bh=n2nILpfrBkVlDUandn/apvcHhWLF7U9Rip4JSuveZ3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Azl7KXKbMi03uCGyIIQEjsv0RAbOCKaT/f+yocG9VuOFmECzVxFYawHheZauBb5/ili8M+kbH7CnGl7XQ2+49u0O7muyjp6RphzI197ud0j+/CeQacdCZGYixYAI0AxDTg+ShfSb2H8TuBUzNJalIWzTBFDws2k2ARtsi38LFw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wiRup2dX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1wzCU3e/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OH0uwNDw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+2iAAOvU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 24E1D2195F;
	Wed, 28 Aug 2024 17:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724867663;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r3zwq4rrhXyzDmK+vsb8EAzshhvI5J1tgmoIqjQZbEE=;
	b=wiRup2dXjean4g+hHXHQQY0yZPEErleZ39rQnIvUR5nxb0l4tT1iDzy50mlj4U7th93Kvy
	4hy3baVN0jixqA/gvc1aQs8G9aiNECzH2wibcCvU4YFKeFv63/hk7EleCMo0Zg+OHpUhVS
	u1vzYbTrDlIPmwOK+oXKn7zKJeGpDvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724867663;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r3zwq4rrhXyzDmK+vsb8EAzshhvI5J1tgmoIqjQZbEE=;
	b=1wzCU3e/3kdXR6tqMtsa8kmYDLKgbIrbWv6oxiRl5J8iHi8qlFER8YKa4AMMOrIOroRl1/
	hN/IyDAbArvszjAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OH0uwNDw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+2iAAOvU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724867661;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r3zwq4rrhXyzDmK+vsb8EAzshhvI5J1tgmoIqjQZbEE=;
	b=OH0uwNDwOBsSKWU0kE+/p5yR78ntLmOwQJ3dYD88gXu9joe766oUgGnETb4xeDVneEBKRq
	byfsvJ6a8hBZIE8RPQMaEKg9He/KlzukBfebbkC/sFno/N3gx9Blt2G2XdGo9esuSP5fNa
	WL6sBZ+NWDEuOXR8d35pEvk4EBA7hmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724867661;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r3zwq4rrhXyzDmK+vsb8EAzshhvI5J1tgmoIqjQZbEE=;
	b=+2iAAOvUXbkpFjB+X9rdmwsiULrdZVHPcl5EY1cYbdYY2tnDF6aRHOnNzAEg3XN3N3Z08s
	tUJO7OqXqLkleFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2F46138D2;
	Wed, 28 Aug 2024 17:54:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o6oeO0xkz2YffQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 28 Aug 2024 17:54:20 +0000
Date: Wed, 28 Aug 2024 19:54:19 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v2 1/3] btrfs: DEFINE_FREE for btrfs_free_path
Message-ID: <20240828175419.GI25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1724785204.git.loemra.dev@gmail.com>
 <6951e579322f1389bcc02de692a696880edb2a7e.1724785204.git.loemra.dev@gmail.com>
 <20240827203058.GA2576577@perftesting>
 <20240828001601.GC25962@twin.jikos.cz>
 <Zs9ZuApvQCH4ITT9@devvm12410.ftw0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs9ZuApvQCH4ITT9@devvm12410.ftw0.facebook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 24E1D2195F
X-Spam-Score: -2.71
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,toxicpanda.com,gmail.com,vger.kernel.org,fb.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Aug 28, 2024 at 10:09:12AM -0700, Boris Burkov wrote:
> On Wed, Aug 28, 2024 at 02:16:01AM +0200, David Sterba wrote:
> > On Tue, Aug 27, 2024 at 04:30:58PM -0400, Josef Bacik wrote:
> > > On Tue, Aug 27, 2024 at 12:08:43PM -0700, Leo Martins wrote:
> > > > Add a DEFINE_FREE for btrfs_free_path. This defines a function that can
> > > > be called using the __free attribute. Defined a macro
> > > > BTRFS_PATH_AUTO_FREE to make the declaration of an auto freeing path
> > > > very clear.
> > > > ---
> > > >  fs/btrfs/ctree.c | 2 +-
> > > >  fs/btrfs/ctree.h | 4 ++++
> > > >  2 files changed, 5 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > > > index 451203055bbfb..f0bdea206d672 100644
> > > > --- a/fs/btrfs/ctree.c
> > > > +++ b/fs/btrfs/ctree.c
> > > > @@ -196,7 +196,7 @@ struct btrfs_path *btrfs_alloc_path(void)
> > > >  /* this also releases the path */
> > > >  void btrfs_free_path(struct btrfs_path *p)
> > > >  {
> > > > -	if (!p)
> > > > +	if (IS_ERR_OR_NULL(p))
> > > >  		return;
> > > >  	btrfs_release_path(p);
> > > >  	kmem_cache_free(btrfs_path_cachep, p);
> > > > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > > > index 75fa563e4cacb..babc86af564a2 100644
> > > > --- a/fs/btrfs/ctree.h
> > > > +++ b/fs/btrfs/ctree.h
> > > > @@ -6,6 +6,7 @@
> > > >  #ifndef BTRFS_CTREE_H
> > > >  #define BTRFS_CTREE_H
> > > >  
> > > > +#include "linux/cleanup.h"
> > > >  #include <linux/pagemap.h>
> > > >  #include <linux/spinlock.h>
> > > >  #include <linux/rbtree.h>
> > > > @@ -599,6 +600,9 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
> > > >  void btrfs_release_path(struct btrfs_path *p);
> > > >  struct btrfs_path *btrfs_alloc_path(void);
> > > >  void btrfs_free_path(struct btrfs_path *p);
> > > > +DEFINE_FREE(btrfs_free_path, struct btrfs_path *, if (!IS_ERR_OR_NULL(_T)) btrfs_free_path(_T))
> > > 
> > > Remember to run "git commit -s" so you get your signed-off-by automatically
> > > added.
> > > 
> > > You don't need the extra IS_ERR_OR_NULL bit if the free has it, so you can keep
> > > the change above and just have btrfs_free_path(_T) here.  Thanks,
> > 
> > The pattern I'd suggest is to keep the special NULL checks in the
> > functions so it's obvious that it's done, the macro wrapping the cleanup
> > functil will be a simple call to the freeing function.
> 
> This pattern came from the cleanup.h documentation:
> https://github.com/torvalds/linux/blob/master/include/linux/cleanup.h#L11

[...] @free should typically include a NULL test before calling a function

Typically yes, but we don't need to do it twice.

> As far as I can tell, it will only be relevant if we end up using the
> 'return_ptr' functionality in the cleanup library, which seems
> relatively unlikely for btrfs_path.

So return_ptr undoes __free, in that case we shouldn't use it at all,
the macros obscure what the code does, this is IMHO taking it too far.

