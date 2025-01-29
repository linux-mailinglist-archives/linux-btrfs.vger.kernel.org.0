Return-Path: <linux-btrfs+bounces-11166-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB1EA2268C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 23:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717663A45D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 22:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB531DE2B1;
	Wed, 29 Jan 2025 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ODfyc5VN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Re82+yKH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9EE199EBB
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738191464; cv=none; b=lca210VQ20OEKGRCsLgtptpSCsyzHqlbk66H649Hin9cOaBU+NdiC3tBIikto18smrvNhSzV9SxHM+p4Rh448Bnx5uUxJyLsRvxARz8PZod89tZ//Cq3Ig/swmPHiU2SMWa98kKKY7ZzeZvdIso33919cRR94AqCoIqWO0kFw24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738191464; c=relaxed/simple;
	bh=1gZ4p/ZzvKiD8NedBvMdZbpe41uzLQftosD/EXwA/co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8NfBqnR8AhAbdtVTRTa2s+C1pIUEX5I7RqkXaLnUL4Dvo7BMXiPQ8TPcaI6p0yLPFb+CoY8PDLF8s7MkX4JWqv+rfDRCsZpGx0I7JeSPdKz2OyWKzc99Fjcef1qk+SCzWbgtnrJh98CN1UWSOUyYWVITovWqjxob4Fq+iSdkgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ODfyc5VN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Re82+yKH; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1275E2540135;
	Wed, 29 Jan 2025 17:57:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 29 Jan 2025 17:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1738191459; x=1738277859; bh=dIAjZLm9l4
	G9hoEs4qEK6KA7JXAq+T/VOxpuqbbjBxw=; b=ODfyc5VN1XktZTaVixa0mOPr2h
	yCWmis/o5iY3K0Bmbn9CBNXxV2gKK1wvrelztPOBby1cAjRfLesnU8BEhC3Ytie5
	dMI2IalHHoVVBRLNE0JuNW2HszkFH1xkD2Gi2WSgcnFt8vVbWTWVV+BCOdkpg90Y
	O5udD6QRVz4iDyqzXEJU7b7VZbE5JgYWr4eKEqsyEdkO68ZN2SO+V/cf9H6kK3lO
	El+4OteUSf7M3UtoTS9i3TlHrQCDZLPCNftz7OYO8bOgx9UWfxfym9KxcGeRCbg3
	Uv0YRUye6cl8YW+5fu0exPo85UI0hWEm+ks64Tg9wJdC1PhxHAyGXP4RLKow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738191459; x=1738277859; bh=dIAjZLm9l4G9hoEs4qEK6KA7JXAq+T/VOxp
	uqbbjBxw=; b=Re82+yKHLbi6gLsRrlp4bkOMG2MQRuSXKS9G5oQQtIDcMYpfVoF
	EED4BABsqbNICoyc8ZEe2X0UXgyqBD8aQ/aZ/XVK19AK07fcjeLp1lZlUIo01DM/
	+lXim50MQjKvASG55Ve5DxgYRv16OzOykXBtJH6LhKnweKZLzayj2CJpgZ90qF1t
	fACAm+o3UjAdgaCK0aoYjg4RDnA+EtzT4FKfQnatFiZ8SlvdciG39GFRL0fmM1np
	lO3umGwwvUjxVI69MIo4FzFxcFesXFcBIvy+M0o6jwLeA+D9lIVOjMY/53ZTE4OR
	Sh8HKdym0eFj/GfpgCJEwNY3c5OX6V1DqPQ==
X-ME-Sender: <xms:Y7KaZ7N3THkeH3v86Uqqc8bey8vBM24pU9uIxSU354bpyZGaHXi2LA>
    <xme:Y7KaZ1_lEzQc9rYnLAe0OL8ut4rAMG2ZhntLH8oE2rXlVGrxgcJ4xOKpTP0CvI0rJ
    w9TDw49_CSawH4gHRI>
X-ME-Received: <xmr:Y7KaZ6RbgNlXH4q3FtudbwWIgN146iO0B7rhoJEdWV-WyhlsWd2uuOoyU6vNufSoXgZJ9A5yB4Af3ywsIhWDpj11s4M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenuc
    ggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeu
    gfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepughsthgvrhgsrgesshhushgvrdgtiidprhgtphhtth
    hopehmrghhrghrmhhsthhonhgvsehmvghtrgdrtghomhdprhgtphhtthhopehfughmrghn
    rghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghlgiesshhushgvrdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:Y7KaZ_vID-bBRuvxOsYQOMI93iK5M-8PDiz6jR1iInxub9o3lJ4YnA>
    <xmx:Y7KaZzfZ8VBLTZqgBsJ8Jh5BiwOtqE_yavBKaj9cUkU9__2_Y9ja0A>
    <xmx:Y7KaZ72CuzFHFMgY6pY0JhtJHfQcPoMThrx-j_zy4Mm1nZeVZxwing>
    <xmx:Y7KaZ_8JJoPUD4KqzJNmwojX0EU4-bwR9CIh64LXzUiPivkurcRuSA>
    <xmx:Y7KaZ0HZ0LQZ0-Qsa_HQmVS1foSSXS2_ObPgft7yoJZ24q2lcBgiJY4T>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 17:57:38 -0500 (EST)
