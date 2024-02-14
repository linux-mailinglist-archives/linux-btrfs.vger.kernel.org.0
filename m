Return-Path: <linux-btrfs+bounces-2394-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846028552CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 19:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E879EB21FED
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 18:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9216013A270;
	Wed, 14 Feb 2024 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="PvKiy7lX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PC+QLcg6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FD21272CD;
	Wed, 14 Feb 2024 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936996; cv=none; b=S5mLgDgITvJY94DB6ItQdcs1r4JTP+OEXpZAUlMJXjleO+1Oft9zH2MvMhFBGSqEWRBggTnnIZo63Muq30JdOvLGun9yXMDUhSLzu36imhCC6RoClaGwtoRlpJZj5KCh5dmLww/EgiSCLW4gWUsLxBGK+uA+IZMpOBQMr6dQgDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936996; c=relaxed/simple;
	bh=8hIv6cNq3a7qYNhZDESFyBQfplcDitQ8UTCfog5Utu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIcxCnAGi+4ilxd+k6zMshnNManV0LOLPchJWWA+lbjPKBw+oqDrm+R8v9Whh0j1W0XGSRkJrgKnntp3dQcyUY+E6wBKUkG5oaKVqkVzeNDl/mvRrExQtlUzziYzbb57wF+zpgEav6Is1pZELjdKR5vsj+oW3CYaSvG2tz+uCqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=PvKiy7lX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PC+QLcg6; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 3F28A32000D7;
	Wed, 14 Feb 2024 13:56:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 14 Feb 2024 13:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707936992; x=1708023392; bh=FxSmCPiL63
	zh2ckZioO639gBdqwSW26PXW2TfMlHQxE=; b=PvKiy7lXwzYXozeyjTOaroEtqW
	2gE3GuxYj1dhPLfU8iIeeY8eWLBkbuPUlNeofECEl1YOanAir1dli75qd7HT0ZvI
	FHuWpX9YIScHyq7Pe03x2eOIYC+q63n9p2CZ/uhr+Xy7zj6XxvLvCzAvc30Fbd5E
	zdDJ96CvhIBz8C7kbPSz+QMk1derkloPXzNvYP+2UyjK6aJshkaFo3OEbUD11shS
	IYuk6L85Kn0kIKMdCpDpTpZjPGR9XIo2un/47tecoge0lQqpL1zv93D5CYi/EbOX
	DIxyt4cKErhjuU9l+eLLQWz4DRH+agohiYmea/h9RHteS4NsNe2Ah5wBP2bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707936992; x=1708023392; bh=FxSmCPiL63zh2ckZioO639gBdqwS
	W26PXW2TfMlHQxE=; b=PC+QLcg6F6MHTQcympb5SGi9021pPgwN02fovRpqQHBn
	Tukqtq/Tz8j0B4/I3nJhEvuLpkcLGTt2SqB9yy3e7em8AsaH0ZYeJrHAvknUoLRc
	SVR+FWfq7FyeyFGBttWMS5Fs2sb+6Ke2tVoUShWYO3DRtdXF4A6waQ1A5lI3DpBJ
	XD1rjrCNVLjVtCu/dfGpPV/h4IWqNDjI76jYYsw5P9+N1ZKsz775f6WNBOn2FOAR
	MtaZaiBuanYfeJtr0Nv6WfcfPyIcFHZxcXDjZXxvGhCYoDooHh49TbcrWX3Oyp+J
	jTeJWRP/UHITaPWYifH3S9WrX6hx6lzIoJE7MOg3DA==
X-ME-Sender: <xms:4AzNZdY7AUrcmL0L-2xOWZ1fNSn7PdRc1mEoxOMeVY994EByEuUS1Q>
    <xme:4AzNZUbahqPruflPS5R_uKZUmAAan6z7_sASgn8unQ28KmCKFCWEWOKMDEbN1IGnx
    FuUWx98QNs_I_EuSPY>
X-ME-Received: <xmr:4AzNZf8rbqxAkaXdzbDSMflSlHinDQhSt8fXvzFkjLeISusFbFijFfZNVGfOMyNaLwOMr-0iAVeJ0EJjCtX8c90S758>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:4AzNZbpBZ1yGJgUyRZVJlxeAarPK_OvqLawt7LDkFzMd-72h4T2X4g>
    <xmx:4AzNZYrcvzza08xiE4k74Oj0LOtGruAn9hmmK7O81qPM46_ntwvf5w>
    <xmx:4AzNZRR_87lT4Bb8jtLUU6NoHxSoP3kfIm7quJYvAwgJ8VVkHrazxw>
    <xmx:4AzNZdAlcp-IGBE2x3Gw0HhJ1cFeE5Zn2DGh2l68cDthBp40yz1-sA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Feb 2024 13:56:31 -0500 (EST)
Date: Wed, 14 Feb 2024 10:58:09 -0800
From: Boris Burkov <boris@bur.io>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] btrfs: open block devices after superblock creation
Message-ID: <20240214185809.GC377066@zen.localdomain>
References: <20240214-hch-device-open-v1-0-b153428b4f72@wdc.com>
 <20240214-hch-device-open-v1-4-b153428b4f72@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-hch-device-open-v1-4-b153428b4f72@wdc.com>

