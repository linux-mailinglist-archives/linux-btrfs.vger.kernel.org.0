Return-Path: <linux-btrfs+bounces-13814-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4626DAAEEBC
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 00:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A0C1BA7A39
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 22:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E755820CCFB;
	Wed,  7 May 2025 22:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="suULzede";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cRw9Js0o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F648BF8
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 22:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746657188; cv=none; b=cN9vQ4e+txKFDJnyJQAe0Zwk8stTAjvW8JbwnOX7gAHJNiYKG5wGLyHMEQWm8FelfBja+UmIBIIkVAWf15inE/KxtUW1i4LFGQBIxdYtlEk5PxXeBo9jXBob2vs8vlZLW2kQn/e7w7RyjW8e9tG+93rHnXGBQGUM4kxfHd8qsxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746657188; c=relaxed/simple;
	bh=Bz/GZ+nVFkrICerra7ftbd51u+Ehn/YbSD3+HvAM7B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcVMNUROzS+RhO3WBaD8GKVbHAD/V8BFOqNfSb4xaefKq+L/YAUDCUBVRPdm04E8GpdcH5GHHzSTGxmarABM1jsGInoHNrIxl9RhRol2zoPoD7wfCAeJ/KsQIIeB42EZlSmRnaIgn6Osgt7ZCxyLM244Wr4E3Er8SZZa2Z3VnD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=suULzede; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cRw9Js0o; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 79D7411400BC;
	Wed,  7 May 2025 18:33:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 07 May 2025 18:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1746657185; x=1746743585; bh=SaUEtiCtYH
	rXSwQ9rPtNmsrl6sn27SwHoiFutxYvxgQ=; b=suULzedeFaPZsyMA/15GGj10JT
	TR6aeEJU4k+kKBciAXY5TRwXpwrRc3UZxCxHzwH+xOJoNBpRcm8t9b2C2uPkryGe
	WOpeX/kpfLyleDs3Dk0ojnNVoTB21fVepXNpCukQkzLfKi8WXCqT/HTlgNPhWIN7
	qOVLZhQcJOyvUVUJc8VzrsrujZOguGQdw4SDrLPHO3YDHVkkkZcHJCAcSRkFPphf
	tIQYpqOcF+FQVySNrl3k5/wEp52757HM41ajG0YpdruDMwQQutg16Qqk+wiv+H3z
	pK442howXPhITL2xHCM9jgStQLcqQSpwbMdU+9mWLuWuQEcD01q66MrFr9sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746657185; x=1746743585; bh=SaUEtiCtYHrXSwQ9rPtNmsrl6sn27SwHoiF
	utxYvxgQ=; b=cRw9Js0oT4tzxvnxJ/pIl58NWvvSns2eeLx39i5DdGF++fsgFuk
	8a+l9nDfMwNkZGQH0F2gd+jYEMiV/eEY+v6na3/ISo7nqvJoPS41vOQ4xCxvFNZQ
	UfNoDzVdu/QBG6MddgCNUl4fksZq2pmb+1ClyFOxe+jZQruVwq8cmwy7Q4k3jiyn
	WSru2H3bJ4y5FI0z+mz61xQ44jZ/mnr9ssm4ffMotkkNA4qHDjGkgMTSBki3XEtF
	1fE+ZO6jQfv1NfgZajd5zsHd2sG1CjAcyATgqPsf1HhUS48uKWpAFsfoJXKCHYjk
	z0zX52vLK0n+M5xWC5m3dK7Hs1iH2sUg54g==
X-ME-Sender: <xms:od8baKxk6lfKri3SyCvC4L7enWue8FAETaUS5UdYJjhqHiAxTboOVQ>
    <xme:od8baGSBxUOididzAqThYwPch7Tptak5hicZx3WDaMVMxFLqAVyDfL42ceg7hY37h
    eN7xJMSdyq2AogbF5M>
X-ME-Received: <xmr:od8baMVH6ETIvqm4laE4MKarrpGt_36eD5NxB84PMEveWc5OfMea5t8AIeiaMg75khc6uyTQ703FroWEumTSEtoi3HI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeektdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhho
    vhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeelle
    fhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfughm
    rghnrghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:od8baAj54EvNbTizj3T39rQL3Wvr4LsquKFe7m_IMRWpwaYfPddwrg>
    <xmx:od8baMD8Ki5gEXTibRna7ckUTzjIV-18TqRDWRyctQaalLof-17ZBg>
    <xmx:od8baBK6SEkh3Y_4EY6K9eScCqhO4Fwo2Q85mrrUe4i6dAfclTUt3g>
    <xmx:od8baDD3WCLZ9gTQS-twVQGqyupjMpHmJEk8HlECOAFesK5QewTrpg>
    <xmx:od8baFu4oZawh9Pg5HWF7T1TVynZiyrtWJjy44zmxWLYY6mqeVTlN4eQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 18:33:04 -0400 (EDT)
