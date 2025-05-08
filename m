Return-Path: <linux-btrfs+bounces-13840-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10229AB002A
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 18:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539581C20F40
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 16:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3CF280CD0;
	Thu,  8 May 2025 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="n8luzSUB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Keqz5huG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4E1280CCE
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721126; cv=none; b=D/9f41BUm0MpfIAtZuUFv4z77mYFK3x9M3/77HZlFcst3ywpaLXb1hrhV7w+ao4OmvQ07r0we+Uu8TE3Yc+CyeLt+iPTrbmLZ15z91PSNheifduGwwBjYvAvOC/dfdb+1FGlo8n32G7StpUZ4YY/gkM76T9ZNwWYzqkcqLmTaug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721126; c=relaxed/simple;
	bh=PD3cXlCJ1PRuqPOH2vJovgA1S49L3+X315TJ20Lio2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbwaLTdjFoaZ2zrEeOiNHPJxjpe5TF62pa/LrhsJIkhgrhl7/4wH1BhaZnpI9hpQkTTrmH6au3PS3pUf+w4Vp2cuXeeNGVH/rjPbJUGKX8DuHI/TNaPA32E6BhvkPcdpjWfmc1I6M1FUI7DazsQBOmqenQJg7v087o6woJEfxgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=n8luzSUB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Keqz5huG; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A31E81140197;
	Thu,  8 May 2025 12:18:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 08 May 2025 12:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1746721123;
	 x=1746807523; bh=wwVgTMwPGNDBdNmki0m9W1RfTplOqi3U5gM0JKc7T00=; b=
	n8luzSUBtB18GjSunMICUtjrfNIwK5PCv01zVEvAbkNhp57nGmzEey2cFNn23jlE
	Ra5eCqQC3VGBhPciyxsn/H+HAdn7GaScOoYGeNbM/Wbc8kan+hTQGXj8wxKC6OW7
	EaqAvvNPODqqN+jnec9aAosP+EYtRR/wDULw2E+BY7BXYfdpY7D9vIcxFAEvG/1O
	xW7Mom6nMo2ch0ZX2z9HT1zsLSmz/kZTNdlthIxS7lfHE0gdQo3/BlgDeK13Q4LT
	BPaAyxEf6SN2o1yIlgBOJ0HQLy0YcWR3maQmerAfY3sDHXok/2VBL/AaR2WFNjL+
	wlI4WPTTV1MuG9PxUsrh4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746721123; x=
	1746807523; bh=wwVgTMwPGNDBdNmki0m9W1RfTplOqi3U5gM0JKc7T00=; b=K
	eqz5huGZIJ/xYuBE+Zbq1kItLTPSmzpLfVTg96cGSfP4rqeAo4w0sfMXn46D89l6
	L/kEh5UAXmCH7xbhZ7uKmcHDmhe4KlN1aimxz9uds+dskW1nyB8qVnjsD1NOs1Ms
	cpN6scwFcFtP7UBDVQJ0+dhdmCgua+vDc6lpTosvOLACV++frIPZXE1hjKuRBb05
	EREUYROA+VpBlxpz2eeLpz/6/5fzgGuFg0T4BuGmDMeGVsDxPWiOw6h2iiwkdoVB
	YUJzGRPPwKZc8lEZ6VrPtIz2UuGGQ17d8i7pbM0sH34P2oHfCtVlDRZQuXSEYDob
	JGp+12v56Ss2S18gIvn6w==
X-ME-Sender: <xms:Y9kcaIuYsifdQDunIKUd3GsBfp49lMC3Y7BMsAZys8R9xB0UpUXILA>
    <xme:Y9kcaFfxMc5JnUiSmFJnDlWSOOAQwGXS9ucCkj1-A4DAElnJFd0kr6SI0njtIATXX
    ZAJr7nipl-aoPBWQMc>
