Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42C5467A08
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 16:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381717AbhLCPLt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 10:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381715AbhLCPLg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 10:11:36 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F6FC061354
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 07:08:12 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id n15so3608525qta.0
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 07:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kvm0wUkvuFkbAVCEJwGUPyM+wgYHMeZOlfpKJAknjjk=;
        b=46SvrIfporQ6oT9WzLghJA2DutSwR5MDLZ/IvJUDEqkefhtL05pYtuKEuWXasA2Lfd
         lIrErBGIZJE+E2S5snBM4CuXU7Rz4G6ZoOkMZ/iF+8AKuUgl4PJ8kRiWYZtntoW67P9c
         PBw6nvXZOKKozY9opt886AQjHC1b9ZdBKeG/WBwbH79AZj4za6igG6BXBHOQFOcJQVTo
         s7gQ9cp2vOOa0QYX1Fr78YYHpdUTHIMppht5LePbdKHYOoL3/MUYGja/zh+djxs4hTBe
         0lcgGHU/SLD3pKek4LSZ98+lrA7Wd6USi+Cgj+k0V85qzBihKqMN/BN1kUMBlEKF9otN
         EaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kvm0wUkvuFkbAVCEJwGUPyM+wgYHMeZOlfpKJAknjjk=;
        b=CcmzyuH9z8WairmTd3qDX+HwlLRoGU1eJAQrCb9Pg/N3BduaDP0q5vbiEnrVEwxrZG
         IxA1+r9lqiVGKeB0jYOQGOtMRuObmrBVFbjJUFkDc/9dVT15YBb4iUOKHdWXoYG7RoLC
         VB7dF9yuq36Kx+eh5/DOesSQwdXplO20tKgqgO7YnljhrWoyXW5JxsLhokynhMP10R94
         Yc6PS9zfdl+7ZlOW5wgvb2ESOqyoMPyVQW7prR0COecGzO+fE/QteeCcB+juylHcwu9M
         wwflHmrLr3CnOCzRqSDyfpkgWyIWNxkwoHCOk2oV39kR7Ghg7pdM72wrjuBgUE+mkDfM
         tfXg==
X-Gm-Message-State: AOAM5331wCqcdx/4N1rpo7W72frkKXVfGyxZxVSlRIPAB51UBw22yAW/
        hRuyO7N2qWsPwKFgomjVWN5IVlRHk+lqXQ==
X-Google-Smtp-Source: ABdhPJyIOVPbX5fnWVJ+MdFiY6YMGK+iPTv13/jLU83eRmzjkHHDXyw1HqZ1pM+Or/GW0Ikjh8ihGw==
X-Received: by 2002:a05:622a:190a:: with SMTP id w10mr21297455qtc.224.1638544090525;
        Fri, 03 Dec 2021 07:08:10 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a17sm2111647qkp.108.2021.12.03.07.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 07:08:10 -0800 (PST)
Date:   Fri, 3 Dec 2021 10:08:08 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: free device if we fail to open it
Message-ID: <Yaoy2Ib85CZ/QJXs@localhost.localdomain>
References: <7cfd63a1232900565abf487e82b7aa4af5fbca29.1638393521.git.josef@toxicpanda.com>
 <fdd4a2c9-00dd-430c-0537-d43734337845@oracle.com>
 <YajuCbMN4H0Ap76V@localhost.localdomain>
 <b25ba451-18f3-073f-0691-c99b10fd8c9a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b25ba451-18f3-073f-0691-c99b10fd8c9a@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 03, 2021 at 04:31:49PM +0800, Anand Jain wrote:
