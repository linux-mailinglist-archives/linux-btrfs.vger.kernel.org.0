Return-Path: <linux-btrfs+bounces-13661-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A025AA98A9
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 18:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87EE3A4F1B
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 16:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FA326980B;
	Mon,  5 May 2025 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fIuyebuh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0267926AA8F
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462008; cv=none; b=eKMW8znVxXLhCC0OerEI7vpH2fo+FuQ9oFMdZbkJkOtq3CkciEbbEj2eJIqnbnsrRIRKHifGqgEdA6ip8cGcqGkKyxrpTs3GPZ5gsO4xMKoN3kpQBuTVxRJaaXtXJSZ1s8T/UCik5ZIagzZOiatiZkKBx3ngsjO4EQQydBvpSKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462008; c=relaxed/simple;
	bh=GJGIujdqvg1xWEY2Z71vP7DJDLHy/fpyySkr1haUQhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcQCFT3/ud/2Jpq2CpOS4Ne+ub8RpZr6g2hHJ4KcOUt1IGdYCA+J5efndECzdF7nQIBLb0OAnImxKkCyN4RKxMuF7dkkY7CH8uKmCU2ucuNGNyJmgxH9evzjAqx2uIacYJOFk/wEQzR5fZL94BPzvTUuHtZT7UAIJS+HQGnv1BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fIuyebuh; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acbb48bad09so854552266b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 05 May 2025 09:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746462004; x=1747066804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KTaJzD5wlXNj6gSU8yS667BR6AMkr8aIxrqAiT7UBkM=;
        b=fIuyebuhJ9Blw/e34SwYWYGRJ4JdINeTFRZhnLfYKpl3ZhQXixbUn1yJKQhhSK9/rc
         LbCkKxCwSiz16jOb285aj6ROak0b/ACSIbVKJAj2AV8L2SHGH2F7/ZbUijM2oTPuYP5U
         dIijqzbQhKrhtfkoFvQl/jnuKF40BUMoZEO8l+lwHySw5NihI3+Kj82NlqLoCGit6da4
         Kcqx9lRxIdUspMsqXSll1LVnB8cOH7RULRYk/j/3dFgF42yNDc8jgrGJPK1DH+QdPqsQ
         fhE46v1zJuog/5Zypwu7WZtz0hhjfEBA8jqZWwiEJg6G7F82YF6yvNCQl539bOy2jVJ1
         xGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746462004; x=1747066804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTaJzD5wlXNj6gSU8yS667BR6AMkr8aIxrqAiT7UBkM=;
        b=E8YoTJHr7lNyEyEP1eUYeVVsDRaJFOEqxPUBXVam3HBcIYJuSVvByCs/9OllZ3IP7k
         INfPU6QIow1tpLSe3ZJsX98lXi+vvIo66679S2IeGWEEj1qQg0yonpzuhvQ+yEhQf+Ys
         yKGCaocJivX8DkiWvEITffdXCdl1s0d4QrVyXgdDPLAkPrRFsSDt84vkoXbXfskOOz1H
         ZjaKLeJsAJWW1XelmMfj75TKW4zo0lmAQQRuMYmh9AidX5b7qUAEtHyVe+oL8EaJRTs0
         32SIJU5m3SDFkZ8hTZtkTyRw4yTA45TrCx5ByKMw0Ur7FVqKrU7eSPYm2gZoktGg9MhR
         SQWg==
X-Forwarded-Encrypted: i=1; AJvYcCVmxejHkvDCkzznWlMdOuSudge49fKCds7mJH1SgL+zDIgarL3tGzu+aXZc90Tc4SBHnsx17uDHmYKo6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcFFRA3LG4Ey1ss2alzfcO5R3H/BY4n9a3AMTZcch9ZeIrvURk
	wjMrucyTClPdRUWQa1gi+/CALl582SgFDBJNIIzij9rrGlqhkh848JSkOfCQ0bGoVVNZhGqz6Ed
	piY5uNEd4sZs1Pgk4be2/7Ww0vzrX0MePAPxk4w==
