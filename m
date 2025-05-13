Return-Path: <linux-btrfs+bounces-13972-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDF4AB5322
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 12:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4C51891C06
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 10:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BCF23ED74;
	Tue, 13 May 2025 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b86lF3XJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348351F03CF
	for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747132998; cv=none; b=EQwxVVIawz0IHxudH/ihn7maMRnf3x4Rge0Jt+i+mFILjiXPUqRoO7TEFdxZrcWKAhR6ZUgzPDl6IOzKAL7+DVAqdxZAOP2qnbmJ1PzYdYuwIP4yHUIqxnuaJNbEuFcxqylBo2LoV84DU8ZlNKRSX7Y10uzUnYqnDOQsjQR6XBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747132998; c=relaxed/simple;
	bh=IaYOh3FvIMYreE3X0cfXpIjVfC0DOQm+8LIadSgDHtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuGsWwMZDJdxwUbJfRIUax30gsj1hx8j2WTxwAoSl8i0c/i6Q9uRiNvXLis8ifldd+dXcxRapi85DLmcq4K7VSk9r17XYD3Sqd7kIumpMsGFcQZLg8KVHa1DeLSacgpIJiqUqN1++Fm8IB6RC2Z9neBJDVvJxOv4rSCQ8hrDg1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b86lF3XJ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad21cc2594eso9953366b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 03:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747132994; x=1747737794; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BnkKSLMFWirkV+KBeE/kgA5LXY+hN4q4xgGq0GY+0SI=;
        b=b86lF3XJtHTArKEOWkrlOg8ffjLqGDJgcb+j4O9vIEnrLbkSSPcv5qlYiNSFR9TobZ
         VjknaclDGSxV0UoxfvyXOoUJMrzIysDfbPSw3klKgtLhPEdDru6onFZTWDPnsik91uJt
         Abtx4TbV9i9ytg0HRRkQ+ZCr+XVzwshEl+KFp1bY2VJem8+4B5m4f/ve4oFuR8bFsX2W
         +qTglAkSwEtWfk3B/y/pY1K0R0W7GOpFDRXrNz6TBIGPZPEG4WOkL8frVLu6tvolhVrz
         7bFip2Jn4ftnz0kYjNeotmjVAREWszPcbhzNK6ilyI+TR7xSP9nqzLT/Tp9PU4Cgw+mo
         Q3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747132994; x=1747737794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnkKSLMFWirkV+KBeE/kgA5LXY+hN4q4xgGq0GY+0SI=;
        b=SsUeox0j6Nf86+eRZzgYFLT7VL8Qf+7jhi9yhN00vKlndBx+b+QGITmaNOF1PSflfI
         0+stHZ/76D4QyvZQQWBRQCqXznT851BH0Wt7/m2V+gYXaEKXZFIaVQzNa8rEBBGoZiwf
         IOAXhNA7LkWqFvLmRCblCNC5kqUgFrCK8oUSpX3m1si9Mb6nZ8CEj3sZRPtxsKw318Ej
         PfT8+ReBOjvC2G8+XhMa1NTUZi0n5J8uRCBvzWmXv879b0fbf6VF+k/tO1RWTmLGk1/u
         GF8jLdfv0pmAw77swXxLTiO9zrblmEHZmVQJGFGV5Yi2dRf87pmFHAweO7FMOMOA3LwW
         r/2A==
X-Forwarded-Encrypted: i=1; AJvYcCVowghxlQjlRTNUCXf76QaDlncFtIacrGMPVdHxrZjWpw3gFTu4FydjqnVCQYerNBZXvnNQGfVDOQiQtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXqFvJbrmA//STtRVOy6tjnHizToNXvvd9VlpoII6Bo3zJsNR8
	xYizoSno57R4Q8pdmHuqxerr7zMszroR8Y8EQYU2ItqWqyPMvnE1kVplYbYZm2aBcOuFe+t5twY
	6iubUJzag2iHrLjNmeOv6KbelmrHkgniQCVzt8VCzgCHkpfjPmAQ=
X-Gm-Gg: ASbGncvPpWxju00azzJcSpbpFtdIeUG83fhpz525vDxuQGpKjeIMmNc1KM0A/HvqVSD
	BwsNz4uRYRRLod56VtwKgHTbVYAnIzVfgh68YSvXCt3aazZxOWpTIB2u7eMyjI5PZ/oXz1bkJrK
	DuRidPj1BmWndUTDqPDN5eTKh1cbNh85M=
