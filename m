Return-Path: <linux-btrfs+bounces-13624-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C06E4AA7123
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 14:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81301B61565
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 12:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D9F248F72;
	Fri,  2 May 2025 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XHoq/QPZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD81246775
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746187451; cv=none; b=WbFRowA+QwRnef0PDwP5uZiBd+oHKZcYJsR7tfccHoP8o4z1aMZ7wGv01OTZgNIY7HAwJdRCQKq7BjvTDSn0f1LgjzEj1+mGwDNke99hbEuxPEZ/pCAlo5qJhVxTN0dqUwkEB3r7KazITHKy+bPfpcv9rggCfA6nofgoVqCqI7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746187451; c=relaxed/simple;
	bh=k4toQUQd4GXmpTZtzVU6CEYOWMfMFzWaAitrU1KmboY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIexZC3q95uwmW1fKWQtxA+Mo9O3sgFw+sNUC4qZZqYY7YtLWSNNtmUR4GqeHju4zqIWqxSVk7sXxQz63wzTBTm7C5w7rShfMYfTbX/6mWtaI54Ce7qgI9xPiElNZe9SJjIAld+yoH2qJPYEDTWBOSppmqWg2vJqACYYRwA2ZAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XHoq/QPZ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so242235066b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 02 May 2025 05:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746187447; x=1746792247; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BPRPIKfVSGRq6ITejbYYVt34aehlUZuBk2QnZqFxJlA=;
        b=XHoq/QPZRT/kAdl4Tmg2DqqDg8Ad9aMkr/jb1BOxlpICsEzUjkm5KoEcrpPv01wkKv
         JpIIK04NlTi74lxIMUs9759cWEQF/W69teoNMs4jffv8c8/GL17xwAc9qlg6VbRJbfqU
         fbrgQCAHSkTyhhCwUvl5fVD/UAnaPUoL0rZdlzYOweGp3+7SVItw+DO5752w2gPk+seB
         HR5lg4Anty32d5HUaq58R6MPv4YvqCjTjkDIcpqiymOd9/GwOb7EGL7vUnYjVwWI+t4T
         iTld+KB0oRBGRZGtOav+IYZOyf95dGiajwMR1zILH7dShY6q4TV2/ELuF28jlnZ48X0G
         2rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746187447; x=1746792247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPRPIKfVSGRq6ITejbYYVt34aehlUZuBk2QnZqFxJlA=;
        b=qCML00nW9bHwwxW41ZQV5zkQ76uKsWjtfY4J21CDZfRW336XGjeZUQD9B5JwDNzV6t
         cRy1kUDGJDbfxpr68NA0Hz2izUHV00g6y2N5vMdYdcWYAngwFj/12TMFP5nXfC9SXJsx
         L56S7Ftnedy3lXTz8Qgl+abb0ljlhgxiYHufoikzAJP54irRwaShTpJszAeW/2XEKdNG
         9da6r87PfHHvUTu8T692u5q4eE/wTOfJD7Svz/mvrgJq1nS4c6+1nBdyfIinuXGqWMWO
         V0NWpeFRQ87FOH1sQ3l4XOoaKmRvEHgOJvDU5eLdv+z9RDlMMAHqTVDj79xxKKZqV/OA
         UHXA==
X-Forwarded-Encrypted: i=1; AJvYcCWwte99lv7+qcHaHEdMGyA8xi/R83+PA+eZu8JJ7S6pzMPwyuMeATwP3Cz/wbzTr/5p/0PzHHF4igf8Rw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu68SlVK2t/MxIwaqihJdqtACwCIP1ZEdNQtg6koSMVNdAI/BO
	0OjQtz6aJ4iJqG1i3rdinKHQ+2aRPCmzI4bJOSslBePWr4F5uBPVzl1H1v7XiWNH3PCdZ34wmE0
	Maq7orWGxI5rkeZERX7lpQeHeh/21mRTyCpQMxA==