X-Gm-Gg: ASbGncveZKAZv63wQzjy7Cf+9r8YO+196iSsgLz9fXkD2AAbja0zzTMnGvrYMwSmQwO
	F7Z+oeeO67l91TpAxlWR/3flj+SNQ7XaOKsjgTEqo2EMTZQsBElEXUUu8caL2vJcsW7V/S/P+A8
	f+bEOVcOfk+y8956Vx289u
X-Google-Smtp-Source: AGHT+IFXGOeb8hvV04Ro/TZTbp1dO+ISIeI4KdYxDzL4E9a8cFKNJS/JYu36/MK6jIBCIAWPLhXTTA5LAf8MTyNBUnc=
X-Received: by 2002:a17:906:6a0d:b0:ace:3f00:25f5 with SMTP id
 a640c23a62f3a-ad1a4897a73mr700368566b.2.1746462004274; Mon, 05 May 2025
 09:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429151800.649010-1-neelx@suse.com> <20250430080317.GF9140@twin.jikos.cz>
 <CAPjX3FfBoU9-wYP-JC63K6y8Pzocu0z8cKvXEbjD_NjdxWO+Og@mail.gmail.com>
 <20250430133026.GH9140@suse.cz> <CAPjX3FdexSywSbJQfrj5pazrBRyVns3SdRCsw1VmvhrJv20bvw@mail.gmail.com>
 <20250502105630.GO9140@suse.cz> <CAPjX3Ffy2=CQP2mx9Wa3BBR54fEAcuo8ADqeTVdcAmCO7g+gmg@mail.gmail.com>
 <20250505141019.GW9140@twin.jikos.cz>
In-Reply-To: <20250505141019.GW9140@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 5 May 2025 18:19:52 +0200
X-Gm-Features: ATxdqUEZT61KVeZ6jM8hQoCnjJA0RgSl9MIJO_BVgcu0oOKH-BgxIfoluMV6c6k
Message-ID: <CAPjX3Fc3C3xtfZ6Rh8ThYxC0SF3Nn5XsY5DVZ+P8v615tOF9tA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove extent buffer's redundant `len` member field
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 May 2025 at 16:10, David Sterba <dsterba@suse.cz> wrote:
>
> On Fri, May 02, 2025 at 02:03:55PM +0200, Daniel Vacek wrote:
> > > Yeah, 256 is a nice number because it aligns with cachelines on multiple
> > > architectures, this is useful for splitting the structure to the "data
> > > accessed together" and locking/refcounting. It's a tentative goal, we
> > > used to have larger eb size due to own locking implementation but with
> > > rwsems it got close/under 256.
> > >
> > > The current size 240 is 1/4 of cacheline shifted so it's not all clean
> > > but whe have some wiggle room for adding new members or cached values,
> > > like folio_size/folio_shift/addr.
> >
> > Sounds like we could force align to cacheline or explicitly pad to
> > 256B? The later could be a bit tricky though.
>
> We could and we also have conflicting goals:
>
> - alignment (with some waste)
>
> - more objects packed into the slab which is 8K

tl.dr> In the end I think it's all about the wasted memory. Either
there's a good reason for it when the alignment is required or there
is not and the slab can be packed. In the latter case there is no
point for discussing cache line misses, IMO. Am I right?

Slab allocator is not so simple. By default (but can be tuned globally
or per slab cache) slabs are allocated up to order 3, so 32Ki on x86.
But the allocator tries to keep the order lower if at the least
minimum number of (4*floor(log2(nr_cpus))+4) objects fit in.

So a bigger object size results in higher order of slabs (up to o3)
with about the same number of objects per slab. And vice versa.

In general, the tradeoff is more about wasted memory, see
calculate_order() and calc_slab_order(). But also the downside is that
higher order slab which wastes less memory could be harder to allocate
after some uptime and memory fragmentation.

Anyways, this is a job for slab and it does a good job already so that
you do not need to be all that concerned about it. Still, some concern
is always good.

