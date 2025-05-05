Return-Path: <linux-btrfs+bounces-13655-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C28AA951B
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 16:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6FB5178B56
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C86825A2A3;
	Mon,  5 May 2025 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HT/BlYy+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oY2/DR1C";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HT/BlYy+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oY2/DR1C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDD454670
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454228; cv=none; b=mmMHBRTK1PY1BI5dXakzh9B1Z3URpnIbxQF0J6wZd1qTLgA5mrCZjTxmM6Y1oXNP+n2koLju+qM24hMvWgTjoqSTajz50i5vV3mvsQy8XmzCtpZQW0oSIwSYgSmTloDvdvqGFY9iOKa1C2g8JtiBUhi+1yJj11fZ6/XnaORRyrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454228; c=relaxed/simple;
	bh=3HBf2jrppsiE/9x244bSAB4/UOZ6ZEuQu5Cl26acWx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1UXYzeDDUE6+ELC586UtUv+1LNjCwCLGBJMXXzFZqWey3TkRZEUmd1DSh5uh4/PJSGEk6Hu0SvBJCmBnpnOPYn2t3g66gw0GaPXj8rgUUU+xzwjDPdePmLeKVQt0F0cIhlVnWMW2lUT3aMai0fsNJsOQkVrPsC+dwdDLdaiVB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HT/BlYy+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oY2/DR1C; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HT/BlYy+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oY2/DR1C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 349111F791;
	Mon,  5 May 2025 14:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746454225;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PxGiBMfGE1n3U6ZFFzbGA2FlVTFs5KhNkmP10Jdjq10=;
	b=HT/BlYy+uTi7gIyKuPwnnqLYqfwBRsfd4+FQlanqf1DB+v6dhjkGzDShUlWV/NImr07Jpu
	GWaOGUvj47WsMbPR6KZJBXRI+ruCBZUwaVyMmx0VSr8Y5HTmt1/ss98mgwOcNshNgA/9Du
	04TziF5Y+jlii3CHXhqneozEdTBELEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746454225;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PxGiBMfGE1n3U6ZFFzbGA2FlVTFs5KhNkmP10Jdjq10=;
	b=oY2/DR1CvBgQYgLLAP5Tg3gx91cfGFNoWwLF9zSGeIW8xLBoQoL9Ip6MzEm/Fnr+NssKCg
	IqBTLLSWEsG90iBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="HT/BlYy+";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="oY2/DR1C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746454225;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PxGiBMfGE1n3U6ZFFzbGA2FlVTFs5KhNkmP10Jdjq10=;
	b=HT/BlYy+uTi7gIyKuPwnnqLYqfwBRsfd4+FQlanqf1DB+v6dhjkGzDShUlWV/NImr07Jpu
	GWaOGUvj47WsMbPR6KZJBXRI+ruCBZUwaVyMmx0VSr8Y5HTmt1/ss98mgwOcNshNgA/9Du
	04TziF5Y+jlii3CHXhqneozEdTBELEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746454225;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PxGiBMfGE1n3U6ZFFzbGA2FlVTFs5KhNkmP10Jdjq10=;
	b=oY2/DR1CvBgQYgLLAP5Tg3gx91cfGFNoWwLF9zSGeIW8xLBoQoL9Ip6MzEm/Fnr+NssKCg
	IqBTLLSWEsG90iBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B2B313883;
	Mon,  5 May 2025 14:10:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +kF6AtHGGGjDQAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 05 May 2025 14:10:25 +0000
Date: Mon, 5 May 2025 16:10:19 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: dsterba@suse.cz, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove extent buffer's redundant `len` member
 field
