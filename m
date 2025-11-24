Return-Path: <linux-btrfs+bounces-19326-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4219AC82A48
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 23:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E667E3ADDA7
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 22:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D782566F5;
	Mon, 24 Nov 2025 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZlIux9SR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YAKSIgpd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZlIux9SR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YAKSIgpd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4077538D
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 22:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023112; cv=none; b=LegEZnFO8itvvcPWVATTpz7AwSVHg6QhIGpCK4QOGfr0ercU9stqBVpkIDJl776uz44dbg2uFH/UwQzi0rgiIQCjN3v8dBMEJcQyiihvSYShOW2hAF6wkbvhTGSwxvamjWcPS/iERd3WyB3HpqBWr2gSQyv93Vsc8vzOnI5FuTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023112; c=relaxed/simple;
	bh=sTKM32Lyey8lj46xt5xzN8HjfrubrOTV9fcP+Xu8NWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3kX1klUXMbnvICcZ5VvMmrPNsl1BftIjxXAkj6FGBbEgIF8TUAN9qEcwSH1R8OM1xWXZauygJwUiHYz42t+mLHuJkKKXs1B8l5TL/v+pBY23Nx3cLVMcNB6MGJDd7el3pXr2wLf9qsu9pmr2Ge4Ss37r2q/EpWWhXZ51j85k9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZlIux9SR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YAKSIgpd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZlIux9SR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YAKSIgpd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1C0D25BCC2;
	Mon, 24 Nov 2025 22:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764023108;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYp3IY9dFfP8CYOVh0MIDAbXXCLqclSc55v3X3IE3Pg=;
	b=ZlIux9SR/SrjrIpRmC1/T0WG9ryn81PaYkRIcotg72lNbUS0HvJlY/dOAIU/4iyPdB1J0+
	9lccV1E++GOsIbs5g/buwhd0+IsGZfEusMbTKuH97jjrQJcTJbU6ZJ064Zi2ctAT90NPC3
	dQ5gdBZ4PksPC1DEIXqY/cOlzoCe5lQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764023108;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYp3IY9dFfP8CYOVh0MIDAbXXCLqclSc55v3X3IE3Pg=;
	b=YAKSIgpd+eVSrBZhwyu8qbgNGCjuse/IGq5BDRDSyWePWooePH9BaAxAkfIVJQwWTud0Ku
	LxEn0zLIAtU4ygBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764023108;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYp3IY9dFfP8CYOVh0MIDAbXXCLqclSc55v3X3IE3Pg=;
	b=ZlIux9SR/SrjrIpRmC1/T0WG9ryn81PaYkRIcotg72lNbUS0HvJlY/dOAIU/4iyPdB1J0+
	9lccV1E++GOsIbs5g/buwhd0+IsGZfEusMbTKuH97jjrQJcTJbU6ZJ064Zi2ctAT90NPC3
	dQ5gdBZ4PksPC1DEIXqY/cOlzoCe5lQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764023108;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYp3IY9dFfP8CYOVh0MIDAbXXCLqclSc55v3X3IE3Pg=;
	b=YAKSIgpd+eVSrBZhwyu8qbgNGCjuse/IGq5BDRDSyWePWooePH9BaAxAkfIVJQwWTud0Ku
	LxEn0zLIAtU4ygBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB4A33EA63;
	Mon, 24 Nov 2025 22:25:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1wo+OUPbJGmsUAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 24 Nov 2025 22:25:07 +0000
Date: Mon, 24 Nov 2025 23:25:06 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Daniel Vacek <neelx@suse.com>, dsterba@suse.cz,
	Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/4] btrfs: make sure all ordered extents beyond EOF
 is properly truncated
Message-ID: <20251124222506.GS13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1763629982.git.wqu@suse.com>
 <5960f3429b90311423a57beff157494698ab1395.1763629982.git.wqu@suse.com>
 <CAL3q7H6pV-pb6T70aOATXc2VBvA0PJZJcoo+B-SzK48qxzyqbg@mail.gmail.com>
 <20251121153850.GP13846@twin.jikos.cz>
 <94236c69-10ed-494f-8895-39a8b4a443b6@gmx.com>
 <CAPjX3FdrTZwzuObrERxP=pLmSMjYt6Drqfxn4S5ENmL_JQhkzw@mail.gmail.com>
 <58e0b0e5-c72c-43de-a1ec-b9d85a71bbdf@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58e0b0e5-c72c-43de-a1ec-b9d85a71bbdf@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Sat, Nov 22, 2025 at 07:16:06AM +1030, Qu Wenruo wrote:
