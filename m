Return-Path: <linux-btrfs+bounces-11877-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A684A463F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 16:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213F9171B07
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 15:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94DC22424B;
	Wed, 26 Feb 2025 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yRTHuO5l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="go7j7OTr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yRTHuO5l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="go7j7OTr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A8E223706
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582048; cv=none; b=HV7rBdoHobLoaZc3KxYmtoM/puvHcQxlhEf4ktRfbJB3ovbo5PM6FdX/b5Gs5k89qQKrkmw1T7osaq3Yg38cUsks969zdKh1aNk/JhO8zcJkAAjq9IcjFT4vmdlWSZsVQzTXAeKeK/z7vaxlGHefjVqCL93WeSskdNfjIEifScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582048; c=relaxed/simple;
	bh=0oWmWe3SseKXfTXZNUeeJM1kbadlesoNXEtNEma0I4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qguiyTkC6/r7YSHcpkQvclpwgBq6MeKNQwHTs75kCGE0i8JLe8rkwTsa/aHmN+8SjQv3m9Xl2OKBvm7Wy04X9bE98qWfvp2lZF4fdjw2Z+UQ6CPAKCYPynMLUo8iHngz3Sk/4SYAmhlUDjwrgQbbZjPIzQDrtO8+7gJcSXcQ4G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yRTHuO5l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=go7j7OTr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yRTHuO5l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=go7j7OTr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E5BE1F388;
	Wed, 26 Feb 2025 15:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740582043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UVVorH37MCFSJ8eBr7mIIBXtxKR/7OGM0uGrvqyOHyE=;
	b=yRTHuO5ltZF5t4rc8/RvW1o2lrdAKnhMvUQTXZTJEWU8JROBFPtr5u0hdOJ1oMN0ddwVIb
	UWaVCp0CeDQwiSNBdLh2m0qa5Kjapvqr7QSaJpJfhJ52AvTx4q7MvdnoF2yivI1mgrlb2A
	4WwkPkiCJ3g8DJWH9J3smqa1sRulpLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740582043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UVVorH37MCFSJ8eBr7mIIBXtxKR/7OGM0uGrvqyOHyE=;
	b=go7j7OTrGBw67ufCbKuCxvFtMmr7TSOykyjE6coYbBqa3C/SV6IaJnO0bQhPZS8KZDvsJQ
	ZYtU/rjKoSf2iUBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yRTHuO5l;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=go7j7OTr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740582043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UVVorH37MCFSJ8eBr7mIIBXtxKR/7OGM0uGrvqyOHyE=;
	b=yRTHuO5ltZF5t4rc8/RvW1o2lrdAKnhMvUQTXZTJEWU8JROBFPtr5u0hdOJ1oMN0ddwVIb
	UWaVCp0CeDQwiSNBdLh2m0qa5Kjapvqr7QSaJpJfhJ52AvTx4q7MvdnoF2yivI1mgrlb2A
	4WwkPkiCJ3g8DJWH9J3smqa1sRulpLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740582043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UVVorH37MCFSJ8eBr7mIIBXtxKR/7OGM0uGrvqyOHyE=;
	b=go7j7OTrGBw67ufCbKuCxvFtMmr7TSOykyjE6coYbBqa3C/SV6IaJnO0bQhPZS8KZDvsJQ
	ZYtU/rjKoSf2iUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 349191377F;
	Wed, 26 Feb 2025 15:00:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dLGZDJssv2d8UAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 26 Feb 2025 15:00:43 +0000
Date: Wed, 26 Feb 2025 16:00:41 +0100
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: haoran zheng <zhenghaoran154@gmail.com>, Daniel Vacek <neelx@suse.com>,
	clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Subject: Re: [PATCH] btrfs: fix data race when accessing the block_group's
 used field
Message-ID: <20250226150041.GV5777@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250208073829.1176287-1-zhenghaoran154@gmail.com>
 <CAL3q7H5JgQkFavwrjOsvxDt9mMjVUK_nPOha-WYU-muLW=Orug@mail.gmail.com>
 <CAPjX3FeaL2+oRz81OEkLKjWwr1XuOOa3t-kgCrc51we-C-GVng@mail.gmail.com>
 <CAL3q7H7iFQ0pS+TB8NNj5CDA=c1cmurSiGsuXDn61O6A5=mBSQ@mail.gmail.com>
 <CAPjX3Feo9=hkptSxOMREKVckbvhfbmjHAWYBL2sBryDcVzp0NA@mail.gmail.com>
 <CAL3q7H7eSw0gg=JQwiEe9_pSEqcxugpgOWJDdv45UHrZbsFhzw@mail.gmail.com>
 <CAKa5YKjymZzRWy6WhVhu+mMzENunsM6URBL3o-_yy1wPGhdV-A@mail.gmail.com>
 <Z72s4bDZghGhcWzN@debian0.Home>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z72s4bDZghGhcWzN@debian0.Home>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 5E5BE1F388
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,fb.com,toxicpanda.com,vger.kernel.org,buaa.edu.cn];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Tue, Feb 25, 2025 at 11:43:29AM +0000, Filipe Manana wrote:
> > > > > > > static inline u64 btrfs_block_group_used(struct btrfs_block_group *bg)
> > > > > > > {
> > > > > > >    u64 ret;
> > > > > > >
> > > > > > >    spin_lock(&bg->lock);
> > > > > > >    ret = bg->used;
> > > > > > >    spin_unlock(&bg->lock);
> > > > > > >
> > > > > > >     return ret;
> > > > > > > }
> > 
> > I understand that using lock to protect block_group->used
> > in discard.c file is feasible. In addition, I looked at the code
> > of block-group.c and found that locks have been added in
> > some places where block_group->used are used. , it
> > seems that it is not appropriate to call
> > btrfs_block_group_used again to obtain (because it will
> > cause deadlock). 
> 
> In places where we are reading it while holding the block group's
> spinlock, there's nothing that needs to be changed.
> 
> Also we can't call it btrfs_block_group_used() since there's already
> an accessor function for struct btrfs_block_group_item with that name
> (defined through macros at accessors.h).
> 
> I took a closer look at the cases in discard.c, and it's safe to use
> data_race() instead, even if load/store tearing happens or we get stale
> values, nothing harmful happens, only a few things can be done later or
> unnecessarily without side effects - like adding a non-empty block group
> to the list of unused block groups, which is fine since the we won't
> delete it the cleaner kthread in case it's not empty, or delay the discard.
> 
> Either give it another name like btrfs_get_block_group_used() or directly
> use data_race() in discard.c - I don't like much either of them, the first
> because there's the similar named accessor for block group items, the
> second due to spreading data_race(), but I don't see any more elegant
> alternative.

Agreed, this looks like a resonable "solution". It's not really a bug,
we can live with data_race annotation, namely when it filters out known
cases so the code analysis tools may find the real problems.

> So a sample patch:
[...]

Looks good to me.

