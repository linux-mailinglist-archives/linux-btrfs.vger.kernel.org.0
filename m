Return-Path: <linux-btrfs+bounces-11177-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B69A22C91
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 12:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D551887E96
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 11:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099751D9329;
	Thu, 30 Jan 2025 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BCUAEC4f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A960A1AB507
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2025 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738236915; cv=none; b=uT8g8rdPkp/9k2Q7VXSeOWWKMtDb0U/Lfw1mB8By5m4wRgUROhwVmf2RBSM0OwFVlgdLrlJkUrj+3n9OOfLlUpS3GTVoRz9hSxDEQT3hr/4vqnTzqiz5HlFAFWntfDHtuyw62c3tixSezR5qDzrVFaWYdgIc5oXRDgTNQIP1B+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738236915; c=relaxed/simple;
	bh=tfFzam/jFHYUMtqdYvfXLZVWweNPmyH3aL2diHIO4gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmpRYRE5eiP3Kz9UTMeVj7QfWZ9TAaGr6mQXJ2jh8fXaBMkK3XmZcC+YDtULt4avTs3JiO38W0nmzf9R19mm3/GSjqilXbe/Ek+/iAegQtpN3T+3jPuUH3rqNMks3jsViLo5Ue1XwSYUC4J+SpqbpcbWcI1fU+LLHn8J/HO9A7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BCUAEC4f; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so125181466b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2025 03:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738236911; x=1738841711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oj8CG5rIrQjMoI52OerRkeINWPFKjjVRRbwBs7xuT7g=;
        b=BCUAEC4fkqmgNj4U4fh8QdObHZUm9A3NtGK524wc5krlEfYMnBZh2+6tfl9OFtMj4q
         nbux0lHiR1xfsGkeY9ntOPlR1+5x9Uid+QlJrJ8u0185PQVlt6D7S8V85uHCYSPv+akv
         Y6aUX8hGtDwTMUm4lg4YbhIn816cngWjA8cs0gr//js+iaSScw5XurMaq8ehxqfPL1hQ
         JVZiwumhnRTj3Chl0MEcxZ12f9BGQ0+S1oS2PqPGH4MZfF89CCJpqDNcD3qRkcKZu9IE
         E/1wX+/h3C0DiUxaLGgHHiUqEKvoWzVrsMCVz2ap3N5KKWQFH6swvMRITkrIYAmPveaV
         mrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738236911; x=1738841711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oj8CG5rIrQjMoI52OerRkeINWPFKjjVRRbwBs7xuT7g=;
        b=LyVWuSTrf5LLKojNZ70Yl8U2ablZDtkuAa6AUATvoNDssSrYJTPc0vZgUj6IqJz4VP
         WPVNTTZ/izbX4FJf17cZ1Vqq99NfL8FxIObriYY++oZ7RI+JYd7bKHApIJZHI3J8F0Hd
         4xuYYSdl4DOeuZ3BOP5vYd7Aoc9Q80mv5Fp9oxwyA1nrADVJzV6cAVF2+LlboXbAJJ8/
         gHTbEOJyyJF7FBrzT1MTPLBMvenYTZB5oqGfsbCM1zqAPowLkCjdVtGJD4667AcoC4f0
         kRwUk8uLpuSv32WMhQ7GV4m1li5RYf7JYYNMMc32EpuCJkwJvWL1xGa5ipVo8p4aXBhu
         qGwA==
X-Forwarded-Encrypted: i=1; AJvYcCW8AG92YMFG/0cEZinTFrXydyjdJ1UCeatrTVjWMuLavYVVshh8YfE5kV/lG7ep+KlmcjN4v7mUAVsSdg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkrsy/CoN5fBfVjrDi3A1LHa2khAFyTnO7t06gOj9b8EGKVMke
	CxmQjW2WY0hqaK/StSvgQptWigKTWvzJfON/FMqGmQnEEMxRStgf1byQJB4C0QihMNwI/31CRt5
	0P50fGwQJmwKY3Q/7nePHzwHwG7I0cqkokjyEQA==
