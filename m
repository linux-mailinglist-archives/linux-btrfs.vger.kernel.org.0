Return-Path: <linux-btrfs+bounces-15677-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C170B12426
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 20:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7699AE506D
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 18:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC7E259C84;
	Fri, 25 Jul 2025 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="LS3cAKGB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mwBEVUXb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4DC2561A7
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468604; cv=none; b=FyuF2gGPamVOZgO8mWDWM1/oVjfZnKxn0s52dnQVzobzQzh4r55H9GRU//sp7ZM1AFlhS1TUYqXZZqxIuhKu/CiXPrQP4VKx7Q07+9jplftu36xdoI3gtQkiDIpnBL8D7zDZGbKcBHMAS5xqYyEKt0P7YT+NmvsoCjbD7QXsvZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468604; c=relaxed/simple;
	bh=RQJETPwiLCbMipMTpgwLiZGpcmZD5PJ4TSDXRWhOMAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqmP3A93gLZ78fJgllOkWdMLIAHLAxweYgA8/MsFlR6NHI6upt4FigqH5LBKAhiS3hXxq4mUDV9aAqktXfg+EHPspQcExdIKxzO0IoHFDgrFWnO9n4dOI+Lz1sROK0/lLgmnz4SKP7zhaXG4dJTNqxnhU8X8i6PbNRExwiOOAbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=LS3cAKGB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mwBEVUXb; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 44E471D00340;
	Fri, 25 Jul 2025 14:36:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 25 Jul 2025 14:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753468602; x=1753555002; bh=XqSEGnORlH
	H5m0Dz2l9nV+HyXiLdGyVQUY9R0mcj22g=; b=LS3cAKGBco3ZDFmQ8M6JgaE5Au
	VcRN2ZSwzzO9vs5kt0eWr42LY++b0H/2fYU9gELpvlRpzykBFTXl/qgWSn8yG5hz
	fAgIcE+hG5WOdJI03eU4CN/Cp2we/eocMbYW0dPFxlYTJ6V8hphTqhieZl//PfFt
	m2nSCXwC/dnQO4sf8zbjSs/GvkmnvMN8ySI/rXeFYgv48vvHqNJuDNpW4YjEdXO0
	C8hLNM2Dv773rLEiIHno0WX/cdijhMN3nOGcO13ltzf6lzf6NLcM7HCDcQ0ZcccS
	YZxNzgwaEwaDT1Z7QQSG9H+7kQx8+2mAA5WuRHSLqtvy9peelKXF76yPF1DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753468602; x=1753555002; bh=XqSEGnORlHH5m0Dz2l9nV+HyXiLdGyVQUY9
	R0mcj22g=; b=mwBEVUXbZjgOth2HDzSlrMesVxDRgYQG8P/5wRlMbiau/hOCAZA
	mQo/vy+/rncIcYKPHsahmHK1r/NKIzq7f1NzZikMHXQAgORsTjeOiwNGQGlIEShR
	62sIzXUCrZ6qKBB8lfO2r5nzFcaVLwjXD+u3zovcmov9HlJKMVS6305AACmiSENK
	jKVSvr8UC380ORsYhEQItjJR4xRIEkM2vNV97eFsxfUj51/MY0+8lC8eSuI6ba2m
	pphzuNgZGPAc7zxGuNdizzg1uMvZF1ZkpRN+3ke+ssZo4A1vFUuiqqDB4SBuEg2M
	f1htOUj8dqsl1JGieuvewD/DRGa/R9AFXJw==
X-ME-Sender: <xms:uc6DaCngtwLeZCbrGqO3-VwnCMjzQ-rfyrQGuOdNCnmETLxOjEICpA>
    <xme:uc6DaKA9xMNCmL5mrGHCrujRyezu0bbrgsWB5QuXz6l-gxaI4gxeqk9z6bjq3IVcN
    _zBunZAY-Nh3I1wzXw>
X-ME-Received: <xmr:uc6DaCdGRmH1HHoxQxVOMdI0zfsNNtIX3yqBEMHh2dD032lSU2ZIrxzyUjt3Imwn1G06xBlEVwUZ5k4Jb5eCKc7nyu4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekgedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvke
    ffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    peifqhhusehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:uc6DaFJmrfW7AWR_VkeieSdISppf0iDwaGu6mhhjQzdlatMCmu9QyQ>
    <xmx:uc6DaFco8nHqSy0qcpZPoBYCAKupNdEWKvn2dNF4GvffGQ85AUq5yQ>
    <xmx:uc6DaM0JIpI0zh0_Y3a7WLHJ9IBdum3IUxNmcP0QDjFQoa6c-U_v8w>
    <xmx:uc6DaOhRGk53K5rHWuMwlCh1ovo96jkOJ8dccZQgyQgwJoFd6Eq69A>
    <xmx:us6DaI0qd_YVsaWmhstI2v8OReNEyt6Cvnxcsh3uCb2LtRCz4ZRaxuJF>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 14:36:41 -0400 (EDT)
