Return-Path: <linux-btrfs+bounces-13347-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEB7A99C9A
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 02:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E1207A8E0F
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 00:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD52139B;
	Thu, 24 Apr 2025 00:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ZwMc9Sdp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CiZuivxB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6EC625
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 00:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745453662; cv=none; b=ubCoRV22dNY+qhtyg4XphC/fkZrclIfJ3RmLWFISOdmaeOCUR6oHRJrUT5wdSi7gWX5ysnic4FA7lciQpdrufKwMiIqlK39tZloRqf5kx96Jv8WJ72Tz4VrlrZssV0wt2tcu2LW5DVHpKxuyeoDWK2ER/vW0IjIbp7XVjoRG2Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745453662; c=relaxed/simple;
	bh=63vHaDSYqEQuWggo7h5BF39AyEveukSac3pN1wgYnFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvuVgEgfGPte23SvzEIUAtncguXKwGP5yNW+s3p7EIILq6kYxGQ3+l/EwVk4riDJVs0aNwG6ZXYBxfkqJMvpPPDCrcdESNlYFOQ4XyWfzULTCHJzhdAVsOdApJjaqf0rgbEqRxUD2ntyP5QBQL4v0aIJTJI2vXEP66Xw8p4MA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ZwMc9Sdp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CiZuivxB; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AE3342540273;
	Wed, 23 Apr 2025 20:14:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 23 Apr 2025 20:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745453656; x=1745540056; bh=bJXBmud99z
	f9NQI+kwe5cQvVjEbfkmazrC1bQgUw81o=; b=ZwMc9Sdp33ueaojWI0HwAHQRNc
	8Q7KzStkDjr8Aw8YxOjLvF3xHl4KA4yTIjVrS+1f/z07LIo4jf2fyGLrYDmQjeCi
	WkBsy/pNPO0eS81v2qeqOe/SBNJH2N+LPkc1UzBLVAKwCihWYno+zgMC7n4To/ar
	jX3QLUSZgawyqJfnl+gNOi/dx11TVgw43KDl/fkbX/n6MlGShTKnBXDhLvRHGNF4
	qaWG5yKL+ofqzwP92/cMWDStE+mH0FG3bpZ57/PZy4hWrkJv1d5/4xGp4HpPjYhc
	+BFds5LLLMtojjWrwfzXWOYgINK4368+M0O1QLb/LbWrTyi6JDAo5SrC9COA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745453656; x=1745540056; bh=bJXBmud99zf9NQI+kwe5cQvVjEbfkmazrC1
	bQgUw81o=; b=CiZuivxBXIhZr+yMxmW+A7rBWzV2B06WLqmt8eQVeTYMJZDP3ie
	sRdhlHMZVeS+TGMmu+KC6okFkkhLIuMpbI7yTeQzWREGWNPnBPy9Y7yLws2gYfpV
	FINU5GS2DTu5Df6tgY/Jfn4bGqwvde1UdNxgNXhtut8ct72ahTHVnZYrUVx2u+LR
	mNmB/eRLyZdNf8G+SWyCIBnjXV1UfXmzhEWyzyxNZ5/WkrOclKStQ0JHZfvCFdN5
	Ptskk/VA3KXjbDmc81HT40RMKEccl86/fR89Djo/3Tdkcvv22k7Xv/rmk8cxWCpZ
	L3f+5dCeqJFbtLnxUURB1a/HptGW3eP4lAQ==
X-ME-Sender: <xms:V4IJaGkMWa4PlRkYagFJCdu2AGcMGCYRU8hx-UoZyMIdC-SlGfthyg>
    <xme:V4IJaN260gNPvCc93hrCkiLaPFmMvY9VFjDct--DKmvrAvbPWdgD1PVPreS8aX6fY
    2IyR3Mh0Ko9yVjb2lA>
