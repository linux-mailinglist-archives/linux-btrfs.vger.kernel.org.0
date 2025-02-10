Return-Path: <linux-btrfs+bounces-11361-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBCEA2EE5B
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 14:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2294F188AB67
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 13:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899B5238743;
	Mon, 10 Feb 2025 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VEDbOCLS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4742309A5
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Feb 2025 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194358; cv=none; b=B9A/E8VkrU8HloOdsx1Tn9lAyTJrZ1Rg7M/kOuWdsqAYaTNgm+5WLztejlrlbc8DcQo0BP4umdDYZZ8AJUOH06TCb9UjJ7IeZfclaGO9fq0oq5DkAA99P+/u6lHkB9tCPX5RNn+SiwuUYwHmPrkGKvMTtmi3lFIjzPQOgu4kWag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194358; c=relaxed/simple;
	bh=p8DuYuxZZ8wRdqoAEuHht8d4AGRh5qMEh6fzpeJssLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqotyCci35v+azOtD64L/pEWH6AnJGyUxOlwhJgwdamxjq3V28ffBxLNCVeOoqRGPYZPj95udENYAt8Bi0TlGHg3riPgzwo7yohbj8hDHafjOaqaQSp72SPBOW+GFht2g00ORVHlT6tD1slTL8AATfUuS4W5EGgE5xdAqv/Z62I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VEDbOCLS; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7b7250256so203286366b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Feb 2025 05:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739194354; x=1739799154; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E+v06brcFB42U2Vu1GmVcQRfaYRcKujK37os0elnnFE=;
        b=VEDbOCLS1WDZzkUTwp0Yg66TH8kdg0dZKB5CJb8uy/asjmbDWl+IYSuHWjKu/meXz+
         EWtA143pbioDNXEy2IBzEoHe586uzS930DkVbvNf8ERfpavNga/Em8FHo06h6wGtwAtL
         PRZQvPXnYRIi2OtbKQ1at99C5vWd8XzzJcwtudclK5gHns2C8QCCjG+iPWaUT1UkDdv5
         uThXq9137Rjdzhl6dMQC8ZrwpVIVxUEEg0gVu4L3DLGLVcYQpXy3Df8wVyiYDV1sXe6R
         wNzK6V0wXLY4ngWq17OEJjziEcW7yBquRK6H2nRx5yIbEC05Cv+PPFtC7Z1/UvcVx075
         YkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194354; x=1739799154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+v06brcFB42U2Vu1GmVcQRfaYRcKujK37os0elnnFE=;
        b=SLukcnkDWeuHNIDNkUjJdXF60nBAfoXRSs6suCpSsrxf8hZPwFxV25vay+QCre5KuF
         Pl4cIlAjVgmE3JAd9PbnlR8mdkWiCP7xqxzuzLR56cgN7i01pwmCyjR5KjfesGdPKSOR
         rvBCakTDIB1TQUbcaMzZ1mMMMxQbMei6i0KJFI9ojsET5QcmLQNkY2z0J/Vjf9baEMKW
         IR21VthJEFkrQwaXavrsyrfatULGtgmZabn2V2YooKpx3Eo+ag4DVpgWP8CFJIjzn9yx
         kAhtxY8IDlRbsrttCo4+pN49hXksDJrtAPHqhPsErOyxtciBJIEjky2AElzfykxtCw58
         P1lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAzVqq6+XUqwq776jzElDTcO8XpJZVjb8A6GYUuLF2pT8jkiItKdBdlNOBbCfellpWnCOg16LR0wEOAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnHqxr1frlKa/zYcuX6H9KiTPW6h3+Uuqvtu4qU7ZhuoTIX2ns
	jFKpLC+FM4lZBvrE6cw06+ay82ieCqCszmafblE8RhbKQUr1xQrRr0bsLrnxyOAqn7RPxH8I/S9
	U+vIhW5kV/keO+cApMFum5A+RaGu96sweu6mK1w==
