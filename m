Return-Path: <linux-btrfs+bounces-3126-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C51D876A15
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 18:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38D81F2206F
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 17:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085C040853;
	Fri,  8 Mar 2024 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="OiUcMpxn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cwPcIyqg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4573BBE2;
	Fri,  8 Mar 2024 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919642; cv=none; b=GjSBmCG4NAEPnAmllQrK4assCSCHX3OaatgxeZzd7TmHfWV9zlISuIVd2sBfCqcNIFdAqD0tkPRnqdkL/thIv4XOhYO6MU3nnQ9hd4grI3jPH6U4lutomR9ZGSSt6/gde9zq9FsfDgzQlgCaa+wpuY0TjPJqD+flZe6Uth5ycbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919642; c=relaxed/simple;
	bh=H4vvGwpHYXd4iYVBNKQiBx0PgbPuKJStOVO818sFqDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfVIH5AvXzMR/jhsx799QYBJa/Y/CRDnoEIAw1g+K+toh1U4V60W+Kl3yXU3fSlbBnSOH+ARhe2aVE+b9A+/NS8XKlkX7wdTWP+Jsgq5iJ2Ovud4T5+6nkJa3yYall8UcjQwjx1VUz0zKd6IvNPRaGGVKDoaRPRuHdAz27VMXOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=OiUcMpxn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cwPcIyqg; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 90231320046F;
	Fri,  8 Mar 2024 12:40:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 08 Mar 2024 12:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1709919638; x=1710006038; bh=lkQD5pSSKI
	E2EHOTXnpevcPKoMwykQ8bxtsmG2z0QfY=; b=OiUcMpxnX4KgEd8TZiK4Iy+oll
	z9rL+ZH46kmGTqAAnUj+og7+Uot4lAbn39ChI6KDueHtpm0W1AbBFtfht6cp9prF
	xrpYK/Y9YA1v9DfPQqhItGSwZvqfIcYzfG/0aohKWLmhp+aPbYLMC5CZC7iVKcta
	2SUaZ8mfJ2Xh3eJUmBP64f5uxuZRKGKBfCc1TC0K781QtHQyee09Zr4OByvBzgLe
	rB5eSNezb29xcRbE1MH50MhdT8zhSKmC91IvHwQzMeE4TKWOPJb5RsOKp3jZ1hlR
	GSYlPaEvUDj+frYeD82KNIxoNS9yjOVbRcg6vw6FWy8HG3bvNh7yTjamemoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709919638; x=1710006038; bh=lkQD5pSSKIE2EHOTXnpevcPKoMwy
	kQ8bxtsmG2z0QfY=; b=cwPcIyqgHQSJWdyPHFvLy2evpTjdjKbmjQvtUtbC3+Fy
	/bkfPS5n2nddXL77R+dizSQXKRdd0hUXMjJQ/QYpfvp3ca8TCPHf8dLExLk+b6jb
	zZrq9+OSHnrvt58oRBakpHoQyXyfFImVBl5zFyHYkhtq819j8/VoZXXLGomc5IgZ
	nYHm1tc3r5qjhXt1rqRl+mEAPFrn+4+MYn9FMgmuNjAUiVMARFlvlmebQG32bZDn
	hzQ6Z7kYV9t75L+7x2fx/vKIZoB2U1UkNMDJNSaFwJfQJatRwgMhoSVzVbeCx9to
	R8SKWUoR6kGDJWsO45QjgLVdva7DOBTT3iaiwaL5Ew==
X-ME-Sender: <xms:lU3rZZh8OPvTvKm1CXSIHg4HAjLX4doTtF5i4P-JFP8aDN7VWS3bMw>
    <xme:lU3rZeC4E6tf7xz7I-mERg_OhiMwAlrzhCbcJLm3Jz-3J09nRfy0tNGEcYfnV0YiI
    KJnFuncWvufswT69K0>
