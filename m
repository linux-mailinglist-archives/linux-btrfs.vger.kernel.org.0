Return-Path: <linux-btrfs+bounces-1796-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E624483C7A2
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 17:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7F91F2793B
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 16:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191E9129A66;
	Thu, 25 Jan 2024 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H9Ys8uqx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qhuQX0Un";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3dNS0WoW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jy8pq2G9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77DA6EB57
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199199; cv=none; b=q7eBZis5NShHjhCgE2Qajyo7XNb97DQFzoMuyNhZEM5Ncnbcu0LvjA8+9tmaSFSWWUN1MucpgM9lpKCfuHaeEb+ELyjrmslbYlfx+ng6noHDV1a5JJ2eJFdOZLoPRhR04BmBVCLlHPWIuLP+2z9vVs8Jax16SqHlU1GA6EHmXrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199199; c=relaxed/simple;
	bh=YtY2FZEHYtlpCb/8fhmE/Kq4r924jJ3vaFKicDlKg7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJ5ZfKfPWJHw3vCGToDFc34LCBjAlLzkaZVGgwFCn680adMPfcZQcQuiR/hbTuzwOPXtwRRdH4oC8hLif2WhYUzjAI8qMcNZJpMdZwHUKDsiY2pViN7OxRxfYKgIOqV8Znm2m0kA16j39kV9gW8fcDBYRGGjPklsN0IQh9iuibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H9Ys8uqx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qhuQX0Un; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3dNS0WoW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jy8pq2G9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D3B7C21EAB;
	Thu, 25 Jan 2024 16:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706199195;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jrRUMdCYz/l3w9he3I4/Tzya5MO+tH80K71UFFrK+j0=;
	b=H9Ys8uqxI9ykumzBtjFa8qzHpT558LhHsuSD7cXjcl4AvyqJ+IqNnDDgnCFfMZlVcN3CqT
	uLB+ldVzKvhPWmbWEqKT0KdQhR2LmjQZuO/Pv4sGt7PCA7yh4kq/bUb705Opfw9QgrdrrY
	/tYKal0gfZeMlj44m6eDe2hMNc16+mI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706199195;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jrRUMdCYz/l3w9he3I4/Tzya5MO+tH80K71UFFrK+j0=;
	b=qhuQX0UnP0NwQCHziFfGu+K3Xd8GaUHLHOJMaTtIiCEYwWNB3V/5RvHRRwoLVfL5bpjhxa
	OqBkMU51+14yxbDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706199194;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jrRUMdCYz/l3w9he3I4/Tzya5MO+tH80K71UFFrK+j0=;
	b=3dNS0WoWtMc74rrGxyE28cE8aoPDVlpFijfbk9ZbkySBYvQgUZwgdXkr+mBFvDAbxz2N8/
	a8vwguNgWMgw7OhDrCwctesoYuKMbqysnnwIAt/qYg7PMA4M6rGYeaZ4oBwYAb6+N4BYAX
	lUEjU1ue1aCbb5JZ1TDxEqdQgQyw0Is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706199194;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jrRUMdCYz/l3w9he3I4/Tzya5MO+tH80K71UFFrK+j0=;
	b=jy8pq2G9tsGlgWWpcQV0pFR/7dQ9Jwh+/izWDmAOagctZ3vj8nFv1G4SCmybpjVvyGda1f
	ECs+VGysciNG0gDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE3A913649;
	Thu, 25 Jan 2024 16:13:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1Pg+LpqIsmX1dQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 25 Jan 2024 16:13:14 +0000
Date: Thu, 25 Jan 2024 17:12:52 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/20] btrfs: handle block group lookup error when it's
 being removed
Message-ID: <20240125161252.GN31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706130791.git.dsterba@suse.com>
 <cfe1bf94b8a6f24407795d3e1823a187ead04570.1706130791.git.dsterba@suse.com>
 <f2eb8f2f-999f-47a6-b920-fb5ba211fe72@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2eb8f2f-999f-47a6-b920-fb5ba211fe72@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3dNS0WoW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jy8pq2G9
X-Spamd-Result: default: False [-3.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_SOME(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D3B7C21EAB
X-Spam-Level: 
X-Spam-Score: -3.01
X-Spam-Flag: NO

On Thu, Jan 25, 2024 at 02:28:02PM +1030, Qu Wenruo wrote:
> 
> 
> On 2024/1/25 07:47, David Sterba wrote:
> > The unlikely case of lookup error in btrfs_remove_block_group() can be
> > handled properly, in its caller this would lead to a transaction abort.
> > We can't do anything else, a block group must have been loaded first.
> >
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >   fs/btrfs/block-group.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index 1905d76772a9..16a2b8609989 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -1063,7 +1063,9 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
> >   	bool remove_rsv = false;
> >
> >   	block_group = btrfs_lookup_block_group(fs_info, map->start);
> > -	BUG_ON(!block_group);
> > +	if (!block_group)
> > +		return -ENOENT;
> 
> This -ENOENT return value is fine, as the only caller would call
> btrfs_abort_transaction() to be noisy enough.
> 
> And talking about btrfs_abort_transaction(), I think we can call it
> early to make debug a little easierly.

There are several patterns, one is that transaction abort is called by
the function that started it. It's not consistent but as a hint abort
can be used anywhere if things go so bad that it's impossible to roll
back, eg. in a middle of a big loop setting up block groups and such.

> > +
> >   	BUG_ON(!block_group->ro);
> 
> But shouldn't we also handle the RO case?

Of course but it's fixing a different problem with tracking of read-only
status of a bg and I will not mix that to that patch.

