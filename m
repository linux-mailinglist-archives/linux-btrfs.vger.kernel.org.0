Return-Path: <linux-btrfs+bounces-2184-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A931684C150
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 01:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B64A1F2499F
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 00:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42C03211;
	Wed,  7 Feb 2024 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Gh8t9j7g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WCHi2ja1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39672944E;
	Wed,  7 Feb 2024 00:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707265285; cv=none; b=Kwexl2q+rx47grboMOH78TEInkrI9Rr68e/AnzRf9jbozGV8bD9du6IDD1FTaDesI2AHPFM6KW0XKuIinG0IZKPwuJssgIrX6UwFWMfB16iyae0SP5nc5GwVaxWo3tf691ZkwPlZf64sgS4Y2Gtr19WWDnmhEmfbcH1hvP17tRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707265285; c=relaxed/simple;
	bh=l9ZR9KPFu+v42cI3WJTTUAbQ6wiRvrdN3zmal3nKdd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLaKbR9Duo9A6ZVe6bE3uZ1MGYtOAO4PeR0Ty8S4lVqZOFQZVZXHUbKoIDwXUE/s+u77cQ+ZYlaHksPItNKr+nBNrM2Eg2anbhQxTM8NCD09VzSU2Ra/67xnwLVu7Y0kUsEp5AB1IVRUOY6lBXntxpbDM9p12xshk99vDPaTrwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Gh8t9j7g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WCHi2ja1; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id EAA7E32004AE;
	Tue,  6 Feb 2024 19:21:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 06 Feb 2024 19:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707265281; x=1707351681; bh=BBH59OQg0c
	SKoW00AgUJt80TkHnqF62UtA8oiIbyfqA=; b=Gh8t9j7g5NBvijkmunDsQHA/0U
	cMbeSnSgKnaQri9RBKVapF/LR6D3UZcSZcF3T91eWafuCp6a3HEObUd0aemJvzFj
	nlpZpGWRyoQ3dAtLtJjGOiqBeySuhEADoo5FEo91YKBrL2WxxNuKZYK6uBuwRIyP
	dbSBlYuNulDy8tYxLsLIg7D1XAzOtc9xvTcSo9FLixDgqMc28gBZRt+7qMe6DpcY
	5h0paDHPwFRWVw06ejp5vZQZvWfrIorFcyUmv27yVCuR34cLintiFBoMQZ3UAH0l
	zObaUCoqJGcjWSDCxQ1m+wOen8FIt6sURYQyDhMMoBKk/yIQ6e1ARK/Q1rWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707265281; x=1707351681; bh=BBH59OQg0cSKoW00AgUJt80TkHnq
	F62UtA8oiIbyfqA=; b=WCHi2ja1Id39g9kHPcjN7tb3POEOfgyObrxeC7lFzIat
	UJ8ayjvPtXO2jRo3CvogxFAxXmdABCFLKQTQDW/RmPO2QMOk5lGYJ+FYeoFWiRCt
	6FCNcOwau3Fvf2ymokL/nq4/SL/tP53L8QlLLxXfGtOY9i+J/iTlNrR+8/ybtvE5
	qLjT3rwACbpT2OPRDZcUASwO1twfv5xZWIhLwAMfCtQfg6Ol6MErtXCRZ9M669WG
	mzhLsqRsg6XIzM+OPy/fkAdAR25bCAOfGn8bahmXPRpJetGG0/vvueU3mhIN5uqR
	Vh5Qw4D6f3PsX4r8IFQAz64+2SOQS1ZGY3mC4hsZpQ==
X-ME-Sender: <xms:Ac3CZe-0t5g6enKZvi_BodLHX_nh6IfICgGT2anZnN03R4T0CVfHnA>
    <xme:Ac3CZevfEGkIydgfYEpJYSfxqsGQiSltbKxlg9m0Z8-TqbN9kvFEjDYe2WwA0jQiE
    1GMEy5y1yl22cUn40w>
X-ME-Received: <xmr:Ac3CZUDRYBMQbrMrcEz5xTp3kpHTkB1VnZGitx4X0SEDBOK0zShZ2IAjjZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddugddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephe
    dthfevgffhtdevgffhlefhgfeuueegtdevudeiheeiheetleeghedvfeegfeegnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:Ac3CZWcEHOgB8tieBW4l2wQT2nMH63H9gZ2Q6mfDmIuFZj81zCbjwg>
    <xmx:Ac3CZTMuGp2bPsVzCsGXgu4SAAuMVdKjjGECxkQ0pigd-VYR34lkvw>
    <xmx:Ac3CZQkakrvjIilh3txs1OCWxCBDpekCFVq4Qng_N_bLdsvochWyBw>
    <xmx:Ac3CZZ2VkgkxHQo2M-cr3MQSg1g75IhN4Bkf_oTLc5kuymTrwn3Tyg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 19:21:20 -0500 (EST)
Date: Tue, 6 Feb 2024 16:21:15 -0800
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: always scan a single device when mounted
Message-ID: <ZcLM+2mtKFaVUFsF@devvm12410.ftw0.facebook.com>
References: <20240205174340.30327-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205174340.30327-1-dsterba@suse.com>