> 
> 
> On 03/12/2021 00:02, Josef Bacik wrote:
> > On Thu, Dec 02, 2021 at 03:09:38PM +0800, Anand Jain wrote:
> > > On 02/12/2021 05:18, Josef Bacik wrote:
> > > > We've been having transient failures of btrfs/197 because sometimes we
> > > > don't show a missing device.
> > > 
> > > > This turned out to be because I use LVM for my devices, and sometimes we
> > > > race with udev and get the "/dev/dm-#" device registered as a device in
> > > > the fs_devices list instead of "/dev/mapper/vg0-lv#" device.
> > > >   Thus when
> > > > the test adds a device to the existing mount it doesn't find the old
> > > > device in the original fs_devices list and remove it properly.
> > > 
> > 
> > I think most of your confusion is because you don't know what btrfs/197 does, so
> > I'll explain that and then answer your questions below.
> > 
> > DEV=/dev/vg0/lv0
> > RAID_DEVS=/dev/vg0/lv1 /dev/vg0/lv2 /dev/vg0/vl3 /dev/vg0/lv4
> > 
> > # First we create a single fs and mount it
> > mkfs.btrfs -f $DEV
> > mount $DEV /mnt/test
> > 
> > # Now we create the RAID fs
> > mkfs.btrfs -f -d raid10 -m raid10 $RAID_DEVS
> > 
> > # Now we add one of the raid devs to the single mount above
> > btrfs device add /dev/vg0/lv2 /mnt/test
> > 
> > # /dev/vg0/lv2 is no longer part of the fs it was made on, it's part of the fs
> > # that's mounted at /mnt/test
> > 
> > # Mount degraded with the raid setup
> > mount -o degraded /dev/vg0/lv1 /mnt/scratch
> > 
> > # Now we shouldn't have found /dev/vg0/lv2, because it was wiped and is no
> > # longer part of the fs_devices for this thing, except it is because it wasn't
> > # removed, so when we do the following it doesn't show as missing
> > btrfs filesystem show /mnt/scratch
> > 
> 
>  I thought I understood the test case. Now it is better. Thanks for taking
> the time to explain.
> 
> 
> > >   The above para is confusing. It can go. IMHO. The device path shouldn't
> > >   matter as we depend on the bdev to compare in the device add thread.
> > > 
> > > 2637         bdev = blkdev_get_by_path(device_path, FMODE_WRITE |
> > > FMODE_EXCL,
> > > 2638                                   fs_info->bdev_holder);
> > > ::
> > > 2657         list_for_each_entry_rcu(device, &fs_devices->devices, dev_list)
> > > {
> > > 2658                 if (device->bdev == bdev) {
> > > 2659                         ret = -EEXIST;
> > > 2660                         rcu_read_unlock();
> > > 2661                         goto error;
> > > 2662                 }
> > > 2663         }
> > > 
> > 
> > This is on the init thread, this is just checking the fs_devices of /mnt/test,
> > not the fs_devices of the RAID setup that we created, so this doesn't error out
> > (nor should it) because we're adding it to our mounted fs.
> > 
> > > 
> > > > This is fine in general, because when we open the devices we check the
> > > > UUID, and properly skip using the device that we added to the other file
> > > > system.  However we do not remove it from our fs_devices,
> > > 
> > > Hmm, context/thread is missing. Like, is it during device add or during
> > > mkfs/dev-scan?
> > > 
> > > AFAIK btrfs_free_stale_devices() checks and handles the removing of stale
> > > devices in the fs_devices in both the contexts/threads device-add, mkfs
> > > (device-scan).
> > > 
> > >   For example:
> > > 
> > > $ alias cnt_free_stale_devices="bpftrace -e 'kprobe:btrfs_free_stale_devices
> > > { @ = count(); }'"
> > > 
> > > New FSID on 2 devices, we call free_stale_devices():
> > > 
> > > $ cnt_free_stale_devices -c 'mkfs.btrfs -fq -draid1 -mraid1 /dev/vg/scratch0
> > > /dev/vg/scratch1'
> > > Attaching 1 probe...
> > > 
> > > @: 2
> > > 
> > >   We do it only when there is a new fsid/device added to the fs_devices.
> > > 
> > > For example:
> > > 
> > > Clean up the fs_devices:
> > > $ cnt_free_stale_devices -c 'btrfs dev scan --forget'
> > > Attaching 1 probe...
> > > 
> > > @: 1
> > > 
> > > Now mounting devices are new to the fs_devices list, so call
> > > free_stale_devices().
> > > 
> > > $ cnt_free_stale_devices -c 'mount -o device=/dev/vg/scratch0
> > > /dev/vg/scratch1 /btrfs'
> > > Attaching 1 probe...
> > > 
> > > @: 2
> > > 
> > > $ umount /btrfs
> > > 
> > > Below we didn't call free_stale_devices() because these two devices are
> > > already in the appropriate fs_devices.
> > > 
> > > $ cnt_free_stale_devices -c 'mount -o device=/dev/vg/scratch0
> > > /dev/vg/scratch1 /btrfs'
> > > Attaching 1 probe...
> > > 
> > > @: 0
> > > 
> > > $
> > > 
> > > To me, it looks to be working correctly.
> > > 
> > 
> > Yes it does work correctly, most of the time.  If you run it in a loop 500 times
> > it'll fail, because _sometimes_ udev goes in and does teh btrfs device scan and
> > changes the name of the device in the fs_devices for the RAID group.  So the
> > btrfs_free_stale_devices() thing doesn't find the exising device, because it's
> > just looking at the device->name, which is different from the device we're
> > adding.
> > 
> > We have the fs_devices for the RAID fs, and instead of /dev/vg0/lv2, we have
> > /dev/dm-4 or whatever.  So we do the addition of /dev/vg0/lv2, go to find it in
> > any other fs_devices, and don't find it because strcmp("/dev/vg0/lv2",
> > "/dev/dm0-4") != 0, and thus leave the device on the fs_devices for the RAID
> > file system.
> > 
> 
>  I got it. It shouldn't be difficult to reproduce and, I could reproduce.
> Without this patch.
> 
> 
>  Below is a device with two different paths. dm and its mapper.
> 
> ----------
>  $ ls -bli /dev/mapper/vg-scratch1  /dev/dm-1
>  561 brw-rw---- 1 root disk 252, 1 Dec  3 12:13 /dev/dm-1
>  565 lrwxrwxrwx 1 root root      7 Dec  3 12:13 /dev/mapper/vg-scratch1 ->
> ../dm-1
> ----------
> 
>  Clean the fs_devices.
> 
> ----------
>  $ btrfs dev scan --forget
> ----------
> 
>  Use the mapper to do mkfs.btrfs.
> 
> ----------
>  $ mkfs.btrfs -fq /dev/mapper/vg-scratch0
>  $ mount /dev/mapper/vg-scratch0 /btrfs
> ----------
> 
>  Crete raid1 again using mapper path.
> 
> ----------
>  $ mkfs.btrfs -U $uuid -fq -draid1 -mraid1 /dev/mapper/vg-scratch1
> /dev/mapper/vg-scratch2
> ----------
> 
>  Use dm path to add the device which belongs to another btrfs filesystem.
> 
> ----------
>  $ btrfs dev add -f /dev/dm-1 /btrfs
> ----------
> 
>  Now mount the above raid1 in degraded mode.
> 
> ----------
>  $ mount -o degraded /dev/mapper/vg-scratch2 /btrfs1
> ----------
> 

Ahhh nice, I couldn't figure out a way to trigger it manually.  I wonder if we
can figure out a way to do this in xfstests without needing to have your
SCRATCH_DEV on lvm already?

<snip>

> > 
> > Yeah I was a little fuzzy on this.  I think *any* failure should mean that we
> > remove the device from the fs_devices tho right?  So that we show we're missing
> > a device, since we can't actually access it?  I'm actually asking, because I
> > think we can go either way, but to me I think any failure sure result in the
> > removal of the device so we can re-scan the correct one.  Thanks,
> > 
> 
> It is difficult to generalize, I guess. For example, consider the transient
> errors during the boot-up and the errors due to slow to-ready devices or the
> system-related errors such as ENOMEM/EACCES, all these does not call for
> device-free. If we free the device for transient errors, any further attempt
> to mount will fail unless it is device-scan again.
> 
> Here the bug is about btrfs_free_stale_devices() which failed to identify
> the same device when tricked by mixing the dm and mapper paths.
> Can I check with you if there is another way to fix this by checking the
> device major and min number or the serial number from the device inquiry
> page?

I suppose I could just change it so that our verification proceses, like the
MAGIC or FSID checks, return ENODATA and we only do it in those cases.  Does
that seem reasonable?

Thanks
