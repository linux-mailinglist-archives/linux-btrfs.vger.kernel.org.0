Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD214C8E94
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Mar 2022 16:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbiCAPHx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Mar 2022 10:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbiCAPHx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Mar 2022 10:07:53 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D056A6519
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Mar 2022 07:07:11 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id t21so13115260qkg.6
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Mar 2022 07:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3bJfewm+YmoYyc+vJgqxE2/toBvQvL1DV8X0bF4w0s0=;
        b=coBAJVPqCDZyEJswgdtFS9UduNPeCSHYBPlPL0vX5cDil87KL4oHNLWr/DhD4bbEx/
         8LaddNetrdrBLFRKq4DmFanmfX2HoUtKA+P8XuAHBEYYSdBOuuiFL9r6Yd0egB+o2jAI
         EEJGXnQhIc2C5sm3L5eQwnkE7TaDWqMj7u4TubG3r2+j0Ugl1Wbty1QpqGAoJ1/qv2Yz
         gPAYDmzwRhk90auDdi/KY7M4QwvpK9YrDskcCuw5Z2ePd93Isqz74zrRoer9QF6Il9TV
         1d8tAoRs57Oaum7Gkm0u/WpPjE6uGpTvjNXNBddRL4xiFDidUMpwUdF+lq5kra2Sxxbh
         e0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3bJfewm+YmoYyc+vJgqxE2/toBvQvL1DV8X0bF4w0s0=;
        b=m4dOqPkJubhA7jpbObFRmEfZCtvO/jX85lJLRpZJhacvkvKfju+wW7/UrVojSOqGwv
         uerBhttcrLF0gHKxIu1tDdywkUp9vK2XLODpHjEVl+4+d9koIn/dnw0E94kbFkhyA2WO
         XfePbWM0Oy3PrDk/A00IHDJ/SryCL62syeABa1uyTavrw9sTjupFp4PBFTJ8iViJP49y
         WcrOS2J/DCxAfY3B7U/B+pvGr1OKL8HfD4ncFQIiseWyJ2fzCoU/7HABOltJIT9RS3N0
         rkKqTYrref8CufG8i10sZ94hRYqe37Pozyt97sknzf7QoVo9IZrQT4IHvJpSJuvuPcnc
         waPA==
X-Gm-Message-State: AOAM532jkrlRAUiw99PqjSysGqLWqT8cJ9jF3o/4yVMpfR//S592sYGC
        MExAKHG7WLje0nBAlR09zRhxy92LHjRVGDhn
X-Google-Smtp-Source: ABdhPJx+uijL5woj8Ecvy7b8dwP9TysWFHsP5Qs+6SA/QITLt4/LdQU2IVDiQpBGMHKNay1c5ry9MA==
X-Received: by 2002:a37:4649:0:b0:47e:cf47:48af with SMTP id t70-20020a374649000000b0047ecf4748afmr14493878qka.605.1646147230337;
        Tue, 01 Mar 2022 07:07:10 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o13-20020ac87c4d000000b002dd2647f223sm9274421qtv.42.2022.03.01.07.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 07:07:09 -0800 (PST)
Date:   Tue, 1 Mar 2022 10:07:08 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     kreijack@inwind.it
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH 0/7][V11] btrfs: allocation_hint
Message-ID: <Yh42nDUquZIqVMC0@localhost.localdomain>
References: <cover.1643228177.git.kreijack@inwind.it>
 <Yh0AnKF1jFKVfa/I@localhost.localdomain>
 <c7fc88cd-a1e5-eb74-d89d-e0a79404f6bf@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7fc88cd-a1e5-eb74-d89d-e0a79404f6bf@libero.it>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 28, 2022 at 10:01:35PM +0100, Goffredo Baroncelli wrote:
> Hi Josef,
> 
> On 28/02/2022 18.04, Josef Bacik wrote:
> > On Wed, Jan 26, 2022 at 09:32:07PM +0100, Goffredo Baroncelli wrote:
> > > From: Goffredo Baroncelli <kreijack@inwind.it>
> > > 
> > > Hi all,
> > > 
> [...
> 
> > > In V11 I added a new 'feature' file /sys/fs/btrfs/features/allocation_hint
> > > to help the detection of the allocation_hint feature.
> > > 
> > 
> > Sorry Goffredo I dropped the ball on this, lets try and get this shit nailed
> > down and done so we can get it merged.  The code overall looks good, I just have
> > two things I want changed
> > 
> > 1. The sysfs file should use a string, not a magic number.  Think how
> >     /sys/block/<dev>/queue/scheduler works.  You echo "metadata_only" >
> >     allocation_hint, you cat allocation_hint and it says "none" or
> >     "metadata_only".  If you want to be fancy you can do exactly like
> >     queue/scheduler and show the list of options with [] around the selected
> >     option.
> 
> Ok.
> > 
> > 2. I hate the major_minor thing, can you do similar to what we do for devices/
> >     and symlink the correct device sysfs directory under devid?
> > 
> Ok, do you have any suggestion for the name ? what about bdev ?
> 

You literally just add a link to the device kobj to the devid kobj.  If you look
at btrfs_sysfs_add_device(), you would do something like this (completely
untested and uncompiled)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 17389a42a3ab..cc570078bf7d 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1450,8 +1450,10 @@ void btrfs_sysfs_remove_device(struct btrfs_device *device)
        devices_kobj = device->fs_info->fs_devices->devices_kobj;
        ASSERT(devices_kobj);
 
-       if (device->bdev)
+       if (device->bdev) {
                sysfs_remove_link(devices_kobj, bdev_kobj(device->bdev)->name);
+               sysfs_remove_link(&device->devid_kobj, bdev_kobj(device->bdev)->name);
+       }
 
        if (device->devid_kobj.state_initialized) {
                kobject_del(&device->devid_kobj);
@@ -1628,10 +1630,23 @@ int btrfs_sysfs_add_device(struct btrfs_device *device)
 
        nofs_flag = memalloc_nofs_save();
 
+       init_completion(&device->kobj_unregister);
+       ret = kobject_init_and_add(&device->devid_kobj, &devid_ktype,
+                                  devinfo_kobj, "%llu", device->devid);
+       if (ret) {
+               kobject_put(&device->devid_kobj);
+               btrfs_warn(device->fs_info,
+                          "devinfo init for devid %llu failed: %d",
+                          device->devid, ret);
+       }
+
        if (device->bdev) {
                struct kobject *disk_kobj = bdev_kobj(device->bdev);
 
                ret = sysfs_create_link(devices_kobj, disk_kobj, disk_kobj->name);
+               if (!ret)
+                       ret = sysfs_create_link(device->devid_kobj, disk_kobj,
+                                               disk_kobj->name);
                if (ret) {
                        btrfs_warn(device->fs_info,
                                "creating sysfs device link for devid %llu failed: %d",
@@ -1640,16 +1655,6 @@ int btrfs_sysfs_add_device(struct btrfs_device *device)
                }
        }
 
-       init_completion(&device->kobj_unregister);
-       ret = kobject_init_and_add(&device->devid_kobj, &devid_ktype,
-                                  devinfo_kobj, "%llu", device->devid);
-       if (ret) {
-               kobject_put(&device->devid_kobj);
-               btrfs_warn(device->fs_info,
-                          "devinfo init for devid %llu failed: %d",
-                          device->devid, ret);
-       }
-
 out:
        memalloc_nofs_restore(nofs_flag);
        return ret;

