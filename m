Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293CE487A3D
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 17:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348214AbiAGQVy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jan 2022 11:21:54 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:36752 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239927AbiAGQVx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jan 2022 11:21:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 443D9212C4;
        Fri,  7 Jan 2022 16:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641572512;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZHnanJHoijlKeIlXhD8xNQw9ST5FrpeDcYM4llNR1gE=;
        b=AilARyRnqTrIxw4DfrF1rhSYkNLXDiVZH0eti8G2Gc2rSpxXfshg0VK5pPocd1rBVcsBOw
        xTtxAnjADOwdScsprqGSKx0vdFdD47a617jsAduiX6EY/SN3a4Lt0eVim7wEyYYGhgc5wg
        W6hXmNpLXflTz18U8sAl3wfpQPxMUuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641572512;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZHnanJHoijlKeIlXhD8xNQw9ST5FrpeDcYM4llNR1gE=;
        b=frBRADV0AJA0Y5oszqnYRJv+cvSubk2j2KCmvXA1hALdsy/Z/GYSnzBUVxq4Ilf8KxncWP
        2x6GiUc2LkM5eaBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9DE51A3B83;
        Fri,  7 Jan 2022 16:21:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 68C99DA7A9; Fri,  7 Jan 2022 17:21:21 +0100 (CET)
Date:   Fri, 7 Jan 2022 17:21:20 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.com, nborisov@suse.com, l@damenly.su
Subject: Re: [PATCH v3 1/4] btrfs: harden identification of the stale device
Message-ID: <20220107162120.GO14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com,
        nborisov@suse.com, l@damenly.su
References: <cover.1641535030.git.anand.jain@oracle.com>
 <e418fd929f03644b70c6be6a1b081bb97dbed254.1641535030.git.anand.jain@oracle.com>
 <20220107160603.GL14046@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107160603.GL14046@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 07, 2022 at 05:06:04PM +0100, David Sterba wrote:
> On Fri, Jan 07, 2022 at 09:04:13PM +0800, Anand Jain wrote:
> > Identifying and removing the stale device from the fs_uuids list is done
> > by the function btrfs_free_stale_devices().
> > btrfs_free_stale_devices() in turn depends on the function
> > device_path_matched() to check if the device repeats in more than one
> > btrfs_device structure.
> > 
> > The matching of the device happens by its path, the device path. However,
> > when dm mapper is in use, the dm device paths are nothing but a link to
> > the actual block device, which leads to the device_path_matched() failing
> > to match.
> > 
> > Fix this by matching the dev_t as provided by lookup_bdev() instead of
> > plain strcmp() the device paths.
> > 
> > Reported-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > ---
> > v3: -
> > v2: Fix 
> >      sparse: warning: incorrect type in argument 1 (different address spaces)
> >      For using device->name->str
> > 
> >     Fix Josef suggestion to pass dev_t instead of device-path in the
> >      patch 2/2.
> > 
> >  fs/btrfs/volumes.c | 41 ++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 36 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 4b244acd0cfa..ad9e08c3199c 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -535,15 +535,46 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
> >  	return ret;
> >  }
> >  
> > -static bool device_path_matched(const char *path, struct btrfs_device *device)
> > +/*
> > + * Check if the device in the 'path' matches with the device in the given
> > + * struct btrfs_device '*device'.
> > + * Returns:
> > + *	0	If it is the same device.
> > + *	1	If it is not the same device.
> 
> The logic is reversed, as the function looks like a predicate, so it
> should return a positive value if the condition is true. It's apparent a
> the end.
> 
> > + *	-errno	For error.
> > + */
> > +static int device_matched(struct btrfs_device *device, const char *path)
> >  {
> > -	int found;
> > +	char *device_name;
> > +	dev_t dev_old;
> > +	dev_t dev_new;
> > +	int ret;
> > +
> > +	device_name = kzalloc(BTRFS_PATH_NAME_MAX, GFP_KERNEL);
> > +	if (!device_name)
> > +		return -ENOMEM;
> >  
> >  	rcu_read_lock();
> > -	found = strcmp(rcu_str_deref(device->name), path);
> > +	ret = sprintf(device_name, "%s", rcu_str_deref(device->name));
> 
> Should this use scnprintf instead? That could check the length
> BTRFS_PATH_NAME_MAX too, so we don't have to do strncpy and verify the
> length manually.
> 
> >  	rcu_read_unlock();
> > +	if (!ret) {
> > +		kfree(device_name);
> > +		return -EINVAL;
> > +	}
> >  
> > -	return found == 0;
> > +	ret = lookup_bdev(device_name, &dev_old);
> > +	kfree(device_name);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = lookup_bdev(path, &dev_new);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (dev_old == dev_new)
> > +		return 0;
> 
> Here it's confusing, it's returning 0 ("false") but checking for
> equality. It's probably to be able to merge the false and error value
> to the same check, but then the helper is a bit inconsistent with the
> predicate-like ones. If the errors are handled internally and the
> result is true/false then it's ok, but still a bit confusing in case
> it's not used in context of the stale devices (where we know the errors
> don't matter).

The last patch removes this helper completely so it would be pointless
to optimize this function, so you can ignore the comments above.

> 
> > +
> > +	return 1;
> >  }
> >  
> >  /*
> > @@ -578,7 +609,7 @@ static int btrfs_free_stale_devices(const char *path,
> >  				continue;
> >  			if (path && !device->name)
> >  				continue;
> > -			if (path && !device_path_matched(path, device))
> > +			if (path && device_matched(device, path) != 0)
> >  				continue;
> >  			if (fs_devices->opened) {
> >  				/* for an already deleted device return 0 */
> > -- 
> > 2.33.1