X-Gm-Gg: ASbGncs3aZsuJIiK3hlxqC2JfQkud6EOx040NYbfR0kAsdMT69V0j61v3XcHlSvb+xl
	x2iWx4Ozm51UKNfLFKkv7kbFGP/QxbhuvBAlc/vGtWJmKgwZPkyGWRcP1hIAggPW8ETzIRh8=
X-Google-Smtp-Source: AGHT+IH0O1ZzRQISyJvJgvPxDJFFbDWDZc422/AabXBzyyIns9UbuheqfG6GtYppKbT+UTZavC795zq3NJ1cwICslsA=
X-Received: by 2002:a17:906:5785:b0:ab6:d575:953c with SMTP id
 a640c23a62f3a-ab6d5759623mr498310066b.47.1738236910779; Thu, 30 Jan 2025
 03:35:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122122459.1148668-1-maharmstone@fb.com> <CAL3q7H4tB3Cb-djYhh_bGB-BRJ7EahjUZec2qfbhH7QHP2iSUw@mail.gmail.com>
 <CAPjX3Fd+-510YrvpxR1GcK2F+XKDVknxes2sj=Eat1Un1zvEkQ@mail.gmail.com>
 <20250123215955.GN5777@twin.jikos.cz> <CAPjX3Ffb2sz9aiWoyx73Bp7cFSDu3+d5WM-9PWW9UBRaHp0yzg@mail.gmail.com>
 <CAL3q7H7+UZcXPefg-_8R=eZj42P2UkV2=yE1dSv8BQZagEOhyQ@mail.gmail.com>
 <962f5499-d730-4e30-8956-7cac25a6b119@meta.com> <20250127201717.GT5777@twin.jikos.cz>
 <20250129225822.GA216421@zen.localdomain>
In-Reply-To: <20250129225822.GA216421@zen.localdomain>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 30 Jan 2025 12:34:59 +0100
X-Gm-Features: AWEUYZmyVquTGjiCagfNgWfkkNfgGXEMCZGRfTR6WHf16TQq7QasqFpviM1GpeQ
Message-ID: <CAPjX3FfG9fpYWn-A8DROS9Kk3RTRj2RU+MP00gg7dCk=TF36Og@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.cz>, Mark Harmstone <maharmstone@meta.com>, 
	Filipe Manana <fdmanana@kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jan 2025 at 23:57, Boris Burkov <boris@bur.io> wrote:
