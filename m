Return-Path: <linux-btrfs+bounces-3517-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD5B8874F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 23:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2B01C22BD9
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 22:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F4B8289D;
	Fri, 22 Mar 2024 22:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="qaDllqvs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WoF42FHA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB10660B91
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Mar 2024 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711148155; cv=none; b=Bw04ejgxB7wWg/3DCd+3Hz/RLiIPHze0bZcELAL5iiQb1apb7vi2NHBLjM3YcpVkWKoHs9IDv+gux6vztcAarV5uTkI2LuO6fJ5aeh0PqN3gJ6oxNqzXPvSjwqFJA6OI/r89XX+0hAcJDzw0YnJjrQhKZqhBcypE8CKk/IOOO1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711148155; c=relaxed/simple;
	bh=CYSy6D6b7oLFV3bCUxtxcQWJlbvCiW6z7FmaQmlV7K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fur4ZDjIEyJJcSdDoCJSUA1cA6gGEsnYomevuqPuFA92uRa8E+rkDqF0b54Os1AdXqgtbIWqFhAYVSaBr1TD/C8Fv3BlBt3Fqgi1dsh40a/GB78Pc07lPAlL5/h1kZBY6mvmSf6OYvSC28tiDsC3AIWymNezFE4Yf3FWSFWsN+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=qaDllqvs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WoF42FHA; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 98C545C0074;
	Fri, 22 Mar 2024 18:55:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 22 Mar 2024 18:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1711148150; x=1711234550; bh=ZR2sL+PQbv
	Yneasy7Re70F+W/+p7c8f44JXWeedXpCo=; b=qaDllqvsYqCBgiq1y5CjH+RPF6
	qjiTx/KCEdKkyUdYW4dFy7SNoqhLozvJ1Aym8pU9Y1+xnnoEct78UhfiGJ/4dOJu
	AP9SU13ddi+dJX41PKx+b0p0ElKe4kS98o4gmADsz/joGeBLe+S1HZ+36mAUsp3r
	Zw6st3zl82A1IHuYv7BQpn+5jpDUXfeboABr0npKQKUxVFbkeAqBZVXia+gqXP1x
	sVR0CIa7uRjRqc3OAPdAWvflPyVZTGIWHhYsL6Wi2RGAnywAg5tPpeTI9qkYMEHq
	65dqpfhslWnHuCDXOgL9Mje2jKUZXkI7hGM9qP9wSJSvtl6w36KRVaKqF2VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711148150; x=1711234550; bh=ZR2sL+PQbvYneasy7Re70F+W/+p7
	c8f44JXWeedXpCo=; b=WoF42FHASBuYqVvRLEFOOhCYarS8w0i/KBt48JIXnfg7
	fejtR+FHUn7NKjWdi0a/hrApRUTRlF44vVvZIFBeHLEXbIozD8psfXjUOgPiUUvq
	K/RPKA2wK2fwtedr94/uZM725UDO8ndUfLvp6c5pXsL1nZz8J8i7EdANwei+VDK/
	lggns3UT77z1+athwiEPquQAgjrTYT0NXO2pBzBTFHNW7Qy8rnFtlPCj/i3oLfZH
	HxWjnIpTU7RN4usaLyssQOIwjdUvzP69r1GQzqCr3p0QKkyTKamGdkug2kZ1VICj
	KMwJVPUZBgJMrERLjLoxQWMW46Gp1gB2j7lEHhXYNA==
X-ME-Sender: <xms:dgz-ZQm7_XgvO_TynAO10_G7lwgX_XDAKG6iTwiH99roTloQaz15OA>
    <xme:dgz-Zf3UVPyCBQPH7euJt7XjP0aqjs1vCCPQ5R1gyFZx43vauOjQ4BR2sgo-kySbA
    sgO7KcrByX16hE7Mw4>
