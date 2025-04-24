Return-Path: <linux-btrfs+bounces-13348-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE32AA99CF0
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 02:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6340A3A7D0B
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 00:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A1F8F5E;
	Thu, 24 Apr 2025 00:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="bjxSX4ir";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J5Jmx7Vr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4D4380
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 00:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745454443; cv=none; b=rhbEwsWXglwEO/anewRDqNLgSx8YkQGQ6vOM6wJ9aNgCwVf9WqIN9ZWikvEOXAx6LHyP7KpVLdFUYeNg9VB6OrspF0hvElOg1Oi5NgqWaV9w1unFF5M5h0BGsXSnLyHjMaNnhTU81iErSWNdeaFb0K4dyz6x+XM+GHkQAJApj2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745454443; c=relaxed/simple;
	bh=8fPZHx6mPFs76gHWx+dAB3pv1I1QTKCGSu/ydUfMGU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdfjKDFh+v5RHMgB0sUibrOk7OyZdTmWzlUTuTph9P5DrS/cMBw8ZXhG0gPtd3FTbVnfup83i0DP9h1lKlgevYUSB2MLrtJvSdT390H/yPu4jI1XqomGN1cBRspwIKjbAtS3N4IIWLKTwe2oKdI1lFtThcNF8LEk797cIzh1ouY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=bjxSX4ir; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J5Jmx7Vr; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D14FE1140154;
	Wed, 23 Apr 2025 20:27:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 23 Apr 2025 20:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745454439; x=1745540839; bh=w/20hQmDEu
	eTan254ZtpfGuw5C2YtNNeRFkwDAFDrhI=; b=bjxSX4irqogQa18YVWDUmO8FQN
	vXRW8MLDDG5q+kkHyTx0u+Ffxl2yv4HmQF27DuVMlFRO4fObTe0obAT0ha/OYJAN
	WF21BDxKxV8F4xWsb2gQqLCp+d0snbFogfM2wTMjdEwlaxHjtipmQtGHvgevxKJa
	qo4vfgbA1RwPRSwtxdpvMLxhuin9DsKM0FA+rp3tAVQggrP/jjt0Lzd0VZmXFVxG
	ZhgFJk2UgMBbXy3heiahdIeMDMmKhwIBCmuEj1FE0oEc2X8X2ASwzVhNBzW/a/tV
	xPeVFPfTMbadzmRbDVVLS1qM7YVEevgb/zBDwVeaHERVtmmmSYNNHuKSsjAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745454439; x=1745540839; bh=w/20hQmDEueTan254ZtpfGuw5C2YtNNeRFk
	wDAFDrhI=; b=J5Jmx7VrYt8mcsltLF9wgXVHfWme21HQxk1M11NecIuUyiDFy4Z
	36seQ0S5KQ4Lzd2AB+UC/mi6e1GRstKmXWcHytgZKYC23C5qUqmv509Lki+OKGda
	uAzhVDoFr/yiznRQZdZqTlgafKRQGf8vueyL5UYdtI8jtUOLKXg6njvYpaoSvxst
	cL20nCS2UZOKfnQ3EPiGQv6y7J1trcS5tvgL8a/4qw0ibEc84EaawFNwwTA82sfr
	e4z5EIQX40AQd/0q4F7N4TjzmolRz6F6LcKeLmTYE1t95Ykn4v4XOjp0E0czhK0l
	YIYhSsHjrVC0+ykQLpkfFEMtXAtr50k9/jA==
X-ME-Sender: <xms:ZoUJaFRHwwyQl-jBSi9YEkUL3O1wuffLP3EKmN86ehI_Qj9xhw9UyQ>
    <xme:ZoUJaOzyoMJ-9yudXBtqV9nqJbG_dXTC19By3lvK6tt9WEQ0fwXUOwceQZt-XpriC
    8BOXv1ClVbIsU-QN3w>
X-ME-Received: <xmr:ZoUJaK3OtwmRTPlaqjPnKk9PBN_DBDY-UeQLGG6RBGivxqipMzn1b45VRSkMpRbNmBIPsDz2FNPpNWOe-dyH9ROzOzimPjKL2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeektdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqe
    enucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedu
    gfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZoUJaNDZURl3LH36NJBmoxhRZlXros71Udo4UkDip30ZwQ88qeoNug>
    <xmx:ZoUJaOhhjrmHabnWCk8PdtdtIvzEmxM8oaG3U0ePDZTJw-X5hhAglQ>
    <xmx:ZoUJaBq8XODtpkdJb3x7ffhZCwy6m7zsU2Fxm8_1f3WHjhgPNP-f5Q>
    <xmx:ZoUJaJgEET_4UYjqTw2UgJZYtUwOGvHzhZ1KD1Y0UVF7R672bn8uuA>
    <xmx:Z4UJaBvEfFXxMPdt1PtIx2xrzepbsmbFoRfbbEg6PuAeHV0bFi0nYbeP>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 20:27:18 -0400 (EDT)
