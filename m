Return-Path: <linux-btrfs+bounces-18077-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB32BF2C95
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 19:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDBB18A7EA5
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 17:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCBE32B99E;
	Mon, 20 Oct 2025 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="f1LexTp2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iMIWmgiS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAF429D267
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982330; cv=none; b=CB2ynjpXPlQk7UEomd1eCyutfhPlHa/q3G+1G6hplSU3RDfDgvPw1la+X/DoEdWCEs6z8eITM2KEpwuwHywW75V3JoJVr0ggum4+iG+vVmXWg+XCdUbJadoG/MSR/K9sMwGKRYHO2Sq2ad66xfRrtXhtv9un05npzpNoO7KxrLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982330; c=relaxed/simple;
	bh=JTQWtyY9OMZobwdIAQer7Nzuas9D5qjxPCaKTWBggm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmAZXFuLerM5lTdocMGwS24HGxumGNmpRlQbxEg+QtscXI5TWOie+zpE500dQNb0uVSTRQ04v8lN7P9Q0IrohHqR8Rp81SY7Ut0hHV4CwHeYVStotkvgbaMH8NGEiRp1/XxyqK+G0Nhi5qRdkv/BHNGQNUTsFJNJTRVib7BGTXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=f1LexTp2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iMIWmgiS; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 6E07B1D0012C;
	Mon, 20 Oct 2025 13:45:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 20 Oct 2025 13:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1760982326; x=1761068726; bh=QW5w/uWDxl
	7dO5R8VIKJX0VrZF+C4Kd28iv0O6ZdS0U=; b=f1LexTp2ryNfOxdPrSUXbnkbTS
	HPs424YJGAD7AvbnKht2Tj3FanENYWdeOh1wxIRrXeM9P26Bu6W8iNUwSTaJnZ/5
	Yff6WH5LOqi/1fZV0rSBs4Jq5PtqMgHBhxhBWFrmMuxO+vrsIAiGZTQNp2VBsRJ5
	IO9bbybsn3W9EidpBQWnEY5e2PnpXuMKAbQOIrAMSd9JaixU1Tc0fh8K+7YW8SF2
	GiVp5sPCXo7uN8+tviZKxGYPyL1EKTcEnwJTN/XrG8KcakYwl3V7EcoIMDARDphC
	LDfE6nw90lTH1zl/79p4tNjap6SFPSTXSZeTdUVW6f2Uz2lHBT6EoK8FNg+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760982326; x=1761068726; bh=QW5w/uWDxl7dO5R8VIKJX0VrZF+C4Kd28iv
	0O6ZdS0U=; b=iMIWmgiSkPALOfJeO1XSdfoeIje8Ka5rupkJEkVkszTlRx0tV4c
	zfECJ7lRzkzD864yI2wKtp2zjxIG+BIbZNClV4KaMb/vhZ1fWutPmRinbNj6Do+a
	KDBo9Hhp8lgmJTAIOiOBJAyROnooq9m+YGyfPOINzPXCnvd0rMB0iMSsRxwimDt8
	x8JcRFF++U0zmIGye0J1gH0ZngRRhJ3xwhFSiW+CrN4Qdl/l/Auf0x1HfHb9LilH
	lAKX7WfQKNVnKYlb5hW4GZ7WrUM1pWESajMHEPqQttlNr9MyIR6XuJpgHEbV1tq5
	e+qsukCYn7nprjGLLVtbL7uvMwX6ET4LBpQ==
X-ME-Sender: <xms:NnX2aMtV-urqmyY2sStWZg-6wbVuVusfaPFYQr-EvWDWVlXx2e2JzQ>
    <xme:NnX2aPeIYu-eU99criiuk7bS2oST-N6gJ9PBFlyFRSYk9_gI6HCLkAstSl53pw9XS
    cmpVZpK0BP7jo8HuyBXUCmxL6GN4OQTYBO-Ya1TxHbmfbM2ir292H8>
