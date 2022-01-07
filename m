Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9EC487936
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 15:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbiAGOsl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jan 2022 09:48:41 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52212 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbiAGOsk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jan 2022 09:48:40 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C998B1F39C;
        Fri,  7 Jan 2022 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641566919;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w5tXwO+zzbtJ7Qd/YhEn+oRMvYnb/8iZYBpzNIx+SjI=;
        b=DPdvAEOQH0uFEX0cOL5hGgaSg8clqeW1wxXi+OWofOibOfw7cLAr38/LCO6XDQmqixmRQM
        M+0jEXTnUbmi5lBvnqOdYWjrtbf0AI0gP3Xo63CSfft2wL2gmwgqoa2B+KKDrX4BiCgKcw
        YCuSMnoY9FZqxQp2lOmpLGiU9apgW38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641566919;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w5tXwO+zzbtJ7Qd/YhEn+oRMvYnb/8iZYBpzNIx+SjI=;
        b=vUPEI9oGax0ciir5fHxUKSPdqozPr4q/u2PCNepkZpsx24zzHcVNzzTuFSAG/c3D3mBwp0
        A4J7/QSP28CwKTAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BCE07A3B88;
        Fri,  7 Jan 2022 14:48:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A5B57DA7A9; Fri,  7 Jan 2022 15:48:08 +0100 (CET)
Date:   Fri, 7 Jan 2022 15:48:07 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH v2 1/2] btrfs: harden identification of the stale device
Message-ID: <20220107144807.GK14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com
References: <cover.1639155519.git.anand.jain@oracle.com>
 <612eac6f9309cbee107afbbd4817c0a628207438.1639155519.git.anand.jain@oracle.com>
 <20220104185611.GX28560@twin.jikos.cz>
 <4210807a-c727-19be-9f72-797f0e1897f2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4210807a-c727-19be-9f72-797f0e1897f2@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 05, 2022 at 07:31:31PM +0800, Anand Jain wrote:
> 
> 
> On 05/01/2022 02:56, David Sterba wrote:
> > On Sat, Dec 11, 2021 at 02:15:29AM +0800, Anand Jain wrote:
> >> Identifying and removing the stale device from the fs_uuids list is done
> >> by the function btrfs_free_stale_devices().
> >> btrfs_free_stale_devices() in turn depends on the function
> >> device_path_matched() to check if the device repeats in more than one
> >> btrfs_device structure.
> >>
> >> The matching of the device happens by its path, the device path. However,
> >> when dm mapper is in use, the dm device paths are nothing but a link to
> >> the actual block device, which leads to the device_path_matched() failing
> >> to match.
> >>
> >> Fix this by matching the dev_t as provided by lookup_bdev() instead of
> >> plain strcmp() the device paths.
> >>
> >> Reported-by: Josef Bacik <josef@toxicpanda.com>
> >> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >> ---
> >>
> >> v2: Fix
> >>       sparse: warning: incorrect type in argument 1 (different address spaces)
> >>       For using device->name->str
> >>
> >>      Fix Josef suggestion to pass dev_t instead of device-path in the
> >>       patch 2/2.
> >>
> >>   fs/btrfs/volumes.c | 41 ++++++++++++++++++++++++++++++++++++-----
> >>   1 file changed, 36 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >> index 1b02c03a882c..559fdb0c4a0e 100644
> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -534,15 +534,46 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
> >>   	return ret;
> >>   }
> >>   
> >> -static bool device_path_matched(const char *path, struct btrfs_device *device)
> >> +/*
> >> + * Check if the device in the 'path' matches with the device in the given
> >> + * struct btrfs_device '*device'.
> >> + * Returns:
> >> + *	0	If it is the same device.
> >> + *	1	If it is not the same device.
> >> + *	-errno	For error.
> >> + */
> >> +static int device_matched(struct btrfs_device *device, const char *path)
> >>   {
> >> -	int found;
> >> +	char *device_name;
> >> +	dev_t dev_old;
> >> +	dev_t dev_new;
> >> +	int ret;
> >> +
> >> +	device_name = kzalloc(BTRFS_PATH_NAME_MAX, GFP_KERNEL);
> >> +	if (!device_name)
> >> +		return -ENOMEM;
> >>   
> >>   	rcu_read_lock();
> >> -	found = strcmp(rcu_str_deref(device->name), path);
> >> +	ret = sprintf(device_name, "%s", rcu_str_deref(device->name));
> > 
> > I wonder if the temporary allocation could be avoided, as it's the
> > exactly same path of the device, so it could be passed to lookup_bdev.
> 
>   Yeah, I tried but to no avail. Unless I drop the rcu read lock and
>   use the str directly as below.
> 
>   lookup_bdev(device->name->str, &dev_old);
> 
>   We do skip rcu access for device->name at a few locations.
> 
>   Also, pls note lookup_bdev() can't be called within rcu_read_lock(),
>   (calling sleep function warning).

I see, thank for checking it.

> 
> 
> >>   	rcu_read_unlock();
> >> +	if (!ret) {
> >> +		kfree(device_name);
> >> +		return -EINVAL;
> >> +	}
> >>   
> >> -	return found == 0;
> >> +	ret = lookup_bdev(device_name, &dev_old);
> >> +	kfree(device_name);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = lookup_bdev(path, &dev_new);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (dev_old == dev_new)
> >> +		return 0;
> >> +
> >> +	return 1;
> >>   }
> >>   
> >>   /*
> >> @@ -577,7 +608,7 @@ static int btrfs_free_stale_devices(const char *path,
> >>   				continue;
> >>   			if (path && !device->name)
> >>   				continue;
> >> -			if (path && !device_path_matched(path, device))
> >> +			if (path && device_matched(device, path) != 0)
> > 
> > You've changed the fuction to return errors but it's not checked,
> > besides the memory allocation failure, the lookup functions could fail
> > for various reasons so I don't think it's safe to ignore the errors.
> 
> IMO there isn't much that the parent function should do even if the
> device_matched() returns an error for the reasons you stated.
> 
> Mainly because btrfs_free_stale_devices() OR btrfs_forget_devices()
> is used as a cleanup ops in the primary task functions such as
> btrfs_scan_one_device() and btrfs_init_new_device(). Even if we don't
> remove the stale there is no harm.

Right, so a comment explaining why it's ok to ignore errors should be
sufficient.

> Further btrfs_forget_devices() is called from btrfs_control_ioctl()
> which is a userland call for forget devices. So as we traverse the
> device list, if a device lookup fails IMO, it is ok to skip to the next
> device in the list and return the status of the device match.
> 
> Even more, IMO we should save the dev_t in the struct btrfs_device,
> upon which the device_matched() will go away altogether. This change
> is outside of the bug that we intended to fix here. I will clean that
> up separately.