X-Gm-Gg: ASbGncvJX78fa85hzmA2WLlEIPzTdlLfWzr60v1vICuWNxKtMNyjDFiy7cIlT1DDJiv
	xVq3wKRVpL7H59e/nhsSSGY3awv4ZuEgOz1LqhJvB8idCO7+fEyOA2n/weuYiGnKtRaisY/ZO0G
	119tuokZCPfvfd2KPjWPQg
X-Google-Smtp-Source: AGHT+IFexHphn+QwtEkGN0QtvusZk4g7qhyXzh59CokpzsuzOfXNl9izhrW/FeZ+1YAKnoX41c8fmxfpp5LBg3FF4pw=
X-Received: by 2002:a17:907:c28f:b0:acb:5583:6fe4 with SMTP id
 a640c23a62f3a-ad17ad3b23dmr269340766b.6.1746187447432; Fri, 02 May 2025
 05:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429151800.649010-1-neelx@suse.com> <20250430080317.GF9140@twin.jikos.cz>
 <CAPjX3FfBoU9-wYP-JC63K6y8Pzocu0z8cKvXEbjD_NjdxWO+Og@mail.gmail.com>
 <20250430133026.GH9140@suse.cz> <CAPjX3FdexSywSbJQfrj5pazrBRyVns3SdRCsw1VmvhrJv20bvw@mail.gmail.com>
 <20250502105630.GO9140@suse.cz>
In-Reply-To: <20250502105630.GO9140@suse.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 2 May 2025 14:03:55 +0200
X-Gm-Features: ATxdqUEf1RQiTTyAISQFpziz--aYmeR-Yd3u2T6S9hrE9Iviu6ITi3lYgPSwwQY
Message-ID: <CAPjX3Ffy2=CQP2mx9Wa3BBR54fEAcuo8ADqeTVdcAmCO7g+gmg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove extent buffer's redundant `len` member field
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 May 2025 at 12:56, David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Apr 30, 2025 at 04:13:20PM +0200, Daniel Vacek wrote:
> > On Wed, 30 Apr 2025 at 15:30, David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Wed, Apr 30, 2025 at 10:21:18AM +0200, Daniel Vacek wrote:
> > > > > The benefit of duplicating the length in each eb is that it's in the
> > > > > same cacheline as the other members that are used for offset
> > > > > calculations or bit manipulations.
> > > > >
> > > > > Going to the fs_info->nodesize may or may not hit a cache, also because
> > > > > it needs to do 2 pointer dereferences, so from that perspective I think
> > > > > it's making it worse.
> > > >
> > > > I was considering that. Since fs_info is shared for all ebs and other
> > > > stuff like transactions, etc. I think the cache is hot most of the
> > > > time and there will be hardly any performance difference observable.
> > > > Though without benchmarks this is just a speculation (on both sides).
> > >
> > > The comparison is between "always access 1 cacheline" and "hope that the
> > > other cacheline is hot", yeah we don't have benchmarks for that but the
> > > first access pattern is not conditional.
> >
> > That's quite right. Though in many places we already have fs_info
> > anyways so it's rather accessing a cacheline in eb vs. accessing a
> > cacheline in fs_info. In the former case it's likely a hot memory due
> > to accessing surrounding members anyways, while in the later case is
> > hopefully hot as it's a heavily shared resource accessed when
> > processing other ebs or transactions.
> > But yeah, in some places we don't have the fs_info pointer yet and two
> > accesses are still needed.
>
> The fs_info got added to eb because it used to be passed as parameter to
> many functions.

Makes sense.

> > In theory fs_info could be shuffled to move nodesize to the same
> > cacheline with buffer_tree. Would that feel better to you?
>
> We'd get conflicting requirements for ordering in fs_info. Right now
> the nodesize/sectorsize/... are in once cacheline in fs_info and they're
> often used together in many functions. Reordering it to fit eb usage
> pattern may work but I'm not convinced we need it.

I agree.

