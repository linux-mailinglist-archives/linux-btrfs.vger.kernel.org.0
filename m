Return-Path: <linux-btrfs+bounces-4599-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FA68B58F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 14:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C581C2171E
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 12:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB876F072;
	Mon, 29 Apr 2024 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="EghpeuRp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iN2Ly05e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00945C2C6
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394713; cv=none; b=n5v4K5Y0RprweYS/bnlpkLWT5yjDWRI5z6gHF5KzGfffoVHLAr96/9X674NLAx2kqD+RnrBJ/dgv9XM17lSzRRg/qpkuOKkZrI4yi58TxrVGuHGTvYaavCfyk4KJkV3GvZIROfy4uQIw/H3UA1Fw6vV9Ee1WqwQfFXxCv/sHEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394713; c=relaxed/simple;
	bh=xa1xImNAovxtdYNn7PeHK+CnoQk63CxifJ6epAV/hzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REU1J4K3O3vcZ9+UzWrU//BxWiE6Y6DsqgqDdFJEYAkyH3zwc7qpg26Fvx/BVS6CKFoHLeDXhs3N6xniSjbQ/ZdGvaaSuEwMH/94KaRjb/H7tZGLSl9R+W6b6VSlXom66+OrBG5nYROux1bvHtQXSCbRozYB0f/3MFGwiXeAL84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=EghpeuRp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iN2Ly05e; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id D8E011381A3B;
	Mon, 29 Apr 2024 08:45:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 29 Apr 2024 08:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1714394709; x=1714481109; bh=ZVsP3pwsre
	USEyHC01oYjyx3teCg0T9CRGuvB9TsTNU=; b=EghpeuRp6B0EtW61duc1d5dDr9
	JV7XsX9nyjGludvFgdw3nR2kJIZuLxAQWcnCVn0ZZIMjMHv8VBbUb+qb/3TGzlz3
	2Tgt2N8puW3GZhkyEIiLX2cbX0t0djrvi5pAE/46lFPUXf5cfvfTCpzT+Myl0aOB
	stlj9NU/MSDr+QLyhGcUJaC3AWbsyjMrpqgoMw07R/XFLMFCzelnuGO0OdkuzZ3i
	nkYy62nUFX8KOLpIIg8dc1P3RNxxm8ZAF61KlvIZvmMkduIoC4Ev47MmboNVBeB/
	kWHtoTz1nxkksjd98x8uU5DdHtDk0kaEZEqBrBsdCO4uSBuLd0w72XEYOfCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714394709; x=1714481109; bh=ZVsP3pwsreUSEyHC01oYjyx3teCg
	0T9CRGuvB9TsTNU=; b=iN2Ly05el6gI2vFK0FGgCZkVmtmSnIw3BVZ6Gl2qAGow
	NB/ynsamwuVIlYGwWRIZlJ6yc/HC/bf9U+aJ6UuRSDrikuITwXh8dKh3JidMemdj
	O/umsA0xTMP9GeALZ3ddpqpmM4jzfWetHRFQv8GYPBs4ML28A3airRjEmswp3SO3
	mqqBv+NqHq+IM9YQPrgyOf5BJ4K/E8Onqe0NAjEzQyz7dC6yN+ahCbvBsrRKT1K6
	hW0DB6lrff9hNoJPQLAvmOCcF8okV/MudG10hEiPugCf2IVBQJjOHlnq3yLdeKgn
	3WmnLx64JgafpmQkyahUAcU3vOZkOA2p/jGLcy7vNw==
X-ME-Sender: <xms:VZYvZgc0slFjNKYYBjFQMig9yQBBeBkgf6tJYr7uULd2wX90AN9ltw>
    <xme:VZYvZiONCDR1tQ3AbobR7ojdP9JaKz8ES_SKOU8Fos0jr3bdvZ-xDdu6LWDarB_nb
    dzB_wMTVToyhzfefRs>
X-ME-Received: <xmr:VZYvZhjiFURxRJYFuHP6pYZfp6aeHZa3ZLTkXFTJ0I9NyosKolmrjzfwyuj6ALPFtTvGRd_IzKSgMUgUhhcMRQm8yjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduuddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:VZYvZl9Adik0-Ak-UzbUU4P2TVoyV9EsRutWJq3k0XL6hr5B_RFI_g>
    <xmx:VZYvZsuGBtuQUJv293qmDM7nskRCJ2kOp2aAerF5d13-IKXwNyVHNw>
    <xmx:VZYvZsFi7OzFPVEmzsAvet7enzmn8VMkT3J6Cg5Be8YKrsdITfac7g>
    <xmx:VZYvZrMD6Rv3DAfaboszNej23pNP-vHPtcHFakX53-Ke3hc_M_QBSQ>
    <xmx:VZYvZl6CsZZozMoaUd8x5fFtuaCuq2Q_CBiiyLdK1EzQ4N2Qxv7KWckQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 08:45:09 -0400 (EDT)
Date: Mon, 29 Apr 2024 05:47:41 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs: slightly loose the requirement for qgroup
 removal
Message-ID: <20240429124741.GA21573@zen.localdomain>
References: <cover.1713519718.git.wqu@suse.com>
 <3fa525bceeec6096ddd131da98036e07b9947c9c.1713519718.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fa525bceeec6096ddd131da98036e07b9947c9c.1713519718.git.wqu@suse.com>

On Fri, Apr 19, 2024 at 07:16:52PM +0930, Qu Wenruo wrote:
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
> Instead of a strong requirement for zero rfer/excl numbers, just check
> if there is any child for higher level qgroup, and for subvolume qgroups
> check if there is a corresponding subvolume for it.
> 
> For rsv values, do extra warnings, and for rfer/excl numbers, only do the
> warning if we're in full accounting mode and the qgroup is consistent.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/qgroup.c | 69 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 62 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 9a9f84c4d3b8..2ea16a07a7d4 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1736,13 +1736,38 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
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

This was what I originally considered for normal qgroups before observing
that usage is 0 anyway. I didn't know about the drop tree threshold,
my mistake.

With that said, I support this change for non-squota qgroups.

For squota, I think this behavior would be OK, but undesirable, IMO. Any
parent qgroup would still have its usage incremented against the limit,
but it would be impossible to find any information on where it was from.

How do you feel about making this patch add the new logic and make it
conditional on qgroup mode?

Thanks,
Boris

> +	key.objectid = qgroup->qgroupid;
> +	key.type = BTRFS_ROOT_ITEM_KEY;
> +	key.offset = -1ULL;
> +	path = btrfs_alloc_path();
> +	if (!path)
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
> @@ -1764,7 +1789,7 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>  		goto out;
>  	}
>  
> -	if (is_fstree(qgroupid) && qgroup_has_usage(qgroup)) {
> +	if (!can_delete_qgroup(fs_info, qgroup)) {
>  		ret = -EBUSY;
>  		goto out;
>  	}
> @@ -1789,6 +1814,36 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
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

If you go ahead with making it conditional, I would fold this warning
into the check logic. Either way is fine, of course.

>  	del_qgroup_rb(fs_info, qgroupid);
>  	spin_unlock(&fs_info->qgroup_lock);
>  
> -- 
> 2.44.0
> 

