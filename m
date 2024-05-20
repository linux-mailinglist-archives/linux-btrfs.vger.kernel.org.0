Return-Path: <linux-btrfs+bounces-5130-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9848CA4C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 00:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35221C20A6F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 22:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF395026E;
	Mon, 20 May 2024 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="BFQYhCkl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j7UBqv46"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0D13D3BC
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245336; cv=none; b=faYuOUU0Qtu10/UjtLyw6hyELWNGheZIWUakDRDUQuRc3H2qc7vib+W8kBhLNWrP1eecgn24IWTMifyGQMQn368U5//owGaujwDQoMYF4z+3uYMKkFWrySla9C4KLRAHNX0ZF32jhWGmKX4dFTIgXFlDnf0g5mCvZUZSlO2BpU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245336; c=relaxed/simple;
	bh=/eXOXHT8atjcQn4fEGV/36JUB98SNmilUZbpEaJSubM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A45WEWIMBqGWw7f9oXF7RVvpCL2bO1J9zk5op3y1CuNCo/GsQTLN2QpT1MPjw2jN797c3XfgL64mhzf2NYuU4+UYOXOZqNMv8pKMFmSv6y2vossR68gERXDP0fa3poBgNvzC2PL90adq/0PB/fu8bbYcszYA3UPRXusNyuKBhyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=BFQYhCkl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j7UBqv46; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 953881800131;
	Mon, 20 May 2024 18:48:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 20 May 2024 18:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1716245333; x=1716331733; bh=dRea0DsTlo
	IkvO6n3difJN432/IqmQnMVPa4uKmKwEc=; b=BFQYhCklgykAG1rdKOIaybE5bQ
	JHa2hzqvdWXP9YoUMY9BmXWm7hiyDUJX/O6A2krREgbjnG6Tj4N+HnjsUa+3TvKw
	i24vG16tYmgwH/lh1fFki/D5aa8RjBUto0FqlIxqm3FrY0nQRZoparmhbSp67/Xb
	25PF/0z3mD+/0C7t+CuZrgSL/81shfeHc0XktTFhThx7E8vyRvn2zooyEAUAK2lE
	GyZqfWehGRcqEj9D6uzBGWKJ7q7exyYBJ5+6tOZGm6sZ+uCASOOuonx/ukeFlKeG
	xpqcAMfFOKYzp0VpIVfCE+epLxrp+UK4uRTWUe1hQZMO0mvNoUucrND8/dhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716245333; x=1716331733; bh=dRea0DsTloIkvO6n3difJN432/Iq
	mQnMVPa4uKmKwEc=; b=j7UBqv46Rs7U+qHb0Pk+szJxPsgT7sCc6eLWC7SAKD0H
	pe7GrsbqBDUfGdi9uNgzzpxneBNBRJcnDcTYrjR5HKB2PwYhJ4ok0Rg1KOnKVjKu
	hFcRuZBsiENACnqMnxwm1FE+aQFzftsIdqXEdGQj8z6fk/h7gwyBRidABmKVU1fc
	DsS8NLvWyLW5XtYvmE6t5wfj36itp9WQFqbC3Cq3NssqFU1N/KGy4p+cPwy65+Tz
	IjCDEOz32x50p5aWwiiesVTF3ePqNDIJVzw8W6z4Y7asJi9rQFXYi4GbmvdwF9CE
	R8FTZtNhXa1XcLV8OjTPPApo/KlMOxlrybYztuxRrQ==
X-ME-Sender: <xms:VdNLZqGrQwaaWbPfK6HzSv_ISeFFmjpQEKnX9wQUZnldshb3HSuYhA>
    <xme:VdNLZrXVZJV_aZBmo2mVk0lT98tw8NDrZSAcNuczWy_zodFZ4X3tVZCCDMm3GqeRp
    D5XELemTtUaS0IdNUs>
