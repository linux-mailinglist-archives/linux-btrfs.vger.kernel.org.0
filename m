Return-Path: <linux-btrfs+bounces-10806-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B255A068BA
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 23:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44C6B7A24E7
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 22:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22EF19EEBF;
	Wed,  8 Jan 2025 22:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="f7Pyuevd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hhcmxkiv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DB0203713
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Jan 2025 22:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736376399; cv=none; b=LiKA2lniwBvwbpPjEqNVzE9wM+jeuLZ6oA04ZFeDZgbmrTZI1TpVkvFUpkOktbv7x1jJZ5LkwdnGuwA9iAwi5b8ah9S9V8AppahA+B/OQm+u/+nL+Plf0rpPeANOdTLGZm9OY/uEEnVelH5Tp2PvvhwmF7iH9PSM5iOIFwQRg8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736376399; c=relaxed/simple;
	bh=fckhONX7du9iA31TrGWH5VsoSWxRY38LVi/VR1GmmAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLxhR1CSbVjMCf5oO39zzNs5Ugg+EtOyltqwSaYTKpHH6Ncgr1dzAbZmDGVyameZ+Wwsz6ak2zWfcYqJf/7otu++9hBL6jbRZ679YUolqzT6ICsZ64MCrsjy1gAYj41EXoR1xfKZ14vzJrhhxIGjxlH6X9rSI5HdCMxPy8qi3tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=f7Pyuevd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hhcmxkiv; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CCCAB1140185;
	Wed,  8 Jan 2025 17:46:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 08 Jan 2025 17:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1736376396; x=1736462796; bh=p81vXO6aZW
	tu20gdQI7NQxJEeExOx0uSVPjDd2kZ0IU=; b=f7Pyuevd/MVfknPMhlTAOKjopj
	jbuU8uk/xYumuYj0iTtDey23HbNFrOE/SznRur8Q+Ta9tr7fqHJfyDB4oGlFf2DG
	Yt9gEOi60Nx3/4VAWdHZS82lr63geRP4m3vaxGIq+aJCzofEet6Z4jw/qFYG5ll1
	C8ZmtiQaV0v+Ip2UFWiXFVxFMFhXQl3KlhIujJ4PFBpr5H9aVL0LWt0G1mCAtgnQ
	O0iN+Qps3hy2VaBkhSnDHFdTp+cpZTcaXDIJW6JSTNit1ki2JQFnlV4gXSmV3czJ
	QQS1qsqNKQb/DWn/pJoGkRPr2P+TXI+xx9ZiO4URJvnTXny7t7bADc+YQHTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736376396; x=1736462796; bh=p81vXO6aZWtu20gdQI7NQxJEeExOx0uSVPj
	Dd2kZ0IU=; b=hhcmxkivsW4SikHx59lzTlDt9QpfzJN6BVd8GYAqOkjSsFX+CeF
	jWFg0p8u9nnQhvn5dNse7kxLJ2f979ZFfuhBqiaiW1O2dwTWqoG2a+kWFLwoN6dX
	fCOpABVsKMgQYb596hVolhI9P4CgU+7yoxddqdTJREu1rzu1DZhMlw9i8oaWNjoc
	dWuaXZ+lNLIV01AhLcB/God/UQvavi8px9RWk36CLKc3v69p3ji0btPVjpZBcH/S
	Ib9McYyoJa8bokJwKPn6ZhDtiYVli/LUS9xbfsU2YCWTMSxF2YdxDv96TnnR3/65
	CzowtHSISNiHyxZpgjopSjOgnU3iKFGW7JQ==
X-ME-Sender: <xms:TAB_Z--z1-nd46GhlbeVpFckj2jpX4ua28tmqAXRNZ-863HFlQ-e2g>
    <xme:TAB_Z-tyysZ59PcLM1YAzmuB4h8O4rY6V1XGbanf1sr2PoNWQosK_Ur9i4E1ysqbX
    2MeucTeDJxEPgdH4Og>
