Return-Path: <linux-btrfs+bounces-14499-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1106ACF4F8
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 19:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221A03AEA6A
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 17:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C5E27990A;
	Thu,  5 Jun 2025 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="NF8inJlK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fVoUHAfV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D237D27603C
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143111; cv=none; b=JshRWVfxoGeUM1r6pEUFmsYwL5vL6v7dFZQ9L6UMJS90czPmHg3+n6+Jv0q/OmX8m2IZnUauAbR6n5fTTPewWyxhYoNilB6jwKof4KO1X3iWW4NDw6l9zZCmntQh6xfLTq4CFfBeZJWQrbY3xM02yl8Vjv2ekjhY0M0ZKtQHDfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143111; c=relaxed/simple;
	bh=O24Ya5ljSrlvN4KlmCkkVSVB6C5zSt10T0IoaPQX+Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yoa46dhIoU3rq4tJ7bSDndXJxi/4T48Jh7MJOG1pY4K2vlXdhOOUMHxnlnZr4xA6RY6AeIukwUkp9RSgqsWCHALvAie/QUsrdO9AEH5O/HwSYlXVdAKRCTcbZw3qcPUheJFixnQIiVDGoIfOtY11Sb3+50B7qkSOFXuwrUMJzP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=NF8inJlK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fVoUHAfV; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A952A114012D;
	Thu,  5 Jun 2025 13:05:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 05 Jun 2025 13:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1749143106; x=1749229506; bh=6RSH9C743/
	+uE9g4mIkMFSyzmjPm8G0GS7ywn4lCgEA=; b=NF8inJlKOTjcska8OhRBG8G9W/
	k3RIBNfzlIEAIhJn3RywT42feqMFSgJJ11xEAk1ROJUSQFtbKmRbWYd1VkiQRPvZ
	iigXImiX5/lnfBfu8Kq7sxhgtXNIAfxH/E/mpu+6jszkIkxfphU+OT61bcrNLxhB
	8P6TVuUr1gDTe2hdkJ1L+cjl5455GJRmpJsYjcyD9E52bYMTlZG58nbeJ2/j0Yxh
	PjeJe0Wk/VMvMeUYHmpWqZrK8v5sqMzn7MTRlnBbFnZxynu5aoF/Gnpry46TgkS2
	EL7EH3/JvIETxOfbKLofCGKzI4z+iYDZI7onh2eB9pQW7Rcr1D2MNGVBSu3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749143106; x=1749229506; bh=6RSH9C743/+uE9g4mIkMFSyzmjPm8G0GS7y
	wn4lCgEA=; b=fVoUHAfVScT9FZJmnDv2067E9zYjHpK5FMTvajIkbj4id+H0l1X
	yUq51kZWZrOzsUDoK07PPpV0jKJWUhsNSi9X7L7r684dF0Iaild2ASZFv+DAlR1Q
	LVFWcgUS44gYwS33zHKdQeAFxmFDeZ+JaITI7piZp38RtCe8+aksfvq4O1Yhw9xl
	nGG4sgUbHbC/C2B3qHTDsMCxRiRjj0z9H8k9SKF1qYbkomyFnjR0YIiJu4rOJlrL
	KycAyIbbwK5d3Kri9lXZn11sgXAmbEr86acDySMveXyGNE+6RfkrjV2be+P980Hj
	YyEF0bw9+OHr5ggmN877PACEivyxG1A6tsw==
X-ME-Sender: <xms:Qs5BaGvDo5gx4Cm9KJojZOojDeWXGGpdqqQMtLzKUHaiqwPp5ihT4w>
    <xme:Qs5BaLdy5lc6TfOlDR6RkgRtjLhV9fxZoHvuj8i2N8wVM6hGKN_jnMMuIqL1fb3M3
    xm2U3t21eiwU_GbL3k>
X-ME-Received: <xmr:Qs5BaByaQ-LybJClvfDHrCIO6Rfu0FNI1k-s-zaA-9lMtiz3_D7etfLVhkyRHKWrojOMnhVfrrjYmv4_Ep6Q1d1EC3o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenuc
    ggtffrrghtthgvrhhnpeehtdfhvefghfdtvefghfelhffgueeugedtveduieehieehteel
    geehvdefgeefgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifqh
    husehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Qs5BaBMy8bE_s8bJPdohxbasKJHz3ZTj0dXGyu6877Fz7GXq2jp08Q>
    <xmx:Qs5BaG8od1bNyAvl4ZjJJsM20mfQ4G-IuM1xpDzcBsZDa8TqIT3vSg>
    <xmx:Qs5BaJWNSuhMDMAOwHx8NHrhAHm1vxRIPIVC0DgYE7Ssu7tdVgZU5w>
    <xmx:Qs5BaPe36xDFS357TeBwl_vThMQFGbeajEYEIKz8IqJGOwhOUuZT8Q>
    <xmx:Qs5BaGO8hKSF-XTlucEZCb6XbiuQcaE8NJYn1274YBzcihczi17unde1>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 13:05:05 -0400 (EDT)
