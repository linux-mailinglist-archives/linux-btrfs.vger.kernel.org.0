Return-Path: <linux-btrfs+bounces-13838-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE318AAFFEB
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 18:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3908D179F2A
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 16:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBC927EC99;
	Thu,  8 May 2025 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="JLCiqZV7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XPOXXSZS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6D627CCEB
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746720420; cv=none; b=Ybu5X4To3aBJw20E8q7y4uNMrwjjBexaPnEaaGYdp7VpGgPrWf1peg++kZdx5K1o3FzFkdosZHIk5lHuBuEfz9vKGBFBzSQ5CloHDkncLmaELO+eY1jxcEb7L+6RGJYpByf/U4AyA+3+df2GbEpaP3usSdJzRdoquEaeAkU5bN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746720420; c=relaxed/simple;
	bh=35AZ9VreaGGer84MTi4QR8eWPUWENMUSK0Cr4sBG8ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SavCPJD+lcXH1WLpPYwq5Re1/xcj3tbfcNwLz+bkZh+0gkkJwdKJINJE116O9RxjF+6JWrT8ML0lrsu2gn3oMRKBQb0nilj/9FpxqnWimaxql7On1A7mmXUKTL5g1cx9XgTQS/X1Hy2ac/RVCTfkvfLtJ67vC+YMEbl/1/U55zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=JLCiqZV7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XPOXXSZS; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id C365A13801B7;
	Thu,  8 May 2025 12:06:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 08 May 2025 12:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1746720417;
	 x=1746806817; bh=b0mCyVEen3xehmCR2RsNM3Isc7M9Nj0x5PPjrKyK16s=; b=
	JLCiqZV7dUmvZNhen4ULZFLn7kzqfacEN3o7LA8xx/v6o+5iseodD5NQ+DLPsg5J
	DvvRWTLg8GHtl4bPE743+16eH5BfsxYLfLzUK7u5F3TUcgLo8LVV8TJe9BdhFfRD
	jHD8JYyNuA4F3jaoBhmZxx0xBNtyFifEW3Z7y5pLVxA6BwwgfSx96osE8MK4fbqD
	ihpCWdAehsO+0+p8AeCMnNyibc/W2+FFdlXx5nN6Npfx9pgazXodZo3fVLJI75/v
	wHy08fvniIOc2Kzo3Beyhxl+pHZJf9rxz/abPcLrsps5K5dwg17yFt/AvokE/x3f
	44BE1hVeO1ysmt28B3VXbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746720417; x=
	1746806817; bh=b0mCyVEen3xehmCR2RsNM3Isc7M9Nj0x5PPjrKyK16s=; b=X
	POXXSZSZ0YpNwM2nyqTyVqBIP5ygTcPbMvdExlozb47Yba9vvr8uzxlZsRH4JXRj
	iigqM76F7DRfJ1T+wE8YWFmySW2hgXLvGllTOQJQPBqYgPLeJ9/y3DHtTrhGWJfQ
	G1u0v8XfkQbymYeSyJ+b6+KulH3z5kZz376AXoce7PMrhomjoA/TcZscEIkpMy8A
	kiv2j4xKnKpu/9vu+KNV+hiFTcw2ncm38SrXj0iVjSNhbysH4i1qONa0Vl8Cw+Wj
	WoHxceAWWKB93jo3yYjiXw8PRQC73AKy5y0OD+p3TMI1tn74ClzrYFSuyGWE2Yvd
	YEvde6SQimznsZu78b4FA==
X-ME-Sender: <xms:odYcaDkIok9V2jy8-NT1nHOjn6qxVeIaydFkLE9RwPbzNEcP0lzAWw>
    <xme:odYcaG3S4sWBQcL0N2b4c-laPbXnHRcrgS_jd5oBQLn_OjbT6q7TU9YW8rem8nd3r
    bE_k63bFHEozYyoQ2E>
