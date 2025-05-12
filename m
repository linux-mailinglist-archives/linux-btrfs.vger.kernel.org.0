Return-Path: <linux-btrfs+bounces-13946-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFBDAB4554
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 22:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9882C19E5141
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4B529825E;
	Mon, 12 May 2025 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rlaTvZUd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K8W12uWG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BAmKd/ep";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bVW7/rh9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E5F248F67
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747080303; cv=none; b=FDzRZkeAGw1S+nHVc4VKJVXZWje/pJf4ySz5W5u7zIhnia1cXgq4/vErmU4oc8ChQx/t2HQE634s3GiRlP1xXc/hf0Sh6CeqkJVyBUaKmZk7nn3yoKpl7r6f9opCkRPK97EWmxTOY9dnFfiMCt3o8v5ohflqOz3ZqtyItYtGuT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747080303; c=relaxed/simple;
	bh=EpbVGC91MnX0w6vmTmEYU1+GS4llwn2DUorzKX1CUCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/2EyhQmvMk59lHc+hganSj0nkIDi0sMagzEjaxr2b5bT+jctgsDN7F8qYsdn3QtD/7JSUXB5x3/LvaSd5+Bm1w1bhyWUytTFHkt9UnChbuhCjIHoRf3+TkGob/wIfUMcwHViwuHzywWMDMqHb8yozI8iZ4IYhFs6fReuLN0S3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rlaTvZUd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K8W12uWG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BAmKd/ep; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bVW7/rh9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7028C1F38A;
	Mon, 12 May 2025 20:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747080299;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2McNyJITFGghEmlYUhDgSMTJ4snImLbFOedBpUaKfUQ=;
	b=rlaTvZUd+FOjTQQlK+o1hesdSY29afeuHmHAfE5THhsEJx39jAGikCtj/DZz9SL8RSKnFq
	jc16K7LOSyzr4PiyhF16/LiMATNzz2+CcFRduN6iAQnimajfRdHEd6/YG4BotCJvjwR/rU
	zQq2XWWBK4FuTWx3HHx0JIILnHhmm8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747080299;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2McNyJITFGghEmlYUhDgSMTJ4snImLbFOedBpUaKfUQ=;
	b=K8W12uWGnbPR2gDRt0ytW/TLsHKHwiAnNq8tp4OKNVgPGL8y9mibEMvFzipNXGYI+SXzcs
	C5dokJtkxDzob7CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747080298;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2McNyJITFGghEmlYUhDgSMTJ4snImLbFOedBpUaKfUQ=;
	b=BAmKd/ep65zhj9uqlsVf28yy9/2xKQ7504x5Q4nl84p+bPFtMKslJypkcW88MpPXh71rqL
	DLyfOXDm6OvM7L42wNwzQysYvQX9TKElze27BskB1b/sf7zhrA3KoJCFugUM+DPMwEToW4
	tENq8RoS2IHSnW2qzSaDHBS8mLJy4V8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747080298;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2McNyJITFGghEmlYUhDgSMTJ4snImLbFOedBpUaKfUQ=;
	b=bVW7/rh9zSqL/61zVlTuun0IggmIyRlAo5VeonqgEOC8a/4pkHkCPTmv4THuOuRWL/JI+M
	zN6vZgmO0tg+J4Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4831C1397F;
	Mon, 12 May 2025 20:04:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1IUjEWpUImjIIAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 12 May 2025 20:04:58 +0000
Date: Mon, 12 May 2025 22:04:57 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use unsigned types for constants defined as bit
 shifts
Message-ID: <20250512200457.GW9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250422155541.296808-1-dsterba@suse.com>
 <CAPjX3FcGAUqheUg0TQHG_yvuQExjT3N3SUGRYtk1S3b3aDVZZQ@mail.gmail.com>
 <20250507174328.GK9140@twin.jikos.cz>
 <CAPjX3FdoqC6VJ2F1ia3vxYKVhnv=oT2GCkY668Z7ugSagTmPdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FdoqC6VJ2F1ia3vxYKVhnv=oT2GCkY668Z7ugSagTmPdg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Fri, May 09, 2025 at 09:02:56AM +0200, Daniel Vacek wrote:
> > Yes, it's a compile time constant. It's in num_entries because it's used
> > twice in the function, for that we usually have a local variable so we
> > don't have to open code the value everywhere.
> 
> Right. I'm just blind, sorry. Could be const unsigned int.
> 
> I have noticed before, using `const` is also not consistent within btrfs
> code. But that's OT here.

Yes it is inconsistent, it was not part of the coding style from the
beginning and the codebase is now like 18 years old. We've started
adding const to local variables some years ago.

I did some passes over the parameters, and add const in patches in
for-next unless it's there already. Further unification is probably a
good thing, though it may need some taste where to add them. Compiler
usually has enough information to see which variables change or not, so
some cases are implicit const anyway.

An optimization to reload a value of non-const variable in the middle of
other code is also possible but there are constraints that may prevent
it in most cases. From what I've seen adding const also prevents this
optimizations. But again this is so rare that we may not need to care
about that too much.

I did some random search and clear candidates for const are fscrypt_str
variables.

> > > ---
> > >
> > > Quite honestly the whole patch is questionable. The recommendations
> > > are about right shifts. Left shifts are not prone to any sinedness
> > > issues.
> > >
> > > What is more important is where the constants are being used. They
> > > should honor the type they are compared with or assigned to. Like for
> > > example 0x80ULL for flags as these are usually declared unsigned long
> > > long, and so on...
> >
> > Agreed, flags and masks should be unsigned.
> >
> > > For example the LINK_LOWER is converted to int when used as
> > > btrfs_backref_link_edge(..., LINK_LOWER) parameter and then another
> > > LINK_LOWER is and-ed to that int argument. I know, the logical
> > > operations are not really influenced by the signedness, but still.
> >
> > Well, it's more a matter of consistency and coding style. We did have a
> > real bug with signed bit defined on 32bit int that got promoted to u64
> > not as a single bit but 0xffffffff80000000 and this even got propagated
> > to on-disk data. We were lucky it never had any real impact but since
> > then I'm on the side of making bit shifts unconditionally on unsigned
> > types. 77eea05e7851d910b7992c8c237a6b5d462050da
> 
> Yeah, that's nasty. That's precisely what I meant when saying that
> more important is the types actually do match. The implicit promotions
> are the source of hidden bugs.
> 
> I'll check all the changes once again, to be sure.
> 
> > >
> > > And btw, the LINK_UPPER is not used at all anywhere in the code, if I
> > > see correctly.
> >
> > $ git grep LINK_UPPER
> > backref.c:      if (link_which & LINK_UPPER)
> > backref.h:#define               LINK_UPPER      (1U << 1)
> 
> This is what I was referring to. The flag is never used. The whole
> `if` can be removed as it'll always be false.

Right. The last use was in 0097422c0dfe0a ("btrfs: remove
clone_backref_node() from relocation") so it's a leftover and can be
removed and there are probably some cascdaded changes from there.

