Return-Path: <linux-btrfs+bounces-10803-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDF6A06856
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 23:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB643A1E52
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 22:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B45D204691;
	Wed,  8 Jan 2025 22:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="aOwXh+wN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cV5VHo3M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AC61A01C6
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Jan 2025 22:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736375590; cv=none; b=F8fr10NB8EQ/zXixxrkJvFd7o+Pszve7s5y5UAWY9K67K0SHkRwSuRDCWSybFSJSoKyQNanuD1+6NhCZKgp8iRffa3PCPVEKeOSHfG4dkYuZuLMG5HUEGY3Dld+nDnhOeIvr/t+iIQ+38fbIw+ZAZPYkll5U0b/tTeA8NyQZdCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736375590; c=relaxed/simple;
	bh=igRQnKI4Vt4PqwBJSjUoQdF8dRXc0fFE3PipExEJ5gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHDU9uw5nxx08vxngRsnzsk8mc7bm6Ee5UFCDeTEWmJ8LK1pB4sKQRW8cqcfC3M4YaB+TcqnONuSNoCZe1BXIfhU7Bdlv0WD5w6ZvHu7fKiAc1TSdWKjzX9xR1dy/+CxzUGppI9KRk4IDXc9IHRN1cPDBt1XIJawi0FOluH2N88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=aOwXh+wN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cV5VHo3M; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6124B25400CE;
	Wed,  8 Jan 2025 17:33:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 08 Jan 2025 17:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1736375585; x=1736461985; bh=sXEAig+Fkr
	LhnQM5oJDbKEV6TCAZLziqXeBD9rovCuI=; b=aOwXh+wN77v1b7+xZLcAdPT7LP
	cpdKab/N82BAZhDBYDcbQyso1tyOHnwCTKiqPeyT095xVYa14zVhkxrK9QBuuynY
	Q8T71FnZQen3+3u0IwwxjnaAgx2sC38NyizITSUd8n7oNpx+l+crbpQSsu8fcR/q
	Zb7nTjAUuKHQf57txWI7kpg03hiJ3qRdHMr+mpNHCqK+Tg9BBAzq3HzURoP9z+Ps
	OvQw8izxBz9qszfdtW7un84ZsOtOhQXMJppdWedu3D1Grl6+8q5FG/laVPIoRu3e
	AiRDZ6ebG1Piw2aLxhVXNpH884hShv9c1QbJGCwyZ6dIvW84yujeZp2J2dpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736375585; x=1736461985; bh=sXEAig+FkrLhnQM5oJDbKEV6TCAZLziqXeB
	D9rovCuI=; b=cV5VHo3MVjW3+XQ2e/j/Lvbv9LV6W6BHvh28WWYoL3ZExLDFkrI
	VTChtCEdC65+k4A4KuFmJGNMjAQCyV/P3Piejcrjjo3WKSksdf6G4/fvaTNgxKtA
	NvtJTJIuIuyYErbMdcWTQXwJtK9edknC7jFVphtUzIQSmZuv7GG3oqrLUIqEjRkp
	c+RMIIJtAT7CQ2jPMLI3PFLpDjN020v5oACrzLzs7ofbrJWIphl1//gsRafdDzvG
	cyWodMoZJ5dQEw7w/EA2FWqJS3wQDYC3x29uwclyqgA4rz5gsXodLEtz9cz72MxA
	sj6GJiLSzspLizQtdX330kww8xAx+1150fQ==
X-ME-Sender: <xms:If1-Z1Zu8vCjjhZBra_RKajF1mm32UXNBXud1GxD9Xof-iRyonAoog>
    <xme:If1-Z8ZamPmIQL_05xpL3QMSp5ECj3GJfBbi_swiQLWAXLuSHFDsxIr20hp8162az
    NlqW4T3eDTr2ApHjoE>
X-ME-Received: <xmr:If1-Z3_iVIHyutkDUmxuIsJ0UOOEmafbVF568USTPAn1l_ZqFMZNOl2S8DSny3jmpok8sx8HdGIpURYMAnZZ2eckpGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfg
    uefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprhgtphhtthhope
    hlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:If1-Zzr2mYjQnVekwOND6m8ZZfSlseGoDTekVl8zK3d-E1Fka21JPw>
    <xmx:If1-Zwq3gQKzwam-CrVdii5tFTp_RhXpo31xarF2frqbhVo8r6EFZA>
    <xmx:If1-Z5SHzIUIDJlCsbR8Ydtzx96RGk79D9NINZiB3__wKMRwO7leiw>
    <xmx:If1-Z4pD8oA-QFxb5oQb-NbyRByO7UVYp5kQZx7-mzAdWHDpe_QLjQ>
    <xmx:If1-Z33bpErsyNL8HPPl3Cq14MwOYIVWf5ArSSBAYxAAdzSLFhxawHYF>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 17:33:04 -0500 (EST)