X-ME-Received: <xmr:TAB_Z0BodjntKFDQPLdydHRO98lUvvy57_yYPzBsrK7ziHnEfIXeaeDgTCJHMFFJ5cOG5v_PbPQhquCMJcygf2H6XWU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeghedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenuc
    ggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeu
    gfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TAB_Z2dP97h5NGhJZHoiUSp5hFqS6NQtzN-UKyLhwsQSp-wM_e1Agg>
    <xmx:TAB_ZzMd27PUgkzMi1MnKGZQy_60lxfzMy9bsBv966pVr5gCJQvopg>
    <xmx:TAB_ZwndcRaW2mv3sw0w5ObcTMsUrkaP9qfpHRiS_skEwwzia7h1JQ>
    <xmx:TAB_Z1vE-t8LwvsLu29qVMXB466bry31IijwqNN4TLEo3gW9KV8IDg>
    <xmx:TAB_Z8Z9i-g8w1GS1sH9naimP01Pz7i5sq3Wr0EVFBcVx6Rxq2BCxE10>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 17:46:36 -0500 (EST)
Date: Wed, 8 Jan 2025 14:47:09 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 8/9] btrfs: add extra error messages for delalloc
 range related errors
Message-ID: <20250108224709.GF1456944@zen.localdomain>
References: <cover.1733983488.git.wqu@suse.com>
 <68c6ef2938e3c55d4b3610744dd378d9441bf91a.1733983488.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68c6ef2938e3c55d4b3610744dd378d9441bf91a.1733983488.git.wqu@suse.com>

On Thu, Dec 12, 2024 at 04:44:02PM +1030, Qu Wenruo wrote:
> All the error handling bugs I hit so far are all -ENOSPC from either:
> 
> - cow_file_range()
> - run_delalloc_nocow()
> - submit_uncompressed_range()
> 
> Previously when those functions failed, there is no error message at
> all, making the debugging much harder.
> 
> So here we introduce extra error messages for:
> 
> - cow_file_range()
> - run_delalloc_nocow()
> - submit_uncompressed_range()
> - writepage_delalloc() when btrfs_run_delalloc_range() failed
> - extent_writepage() when extent_writepage_io() failed
> 
> One example of the new debug error messages is the following one:
> 
>  run fstests generic/750 at 2024-12-08 12:41:41
>  BTRFS: device fsid 461b25f5-e240-4543-8deb-e7c2bd01a6d3 devid 1 transid 8 /dev/mapper/test-scratch1 (253:4) scanned by mount (2436600)
>  BTRFS info (device dm-4): first mount of filesystem 461b25f5-e240-4543-8deb-e7c2bd01a6d3
>  BTRFS info (device dm-4): using crc32c (crc32c-arm64) checksum algorithm
>  BTRFS info (device dm-4): forcing free space tree for sector size 4096 with page size 65536
>  BTRFS info (device dm-4): using free-space-tree
>  BTRFS warning (device dm-4): read-write for sector size 4096 with page size 65536 is experimental
>  BTRFS info (device dm-4): checking UUID tree
>  BTRFS error (device dm-4): cow_file_range failed, root=363 inode=412 start=503808 len=98304: -28
>  BTRFS error (device dm-4): run_delalloc_nocow failed, root=363 inode=412 start=503808 len=98304: -28
>  BTRFS error (device dm-4): failed to run delalloc range, root=363 ino=412 folio=458752 submit_bitmap=11-15 start=503808 len=98304: -28

