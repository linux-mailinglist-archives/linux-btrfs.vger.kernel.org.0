Return-Path: <linux-btrfs+bounces-13546-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D37AA4B30
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 14:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B141898CB0
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 12:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6913248F70;
	Wed, 30 Apr 2025 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BFhPg+sF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816AE22172B
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 12:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746016309; cv=none; b=Fus4JnxiEQPhbv/FaupnU0f3qdxDnxw4/8MG3uKDjbLTm4NuH1vY5yHL2RPkETbp1LT0X5Hano//LevQpZ9CZuHxTlIQgowefseJACLHCXQ25tPWz/TWxIcfV/OFBU+zngJaD3CcyA16b2/TyQ+PDny561ZD/hcmeu9jxAT7nVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746016309; c=relaxed/simple;
	bh=rtn7yLDEvfiwEk7EUKd3nIbv4/Qh8Y2eX4nRV1S1K60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYSU1Xw9YJpHA5GoGpM1A0iMWONmjZgbR+JHctNmCBI2RWe6kBlVZ4/Nt5/uW2w+AFgnqG27If/zgGx/khRlqUNXlR+k8Q7g8zHdmbXp6f/wFWmuDU27UgMWR1f/Nb0/C6JaIvxOxN0vFoLUno4rua14oBs5k/vVR6bRSkND+0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BFhPg+sF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-acbb48bad09so16663866b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 05:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746016305; x=1746621105; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hQdFT3CXC+wTZfljV6k5GYo/bu5BlFIO1d2AXG/ww5k=;
        b=BFhPg+sF6JEtKmV5CYy0bUDJqZGMP/DMle5hsfOiPPzoI07Wc8BT8SHbXgLGvN78NB
         rRH+94WT55BdoXGZijRrE/PtE6VM0gnAdp4xGpjUWYgaiSfP3NgMbYVIWUj2vEgwmD41
         /gg7OiuRRXg6mVKHgqhs66NpXE7VMmX/RCF1SrsI/OzH7zNJ/nSCPvVjJi3TmfIvqcyI
         JHlXLyDoEjXVSi6hqtxh/9MOJeaV7GaRxjeUe7IPDfpz4qj8f8pI0yv+QlowVFCl2zeq
         6SARencQMtUO3m5ly6db+ZwRvzHOy3BReYja+0R4knby4XzDOPatw8YE2kVvUvshmuyn
         aFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746016305; x=1746621105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQdFT3CXC+wTZfljV6k5GYo/bu5BlFIO1d2AXG/ww5k=;
        b=f/Q2r4HbzoIWemxE3p68QJU55a55TO8NnpZN2SPFyG1Ij5pq1TQVq4o8/3I1iouVjd
         oSFMQLzdNZDa9U0z8uYNkiXvSUqRfpnWghaXZx6TdI+GFFccKwwsTj4lptQaN322Ni8M
         V2ymnW4810ZFh2eer7yCTg4sH4FKw59cB9V0LrtEQRQsiqe+JimBBx8qqr/wYjSRaIBf
         o7RQQaTEydg51QJAblSe2mpB2PHUY07JyjR3Uw/WW5hecEK8jDsuMvg/if3wILq0QZFg
         pizmcA2qbcP+jERS7QEvso8ypVEardvg1B12qTuJml16MKDuOAhu9EYxvdVsSn3Vj/Zl
         e4bw==
X-Forwarded-Encrypted: i=1; AJvYcCWue0sTkrAXJ/+IlccXVzPsqAKYrnmYHN3XLUSB/i7lePeRBxRN5DHOd2jDr+6NyYqSSX2zSCdmuKi87g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzriFEOD38BR65U/DsDbeiJIEo21gPZ+BBtDep+S7PtTbj/aqZi
	3360/lOkFEMoLtlK9qOqezBrckuu7sJHLsBg4qlz9eW0tqlhjq6U6r/94Xk6pYxW/ssdv4vMEnT
	vGKUJl6PshFOwNRFGpbDOrImPN3+mVIRH1B0QEg==
X-Gm-Gg: ASbGnct5kjw2nnU5BLHAhWf+tUx/lftgOaYBhfI7sIUDrlZlfFLMEhrFPTbwfBY6aQS
	kz6S6fNeg9t+E0XYmw5ZFP62VtOratnQTY5ZWHvVOatTjb1RzuB06NXKrfLvXZaHlXG8V7FoSUl
	GzfShFjqoa8LPK1ovwD/T+
