Return-Path: <linux-btrfs+bounces-19166-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 98911C71698
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 00:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9020034377D
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 23:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E3D2DEA9B;
	Wed, 19 Nov 2025 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="JbB1dToM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="axq6NSBx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCDF244684
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763593404; cv=none; b=Ax2V2oafAo43adKEuiD7pD8P4M4pvYT/rgnF72A4vd88Nd6NuX2vlHEmD4gpkCIVqUSCbpc8v+UGeHqVoNjyrnbmQ8NRXoaEjF3qG9l1qjyoNEVe7tyXULyBj3VImwd9ZLYDsoPvhw0BhjpXBSfZ+ng11geW3TRe2W5KIrCNCIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763593404; c=relaxed/simple;
	bh=VIH+u95kL3gr99RKxUftzVgob6GEMe5MH1FWoebdTN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEdhLcEVN5og7ztGnSnx/uWLSz0TFma+89g5Hszz3O4+6kia28LsvvUio2szg/d4BbDby3P8ZnoORd37GMy0QXuMVDs70XfAQ/LrFNUEBwnjajwcI0gHGfXKcH6zo/hGJPaCwWWRYPwItz/E5rCUgkbWWWwx5tb8jJmEuOlZm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=JbB1dToM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=axq6NSBx; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C9F7AEC01BF;
	Wed, 19 Nov 2025 18:03:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 19 Nov 2025 18:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1763593401; x=1763679801; bh=7tgtl9VN7M
	YUmjT9R1Ji8YgoJkgUWmZl+N/b2ea/LxM=; b=JbB1dToM3z8Pa/qM9PgLORh3s9
	qum5/ppsGbO4JSKDWCDwbOrexxoB9MGoNigreH/HYVigGO9QQ7dUhnHEdxGVCLvJ
	spZfPof3xG6JB4VtNPn2GKsxWuG2wHEyR2rDYZ3V88+6DVysRpFqTTcMbn4opK6m
	DF4U7mPp4WqoL8MwFPjhiaYGc1dkA9WOCLz1H/+MnbwVHQz923qoUfqGfnk2DSvg
	mlISYoOMUn3KquM2pprAIDF522dlveMO7+oHEkLXFRMOf+7hbyX3U9Vll77lEOI3
	74sUMPD4dSE/4duZxoPp9fiBaXcTDHVlE0cNS/Sd2XeTgya6CNk1DxmU7lFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763593401; x=1763679801; bh=7tgtl9VN7MYUmjT9R1Ji8YgoJkgUWmZl+N/
	b2ea/LxM=; b=axq6NSBx4IdMbEZEd6ROZDIKlVug4MI9SQRsT/hJwB902r+Pl97
	lQhdQ8PBJdVOw6h8qMnMQzbpxMM0qgnastcgfLXxGbXLpekcL1AhaXPwPl/9bij/
	YphpcWpX8D7HAoJ6O9ib+MNDYStJgAUkR2asKLsFhL58IcF24gn9pSX2GNlbmkQZ
	lMqwKinO+fWLHLX4gKSojMvaPV5UCu4mzgUhg/8fqWqU/tDMVPub/puJPB333va2
	lRFyonsJnbDPG2hnDao2zwQdYQv3eSn3qMUoiQ5ARiBe2SbcowxeIlTVj+lPOSlG
	R9JUQeNHhfhgLt8rHGBqe/igTYWP88UiAHQ==
X-ME-Sender: <xms:uUweafkixWnLLKhmFBIh6TB-bIuU9GUg4NP-5nkliznoi6ZuDS-QNQ>
    <xme:uUweaY05eyodgqX9x5J79wI2OLC0ngHvfPrytYd9WTjukN5niVgurjMn0_xyjsKWY
    HdvwV91DtJcE2aSB77OVu15f32QKBxLJ08kf40qk1P-tMyaUtzoVXQ>
X-ME-Received: <xmr:uUweaTQlcVRIOAXC77DTWUa8mW3QicjFMLnQBKu4SYzcgbLzNQcqWWfH7o9LDI3yKRCU7oLefcVPIbapxoeeZjQWjQE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeehtd
    fhvefghfdtvefghfelhffgueeugedtveduieehieehteelgeehvdefgeefgeenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:uUweaSvYYyd_hH9QCE9l257p8D5FEGYd7t6pup7uMZnRAlGb4nBcuQ>
    <xmx:uUweaQYqJPWFmf2XjgCTH_lROq5x1fuBXKOAM4mNuZAMgwaaB4pxTA>
    <xmx:uUweafszR21hHjvKMgOrMcxnzDVc7tJbEVxPwazTPuZL-1-wFkEzSw>
    <xmx:uUweaaFW_fDiIK7p6HpDHDd_zrl_pYYjXTKHZC77GixG8HA_MJqlCA>
    <xmx:uUweaSSX9PE6_jTNIshD96EXxrHhUqTQ7wfTS1CYJeAmWIseo1lbqeKl>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 18:03:21 -0500 (EST)
Date: Wed, 19 Nov 2025 15:02:36 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: check: add repair ability for missing
 orphan root item
