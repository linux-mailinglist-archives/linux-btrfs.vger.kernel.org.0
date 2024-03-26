Return-Path: <linux-btrfs+bounces-3609-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0199C88C86B
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 17:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C191F80CA6
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 16:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EE713C903;
	Tue, 26 Mar 2024 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="TOHOMprZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SZZ/45Ef"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E592813C8ED
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711468978; cv=none; b=aGVEaewkz7wVuvm6d4Qd9X68+OxZxe1EOdZQ0IK3eSZMOkNXRXA0CvDRwDgdXxcjSlBRqnVsbLkdxNHJMJlrYDBLVYmUm3FANTFoSqdA1u5DLjPyAzsYrauQCMIwWioxBDh5cbEnk1ADiVUtffAaQDdNQo5MhPZWofspiCup6oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711468978; c=relaxed/simple;
	bh=rIviVUIV/Zp4jIGkKqT8vgge3kV0ieDAB0vsPVn+xNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8aAnm4/pQ1ygYY4YsnpC9WmmjLgd+cMNGXyDLXpda9qtnZnLtBiGYsW+VO8uJXBuOVQuvW8Qh8ytNDLZ0rgFETIlPa+9HAXXFyUKsfRjCRUt0vP1AtlH+mjix2aqvhyKFOECwEYqTYPVOmRxqMWi00dGnn/5XZy9BHuHfTw7DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=TOHOMprZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SZZ/45Ef; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id BA66332001C6;
	Tue, 26 Mar 2024 12:02:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 26 Mar 2024 12:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1711468973; x=1711555373; bh=pgmiw5gNm9
	HtgoPDAuqifdiAwA7eIp9KNuS8SgbNQIY=; b=TOHOMprZ20Tn3Irm475wdsg20m
	U9OCmGBSrrvcyzWHqqdZa1TPxilg46Toyt9RcT7VsQWufKyVrFijsXGpaRCJN82N
	/M7j9BXUytNmgR98N4SFAVs29Oi0qqWVeb+oHfglCmmWdY/iEwkkhkr8/Dg8DSO9
	741VA5oGA/p+q6a9QnHBw8gOC/5rprFMuKIs6PO52J+5Ws1P+b7n6qCLwwh+bbeq
	/NPGtrJS8ichv8kiqFSfcBAM1kfuFP5lKT6ATtOZGKkuqbd0qtEMTCHJaaWZC9DF
	OKoM2GYCPs3KzhxpnvBG65KuCt2AY8ONn+IlLQf2vp0pbxYqtGLV3tuwDtGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711468973; x=1711555373; bh=pgmiw5gNm9HtgoPDAuqifdiAwA7e
	Ip9KNuS8SgbNQIY=; b=SZZ/45EfmrDKE2Milicx20f9f7L1pohhp1l0Mf5joLAM
	BZ3V+/ocSPbK5KQSpAMCmMxavGty/vUZUA114FrO8sHLGPhD8D90mX/wzMeaLdiO
	iI1grY0CjTIWMV4LHfLEskOVpLnmHKeCo2/w7PFxoRYp5Xsq4CoGcbJdsSzyhGCB
	vQh0qKQQ3xJyGinRpMWHKva3JSj5Nxtw1V2d3ESrHVW4aNy/0Si3SL46KXjssOx0
	wpFJUqigX06l+2NLrie4Ri4fhWCRDsxKNqgcHPVCTgy3QrtiaxB7fyffcMHtO8L9
	EU70zCN0J/l2eS6GIfhO8dHUh2uyW5ynfMcdkPxP6g==
X-ME-Sender: <xms:rPECZoAfVNu1IHPuWhvDKzyH7_H71WQFQxQrieXFRK2JonKLALjucw>
    <xme:rPECZqiFFEnoB_6SxdDQlrpog2Mtot9pelMt7IJ_YS3_cO58Z7A_IoDe5B8q0-QTD
    xPohEfXDI0q-PgZZy0>
X-ME-Received: <xmr:rPECZrkwEmxv4mysA4XupWSljuQzG9DW9lFPF9PnROAp_4wPSWfSwDJTjPHWqNWCdpW-Vl_6c9DjkRWlI1O0W-Oy63s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvve
    eiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:rPECZuxg9PiuIOg3uJlXjaCrYqqAxSukL4GbBPPkSbQAAm72ucD7AA>
    <xmx:rfECZtQQ9czxqDV0hbzyIZE_1lzVxytrjJ5C_FP1OIvZn_JR2k5DQw>
    <xmx:rfECZpY-zU3ZCUZzDeBaddfuqytCNNwD2TnhZoRGahTq7EPNmqFUkA>
    <xmx:rfECZmT7g7-XEU_YbfqMUXebJYGoq4DRbuEDGp5ycvqzXr2o1HFFWQ>
    <xmx:rfECZsIdJpFHyZoxNPJpW-Tt-XMqEqgbl4XG4Tc8w9-vKkWcrlR4bg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 12:02:52 -0400 (EDT)