Note, slab also honors the alignment of the given structure. So in the
end it ultimately depends on the alignment of struct extent_buffer. If
you really wanted to have some members hot in the same cacheline, we
could declare the structure with ____cacheline_aligned_in_smp.
Otherwise some objects may have the desired fields shared and some may
not.

Well, at least that would be the case if we used KMEM_CACHE() macro
which we don't at the moment. We still use the old kmem_cache_create()
API and we are requesting an alignment of 0. So the objects are placed
completely freely within the slab.

====

And a bit off topic but still related. I'm a bit more concerned about
wasting 3 xarray slots for each eb (only 1/4 of the slots are being
used due to deprecated legacy). Each leaf can store only up to 16 ebs
while there are 64 slots. That's because we are still indexing by
sector size and not by node size. The xarray/radix tree could save 75%
of the memory it is using now. At least for the common case of 4Ki
sector size and 16Ki node size.

> More objects mean better chance to satisfy allocations, that are right
> now NOFAIL, so blocking metadata operations with worse consequences.

Right, the more objects per slab the better amortized the allocation
overhead is. That's perfectly clear, no questions about it. But as I
mentioned this is mostly decided by the slab allocator. Yet, I
understand your concerns.

> > > >         struct btrfs_fs_info *fs_info;
> > > >
> > > >         /*
> > > > @@ -94,9 +97,6 @@ struct extent_buffer {
> > > >         spinlock_t refs_lock;
> > > >         atomic_t refs;
> > > >         int read_mirror;
> > > > -       /* >= 0 if eb belongs to a log tree, -1 otherwise */
> > > > -       s8 log_index;
> > > > -       u8 folio_shift;
> > > >         struct rcu_head rcu_head;
> > > >
> > > >         struct rw_semaphore lock;
> > > >
> > > > you're down to 256 even on -rt. And the great part is I don't see any
> > > > sacrifices (other than accessing a cacheline in fs_info). We're only
> > > > using 8 flags now, so there is still some room left for another 8 if
> > > > needed in the future.
> > >
> > > Which means that the size on non-rt would be something like 228, roughly
> > > calculating the savings and the increase due to spinloct_t going from
> > > 4 -> 32 bytes. Also I'd like to see the generated assembly after the
> > > suggested reordering.
> >
> > If I see correctly the non-rt will not change when I keep ulong
> > bflags. The -rt build goes down to 264 bytes. That's a bit better for
> > free but still not ideal from alignment POV.
> >
> > > The eb may not be perfect, I think there could be false sharing of
> > > refs_lock and refs but this is a wild guess and based only on code
> >
> > refs_lock and refs look like they share the same cacheline in every
> > case. At least on x86.
> > But still, the slab object is not aligned in the first place. Luckily
> > the two fields roam together.
> >
> > Out of curiosity, is there any past experience where this kind of
> > optimizations make a difference within a filesystem code?
> > I can imagine perhaps for fast devices like NVDIMM or DAX the CPU may
> > become the bottleneck? Or are nowadays NVMe devices already fast
> > enough to saturate the CPU?
>
> I don't have a specific example. This is tricky to measure and
> historically the devices were slow so any IO and waiting made the cache
> effects irrelevant. With NVMe, modern CPUs we might start seeing that.
> Instrumentation or profiling of the structures can do that, there are
> tools for that but the variability of the hardware combinations and
> runtime conditions makes it hard so I'm resorting to more "static"
> approach and go after known good patterns like alignment or placement
> related to cachelines (manually or with ____cacheline_aligned_in_smp).

Yeah, I know perf's cache to cache proved to be especially useful in
the past with the network stack and other parts of the kernel. But
that may be a bit different use-case.

> > I faintly recall one issue where I debugged a CPU which could not keep
> > up with handling the interrupts of finished IO on NVMe submitted by
> > other CPUs. Though that was on xfs (or maybe ext4) not on btrfs. But
> > that was a power-play of one against the rest as the interrupt was not
> > balanced or spread to more CPUs.