Message-ID: <20250505141019.GW9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250429151800.649010-1-neelx@suse.com>
 <20250430080317.GF9140@twin.jikos.cz>
 <CAPjX3FfBoU9-wYP-JC63K6y8Pzocu0z8cKvXEbjD_NjdxWO+Og@mail.gmail.com>
 <20250430133026.GH9140@suse.cz>
 <CAPjX3FdexSywSbJQfrj5pazrBRyVns3SdRCsw1VmvhrJv20bvw@mail.gmail.com>
 <20250502105630.GO9140@suse.cz>
 <CAPjX3Ffy2=CQP2mx9Wa3BBR54fEAcuo8ADqeTVdcAmCO7g+gmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3Ffy2=CQP2mx9Wa3BBR54fEAcuo8ADqeTVdcAmCO7g+gmg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 349111F791
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, May 02, 2025 at 02:03:55PM +0200, Daniel Vacek wrote:
> > Yeah, 256 is a nice number because it aligns with cachelines on multiple
> > architectures, this is useful for splitting the structure to the "data
> > accessed together" and locking/refcounting. It's a tentative goal, we
> > used to have larger eb size due to own locking implementation but with
> > rwsems it got close/under 256.
> >
> > The current size 240 is 1/4 of cacheline shifted so it's not all clean
> > but whe have some wiggle room for adding new members or cached values,
> > like folio_size/folio_shift/addr.
> 
> Sounds like we could force align to cacheline or explicitly pad to
> 256B? The later could be a bit tricky though.

We could and we also have conflicting goals:

- alignment (with some waste)

- more objects packed into the slab which is 8K

More objects mean better chance to satisfy allocations, that are right
now NOFAIL, so blocking metadata operations with worse consequences.

> > >         struct btrfs_fs_info *fs_info;
> > >
> > >         /*
> > > @@ -94,9 +97,6 @@ struct extent_buffer {
> > >         spinlock_t refs_lock;
> > >         atomic_t refs;
> > >         int read_mirror;
> > > -       /* >= 0 if eb belongs to a log tree, -1 otherwise */
> > > -       s8 log_index;
> > > -       u8 folio_shift;
> > >         struct rcu_head rcu_head;
> > >
> > >         struct rw_semaphore lock;
> > >
> > > you're down to 256 even on -rt. And the great part is I don't see any
> > > sacrifices (other than accessing a cacheline in fs_info). We're only
> > > using 8 flags now, so there is still some room left for another 8 if
> > > needed in the future.
> >
> > Which means that the size on non-rt would be something like 228, roughly
> > calculating the savings and the increase due to spinloct_t going from
> > 4 -> 32 bytes. Also I'd like to see the generated assembly after the
> > suggested reordering.
> 
> If I see correctly the non-rt will not change when I keep ulong
> bflags. The -rt build goes down to 264 bytes. That's a bit better for
> free but still not ideal from alignment POV.
> 
> > The eb may not be perfect, I think there could be false sharing of
> > refs_lock and refs but this is a wild guess and based only on code
> 
> refs_lock and refs look like they share the same cacheline in every
> case. At least on x86.
> But still, the slab object is not aligned in the first place. Luckily
> the two fields roam together.
> 
> Out of curiosity, is there any past experience where this kind of
> optimizations make a difference within a filesystem code?
> I can imagine perhaps for fast devices like NVDIMM or DAX the CPU may
> become the bottleneck? Or are nowadays NVMe devices already fast
> enough to saturate the CPU?

I don't have a specific example. This is tricky to measure and
historically the devices were slow so any IO and waiting made the cache
effects irrelevant. With NVMe, modern CPUs we might start seeing that.
Instrumentation or profiling of the structures can do that, there are
tools for that but the variability of the hardware combinations and
runtime conditions makes it hard so I'm resorting to more "static"
approach and go after known good patterns like alignment or placement
related to cachelines (manually or with ____cacheline_aligned_in_smp).

> I faintly recall one issue where I debugged a CPU which could not keep
> up with handling the interrupts of finished IO on NVMe submitted by
> other CPUs. Though that was on xfs (or maybe ext4) not on btrfs. But
> that was a power-play of one against the rest as the interrupt was not
> balanced or spread to more CPUs.

