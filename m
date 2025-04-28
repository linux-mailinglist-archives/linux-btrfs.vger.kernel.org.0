Return-Path: <linux-btrfs+bounces-13473-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1212CA9FC09
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 23:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B46218887D2
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 21:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E5B20969A;
	Mon, 28 Apr 2025 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="jr0+kP84";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bZ6N0P+M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8371E282D
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745874869; cv=none; b=JqFM74erYCQuyN0Axg7XolOEcrqcxeou5sucC6ovyv/0DcuKVI2Kw2YQ71rlZ+C42/M63cdlZnG7Rcok8G53N5bVm6y/24+kYq9HK6T9DNysL3Isqaa87r1J6dsEXoEij2i796hD4NNMu5Aytj/e5LxXN2dNBwJa/e4EbU+9L6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745874869; c=relaxed/simple;
	bh=sFqApwmfb3v72MwKSHEEKKufavurXDfQO9d4L9EUpS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkizD9b7Nglq7YStLfueqbSjrYjhI9r2LgkihbLoi2CoULTWHBTDaCDagPHKNjszgnw1Nv0wVo0WzN8+7jn4JK6feDEp9s8MibkU7u8nJn4L241QcnUmMi3QUxPrjGrDG6LxLmTUrd8NzxEGQF0YJ+laPWKNaV2lly8JItX8xEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=jr0+kP84; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bZ6N0P+M; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 7F96011401AF;
	Mon, 28 Apr 2025 17:14:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 28 Apr 2025 17:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745874864; x=1745961264; bh=bEevPvnQUP
	MMzUM/EJCmA9rV9t9xFVTplU0ZPlz5474=; b=jr0+kP84Exk9YuuZ1KPpgSGT8f
	N/K+CsZkXJGxdQnvjqEwDQAAEf0n+0gkZqOl6/A9xli251DlQ6IEEwm9qhznXdRG
	qIHpNCZ1tOWVawd3zPAHhnTsetohqC8X9Yuuk8hauDX7jdyVF5SiNhe6IjnfCDtE
	CB6qJ9PVwiDPj911Y5ETvKk2/ocIG6/jwMA9n4Ww+/MJ9IhGAsE+97TtfYVUL9BK
	Xh0RV0ImxaHCW2CNNK+AM0mhB+d7ow5DwXQG+vS0AJOHw20YY8INb5CpmBuWoT/x
	QTeRy8xiUdhR0ZTm1QcuQFlmZCbifjWGdVU1DANReJ9+vPfPaLyyo4eBqIpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745874864; x=1745961264; bh=bEevPvnQUPMMzUM/EJCmA9rV9t9xFVTplU0
	ZPlz5474=; b=bZ6N0P+M75GKia3BDZTA1tJI2jRNdZH3NECvWYn6uOUQCEOccvI
	q1T+aROoYIBvhdrK1R4Dwi+k5xf9SmMteSwaVVdK0e6bvKL32I6Rg90YznSTAjBv
	9ImW4qDz/TerCqrh3vAgmAwHzP2fkoLV4w+ThJB1QjtN3NXVln0mTE46r61BRs5c
	9oFbeewBV4GgL0zkM6F+GKSZkC8yHfvDHMJjtgJEiZ+gAZVy9MK5DtuZVw+q84LN
	T3KCTdZmUo9CRQlPchYLa1E+RD1JibVvWWMevHIfBpOAj/zZyyELGXwApmh9Ujb6
	67alGQA876qStJ85TvBkcY+7PnFWPn2PMSw==
X-ME-Sender: <xms:sO8PaHifguaz9_wdKoRhRj9b9UjDME0zDJf4OZlcTxMoThEONoD7tA>
    <xme:sO8PaEDSeduSFhx9B1H52jA7cSVW9el0O611Rv0BJV9jgRyz7qQhn6Ad5RYTWJgj3
    kDG-gytvj6bhuZhb4Q>
X-ME-Received: <xmr:sO8PaHFdJDC_l9yPPzZegi6znsGnlpymfiAzxqcCL8b6VPALKKjoNNPd8eG4i8pFUcX1iU0AXtHswwuRhqKYqy4P0IA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedvtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqe
    enucggtffrrghtthgvrhhnpeehtdfhvefghfdtvefghfelhffgueeugedtveduieehieeh
    teelgeehvdefgeefgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdr
    ihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    ifqhhusehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sO8PaES7fpIjNCdh-sFSzNgrlfVQpaQgmGuG0J4c4VPrb2OfVEbVKg>
    <xmx:sO8PaEyYKBOOFR88ta2tMwJS5510Kx8e-fGPhgbqBvym6OpxR9Zuyg>
    <xmx:sO8PaK68E3C-jdvs5xSVCNK_nkvPwW_XuuzEe3GGzXA-roBOjGNW1A>
    <xmx:sO8PaJw78bqMOjo9G5FnDfdZLmz5OHvTiKRBhLL8ZN9GUhGviTOO-Q>
    <xmx:sO8PaJjcDIoj1lL1acc7Fm8YsMTlfdjdOTGIR3vsy4tTYA0HfHXL7GJ8>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 17:14:23 -0400 (EDT)
Date: Mon, 28 Apr 2025 14:15:21 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Revert "btrfs: canonicalize the device path before
 adding it"
Message-ID: <20250428211521.GA3351171@zen.localdomain>
References: <65c879f1c79f2171e64335a4f2045a0e604a1950.1737067145.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65c879f1c79f2171e64335a4f2045a0e604a1950.1737067145.git.wqu@suse.com>