X-ME-Received: <xmr:Y9kcaDxErI-bPC37FD2oWcTYBSqLOztYt20HK_Mh1pG4sIiYA7Ef80Qc5Ypu0S1DiYO132Px8PycODIH-6jwiiTMjis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledtvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioh
    eqnecuggftrfgrthhtvghrnhepudelhfdthfetuddvtefhfedtiedtteehvddtkedvledt
    vdevgedtuedutdeitdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:Y9kcaLNh2iXDWVK0_iVGSYyp5KuLJfVhZ2fOwbFxOU3wxkVnQlDAVQ>
    <xmx:Y9kcaI8vCtlcgFy7r7uqSu-B9PXRyk_2eUFJ13n0j7VPAPAO9JONlg>
    <xmx:Y9kcaDVWy-oyFanHng1ktkl-DH-uuD9JFM2wj4a4Sv6ZyGlWZIaeVg>
    <xmx:Y9kcaBfkgIkU_-2GfaSCckA6Qu_9NoecuK3qJoqDIRpr_itQB-Iy7g>
    <xmx:Y9kcaMIkHUgQHYNnoGqpMLHC16a0MaqkQsryRXu3Al8Bh2alXa8x00NV>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 12:18:43 -0400 (EDT)
Date: Thu, 8 May 2025 09:19:24 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/5] btrfs: fix qgroup reservation leak on failure to
 allocate ordered extent
Message-ID: <20250508161924.GC3935696@zen.localdomain>
References: <cover.1746638347.git.fdmanana@suse.com>
 <b2b4a73fb7ef395f131884cd5c903cbf92517e6f.1746638347.git.fdmanana@suse.com>
 <20250507223347.GB332956@zen.localdomain>
 <CAL3q7H6tk-Z3bQY8uiZf=CfqfD_9tmpqRTdOS5wHymwgChp+EA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6tk-Z3bQY8uiZf=CfqfD_9tmpqRTdOS5wHymwgChp+EA@mail.gmail.com>

On Thu, May 08, 2025 at 02:40:22PM +0100, Filipe Manana wrote:
> On Wed, May 7, 2025 at 11:33 PM Boris Burkov <boris@bur.io> wrote:
> >
> > On Wed, May 07, 2025 at 06:23:13PM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > If we fail to allocate an ordered extent for a COW write we end up leaking
> > > a qgroup data reservation since we called btrfs_qgroup_release_data() but
> > > we didn't call btrfs_qgroup_free_refroot() (which would happen when
> > > running the respective data delayed ref created by ordered extent
> > > completion or when finishing the ordered extent in case an error happened).
> > >
> > > So make sure we call btrfs_qgroup_free_refroot() if we fail to allocate an
> > > ordered extent for a COW write.
> >
> > I haven't tried it myself yet, but I believe that this patch will double
> > free reservation from the qgroup when this case occurs.
> 
> Nop, see below.
> 
> >
> > Can you share the context where you saw this bug? Have you run fstests
> > with qgroups or squotas enabled? I think this should show pretty quickly
> > in generic/475 with qgroups on.
> 
> Yes, I have run fstests. I always do before sending a patch, no matter
> how simple or trivial it is (or seems to be).

For the record, I was not suggesting that you hadn't run fstests, I just
wasn't sure if you ran them with qgroups on for every test as well.

> 
> This isn't a scenario that can be triggered with fstests since there
> are no test cases that inject memory allocation failures on ordered
> extents or anything else.
> generic/475 simulates IO failures with dm error, so I don't see why
> you think that would be relevant when the problem here is on ordered
> extent allocation failure and not IO errors.
> 

Yes, I noticed that later, while discussing with Qu.