X-ME-Received: <xmr:VdNLZkL0KyTtF5dL_n1aEPbureFHiOXHCEa2wiXbtmpvxjFzCkW1QEU0NMiq9vngJgFkdEgEaa6RxLJbKN4QSwGlW4E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiuddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehvdeugfdvheehteetieeiiedvieehhfeitedvledugeetgefhueeitdetlefggfenucff
    ohhmrghinhepshhushgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:VdNLZkG45ZFgVJlXTuSs_DCslkEIHWNzpoUYWnR0upEHfXuFN62eHQ>
    <xmx:VdNLZgWeifiuoKueMxllyZWVsuHFxUn90DaowwoR8jxMxB5xRZiwZg>
    <xmx:VdNLZnNiE_rpF0zEHOFRbGbjMK21i3XeQkPWHNHnZ16nMytPUEt-2g>
    <xmx:VdNLZn3OVdO9D2GRZanEnbfecyKvuBKCM79n-kZsLnWg1jhp-9OTnQ>
    <xmx:VdNLZtiGZjF4DyTiRxTi4clrHXrrzrntUKUuUPoCBgSU2hfo8kaiPhRQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 May 2024 18:48:52 -0400 (EDT)
Date: Mon, 20 May 2024 15:50:51 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 2/2] btrfs: automatically remove the subvolume qgroup
Message-ID: <20240520225051.GB1820897@zen.localdomain>
References: <cover.1715064550.git.wqu@suse.com>
 <90a4ae6ae4be63ef4df3d020707fb7b1ae004634.1715064550.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90a4ae6ae4be63ef4df3d020707fb7b1ae004634.1715064550.git.wqu@suse.com>

On Tue, May 07, 2024 at 04:28:11PM +0930, Qu Wenruo wrote:
> Currently if we fully removed a subvolume (not only unlinked, but fully
> dropped its root item), its qgroup would not be removed.
> 
> Thus we have "btrfs qgroup clear-stale" to handle such 0 level qgroups.
> 
> This patch changes the behavior by automatically removing the qgroup of
> a fully dropped subvolume when possible:
> 
> - Full qgroup but still consistent
>   We can and should remove the qgroup.
>   The qgroup numbers should be 0, without any rsv.
> 
> - Full qgroup but inconsistent
>   Can happen with drop_subtree_threshold feature (skip accounting
>   and mark qgroup inconsistent).
> 
>   We can and should remove the qgroup.
>   Higher level qgroup numbers will be incorrect, but since qgroup
>   is already inconsistent, it should not be a problem.
> 
> - Squota mode
>   This is the special case, we can only drop the qgroup if its numbers
>   are all 0.
> 
>   This would be handled by can_delete_qgroup(), so we only need to check
>   the return value and ignore the -EBUSY error.
> 
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1222847
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/extent-tree.c |  8 ++++++++
>  fs/btrfs/qgroup.c      | 38 ++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/qgroup.h      |  2 ++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 47d48233b592..21e07b698625 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5833,6 +5833,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  	struct btrfs_root_item *root_item = &root->root_item;
>  	struct walk_control *wc;
>  	struct btrfs_key key;
> +	const u64 rootid = btrfs_root_id(root);
>  	int err = 0;
>  	int ret;
>  	int level;
> @@ -6063,6 +6064,13 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
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
> index d89f16366a1c..d894a7e2bf30 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1864,6 +1864,44 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
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
> +	 * Commit current transaction to make sure all the rfer/excl numbers
> +	 * get updated.
> +	 */
> +	trans = btrfs_start_transaction(fs_info->quota_root, 0);
> +	if (IS_ERR(trans))
> +		return PTR_ERR(trans);
> +
> +	ret = btrfs_commit_transaction(trans);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Start new trans to delete the qgroup info and limit items. */
> +	trans = btrfs_start_transaction(fs_info->quota_root, 2);
> +	if (IS_ERR(trans))
> +		return PTR_ERR(trans);
> +	ret = btrfs_remove_qgroup(trans, subvolid);
> +	btrfs_end_transaction(trans);
> +	/*
> +	 * It's squota and the subvolume still has numbers needed
> +	 * for future accounting, in this case we can not delete.
> +	 * Just skip it.
> +	 */

Maybe throw in an ASSERT or WARN or whatever you think is best checking
for squota mode, if we are sure this shouldn't happen for normal qgroup?

> +	if (ret == -EBUSY)
> +		ret = 0;
> +	return ret;
> +}
> +
>  int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
>  		       struct btrfs_qgroup_limit *limit)
>  {
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
> 2.45.0
> 