On Mon, Feb 05, 2024 at 06:43:39PM +0100, David Sterba wrote:
> There are reports that since version 6.7 update-grub fails to find the
> device of the root on systems without initrd and on a single device.
> 
> This looks like the device name changed in the output of
> /proc/self/mountinfo:
> 
> 6.5-rc5 working
> 
>   18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...
> 
> 6.7 not working:
> 
>   17 1 0:15 / / rw,noatime - btrfs /dev/root ...
> 
> and "update-grub" shows this error:
> 
>   /usr/sbin/grub-probe: error: cannot find a device for / (is /dev mounted?)
> 
> This looks like it's related to the device name, but grub-probe
> recognizes the "/dev/root" path and tries to find the underlying device.
> However there's a special case for some filesystems, for btrfs in
> particular.
> 
> The generic root device detection heuristic is not done and it all
> relies on reading the device infos by a btrfs specific ioctl. This ioctl
> returns the device name as it was saved at the time of device scan (in
> this case it's /dev/root).
> 
> The change in 6.7 for temp_fsid to allow several single device
> filesystem to exist with the same fsid (and transparently generate a new
> UUID at mount time) was to skip caching/registering such devices.
> 
> This also skipped mounted device. One step of scanning is to check if
> the device name hasn't changed, and if yes then update the cached value.
> 
> This broke the grub-probe as it always read the device /dev/root and
> couldn't find it in the system. A temporary workaround is to create a
> symlink but this does not survive reboot.
> 
> The right fix is to allow updating the device path of a mounted
> filesystem even if this is a single device one. This does not affect the
> temp_fsid feature, the UUID of the mounted filesystem remains the same
> and the matching is based on device major:minor which is unique per
> mounted filesystem.
> 
> As the main part of device scanning and list update is done in
> device_list_add() that handles all corner cases and locking, it is
> extended to take a parameter that tells it to do everything as before,
> except adding a new device entry.
> 
> This covers the path when the device (that exists for all mounted
> devices) name changes, updating /dev/root to /dev/sdx. Any other single
> device with filesystem is skipped.
> 
> Note that if a system is booted and initial mount is done on the
> /dev/root device, this will be the cached name of the device. Only after
> the command "btrfs device rescan" it will change as it triggers the
> rename.
> 
> The fix was verified by users whose systems were affected.
> 
> CC: stable@vger.kernel.org # 6.7+
> Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single device filesystem")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218353
> Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com/
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/volumes.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 474ab7ed65ea..f2c2f7ca5c3d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -738,6 +738,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>  	bool same_fsid_diff_dev = false;
>  	bool has_metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
>  		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
> +	bool can_create_new = *new_device_added;

It took me quite a while to figure out all the intended logic with the
now in/out parameter. I think it's probably too cute? Why not just add
another parameter "can_create_new_device"? I think it feels kind of
weird on the caller side too, to set "new_device_added" to true, but
then still rely on it to actually get set to true.

Once I got past this, the logic made sense, so definitely don't block
yourself on this nit.

>  
>  	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_CHANGING_FSID_V2) {
>  		btrfs_err(NULL,
> @@ -753,6 +754,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>  		return ERR_PTR(error);
>  	}
>  
> +	*new_device_added = false;
>  	fs_devices = find_fsid_by_device(disk_super, path_devt, &same_fsid_diff_dev);
>  
>  	if (!fs_devices) {
> @@ -804,6 +806,15 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>  			return ERR_PTR(-EBUSY);
>  		}
>  
> +		if (!can_create_new) {
> +			pr_info(
> +	"BTRFS: device fsid %pU devid %llu transid %llu %s skip registration scanned by %s (%d)\n",
> +				disk_super->fsid, devid, found_transid, path,
> +				current->comm, task_pid_nr(current));
> +			mutex_unlock(&fs_devices->device_list_mutex);
> +			return NULL;
> +		}
> +
>  		nofs_flag = memalloc_nofs_save();
>  		device = btrfs_alloc_device(NULL, &devid,
>  					    disk_super->dev_item.uuid, path);
> @@ -1355,27 +1366,14 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>  		goto error_bdev_put;
>  	}
>  
> -	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
> -	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
> -		dev_t devt;
> -
> -		ret = lookup_bdev(path, &devt);
> -		if (ret)
> -			btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
> -				   path, ret);
> -		else
> -			btrfs_free_stale_devices(devt, NULL);
> -
> -		pr_debug("BTRFS: skip registering single non-seed device %s\n", path);
> -		device = NULL;
> -		goto free_disk_super;
> -	}
> +	if (mount_arg_dev || btrfs_super_num_devices(disk_super) != 1 ||
> +	    (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
> +		new_device_added = true;

This is the line I was referring to in the comment above, fwiw.

>  
>  	device = device_list_add(path, disk_super, &new_device_added);
>  	if (!IS_ERR(device) && new_device_added)
>  		btrfs_free_stale_devices(device->devt, device);
>  
> -free_disk_super:
>  	btrfs_release_disk_super(disk_super);
>  
>  error_bdev_put:
> 
> -- 
> 2.42.1
> 