Date: Wed, 7 May 2025 15:33:47 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/5] btrfs: fix qgroup reservation leak on failure to
 allocate ordered extent
Message-ID: <20250507223347.GB332956@zen.localdomain>
References: <cover.1746638347.git.fdmanana@suse.com>
 <b2b4a73fb7ef395f131884cd5c903cbf92517e6f.1746638347.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2b4a73fb7ef395f131884cd5c903cbf92517e6f.1746638347.git.fdmanana@suse.com>

On Wed, May 07, 2025 at 06:23:13PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we fail to allocate an ordered extent for a COW write we end up leaking
> a qgroup data reservation since we called btrfs_qgroup_release_data() but
> we didn't call btrfs_qgroup_free_refroot() (which would happen when
> running the respective data delayed ref created by ordered extent
> completion or when finishing the ordered extent in case an error happened).
> 
> So make sure we call btrfs_qgroup_free_refroot() if we fail to allocate an
> ordered extent for a COW write.

I haven't tried it myself yet, but I believe that this patch will double
free reservation from the qgroup when this case occurs.

Can you share the context where you saw this bug? Have you run fstests
with qgroups or squotas enabled? I think this should show pretty quickly
in generic/475 with qgroups on.

Consider, for example, the following execution of the dio case:

btrfs_dio_iomap_begin
  btrfs_check_data_free_space // reserves the data into `reserved`, sets dio_data->data_space_reserved
  btrfs_get_blocks_direct_write
    btrfs_create_dio_extent
      btrfs_alloc_ordered_extent
        alloc_ordered_extent // fails and frees refroot, reserved is "wrong" now.
      // error propagates up
    // error propagates up via PTR_ERR

which brings us to the code:
if (ret < 0)
        goto unlock_err;
...
unlock_err:
...
if (dio_data->data_space_reserved) {
        btrfs_free_reserved_data_space()
}

so the execution continues...

btrfs_free_reserved_data_space
  btrfs_qgroup_free_data
    __btrfs_qgroup_release_data
      qgroup_free_reserved_data
        btrfs_qgroup_free_refroot

This will result in a underflow of the reservation once everything
outstanding gets released.

Furthermore, raw calls to free_refroot in cases where we have a reserved
changeset make me worried, because they will run afoul of races with
multiple threads touching the various bits. I don't see the bugs here,
but the reservation lifetime is really tricky so I wouldn't be surprised
if something like that was wrong too.

As of the last time I looked at this, I think cow_file_range handles
this correctly as well. Looking really quickly now, it looks like maybe
submit_one_async_extent() might not do a qgroup free, but I'm not sure
where the corresponding reservation is coming from.

I think if you have indeed found a different codepath that makes a data
reservation but doesn't release the qgroup part when allocating the
ordered extent fails, then the fastest path to a fix is to do that at
the same level as where it calls btrfs_check_data_free_space or (however
it gets the reservation), as is currently done by the main
ordered_extent allocation paths. With async_extent, we might need to
plumb through the reserved extent changeset through the async chunk to
do it perfectly...

Thanks,
Boris

> 
> Fixes: 7dbeaad0af7d ("btrfs: change timing for qgroup reserved space for ordered extents to fix reserved space leak")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/ordered-data.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index ae49f87b27e8..e44d3dd17caf 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -153,9 +153,10 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
>  	struct btrfs_ordered_extent *entry;
>  	int ret;
>  	u64 qgroup_rsv = 0;
> +	const bool is_nocow = (flags &
> +	       ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC)));
>  
> -	if (flags &
> -	    ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC))) {
> +	if (is_nocow) {
>  		/* For nocow write, we can release the qgroup rsv right now */
>  		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes, &qgroup_rsv);
>  		if (ret < 0)
> @@ -170,8 +171,13 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
>  			return ERR_PTR(ret);
>  	}
>  	entry = kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
> -	if (!entry)
> +	if (!entry) {
> +		if (!is_nocow)
> +			btrfs_qgroup_free_refroot(inode->root->fs_info,
> +						  btrfs_root_id(inode->root),
> +						  qgroup_rsv, BTRFS_QGROUP_RSV_DATA);
>  		return ERR_PTR(-ENOMEM);
> +	}
>  
>  	entry->file_offset = file_offset;
>  	entry->num_bytes = num_bytes;
> -- 
> 2.47.2
> 

