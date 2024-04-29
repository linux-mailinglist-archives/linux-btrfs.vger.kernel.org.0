Return-Path: <linux-btrfs+bounces-4600-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BED258B5937
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 14:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B47C4B28A5E
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 12:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544CC56768;
	Mon, 29 Apr 2024 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="uPY6vWaa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CGr1WMVT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D756537EC
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395318; cv=none; b=CmY6YrkOEDpW8cM5VFtBUeiAt5BcETJCVuF/MohW4pinoUzP2f9P3iiqgePmfEDDGk6blsH4imch/kNwnK5/EHnWrlt7WvNq2zmvW3aRyJpK/XqKUR3Q8IUAOG4mhEISNWNXTFoR2miikLIEYHjGtZ/vVMTo3EKI2+HpLMATq6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395318; c=relaxed/simple;
	bh=k9qeCKFbw68JaGTnBG0GuwVuAKqKZI8erdAUd+Mmpd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2rFXRrjb7GmXAmHs2MQrI2xl9ovkYBhx0LHF2d4FgydYmiEgs3LrbdUNbP6YOggKP4TXDR5SUAnHjtLi+yXgXZQB7uDe8nYvplf5rnN46eCsQ0uiT/826dIF8zQ3jt96IYWkQoepFL+NURU/6a0nIdL8wDk5K4ddqCtg0uKBdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=uPY6vWaa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CGr1WMVT; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 655F31381A36;
	Mon, 29 Apr 2024 08:55:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 29 Apr 2024 08:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1714395315; x=1714481715; bh=XC2WLMPd21
	hEE2KYVqM0R/fxPTqxuR3t9j7vYGBw2Xw=; b=uPY6vWaae0sRy3yRmKC/aLKACn
	nPf/NPQTrYsU5eb8XKZRzxQfKLOhFHdHYV2Gubq087QCm27hM53mUE5ldncqkAPu
	dqFBGTXAUCSUB5RU9NUAUHF/SWJ0OS8Ca8rYzYrAWDkPfG3y+zp+SM/xUiM95wqq
	OKCH6rITlv4mDMFree9VyeYrJSMb5ezn4/gZuXLwci4OwWHtMh6BJ00fCrYlkAPA
	7gLuxZfzet2oyBz4qsyw6AE00YDCNRpWpw/QcxSRTBXK0jqycDAGG592T9E9qJeB
	BL5RwogbOJ0Otelc1M/wvROKWWCCWrfnbUFZUu0pKlGoOSyCki880IMpjLCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714395315; x=1714481715; bh=XC2WLMPd21hEE2KYVqM0R/fxPTqx
	uR3t9j7vYGBw2Xw=; b=CGr1WMVTa5NkhX6iiWP8egNKqNUCmhBPLDRpxp4wyRSF
	Jw/TkOHyT9o9c1KkskXVwVZ8yk4QxVHFlmw61mRnxQlortn7Ggfmb830vPlqZhjC
	DB4coSzkrq/jgE7SBx7gRBPa/vTEMmyEELmN1WYbHVdLnpFV/lU/NYod32LFmVFj
	SJYCMJ5BGRZceNwttQChTcy0UHh8rJwvSDJvix2QXGPW/xGVAU8PplQkCrotfkDa
	+JPnoTOst/CPX5BboNlnHk9hF5JP6ptkqXs2h5brw1LQTzQmUqEMw8v34JvpRxMD
	hrCu/EuylP97Hnh9Zkn0VOFsPeImOowVYD3TNPP9eg==
X-ME-Sender: <xms:spgvZoiTYlzzs7Kn3x-WqndDIUZFoFnUGH0tHKddlgfgFkzDN16i5g>
    <xme:spgvZhAd2x-egk6lGit_C8kct_ZfiKmfOvpBqr0zQA6BPznUg_IeiJOyC_B7uPrJT
    1A4rIMGkaof-su41Sk>
X-ME-Received: <xmr:spgvZgEYiA4-Gqow1J1uR7jgaUUuKC2_OwpNWDcX0kGInRoObVpyn1Fk7RYNVdA36L1rFqGKMGetXEaMfAokq2sXXJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduuddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehvdeugfdvheehteetieeiiedvieehhfeitedvledugeetgefhueeitdetlefggfenucff
    ohhmrghinhepshhushgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:spgvZpSKUrmXOxBlLeAKshWM7wqxYk7Z9pCG5WaCDx5iqjPQ1RoHrg>
    <xmx:spgvZly9WWX7k-aS1eocnqMtEMhGGHVFp_OzUD6zqFziWHORbP578A>
    <xmx:spgvZn7kDKFTpsrFRdiAHyF8uHnGD4VH6YtOjgbUGAqaVYC_Emo_Rw>
    <xmx:spgvZiwPjIIGzN5TgEbqfr7bLN_kCXJmk75CgzCIVN3PIoF3Ft7AKg>
    <xmx:s5gvZg-aRAxxJ0rWoZIty4VHtfcPlkMF-U3aisj__GuwFQJwfgRjMyP4>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 08:55:13 -0400 (EDT)