Message-ID: <20251119230236.GB2475306@zen.localdomain>
References: <cover.1763156743.git.wqu@suse.com>
 <6511d4175e77e7f9cd11e074c4e06bd745ff4568.1763156743.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6511d4175e77e7f9cd11e074c4e06bd745ff4568.1763156743.git.wqu@suse.com>

On Sat, Nov 15, 2025 at 08:15:59AM +1030, Qu Wenruo wrote:
> There is a known bug in older kernels that orphan items can be missing
> for dropped subvolumes.
> 
> This makes those subvolumes unable to be removed on the next mount, and
> recent kernel commit 4289b494ac55 ("btrfs: do not allow relocation of
> partially dropped subvolumes") introduced one extra safe net to catch
> such problem.
> 
> But unfortunately there is no way to repair it.
> 
> Add the repair ability to both the original and lowmem modes.
> 
> Link: https://lore.kernel.org/linux-btrfs/01f8b560-fb57-4861-8382-141c39655478@gmx.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  check/main.c        |  5 +++++
>  check/mode-common.c | 33 +++++++++++++++++++++++++++++++++
>  check/mode-common.h |  1 +
>  check/mode-lowmem.c | 13 ++++++++++---
>  4 files changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/check/main.c b/check/main.c
> index 77458a769028..db055ae194f8 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -3550,6 +3550,11 @@ static int check_root_refs(struct btrfs_root *root,
>  				 */
>  				if (!rec->found_root_item)
>  					continue;
> +				if (opt_check_repair) {
> +					ret = repair_subvol_orphan_item(gfs_info, rec->objectid);
> +					if (!ret)
> +						continue;
> +				}
>  				errors++;
>  				fprintf(stderr, "fs tree %llu missing orphan item\n", rec->objectid);
>  			}
> diff --git a/check/mode-common.c b/check/mode-common.c
> index 0467ba28395e..2d11a96dfb7e 100644
> --- a/check/mode-common.c
> +++ b/check/mode-common.c
> @@ -1672,3 +1672,36 @@ int check_and_repair_super_num_devs(struct btrfs_fs_info *fs_info)
>  	printf("Successfully reset super num devices to %u\n", found_devs);
>  	return 0;
>  }
> +
> +int repair_subvol_orphan_item(struct btrfs_fs_info *fs_info, u64 rootid)
> +{
> +	struct btrfs_root *tree_root = fs_info->tree_root;
> +	struct btrfs_trans_handle *trans;
> +	struct btrfs_path path = { 0 };
> +	int ret;
> +
> +	trans = btrfs_start_transaction(tree_root, 1);
> +	if (IS_ERR(trans)) {
> +		ret = PTR_ERR(trans);
> +		errno = -ret;
> +		error_msg(ERROR_MSG_START_TRANS, "%m");
> +		return ret;
> +	}
> +	ret = btrfs_add_orphan_item(trans, tree_root, &path, rootid);
> +	btrfs_release_path(&path);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("failed to insert orphan item for subvolume %llu: %m", rootid);
> +		btrfs_abort_transaction(trans, ret);
> +		btrfs_commit_transaction(trans, tree_root);
> +		return ret;
> +	}
> +	ret = btrfs_commit_transaction(trans, tree_root);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
> +		return ret;
> +	}
> +	printf("Added back missing orphan item for subvolume %llu\n", rootid);
> +	return 0;
> +}
> diff --git a/check/mode-common.h b/check/mode-common.h
> index c37b4dc00e54..e97835a5b6a3 100644
> --- a/check/mode-common.h
> +++ b/check/mode-common.h
> @@ -197,5 +197,6 @@ int repair_dev_item_bytes_used(struct btrfs_fs_info *fs_info,
>  int fill_csum_tree(struct btrfs_trans_handle *trans, bool search_fs_tree);
>  
>  int check_and_repair_super_num_devs(struct btrfs_fs_info *fs_info);
> +int repair_subvol_orphan_item(struct btrfs_fs_info *fs_info, u64 rootid);
>  
>  #endif
> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
> index 363dc4ae1904..ea4d4017827f 100644
> --- a/check/mode-lowmem.c
> +++ b/check/mode-lowmem.c
> @@ -5569,9 +5569,16 @@ static int check_btrfs_root(struct btrfs_root *root, int check_all)
>  	 * If this tree is a subvolume (not a reloc tree) and has no refs, there
>  	 * should be an orphan item for it, or this subvolume will never be deleted.
>  	 */
> -	if (btrfs_root_refs(root_item) == 0 && is_fstree(btrfs_root_id(root))) {
> -		if (!has_orphan_item(root->fs_info->tree_root,
> -				     btrfs_root_id(root))) {
> +	if (btrfs_root_refs(root_item) == 0 && is_fstree(btrfs_root_id(root)) &&
> +	    !has_orphan_item(root->fs_info->tree_root, btrfs_root_id(root))) {
> +		bool repaired = false;
> +
> +		if (opt_check_repair) {
> +			ret = repair_subvol_orphan_item(root->fs_info, btrfs_root_id(root));
> +			if (!ret)
> +				repaired = true;
> +		}
> +		if (!repaired) {
>  			error("missing orphan item for root %lld", btrfs_root_id(root));
>  			err |= REFERENCER_MISSING;
>  		}
> -- 
> 2.51.2
> 