> 在 2025/11/22 06:55, Daniel Vacek 写道:
> > On Fri, 21 Nov 2025 at 20:28, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >> 在 2025/11/22 02:08, David Sterba 写道:
> >>> On Fri, Nov 21, 2025 at 11:55:58AM +0000, Filipe Manana wrote:
> >>>>> +               /*
> >>>>> +                * We have just run delalloc before getting here, so there must
> >>>>> +                * be an ordered extent.
> >>>>> +                */
> >>>>> +               ASSERT(ordered != NULL);
> >>>>> +               scoped_guard(spinlock, &inode->ordered_tree_lock) {
> >>>>> +                       set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
> >>>>> +                       ordered->truncated_len = min(ordered->truncated_len,
> >>>>> +                                                    cur - ordered->file_offset);
> >>>>> +               }
> >>>>
> >>>> I thought we had not made a decision yet to not use this new fancy locking yet.
> >>>> In this case where it's a very short critical section, it doesn't
> >>>> bring any advantage over using explicit spin_lock/unlock, and adds one
> >>>> extra level of indentation.
> >>>
> >>> Agreed, this looks like an anti-pattern of the scoped locking.
> >>>
> >>
> >> I think one is free to use whatever style as long as there is no mixed
> >> style in the same function.
> > 
> > I've got a hard objection here. If there is(?) any granularity using
> > guards vs. explicit locking then, IMO, it should be per given lock.
> > 
> > Ie, given `ordered_tree_lock` - either it should always use the RAII
> > style *OR* it should always use the explicit style. But it should
> > never mix one style in one function and the other style in another
> > function. That would only make it really messy looking for
> > interactions and race bugs / missing/misplaced locking - simply
> > general debugging.
> 
> Then check fs/*.c.
> 
> There are guard(rcu) and rcu_read_lock() usage mixed in different files.
> 
> E.g. in fs/namespace.c it's using guard(rcu) and scoped_guard(rcu), 
> meanwhile still having regular rcu_read_lock().
> 
> There are more counter-examples than you know.
> We're not the first subsystem to face the new RAII styles, and I hope we 
> will not be the last either.

We take inspiration from other subsystems but that some coding style is
done in another subsystem does not mean we have to do that too. If
fs/*.c people decide to use it everywhere then so be it.

I was hesitant to introduce the auto cleaning for btrfs_path or kfree
but so far I found it working. The locking guards are quite different to
that and I don't seem to get any liking in it

> [...]
> >>
> >> I'm not saying we should change to the new RAII style immediately with a
> >> huge patch nor everyone should accept it immediately, but to gradually
> >> use the new style in new codes, with the usual proper review/testing
> >> procedures to keep the correctness.
> > 
> > I would understand if you introduced a _new_ lock and started using it
> > with the RAII style - setting the example. But if you're grabbing a
> > lock which is always acquired using the explicit style, just stick to
> > it and keep the style consistent throughout all the callsites, the
> > whole code base. This makes it _easier_ to crosscheck, IMO.
> 
> Then check kernfs_root::kernfs_rwsem, it also has mixed RAII and old styles.
> 
> We should all remember there are always subsystems before us facing this 
> challenge, and if they are fine embrace the new style gradually, I see 
> no reason why we can not.
> 
> We're just a regular subsystem in the kernel, not some god-chosen 
> special one, we do not live in a bubble.

Honestly, this is a weird argument to make. There are local coding
styles that are their own bubbles, look at net/* with their own special
commenting style and mandatory reverse xmass tree sort of variables (I
think that one has been adopted by other subsystems too). Contributing to
those subsystems means following their style. If you want an example
of a filesystem with unique code formatting style then go no further
than XFS.

I think we've been doing fine in btrfs with the style consistency and
incremental updates of old code when possible. This means we have fewer
choices for personal "creative expression" how the code is written but
in the long run it makes the code look better.

The problem with the guards is that there's no one good way for their
general use, i.e. the problem of mixing with explicit lock/unlock,
trylock, unlock/lock order, etc. Allowing both styles will lead to
inconsistent style based on personal preferences again.

As said on slack, we'll get to a conclusion.

