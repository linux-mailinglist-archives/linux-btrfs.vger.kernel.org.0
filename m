Return-Path: <linux-btrfs+bounces-14756-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37976ADDE84
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 00:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCC71898E67
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 22:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621DF29344F;
	Tue, 17 Jun 2025 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Rdz0OAhf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="httoXXSo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF2D169AE6
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 22:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750198241; cv=none; b=eHMamINMggGEwCKdLx/twhtTf1F9NsHYJbY88z1i5DEcR4lAIlR4GWIkHtP8cmQqYxlBd2u8l4oEOBfdw52lxNNpsZKzdw8iPIQF1Ly1CayqT481kGXIigYBTK3vQyndv7JYtzacgfPweh5eiawxM7QfKSyEnqbYlRIS+UKjKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750198241; c=relaxed/simple;
	bh=3TGT79pkGjQMfHfMan6DTAULI0I9y1ohYjJzeFceEB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8bGmln0bcRe53tdhf03NhRJ/yK49xznEvXAqpxwXxmXgl89v5QuxN9gebT+Vh0m5QjTcfFzWtd3+rl+nEQgWnThznqOC5/E9eEht5Zkizlh9mhTzzmHxPUSqwB7jV6iRr4CMml1wwjq3lgkHJRJ6hQRZNy3dV8Oe9qs1Nyh570=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Rdz0OAhf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=httoXXSo; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 42726114011E;
	Tue, 17 Jun 2025 18:10:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 17 Jun 2025 18:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1750198237;
	 x=1750284637; bh=4Oo8NUlX6jAaA2Yty9TYDJ5EgbuSYtnf+cToOV97lXo=; b=
	Rdz0OAhfHQLEx3jxf9rQP3ADP+2XuMzRPjmO0Qt74MeUCn+B5u1ne1igAJwUIsjb
	xjSWHR/94yoO+AU78JVaVqxYjKKxCGeIJosryROF9sQRvnYbv3SrD//ztpM85aLO
	IvLIJjjyDiAAIjwvvBBcE/bkLwZQ9nI8aI5LTHyMCzaJESLwAJcumqK9puwxD1mB
	tUw/5h/H0zPc6xHbjRtZlbilXsKkZgt9EvZFXEGwrB4BQ3SS2f+kPceHGaXwlvZD
	DE6/250EC4ZKauiy4IXJeUHDXc5Z+ez11EmxFDYznaMlNGj0+8IafEio7C3NJ7lF
	FA84r03IUV+rNrj7kGrY8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750198237; x=
	1750284637; bh=4Oo8NUlX6jAaA2Yty9TYDJ5EgbuSYtnf+cToOV97lXo=; b=h
	ttoXXSoz3UXzSKrjDv+j/xg9yYiz9qfJpCgqLYBasCagPaXNG+FDryzVCd9GQC86
	52EXf/tZG+8bZVsVGNXNsXLMXCtNtSsYwJosFdM1P2UIJTtTXU3ybbNzQUyH+8Gy
	JsIllN9tKALtUBBiCLPv9D+0b1Zv3/U0yhYqAgvxVpM2/XcLx9OQ4Gg5/MDiuDrP
	/GnPSgc0AncR1l943rt5M7H5BruPO66k/gAID6hcWqzg/rylyJd0gqIdNNfAzbTZ
	ViStu8gMZ+PpheGHG+tQlexrf6+TfgO6TgkyA7waClJuVlBpNfDRPtJXyQ3UcXyi
	TpnpnrveLpw271Mx9o4uA==
X-ME-Sender: <xms:3OdRaDnw95JxwQ_wn3y3lCFSclk8MLj5ShHHa__XgD4GIgMceu-Vjg>
    <xme:3OdRaG2a5n-WaJYm7Li4SiWQO1iNM90PnwOQJah4uQLIOSU_r20JRjWPXsyvDqF94
    OM8_Y3NVVzNe0AvSPg>
X-ME-Received: <xmr:3OdRaJoGyn2VN-DQbY3BQxntQlu3fXaynHjiuaqFMrM5RUV4gV5w7k7mg4El5pYpcDl7AKSXGjlnUCCPZQ-rV1Gj4jM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepudelhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdev
    gedtuedutdeitdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3OdRaLmXzvdFb9NQ0iGDkoLyNWohNeoAIrjvCG62UkHqKcP3qCAfZg>
    <xmx:3OdRaB2UFqh_F0dhVXpL9bu97ttNSQE-FBUXGsX_EnkMhQ-wC_wBIQ>
    <xmx:3OdRaKu6UQyPmh_90V49wvkDWHrkOxfuYO5AhCjRqg9frc4wSoFkEw>
    <xmx:3OdRaFWuw36GqMZhEe0JlOtxwUgG7Bj1CR-GjOZnwjFyc82RV7GTxQ>
    <xmx:3edRaADm9z09BZBTcHW39HmGAZbooRFHZkfBgm1-z4kpjACb0-upM4x6>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jun 2025 18:10:36 -0400 (EDT)