X-ME-Received: <xmr:odYcaJrefYQsaTJ5qfghHR7twn7tje_8oRaQYlel_8QlGCPGNDJY02QiQTrpTOLMI5TM5CPPkGA3RV_iScMupkWSREg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledtudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioh
    eqnecuggftrfgrthhtvghrnhepudelhfdthfetuddvtefhfedtiedtteehvddtkedvledt
    vdevgedtuedutdeitdeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidq
    sghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:odYcaLmPcYZ8dcqs0tqUoNgr2FRGtmBgA-_J9qTRq5SKMQt9_fowTg>
    <xmx:odYcaB0sSm4pPH_kCqz8gmvS7TFOvyo2Hm2NZ3OCkiY6YuRqXALtYQ>
    <xmx:odYcaKty2erLfA8FIXqNj9tgrBm8mj5v1SZOk771_2q5yp_6bREEHw>
    <xmx:odYcaFUG3c0VFmkfMjJgofXoPW1kjRfPlTnh6eK7Poruk3YacG1qPQ>
    <xmx:odYcaOI2l_wizuLfaXIoRmOECaVYiwQODRfSacI1AYk_mBFJCEtCkq8s>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 12:06:57 -0400 (EDT)
Date: Thu, 8 May 2025 09:07:38 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/5] btrfs: fix qgroup reservation leak on failure to
 allocate ordered extent
Message-ID: <20250508160738.GB3935696@zen.localdomain>
References: <cover.1746638347.git.fdmanana@suse.com>
 <b2b4a73fb7ef395f131884cd5c903cbf92517e6f.1746638347.git.fdmanana@suse.com>
 <20250507223347.GB332956@zen.localdomain>
 <ccacb32f-e345-49c7-9c6b-8bdc72c69a7f@suse.com>
 <CAL3q7H4YWzsCTsSC=oup6_typt_PdNVAdAuK1RVhuH1nEto-eQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4YWzsCTsSC=oup6_typt_PdNVAdAuK1RVhuH1nEto-eQ@mail.gmail.com>

On Thu, May 08, 2025 at 02:43:36PM +0100, Filipe Manana wrote:
> On Thu, May 8, 2025 at 12:12 AM Qu Wenruo <wqu@suse.com> wrote:
> >
> >
> >
> > 在 2025/5/8 08:03, Boris Burkov 写道:
> > > On Wed, May 07, 2025 at 06:23:13PM +0100, fdmanana@kernel.org wrote:
> > >> From: Filipe Manana <fdmanana@suse.com>
> > >>
> > >> If we fail to allocate an ordered extent for a COW write we end up leaking
> > >> a qgroup data reservation since we called btrfs_qgroup_release_data() but
> > >> we didn't call btrfs_qgroup_free_refroot() (which would happen when
> > >> running the respective data delayed ref created by ordered extent
> > >> completion or when finishing the ordered extent in case an error happened).
> > >>
> > >> So make sure we call btrfs_qgroup_free_refroot() if we fail to allocate an
> > >> ordered extent for a COW write.
> > >
> > > I haven't tried it myself yet, but I believe that this patch will double
> > > free reservation from the qgroup when this case occurs.
> > >
> > > Can you share the context where you saw this bug? Have you run fstests
> > > with qgroups or squotas enabled? I think this should show pretty quickly
> > > in generic/475 with qgroups on.
> > >
> > > Consider, for example, the following execution of the dio case:
> > >
> > > btrfs_dio_iomap_begin
> > >    btrfs_check_data_free_space // reserves the data into `reserved`, sets dio_data->data_space_reserved
> > >    btrfs_get_blocks_direct_write
> > >      btrfs_create_dio_extent
> > >        btrfs_alloc_ordered_extent
> > >          alloc_ordered_extent // fails and frees refroot, reserved is "wrong" now.
> > >        // error propagates up
> > >      // error propagates up via PTR_ERR
> > >
> > > which brings us to the code:
> > > if (ret < 0)
> > >          goto unlock_err;
> > > ...
> > > unlock_err:
> > > ...
> > > if (dio_data->data_space_reserved) {
> > >          btrfs_free_reserved_data_space()
> > > }
> > >
> > > so the execution continues...
> > >
> > > btrfs_free_reserved_data_space
> > >    btrfs_qgroup_free_data
> > >      __btrfs_qgroup_release_data
> > >        qgroup_free_reserved_data
> > >          btrfs_qgroup_free_refroot
> > >
> > > This will result in a underflow of the reservation once everything
> > > outstanding gets released.
> >
> > That should still be safe.
> >
> > Firstly at alloc_ordered_extent() we released the qgroup space already,
> > thus there will be no EXTENT_QGROUP_RESERVED range in extent-io tree
> > anymore.
> >
> > Then at the final cleanup, qgroup_free_reserved_data_space() will
> > release/free nothing, because the extent-io tree no longer has the
> > corresponding range with EXTENT_QGROUP_RESERVED.
> >
> > This is the core design of qgroup data reserved space, which allows us
> > to call btrfs_release/free_data() twice without double accounting.
> >
> > >
> > > Furthermore, raw calls to free_refroot in cases where we have a reserved
> > > changeset make me worried, because they will run afoul of races with
> > > multiple threads touching the various bits. I don't see the bugs here,
> > > but the reservation lifetime is really tricky so I wouldn't be surprised
> > > if something like that was wrong too.
> >
> > This free_refroot() is the common practice here. The extent-io tree
> > based accounting can only cover the reserved space before ordered extent
> > is allocated.
> >
> > Then the reserved space is "transferred" to ordered extent, and
> > eventually go to the new data extent, and finally freed at
> > btrfs_qgroup_account_extents(), which also goes the free_refroot() way.
> >
> > >
> > > As of the last time I looked at this, I think cow_file_range handles
> > > this correctly as well. Looking really quickly now, it looks like maybe
> > > submit_one_async_extent() might not do a qgroup free, but I'm not sure
> > > where the corresponding reservation is coming from.
> > >
> > > I think if you have indeed found a different codepath that makes a data
> > > reservation but doesn't release the qgroup part when allocating the
> > > ordered extent fails, then the fastest path to a fix is to do that at
> > > the same level as where it calls btrfs_check_data_free_space or (however
> > > it gets the reservation), as is currently done by the main
> > > ordered_extent allocation paths. With async_extent, we might need to
> > > plumb through the reserved extent changeset through the async chunk to
> > > do it perfectly...
> >
> > I agree with you that, the extent io tree based double freeing
> > prevention should only be the last safe net, not something we should
> > abuse when possible.
> >
> > But I can't find a better solution, mostly due to the fact that after
> > the btrfs_qgroup_release_data() call, the qgroup reserved space is
> > already released, and we have no way to undo that...
> >
> > Maybe we can delayed the qgroup release/free calls until the ordered
> > extent @entry is allocated?
> 
> At some point I considered allocating first the ordered extent and
> then doing the qgroup free/release calls, and that would fix the leak
> too.
> At the moment it seemed more clear to me the way I did, but if
> everyone prefers that other way I'm fine with it and will change it.

