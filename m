Return-Path: <linux-btrfs+bounces-5129-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 817BB8CA48F
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 00:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3385C282204
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 22:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4334F897;
	Mon, 20 May 2024 22:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="4bQmSiOg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DGE/C9v+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732FC374D9
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245080; cv=none; b=kUFC52erE+GX75XkazTJ6YD8ZRipF8jf5SsqIPktwyP2PKb+s/bQKsW2IMmH65VggN7G+WBXFVxkirdtCCt2DdPEU5ZPb9/UXw83CdneNOyS7RCmx953SjWjjjmJiYDWkj7ObPoT8oY72EK72YqP8U42qCoRhZ5dvel6O8XnPYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245080; c=relaxed/simple;
	bh=TiMihOZ5oaC4dq2qH90IcE2ii8u4UE1a443abOxgk7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ch7DwQeLg2FKaBjExSft5EuteI4+TbzUAOAOJUY49WsP6bsl6i3GzAfiW22MEU+XydKpyv8zQUoK6b5eUQGW9XdkWW2p12v081Skvtevl0oAWR6DpNPqdMyHm92U+9RpK1jC9ajPJrUANMCu9gHGVWbVArsVWLWSpOiHN1kpCfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=4bQmSiOg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DGE/C9v+; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 842C51C000E9;
	Mon, 20 May 2024 18:44:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 20 May 2024 18:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1716245077; x=1716331477; bh=ibj8Q15E8Q
	WZGVTv2tBBoaihbglApjLU2NMvLRqQjJQ=; b=4bQmSiOg1j0n+o1K4llbbbV0IV
	w2/bLZ3+BWAEKCjlGXzg12hIIw6GETVVY40+WRN9MmUDISFCfSN6rMLZiKVI4Yvd
	0dIBOBshi0J5ghfz9yiDx1aWvfeNeAr9rNMcQ3xJMSJ75Tg1dOQIUz+vIQ19LAv4
	Rs/3VknQfyWOYipwfQYk0dwdoLCA9Htdc2xMWlE7ac5y0cnE8SBl+GWVYljLpVnh
	bgQ376atxg4BIrdkFsCLi9ih+N9QAxpV8DcBOrCVB//j8XzttfKNB/5rj6/ag0hZ
	sql1mTPf+uMnKltT4aTjeP2Maum1XUifO1EIDeNrG1xLUOV5kJF6TIWSwpew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716245077; x=1716331477; bh=ibj8Q15E8QWZGVTv2tBBoaihbglA
	pjLU2NMvLRqQjJQ=; b=DGE/C9v+og9wFrfGNU6SRqRU+Mk2P8fZyr+qoHRH9IkA
	VcsWeGQ68YufgPHxQK8DTiLKkDHjKJ9pxI4zs+7x/p1GN6grhkslcxTi9l/vBKXv
	oh8EpBYRwIJzvsVkZTjjVM5MYp7sgSZe/4YMSbDvZuiV78+D++j5RXLKuCjuiei2
	I1H1lRYTsPPkiOF9e1935atXdfmY6MTvE0mycFcGGWz0uHQGoXBC5tkVOdgev1DS
	lWT36/4gsh/0F0YJjFJOStfI4L2pGfFvrIZSE0+p2xP2W7wjZg15op9n/cTAdXsP
	+h2YkyfhvM9q1/CLInpPvmpTSCxuRrAUg4D1enHIAw==
X-ME-Sender: <xms:VNJLZh-tJoUwdTxIXmSL21GN89ttYRYy6mgvCDfnu79AEVxOmCIZpw>
    <xme:VNJLZlusizNyhnVion7jDfVcOw5BSUMj-Su-HkhzS14M_EEpVNz3HfSpZ_B4OMtiE
    77vjmWz7R4vkjinS40>