On Fri, Jan 17, 2025 at 09:09:34AM +1030, Qu Wenruo wrote:
> This reverts commit 7e06de7c83a746e58d4701e013182af133395188.
> 
> Commit 7e06de7c83a7 ("btrfs: canonicalize the device path before adding
> it") tries to make btrfs to use "/dev/mapper/*" name first, then any
> filename inside "/dev/" as the device path.
> 
> This is mostly fine when there is only the root namespace involved, but
> when multiple namespace are involved, things can easily go wrong for the
> d_path() usage.
> 
> As d_path() returns a file path that is namespace dependent, the
> resulted string may not make any sense in another namespace.
> 
> Furthermore, the "/dev/" prefix checks itself is not reliable, one can
> still make a valid initramfs without devtmpfs, and fill all needed
> device nodes manually.
> 
> Overall the userspace has all its might to pass whatever device path for
> mount, and we are not going to win the war trying to cover every corner
> case.
> 
> So just revert that commit, and do no extra d_path() based file path
> sanity check.
> 
> Link: https://lore.kernel.org/linux-fsdevel/20250115185608.GA2223535@zen.localdomain/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thanks for sending this, I believe it will unblock a systemd utility
that uses unshare(CLONE_NEWNS) in a way that isn't friendly with the
canonicalizing behavior.

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
> Reason for RFC:
> 
> Although most distros will mount devtmpfs on "/dev/", it may not be the
> case for containers.
> And d_path() result is always namespace dependent, it means the mount
> source shown in mount info is never ensured to make sense in another
> namespace anyway.
> 
> I do not see a future that we can win the cat-and-mouse game, and the
> complexity of the file path sanity check will only grow and grow,
> eventually get out-of-control.
> 
> Thus I recommend to cut the loss early.
> ---
>  fs/btrfs/volumes.c | 87 +---------------------------------------------
>  1 file changed, 1 insertion(+), 86 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a594f66daedf..e511743bbc08 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -733,78 +733,6 @@ const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super_block *sb)
>  	return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
>  }
>  
> -/*
> - * We can have very weird soft links passed in.
> - * One example is "/proc/self/fd/<fd>", which can be a soft link to
> - * a block device.
> - *
> - * But it's never a good idea to use those weird names.
> - * Here we check if the path (not following symlinks) is a good one inside
> - * "/dev/".
> - */
> -static bool is_good_dev_path(const char *dev_path)
> -{
> -	struct path path = { .mnt = NULL, .dentry = NULL };
> -	char *path_buf = NULL;
> -	char *resolved_path;
> -	bool is_good = false;
> -	int ret;
> -
> -	if (!dev_path)
> -		goto out;
> -
> -	path_buf = kmalloc(PATH_MAX, GFP_KERNEL);
> -	if (!path_buf)
> -		goto out;
> -
> -	/*
> -	 * Do not follow soft link, just check if the original path is inside
> -	 * "/dev/".
> -	 */
> -	ret = kern_path(dev_path, 0, &path);
> -	if (ret)
> -		goto out;
> -	resolved_path = d_path(&path, path_buf, PATH_MAX);
> -	if (IS_ERR(resolved_path))
> -		goto out;
> -	if (strncmp(resolved_path, "/dev/", strlen("/dev/")))
> -		goto out;
> -	is_good = true;
> -out:
> -	kfree(path_buf);
> -	path_put(&path);
> -	return is_good;
> -}
> -
> -static int get_canonical_dev_path(const char *dev_path, char *canonical)
> -{
> -	struct path path = { .mnt = NULL, .dentry = NULL };
> -	char *path_buf = NULL;
> -	char *resolved_path;
> -	int ret;
> -
> -	if (!dev_path) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
> -	path_buf = kmalloc(PATH_MAX, GFP_KERNEL);
> -	if (!path_buf) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -
> -	ret = kern_path(dev_path, LOOKUP_FOLLOW, &path);
> -	if (ret)
> -		goto out;
> -	resolved_path = d_path(&path, path_buf, PATH_MAX);
> -	ret = strscpy(canonical, resolved_path, PATH_MAX);
> -out:
> -	kfree(path_buf);
> -	path_put(&path);
> -	return ret;
> -}
> -
>  static bool is_same_device(struct btrfs_device *device, const char *new_path)
>  {
>  	struct path old = { .mnt = NULL, .dentry = NULL };
> @@ -1509,23 +1437,12 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>  	bool new_device_added = false;
>  	struct btrfs_device *device = NULL;
>  	struct file *bdev_file;
> -	char *canonical_path = NULL;
>  	u64 bytenr;
>  	dev_t devt;
>  	int ret;
>  
>  	lockdep_assert_held(&uuid_mutex);
>  
> -	if (!is_good_dev_path(path)) {
> -		canonical_path = kmalloc(PATH_MAX, GFP_KERNEL);
> -		if (canonical_path) {
> -			ret = get_canonical_dev_path(path, canonical_path);
> -			if (ret < 0) {
> -				kfree(canonical_path);
> -				canonical_path = NULL;
> -			}
> -		}
> -	}
>  	/*
>  	 * Avoid an exclusive open here, as the systemd-udev may initiate the
>  	 * device scan which may race with the user's mount or mkfs command,
> @@ -1570,8 +1487,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>  		goto free_disk_super;
>  	}
>  
> -	device = device_list_add(canonical_path ? : path, disk_super,
> -				 &new_device_added);
> +	device = device_list_add(path, disk_super, &new_device_added);
>  	if (!IS_ERR(device) && new_device_added)
>  		btrfs_free_stale_devices(device->devt, device);
>  
> @@ -1580,7 +1496,6 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>  
>  error_bdev_put:
>  	fput(bdev_file);
> -	kfree(canonical_path);
>  
>  	return device;
>  }
> -- 
> 2.48.0
> 