X-ME-Received: <xmr:dgz-ZepVFl6Rd-LEXmop86hvsghN57vNeOTA-M6fAYkoMi_m4pE2xdy1vI7l77g-Bsgprf-o5wR8OjfduuZC5KlMmSM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtfedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvve
    eiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:dgz-Zck8ToVjwtLiAB1LHxuhpGAOYc5K20CXcTsloTtgoF18zshqKA>
    <xmx:dgz-Ze07fKBHrJ2901JJ8wQv6pYpWsRx3BEfFu8yM1qGXRQd3IBgpA>
    <xmx:dgz-ZTsOHzjrpgf2mc-A9sBeefcmTeGhdc2B6w7HtytOz1kY7M-itg>
    <xmx:dgz-ZaWiA4c5N_8XZ35uNqSSgi-YMiGmIKk4wvp0H-Xipq4ju5_gSQ>
    <xmx:dgz-ZT-4OoLhdS1b6EbSLQkUwpF31xdnKQjFsSLDiIk93gqHK3_ozQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Mar 2024 18:55:49 -0400 (EDT)
Date: Fri, 22 Mar 2024 15:58:03 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: stop locking the source extent range during
 reflink
Message-ID: <20240322225803.GA173716@zen.localdomain>
References: <09a3da957a5b7f60a1dba5f4609971a62b3f7c23.1711134182.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09a3da957a5b7f60a1dba5f4609971a62b3f7c23.1711134182.git.fdmanana@suse.com>

On Fri, Mar 22, 2024 at 07:07:18PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Nowadays before starting a reflink operation we do this:
> 
> 1) Take the VFS lock of the inodes in exlcusive mode (a rw semaphore);
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
> In step 5 we don't need anymore to lock the source range because nowadays
> we have the mmap lock (step 2) and locking the source range was just to
> avoid races with mmap writes before we had that mmap lock, which was added
> in commit 8c99516a8cdd ("btrfs: exclude mmaps while doing remap").
> 
> So stop locking the source file range, allowing concurrent reads to happen
> in parallel and making test case generic/733 pass.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/reflink.c | 42 +++++++++---------------------------------
>  1 file changed, 9 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index 08d0fb46ceec..6e7a3970394b 100644
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
> @@ -662,6 +633,8 @@ static void btrfs_double_mmap_unlock(struct inode *inode1, struct inode *inode2)
>  static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
>  				   struct inode *dst, u64 dst_loff)
>  {
> +	const u64 end = dst_loff + len - 1;
> +	struct extent_state *cached_state = NULL;
>  	struct btrfs_fs_info *fs_info = BTRFS_I(src)->root->fs_info;
>  	const u64 bs = fs_info->sectorsize;
>  	int ret;
> @@ -670,9 +643,9 @@ static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
>  	 * Lock destination range to serialize with concurrent readahead() and
>  	 * source range to serialize with relocation.
>  	 */
> -	btrfs_double_extent_lock(src, loff, dst, dst_loff, len);
> +	lock_extent(&BTRFS_I(dst)->io_tree, dst_loff, end, &cached_state);
>  	ret = btrfs_clone(src, dst, loff, len, ALIGN(len, bs), dst_loff, 1);
> -	btrfs_double_extent_unlock(src, loff, dst, dst_loff, len);
> +	unlock_extent(&BTRFS_I(dst)->io_tree, dst_loff, end, &cached_state);
>  
>  	btrfs_btree_balance_dirty(fs_info);
>  
> @@ -724,6 +697,7 @@ static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
>  static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
>  					u64 off, u64 olen, u64 destoff)
>  {
> +	struct extent_state *cached_state = NULL;
>  	struct inode *inode = file_inode(file);
>  	struct inode *src = file_inode(file_src);
>  	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
> @@ -731,6 +705,7 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
>  	int wb_ret;
>  	u64 len = olen;
>  	u64 bs = fs_info->sectorsize;
> +	u64 end;
>  
>  	/*
>  	 * VFS's generic_remap_file_range_prep() protects us from cloning the
> @@ -766,9 +741,10 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
>  	 * Lock destination range to serialize with concurrent readahead() and
>  	 * source range to serialize with relocation.
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
> -- 
> 2.43.0
> 