Date: Tue, 17 Jun 2025 15:12:15 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 16/16] btrfs: cache if we are using free space bitmaps
 for a block group
Message-ID: <20250617221215.GA2152829@zen.localdomain>
References: <cover.1750075579.git.fdmanana@suse.com>
 <b8dfd9adca4be0d65661e90e7c742b1c66ff4fe9.1750075579.git.fdmanana@suse.com>
 <20250617215239.GB2330659@zen.localdomain>
 <CAL3q7H4RGxg7D8hvSC72JnHEKssvdYBanEfxT8fnFX=L26pE+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4RGxg7D8hvSC72JnHEKssvdYBanEfxT8fnFX=L26pE+Q@mail.gmail.com>

On Tue, Jun 17, 2025 at 10:59:04PM +0100, Filipe Manana wrote:
> On Tue, Jun 17, 2025 at 10:51 PM Boris Burkov <boris@bur.io> wrote:
> >
> > On Tue, Jun 17, 2025 at 05:13:11PM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Every time we add free space to the free space tree or we remove free
> > > space from the free space tree, we do a lookup for the block group's free
> > > space info item in the free space tree. This takes time, navigating the
> > > btree and we may block either on IO when reading extent buffers from disk
> > > or on extent buffer lock contention due to concurrency.
> > >
> > > Instead of doing this lookup everytime, cache the result in the block
> > > structure and use it after the first lookup. This adds two boolean members
> > > to the block group structure but doesn't increase the structure's size.
> > >
> > > The following script that runs fs_mark was used to measure the time spent
> > > on run_delayed_tree_ref(), since down that call chain we have calls to
> > > add and remove free space to/from the free space tree (calls to
> > > btrfs_add_to_free_space_tree() and btrfs_remove_from_free_space_tree()):
> > >
> > >   $ cat test.sh
> > >   #!/bin/bash
> > >
> > >   DEV=/dev/nullb0
> > >   MNT=/mnt
> > >   FILES=100000
> > >   THREADS=$(nproc --all)
> > >
> > >   echo "performance" | \
> > >       tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> > >
> > >   umount $DEV &> /dev/null
> > >   mkfs.btrfs -f $DEV
> > >   mount -o ssd $DEV $MNT
> > >
> > >   OPTS="-S 0 -L 5 -n $FILES -s 0 -t $THREADS -k"
> > >   for ((i = 1; i <= $THREADS; i++)); do
> > >       OPTS="$OPTS -d $MNT/d$i"
> > >   done
> > >
> > >   fs_mark $OPTS
> > >
> > >   umount $MNT
> > >
> > > This is a heavy metadata test as it's exercising only file creation, so a
> > > lot of allocations of metadata extents, creating delayed refs for adding
> > > new metadata extents and dropping existing ones due to COW. The results
> > > of the times it took to execute run_delayed_tree_ref(), in nanoseconds,
> > > are the following.
> > >
> > > Before this change:
> > >
> > >   Range: 1868.000 - 6482857.000; Mean: 10231.430; Median: 7005.000; Stddev: 27993.173
> > >   Percentiles:  90th: 13342.000; 95th: 23279.000; 99th: 82448.000
> > >   1868.000 - 4222.038: 270696 ############
> > >   4222.038 - 9541.029: 1201327 #####################################################
> > >   9541.029 - 21559.383: 385436 #################
> > >   21559.383 - 48715.063: 64942 ###
> > >   48715.063 - 110073.800: 31454 #
> > >   110073.800 - 248714.944:  8218 |
> > >   248714.944 - 561977.042:  1030 |
> > >   561977.042 - 1269798.254:   295 |
> > >   1269798.254 - 2869132.711:   116 |
> > >   2869132.711 - 6482857.000:    28 |
> > >
> > > After this change:
> > >
> > >   Range: 1554.000 - 4557014.000; Mean: 9168.164; Median: 6391.000; Stddev: 21467.060
> > >   Percentiles:  90th: 12478.000; 95th: 20964.000; 99th: 72234.000
> > >   1554.000 - 3453.820: 219004 ############
> > >   3453.820 - 7674.743: 980645 #####################################################
> > >   7674.743 - 17052.574: 552486 ##############################
> > >   17052.574 - 37887.762: 68558 ####
> > >   37887.762 - 84178.322: 31557 ##
> > >   84178.322 - 187024.331: 12102 #
> > >   187024.331 - 415522.355:  1364 |
> > >   415522.355 - 923187.626:   256 |
> > >   923187.626 - 2051092.468:   125 |
> > >   2051092.468 - 4557014.000:    21 |
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  fs/btrfs/block-group.h     |  5 +++++
> > >  fs/btrfs/free-space-tree.c | 12 +++++++++++-
> > >  2 files changed, 16 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> > > index aa176cc9a324..8a8f1fff7e5b 100644
> > > --- a/fs/btrfs/block-group.h
> > > +++ b/fs/btrfs/block-group.h
> > > @@ -246,6 +246,11 @@ struct btrfs_block_group {
> > >       /* Lock for free space tree operations. */
> > >       struct mutex free_space_lock;
> > >
> > > +     /* Protected by @free_space_lock. */
> > > +     bool use_free_space_bitmaps;
> > > +     /* Protected by @free_space_lock. */
> > > +     bool use_free_space_bitmaps_cached;
> > > +
> > >       /*
> > >        * Number of extents in this block group used for swap files.
> > >        * All accesses protected by the spinlock 'lock'.
> > > diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> > > index 3c8bb95fa044..1bd07e91fd5a 100644
> > > --- a/fs/btrfs/free-space-tree.c
> > > +++ b/fs/btrfs/free-space-tree.c
> > > @@ -287,6 +287,8 @@ int btrfs_convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
> > >       leaf = path->nodes[0];
> > >       flags = btrfs_free_space_flags(leaf, info);
> > >       flags |= BTRFS_FREE_SPACE_USING_BITMAPS;
> > > +     block_group->use_free_space_bitmaps = true;
> > > +     block_group->use_free_space_bitmaps_cached = true;
> > >       btrfs_set_free_space_flags(leaf, info, flags);
> > >       expected_extent_count = btrfs_free_space_extent_count(leaf, info);
> > >       btrfs_release_path(path);
> > > @@ -434,6 +436,8 @@ int btrfs_convert_free_space_to_extents(struct btrfs_trans_handle *trans,
> > >       leaf = path->nodes[0];
> > >       flags = btrfs_free_space_flags(leaf, info);
> > >       flags &= ~BTRFS_FREE_SPACE_USING_BITMAPS;
> > > +     block_group->use_free_space_bitmaps = false;
> > > +     block_group->use_free_space_bitmaps_cached = true;
> > >       btrfs_set_free_space_flags(leaf, info, flags);
> > >       expected_extent_count = btrfs_free_space_extent_count(leaf, info);
> > >       btrfs_release_path(path);
> > > @@ -796,13 +800,19 @@ static int use_bitmaps(struct btrfs_block_group *bg, struct btrfs_path *path)
> > >       struct btrfs_free_space_info *info;
> > >       u32 flags;
> > >
> > > +     if (bg->use_free_space_bitmaps_cached)
> > > +             return bg->use_free_space_bitmaps;
> > > +
> >
> > I'm a little worried about what happens if the reader observes the
> > writes out of order.
> >
> > i.e., say T1 is calling btrfs_convert_free_space_to_bitmaps() and T2 is
> > calling use_bitmaps(). Then if T2 observes use_free_space_bitmaps_cached
> > set to true but not use_free_space_bitmaps set to true, it will get the
> > wrong value.
> >
> > Or is there some higher level locking that I missed protecting us?
> 
> Yes, there is. It's the block group's free_space_lock mutex, taken at
> any entry point that modifies the free space tree.
> 
> Thanks.
> 

Ah, yup, looks good, thanks.

You can add
Reviewed-by: Boris Burkov <boris@bur.io>

to the whole series.

> >
> > Thanks,
> > Boris
> >
> > >       info = btrfs_search_free_space_info(NULL, bg, path, 0);
> > >       if (IS_ERR(info))
> > >               return PTR_ERR(info);
> > >       flags = btrfs_free_space_flags(path->nodes[0], info);
> > >       btrfs_release_path(path);
> > >
> > > -     return (flags & BTRFS_FREE_SPACE_USING_BITMAPS) ? 1 : 0;
> > > +     bg->use_free_space_bitmaps = (flags & BTRFS_FREE_SPACE_USING_BITMAPS);
> > > +     bg->use_free_space_bitmaps_cached = true;
> > > +
> > > +     return bg->use_free_space_bitmaps;
> > >  }
> > >
> > >  EXPORT_FOR_TESTS
> > > --
> > > 2.47.2
> > >