X-ME-Received: <xmr:NnX2aFYx_x0faMfdzQn-oEi4gDp8CjSbQ1AHayVFsavNfiIOlHUesTOpeCyIrFD4j3nIt91FyAGGa9r4XKRYA7oV3gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NnX2aKWOHUPeuojj7BIzD56mjLNPEkF5OJRcE0LKsCiaXWCIqv4ZIw>
    <xmx:NnX2aPh3oKGd7LNiQS7X0Wrqsq8UIowDulUUYcRk0O9i92mP0yZeYQ>
    <xmx:NnX2aAXQU0Mrxxi9V-3L1AQ8Ov3xLc88tgGlYiORm28__qKHJGkK-Q>
    <xmx:NnX2aOPCxO0HCdxeX8UmP6eWtnt1beTxsjm5fbIpHWtYr-jbaxx71Q>
    <xmx:NnX2aIBdhNtFlm86ie7FRLuiDSPzzeNxxBoIOKL_-TgCzplCHIdPU5Vt>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 13:45:25 -0400 (EDT)
Date: Mon, 20 Oct 2025 10:44:56 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 08/17] btrfs: redirect I/O for remapped block groups
Message-ID: <20251020174456.GC696792@zen.localdomain>
References: <20251009112814.13942-1-mark@harmstone.com>
 <20251009112814.13942-9-mark@harmstone.com>
 <20251015042136.GG1702774@zen.localdomain>
 <f74da96e-7b50-48f2-b9ad-a2aefc8ed9aa@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f74da96e-7b50-48f2-b9ad-a2aefc8ed9aa@harmstone.com>