Date: Wed, 23 Apr 2025 17:27:14 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 2/2] btrfs: make btrfs_truncate_block() zero folio
 range for certain subpage corner cases
Message-ID: <aAmFYrptBXjufdg5@devvm12410.ftw0.facebook.com>
References: <50e41f048f26b5b58f55b25c045e5dfe94a8dcfd.1745443508.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50e41f048f26b5b58f55b25c045e5dfe94a8dcfd.1745443508.git.wqu@suse.com>

On Thu, Apr 24, 2025 at 06:56:32AM +0930, Qu Wenruo wrote:
> [BUG]
> For the following fsx -e 1 run, the btrfs still fails the run on 64K
> page size with 4K fs block size:
> 
> READ BAD DATA: offset = 0x26b3a, size = 0xfafa, fname = /mnt/btrfs/junk
> OFFSET      GOOD    BAD     RANGE
> 0x26b3a     0x0000  0x15b4  0x0
> operation# (mod 256) for the bad data may be 21
> [...]
> LOG DUMP (28 total operations):
> 1(  1 mod 256): SKIPPED (no operation)
> 2(  2 mod 256): SKIPPED (no operation)
> 3(  3 mod 256): SKIPPED (no operation)
> 4(  4 mod 256): SKIPPED (no operation)
> 5(  5 mod 256): WRITE    0x1ea90 thru 0x285e0	(0x9b51 bytes) HOLE
> 6(  6 mod 256): ZERO     0x1b1a8 thru 0x20bd4	(0x5a2d bytes)
> 7(  7 mod 256): FALLOC   0x22b1a thru 0x272fa	(0x47e0 bytes) INTERIOR
> 8(  8 mod 256): WRITE    0x741d thru 0x13522	(0xc106 bytes)
> 9(  9 mod 256): MAPWRITE 0x73ee thru 0xdeeb	(0x6afe bytes)
> 10( 10 mod 256): FALLOC   0xb719 thru 0xb994	(0x27b bytes) INTERIOR
> 11( 11 mod 256): COPY 0x15ed8 thru 0x18be1	(0x2d0a bytes) to 0x25f6e thru 0x28c77
> 12( 12 mod 256): ZERO     0x1615e thru 0x1770e	(0x15b1 bytes)
> 13( 13 mod 256): SKIPPED (no operation)
> 14( 14 mod 256): DEDUPE 0x20000 thru 0x27fff	(0x8000 bytes) to 0x1000 thru 0x8fff
> 15( 15 mod 256): SKIPPED (no operation)
> 16( 16 mod 256): CLONE 0xa000 thru 0xffff	(0x6000 bytes) to 0x36000 thru 0x3bfff
> 17( 17 mod 256): ZERO     0x14adc thru 0x1b78a	(0x6caf bytes)
> 18( 18 mod 256): TRUNCATE DOWN	from 0x3c000 to 0x1e2e3	******WWWW
> 19( 19 mod 256): CLONE 0x4000 thru 0x11fff	(0xe000 bytes) to 0x16000 thru 0x23fff
> 20( 20 mod 256): FALLOC   0x311e1 thru 0x3681b	(0x563a bytes) PAST_EOF
> 21( 21 mod 256): FALLOC   0x351c5 thru 0x40000	(0xae3b bytes) EXTENDING
> 22( 22 mod 256): WRITE    0x920 thru 0x7e51	(0x7532 bytes)
> 23( 23 mod 256): COPY 0x2b58 thru 0xc508	(0x99b1 bytes) to 0x117b1 thru 0x1b161
> 24( 24 mod 256): TRUNCATE DOWN	from 0x40000 to 0x3c9a5
> 25( 25 mod 256): SKIPPED (no operation)
> 26( 26 mod 256): MAPWRITE 0x25020 thru 0x26b06	(0x1ae7 bytes)
> 27( 27 mod 256): SKIPPED (no operation)
> 28( 28 mod 256): READ     0x26b3a thru 0x36633	(0xfafa bytes)	***RRRR***
> 
> [CAUSE]
> The involved operations are:
> 
>  fallocating to largest ever: 0x40000
>  21 pollute_eof	0x24000 thru	0x2ffff	(0xc000 bytes)
>  21 falloc	from 0x351c5 to 0x40000 (0xae3b bytes)
>  28 read	0x26b3a thru	0x36633	(0xfafa bytes)
> 
> At operation #21 a pollute_eof is done, by memory mappaed write into
> range [0x24000, 0x2ffff).
> At this stage, the inode size is 0x24000, which is block aligned.
> 
> Then fallocate happens, and since it's expanding the inode, it will call
> btrfs_truncate_block() to truncate any unaligned range.
> 
> But since the inode size is already block aligned,
> btrfs_truncate_block() does nothing and exit.
> 
> However remember the folio at 0x20000 has some range polluted already,
> although they will not be written back to disk, it still affects the
> page cache, resulting the later operation #28 to read out the polluted
> value.
> 
> [FIX]
> Instead of early exit from btrfs_truncate_block() if the range is
> already block aligned, do extra filio zeroing if the fs block size is
> smaller than the page size.
> 
> This is to address exactly the above case where memory mapped write can
> still leave some garbage beyond EOF.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 88 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 6f910c056819..23cd03716e57 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4760,6 +4760,80 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
>  	return ret;
>  }
>  
> +/*
> + * A helper to zero out all blocks inside range [@orig_start, @orig_end) of
> + * the target folio.
> + * The target folio is the one containing the head or tail block of the range
> + * [@from, @end].
> + *
> + * This is a special case for fs block size < page size, where even if the range
> + * [from, end] is already block aligned, we can still have blocks beyond EOF being
> + * polluted by memory mapped write.
> + */