Date: Fri, 25 Jul 2025 11:37:59 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: enhance error messages for delalloc range
 failure
Message-ID: <20250725183759.GD1649496@zen.localdomain>
References: <cover.1753269601.git.wqu@suse.com>
 <770950dc29a5d621682d80c4069a8cde0e2d629b.1753269601.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <770950dc29a5d621682d80c4069a8cde0e2d629b.1753269601.git.wqu@suse.com>

On Wed, Jul 23, 2025 at 08:51:22PM +0930, Qu Wenruo wrote:
> When running emulated write error tests like generic/475, we can hit
> error messages like this:
> 
>  BTRFS error (device dm-12 state EA): run_delalloc_nocow failed, root=596 inode=264 start=1605632 len=73728: -5
>  BTRFS error (device dm-12 state EA): failed to run delalloc range, root=596 ino=264 folio=1605632 submit_bitmap=0-7 start=1605632 len=73728: -5
> 
> Which is normally buried by direct IO error messages.
> 
> However above error messages are not enough to determine which is the
> real range that caused the error.
> Considering we can have multiple different extents in one delalloc
> range (e.g. some COW extents along with some NOCOW extents), just
> outputting the error at the end of run_delalloc_nocow() is not enough.
> 
> To enhance the error messages:
> 
> - Remove the rate limit on the existing error messages
>   In the generic/475 example, most error messages are from direct IO,
>   not really from the delalloc range.
>   Considering how useful the delalloc range error messages are, we don't
>   want they to be rate limited.
> 
> - Add extra @cur_offset output for cow_file_range()
> - Add extra @cow_start and @cow_end output for run_delalloc_nocow()
>   This is especially important for run_delalloc_nocow(), as there
>   are extra error paths where we can hit error without into
>   nocow_one_range() nor fallback_to_cow().
> 
> - Add an error message for nocow_one_range()
>   That's the missing part.
>   For fallback_to_cow(), we have error message from cow_file_range()
>   already.
> 
> - Constify the @len and @end local variables for nocow_one_range()
>   This makes it much easier to make sure @len and @end are not modified
>   at runtime.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/inode.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 6d9a8d8bea4c..55d42f2b4a86 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1534,10 +1534,11 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  		btrfs_qgroup_free_data(inode, NULL, start + cur_alloc_size,
>  				       end - start - cur_alloc_size + 1, NULL);
>  	}
> -	btrfs_err_rl(fs_info,
> -		     "%s failed, root=%llu inode=%llu start=%llu len=%llu: %d",
> -		     __func__, btrfs_root_id(inode->root),
> -		     btrfs_ino(inode), orig_start, end + 1 - orig_start, ret);
> +	btrfs_err(fs_info,
> +		  "%s failed, root=%llu inode=%llu start=%llu len=%llu cur_offset=%llu cur_alloc_size=%llu: %d",
> +		  __func__, btrfs_root_id(inode->root),
> +		  btrfs_ino(inode), orig_start, end + 1 - orig_start,
> +		  start, cur_alloc_size, ret);
>  	return ret;
>  }
>  
> @@ -1969,8 +1970,8 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
>  			   u64 file_pos, bool is_prealloc)
>  {
>  	struct btrfs_ordered_extent *ordered;
> -	u64 len = nocow_args->file_extent.num_bytes;
> -	u64 end = file_pos + len - 1;
> +	const u64 len = nocow_args->file_extent.num_bytes;
> +	const u64 end = file_pos + len - 1;
>  	int ret = 0;
>  
>  	btrfs_lock_extent(&inode->io_tree, file_pos, end, cached);
> @@ -2017,8 +2018,13 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
>  	 * We do not clear the folio Dirty flags because they are set and
>  	 * cleaered by the caller.
>  	 */
> -	if (ret < 0)
> +	if (ret < 0) {
>  		btrfs_cleanup_ordered_extents(inode, file_pos, len);
> +		btrfs_err(inode->root->fs_info,
> +			  "%s failed, root=%lld inode=%llu start=%llu len=%llu: %d",
> +			  __func__, btrfs_root_id(inode->root), btrfs_ino(inode),
> +			  file_pos, len, ret);
> +	}
>  	return ret;
>  }
>  
> @@ -2304,10 +2310,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  		btrfs_qgroup_free_data(inode, NULL, cur_offset, end - cur_offset + 1, NULL);
>  	}
>  	btrfs_free_path(path);
> -	btrfs_err_rl(fs_info,
> -		     "%s failed, root=%llu inode=%llu start=%llu len=%llu: %d",
> -		     __func__, btrfs_root_id(inode->root),
> -		     btrfs_ino(inode), start, end + 1 - start, ret);
> +	btrfs_err(fs_info,
> +		  "%s failed, root=%llu inode=%llu start=%llu len=%llu cow_start=%lld cow_end=%llu: %d",
> +		  __func__, btrfs_root_id(inode->root), btrfs_ino(inode),
> +		  start, end + 1 - start, cow_start, cow_end, ret);
>  	return ret;
>  }
>  
> -- 
> 2.50.0
> 