On Mon, Oct 20, 2025 at 03:31:39PM +0100, Mark Harmstone wrote:
> On 15/10/2025 5.21 am, Boris Burkov wrote:
> > On Thu, Oct 09, 2025 at 12:28:03PM +0100, Mark Harmstone wrote:
> > > Change btrfs_map_block() so that if the block group has the REMAPPED
> > > flag set, we call btrfs_translate_remap() to obtain a new address.
> > > 
> > > btrfs_translate_remap() searches the remap tree for a range
> > > corresponding to the logical address passed to btrfs_map_block(). If it
> > > is within an identity remap, this part of the block group hasn't yet
> > > been relocated, and so we use the existing address.
> > > 
> > > If it is within an actual remap, we subtract the start of the remap
> > > range and add the address of its destination, contained in the item's
> > > payload.
> > > 
> > > Signed-off-by: Mark Harmstone <mark@harmstone.com>
> > > ---
> > >   fs/btrfs/relocation.c | 59 +++++++++++++++++++++++++++++++++++++++++++
> > >   fs/btrfs/relocation.h |  2 ++
> > >   fs/btrfs/volumes.c    | 31 +++++++++++++++++++++++
> > >   3 files changed, 92 insertions(+)
> > > 
> > > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > > index 748290758459..4f5d3aaf0f65 100644
> > > --- a/fs/btrfs/relocation.c
> > > +++ b/fs/btrfs/relocation.c
> > > @@ -3870,6 +3870,65 @@ static const char *stage_to_string(enum reloc_stage stage)
> > >   	return "unknown";
> > >   }
> > > +int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
> > > +			  u64 *length, bool nolock)
> > > +{
> > > +	int ret;
> > > +	struct btrfs_key key, found_key;
> > > +	struct extent_buffer *leaf;
> > > +	struct btrfs_remap *remap;
> > > +	BTRFS_PATH_AUTO_FREE(path);
> > > +
> > > +	path = btrfs_alloc_path();
> > > +	if (!path)
> > > +		return -ENOMEM;
> > > +
> > > +	if (nolock) {
> > > +		path->search_commit_root = 1;
> > > +		path->skip_locking = 1;
> > > +	}
> > > +
> > > +	key.objectid = *logical;
> > > +	key.type = (u8)-1;
> > > +	key.offset = (u64)-1;
> > > +
> > > +	ret = btrfs_search_slot(NULL, fs_info->remap_root, &key, path,
> > > +				0, 0);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	leaf = path->nodes[0];
> > > +
> > > +	if (path->slots[0] == 0)
> > > +		return -ENOENT;
> > > +
> > > +	path->slots[0]--;
> > > +
> > > +	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> > > +
> > > +	if (found_key.type != BTRFS_REMAP_KEY &&
> > > +	    found_key.type != BTRFS_IDENTITY_REMAP_KEY) {
> > > +		return -ENOENT;
> > > +	}
> > > +
> > > +	if (found_key.objectid > *logical ||
> > > +	    found_key.objectid + found_key.offset <= *logical) {
> > > +		return -ENOENT;
> > > +	}
> > > +
> > > +	if (*logical + *length > found_key.objectid + found_key.offset)
> > > +		*length = found_key.objectid + found_key.offset - *logical;
> > > +
> > > +	if (found_key.type == BTRFS_IDENTITY_REMAP_KEY)
> > > +		return 0;
> > > +
> > > +	remap = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_remap);
> > > +
> > > +	*logical += btrfs_remap_address(leaf, remap) - found_key.objectid;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   /*
> > >    * function to relocate all extents in a block group.
> > >    */
> > > diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
> > > index 5c36b3f84b57..a653c42a25a3 100644
> > > --- a/fs/btrfs/relocation.h
> > > +++ b/fs/btrfs/relocation.h
> > > @@ -31,5 +31,7 @@ int btrfs_should_cancel_balance(const struct btrfs_fs_info *fs_info);
> > >   struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info, u64 bytenr);
> > >   bool btrfs_should_ignore_reloc_root(const struct btrfs_root *root);
> > >   u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info);
> > > +int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
> > > +			  u64 *length, bool nolock);
> > >   #endif
> > > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > > index 0abe02a7072f..f2d1203778aa 100644
> > > --- a/fs/btrfs/volumes.c
> > > +++ b/fs/btrfs/volumes.c
> > > @@ -6635,6 +6635,37 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
> > >   	if (IS_ERR(map))
> > >   		return PTR_ERR(map);
> > > +	if (map->type & BTRFS_BLOCK_GROUP_REMAPPED) {
> > > +		u64 new_logical = logical;
> > > +		bool nolock = !(map->type & BTRFS_BLOCK_GROUP_DATA);
> > 
> > Why not data?
> 
> Because I thought we'd maxed out our lockdep classes so this was the only way to
> prevent lockdep from complaining about metadata reads - not yet knowing about
> the btrfs_lockdep_keysets array.
> 
> I think I'm going to remove the search_commit_root stuff from this patchset, and
> leave it for a future optimization. As you know it's full of gotchas.
> 
> > > +
> > > +		/*
> > > +		 * We use search_commit_root in btrfs_translate_remap for
> > > +		 * metadata blocks, to avoid lockdep complaining about
> > > +		 * recursive locking.
> > > +		 * If we get -ENOENT this means this is a BG that has just had
> > > +		 * its REMAPPED flag set, and so nothing has yet been actually
> > > +		 * remapped.
> > > +		 */
> > 
> > I'm actually kind of worried about this now. What is preventing the
> > following racy interleaving:
> > 
> >        T1                                         T2
> >                                          start_block_group_remapping() // in TXN-K set REMAPPED
> > btrfs_map_block()
> >    btrfs_translate_remap()
> >      ENOENT // searched in commit root
> >                                          do_remap_tree_reloc() // in TXN-K do all remaps
> >                                          // fully remapped, removed, discarded
> >                                          // TXN-K committed
> >    // not remapped! but the original chunk map is gone gone
> >    num_copies = ...
> 
> The bits on the right will be separate transactions, I thought that would save
> us - does it not? I'm guessing this means that search_commit_root means to
> search the last transaction that was flushed to disk, rather than the last
> in-memory transaction.
> 
> Yes, I'm definitely saving this bit until later.
> 

I think that's a good idea.

> > > +		ret = btrfs_translate_remap(fs_info, &new_logical, length,
> > > +					    nolock);
> > > +		if (ret && (!nolock || ret != -ENOENT))
> > > +			return ret;
> > > +
> > > +		if (ret != -ENOENT && new_logical != logical) {
> > > +			btrfs_free_chunk_map(map);
> > > +
> > > +			map = btrfs_get_chunk_map(fs_info, new_logical,
> > > +						  *length);
> > > +			if (IS_ERR(map))
> > > +				return PTR_ERR(map);
> > > +
> > > +			logical = new_logical;
> > > +		}
> > > +
> > > +		ret = 0;
> > > +	}
> > > +
> > >   	num_copies = btrfs_chunk_map_num_copies(map);
> > >   	if (io_geom.mirror_num > num_copies)
> > >   		return -EINVAL;
> > > -- 
> > > 2.49.1
> > > 
> 