X-Google-Smtp-Source: AGHT+IGrEchgHdLMUdss9BMWal8Z3yNsvOyPjVCzLRtDEx7FbGA7IUNrVWSkAmFM65s2vxpF9pz5d+T+4rAjGExeqNg=
X-Received: by 2002:a17:907:97c1:b0:ad2:404d:cade with SMTP id
 a640c23a62f3a-ad2404dcd9cmr1040764266b.27.1747132994353; Tue, 13 May 2025
 03:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505115056.1803847-1-neelx@suse.com> <20250505115056.1803847-2-neelx@suse.com>
 <20250505151817.GX9140@twin.jikos.cz> <CAPjX3FfbeGmPkXY1NDnecrtcLe5dqX7+vLOLGe3sdggUfS-WSg@mail.gmail.com>
 <20250513003200.GZ9140@twin.jikos.cz>
In-Reply-To: <20250513003200.GZ9140@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 13 May 2025 12:43:03 +0200
X-Gm-Features: AX0GCFtoBq_P5Ys1TUxPoFoovKd2t5qxLf-JglFhrBAXlnnCoYTcZWqLFMO-rAc
Message-ID: <CAPjX3FdNLjLGQ+0oyZgYOHAy0QxkEcycr86WQt9UyiLjXw5uJA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] btrfs: remove extent buffer's redundant `len`
 member field
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 May 2025 at 02:32, David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, May 05, 2025 at 07:53:16PM +0200, Daniel Vacek wrote:
> > On Mon, 5 May 2025 at 17:18, David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Mon, May 05, 2025 at 01:50:54PM +0200, Daniel Vacek wrote:
> > > > Even super block nowadays uses nodesize for eb->len. This is since commits
> > > >
> > > > 551561c34663 ("btrfs: don't pass nodesize to __alloc_extent_buffer()")
> > > > da17066c4047 ("btrfs: pull node/sector/stripe sizes out of root and into fs_info")
> > > > ce3e69847e3e ("btrfs: sink parameter len to alloc_extent_buffer")
> > > > a83fffb75d09 ("btrfs: sink blocksize parameter to btrfs_find_create_tree_block")
> > > >
> > > > With these the eb->len is not really useful anymore. Let's use the nodesize
> > > > directly where applicable.
> > >
> > > You haven't updated the changelog despite we had a discussion about the
> > > potential drawbacks, so this should be here. But I'm not convinced this
> >
> > Right. That's because I was not sure we came to any conclusion yet. I
> > thought this discussion was still ongoing. I understand that so far
> > this is still all just a theory and any premature conclusions may be
> > misleading.
> >
> > But yeah, I may write some kind of a warning or a disclaimer
> > mentioning the suspicion. Just so that it gets documented and it is
> > clear it was considered, even though maybe without a clear conclusion.
> >
> > > is a good change. The eb size does not change so no better packing in
> > > the slab and the caching of length in the same cacheline is lost.
> >
> > So to be perfectly clear, what sharing do you mean? Is it the
> > eb->start and eb->len you talking about? In other words, when getting
> > `start` you also get `len` for free?
>
> Yes, basically.
>
> > Since the structure is 8 bytes aligned, they may eventually still end
> > up in two cachelines. Luckily the size of the structure is 0 mod 16 so
> > just out of the luck this never happens and they are always in the
> > same cache line. But this may break with future changes, so it is not
> > rock solid the way it is now.
>
> Yes, with structures not perfectly aligned to a cacheline (64B) there
> will be times when the access needs fetching two cachelines. With locks
> it can result in various cacheline bouncing patterns when various
> allocated structures are aligned to 8 bytes, giving 8 possible groups of
> "misaligned" structure instances.
>
> There's also a big assumption that the CPU cache prefetcher is clever
> enough to average out many bad patterns. What I try to do on the source
> code level is to be able to reason about the high level access patterns,
> like "used at the same time -> close together in the structure".

That makes sense. The closer they are the higher the chance they end
up in the same cacheline if the object itself is free of alignment.

> > > In the assebly it's clear where the pointer dereference is added, using
> > > an example from btrfs_get_token_8():
> > >
> > >   mov    0x8(%rbp),%r9d
> > >
> > > vs
> > >
> > >   mov    0x18(%rbp),%r10
> > >   mov    0xd38(%r10),%r9d
> >
> > I understand that. Again, this is what I originally considered. Not
> > all the functions end up like this but there are definitely some. And
> > by a rule of a thumb it's roughly half of them, give or take. That
> > sounds like a good reason to be concerned.
> >
> > My reasoning was that the fs_info->nodesize is accessed by many so the
> > chances are it will be hot in cache. But you're right that this may
> > not always be the case. It depends. The question remains if that makes
> > a difference?
> >
> > Another (IMO valid) point is that I believe the code will dereference
> > many other pointers before getting here so this may seem like a drop
> > in the sea. It's not like this was a tight loop scattering over
> > hundreds random memory addresses.
> > For example when this code is reached from a syscall, the syscall
> > itself will have significantly higher overhead then one additional
> > dereference. And I think the same applies when reached from an
> > interrupt.
> > Otherwise this would be visible on perf profile (which none of us
> > performed yet).
>
> Yeah and I don't intend to do so other than to verify your measurements
> and calims that this patch does not make things worse at least. The
> burden is on the patch submitter.

