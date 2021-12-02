Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2335F466787
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 17:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359354AbhLBQGD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 11:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347760AbhLBQFo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 11:05:44 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1BDC06174A
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 08:02:21 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id 8so167840qtx.5
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Dec 2021 08:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wowS4XMOK3CpLMYIRzlfN9814Nb/xsHKor2pxowFUUE=;
        b=xB8EMPJZe1HtKH4NVJYhDDaPKXR2DlBQ5icmucAHdHiCUyhBYLb9leIcF7ipHUV5nS
         y8QyIEQjtIIDJyJtbGsKGN5bcAA7T90YU5Jsrz9yLOTxx/IdxT3iZip7iLMWk4P21pzl
         b2mTh1k+HaxBJKvdEu8WOQZLJIKihxLZ0q1DlFEegcepKpa8M3n73ws0L9x8tSeDTWWv
         13SvWk8TmM8Vhf2SJWXfrdt+utmQd7h0tAULX7R2tM0/aGuAiLRCstitVcMFT0dtzU8W
         lATUTxzoUuilbjC0dRTGiLhkNVIYtRb/a91t7es13AP5r3deEeM5bI7kd+cjh5kOxP1m
         nrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wowS4XMOK3CpLMYIRzlfN9814Nb/xsHKor2pxowFUUE=;
        b=oG4ap4Q7SdydvTltDUxyAYW1d90c7PUlOoFmoFomn0dLXfQch3THWJpitjpkD8zJKA
         aUErd+zkCaEoDyuOC5IrHu7j7FIIqHvSAUgEGpysRDnUkxUDNyXTOAGMUKGrIM/h9CUq
         Dm1vGmjMPzw51JEuwwIoqE/wvOurs5XMQ90VD6hIUf/rkqFhaaYy8xofcxNrNWxqUyQ5
         YQUab7ud4e4Dl6By6RIkqhc6Rc0Ii6s/PddwQDTgRXSt1ufFIVTvOxS8VWw5keCEs3fZ
         ohlatottlkVXEBOJz4GQdbJHXcBynXaahrhEM3iebsQhT1kXKLHIfVqoog1dMxCXRFE6
         3+Ig==
X-Gm-Message-State: AOAM530qNEiPFBwoZgq0/NuAIp1ga8QWrY9OerGuI9AQ+TIhz3FeG6re
        W9dkJkzGSxAzDvz8IzhM6Zfe58Inbm615A==
X-Google-Smtp-Source: ABdhPJx01TOt+SFRJdtwVjQZfuloFuqbnBsq3YgphdWo3iX48WZNLQBtxeAMd5rxPq4IHVbOSxyGYQ==
X-Received: by 2002:a05:622a:609:: with SMTP id z9mr14504749qta.243.1638460940770;
        Thu, 02 Dec 2021 08:02:20 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s2sm63315qtw.22.2021.12.02.08.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 08:02:18 -0800 (PST)
Date:   Thu, 2 Dec 2021 11:02:17 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: free device if we fail to open it
Message-ID: <YajuCbMN4H0Ap76V@localhost.localdomain>
References: <7cfd63a1232900565abf487e82b7aa4af5fbca29.1638393521.git.josef@toxicpanda.com>
 <fdd4a2c9-00dd-430c-0537-d43734337845@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdd4a2c9-00dd-430c-0537-d43734337845@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 02, 2021 at 03:09:38PM +0800, Anand Jain wrote:
> On 02/12/2021 05:18, Josef Bacik wrote:
> > We've been having transient failures of btrfs/197 because sometimes we
> > don't show a missing device.
> 
> > This turned out to be because I use LVM for my devices, and sometimes we
> > race with udev and get the "/dev/dm-#" device registered as a device in
> > the fs_devices list instead of "/dev/mapper/vg0-lv#" device.
> >  Thus when
> > the test adds a device to the existing mount it doesn't find the old
> > device in the original fs_devices list and remove it properly.
> 