Date: Thu, 5 Jun 2025 10:05:00 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use fs_info as the block device holder
Message-ID: <20250605170431.GA3475402@zen.localdomain>
References: <8c2f064770e5bf7a78d768b3e0a2cad9643169d7.1749116730.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c2f064770e5bf7a78d768b3e0a2cad9643169d7.1749116730.git.wqu@suse.com>

On Thu, Jun 05, 2025 at 07:15:48PM +0930, Qu Wenruo wrote:
> Currently btrfs uses "btrfs_fs_type" as the bdev holder for all opened
> device, which means all btrfses shares the same holder value.
> 
> That's only fine when there is no blk_holder_ops provided, but we're
> going to implement blk_holder_ops soon, so replace the "btrfs_fs_type"
> holder usage, and replace it with a proper fs_info instead.
> 
> This means we can remove the btrfs_fs_info::bdev_holder completely.

I definitely support this, I always found it quite weird that we had a
single generic holder and relied on our own checking to ensure we only
mount each device once. I think this should help insulate us from
bizarre fsid bugs like we've seen with seed+sprout in the past.

However, I'm a little confused, as I thought Johannes and Christoph made
the change to using the super block as the holder a while ago:
https://lore.kernel.org/linux-btrfs/20231218044933.706042-1-hch@lst.de/

Did that end up failing to get in? Or it got reverted? I don't see it in
the git history.

Those patches have a lot more going on, so I'm also wondering if any of
that is necessary for making this change? Haven't fully refreshed myself
on that old series, though, so it's a fairly naive question. Also, it
does seem like other fs-es uses sb, but I don't have a strong opinion on
that and don't see why fs_info can't work.

Thanks,
Boris

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/dev-replace.c | 2 +-
>  fs/btrfs/fs.h          | 2 --
>  fs/btrfs/super.c       | 3 +--
>  fs/btrfs/volumes.c     | 4 ++--
>  4 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 2decb9fff445..cf63f4b29327 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -250,7 +250,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>  	}
>  
>  	bdev_file = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
> -					fs_info->bdev_holder, NULL);
> +					   fs_info, NULL);
>  	if (IS_ERR(bdev_file)) {
>  		btrfs_err(fs_info, "target device %s is invalid!", device_path);
>  		return PTR_ERR(bdev_file);
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index b239e4b8421c..d90304d4e32c 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -715,8 +715,6 @@ struct btrfs_fs_info {
>  	u32 data_chunk_allocations;
>  	u32 metadata_ratio;
>  
> -	void *bdev_holder;
> -
>  	/* Private scrub information */
>  	struct mutex scrub_lock;
>  	atomic_t scrubs_running;
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 2d0d8c6e77b4..c1efd20166cc 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1865,7 +1865,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
>  	fs_devices = device->fs_devices;
>  	fs_info->fs_devices = fs_devices;
>  
> -	ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
> +	ret = btrfs_open_devices(fs_devices, mode, fs_info);
>  	mutex_unlock(&uuid_mutex);
>  	if (ret)
>  		return ret;
> @@ -1905,7 +1905,6 @@ static int btrfs_get_tree_super(struct fs_context *fc)
>  	} else {
>  		snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
>  		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
> -		btrfs_sb(sb)->bdev_holder = &btrfs_fs_type;
>  		ret = btrfs_fill_super(sb, fs_devices);
>  		if (ret) {
>  			deactivate_locked_super(sb);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index d3e749328e0f..606ddf42ddc3 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2705,7 +2705,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  		return -EROFS;
>  
>  	bdev_file = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
> -					fs_info->bdev_holder, NULL);
> +					   fs_info, NULL);
>  	if (IS_ERR(bdev_file))
>  		return PTR_ERR(bdev_file);
>  
> @@ -7168,7 +7168,7 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
>  	if (IS_ERR(fs_devices))
>  		return fs_devices;
>  
> -	ret = open_fs_devices(fs_devices, BLK_OPEN_READ, fs_info->bdev_holder);
> +	ret = open_fs_devices(fs_devices, BLK_OPEN_READ, fs_info);
>  	if (ret) {
>  		free_fs_devices(fs_devices);
>  		return ERR_PTR(ret);
> -- 
> 2.49.0
> 

