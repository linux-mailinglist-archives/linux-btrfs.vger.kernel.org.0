Return-Path: <linux-btrfs+bounces-16511-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC83B3AE6A
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 01:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB63016DD73
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 23:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66232C3770;
	Thu, 28 Aug 2025 23:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q3FlhbfZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P5z5ptwy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q3FlhbfZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P5z5ptwy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584567082D
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 23:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756423432; cv=none; b=LRr5nrIzsEhLYIMciBsybETtKDpgNS6Thnp7DisyYDrnls52n/zYbkMiUNrqTArsPaPOs5sRbK7T+SfvODiBAJiDpMkbqYGB3Oaz6IKLWIrg2HAAwOR1FKlWLv1RrkMH6Z5IsjlUMBFeierqnGv7Mbv6VlzBvqruw+lyWFZZI0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756423432; c=relaxed/simple;
	bh=YTvCp/V/DUMjrU5LpM+U+xY/+8bjPuuF80SN6znJizg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5llSgWAP3TU068HeEhLAM+XgJeDVy8duweLsPK1x5UAWugS4S2+M5VkrjnQ9jb1Q0tH7bcNQKWdPXIszvrGBf5tMuuHDZOS0z93RccmxgAs6JWPXbuKW0++f6VxOo6IqhKvvYqhoRim2I935oMXPpMu2QJCUebqyq9X0+3BsXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q3FlhbfZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P5z5ptwy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q3FlhbfZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P5z5ptwy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4298920F9A;
	Thu, 28 Aug 2025 23:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756423428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zzH4FhkbTPLm6c2Re8317hQQumE69i9j9gGfTRSRkfE=;
	b=q3FlhbfZTS/PpkLH3DiaXASWMiFAY5e1UleDPxE6BwG+Wh9I8nwqzy1+nwwF1u6cmGzFqT
	gMuLRHQDXtqB+TmIqUmL895mOC40G2yFEolrSo/nUwEImt1WxEP5LGWd67nYlXblKgtRHH
	bGWyfgN0qyAkkQtZz1YVB29SxBgr3h4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756423428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zzH4FhkbTPLm6c2Re8317hQQumE69i9j9gGfTRSRkfE=;
	b=P5z5ptwyvj7Fc/229jAhXnFa+CfPSrjcgb5Kqyukc6ij7S/q4gBu7c9OZn1B38ADO0swk2
	OaREeuDYPpf2trBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=q3FlhbfZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=P5z5ptwy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756423428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zzH4FhkbTPLm6c2Re8317hQQumE69i9j9gGfTRSRkfE=;
	b=q3FlhbfZTS/PpkLH3DiaXASWMiFAY5e1UleDPxE6BwG+Wh9I8nwqzy1+nwwF1u6cmGzFqT
	gMuLRHQDXtqB+TmIqUmL895mOC40G2yFEolrSo/nUwEImt1WxEP5LGWd67nYlXblKgtRHH
	bGWyfgN0qyAkkQtZz1YVB29SxBgr3h4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756423428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zzH4FhkbTPLm6c2Re8317hQQumE69i9j9gGfTRSRkfE=;
	b=P5z5ptwyvj7Fc/229jAhXnFa+CfPSrjcgb5Kqyukc6ij7S/q4gBu7c9OZn1B38ADO0swk2
	OaREeuDYPpf2trBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 268C813326;
	Thu, 28 Aug 2025 23:23:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FnX/CATlsGjbRQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 28 Aug 2025 23:23:48 +0000
Date: Fri, 29 Aug 2025 01:23:46 +0200
From: David Sterba <dsterba@suse.cz>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	Filipe Manana <fdmanana@suse.com>,
	Leo Martins <loemra.dev@gmail.com>, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH] btrfs: fix subvolume deletion lockup caused by inodes
 xarray race
Message-ID: <20250828232346.GD29826@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f7e05205fd33d9e510ec1295e0cc8cfdf395cb89.1756237895.git.osandov@osandov.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e05205fd33d9e510ec1295e0cc8cfdf395cb89.1756237895.git.osandov@osandov.com>
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
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,fb.com,suse.com,gmail.com,bur.io];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 4298920F9A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.71

On Tue, Aug 26, 2025 at 01:01:38PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> There is a race condition between inode eviction and inode caching that
> can cause a live struct btrfs_inode to be missing from the root->inodes
> xarray. Specifically, there is a window during evict() between the inode
> being unhashed and deleted from the xarray. If btrfs_iget() is called
> for the same inode in that window, it will be recreated and inserted
> into the xarray, but then eviction will delete the new entry, leaving
> nothing in the xarray:
> 
> Thread 1                          Thread 2
> ---------------------------------------------------------------
> evict()
>   remove_inode_hash()
>                                   btrfs_iget_path()
>                                     btrfs_iget_locked()
>                                     btrfs_read_locked_inode()
>                                       btrfs_add_inode_to_root()
>   destroy_inode()
>     btrfs_destroy_inode()
>       btrfs_del_inode_from_root()
>         __xa_erase
> 
> In turn, this can cause issues for subvolume deletion. Specifically, if
> an inode is in this lost state, and all other inodes are evicted, then
> btrfs_del_inode_from_root() will call btrfs_add_dead_root() prematurely.
> If the lost inode has a delayed_node attached to it, then when
> btrfs_clean_one_deleted_snapshot() calls btrfs_kill_all_delayed_nodes(),
> it will loop forever because the delayed_nodes xarray will never become
> empty (unless memory pressure forces the inode out). We saw this
> manifest as soft lockups in production.
> 
> Fix it by only deleting the xarray entry if it matches the given inode
> (using __xa_cmpxchg()).
> 
> Fixes: 310b2f5d5a94 ("btrfs: use an xarray to track open inodes in a root")

Is this correct Fixes commit? The xarray conversion was done in two
steps, first the rbtree to xarray and then the locking got changed in
e2844cce75c9e6 ("btrfs: remove inode_lock from struct btrfs_root and use
xarray locks").

The root->inode_lock is an outer lock, and with rbtree it worked.  The
new code relies on xa_lock, which could be released by xarray internally
or elsewhere we need the atomic operations. Like in this case it's the
__xa_cmpxchg which I find quite unobvious regarding the xarray API and
who knows where something like it could be still missing. The simplicity
of root->inode_lock feels a bit safer.