This function name is basically the same as folio_zero_range which
behaves very differently. I think it needs a name that captures the fact
that it is a special case for btrfs_truncate_block

> +static int zero_range_folio(struct btrfs_inode *inode, u64 from, u64 end,
> +			    u64 orig_start, u64 orig_end,
> +			    enum btrfs_truncate_where where)
> +{
> +	const u32 blocksize = inode->root->fs_info->sectorsize;
> +	struct address_space *mapping = inode->vfs_inode.i_mapping;
> +	struct extent_io_tree *io_tree = &inode->io_tree;
> +	struct extent_state *cached_state = NULL;
> +	struct btrfs_ordered_extent *ordered;
> +	pgoff_t index = (where == BTRFS_TRUNCATE_HEAD_BLOCK) ?
> +			(from >> PAGE_SHIFT) : (end >> PAGE_SHIFT);
> +	struct folio *folio;
> +	u64 block_start;
> +	u64 block_end;
> +	u64 clamp_start;
> +	u64 clamp_end;
> +	int ret = 0;
> +
> +again:
> +	folio = filemap_lock_folio(mapping, index);
> +	/* No folio present. */
> +	if (IS_ERR(folio))
> +		return 0;
> +
> +	if (!folio_test_uptodate(folio)) {
> +		ret = btrfs_read_folio(NULL, folio);
> +		folio_lock(folio);
> +		if (folio->mapping != mapping) {
> +			folio_unlock(folio);
> +			folio_put(folio);
> +			goto again;
> +		}
> +		if (!folio_test_uptodate(folio)) {
> +			ret = -EIO;
> +			goto out_unlock;
> +		}
> +	}
> +	folio_wait_writeback(folio);

This lock/read/wait pattern is the same as in btrfs_truncate_block and I
think could benefit from being lifted into a function. 

> +
> +	clamp_start = max_t(u64, folio_pos(folio), orig_start);
> +	clamp_end = min_t(u64, folio_pos(folio) + folio_size(folio) - 1,
> +			  orig_end);
> +	block_start = round_down(clamp_start, blocksize);
> +	block_end = round_up(clamp_end + 1, blocksize) - 1;
> +	lock_extent(io_tree, block_start, block_end, &cached_state);
> +	ordered = btrfs_lookup_ordered_range(inode, block_start, block_end + 1 - block_end);
> +	if (ordered) {
> +		unlock_extent(io_tree, block_start, block_end, &cached_state);
> +		folio_unlock(folio);
> +		folio_put(folio);
> +		btrfs_start_ordered_extent(ordered);
> +		btrfs_put_ordered_extent(ordered);
> +		goto again;
> +	}
> +	folio_zero_range(folio, clamp_start - folio_pos(folio),
> +			 clamp_end - clamp_start + 1);
> +	unlock_extent(io_tree, block_start, block_end, &cached_state);
> +
> +out_unlock:
> +	folio_unlock(folio);
> +	folio_put(folio);
> +	return ret;
> +}
> +
>  /*
>   * Read, zero a chunk and write a block.
>   *
> @@ -4801,8 +4875,20 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t end,
>  	if (end == (loff_t)-1)
>  		ASSERT(where == BTRFS_TRUNCATE_HEAD_BLOCK);
>  
> -	if (IS_ALIGNED(from, blocksize) && IS_ALIGNED(end + 1, blocksize))
> -		goto out;
> +	if (IS_ALIGNED(from, blocksize) && IS_ALIGNED(end + 1, blocksize)) {

Does this need to depend on `where` now or is it still necessary to
check both?

> +		/*
> +		 * The target head/tail range is already block aligned.
> +		 * If block size >= PAGE_SIZE, meaning it's impossible to mmap a
> +		 * page containing anything other than the target block.
> +		 * So we can safely exit.
> +		 *
> +		 * Otherwise we still need to zero out the range inside the folio
> +		 * to avoid memory mapped write to pollute beyond EOF.
> +		 */
> +		if (blocksize >= PAGE_SIZE)
> +			return 0;
> +		return zero_range_folio(inode, from, end, orig_start, orig_end, where);
> +	}
>  
>  	if (where == BTRFS_TRUNCATE_HEAD_BLOCK)
>  		block_start = round_down(from, blocksize);
> -- 
> 2.49.0