This looks great, thanks. Curious to see how much this shows up in our
prod :)

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Which shows an error from cow_file_range() which is called inside a
> nocow write attempt, along with the extra bitmap from
> writepage_delalloc().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 16 ++++++++++++++++
>  fs/btrfs/inode.c     | 14 +++++++++++++-
>  fs/btrfs/subpage.c   |  3 ++-
>  3 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index b6a4f1765b4c..f4fb1fb3454a 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1254,6 +1254,15 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
>  						       wbc);
>  			if (ret >= 0)
>  				last_finished = found_start + found_len;
> +			if (unlikely(ret < 0))
> +				btrfs_err_rl(fs_info,
> +"failed to run delalloc range, root=%lld ino=%llu folio=%llu submit_bitmap=%*pbl start=%llu len=%u: %d",
> +					     inode->root->root_key.objectid,
> +					     btrfs_ino(inode),
> +					     folio_pos(folio),
> +					     fs_info->sectors_per_page,
> +					     &bio_ctrl->submit_bitmap,
> +					     found_start, found_len, ret);
>  		} else {
>  			/*
>  			 * We've hit an error during previous delalloc range,
> @@ -1546,6 +1555,13 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
>  				  PAGE_SIZE, bio_ctrl, i_size);
>  	if (ret == 1)
>  		return 0;
> +	if (ret < 0)
> +		btrfs_err_rl(fs_info,
> +"failed to submit blocks, root=%lld inode=%llu folio=%llu submit_bitmap=%*pbl: %d",
> +			     BTRFS_I(inode)->root->root_key.objectid,
> +			     btrfs_ino(BTRFS_I(inode)),
> +			     folio_pos(folio), fs_info->sectors_per_page,
> +			     &bio_ctrl->submit_bitmap, ret);
>  
>  	bio_ctrl->wbc->nr_to_write--;
>  
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index bae8aceb3eae..a88cba85bf40 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1134,6 +1134,10 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
>  		if (locked_folio)
>  			btrfs_folio_end_lock(inode->root->fs_info, locked_folio,
>  					     start, async_extent->ram_size);
> +		btrfs_err_rl(inode->root->fs_info,
> +		"%s failed, root=%llu inode=%llu start=%llu len=%llu: %d",
> +			     __func__, btrfs_root_id(inode->root),
> +			     btrfs_ino(inode), start, async_extent->ram_size, ret);
>  	}
>  }
>  
> @@ -1246,7 +1250,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
>  	free_async_extent_pages(async_extent);
>  	if (async_chunk->blkcg_css)
>  		kthread_associate_blkcg(NULL);
> -	btrfs_debug(fs_info,
> +	btrfs_debug_rl(fs_info,
>  "async extent submission failed root=%lld inode=%llu start=%llu len=%llu ret=%d",
>  		    btrfs_root_id(root), btrfs_ino(inode), start,
>  		    async_extent->ram_size, ret);
> @@ -1580,6 +1584,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  		btrfs_qgroup_free_data(inode, NULL, start + cur_alloc_size,
>  				       end - start - cur_alloc_size + 1, NULL);
>  	}
> +	btrfs_err_rl(fs_info,
> +		     "%s failed, root=%llu inode=%llu start=%llu len=%llu: %d",
> +		     __func__, btrfs_root_id(inode->root),
> +		     btrfs_ino(inode), orig_start, end + 1 - orig_start, ret);
>  	return ret;
>  }
>  
> @@ -2325,6 +2333,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  		btrfs_qgroup_free_data(inode, NULL, cur_offset, end - cur_offset + 1, NULL);
>  	}
>  	btrfs_free_path(path);
> +	btrfs_err_rl(fs_info,
> +		     "%s failed, root=%llu inode=%llu start=%llu len=%llu: %d",
> +		     __func__, btrfs_root_id(inode->root),
> +		     btrfs_ino(inode), start, end + 1 - start, ret);
>  	return ret;
>  }
>  
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index d692bc34a3af..7f47bc61389c 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -652,7 +652,7 @@ IMPLEMENT_BTRFS_PAGE_OPS(checked, folio_set_checked, folio_clear_checked,
>  									\
>  	GET_SUBPAGE_BITMAP(subpage, fs_info, name, &bitmap);		\
>  	btrfs_warn(fs_info,						\
> -	"dumpping bitmap start=%llu len=%u folio=%llu" #name "_bitmap=%*pbl", \
> +	"dumpping bitmap start=%llu len=%u folio=%llu " #name "_bitmap=%*pbl", \
>  		   start, len, folio_pos(folio),			\
>  		   fs_info->sectors_per_page, &bitmap);			\
>  }
> @@ -717,6 +717,7 @@ void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
>  	/* Target range should not yet be locked. */
>  	if (unlikely(!bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits))) {
>  		subpage_dump_bitmap(fs_info, folio, locked, start, len);
> +		btrfs_warn(fs_info, "nr_locked=%u\n", atomic_read(&subpage->nr_locked));
>  		ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
>  	}
>  	bitmap_set(subpage->bitmaps, start_bit, nbits);
> -- 
> 2.47.1
> 

