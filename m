Return-Path: <linux-btrfs+bounces-7442-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8F795D1B0
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 17:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4EA1F2689A
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 15:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0001898F9;
	Fri, 23 Aug 2024 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Inve0ZB6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3516A1898EB
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2024 15:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427515; cv=none; b=rZqPO4gPD5JkviZztztcKxePsNxyXhiDoS7j7ikpsx3+pDjqjNX87fmhpihOzmaae/Jaa2pPNule1tL8qJB3DrcmoJWVY7W6ZPC+KSJNPGbfMMXPQUAAOWIBNwQTBDKxLTwkpEwMsByFg2ejmhfYNxWhhLC6AWII3T2pzAetxng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427515; c=relaxed/simple;
	bh=6gB9w4RuJL7fJgOzsbgyy3mm83GDLzfkYyx3mZJTw5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA/GL15KVF+lvuJO+IwMYiziCnGrY0h/tzgwgEoiae4u+CjTnOikAObx5Xs/SZ8qgiDRliqzC/IcEx/pY5tUi/t8UToYWpC0Jvpu34UJd1CZkjIce19h1LSEsdqci+nNJrO9iHOq/DqwbrzKVghbRNIF7aU1T4uSOhNclyr3h5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Inve0ZB6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=rKHpb8BNe6VsPtuD5PfIXPoMq93cxgO1KKnMxDRYLdw=; b=Inve0ZB6WZIggq/RT/UwRCIfFx
	alQy6i2jwb4uDwqP2WL+C2hE2wDVrSDmr/ZF8WotOvKCyr5q18ZjeNZq44nm9jTxfmuDGjxcQhUje
	OPV3ZKW9Wv3TAokPbfdq1QSQE1oEUp3fmY4dCkAXk59KcdNvckBUHybWBBzq69QXnoM2fVoYtTEF2
	G8V6Rs0Y7qeR96SDX4HTQhN8iYknX/L94aOf8eDcbDWxYk5f0jnX6XSmDs8UeYzDHVgMcXMMXnML/
	Sw2u9hNiCyIIfzTdR3oNHx/kr14OnEisaIpD2jZivHD2XvNIXuDLM1BQRU3oYC/FDDZ567XsO8uTq
	RMcphSvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shWMu-0000000BsOY-0Yml;
	Fri, 23 Aug 2024 15:38:28 +0000
Date: Fri, 23 Aug 2024 16:38:27 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Li Zetao <lizetao1@huawei.com>, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, terrelln@fb.com, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 02/14] btrfs: convert get_next_extent_buffer() to take a
 folio
Message-ID: <Zsis82IKSAq6Mgms@casper.infradead.org>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
 <20240822013714.3278193-3-lizetao1@huawei.com>
 <Zsaq_QkyQIhGsvTj@casper.infradead.org>
 <0f643b0f-f1c2-48b7-99d5-809b8b7f0aac@gmx.com>
 <ZscqGAMm1tofHSSG@casper.infradead.org>
 <38247c40-604b-443a-a600-0876b596a284@gmx.com>
 <7a04ac3b-e655-4a80-89dc-19962db50f05@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a04ac3b-e655-4a80-89dc-19962db50f05@gmx.com>

On Fri, Aug 23, 2024 at 11:43:41AM +0930, Qu Wenruo wrote:
> 在 2024/8/23 07:55, Qu Wenruo 写道:
> > 在 2024/8/22 21:37, Matthew Wilcox 写道:
> > > On Thu, Aug 22, 2024 at 08:28:09PM +0930, Qu Wenruo wrote:
> > > > But what will happen if some writes happened to that larger folio?
> > > > Do MM layer detects that and split the folios? Or the fs has to go the
> > > > subpage routine (with an extra structure recording all the subpage flags
> > > > bitmap)?
> > > 
> > > Entirely up to the filesystem.  It would help if btrfs used the same
> > > terminology as the rest of the filesystems instead of inventing its own
> > > "subpage" thing.  As far as I can tell, "subpage" means "fs block size",
> > > but maybe it has a different meaning that I haven't ascertained.
> > 
> > Then tell me the correct terminology to describe fs block size smaller
> > than page size in the first place.
> > 
> > "fs block size" is not good enough, we want a terminology to describe
> > "fs block size" smaller than page size.

