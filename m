Return-Path: <linux-btrfs+bounces-20428-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02384D161BC
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 02:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 645CE301FC06
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 01:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4394A258EDE;
	Tue, 13 Jan 2026 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qV/RLDNh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mnd1m/c7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qV/RLDNh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mnd1m/c7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A15B248176
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 01:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768266642; cv=none; b=OnBS7P/gwdFQnWQeP4YT//1W8wghcJgHKZx5ANx0qvC2H11dsF89DyfNzfXPNtF3XBxL3CNQxwogip+raxA7OIO4H1oNqkhiw7VH38cSItJLlJ9ksplr6xfnMRpFXxu1jrMh4VMhuhLT5S/NdAiuUhFEdLg8yiYueyAsoLihjd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768266642; c=relaxed/simple;
	bh=5mVDE8PqSKuOqyBu9+i8qYJqvqokkVQDNWJ17MAFHDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXmPSTEXifkZE7m+xE6ENajLSWWIKWhpPbX0YFXGhsbKnKG5cc8Agcrg8kLP+9r704Pj5loR94EHpJVrE/1PbpBdUtjUO6iv4lV+vYNz1ksZAbcl9+VSWESZRAXkxPzV+Y5XySBe8SAiMlR/nPnxefNpcF/T8HdwTeqiAY+6dec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qV/RLDNh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mnd1m/c7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qV/RLDNh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mnd1m/c7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2D8535BCC1;
	Tue, 13 Jan 2026 01:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768266639;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=haNN7x+q4SlSlzAm6b/nsLSnEFqv7VRq8NjWu91zCMo=;
	b=qV/RLDNhEe90lP6cTBZPpx2phwhJMDujsudn3bLjqA2hqLUb5yopzmKfjNXKzSet37r0Eh
	LN5Sk7JV/+CqQLuXJLkjfY8ZkyZzBEkpVavx/BYQ5EHS5JtmzYcD2fvvvH5xwk9jdAOaGK
	UaF3lC+KVF0DJriP7R4yB6SAW8/yHo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768266639;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=haNN7x+q4SlSlzAm6b/nsLSnEFqv7VRq8NjWu91zCMo=;
	b=mnd1m/c7bKG4B67uKJ6wr8um+3dgjH5bNvC7g+j34Sr1dg57Uj6JgD5cIMFROoG4walChH
	Uji7sxYl6shY23BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="qV/RLDNh";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="mnd1m/c7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768266639;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=haNN7x+q4SlSlzAm6b/nsLSnEFqv7VRq8NjWu91zCMo=;
	b=qV/RLDNhEe90lP6cTBZPpx2phwhJMDujsudn3bLjqA2hqLUb5yopzmKfjNXKzSet37r0Eh
	LN5Sk7JV/+CqQLuXJLkjfY8ZkyZzBEkpVavx/BYQ5EHS5JtmzYcD2fvvvH5xwk9jdAOaGK
	UaF3lC+KVF0DJriP7R4yB6SAW8/yHo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768266639;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=haNN7x+q4SlSlzAm6b/nsLSnEFqv7VRq8NjWu91zCMo=;
	b=mnd1m/c7bKG4B67uKJ6wr8um+3dgjH5bNvC7g+j34Sr1dg57Uj6JgD5cIMFROoG4walChH
	Uji7sxYl6shY23BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF85A3EA63;
	Tue, 13 Jan 2026 01:10:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b+RBOo6bZWnkTQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 13 Jan 2026 01:10:38 +0000