X-Google-Smtp-Source: AGHT+IGfvBwJh4zz3xEM3UjmypYEXhK/G1AKoUritCmLIeHI7FHNqa/gt+tifNrWGAKJHEQ9PLJaI4U7g+B5adalWJ4=
X-Received: by 2002:a17:907:1b22:b0:ac2:7f28:684e with SMTP id
 a640c23a62f3a-acee2156d04mr220073966b.6.1746016304702; Wed, 30 Apr 2025
 05:31:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429151800.649010-1-neelx@suse.com> <20250430080317.GF9140@twin.jikos.cz>
 <CAPjX3FfBoU9-wYP-JC63K6y8Pzocu0z8cKvXEbjD_NjdxWO+Og@mail.gmail.com>
In-Reply-To: <CAPjX3FfBoU9-wYP-JC63K6y8Pzocu0z8cKvXEbjD_NjdxWO+Og@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 30 Apr 2025 14:31:33 +0200
X-Gm-Features: ATxdqUFvNwkrZ_ZJns0Di-9O-zxMlXjm4v3Z-u9nF9TmaduaVWP58rZ50t9cRxY
Message-ID: <CAPjX3FdpjOfu61KTnQFKdGgh4u5eVz_AwenoPVNgP_eiuka3hw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove extent buffer's redundant `len` member field
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Apr 2025 at 10:21, Daniel Vacek <neelx@suse.com> wrote:
>
> On Wed, 30 Apr 2025 at 10:03, David Sterba <dsterba@suse.cz> wrote:
> >
> > On Tue, Apr 29, 2025 at 05:17:57PM +0200, Daniel Vacek wrote:
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
> > I've had this patch in my local branch for some years from the times we
> > were optimizing extent buffer size. The size on release config is 240
> > bytes. The goal was to get it under 256 and keep it aligned.
> >
> > Removing eb->len does not change the structure size and leaves a hole
> >
> >  struct extent_buffer {
> >         u64                        start;                /*     0     8 */
> > -       u32                        len;                  /*     8     4 */
> > -       u32                        folio_size;           /*    12     4 */
> > +       u32                        folio_size;           /*     8     4 */
> > +
> > +       /* XXX 4 bytes hole, try to pack */
> > +
> >         long unsigned int          bflags;               /*    16     8 */
> >         struct btrfs_fs_info *     fs_info;              /*    24     8 */
> >         void *                     addr;                 /*    32     8 */
> > @@ -5554,8 +5556,8 @@ struct extent_buffer {
> >         struct rw_semaphore        lock;                 /*    72    40 */
> >         struct folio *             folios[16];           /*   112   128 */
> >
> > -       /* size: 240, cachelines: 4, members: 14 */
> > -       /* sum members: 238, holes: 1, sum holes: 2 */
> > +       /* size: 240, cachelines: 4, members: 13 */
> > +       /* sum members: 234, holes: 2, sum holes: 6 */
> >         /* forced alignments: 1, forced holes: 1, sum forced holes: 2 */
> >         /* last cacheline: 48 bytes */
> >  } __attribute__((__aligned__(8)));
> >
> > The benefit of duplicating the length in each eb is that it's in the
> > same cacheline as the other members that are used for offset
> > calculations or bit manipulations.
> >
> > Going to the fs_info->nodesize may or may not hit a cache, also because
> > it needs to do 2 pointer dereferences, so from that perspective I think
> > it's making it worse.
>
> I was considering that. Since fs_info is shared for all ebs and other
> stuff like transactions, etc. I think the cache is hot most of the
> time and there will be hardly any performance difference observable.
> Though without benchmarks this is just a speculation (on both sides).
>
> > I don't think we need to do the optimization right now, but maybe in the
> > future if there's a need to add something to eb. Still we can use the
> > remaining 16 bytes up to 256 without making things worse.
>
> This really depends on configuration. On my laptop (Debian -rt kernel)
> the eb struct is actually 272 bytes as the rt_mutex is significantly
> heavier than raw spin lock. And -rt is a first class citizen nowadays,
> often used in Kubernetes deployments like 5G RAN telco, dpdk and such.
> I think it would be nice to slim the struct below 256 bytes even there
> if that's your aim.

Eventually we can get there by using ushort for bflags and moving
log_index and folio_shift to fill the hole.
Let me know what you think.