Oh dear.  btrfs really has corrupted your brain.  Here's the terminology
used in the rest of Linux:

SECTOR_SIZE.  Fixed at 512 bytes.  This is the unit used to communicate
with the block layer.  It has no real meaning, other than Linux doesn't
support block devices with 128 and 256 byte sector sizes (I have used
such systems, but not in the last 30 years).

LBA size.  This is the unit that the block layer uses to communicate
with the block device.  Must be at least SECTOR_SIZE.  I/O cannot be
performed in smaller chunks than this.

Physical block size.  This is the unit that the device advertises as
its efficient minimum size.  I/Os smaller than this / not aligned to
this will probably incur a performance penalty as the device will need
to do a read-modify-write cycle.

fs block size.  Known as s_blocksize or i_blocksize.  Must be a multiple
of LBA size, but may be smaller than physical block size.  Files are
allocated in multiples of this unit.

PAGE_SIZE.  Unit that memory can be mapped in.  This applies to both
userspace mapping of files as well as calls to kmap_local_*().

folio size.  The size that the page cache has decided to manage this
chunk of the file in.  A multiple of PAGE_SIZE.


I've mostly listed this in smallest to largest.  The relationships that
must be true:

SS <= LBA <= Phys
LBA <= fsb
PS <= folio
fsb <= folio

ocfs2 supports fsb > PAGE_SIZE, but this is a rarity.  Most filesystems
require fsb <= PAGE_SIZE.

Filesystems like UFS also support a fragment size which is less than fs
block size.  It's kind of like tail packing.  Anyway, that's internal to
the filesystem and not exposed to the VFS.

> > > I have no idea why btrfs thinks it needs to track writeback, ordered,
> > > checked and locked in a bitmap.  Those make no sense to me.  But they
> > > make no sense to me if you're support a 4KiB filesystem on a machine
> > > with a 64KiB PAGE_SIZE, not just in the context of "larger folios".
> > > Writeback is something the VM tells you to do; why do you need to tag
> > > individual blocks for writeback?
> > 
> > Because there are cases where btrfs needs to only write back part of the
> > folio independently.

iomap manages to do this with only tracking per-block dirty bits.

> > And especially for mixing compression and non-compression writes inside
> > a page, e.g:
> > 
> >        0     16K     32K     48K      64K
> >        |//|          |///////|
> >           4K
> > 
> > In above case, if we need to writeback above page with 4K sector size,
> > then the first 4K is not suitable for compression (result will still
> > take a full 4K block), while the range [32K, 48K) will be compressed.
> > 
> > In that case, [0, 4K) range will be submitted directly for IO.
> > Meanwhile [32K, 48) will be submitted for compression in antoher wq.
> > (Or time consuming compression will delay the writeback of the remaining
> > pages)
> > 
> > This means the dirty/writeback flags will have a different timing to be
> > changed.
> 
> Just in case if you mean using an atomic to trace the writeback/lock
> progress, then it's possible to go that path, but for now it's not space
> efficient.
> 
> For 16 blocks per page case (4K sectorsize 64K page size), each atomic
> takes 4 bytes while a bitmap only takes 2 bytes.
> 
> And for 4K sectorsize 16K page size case, it's worse and btrfs compact
> all the bitmaps into a larger one to save more space, while each atomic
> still takes 4 bytes.

Sure, but it doesn't scale up well.  And it's kind of irrelevant whether
you occupy 2 or 4 bytes at the low end because you're allocating all
this through slab, so you get rounded to 8 bytes anyway.
iomap_folio_state currently occupies 12 bytes + 2 bits per block.  So
for a 16 block folio (4k in 64k), that's 32 bits for a total of 16
bytes.  For a 2MB folio on a 4kB block size fs, that's 1024 bits for
a total of 140 bytes (rounded to 192 bytes by slab).

Hm, it might be worth adding a kmalloc-160, we'd get 25 objects per 4KiB
page instead of 21 192-byte objects ...