Date: Mon, 29 Apr 2024 05:57:47 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: automatically remove the subvolume qgroup
Message-ID: <20240429125747.GB21573@zen.localdomain>
References: <cover.1713519718.git.wqu@suse.com>
 <07e54de6747a5bf1e6a422cba80cbb06ba832cf4.1713519718.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07e54de6747a5bf1e6a422cba80cbb06ba832cf4.1713519718.git.wqu@suse.com>

On Fri, Apr 19, 2024 at 07:16:53PM +0930, Qu Wenruo wrote:
> Currently if we fully removed a subvolume (not only unlinked, but fully
> dropped its root item), its qgroup would not be removed.
> 
> Thus we have "btrfs qgroup clear-stale" to handle such 0 level qgroups.
> 
> This patch changes the behavior by automatically removing the qgroup of
> a fully dropped subvolume.
> 
> There is an exception for simple quota, that btrfs_record_squota_delta()
> has to handle missing qgroup case, where the target delta belongs to an
> automatically deleted subvolume.
> In that case since the subvolume is already gone, no need to treat it as
> an error.
> 
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1222847
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent-tree.c |  8 ++++++++
>  fs/btrfs/qgroup.c      | 39 ++++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/qgroup.h      |  2 ++
>  3 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 023920d0d971..1e2caa234146 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5834,6 +5834,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  	struct btrfs_root_item *root_item = &root->root_item;
>  	struct walk_control *wc;
>  	struct btrfs_key key;
> +	const u64 rootid = btrfs_root_id(root);
>  	int err = 0;
>  	int ret;
>  	int level;
> @@ -6064,6 +6065,13 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  	kfree(wc);
>  	btrfs_free_path(path);
>  out:
> +	if (!err && root_dropped) {
> +		ret = btrfs_qgroup_cleanup_dropped_subvolume(fs_info, rootid);
> +		if (ret < 0)
> +			btrfs_warn_rl(fs_info,
> +				      "failed to cleanup qgroup 0/%llu: %d",
> +				      rootid, ret);
> +	}
>  	/*
>  	 * We were an unfinished drop root, check to see if there are any
>  	 * pending, and if not clear and wake up any waiters.
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 2ea16a07a7d4..9aeb740388ab 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1859,6 +1859,39 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>  	return ret;
>  }
>  
> +int btrfs_qgroup_cleanup_dropped_subvolume(struct btrfs_fs_info *fs_info,
> +					   u64 subvolid)
> +{
> +	struct btrfs_trans_handle *trans;
> +	int ret;
> +
> +	if (!is_fstree(subvolid) || !btrfs_qgroup_enabled(fs_info) ||
> +	    !fs_info->quota_root)
> +		return 0;
> +
> +	/*
> +	 * If our qgroup is consistent, commit current transaction to make sure
> +	 * all the rfer/excl numbers get updated to 0 before deleting.
> +	 */
> +	if (!(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)) {
> +		trans = btrfs_start_transaction(fs_info->quota_root, 0);
> +		if (IS_ERR(trans))
> +			return PTR_ERR(trans);
> +
> +		ret = btrfs_commit_transaction(trans);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/* Start new trans to delete the qgroup info and limit items. */
> +	trans = btrfs_start_transaction(fs_info->quota_root, 2);
> +	if (IS_ERR(trans))
> +		return PTR_ERR(trans);
> +	ret = btrfs_remove_qgroup(trans, subvolid);
> +	btrfs_end_transaction(trans);
> +	return ret;
> +}
> +
>  int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
>  		       struct btrfs_qgroup_limit *limit)
>  {
> @@ -4877,7 +4910,11 @@ int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
>  	spin_lock(&fs_info->qgroup_lock);
>  	qgroup = find_qgroup_rb(fs_info, root);
>  	if (!qgroup) {
> -		ret = -ENOENT;
> +		/*
> +		 * The qgroup can be auto deleted by subvolume deleting.
> +		 * In that case do not consider it an error.
> +		 */
> +		ret = 0;

If we call record_squota_delta, that means we are adding an extent to
the tree whose owner ref will point at this subvol. Which means that we
are entering into a case where our on disk accounting disagrees between
qgroup and extent tree. This should fail the squota fsck logic, if you
really trigger it.

How were you hitting this? In some mundane way where the extent actually
gets dropped? I worry that if the extent also picks up a reference in
the same transaction in a way that the owner is the dropped subvol, we
could get into inconsistency. Ideally, the checks on rsv/usage in drop
also prevent that..

>  		goto out;
>  	}
>  
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index 706640be0ec2..3f93856a02e1 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -327,6 +327,8 @@ int btrfs_del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
>  			      u64 dst);
>  int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid);
>  int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid);
> +int btrfs_qgroup_cleanup_dropped_subvolume(struct btrfs_fs_info *fs_info,
> +					   u64 subvolid);
>  int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
>  		       struct btrfs_qgroup_limit *limit);
>  int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info);
> -- 
> 2.44.0
> 