X-ME-Received: <xmr:V4IJaEp2uNVYtnVqNPjE3rg7I4VelGdmFD_TkyRaP3ABax9LiC9_gVIcCD0d4fFpQxz5ZKPCSRLWOMCXwYaMz8Llf2V7aRgaGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeektdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqe
    enucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedu
    gfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:V4IJaKlF7Db0myLDScFBCUa7TJxq__mGqf5khaaQGFHo8OnL-LUzQg>
    <xmx:V4IJaE1DP6vOs-NOUCfHoijx-pLtciOIGEYZW5uPNWwW2AxIlqYlfw>
    <xmx:V4IJaBtySRIkHkDAGgm-ZKqgypN8V9caJl8QfLGoxfQfJxqj520QAQ>
    <xmx:V4IJaAVpS9OAnV_t26rVLaLvTJ7TbBYDN3VAPPZHcBHYsI3Ba4_H5g>
    <xmx:WIIJaNGHeJPYQ7ge7F2cxS6wwSd-Yp1vEGIJHmi1ZPyHK6grydcxxyDe>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 20:14:15 -0400 (EDT)
Date: Wed, 23 Apr 2025 17:14:11 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 1/2] btrfs: make btrfs_truncate_block() to zero
 involved blocks in a folio
Message-ID: <aAmCU2BDFmEmX0mv@devvm12410.ftw0.facebook.com>
References: <0bf58569b1f5ea0d7c2e086f07088e9093b274f3.1745443508.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bf58569b1f5ea0d7c2e086f07088e9093b274f3.1745443508.git.wqu@suse.com>

On Thu, Apr 24, 2025 at 06:56:31AM +0930, Qu Wenruo wrote:
> [BUG]
> The following fsx sequence will fail on btrfs with 64K page size and 4K
> fs block size:
> 
>  #fsx -d -e 1 -N 4 $mnt/junk -S 36386
>  READ BAD DATA: offset = 0xe9ba, size = 0x6dd5, fname = /mnt/btrfs/junk
>  OFFSET      GOOD    BAD     RANGE
>  0xe9ba      0x0000  0x03ac  0x0
>  operation# (mod 256) for the bad data may be 3
>  ...
>  LOG DUMP (4 total operations):
>  1(  1 mod 256): WRITE    0x6c62 thru 0x1147d	(0xa81c bytes) HOLE	***WWWW
>  2(  2 mod 256): TRUNCATE DOWN	from 0x1147e to 0x5448	******WWWW
>  3(  3 mod 256): ZERO     0x1c7aa thru 0x28fe2	(0xc839 bytes)
>  4(  4 mod 256): MAPREAD  0xe9ba thru 0x1578e	(0x6dd5 bytes)	***RRRR***
> 
> [CAUSE]
> Only 2 operations are really involved in this case:
> 
>  3 pollute_eof	0x5448 thru	0xffff	(0xabb8 bytes)
>  3 zero	from 0x1c7aa to 0x28fe3, (0xc839 bytes)
>  4 mapread	0xe9ba thru	0x1578e	(0x6dd5 bytes)
> 
> At operation 3, fsx pollutes beyond EOF, that is done by mmap()
> and write into that mmap() range beyondd EOF.
> 
> Such write will fill the range beyond EOF, but it will never reach disk
> as ranges beyond EOF will not be marked dirty nor uptodate.
> 
> Then we zero_range for [0x1c7aa, 0x28fe3], and since the range is beyond
> our isize (which was 0x5448), we should zero out any range beyond
> EOF (0x5448).
> 
> During btrfs_zero_range(), we call btrfs_truncate_block() to dirty the
> unaligned head block.
> But that function only really zero out the block at [0x5000, 0x5fff], it
> doesn't bother any range other that that block, since those range will
> not be marked dirty nor written back.
> 
> So the range [0x6000, 0xffff] is still polluted, and later mapread()
> will return the poisoned value.
> 
> Such behavior is only exposed when page size is larger than fs block
> btrfs, as for block size == page size case the block is exactly one
> page, and fsx only checks exactly one page at EOF.

This wording struck me as a little weird. What fsx does and doesn't
check shouldn't really matter, compared to the expected/desired behavior
of the various APIs.

Other than that, very nice debug and thanks for the clear explanation.

> 
> [FIX]
> Enhance btrfs_truncate_block() by:
> 
> - Force callers to pass a @start/@end combination
>   So that there will be no 0 length passed in.
> 
> - Rename the @front parameter to an enum
>   And make it matches the @start/@end parameter better by using
>   TRUNCATE_HEAD_BLOCK and TRUNCATE_TAIL_BLOCK instead.