Date: Wed, 8 Jan 2025 14:33:38 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/9] btrfs: fix the error handling of
 submit_uncompressed_range()
Message-ID: <20250108223338.GC1456944@zen.localdomain>
References: <cover.1733983488.git.wqu@suse.com>
 <d1a4d05c0559c7fc1f2b97326ce8b7e4cd43dd29.1733983488.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1a4d05c0559c7fc1f2b97326ce8b7e4cd43dd29.1733983488.git.wqu@suse.com>

On Thu, Dec 12, 2024 at 04:43:57PM +1030, Qu Wenruo wrote:
> [BUG]
> If btrfs failed to compress the range, or can not reserve a large enough
> data extent (e.g. too fragmented free space), btrfs will fall back to
> submit_uncompressed_range().
> 
> But inside submit_uncompressed_range(), run_dealloc_cow() can also fail
> due to -ENOSPC or whatever other errors.
> 
> In that case there are 3 bugs in the error handling:
> 
> 1) Double freeing for the same ordered extent
>    Which can lead to crash due to ordered extent double accounting
> 
> 2) Start/end writeback without updating the subpage writeback bitmap
> 
> 3) Unlock the folio without clear the subpage lock bitmap
> 
> Both bug 2) and 3) will crash the kernel if the btrfs block size is
> smaller than folio size, as the next time the folio get writeback/lock
> updates, subpage will find the bitmap already have the range set,
> triggering an ASSERT().
> 
> [CAUSE]
> Bug 1) happens in the following call chain:
> 
>   submit_uncompressed_range()
>   |- run_dealloc_cow()
>   |  |- cow_file_range()
>   |     |- btrfs_reserve_extent()
>   |        Failed with -ENOSPC or whatever error
>   |
>   |- btrfs_clean_up_ordered_extents()
>   |  |- btrfs_mark_ordered_io_finished()
>   |     Which cleans all the ordered extents in the async_extent range.
>   |
>   |- btrfs_mark_ordered_io_finished()
>      Which cleans the folio range.
> 
> The finished ordered extents may not be immediately removed from the
> ordered io tree, as they are removed inside a work queue.
> 
> So the second btrfs_mark_ordered_io_finished() may find the finished but
> not-yet-removed ordered extents, and double free them.
> 
> Furthermore, the second btrfs_mark_ordered_io_finished() is not subpage
> compatible, as it uses fixed folio_pos() with PAGE_SIZE, which can cover
> other ordered extents.
> 
> Bug 2) and 3) are more straight forward, btrfs just calls folio_unlock(),
> folio_start_writeback() and folio_end_writeback(), other than the helpers
> which handle subpage cases.
> 
> [FIX]
> For bug 1) since the first btrfs_cleanup_ordered_extents() call is
> handling the whole range, we should not do the second
> btrfs_mark_ordered_io_finished() call.
> 
> And for the first btrfs_cleanup_ordered_extents(), we no longer need to
> pass the @locked_page parameter, as we are already in the async extent
> context, thus will never rely on the error handling inside
> btrfs_run_delalloc_range().
> 
> So just let the btrfs_clean_up_ordered_extents() to handle every folio
> equally.
> 
> For bug 2) we should not even call
> folio_start_writeback()/folio_end_writeback() anymore.
> As the error handling protocol, cow_file_range() should clear
> dirty flag and start/finish the writeback for the whole range passed in.
> 
> For bug 3) just change the folio_unlock() to btrfs_folio_end_lock()
> helper.
> 

Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d41bb47d59fb..5ba8d044757b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1129,19 +1129,11 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
>  			       &wbc, false);
>  	wbc_detach_inode(&wbc);
>  	if (ret < 0) {
> -		btrfs_cleanup_ordered_extents(inode, locked_folio,
> +		btrfs_cleanup_ordered_extents(inode, NULL,
>  					      start, end - start + 1);
> -		if (locked_folio) {
> -			const u64 page_start = folio_pos(locked_folio);
> -
> -			folio_start_writeback(locked_folio);
> -			folio_end_writeback(locked_folio);
> -			btrfs_mark_ordered_io_finished(inode, locked_folio,
> -						       page_start, PAGE_SIZE,
> -						       !ret);
> -			mapping_set_error(locked_folio->mapping, ret);
> -			folio_unlock(locked_folio);
> -		}
> +		if (locked_folio)
> +			btrfs_folio_end_lock(inode->root->fs_info, locked_folio,
> +					     start, async_extent->ram_size);
>  	}
>  }
>  
> -- 
> 2.47.1
> 