On Wed, Feb 14, 2024 at 08:42:15AM -0800, Johannes Thumshirn wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Currently btrfs_mount_root opens the block devices before committing to
> allocating a super block. That creates problems for restricting the
> number of writers to a device, and also leads to a unusual and not very
> helpful holder (the fs_type).
> 
> Reorganize the code to first check whether the superblock for a
> particular fsid does already exist and open the block devices only if it
> doesn't, mirroring the recent changes to the VFS mount helpers.  To do
> this the increment of the in_use counter moves out of btrfs_open_devices
> and into the only caller in btrfs_mount_root so that it happens before
> dropping uuid_mutex around the call to sget.

I believe this commit message is now out of date as of
'btrfs: remove old mount API code'
which got rid of btrfs_mount_root.

As far as I can tell, the code itself is updated and fine.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/super.c   | 41 +++++++++++++++++++++++++----------------
>  fs/btrfs/volumes.c | 15 +++++----------
>  2 files changed, 30 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 51b8fd272b15..1fa7d83d02c1 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1794,7 +1794,6 @@ static int btrfs_get_tree_super(struct fs_context *fc)
>  	struct btrfs_fs_info *fs_info = fc->s_fs_info;
>  	struct btrfs_fs_context *ctx = fc->fs_private;
>  	struct btrfs_fs_devices *fs_devices = NULL;
> -	struct block_device *bdev;
>  	struct btrfs_device *device;
>  	struct super_block *sb;
>  	blk_mode_t mode = btrfs_open_mode(fc);
> @@ -1817,15 +1816,8 @@ static int btrfs_get_tree_super(struct fs_context *fc)
>  	fs_devices = device->fs_devices;
>  	fs_info->fs_devices = fs_devices;
>  
> -	ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
> +	fs_devices->in_use++;
>  	mutex_unlock(&uuid_mutex);
> -	if (ret)
> -		return ret;
> -
> -	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0)
> -		return -EACCES;
> -
> -	bdev = fs_devices->latest_dev->bdev;
>  
>  	/*
>  	 * From now on the error handling is not straightforward.
> @@ -1843,24 +1835,41 @@ static int btrfs_get_tree_super(struct fs_context *fc)
>  	set_device_specific_options(fs_info);
>  
>  	if (sb->s_root) {
> -		if ((fc->sb_flags ^ sb->s_flags) & SB_RDONLY)
> +		if ((fc->sb_flags ^ sb->s_flags) & SB_RDONLY) {
>  			ret = -EBUSY;
> +			goto error_deactivate;
> +		}
>  	} else {
> -		snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
> +		struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> +
> +		mutex_lock(&uuid_mutex);
> +		ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
> +		mutex_unlock(&uuid_mutex);
> +		if (ret)
> +			goto error_deactivate;
> +
> +		if (!(fc->sb_flags & SB_RDONLY) && !fs_devices->rw_devices) {
> +			ret = -EACCES;
> +			goto error_deactivate;
> +		}
> +
> +		snprintf(sb->s_id, sizeof(sb->s_id), "%pg",
> +			 fs_devices->latest_dev->bdev);
>  		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
>  		btrfs_sb(sb)->bdev_holder = &btrfs_fs_type;
>  		ret = btrfs_fill_super(sb, fs_devices, NULL);
> -	}
> -
> -	if (ret) {
> -		deactivate_locked_super(sb);
> -		return ret;
> +		if (ret)
> +			goto error_deactivate;
>  	}
>  
>  	btrfs_clear_oneshot_options(fs_info);
>  
>  	fc->root = dget(sb->s_root);
>  	return 0;
> +
> +error_deactivate:
> +	deactivate_locked_super(sb);
> +	return ret;
>  }
>  
>  /*
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index f27af155abf0..6e82bd7ce501 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1220,8 +1220,6 @@ static int devid_cmp(void *priv, const struct list_head *a,
>  int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>  		       blk_mode_t flags, void *holder)
>  {
> -	int ret;
> -
>  	lockdep_assert_held(&uuid_mutex);
>  	/*
>  	 * The device_list_mutex cannot be taken here in case opening the
> @@ -1230,14 +1228,11 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>  	 * We also don't need the lock here as this is called during mount and
>  	 * exclusion is provided by uuid_mutex
>  	 */
> -	if (!fs_devices->is_open) {
> -		list_sort(NULL, &fs_devices->devices, devid_cmp);
> -		ret = open_fs_devices(fs_devices, flags, holder);
> -		if (ret)
> -			return ret;
> -	}
> -	fs_devices->in_use++;
> -	return 0;
> +	ASSERT(fs_devices->in_use);
> +	if (fs_devices->is_open)
> +		return 0;
> +	list_sort(NULL, &fs_devices->devices, devid_cmp);
> +	return open_fs_devices(fs_devices, flags, holder);
>  }
>  
>  void btrfs_release_disk_super(struct btrfs_super_block *super)
> 
> -- 
> 2.43.0
> 