Do I understand that you are not just renaming front to an enum, but
changing the meaning to be selecting a block to do the dirty/writeback
thing on? That is not really as clear as it could be from the commit
message/comments.

> 
> - Pass the original unmodified range into btrfs_truncate_block()
>   There are several call sites inside btrfs_zero_range() and
>   btrfs_punch_hole() where we pass part of the original range for
>   truncating.

The definition of "original range" is very murky to me. It seems
specific to the hole punching code (and maybe some of the other
callsites).

> 
>   This hides the original range which can lead to under or over
>   truncating.
>   Thus we have to pass the original zero/punch range.
> 
> - Make btrfs_truncate_block() to zero any involved blocks inside the folio
>   Since we have the original range, we know exactly which range inside
>   the folio that should be zeroed.
> 
>   It may cover other blocks other than the one with data space reserved,
>   but that's fine, the zeroed range will not be written back anyway.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/btrfs_inode.h | 10 +++++--
>  fs/btrfs/file.c        | 37 ++++++++++++++++--------
>  fs/btrfs/inode.c       | 65 +++++++++++++++++++++++++++---------------
>  3 files changed, 75 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 61fad5423b6a..17b04702562a 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -565,8 +565,14 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
>  		   struct btrfs_inode *parent_inode, struct btrfs_inode *inode,
>  		   const struct fscrypt_str *name, int add_backref, u64 index);
>  int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry);
> -int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
> -			 int front);
> +
> +enum btrfs_truncate_where {
> +	BTRFS_TRUNCATE_HEAD_BLOCK,
> +	BTRFS_TRUNCATE_TAIL_BLOCK,
> +};
> +int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t end,
> +			 u64 orig_start, u64 orig_end,
> +			 enum btrfs_truncate_where where);
>  
>  int btrfs_start_delalloc_snapshot(struct btrfs_root *root, bool in_reclaim_context);
>  int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index e688587329de..23f8f25d617b 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2614,7 +2614,8 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
>  	u64 lockend;
>  	u64 tail_start;
>  	u64 tail_len;
> -	u64 orig_start = offset;
> +	const u64 orig_start = offset;
> +	const u64 orig_end = offset + len - 1;
>  	int ret = 0;
>  	bool same_block;
>  	u64 ino_size;
> @@ -2656,8 +2657,9 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)

(not visible in the formatted patch) but there is a comment just above
this change about how we don't need to truncate past EOF. Can you check
it and update it if it is wrong now?