I personally prefer not adding more naked btrfs_qgroup_free_refroots and
think it's better to move the release call. Either way, please feel free
to add:

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Thanks.
> 
> 
> >
> > Thanks,
> > Qu
> >
> >
> > >
> > > Thanks,
> > > Boris
> > >
> > >>
> > >> Fixes: 7dbeaad0af7d ("btrfs: change timing for qgroup reserved space for ordered extents to fix reserved space leak")
> > >> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > >> ---
> > >>   fs/btrfs/ordered-data.c | 12 +++++++++---
> > >>   1 file changed, 9 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> > >> index ae49f87b27e8..e44d3dd17caf 100644
> > >> --- a/fs/btrfs/ordered-data.c
> > >> +++ b/fs/btrfs/ordered-data.c
> > >> @@ -153,9 +153,10 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
> > >>      struct btrfs_ordered_extent *entry;
> > >>      int ret;
> > >>      u64 qgroup_rsv = 0;
> > >> +    const bool is_nocow = (flags &
> > >> +           ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC)));
> > >>
> > >> -    if (flags &
> > >> -        ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC))) {
> > >> +    if (is_nocow) {
> > >>              /* For nocow write, we can release the qgroup rsv right now */
> > >>              ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes, &qgroup_rsv);
> > >>              if (ret < 0)
> > >> @@ -170,8 +171,13 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
> > >>                      return ERR_PTR(ret);
> > >>      }
> > >>      entry = kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
> > >> -    if (!entry)
> > >> +    if (!entry) {
> > >> +            if (!is_nocow)
> > >> +                    btrfs_qgroup_free_refroot(inode->root->fs_info,
> > >> +                                              btrfs_root_id(inode->root),
> > >> +                                              qgroup_rsv, BTRFS_QGROUP_RSV_DATA);
> > >>              return ERR_PTR(-ENOMEM);
> > >> +    }
> > >>
> > >>      entry->file_offset = file_offset;
> > >>      entry->num_bytes = num_bytes;
> > >> --
> > >> 2.47.2
> > >>
> > >
> >