Date: Wed, 29 Jan 2025 14:58:22 -0800
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: Mark Harmstone <maharmstone@meta.com>,
	Filipe Manana <fdmanana@kernel.org>, Daniel Vacek <neelx@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
Message-ID: <20250129225822.GA216421@zen.localdomain>
References: <20250122122459.1148668-1-maharmstone@fb.com>
 <CAL3q7H4tB3Cb-djYhh_bGB-BRJ7EahjUZec2qfbhH7QHP2iSUw@mail.gmail.com>
 <CAPjX3Fd+-510YrvpxR1GcK2F+XKDVknxes2sj=Eat1Un1zvEkQ@mail.gmail.com>
 <20250123215955.GN5777@twin.jikos.cz>
 <CAPjX3Ffb2sz9aiWoyx73Bp7cFSDu3+d5WM-9PWW9UBRaHp0yzg@mail.gmail.com>
 <CAL3q7H7+UZcXPefg-_8R=eZj42P2UkV2=yE1dSv8BQZagEOhyQ@mail.gmail.com>
 <962f5499-d730-4e30-8956-7cac25a6b119@meta.com>
 <20250127201717.GT5777@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127201717.GT5777@twin.jikos.cz>

On Mon, Jan 27, 2025 at 09:17:17PM +0100, David Sterba wrote:
> On Mon, Jan 27, 2025 at 05:42:28PM +0000, Mark Harmstone wrote:
> > On 24/1/25 12:25, Filipe Manana wrote:
> > >>
> > >> It will only retry precisely when more concurrent requests race here.
> > >> And thanks to cmpxchg only one of them wins and increments. The others
> > >> retry in another iteration of the loop.
> > >>
> > >> I think this way no lock is needed and the previous behavior is preserved.
> > > 
> > > That looks fine to me. But under heavy concurrency, there's the
> > > potential to loop too much, so I would at least add a cond_resched()
> > > call before doing the goto.
> > > With the mutex there's the advantage of not looping and wasting CPU if
> > > such high concurrency happens, tasks will be blocked and yield the cpu
> > > for other tasks.
> > 
> > And then we have the problem of the function potentially sleeping, which 
> > was one of the things I'm trying to avoid.
> > 
> > I still think an atomic is the correct choice here:
> > 
> > * Skipped integers aren't a problem, as there's no reliance on the 
> > numbers being contiguous.
> > * The overflow check is wasted cycles, and should never have been there 
> > in the first place.
> 
> We do many checks that almost never happen but declare the range of the
> expected values and can catch eventual bugs caused by the "impossible"
> reasons like memory bitflips or consequences of other errors that only
> show up due to such checks. I would not cosider one condition wasted
> cycles in this case, unless we really are optimizing a hot path and
> counting the cycles.
> 

Could you explain a bit more what you view the philosophy on "impossible"
inputs to be? In this case, we are *not* safe from full on memory
corruption, as some other thread might doodle on our free_objectid after
we do the check. It helps with a bad write for inode metadata, but in
that case, we still have the following on our side:

1. we have multiple redundant inode items, so fsck/tree checker can
notice an inconsistency when we see an item with a random massive
objectid out of order. I haven't re-read it to see if it does, but it
seems easy enough to implement if not.

2. a single bit flip, even of the MSB, still doesn't put us THAT close
to the end of the range and Mark's argument about 2^64 being a big
number still presents a reasonable, if not bulletproof, defense.

I generally support correctness trumping performance, but suppose the
existing code was the atomic and we got a patch to do the inc under a
mutex, justified by the possible bug. Would we be excited by that patch,
or would we say it's not a real bug?

I was thinking some more about it, and was wondering if we could get
away with setting the max objectid to something smaller than -256 s.t.
we felt safe with some trivial algorithm like "atomic_inc with dec on
failure", which would obviously not fly with a buffer of only 256.

Another option is aborting the fs when we get an obviously impossibly
large inode. In that case, the disaster scenario of overflowing into a
dupe is averted, and it will never happen except in the case of
corruption, so it's not a worse UX than ENOSPC. Presumably, we can ensure
that we can't commit the transaction once a thread hits this error, so
no one should be able to write an item with an overflowed inode number.

Those slightly rambly ideas aside, I also support Daniel's solution. I
would worry about doing it without cond_resched as we don't really know
how much we currently rely on the queueing behavior of mutex.

> > Even if we were to grab a new integer a billion 
> > times a second, it would take 584 years to wrap around.
> 
> Good to know, but I would not use that as an argument.  This may hold if
> you predict based on contemporary hardware. New technologies can bring
> an order of magnitude improvement, eg. like NVMe brought compared to SSD
> technology.

I eagerly look forward to my 40GHz processor :)