Date: Tue, 13 Jan 2026 02:10:37 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.cz>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Delayed ref root cleanups
Message-ID: <20260113011037.GW21071@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1767979013.git.dsterba@suse.com>
 <20260109181627.GB3036615@zen.localdomain>
 <20260109210921.GT21071@twin.jikos.cz>
 <20260109213953.GA3129444@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109213953.GA3129444@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: 2D8535BCC1
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Fri, Jan 09, 2026 at 01:39:53PM -0800, Boris Burkov wrote:
> On Fri, Jan 09, 2026 at 10:09:21PM +0100, David Sterba wrote:
> > On Fri, Jan 09, 2026 at 10:16:27AM -0800, Boris Burkov wrote:
> > > On Fri, Jan 09, 2026 at 06:17:39PM +0100, David Sterba wrote:
> > > > Embed delayed root into btrfs_fs_info.
> > > 
> > > The patches all look fine to me, but I think it would be nice to give
> > > some justification for why it is desirable to make this change besides
> > > "it's possible". If anything, it is a regression on the size of struct
> > > btrfs_fs_info as you mention in the first patch.
> > 
> > A regression? That's an unusal way how to look at it and I did not cross
> > my mind. The motivation is that the two objects have same lifetime and
> > whe have spare bytes in the slab.
> > 
> 
> Sorry for the slightly hyperbolic language. My point was merely that it
> is the main observable outcome. I agree with you that it's not an actual
> meaningful regression in any way that we care about today.
> 
> All I'm saying is we consider it a minor win (all else being equal) to
> shrink structs, so it's only fair to consider growing them a minor
> regression.
> 
> It can be offset by other benefits and be an attractive choice anyway.
> 
> > > If the answer is just that it's simpler and there is no need for a
> > > separate allocation, then fair enough. But then why not directly embed
> > > all the one-off structures pointed to by fs_info? Like all the global
> > > roots, for example. Are they too large? What constitutes too large?
> > > Later, when we slowly add stuff to fs_info till it is bigger than 4k,
> > > should we undo this patch set? Or look for other, bigger structs to
> > > unembed first?
> > 
> > Fair questions. If we embed everything the fs_info would be say 16K. The
> > threshold I'm considering is 4K, which is 4K page on the most common
> > architecture x86_64. ARM can be configured to have 4K or 64K on the most
> > common setups, so I'm not making it worse by the 4K choice.
> 
> Agreed.
> 
> > So, if the structure for embedding is small enough not to cross 4K and
> > still leave some space then I consider it worth doing. In the case of
> 
> All I'm really asking is for some durable explanation why it is that you
> consider it worth doing. Your email and patch messages just explained
> why it was possible.
> 
> Even something like "if a non optional object is smaller than ~X, we
> prefer not to use up slab" would be a helpful explanation.
> 
> Understanding how you think about these things is important to other
> developers so we know what principles to try to follow in our own work.
> 
> Otherwise, we are just guessing at your taste preferences, and we can
> monkey around and you can clean up after us :). I assume that is not the
> most desirable.

You're right, it's good to have all the why's answered, sometimes I'm
not sure if I'm explaining trivialities but this is skewed by the time
one stares at the code until it's all obvious. The changelogs also serve
as documentation and gather information that we may use in the future
for similar patterns.

> > increasing the fs_info by required and small new members (spinlocks,
> > atomics, various stats etc) we can first look how to shring the size by
> > reordering it. Currently I see there are 97 bytes in holes. Then we can
> > look what is used optionally, eg. depends on a mount option and move it
> > to a separate structure.
> > 
> > The delayed root is a core data structure so we will not have to
> > separate it again and revert this patchset. What I'd start looking for
> > for a separate data structure would be some kind of static
> > almost-read-only information, like mount option bits or status flags
> > etc.
> 
> I mean, it's not impossible to imagine a future where the lower hanging
> fruit are exhausted and we are butting up on 4k.

Yeah, fs_info gets updated often, comparing to other structures, I'm
sure we'll hit the page limit.

> > Also I don't want people to worry about fs_info size when there's
> > something new to implement. We have some space to use and I will notice
> > if we cross the boundary as I do random checks of the patch effects
> > every now and then. This applies to parameters and stack space
> > consumption. You may say this is pointless like in the other patchset
> > but even on machines with terabytes of memory a kernel thread is still
> > limited to 16K of stack and layering subsystems can use substantial
> > portions of it. My long term goal is to keep the level the same without
> > hindering development.
> 
> I won't say pointless, since you're right, there is a point to reducing
> stack size. Perhaps the better expression of how I feel about that is
> "arbitrary". But individual improvements are always useful.

The general answer to that is that kernel memory is a scarce resource.
We neither waste it because big machines exist or optimize too
aggressively because small machines exist. Fixing low hanging fruit
stuff like reducing size is easy, everything beyond obvious needs some
numbers and analysis and a comment in code why the general principles
may be broken (like leaving a gap in a structure due to forced cacheline
alignment). Anyway, thanks for the discussion, I'll update the
changelogs.

