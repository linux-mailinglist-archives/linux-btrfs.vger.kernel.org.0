Return-Path: <linux-btrfs+bounces-7744-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52418968EE1
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 22:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A841F2346D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 20:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160A51581F8;
	Mon,  2 Sep 2024 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0CBw84Sh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w0SEx8Bg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0CBw84Sh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w0SEx8Bg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBA41A4E7F
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725309094; cv=none; b=s16X+7GjkjuJ7q5QLfj/Uks2cCQhhpvgwdt5UhOmm37Q3hh3hOCwD6u0+J5L/UoZWkQdH4DIKbxn801rb9RuTf80FF5jYYfvR0Fo4Tla6ok3pJ2Wz5OyU0cxlQlBbtZhA6XTWpoKS4jmU12VFs/rGKSOwHPLT0Ylk8hU/OdAYzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725309094; c=relaxed/simple;
	bh=HB35RfcF7Ae2qIRsrSbU6KgP0t2m4e0c7XzbBhzrDCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R99m4+sghndLPnCKxOjYPLjNIo0d6/mhGntwji7iSTyR/GN03pnLsdi/XCWkSCHFkSlOue2QNECmtXP4+e13c010Q4WXXLvTvJgvlEfPO+hkclT+MxPOPOYWBkU8N4U9TqyjJDSca3ma1GSE3F+RUpQ5h1ty3DN5qKj7LoamMkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0CBw84Sh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w0SEx8Bg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0CBw84Sh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w0SEx8Bg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 29A3821B4C;
	Mon,  2 Sep 2024 20:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725309089;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n/6hYjqkdAhiBoeSReeGwe14t1R7qeaqg9uKKHbYD1g=;
	b=0CBw84ShkZ8JCJOi5IRcpFyPZ8LHk5elAQEhlWZGM+9cQVLv8V+Hg/JwolF+vlXvV2eqkE
	Q0JmWoNBq6uD9o3saSGzTo68Hi8tmSsZOTVsUTKz8yOOiRjzZbKMg0xlwptwp+e10htBfZ
	RySzBD9OZHEF+kevh40DtHKnSUQgAhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725309089;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n/6hYjqkdAhiBoeSReeGwe14t1R7qeaqg9uKKHbYD1g=;
	b=w0SEx8BgMlAeyLQ0eoX+2jcJibJVuURi2nfyElLxtfzD9zvWI5KuaytQGjOp9Tu6z8k2aJ
	+DVELkddpVcv5MCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0CBw84Sh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=w0SEx8Bg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725309089;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n/6hYjqkdAhiBoeSReeGwe14t1R7qeaqg9uKKHbYD1g=;
	b=0CBw84ShkZ8JCJOi5IRcpFyPZ8LHk5elAQEhlWZGM+9cQVLv8V+Hg/JwolF+vlXvV2eqkE
	Q0JmWoNBq6uD9o3saSGzTo68Hi8tmSsZOTVsUTKz8yOOiRjzZbKMg0xlwptwp+e10htBfZ
	RySzBD9OZHEF+kevh40DtHKnSUQgAhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725309089;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n/6hYjqkdAhiBoeSReeGwe14t1R7qeaqg9uKKHbYD1g=;
	b=w0SEx8BgMlAeyLQ0eoX+2jcJibJVuURi2nfyElLxtfzD9zvWI5KuaytQGjOp9Tu6z8k2aJ
	+DVELkddpVcv5MCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05C1013A21;
	Mon,  2 Sep 2024 20:31:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DOblAKEg1mbRGwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 02 Sep 2024 20:31:29 +0000
Date: Mon, 2 Sep 2024 22:31:27 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org, xuefer@gmail.com, HAN Yuwei <hrx@bupt.moe>
Subject: Re: [PATCH] btrfs: zoned: handle broken write pointer on zones
Message-ID: <20240902203127.GD26776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6a8b1550cef136b1d733d5c1016a7ba717335344.1725035560.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a8b1550cef136b1d733d5c1016a7ba717335344.1725035560.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 29A3821B4C
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:dkim];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,bupt.moe];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, Aug 31, 2024 at 01:32:49AM +0900, Naohiro Aota wrote:
> Btrfs rejects to mount a FS if it finds a block group with a broken write
> pointer (e.g, unequal write pointers on two zones of RAID1 block group).
> Since such case can happen easily with a power-loss or crash of a system,
> we need to handle the case more gently.
> 
> Handle such block group by making it unallocatable, so that there will be
> no writes into it. That can be done by setting the allocation pointer at
> the end of allocating region (= block_group->zone_capacity). Then, existing
> code handle zone_unusable properly.

This sounds like the best option, this makes the zone read-only and
relocation will reset it back to a good state. Alternatives like another
state or error bits would need tracking them and increase complexity.

> Having proper zone_capacity is necessary for the change. So, set it as fast
> as possible.
> 
> We cannot handle RAID0 and RAID10 case like this. But, they are anyway
> unable to read because of a missing stripe.
> 
> Fixes: 265f7237dd25 ("btrfs: zoned: allow DUP on meta-data block groups")
> Fixes: 568220fa9657 ("btrfs: zoned: support RAID0/1/10 on top of raid stripe tree")
> CC: stable@vger.kernel.org # 6.1+
> Reported-by: HAN Yuwei <hrx@bupt.moe>
> Cc: Xuefer <xuefer@gmail.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: David Sterba <dsterba@suse.com>

> @@ -1650,6 +1653,23 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
>  		goto out;
>  	}
>  
> +	if (ret == -EIO && profile != 0 && profile != BTRFS_BLOCK_GROUP_RAID0 &&
> +	    profile != BTRFS_BLOCK_GROUP_RAID10) {
> +		/*
> +		 * Detected broken write pointer.  Make this block group
> +		 * unallocatable by setting the allocation pointer at the end of
> +		 * allocatable region. Relocating this block group will fix the
> +		 * mismatch.
> +		 *
> +		 * Currently, we cannot handle RAID0 or RAID10 case like this
> +		 * because we don't have a proper zone_capacity value. But,
> +		 * reading from this block group won't work anyway by a missing
> +		 * stripe.
> +		 */
> +		cache->alloc_offset = cache->zone_capacity;

Mabe print a warning, this looks like a condition that should be
communicated back to the user.

