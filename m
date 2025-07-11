Return-Path: <linux-btrfs+bounces-15466-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E914B019E3
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 12:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DA618961D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 10:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715C328643F;
	Fri, 11 Jul 2025 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l4HXst/9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vqjnejMO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L1ADgsUn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YgNsJB19"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F297283C8E
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752230339; cv=none; b=i2KGbuYDtIwpRgq4U7GvjEKfv8lv1Yqj2+FwsMSDrR1YlnJgK4SYpzWgTfAZ2JmcgTTApjV0r8jZ4LzfkdHW1jG6UlZ+MaHCxrTCJv/4T2oXYzFRQ2w589+4u/m6Lkmik36gQ5+BJR9zPz8vfCtu1jfMUlTMq0/7Z16C4PW6MPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752230339; c=relaxed/simple;
	bh=vZoyTIqBjCed0WZgn8UM/xZDVJ6f++X4N+3g6Dz00BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLHq1DehyRGpz2mnc5olw83udGM6oWXfEURCbdQPYLj0dJLlZQw63vnRFCZzLRHvdzQ79yMfWYL3PqeGdO6wFhnaFmOsrX6yWPFRNEFHXXOT0tN16cIFeDq5G1Z/masI6GWySW+lzm89qfXF/JN5nkyGsWvF6ST+W1IiAipr4yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l4HXst/9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vqjnejMO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L1ADgsUn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YgNsJB19; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17BCA1F385;
	Fri, 11 Jul 2025 10:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752230336;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/jqA/JSEVNqv4mDubdSCGZvGUFeMv71w182cZ40O10=;
	b=l4HXst/9DvfbdnyBzi9iudSVgQ5Fd/3HKaCNdKteoXKjxKTtbQjmP5LQSAmljnBZ4nSJo5
	PZyGKro2C7ebJ3CMERuw+KHstWbiueg3bV+9vBvRTQIab4zVeiqmyrvDut4pO/A92UCxr8
	CF5xPqDQ5lGbwlJ0ybD3Kao6Jiafyao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752230336;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/jqA/JSEVNqv4mDubdSCGZvGUFeMv71w182cZ40O10=;
	b=vqjnejMOsR5tkR8j/6CLeN4YFmf8OE94E3yFgn/lm6f3S3Y689Y1OQcMt+G27ZuMSh81j5
	I7P5SWprXR/BgBAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=L1ADgsUn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YgNsJB19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752230335;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/jqA/JSEVNqv4mDubdSCGZvGUFeMv71w182cZ40O10=;
	b=L1ADgsUnIT2JS1Qhe/AAwyC8ho0xR+iMLwKlfArmz4KPt6CaZIgAszGVNY7F3Tdntg++9g
	OMBPhRn1KOCZaRrxOXBHuDKm0qExQj2tGRiqnmnFosPNGFjRFzgTyG9wOFsp/euAOnzwe9
	rQAAj7EGx+o3yx8eTTbHGDyI2lf3Iyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752230335;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/jqA/JSEVNqv4mDubdSCGZvGUFeMv71w182cZ40O10=;
	b=YgNsJB19XbqFJg8nijUr4uZVxn9hoBR1ZX1WoO2qSoKgzL3CKduXNSojSpdhrFFVQfViGj
	e1XDwjLVyimEzXAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECFAC138A5;
	Fri, 11 Jul 2025 10:38:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OYiUOb7pcGg6BAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 11 Jul 2025 10:38:54 +0000
Date: Fri, 11 Jul 2025 12:38:53 +0200
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, jlayton@kernel.org
Subject: Re: [PATCH] btrfs: implement ref_tracker for delayed_nodes
Message-ID: <20250711103853.GC22472@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <fa19acf9dc38e93546183fc083c365cdb237e89b.1752098515.git.loemra.dev@gmail.com>
 <CAL3q7H5pDTDK6zOj_85dNTbARcfaTHwqZXOGbZ-We0N5Jg8rtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5pDTDK6zOj_85dNTbARcfaTHwqZXOGbZ-We0N5Jg8rtQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,fb.com,kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,twin.jikos.cz:mid,suse.cz:replyto,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 17BCA1F385
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.71

On Thu, Jul 10, 2025 at 12:54:34PM +0100, Filipe Manana wrote:
> > @@ -63,10 +109,18 @@ struct btrfs_delayed_node {
> >         struct rb_root_cached del_root;
> >         struct mutex mutex;
> >         struct btrfs_inode_item inode_item;
> > +
> >         refcount_t refs;
> > -       int count;
> > +       /* Used to track all references to this delayed node. */
> > +       btrfs_delayed_node_ref_tracker_dir ref_dir;
> > +       /* Used to track delayed node reference stored in node list. */
> > +       btrfs_delayed_node_ref_tracker node_list_tracker;
> > +       /* Used to track delayed node reference stored in inode cache. */
> > +       btrfs_delayed_node_ref_tracker inode_cache_tracker;
> > +
> >         u64 index_cnt;
> >         unsigned long flags;
> > +       int count;
> 
> Why are you moving the count field?
> This increases the size of the struct even without the new config
> option enabled and as a result we get less objects per page.
> You are essentially reverting this commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a20725e1e7014642fc8ba4c7dd2c4ef6d4ec56a9
> 
> Without any explanation about why.
> 
> I'm also not a big fan of the typedefs and would prefer to have
> struct ref_tracker used directly in the structure surrounded by an
> #ifdef block.

Agreed, we use typedefs only for function callbacks, for variable types
not anymore.

> I also don't like adding a new Kconfig option just for this... How
> much slower would a build with CONFIG_BTRFS_DEBUG=y be?
> 
> If that's really a lot slower, then perhaps a more generic config
> option name in case we add similar tracking to other data structures
> one day.

Right, we want to keep the config options at minimum and for debugging
features it should be fine under BTRFS_DEBUG. If this needs to be
configured for performance reasons then it can be a mount option, same
as we have ref-verify or fragment already.