Totally. I'll run some profiles to see if anything significant is
visible. Not sure what workload to use though? I guess fio would be a
good starting point?

Though we agreed that this also depends on the actual HW used.
Whatever numbers I present, if my CPU is fast enough and my storage is
slow enough, I'll hardly ever find any issue. I think this needs more
broader testing than just one's claims that this is OK for me
(provided my results would suggest so).

So how about pushing this to misc-next to get some broader testing and
see if there are any issues in the bigger scope?

> > Still, I'd say reading the assembly is a good indication of possible
> > issues to be concerned with. But it's not always the best one. An
> > observed performance regression would be.
> > I'll be happy to conduct any suggested benchmarks. Though as you
> > mentioned this may be also picky on the used HW.
>
> I'd say any contemporary hardware is good, I don't think the internal
> CPU algorithms of prefetching or branch predictions change that often. A
> difference that I would consider significant is 5% in either direction.

I meant the storage part rather than the CPU. Though the CPUs also
differ in cache sizes between consumer and server parts.

> > So even though we
> > don't see any regressions with our testing, one day someone may find
> > some if we merged this change. In which case we can always revert.
> >
> > I have to say I'm pretty happy with the positive feedback from the
> > other reviewers. So far you're the only one raising this concern.
>
> I don't dispute the feedback from others, the patch is not wrong on
> itself, it removes a redundant member. However I don't see it as a
> simple change because I also spent some time looking into that
> particular structure, shrinking size, member ordering and access
> patterns that I am questioning the runtime performance implications.

With that experience, would you suggest any other tests than fio where
a performance change could be visible? Something I can focus on?

> My local eb->len removal patch is from 2020 and I decided not to send it
> because I was not able to prove to myself it'd be for the better. This
> is what I base my feedback on.

I understand. Let's see what we can do about it.

> > So how do we conclude this?
>
> I don't agree to add this patch due to the following main points:
>
> - no struct size change, ie. same number of objects in the slab

Right. That makes sense as the original idea was about code cleanup
and not about reducing the struct size in terms of bytes.
I did not think a cleanup needs to be justified by reducing the struct
size. Even without that I believe it's still a good cleanup.
The struct is still reduced by one member (with a new hole now).
Moreover with the followup patch the size is actually reduced at least
for -rt configs by filling the new hole so that the later hole is not
created at all. This wins 8 bytes for -rt. Not much and maybe not
worth it. Or is it?

That said, as long as the removed member was not meant to cache the
fs-wide value for performance reasons. I did not see any documentation
or code comments suggesting that's the case (even you're not able to
tell for sure) and so I thought it may be fine to remove this eb->len
field.
Which brings us to the point below.

> - disputed cacheline behaviour, numbers showing improvement or not
>   making it worse needed

I'll look into this. As I said, any hints are welcome otherwise I'll
start with fio and I'll compare the perf profiles of some functions
which access the data. Let me know if I can do anything better than
that, please.

> > If you don't want this cleanup I'd opt at least for rename eb->len
> > ==>> eb->nodesize.
>
> This sounds like an unnecessary churn. 'length' related to a structure
> is natural, nodesize is a property of the whole filesystem, we're used
> to eb->len, I don't any benefit to increase the cognitive load.

Now, our points of view differ here. For someone new to the codebase,
I need to carry on the additional information that eb->len actually
means the nodesize. In other words without digging this detail up the
code just hides that fact.
Since it's always set to nodesize, it does not really mean 'length' as
in any arbitrary length, like 12345 bytes.
And that's what I was trying to clean up. See? Does it make sense?
Also that's why as an alternative I suggested renaming the member if
removing it is not really favorable.

And I thought it can also have implications maybe at some places when
you realize that what's being used in the expression as eb->len really
means the fs-wide nodesize.

After all, with this insight I realized that the buffer_tree is
inefficient as we're wasting the slots using the tree really sparsely.
Since there are no shorter ebs, those empty slots can never be filled.

So using the right name actually makes sense, IMO. For code clarity.
But I can also understand your point and I can get used to it. It just
does not feel right to me, but it's not a big deal. I just mentioned
it to know others' POV and explain the intention one way or the other.