Date: Tue, 26 Mar 2024 09:05:00 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: stop locking the source extent range during
 reflink
Message-ID: <20240326160500.GA286197@zen.localdomain>
References: <09a3da957a5b7f60a1dba5f4609971a62b3f7c23.1711134182.git.fdmanana@suse.com>
 <5fe82cceb3b6f3434172a7fb0e85a21a2f07e99c.1711199153.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fe82cceb3b6f3434172a7fb0e85a21a2f07e99c.1711199153.git.fdmanana@suse.com>

On Sat, Mar 23, 2024 at 01:29:25PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Nowadays before starting a reflink operation we do this:
> 
> 1) Take the VFS lock of the inodes in exclusive mode (a rw semaphore);
> 
> 2) Take the  mmap lock of the inodes (struct btrfs_inode::i_mmap_lock);
> 
> 3) Flush all dealloc in the source and target ranges;
> 
> 4) Wait for all ordered extents in the source and target ranges to
>    complete;
> 
> 5) Lock the source and destination ranges in the inodes' io trees.
> 
> In step 5 we lock the source range because:
> 
> 1) We needed to serialize against mmap writes, but that is not needed
>    anymore because nowadays we do that through the inode's i_mmap_lock
>    (step 2). This happens since commit 8c99516a8cdd ("btrfs: exclude mmaps
>    while doing remap");
> 
> 2) To serialize against a concurrent relocation and avoid generating
>    a delayed ref for an extent that was just dropped by relocation, see
>    commit d8b552424210 (Btrfs: fix race between reflink/dedupe and
>    relocation").

Great catch! Did you notice this via blame or did a test catch it?
Should we try to write a test which exercises concurrent reflink and
relocation if we don't have one?

> 
> Locking the source range however blocks any concurrent reads for that
> range and makes test case generic/733 fail.
> 
> So instead of locking the source range during reflinks, make relocation
> read lock the inode's i_mmap_lock, so that it serializes with a concurrent
> reflink while still able to run concurrently with mmap writes and allow
> concurrent reads too.

The local locking logic (order, releasing, error-paths) all looks good
to me. It also seems to restore a similar amount of serialization as the
range locking with relocation, so with that said, you can add:
Reviewed-by: Boris Burkov <boris@bur.io>

However, since I missed it the first time around, now I'm a bit more
curious about how this works.

Clone doesn't seem to commit its transaction, so is there something else
that gets relocation to see the new reference and move it as well? It
just keeps looping until there are no inodes pointing at the block
group? Or is there something about the order of adding the delayed refs
that makes the delayed ref merging handle it better?

On the other hand, if relocation wins the race for the mmap lock, then
reflink will re-create the ref with an add_delayed_extent? How come that
doesn't happen without the extra locking?

Hope my questions make sense :)
Boris

> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> 
> ---
> 
> V2: Protect against concurrent relocation of the source extents and
>     update comment.
> 
>  fs/btrfs/reflink.c    | 54 ++++++++++++++-----------------------------
>  fs/btrfs/relocation.c |  8 ++++++-
>  2 files changed, 24 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index 08d0fb46ceec..f12ba2b75141 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -616,35 +616,6 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
>  	return ret;
>  }
>  
> -static void btrfs_double_extent_unlock(struct inode *inode1, u64 loff1,
> -				       struct inode *inode2, u64 loff2, u64 len)
> -{
> -	unlock_extent(&BTRFS_I(inode1)->io_tree, loff1, loff1 + len - 1, NULL);
> -	unlock_extent(&BTRFS_I(inode2)->io_tree, loff2, loff2 + len - 1, NULL);
> -}
> -
> -static void btrfs_double_extent_lock(struct inode *inode1, u64 loff1,
> -				     struct inode *inode2, u64 loff2, u64 len)
> -{
> -	u64 range1_end = loff1 + len - 1;
> -	u64 range2_end = loff2 + len - 1;
> -
> -	if (inode1 < inode2) {
> -		swap(inode1, inode2);
> -		swap(loff1, loff2);
> -		swap(range1_end, range2_end);
> -	} else if (inode1 == inode2 && loff2 < loff1) {
> -		swap(loff1, loff2);
> -		swap(range1_end, range2_end);
> -	}
> -
> -	lock_extent(&BTRFS_I(inode1)->io_tree, loff1, range1_end, NULL);
> -	lock_extent(&BTRFS_I(inode2)->io_tree, loff2, range2_end, NULL);
> -
> -	btrfs_assert_inode_range_clean(BTRFS_I(inode1), loff1, range1_end);
> -	btrfs_assert_inode_range_clean(BTRFS_I(inode2), loff2, range2_end);
> -}
> -
>  static void btrfs_double_mmap_lock(struct inode *inode1, struct inode *inode2)
>  {
>  	if (inode1 < inode2)
> @@ -662,17 +633,21 @@ static void btrfs_double_mmap_unlock(struct inode *inode1, struct inode *inode2)
>  static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
>  				   struct inode *dst, u64 dst_loff)
>  {
> +	const u64 end = dst_loff + len - 1;
> +	struct extent_state *cached_state = NULL;
>  	struct btrfs_fs_info *fs_info = BTRFS_I(src)->root->fs_info;
>  	const u64 bs = fs_info->sectorsize;
>  	int ret;
>  
>  	/*
> -	 * Lock destination range to serialize with concurrent readahead() and
> -	 * source range to serialize with relocation.
> +	 * Lock destination range to serialize with concurrent readahead(), and
> +	 * we are safe from concurrency with relocation of source extents
> +	 * because we have already locked the inode's i_mmap_lock in exclusive
> +	 * mode.
>  	 */
> -	btrfs_double_extent_lock(src, loff, dst, dst_loff, len);
> +	lock_extent(&BTRFS_I(dst)->io_tree, dst_loff, end, &cached_state);
>  	ret = btrfs_clone(src, dst, loff, len, ALIGN(len, bs), dst_loff, 1);
> -	btrfs_double_extent_unlock(src, loff, dst, dst_loff, len);
> +	unlock_extent(&BTRFS_I(dst)->io_tree, dst_loff, end, &cached_state);
>  
>  	btrfs_btree_balance_dirty(fs_info);
>  
> @@ -724,6 +699,7 @@ static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
>  static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
>  					u64 off, u64 olen, u64 destoff)
>  {
> +	struct extent_state *cached_state = NULL;
>  	struct inode *inode = file_inode(file);
>  	struct inode *src = file_inode(file_src);
>  	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
> @@ -731,6 +707,7 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
>  	int wb_ret;
>  	u64 len = olen;
>  	u64 bs = fs_info->sectorsize;
> +	u64 end;
>  
>  	/*
>  	 * VFS's generic_remap_file_range_prep() protects us from cloning the
> @@ -763,12 +740,15 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
>  	}
>  
>  	/*
> -	 * Lock destination range to serialize with concurrent readahead() and
> -	 * source range to serialize with relocation.
> +	 * Lock destination range to serialize with concurrent readahead(), and
> +	 * we are safe from concurrency with relocation of source extents
> +	 * because we have already locked the inode's i_mmap_lock in exclusive
> +	 * mode.
>  	 */
> -	btrfs_double_extent_lock(src, off, inode, destoff, len);
> +	end = destoff + len - 1;
> +	lock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
>  	ret = btrfs_clone(src, inode, off, olen, len, destoff, 0);
> -	btrfs_double_extent_unlock(src, off, inode, destoff, len);
> +	unlock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
>  
>  	/*
>  	 * We may have copied an inline extent into a page of the destination
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index f96f267fb4aa..8fe495d74776 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1127,16 +1127,22 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
>  						    fs_info->sectorsize));
>  				WARN_ON(!IS_ALIGNED(end, fs_info->sectorsize));
>  				end--;
> +				/* Take mmap lock to serialize with reflinks. */
> +				if (!down_read_trylock(&BTRFS_I(inode)->i_mmap_lock))
> +					continue;
>  				ret = try_lock_extent(&BTRFS_I(inode)->io_tree,
>  						      key.offset, end,
>  						      &cached_state);
> -				if (!ret)
> +				if (!ret) {
> +					up_read(&BTRFS_I(inode)->i_mmap_lock);
>  					continue;
> +				}
>  
>  				btrfs_drop_extent_map_range(BTRFS_I(inode),
>  							    key.offset, end, true);
>  				unlock_extent(&BTRFS_I(inode)->io_tree,
>  					      key.offset, end, &cached_state);
> +				up_read(&BTRFS_I(inode)->i_mmap_lock);
>  			}
>  		}
>  
> -- 
> 2.43.0
> 