X-Gm-Gg: ASbGnctGaVnvETaOdm0QwsHY39ZFqEO5cuvuoF79Iyd8sSmTe287qTQWRpddGnoVP8e
	UAkoGz/YmAy4kVPeE8iSTSB10IsvSlVnubSOKsOay698N7EZXLarkBPDc+sXEJmJtjtEiN5I=
X-Google-Smtp-Source: AGHT+IFHG68nqQFnKUUE4MduEpd8xR7WyBbCx+V3tOlPVznuEgC7CDj5Or1MTp4uPLdKuf4takYSbsHXr642ZfMQpQs=
X-Received: by 2002:a17:907:a28d:b0:ab7:bcf1:277 with SMTP id
 a640c23a62f3a-ab7bcf11343mr455441666b.6.1739194353808; Mon, 10 Feb 2025
 05:32:33 -0800 (PST)
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
 <20250129225822.GA216421@zen.localdomain> <CAPjX3FfG9fpYWn-A8DROS9Kk3RTRj2RU+MP00gg7dCk=TF36Og@mail.gmail.com>
 <20250131193855.GA1197694@zen.localdomain> <4a42d804-ab7b-4734-a99f-c80ae354e93b@meta.com>
In-Reply-To: <4a42d804-ab7b-4734-a99f-c80ae354e93b@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 10 Feb 2025 14:32:22 +0100
X-Gm-Features: AWEUYZktZIom99DNiK6ibLWJGMr_kxI33FYsVlZV5PzezM-dmbyLqHqzUyVxoSM
Message-ID: <CAPjX3FfxTjVmkFE-BdTuLRd63_ctnPjXNmNY7sMq=v_-X4MoVw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
To: Mark Harmstone <maharmstone@meta.com>
Cc: Boris Burkov <boris@bur.io>, David Sterba <dsterba@suse.cz>, Filipe Manana <fdmanana@kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Feb 2025 at 16:09, Mark Harmstone <maharmstone@meta.com> wrote:
>
> On 31/1/25 19:38, Boris Burkov wrote:
> > >
> > On Thu, Jan 30, 2025 at 12:34:59PM +0100, Daniel Vacek wrote:
> >> On Wed, 29 Jan 2025 at 23:57, Boris Burkov <boris@bur.io> wrote:
> >>>
> >>> On Mon, Jan 27, 2025 at 09:17:17PM +0100, David Sterba wrote:
> >>>> On Mon, Jan 27, 2025 at 05:42:28PM +0000, Mark Harmstone wrote:
> >>>>> On 24/1/25 12:25, Filipe Manana wrote:
> >>>>>>>
> >>>>>>> It will only retry precisely when more concurrent requests race here.
> >>>>>>> And thanks to cmpxchg only one of them wins and increments. The others
> >>>>>>> retry in another iteration of the loop.
> >>>>>>>
> >>>>>>> I think this way no lock is needed and the previous behavior is preserved.
> >>>>>>
> >>>>>> That looks fine to me. But under heavy concurrency, there's the
> >>>>>> potential to loop too much, so I would at least add a cond_resched()
> >>>>>> call before doing the goto.
> >>>>>> With the mutex there's the advantage of not looping and wasting CPU if
> >>>>>> such high concurrency happens, tasks will be blocked and yield the cpu
> >>>>>> for other tasks.
> >>>>>
> >>>>> And then we have the problem of the function potentially sleeping, which
> >>>>> was one of the things I'm trying to avoid.
> >>>>>
> >>>>> I still think an atomic is the correct choice here:
> >>>>>
> >>>>> * Skipped integers aren't a problem, as there's no reliance on the
> >>>>> numbers being contiguous.
> >>>>> * The overflow check is wasted cycles, and should never have been there
> >>>>> in the first place.
> >>>>
> >>>> We do many checks that almost never happen but declare the range of the
> >>>> expected values and can catch eventual bugs caused by the "impossible"
> >>>> reasons like memory bitflips or consequences of other errors that only
> >>>> show up due to such checks. I would not cosider one condition wasted
> >>>> cycles in this case, unless we really are optimizing a hot path and
> >>>> counting the cycles.
> >>>>
> >>>
> >>> Could you explain a bit more what you view the philosophy on "impossible"
> >>> inputs to be? In this case, we are *not* safe from full on memory
> >>> corruption, as some other thread might doodle on our free_objectid after
> >>> we do the check. It helps with a bad write for inode metadata, but in
> >>> that case, we still have the following on our side:
> >>>
> >>> 1. we have multiple redundant inode items, so fsck/tree checker can
> >>> notice an inconsistency when we see an item with a random massive
> >>> objectid out of order. I haven't re-read it to see if it does, but it
> >>> seems easy enough to implement if not.
> >>>
> >>> 2. a single bit flip, even of the MSB, still doesn't put us THAT close
> >>> to the end of the range and Mark's argument about 2^64 being a big
> >>> number still presents a reasonable, if not bulletproof, defense.
> >>>
> >>> I generally support correctness trumping performance, but suppose the
> >>> existing code was the atomic and we got a patch to do the inc under a
> >>> mutex, justified by the possible bug. Would we be excited by that patch,
> >>> or would we say it's not a real bug?
> >>>
> >>> I was thinking some more about it, and was wondering if we could get
> >>> away with setting the max objectid to something smaller than -256 s.t.
> >>> we felt safe with some trivial algorithm like "atomic_inc with dec on
> >>> failure", which would obviously not fly with a buffer of only 256.
> >>
> >> You mean at least NR_CPUS, right? That would imply wrapping into
> >> `preempt_disable()` section.
> >
> > Probably :) I was just brainstorming and didn't think it through super
> > carefully in terms of a provably correct algorithm.
> >
> >> But yeah, that could be another possible solution here.
> >> The pros would be a single pass (no loop) and hence no
> >> `cond_resched()` needed even.
> >> For the cons, there are multiple `root->free_objectid <=
> >> BTRFS_LAST_FREE_OBJECTID` asserts and other uses of the const macro
> >> which would need to be reviewed and considered.
> >>
> >>> Another option is aborting the fs when we get an obviously impossibly
> >>> large inode. In that case, the disaster scenario of overflowing into a
> >>> dupe is averted, and it will never happen except in the case of
> >>> corruption, so it's not a worse UX than ENOSPC. Presumably, we can ensure
> >>> that we can't commit the transaction once a thread hits this error, so
> >>> no one should be able to write an item with an overflowed inode number.
> >
> > I am liking this idea more. A filesystem that eternally ENOSPCs on inode
> > creation is borderline dead anyway.
> >
> >>>
> >>> Those slightly rambly ideas aside, I also support Daniel's solution. I
> >>> would worry about doing it without cond_resched as we don't really know
> >>> how much we currently rely on the queueing behavior of mutex.
> >>
> >> Let me emphasize once again, I still have this feeling that if this
> >> mutex was contended, we would notoriously know about it as being a
> >> major throughput bottleneck. Whereby 'we' I mean you guys as I don't
> >> have much experience with regards to this one yet.
> >
> > In my opinion, it doesn't really matter if it's a bottleneck or not.
> > Code can evolve over time with people attempting to make safe
> > transformations until it reaches a state that doesn't make sense.
> >
> > If not for the technically correct point about the bounds check, then
> > changing
> >
> > mutex_lock(m);
> > x++;
> > mutex_unlock(m);
> >
> > to
> >
> > atomic_inc(x);
> >
> > is just a free win for simplicity and using the right tool for the job.
> >
> > It being a bottleneck would make it *urgent* but it still makes sense to
> > fix bad code when we find it.
>
> Yes, precisely. The major bottleneck for file creation is the locking
> for the dentries, but using a mutex just to increase an integer is
> obviously the wrong tool for the job.
>
> > I dug into the history of the code a little bit, and the current mutex
> > object dates back to 2008 when it was split out of a global fs mutex in
> > this patch:
> > a213501153fd ("Btrfs: Replace the big fs_mutex with a collection of other locks")
> > and the current bounds checking logic dates back to
> > 13a8a7c8c47e ("Btrfs: do not reuse objectid of deleted snapshot/subvol")
> > which was a refactor of running the find_highest algorithm inline.
> > Perhaps this has to do with handling ORPHAN_OBJECTID properly when
> > loading the highest objectid.
> >
> > These were operating in a totally different environment, with different
> > timings for walking the inode tree to find the highest inode, as well as
> > a since ripped out experiment to cache free objectids.
> >
> > Note that there is never a conscious choice to protect this integer
> > overflow check with a mutex, it's just a natural evolution of refactors
> > leaving things untouched. Some number of intelligent cleanups later and
> > we are left with the current basically nonsensical code.
> >
> > I believe this supports my view that this was never done to consciously
> > protect against some feared corruption based overflow. I am open to
> > being corrected on this by someone who was there or knows better.
>
> This was my conclusion, too - it was a relic of older code, rather than
> a conscious design decision.
>
> >
> > I think any one of:
> > - Mark's patch
> > - atomic_inc_unless
> > - abort fs on enospc
> > - big enough buffer to make dec on enospc work
> >
> > would constitute an improvement over a mutex around an essentially
> > impossible condition. Besides performance, mutexes incur readability
> > overhead. They suggest that some important coordination is occurring.
> > They incur other costs as well, like making functions block. We
> > shouldn't use them unless we need them.
> >
> >>
> >> But then again, if this mutex is rather a protection against unlikely
> >> races than against likely expected contention, then the overhead
> >> should already be minimal anyways in most cases and Mark's patch would
> >> make little to no difference really. More like just covering the
> >> unlikely edge cases (which could still be a good thing).
> >> So I'm wondering, is there actually any performance gain with Mark's
> >> patch to begin with? Or is the aim to cover and address the edge cases
> >> where CPUs (or rather tasks) may be racing and one/some are forced to
> >> sleep?
> >> The commit message tries to sell the non-blocking mode for new
> >> inodes/subvol's. That sounds fair as it is, but again, little
> >> experience from my side here.
> >
> > My understanding is that the motivation is to enable non-blocking mode
> > for io_uring operations, but I'll let Mark reply in detail.
>
> That's right. io_uring operates in two passes: the first in non-blocking
> mode, then if it receives EAGAIN again in a work thread in blocking mode.
>
> As part of my work to get btrfs receive to use io_uring, I want to add
> an io_uring interface for subvol creation. There's two things preventing
> a non-blocking version: this, and the fact we need a
> btrfs_try_start_transaction() (which should be relatively straightforward).
>
> >
> >>
> >>>>> Even if we were to grab a new integer a billion
> >>>>> times a second, it would take 584 years to wrap around.
> >>>>
> >>>> Good to know, but I would not use that as an argument.  This may hold if
> >>>> you predict based on contemporary hardware. New technologies can bring
> >>>> an order of magnitude improvement, eg. like NVMe brought compared to SSD
> >>>> technology.
> >>>
> >>> I eagerly look forward to my 40GHz processor :)
> >>
> >> You never know about unexpected break-throughs. So fingers crossed.
> >> Though I'd be surprised.
>
> More like 40THz, and somebody finding a way to increase the speed of
> light... There's four or five orders of magnitude to go before 64-bit
> wraparound would become a problem here.
>
> >> But maybe a question for (not just) Dave:
> >> Can you imagine (or do you know already) any workload which would rely
> >> on creating FS objects as lightning-fast as possible?
> >> The size of the storage would have to be enormous to hold that many
> >> files so that the BTRFS_LAST_FREE_OBJECTID limit could be reached or
> >> the files would have to be ephemeral (but in that case tmpfs sounds
> >> like a better fit anyways).
>
> Like I said, the dentry locking was the limiting factor for file
> creation when I looked into it. So it would have to be O_TMPFILE files,
> and then you'd hit the open fd limit early on.
>
> When I mentioned this issue to Chris Mason, he thought that maybe percpu
> integers were the way to go. We wouldn't need any locking then, and
> could keep the existing overflow check.

That sounds like an overkill. IMO, the atomic counter is perfectly fine here.

> Mark