X-ME-Received: <xmr:lU3rZZFPXzUNPEpn-mHKleDsZ_bivd69a-UpcR7oB5FpVp5T75fg4uuidl3FWBj0HCN8XgSoFQCkp0t8NzMCO_iI3uk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieehgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehtdfhvefghfdtvefghfelhffgueeugedtveduieehieehteelgeehvdefgeefgeenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:lU3rZeSSoLdPkfBE_yzRBMKhqN4BZjfWSEBApV-Yd-1uZiesoqQHiA>
    <xmx:lU3rZWwny9GiEaz557JCJl0aGqZjd8gzUYRK111EEqrUwO8Kfcq6Tg>
    <xmx:lU3rZU5tYVkrRVXn3PbN0Zu8XasD1EfCLycI0_FvCerKxajjD4MOzw>
    <xmx:lk3rZR82E7z1b7p-hBcipBVfDVIveUbryIz4hBzm28MTQbXlFx-qfQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Mar 2024 12:40:37 -0500 (EST)
Date: Fri, 8 Mar 2024 09:41:38 -0800
From: Boris Burkov <boris@bur.io>
To: Anand Jain <anand.jain@oracle.com>
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: validate device maj:min during open
Message-ID: <20240308174138.GB2469063@zen.localdomain>
References: <845dfb4fbf36dae204020c6a0a0e027cab42bcf0.1709865032.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <845dfb4fbf36dae204020c6a0a0e027cab42bcf0.1709865032.git.anand.jain@oracle.com>

On Fri, Mar 08, 2024 at 08:15:07AM +0530, Anand Jain wrote:
> Boris managed to create a device capable of changing its maj:min without
> altering its device path.
> 
> Only multi-devices can be scanned. A device that gets scanned and remains
> in the Btrfs kernel cache might end up with an incorrect maj:min.
> 
> Despite the tempfsid feature patch did not introduce this bug, it could
> lead to issues if the above multi-device is converted to a single device
> with a stale maj:min. Subsequently, attempting to mount the same device
> with the correct maj:min might mistake it for another device with the same
> fsid, potentially resulting in wrongly auto-enabling the tempfsid feature.
> 
> To address this, this patch validates the device's maj:min at the time of
> device open and updates it if it has changed since the last scan.

You and Dave have convinced me that it is important to fix this in the
kernel. I still have a hope of simplifying this further, while we are
here and have the code kicking around in our heads.

> 
> CC: stable@vger.kernel.org # 6.7+
> Fixes: a5b8a5f9f835 ("btrfs: support cloned-device mount capability")
> Reported-by: Boris Burkov <boris@bur.io>
> Co-developed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2:
> Drop using lookup_bdev() instead, get it from device->bdev->bd_dev.
> 
> v1:
> https://lore.kernel.org/linux-btrfs/752b8526be21d984e0ee58c7f66d312664ff5ac5.1709256891.git.anand.jain@oracle.com/
> 
>  fs/btrfs/volumes.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e49935a54da0..c318640b4472 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -692,6 +692,16 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  	device->bdev = bdev_handle->bdev;
>  	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>  
> +	if (device->devt != device->bdev->bd_dev) {
> +		btrfs_warn(NULL,
> +			   "device %s maj:min changed from %d:%d to %d:%d",
> +			   device->name->str, MAJOR(device->devt),
> +			   MINOR(device->devt), MAJOR(device->bdev->bd_dev),
> +			   MINOR(device->bdev->bd_dev));
> +
> +		device->devt = device->bdev->bd_dev;
> +	}
> +

If we are permanently maintaining an invariant that device->devt ==
device->bdev->bd_dev, do we even need device->devt? As far as I can
tell, all the logic that uses device->devt assumes that the device is
not stale, both in the temp_fsid found_by_devt lookup and in the "device
changed name" check. If so, we could just always use
device->bdev->bd_dev and eliminate this confusion/source of bugs
entirely.

>  	fs_devices->open_devices++;
>  	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
>  	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
> -- 
> 2.38.1
> 

