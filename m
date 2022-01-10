Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CC9489C0A
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 16:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbiAJPUQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 10:20:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48948 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbiAJPUQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 10:20:16 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5A03C210FB;
        Mon, 10 Jan 2022 15:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641828015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FN7B3jEv2EVwejgp4xy8mDm/wRBOLkwgwTTHs509VNE=;
        b=pm0jjo8VP8GlhPTYXCr41AYrKk6iYnXpR46u6aFtBHZb0G2xUeXmWl3xRIsOCnfegwIKcQ
        A0jbj88sYibJyTnKlWsofmQPttQbsyoLhxS3d5ut1c5TUAdQpG5vT+/irxsQ0AN5LKNb9m
        jEkNvBs2+YOMJaO4P3aZ0LGAQfLmzm8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F22DB13D88;
        Mon, 10 Jan 2022 15:20:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VKWKN65O3GHjeAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 10 Jan 2022 15:20:14 +0000
Subject: Re: [PATCH v4 2/4] btrfs: redeclare btrfs_stale_devices arg1 to dev_t
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, l@damenly.su
References: <cover.1641794058.git.anand.jain@oracle.com>
 <d05f560ad6b65dd6fd7fca0e54271d3d0d8a3f8b.1641794058.git.anand.jain@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <df5e06aa-5ed4-0df2-9210-ea8d19069cba@suse.com>
Date:   Mon, 10 Jan 2022 17:20:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <d05f560ad6b65dd6fd7fca0e54271d3d0d8a3f8b.1641794058.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.01.22 г. 15:23, Anand Jain wrote:
> After the commit (btrfs: harden identification of the stale device), we
> don't have to match the device path anymore. Instead, we match the dev_t.
> So pass in the dev_t instead of the device-path, in the call chain
> btrfs_forget_devices()->btrfs_free_stale_devices().
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v4: Change log updated drop commit id
>     Use name[0] instead of strlen()
>     Change logic from !lookup_bdev() to lookup_bdev == 0
> v3: -
> 
>  fs/btrfs/super.c   |  8 +++++++-
>  fs/btrfs/volumes.c | 51 +++++++++++++++++++++++++---------------------
>  fs/btrfs/volumes.h |  2 +-
>  3 files changed, 36 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 1ff03fb6c64a..6eca93096ca5 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2386,6 +2386,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>  {
>  	struct btrfs_ioctl_vol_args *vol;
>  	struct btrfs_device *device = NULL;
> +	dev_t devt = 0;
>  	int ret = -ENOTTY;
>  
>  	if (!capable(CAP_SYS_ADMIN))
> @@ -2405,7 +2406,12 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>  		mutex_unlock(&uuid_mutex);
>  		break;
>  	case BTRFS_IOC_FORGET_DEV:
> -		ret = btrfs_forget_devices(vol->name);
> +		if (vol->name[0] != '\0') {
> +			ret = lookup_bdev(vol->name, &devt);
> +			if (ret)
> +				break;
> +		}
> +		ret = btrfs_forget_devices(devt);
>  		break;
>  	case BTRFS_IOC_DEVICES_READY:
>  		mutex_lock(&uuid_mutex);

<snip>

> @@ -577,16 +572,16 @@ static int device_matched(struct btrfs_device *device, const char *path)
>  /*
>   *  Search and remove all stale (devices which are not mounted) devices.
>   *  When both inputs are NULL, it will search and release all stale devices.
> - *  path:	Optional. When provided will it release all unmounted devices
> - *		matching this path only.
> + *  devt:	Optional. When provided will it release all unmounted devices
> + *		matching this devt only.
>   *  skip_dev:	Optional. Will skip this device when searching for the stale
>   *		devices.
> - *  Return:	0 for success or if @path is NULL.
> - * 		-EBUSY if @path is a mounted device.
> - * 		-ENOENT if @path does not match any device in the list.
> + *  Return:	0 for success or if @devt is 0.
> + *		-EBUSY if @devt is a mounted device.
> + *		-ENOENT if @devt does not match any device in the list.
>   */
> -static int btrfs_free_stale_devices(const char *path,
> -				     struct btrfs_device *skip_device)
> +static int btrfs_free_stale_devices(dev_t devt,
> +				    struct btrfs_device *skip_device)
>  {
>  	struct btrfs_fs_devices *fs_devices, *tmp_fs_devices;
>  	struct btrfs_device *device, *tmp_device;
> @@ -594,7 +589,7 @@ static int btrfs_free_stale_devices(const char *path,
>  
>  	lockdep_assert_held(&uuid_mutex);
>  
> -	if (path)
> +	if (devt)
>  		ret = -ENOENT;
>  
>  	list_for_each_entry_safe(fs_devices, tmp_fs_devices, &fs_uuids, fs_list) {
> @@ -604,14 +599,14 @@ static int btrfs_free_stale_devices(const char *path,
>  					 &fs_devices->devices, dev_list) {
>  			if (skip_device && skip_device == device)
>  				continue;
> -			if (path && !device->name)
> +			if (devt && !device->name)

This check is now rendered obsolete since ->name is used iff we have
passed a patch to match against it, but since your series removes the
path altogether having device->name becomes obsolete, hence it can be
removed.

<snip>