> > > > > I don't think we need to do the optimization right now, but maybe in the
> > > > > future if there's a need to add something to eb. Still we can use the
> > > > > remaining 16 bytes up to 256 without making things worse.
> > > >
> > > > This really depends on configuration. On my laptop (Debian -rt kernel)
> > > > the eb struct is actually 272 bytes as the rt_mutex is significantly
> > > > heavier than raw spin lock. And -rt is a first class citizen nowadays,
> > > > often used in Kubernetes deployments like 5G RAN telco, dpdk and such.
> > > > I think it would be nice to slim the struct below 256 bytes even there
> > > > if that's your aim.
> > >
> > > I configured and built RT kernel to see if it's possible to go to 256
> > > bytes on RT and it seems yes with a big sacrifice of removing several
> > > struct members that cache values like folio_size or folio_shift and
> > > generating worse code.
> > >
> > > As 272 is a multiple of 16 it's a reasonable size and we don't need to
> > > optimize further. The number of ebs in one slab is 30, with the non-rt
> > > build it's 34, which sounds OK.
> >
> > That sounds fair. Well the 256 bytes were your argument in the first place.
>
> Yeah, 256 is a nice number because it aligns with cachelines on multiple
> architectures, this is useful for splitting the structure to the "data
> accessed together" and locking/refcounting. It's a tentative goal, we
> used to have larger eb size due to own locking implementation but with
> rwsems it got close/under 256.
>
> The current size 240 is 1/4 of cacheline shifted so it's not all clean
> but whe have some wiggle room for adding new members or cached values,
> like folio_size/folio_shift/addr.

Sounds like we could force align to cacheline or explicitly pad to
256B? The later could be a bit tricky though.

> >
> > Still, with this:
> >
> > --- a/fs/btrfs/extent_io.h
> > +++ b/fs/btrfs/extent_io.h
> > @@ -82,7 +82,10 @@ void __cold extent_buffer_free_cachep(void);
> >  struct extent_buffer {
> >         u64 start;
> >         u32 folio_size;
> > -       unsigned long bflags;
> > +       u8 folio_shift;
> > +       /* >= 0 if eb belongs to a log tree, -1 otherwise */
> > +       s8 log_index;
> > +       unsigned short bflags;
>
> This does not compile because of set_bit/clear_bit/wait_on_bit API
> requirements.

Yeah, I realized when I tried to implement it. It was just an email
idea when sent.

> >         struct btrfs_fs_info *fs_info;
> >
> >         /*
> > @@ -94,9 +97,6 @@ struct extent_buffer {
> >         spinlock_t refs_lock;
> >         atomic_t refs;
> >         int read_mirror;
> > -       /* >= 0 if eb belongs to a log tree, -1 otherwise */
> > -       s8 log_index;
> > -       u8 folio_shift;
> >         struct rcu_head rcu_head;
> >
> >         struct rw_semaphore lock;
> >
> > you're down to 256 even on -rt. And the great part is I don't see any
> > sacrifices (other than accessing a cacheline in fs_info). We're only
> > using 8 flags now, so there is still some room left for another 8 if
> > needed in the future.
>
> Which means that the size on non-rt would be something like 228, roughly
> calculating the savings and the increase due to spinloct_t going from
> 4 -> 32 bytes. Also I'd like to see the generated assembly after the
> suggested reordering.

If I see correctly the non-rt will not change when I keep ulong
bflags. The -rt build goes down to 264 bytes. That's a bit better for
free but still not ideal from alignment POV.

> The eb may not be perfect, I think there could be false sharing of
> refs_lock and refs but this is a wild guess and based only on code

refs_lock and refs look like they share the same cacheline in every
case. At least on x86.
But still, the slab object is not aligned in the first place. Luckily
the two fields roam together.

Out of curiosity, is there any past experience where this kind of
optimizations make a difference within a filesystem code?
I can imagine perhaps for fast devices like NVDIMM or DAX the CPU may
become the bottleneck? Or are nowadays NVMe devices already fast
enough to saturate the CPU?

I faintly recall one issue where I debugged a CPU which could not keep
up with handling the interrupts of finished IO on NVMe submitted by
other CPUs. Though that was on xfs (or maybe ext4) not on btrfs. But
that was a power-play of one against the rest as the interrupt was not
balanced or spread to more CPUs.

> observation. You may have more luck with other data structures with
> unnecessary holes but please optimize for non-RT first.

Clearly non-rt is the default and most important. No questions here.