I think most of your confusion is because you don't know what btrfs/197 does, so
I'll explain that and then answer your questions below.

DEV=/dev/vg0/lv0
RAID_DEVS=/dev/vg0/lv1 /dev/vg0/lv2 /dev/vg0/vl3 /dev/vg0/lv4

# First we create a single fs and mount it
mkfs.btrfs -f $DEV
mount $DEV /mnt/test

# Now we create the RAID fs
mkfs.btrfs -f -d raid10 -m raid10 $RAID_DEVS

# Now we add one of the raid devs to the single mount above
btrfs device add /dev/vg0/lv2 /mnt/test

# /dev/vg0/lv2 is no longer part of the fs it was made on, it's part of the fs
# that's mounted at /mnt/test

# Mount degraded with the raid setup
mount -o degraded /dev/vg0/lv1 /mnt/scratch

# Now we shouldn't have found /dev/vg0/lv2, because it was wiped and is no
# longer part of the fs_devices for this thing, except it is because it wasn't
# removed, so when we do the following it doesn't show as missing
btrfs filesystem show /mnt/scratch

>  The above para is confusing. It can go. IMHO. The device path shouldn't
>  matter as we depend on the bdev to compare in the device add thread.
> 
> 2637         bdev = blkdev_get_by_path(device_path, FMODE_WRITE |
> FMODE_EXCL,
> 2638                                   fs_info->bdev_holder);
> ::
> 2657         list_for_each_entry_rcu(device, &fs_devices->devices, dev_list)
> {
> 2658                 if (device->bdev == bdev) {
> 2659                         ret = -EEXIST;
> 2660                         rcu_read_unlock();
> 2661                         goto error;
> 2662                 }
> 2663         }
> 

This is on the init thread, this is just checking the fs_devices of /mnt/test,
not the fs_devices of the RAID setup that we created, so this doesn't error out
(nor should it) because we're adding it to our mounted fs.

> 
> > This is fine in general, because when we open the devices we check the
> > UUID, and properly skip using the device that we added to the other file
> > system.  However we do not remove it from our fs_devices,
> 
> Hmm, context/thread is missing. Like, is it during device add or during
> mkfs/dev-scan?
> 
> AFAIK btrfs_free_stale_devices() checks and handles the removing of stale
> devices in the fs_devices in both the contexts/threads device-add, mkfs
> (device-scan).
> 
>  For example:
> 
> $ alias cnt_free_stale_devices="bpftrace -e 'kprobe:btrfs_free_stale_devices
> { @ = count(); }'"
> 
> New FSID on 2 devices, we call free_stale_devices():
> 
> $ cnt_free_stale_devices -c 'mkfs.btrfs -fq -draid1 -mraid1 /dev/vg/scratch0
> /dev/vg/scratch1'
> Attaching 1 probe...
> 
> @: 2
> 
>  We do it only when there is a new fsid/device added to the fs_devices.
> 
> For example:
> 
> Clean up the fs_devices:
> $ cnt_free_stale_devices -c 'btrfs dev scan --forget'
> Attaching 1 probe...
> 
> @: 1
> 
> Now mounting devices are new to the fs_devices list, so call
> free_stale_devices().
> 
> $ cnt_free_stale_devices -c 'mount -o device=/dev/vg/scratch0
> /dev/vg/scratch1 /btrfs'
> Attaching 1 probe...
> 
> @: 2
> 
> $ umount /btrfs
> 
> Below we didn't call free_stale_devices() because these two devices are
> already in the appropriate fs_devices.
> 
> $ cnt_free_stale_devices -c 'mount -o device=/dev/vg/scratch0
> /dev/vg/scratch1 /btrfs'
> Attaching 1 probe...
> 
> @: 0
> 
> $
> 
> To me, it looks to be working correctly.
> 