>  	if (same_block && len < fs_info->sectorsize) {
>  		if (offset < ino_size) {
>  			truncated_block = true;
> -			ret = btrfs_truncate_block(BTRFS_I(inode), offset, len,
> -						   0);
> +			ret = btrfs_truncate_block(BTRFS_I(inode), offset, offset + len - 1,
> +						   orig_start, orig_end,
> +						   BTRFS_TRUNCATE_HEAD_BLOCK);
>  		} else {
>  			ret = 0;
>  		}
> @@ -2667,7 +2669,9 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
>  	/* zero back part of the first block */
>  	if (offset < ino_size) {
>  		truncated_block = true;
> -		ret = btrfs_truncate_block(BTRFS_I(inode), offset, 0, 0);
> +		ret = btrfs_truncate_block(BTRFS_I(inode), offset, -1,
> +					   orig_start, orig_end,
> +					   BTRFS_TRUNCATE_HEAD_BLOCK);
>  		if (ret) {
>  			btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
>  			return ret;
> @@ -2704,8 +2708,9 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
>  			if (tail_start + tail_len < ino_size) {
>  				truncated_block = true;
>  				ret = btrfs_truncate_block(BTRFS_I(inode),
> -							tail_start + tail_len,
> -							0, 1);
> +						tail_start, tail_start + tail_len - 1,
> +						orig_start, orig_end,
> +						BTRFS_TRUNCATE_TAIL_BLOCK);
>  				if (ret)
>  					goto out_only_mutex;
>  			}
> @@ -2873,6 +2878,8 @@ static int btrfs_zero_range(struct inode *inode,
>  	int ret;
>  	u64 alloc_hint = 0;
>  	const u64 sectorsize = fs_info->sectorsize;
> +	const u64 orig_start = offset;
> +	const u64 orig_end = offset + len - 1;
>  	u64 alloc_start = round_down(offset, sectorsize);
>  	u64 alloc_end = round_up(offset + len, sectorsize);
>  	u64 bytes_to_reserve = 0;
> @@ -2935,8 +2942,9 @@ static int btrfs_zero_range(struct inode *inode,
>  		}
>  		if (len < sectorsize && em->disk_bytenr != EXTENT_MAP_HOLE) {
>  			btrfs_free_extent_map(em);
> -			ret = btrfs_truncate_block(BTRFS_I(inode), offset, len,
> -						   0);
> +			ret = btrfs_truncate_block(BTRFS_I(inode), offset, offset + len - 1,
> +						   orig_start, orig_end,
> +						   BTRFS_TRUNCATE_HEAD_BLOCK);
>  			if (!ret)
>  				ret = btrfs_fallocate_update_isize(inode,
>  								   offset + len,
> @@ -2967,7 +2975,9 @@ static int btrfs_zero_range(struct inode *inode,
>  			alloc_start = round_down(offset, sectorsize);
>  			ret = 0;
>  		} else if (ret == RANGE_BOUNDARY_WRITTEN_EXTENT) {
> -			ret = btrfs_truncate_block(BTRFS_I(inode), offset, 0, 0);
> +			ret = btrfs_truncate_block(BTRFS_I(inode), offset, -1,
> +						   orig_start, orig_end,
> +						   BTRFS_TRUNCATE_HEAD_BLOCK);
>  			if (ret)
>  				goto out;
>  		} else {
> @@ -2984,8 +2994,9 @@ static int btrfs_zero_range(struct inode *inode,
>  			alloc_end = round_up(offset + len, sectorsize);
>  			ret = 0;
>  		} else if (ret == RANGE_BOUNDARY_WRITTEN_EXTENT) {
> -			ret = btrfs_truncate_block(BTRFS_I(inode), offset + len,
> -						   0, 1);
> +			ret = btrfs_truncate_block(BTRFS_I(inode), offset, offset + len - 1,
> +						   orig_start, orig_end,
> +						   BTRFS_TRUNCATE_TAIL_BLOCK);
>  			if (ret)
>  				goto out;
>  		} else {
> @@ -3105,7 +3116,9 @@ static long btrfs_fallocate(struct file *file, int mode,
>  		 * need to zero out the end of the block if i_size lands in the
>  		 * middle of a block.
>  		 */
> -		ret = btrfs_truncate_block(BTRFS_I(inode), inode->i_size, 0, 0);
> +		ret = btrfs_truncate_block(BTRFS_I(inode), inode->i_size, -1,
> +					   inode->i_size, -1,
> +					   BTRFS_TRUNCATE_HEAD_BLOCK);
>  		if (ret)
>  			goto out;
>  	}
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 538a9ec86abc..6f910c056819 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4765,15 +4765,16 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
>   *
>   * @inode - inode that we're zeroing
>   * @from - the offset to start zeroing
> - * @len - the length to zero, 0 to zero the entire range respective to the
> - *	offset

orig_start/orig_end are missing. This adds to the confusion about their
definition/semantics I mentioned above.

More generally, I think this change is a huge change to the semantics of
this function, which used to operate on only a block but now operates on
a range. I think that merits a full rewrite of the doc to fully
represent what the new interface is.

> - * @front - zero up to the offset instead of from the offset on
> + * @end - the inclusive end to finish zeroing, can be -1 meaning truncating
> + *	  everything beyond @from.
> + * @where - Head or tail block to truncate.
>   *
>   * This will find the block for the "from" offset and cow the block and zero the
>   * part we want to zero.  This is used with truncate and hole punching.

"zero the part we want to zero" is far less trivial now, for example,
and merits more explanation.

>   */
> -int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
> -			 int front)
> +int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t end,
> +			 u64 orig_start, u64 orig_end,
> +			 enum btrfs_truncate_where where)
>  {
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  	struct address_space *mapping = inode->vfs_inode.i_mapping;
> @@ -4783,20 +4784,30 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
>  	struct extent_changeset *data_reserved = NULL;
>  	bool only_release_metadata = false;
>  	u32 blocksize = fs_info->sectorsize;
> -	pgoff_t index = from >> PAGE_SHIFT;
> -	unsigned offset = from & (blocksize - 1);
> +	pgoff_t index = (where == BTRFS_TRUNCATE_HEAD_BLOCK) ?
> +			(from >> PAGE_SHIFT) : (end >> PAGE_SHIFT);
>  	struct folio *folio;
>  	gfp_t mask = btrfs_alloc_write_mask(mapping);
>  	size_t write_bytes = blocksize;
>  	int ret = 0;
>  	u64 block_start;
>  	u64 block_end;
> +	u64 clamp_start;
> +	u64 clamp_end;
>  
> -	if (IS_ALIGNED(offset, blocksize) &&
> -	    (!len || IS_ALIGNED(len, blocksize)))
> +	ASSERT(where == BTRFS_TRUNCATE_HEAD_BLOCK ||
> +	       where == BTRFS_TRUNCATE_TAIL_BLOCK);
> +
> +	if (end == (loff_t)-1)
> +		ASSERT(where == BTRFS_TRUNCATE_HEAD_BLOCK);
> +
> +	if (IS_ALIGNED(from, blocksize) && IS_ALIGNED(end + 1, blocksize))
>  		goto out;
>  
> -	block_start = round_down(from, blocksize);
> +	if (where == BTRFS_TRUNCATE_HEAD_BLOCK)
> +		block_start = round_down(from, blocksize);
> +	else
> +		block_start = round_down(end, blocksize);

I don't think I get why we would want to change which block we are doing
the cow stuff to, if the main focus is zeroing the full original range.

Apologies if I am being dense on that :)

>  	block_end = block_start + blocksize - 1;
>  
>  	ret = btrfs_check_data_free_space(inode, &data_reserved, block_start,
> @@ -4876,17 +4887,22 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
>  		goto out_unlock;
>  	}
>  
> -	if (offset != blocksize) {
> -		if (!len)
> -			len = blocksize - offset;
> -		if (front)
> -			folio_zero_range(folio, block_start - folio_pos(folio),
> -					 offset);
> -		else
> -			folio_zero_range(folio,
> -					 (block_start - folio_pos(folio)) + offset,
> -					 len);
> -	}
> +	/*
> +	 * Although we have only reserved space for the one block, we still should
> +	 * zero out all blocks in the original range.
> +	 * The remaining blocks normally are already holes thus no need to zero again,
> +	 * but it's possible for fs block size < page size cases to have memory mapped
> +	 * writes to pollute ranges beyond EOF.
> +	 *
> +	 * In that case although the polluted blocks beyond EOF will not reach disk,
> +	 * it still affects our page cache.
> +	 */
> +	clamp_start = max_t(u64, folio_pos(folio), orig_start);
> +	clamp_end = min_t(u64, folio_pos(folio) + folio_size(folio) - 1,
> +			  orig_end);
> +	folio_zero_range(folio, clamp_start - folio_pos(folio),
> +			 clamp_end - clamp_start + 1);
> +
>  	btrfs_folio_clear_checked(fs_info, folio, block_start,
>  				  block_end + 1 - block_start);
>  	btrfs_folio_set_dirty(fs_info, folio, block_start,
> @@ -4988,7 +5004,8 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
>  	 * rest of the block before we expand the i_size, otherwise we could
>  	 * expose stale data.
>  	 */
> -	ret = btrfs_truncate_block(inode, oldsize, 0, 0);
> +	ret = btrfs_truncate_block(inode, oldsize, -1, oldsize, -1,
> +				   BTRFS_TRUNCATE_HEAD_BLOCK);
>  	if (ret)
>  		return ret;
>  
> @@ -7623,7 +7640,9 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
>  		btrfs_end_transaction(trans);
>  		btrfs_btree_balance_dirty(fs_info);
>  
> -		ret = btrfs_truncate_block(inode, inode->vfs_inode.i_size, 0, 0);
> +		ret = btrfs_truncate_block(inode, inode->vfs_inode.i_size, -1,
> +					   inode->vfs_inode.i_size, -1,
> +					   BTRFS_TRUNCATE_HEAD_BLOCK);
>  		if (ret)
>  			goto out;
>  		trans = btrfs_start_transaction(root, 1);
> -- 
> 2.49.0