>
> On Mon, Jan 27, 2025 at 09:17:17PM +0100, David Sterba wrote:
> > On Mon, Jan 27, 2025 at 05:42:28PM +0000, Mark Harmstone wrote:
> > > On 24/1/25 12:25, Filipe Manana wrote:
> > > >>
> > > >> It will only retry precisely when more concurrent requests race here.
> > > >> And thanks to cmpxchg only one of them wins and increments. The others
> > > >> retry in another iteration of the loop.
> > > >>
> > > >> I think this way no lock is needed and the previous behavior is preserved.
> > > >
> > > > That looks fine to me. But under heavy concurrency, there's the
> > > > potential to loop too much, so I would at least add a cond_resched()
> > > > call before doing the goto.
> > > > With the mutex there's the advantage of not looping and wasting CPU if
> > > > such high concurrency happens, tasks will be blocked and yield the cpu
> > > > for other tasks.
> > >
> > > And then we have the problem of the function potentially sleeping, which
> > > was one of the things I'm trying to avoid.
> > >
> > > I still think an atomic is the correct choice here:
> > >
> > > * Skipped integers aren't a problem, as there's no reliance on the
> > > numbers being contiguous.
> > > * The overflow check is wasted cycles, and should never have been there
> > > in the first place.
> >
> > We do many checks that almost never happen but declare the range of the
> > expected values and can catch eventual bugs caused by the "impossible"
> > reasons like memory bitflips or consequences of other errors that only
> > show up due to such checks. I would not cosider one condition wasted
> > cycles in this case, unless we really are optimizing a hot path and
> > counting the cycles.
> >
>
> Could you explain a bit more what you view the philosophy on "impossible"
> inputs to be? In this case, we are *not* safe from full on memory
> corruption, as some other thread might doodle on our free_objectid after
> we do the check. It helps with a bad write for inode metadata, but in
> that case, we still have the following on our side:
>
> 1. we have multiple redundant inode items, so fsck/tree checker can
> notice an inconsistency when we see an item with a random massive
> objectid out of order. I haven't re-read it to see if it does, but it
> seems easy enough to implement if not.
>
> 2. a single bit flip, even of the MSB, still doesn't put us THAT close
> to the end of the range and Mark's argument about 2^64 being a big
> number still presents a reasonable, if not bulletproof, defense.
>
> I generally support correctness trumping performance, but suppose the
> existing code was the atomic and we got a patch to do the inc under a
> mutex, justified by the possible bug. Would we be excited by that patch,
> or would we say it's not a real bug?
>
> I was thinking some more about it, and was wondering if we could get
> away with setting the max objectid to something smaller than -256 s.t.
> we felt safe with some trivial algorithm like "atomic_inc with dec on
> failure", which would obviously not fly with a buffer of only 256.

You mean at least NR_CPUS, right? That would imply wrapping into
`preempt_disable()` section.
But yeah, that could be another possible solution here.
The pros would be a single pass (no loop) and hence no
`cond_resched()` needed even.
For the cons, there are multiple `root->free_objectid <=
BTRFS_LAST_FREE_OBJECTID` asserts and other uses of the const macro
which would need to be reviewed and considered.

> Another option is aborting the fs when we get an obviously impossibly
> large inode. In that case, the disaster scenario of overflowing into a
> dupe is averted, and it will never happen except in the case of
> corruption, so it's not a worse UX than ENOSPC. Presumably, we can ensure
> that we can't commit the transaction once a thread hits this error, so
> no one should be able to write an item with an overflowed inode number.
>
> Those slightly rambly ideas aside, I also support Daniel's solution. I
> would worry about doing it without cond_resched as we don't really know
> how much we currently rely on the queueing behavior of mutex.

Let me emphasize once again, I still have this feeling that if this
mutex was contended, we would notoriously know about it as being a
major throughput bottleneck. Whereby 'we' I mean you guys as I don't
have much experience with regards to this one yet.

But then again, if this mutex is rather a protection against unlikely
races than against likely expected contention, then the overhead
should already be minimal anyways in most cases and Mark's patch would
make little to no difference really. More like just covering the
unlikely edge cases (which could still be a good thing).
So I'm wondering, is there actually any performance gain with Mark's
patch to begin with? Or is the aim to cover and address the edge cases
where CPUs (or rather tasks) may be racing and one/some are forced to
sleep?
The commit message tries to sell the non-blocking mode for new
inodes/subvol's. That sounds fair as it is, but again, little
experience from my side here.

> > > Even if we were to grab a new integer a billion
> > > times a second, it would take 584 years to wrap around.
> >
> > Good to know, but I would not use that as an argument.  This may hold if
> > you predict based on contemporary hardware. New technologies can bring
> > an order of magnitude improvement, eg. like NVMe brought compared to SSD
> > technology.
>
> I eagerly look forward to my 40GHz processor :)

You never know about unexpected break-throughs. So fingers crossed.
Though I'd be surprised.

But maybe a question for (not just) Dave:
Can you imagine (or do you know already) any workload which would rely
on creating FS objects as lightning-fast as possible?
The size of the storage would have to be enormous to hold that many
files so that the BTRFS_LAST_FREE_OBJECTID limit could be reached or
the files would have to be ephemeral (but in that case tmpfs sounds
like a better fit anyways).

