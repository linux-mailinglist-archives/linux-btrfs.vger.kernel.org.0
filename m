Return-Path: <linux-btrfs+bounces-2110-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 297DA849B41
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 14:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31E51F27512
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 13:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B88A35F0C;
	Mon,  5 Feb 2024 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f5C6S3E8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fgqlJr6B";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m5nzZvfv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2cJC/LNW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DAD1CA91
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137856; cv=none; b=KuIi+SVa5X2XKQTpCAadBCXNf+6qBIAiMBJK+G8ginv4c7tdI/vmACv09AIe24odnK7kitiycNBPLfqf9bJYya1D4aHerk5g6N14rWTsD18QyNttgsoHRxiSIHAcZncIug5BCXpkidSvJHvxZS5dbci8cVxj82IKMMXOnoHlQKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137856; c=relaxed/simple;
	bh=eSaxwLQBtu7BuFapxEuI56sm1ut/noJkhDe4EpRA6TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVouKSCBou2zJRf156DxC7e1maAofhCjhjbppm3M9V6sNbvmJ8i/Zkay1AIBGIwlqzWFNyrwVkkaN2MqefBzj/xcLI3uAXeUNidoGG6JQMdxpfICBgrZNEJ4VUf/5/jqKLwc/vP+bfj5JfDGA9qX+zRHQj+1oRV2IoiAjtpJ2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f5C6S3E8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fgqlJr6B; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m5nzZvfv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2cJC/LNW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E47D61F8C2;
	Mon,  5 Feb 2024 12:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707137853;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+X9e9CZhbqLm1NcrKhMRqywteDdoKXWuPcwq6XtsHq4=;
	b=f5C6S3E8CpDykNvCrTlNz5k8NxlrsKMPDGZWr0JFwTgXN4MuJbMKiarghUK4AEyZqIABD6
	6rbPXQWHE7M7X2Td/HspErCoAxNsHKF/8jT5nwV6rPPqCootH6wriYjsFP1CiRscKEMY7y
	qusyOep3B/FW+Qc7whqFna9WmVcWehc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707137853;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+X9e9CZhbqLm1NcrKhMRqywteDdoKXWuPcwq6XtsHq4=;
	b=fgqlJr6BHd6adFqSe1dgBYQjXLSNj164hM1MPeuemxr7v7hyI/x7KWlGNhGBX2/qdi5G/S
	8UvzYDQeHqLeOaDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707137852;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+X9e9CZhbqLm1NcrKhMRqywteDdoKXWuPcwq6XtsHq4=;
	b=m5nzZvfv8Mi3Xg1ag9t1Efj+LXfRIENmJgkhRm063iZ4bF7ANpxCNRJxb/7jv5MeycMuwu
	NXjrnqClUKdNZIHcZOxG0m3bmH2wuYEqGGMuQfUw26OOeEnwBQHN6cwjhhPS7bO3k1JD3T
	ut9ivaEVald+srA5zafyIzteRDA8CCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707137852;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+X9e9CZhbqLm1NcrKhMRqywteDdoKXWuPcwq6XtsHq4=;
	b=2cJC/LNWQjmW8WubpWzEfTGHe6IFr6YgjWQFfIm6+bcNffLR+wsq+FnQYA48k9tlKq4KsY
	Bw8WH6lckOfjyeDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C477A13A3B;
	Mon,  5 Feb 2024 12:57:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wLRoLzzbwGUeVwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 05 Feb 2024 12:57:32 +0000
Date: Mon, 5 Feb 2024 13:57:04 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, aromosan@gmail.com,
	bernd.feige@gmx.net
Subject: Re: [PATCH] btrfs: do not skip re-registration for the mounted device
Message-ID: <20240205125704.GD355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8dd1990114aabb775d4631969f1beabeadaac5b7.1707132247.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dd1990114aabb775d4631969f1beabeadaac5b7.1707132247.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,gmail.com,gmx.net];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Mon, Feb 05, 2024 at 07:45:05PM +0800, Anand Jain wrote:
> We skip device registration for a single device. However, we do not do
> that if the device is already mounted, as it might be coming in again
> for scanning a different path.
> 
> This patch is lightly tested; for verification if it fixes.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> I still have some unknowns about the problem. Pls test if this fixes
> the problem.
> 
>  fs/btrfs/volumes.c | 44 ++++++++++++++++++++++++++++++++++----------
>  fs/btrfs/volumes.h |  1 -
>  2 files changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 474ab7ed65ea..192c540a650c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1299,6 +1299,31 @@ int btrfs_forget_devices(dev_t devt)
>  	return ret;
>  }
>  
> +static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
> +				    dev_t devt, bool mount_arg_dev)
> +{
> +	struct btrfs_fs_devices *fs_devices;
> +
> +	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
> +		struct btrfs_device *device;
> +
> +		mutex_lock(&fs_devices->device_list_mutex);
> +		list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +			if (device->devt == devt) {
> +				mutex_unlock(&fs_devices->device_list_mutex);
> +				return false;
> +			}
> +		}
> +		mutex_unlock(&fs_devices->device_list_mutex);

This is locking and unlocking again before going to device_list_add, so
if something changes regarding the registered device then it's not up to
date.


> +	}
> +
> +	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
> +	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
> +		return true;

The way I implemented it is to check the above conditions as a
prerequisite but leave the heavy work for device_list_add that does all
the uuid and device list locking and we are quite sure it survives all
the races between scanning and mounts.

> +
> +	return false;
> +}
> +
>  /*
>   * Look for a btrfs signature on a device. This may be called out of the mount path
>   * and we are not allowed to call set_blocksize during the scan. The superblock
> @@ -1316,6 +1341,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>  	struct btrfs_device *device = NULL;
>  	struct bdev_handle *bdev_handle;
>  	u64 bytenr, bytenr_orig;
> +	dev_t devt = 0;
>  	int ret;
>  
>  	lockdep_assert_held(&uuid_mutex);
> @@ -1355,18 +1381,16 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>  		goto error_bdev_put;
>  	}
>  
> -	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
> -	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
> -		dev_t devt;
> +	ret = lookup_bdev(path, &devt);
> +	if (ret)
> +		btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
> +			   path, ret);
>  
> -		ret = lookup_bdev(path, &devt);

Do we actually need this check? It was added with the patch skipping the
registration, so it's validating the block device but how can we pass
something that is not a valid block device?

Besides there's a call to bdev_open_by_path() that in turn does the
lookup_bdev so checking it here is redundant. It's not related to the
fix itself but I deleted it in my fix.

> -		if (ret)
> -			btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
> -				   path, ret);
> -		else
> +	if (btrfs_skip_registration(disk_super, devt, mount_arg_dev)) {
> +		pr_debug("BTRFS: skip registering single non-seed device %s\n",
> +			  path);
> +		if (devt)
>  			btrfs_free_stale_devices(devt, NULL);
> -
> -		pr_debug("BTRFS: skip registering single non-seed device %s\n", path);
>  		device = NULL;
>  		goto free_disk_super;
>  	}