Yes it does work correctly, most of the time.  If you run it in a loop 500 times
it'll fail, because _sometimes_ udev goes in and does teh btrfs device scan and
changes the name of the device in the fs_devices for the RAID group.  So the
btrfs_free_stale_devices() thing doesn't find the exising device, because it's
just looking at the device->name, which is different from the device we're
adding.

We have the fs_devices for the RAID fs, and instead of /dev/vg0/lv2, we have
/dev/dm-4 or whatever.  So we do the addition of /dev/vg0/lv2, go to find it in
any other fs_devices, and don't find it because strcmp("/dev/vg0/lv2",
"/dev/dm0-4") != 0, and thus leave the device on the fs_devices for the RAID
file system.

> > so when we get
> > the device info we still see this old device and think that everything
> > is ok.
> 
> 
> > We have a check for -ENODATA coming back from reading the super off of
> > the device to catch the wipefs case, but we don't catch literally any
> > other error where the device is no longer valid and thus do not remove
> > the device.
> > 
> 
> > Fix this to not special case an empty device when reading the super
> > block, and simply remove any device we are unable to open.
> > 
> > With this fix we properly print out missing devices in the test case,
> > and after 500 iterations I'm no longer able to reproduce the problem,
> > whereas I could usually reproduce within 200 iterations.
> > 
> 
> commit 7f551d969037 ("btrfs: free alien device after device add")
> fixed the case we weren't freeing the stale device in the device-add
> context.
> 
> However, here I don't understand the thread/context we are missing to free
> the stale device here.
> 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >   fs/btrfs/disk-io.c | 2 +-
> >   fs/btrfs/volumes.c | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 5c598e124c25..fa34b8807f8d 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -3924,7 +3924,7 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
> >   	super = page_address(page);
> >   	if (btrfs_super_magic(super) != BTRFS_MAGIC) {
> >   		btrfs_release_disk_super(super);
> > -		return ERR_PTR(-ENODATA);
> > +		return ERR_PTR(-EINVAL);
> >   	}
> 
>  I think you are removing ENODATA because it is going away in the parent
> function. And, we don't reach this condition in the test case btrfs/197.
>  Instead, we fail here at line 645 below and, we return -EINVAL;

I'm changing it to be consistent, instead of special casing this one specific
failure, just treat all failures like we need to remove the device, and thus we
can just make this be EINVAL as well.

> 
>  645         if (memcmp(device->uuid, disk_super->dev_item.uuid,
> BTRFS_UUID_SIZE))
>  646                 goto error_free_page;
>  647
> 
>  687 error_free_page:
>  688         btrfs_release_disk_super(disk_super);
>  689         blkdev_put(bdev, flags);
>  690
>  691         return -EINVAL;
> 
> function stack carries the return code to the parent open_fs_devices().
> 
> open_fs_devices()
>  btrfs_open_one_device()
>   btrfs_get_bdev_and_sb()
>    btrfs_read_dev_super()
>     btrfs_read_dev_one_super()
> 
> 
> 
> >   	if (btrfs_super_bytenr(super) != bytenr_orig) {
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index f38c230111be..890153dd2a2b 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -1223,7 +1223,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
> >   		if (ret == 0 &&
> >   		    (!latest_dev || device->generation > latest_dev->generation)) {
> >   			latest_dev = device;
> > -		} else if (ret == -ENODATA) {
> > +		} else if (ret) {
> >   			fs_devices->num_devices--;
> >   			list_del(&device->dev_list);
> >   			btrfs_free_device(device);
> > 
> 
> There are many other cases, for example including -EACCES (from
> blkdev_get_by_path()) (I haven't checked other error codes). For which,
> calling btrfs_free_device() is inappropriate.

Yeah I was a little fuzzy on this.  I think *any* failure should mean that we
remove the device from the fs_devices tho right?  So that we show we're missing
a device, since we can't actually access it?  I'm actually asking, because I
think we can go either way, but to me I think any failure sure result in the
removal of the device so we can re-scan the correct one.  Thanks,

Josef