> >
> > Consider, for example, the following execution of the dio case:
> >
> > btrfs_dio_iomap_begin
> >   btrfs_check_data_free_space // reserves the data into `reserved`, sets dio_data->data_space_reserved
> >   btrfs_get_blocks_direct_write
> >     btrfs_create_dio_extent
> >       btrfs_alloc_ordered_extent
> >         alloc_ordered_extent // fails and frees refroot, reserved is "wrong" now.
> >       // error propagates up
> >     // error propagates up via PTR_ERR
> >
> > which brings us to the code:
> > if (ret < 0)
> >         goto unlock_err;
> > ...
> > unlock_err:
> > ...
> > if (dio_data->data_space_reserved) {
> >         btrfs_free_reserved_data_space()
> > }
> >
> > so the execution continues...
> >
> > btrfs_free_reserved_data_space
> >   btrfs_qgroup_free_data
> >     __btrfs_qgroup_release_data
> >       qgroup_free_reserved_data
> >         btrfs_qgroup_free_refroot
> >
> > This will result in a underflow of the reservation once everything
> > outstanding gets released.
> 
> No, it won't.
> 
> For a COW write, before we failed to allocate the ordered extent, at
> alloc_ordered_extent(), we called btrfs_qgroup_release_data().
> That function will find all subranges in the inode's iotree marked
> with EXTENT_QGROUP_RESERVED, clear that bit from them and sum their
> lengths into @qgroup_rsv (local variable from alloc_ordered_extent()).
> 
> So calling qgroup_free_reserved_data() in an error path such as that
> one will do nothing because it can't find any more ranges in the
> inode's iotree marked with EXTENT_QGROUP_RESERVED.
> 
> So we leak reserved space... from the moment we called
> btrfs_qgroup_release_data(), at alloc_ordered_extent(), we transferred
> how we track the reserved space - which was intended to be in the
> ordered extent and then when the ordered extent completes a delayed
> data ref is created and when that delayed ref is ran we release the
> space with btrfs_qgroup_free_refroot(). But since we failed to
> allocate the ordered extent and the reserved space is no longer
> tracked in the inode's iotree, we fail to release qgroup space.
> 
> Actually patch 3 in the patchset updates the comments at
> alloc_ordered_extent() with those details to make it clear.
> 
> Hope it's more clear now what's going on and how qgroup tracks reserved space.
> 
> Thanks.
> 
> 
> 
> >
> > Furthermore, raw calls to free_refroot in cases where we have a reserved
> > changeset make me worried, because they will run afoul of races with
> > multiple threads touching the various bits. I don't see the bugs here,
> > but the reservation lifetime is really tricky so I wouldn't be surprised
> > if something like that was wrong too.
> >
> > As of the last time I looked at this, I think cow_file_range handles
> > this correctly as well. Looking really quickly now, it looks like maybe
> > submit_one_async_extent() might not do a qgroup free, but I'm not sure
> > where the corresponding reservation is coming from.
> >
> > I think if you have indeed found a different codepath that makes a data
> > reservation but doesn't release the qgroup part when allocating the
> > ordered extent fails, then the fastest path to a fix is to do that at
> > the same level as where it calls btrfs_check_data_free_space or (however
> > it gets the reservation), as is currently done by the main
> > ordered_extent allocation paths. With async_extent, we might need to
> > plumb through the reserved extent changeset through the async chunk to
> > do it perfectly...
> >
> > Thanks,
> > Boris
> >
> > >
> > > Fixes: 7dbeaad0af7d ("btrfs: change timing for qgroup reserved space for ordered extents to fix reserved space leak")
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  fs/btrfs/ordered-data.c | 12 +++++++++---
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> > > index ae49f87b27e8..e44d3dd17caf 100644
> > > --- a/fs/btrfs/ordered-data.c
> > > +++ b/fs/btrfs/ordered-data.c
> > > @@ -153,9 +153,10 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
> > >       struct btrfs_ordered_extent *entry;
> > >       int ret;
> > >       u64 qgroup_rsv = 0;
> > > +     const bool is_nocow = (flags &
> > > +            ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC)));
> > >
> > > -     if (flags &
> > > -         ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC))) {
> > > +     if (is_nocow) {
> > >               /* For nocow write, we can release the qgroup rsv right now */
> > >               ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes, &qgroup_rsv);
> > >               if (ret < 0)
> > > @@ -170,8 +171,13 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
> > >                       return ERR_PTR(ret);
> > >       }
> > >       entry = kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
> > > -     if (!entry)
> > > +     if (!entry) {
> > > +             if (!is_nocow)
> > > +                     btrfs_qgroup_free_refroot(inode->root->fs_info,
> > > +                                               btrfs_root_id(inode->root),
> > > +                                               qgroup_rsv, BTRFS_QGROUP_RSV_DATA);
> > >               return ERR_PTR(-ENOMEM);
> > > +     }
> > >
> > >       entry->file_offset = file_offset;
> > >       entry->num_bytes = num_bytes;
> > > --
> > > 2.47.2
> > >