X-ME-Received: <xmr:VNJLZvB8ljRmOXe09UcSXCjSgSCatNP80Hybb2duyAMV8CeZJTqlQG-JpfRrN-r9Jr-dKM2XwBNLAv5-p0DpZ_xixFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:VNJLZlc-diogKqxh_gU3ZMZmnUVq5UyHC5I2t8KreS65IWdvPuZMaA>
    <xmx:VNJLZmN50naWW3GpP_-e15bpekYHUgVATmV9ZBcexuVQFXLlhk3jEg>
    <xmx:VNJLZnk91_LU_1-oNR-f62xOkhxFn7Rt8rbO5kZ6n1Yz5SEo5onPkQ>
    <xmx:VNJLZgt0CdNCgVmCiA2Z1Q4zTmOhopaa2RsjUoJ8Lm4PzndsAM7X8Q>
    <xmx:VdJLZvYvoM8RTkvXo9QhmrM3pw8thTq-S3VqQOXEMtLs8rwyovksUeRs>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 May 2024 18:44:36 -0400 (EDT)
Date: Mon, 20 May 2024 15:46:34 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/2] btrfs: slightly loose the requirement for qgroup
 removal
Message-ID: <20240520224634.GA1820897@zen.localdomain>
References: <cover.1715064550.git.wqu@suse.com>
 <16337d00a7946336cd742573327c8714db278331.1715064550.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16337d00a7946336cd742573327c8714db278331.1715064550.git.wqu@suse.com>

On Tue, May 07, 2024 at 04:28:10PM +0930, Qu Wenruo wrote:
> [BUG]
> Currently if one is utilizing "qgroups/drop_subtree_threshold" sysfs,
> and a snapshot with level higher than that value is dropped, btrfs will
> not be able to delete the qgroup until next qgroup rescan:
> 
>   uuid=ffffffff-eeee-dddd-cccc-000000000000
> 
>   wipefs -fa $dev
>   mkfs.btrfs -f $dev -O quota -s 4k -n 4k -U $uuid
>   mount $dev $mnt
> 
>   btrfs subvolume create $mnt/subv1/
>   for (( i = 0; i < 1024; i++ )); do
>   	xfs_io -f -c "pwrite 0 2k" $mnt/subv1/file_$i > /dev/null
>   done
>   sync
>   btrfs subv snapshot $mnt/subv1 $mnt/snapshot
>   btrfs quota enable $mnt
>   btrfs quota rescan -w $mnt
>   sync
>   echo 1 > /sys/fs/btrfs/$uuid/qgroups/drop_subtree_threshold
>   btrfs subvolume delete $mnt/snapshot
>   btrfs subv sync $mnt
>   btrfs qgroup show -prce --sync $mnt
>   btrfs qgroup destroy 0/257 $mnt
>   umount $mnt
> 
> The final qgroup removal would fail with the following error:
> 
>   ERROR: unable to destroy quota group: Device or resource busy
> 
> [CAUSE]
> The above script would generate a subvolume of level 2, then snapshot
> it, enable qgroup, set the drop_subtree_threshold, then drop the
> snapshot.
> 
> Since the subvolume drop would meet the threshold, qgroup would be
> marked inconsistent and skip accounting to avoid hanging the system at
> transaction commit.
> 
> But currently we do not allow a qgroup with any rfer/excl numbers to be
> dropped, and this is not really compatible with the new
> drop_subtree_threshold behavior.
> 
> [FIX]
> Only require the strong zero rfer/excl/rfer_cmpr/excl_cmpr for squota
> mode.
> This is due to the fact that squota can never go inconsistent, and it
> can have dropped subvolume but with non-zero qgroup numbers for future
> accounting.
> 
> For full qgroup mode, we only check if there is a subvolume for it.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Sorry, I got dragged into other stuff and didn't get around to reviewing
this. LGTM!

Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/qgroup.c | 82 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 75 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index eb28141d5c37..d89f16366a1c 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1728,13 +1728,51 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>  	return ret;
>  }
>  
> -static bool qgroup_has_usage(struct btrfs_qgroup *qgroup)
> +static bool can_delete_qgroup(struct btrfs_fs_info *fs_info,
> +			      struct btrfs_qgroup *qgroup)
>  {
> -	return (qgroup->rfer > 0 || qgroup->rfer_cmpr > 0 ||
> -		qgroup->excl > 0 || qgroup->excl_cmpr > 0 ||
> -		qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] > 0 ||
> -		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] > 0 ||
> -		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS] > 0);
> +	struct btrfs_key key;
> +	struct btrfs_path *path;
> +	int ret;
> +
> +	/*
> +	 * Squota would never be inconsistent, but there can still be
> +	 * case where a dropped subvolume still has qgroup numbers, and
> +	 * squota relies on such qgroup for future accounting.
> +	 *
> +	 * So for squota, do not allow dropping any non-zero qgroup.
> +	 */
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE) {

nit: you can chain this condition with an and rather than a nested if.

> +		if (qgroup->rfer || qgroup->excl || qgroup->excl_cmpr ||
> +		    qgroup->rfer_cmpr)
> +			return false;
> +	}
> +
> +	/* For higher level qgroup, we can only delete it if it has no child. */
> +	if (btrfs_qgroup_level(qgroup->qgroupid)) {
> +		if (!list_empty(&qgroup->members))
> +			return false;
> +		return true;
> +	}
> +
> +	/*
> +	 * For level-0 qgroups, we can only delete it if it has no subvolume
> +	 * for it.
> +	 * This means even a subvolume is unlinked but not yet fully dropped,
> +	 * we can not delete the qgroup.
> +	 */
> +	key.objectid = qgroup->qgroupid;
> +	key.type = BTRFS_ROOT_ITEM_KEY;
> +	key.offset = -1ULL;
> +	path = btrfs_alloc_path();
> +	if (!path)

