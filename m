Return-Path: <linux-btrfs+bounces-13953-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 183CDAB4878
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 02:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E606F1B41DCB
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 00:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB6C71747;
	Tue, 13 May 2025 00:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LPU3H+XH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="neibz5P8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LPU3H+XH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="neibz5P8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFB43F9FB
	for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 00:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747096325; cv=none; b=Bvqb4zxFvr1lSNEfrjKRpN2jbWMhPdJshlpq34GlXaLv1zkMjV5lCbW+cA0hzGE3UKXhd88P/teCvV2yhDYALGXBB4p3lFCHFu6txnAomolVymZRnopQMYWzNbCgCi+OLMeN6o6uYYh0YqXKXLKzPnvPOwQNff5KnpkvdTeMjMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747096325; c=relaxed/simple;
	bh=u/uZu3C4+NyyEXfW9P+uhf063yFrKN4Fw2RaqHmeoOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khF87A6VuwSG88PbOGqR+f6vxGa9nxzNzUO+cqeTkHagyq4EDGrtocgM2sqWIC+pUT6szJhuYnuGrbMRGakLYtzaZcu4GNLcul9Q2VAGyp7375ldePPDDR6ju6J8bPOQD5r+8siDcz3wK1rhcSz/PxrPwfGAH2LUIKY1W5fH2Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LPU3H+XH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=neibz5P8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LPU3H+XH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=neibz5P8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A8B121F388;
	Tue, 13 May 2025 00:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747096321;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6cYvGIo/SGidr6VuJk7mvsrXECdnDKcAY8/+dzZH3Q0=;
	b=LPU3H+XH4ALkmg5shnASRepdDwZnBoqnD6XkBVUwlmhaZiUhZVfDlZAZgy7YWzvVPK9MUG
	nDp+iqFVP9UOJlszRSAY9gbMxQNJqfnTlFvkKidgPaf7CUHRQ4iFb4ApB5RFbAxkn/2o4B
	rPGVHYrFiMYzW6dzmv+vM3RasCcJOXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747096321;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6cYvGIo/SGidr6VuJk7mvsrXECdnDKcAY8/+dzZH3Q0=;
	b=neibz5P88AMN4LCnzZDMl1piUaBMBHk+Kb6PNmHwvEpE80w8240RD/WLofjTmtL1A654GX
	o1uiIq37aN75DEAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LPU3H+XH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=neibz5P8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747096321;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6cYvGIo/SGidr6VuJk7mvsrXECdnDKcAY8/+dzZH3Q0=;
	b=LPU3H+XH4ALkmg5shnASRepdDwZnBoqnD6XkBVUwlmhaZiUhZVfDlZAZgy7YWzvVPK9MUG
	nDp+iqFVP9UOJlszRSAY9gbMxQNJqfnTlFvkKidgPaf7CUHRQ4iFb4ApB5RFbAxkn/2o4B
	rPGVHYrFiMYzW6dzmv+vM3RasCcJOXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747096321;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6cYvGIo/SGidr6VuJk7mvsrXECdnDKcAY8/+dzZH3Q0=;
	b=neibz5P88AMN4LCnzZDMl1piUaBMBHk+Kb6PNmHwvEpE80w8240RD/WLofjTmtL1A654GX
	o1uiIq37aN75DEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DA79137E8;
	Tue, 13 May 2025 00:32:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kkgWHgGTImj6ZwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 13 May 2025 00:32:01 +0000
Date: Tue, 13 May 2025 02:32:00 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: dsterba@suse.cz, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] btrfs: remove extent buffer's redundant `len`
 member field
Message-ID: <20250513003200.GZ9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250505115056.1803847-1-neelx@suse.com>
 <20250505115056.1803847-2-neelx@suse.com>
 <20250505151817.GX9140@twin.jikos.cz>
 <CAPjX3FfbeGmPkXY1NDnecrtcLe5dqX7+vLOLGe3sdggUfS-WSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FfbeGmPkXY1NDnecrtcLe5dqX7+vLOLGe3sdggUfS-WSg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A8B121F388
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Mon, May 05, 2025 at 07:53:16PM +0200, Daniel Vacek wrote:
> On Mon, 5 May 2025 at 17:18, David Sterba <dsterba@suse.cz> wrote:
> >
> > On Mon, May 05, 2025 at 01:50:54PM +0200, Daniel Vacek wrote:
> > > Even super block nowadays uses nodesize for eb->len. This is since commits
> > >
> > > 551561c34663 ("btrfs: don't pass nodesize to __alloc_extent_buffer()")
> > > da17066c4047 ("btrfs: pull node/sector/stripe sizes out of root and into fs_info")
> > > ce3e69847e3e ("btrfs: sink parameter len to alloc_extent_buffer")
> > > a83fffb75d09 ("btrfs: sink blocksize parameter to btrfs_find_create_tree_block")
> > >
> > > With these the eb->len is not really useful anymore. Let's use the nodesize
> > > directly where applicable.
> >
> > You haven't updated the changelog despite we had a discussion about the
> > potential drawbacks, so this should be here. But I'm not convinced this
> 
> Right. That's because I was not sure we came to any conclusion yet. I
> thought this discussion was still ongoing. I understand that so far
> this is still all just a theory and any premature conclusions may be
> misleading.
> 
> But yeah, I may write some kind of a warning or a disclaimer
> mentioning the suspicion. Just so that it gets documented and it is
> clear it was considered, even though maybe without a clear conclusion.
> 
> > is a good change. The eb size does not change so no better packing in
> > the slab and the caching of length in the same cacheline is lost.
> 
> So to be perfectly clear, what sharing do you mean? Is it the
> eb->start and eb->len you talking about? In other words, when getting
> `start` you also get `len` for free?

Yes, basically.

> Since the structure is 8 bytes aligned, they may eventually still end
> up in two cachelines. Luckily the size of the structure is 0 mod 16 so
> just out of the luck this never happens and they are always in the
> same cache line. But this may break with future changes, so it is not
> rock solid the way it is now.

Yes, with structures not perfectly aligned to a cacheline (64B) there
will be times when the access needs fetching two cachelines. With locks
it can result in various cacheline bouncing patterns when various
allocated structures are aligned to 8 bytes, giving 8 possible groups of
"misaligned" structure instances.

There's also a big assumption that the CPU cache prefetcher is clever
enough to average out many bad patterns. What I try to do on the source
code level is to be able to reason about the high level access patterns,
like "used at the same time -> close together in the structure".

> > In the assebly it's clear where the pointer dereference is added, using
> > an example from btrfs_get_token_8():
> >
> >   mov    0x8(%rbp),%r9d
> >
> > vs
> >
> >   mov    0x18(%rbp),%r10
> >   mov    0xd38(%r10),%r9d
> 
> I understand that. Again, this is what I originally considered. Not
> all the functions end up like this but there are definitely some. And
> by a rule of a thumb it's roughly half of them, give or take. That
> sounds like a good reason to be concerned.
> 
> My reasoning was that the fs_info->nodesize is accessed by many so the
> chances are it will be hot in cache. But you're right that this may
> not always be the case. It depends. The question remains if that makes
> a difference?
> 
> Another (IMO valid) point is that I believe the code will dereference
> many other pointers before getting here so this may seem like a drop
> in the sea. It's not like this was a tight loop scattering over
> hundreds random memory addresses.
> For example when this code is reached from a syscall, the syscall
> itself will have significantly higher overhead then one additional
> dereference. And I think the same applies when reached from an
> interrupt.
> Otherwise this would be visible on perf profile (which none of us
> performed yet).

Yeah and I don't intend to do so other than to verify your measurements
and calims that this patch does not make things worse at least. The
burden is on the patch submitter.

> Still, I'd say reading the assembly is a good indication of possible
> issues to be concerned with. But it's not always the best one. An
> observed performance regression would be.
> I'll be happy to conduct any suggested benchmarks. Though as you
> mentioned this may be also picky on the used HW.

I'd say any contemporary hardware is good, I don't think the internal
CPU algorithms of prefetching or branch predictions change that often. A
difference that I would consider significant is 5% in either direction.

> So even though we
> don't see any regressions with our testing, one day someone may find
> some if we merged this change. In which case we can always revert.
> 
> I have to say I'm pretty happy with the positive feedback from the
> other reviewers. So far you're the only one raising this concern.

I don't dispute the feedback from others, the patch is not wrong on
itself, it removes a redundant member. However I don't see it as a
simple change because I also spent some time looking into that
particular structure, shrinking size, member ordering and access
patterns that I am questioning the runtime performance implications.

My local eb->len removal patch is from 2020 and I decided not to send it
because I was not able to prove to myself it'd be for the better. This
is what I base my feedback on.

> So how do we conclude this?

I don't agree to add this patch due to the following main points:

- no struct size change, ie. same number of objects in the slab
- disputed cacheline behaviour, numbers showing improvement or not
  making it worse needed

> If you don't want this cleanup I'd opt at least for rename eb->len
> ==>> eb->nodesize.

This sounds like an unnecessary churn. 'length' related to a structure
is natural, nodesize is a property of the whole filesystem, we're used
to eb->len, I don't any benefit to increase the cognitive load.