I suppose ideally this should be ENOMEM, not false => EBUSY

> +		return false;
> +
> +	ret = btrfs_find_root(fs_info->tree_root, &key, path, NULL, NULL);
> +	btrfs_free_path(path);
> +	if (ret > 0)
> +		return true;
> +	return false;
>  }
>  
>  int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
> @@ -1756,7 +1794,7 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>  		goto out;
>  	}
>  
> -	if (is_fstree(qgroupid) && qgroup_has_usage(qgroup)) {
> +	if (!can_delete_qgroup(fs_info, qgroup)) {
>  		ret = -EBUSY;
>  		goto out;
>  	}
> @@ -1781,6 +1819,36 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>  	}
>  
>  	spin_lock(&fs_info->qgroup_lock);
> +	/*
> +	 * Warn on reserved space. The subvolume should has no child nor
> +	 * corresponding subvolume.
> +	 * Thus its reserved space should all be zero, no matter if qgroup
> +	 * is consistent or the mode.
> +	 */
> +	WARN_ON(qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] ||
> +		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] ||
> +		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS]);
> +	/*
> +	 * The same for rfer/excl numbers, but that's only if our qgroup is
> +	 * consistent and if it's in regular qgroup mode.
> +	 * For simple mode it's not as accurate thus we can hit non-zero values
> +	 * very frequently.
> +	 */
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_FULL &&
> +	    !(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)) {
> +		if (WARN_ON(qgroup->rfer || qgroup->excl ||
> +			    qgroup->rfer_cmpr || qgroup->excl_cmpr)) {
> +			btrfs_warn_rl(fs_info,
> +"to be deleted qgroup %u/%llu has non-zero numbers, rfer %llu rfer_cmpr %llu excl %llu excl_cmpr %llu",
> +				      btrfs_qgroup_level(qgroup->qgroupid),
> +				      btrfs_qgroup_subvolid(qgroup->qgroupid),
> +				      qgroup->rfer,
> +				      qgroup->rfer_cmpr,
> +				      qgroup->excl,
> +				      qgroup->excl_cmpr);
> +			qgroup_mark_inconsistent(fs_info);
> +		}
> +	}
>  	del_qgroup_rb(fs_info, qgroupid);
>  	spin_unlock(&fs_info->qgroup_lock);
>  
> -- 
> 2.45.0
> 

