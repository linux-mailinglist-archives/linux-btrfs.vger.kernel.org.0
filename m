Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD7B46A5AB
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 20:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348421AbhLFTcK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 14:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348427AbhLFTcI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 14:32:08 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E12BC0613F8
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 11:28:39 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id m186so12266642qkb.4
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Dec 2021 11:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ca6k9nMpi4aqLKUkwZYVOyHetlZsbnRlRoDNuS14m6s=;
        b=ErQ1q32miwsA7osvBVrXBkjQA/Lp7hNtbXvrMefg8x9D0u6EL6smzh7B58VjwuKJQB
         MdZZcw6MImFjfYuO+SYtlZodsn9jDJo7wbqx9cdkHmiUqss8A8Bxf88GVxjujk/G5qMZ
         IpWO6dK43EwsCGogPSoDt8Vs1v0KXiO7/zTJs68sY4VyQdIO5P12XmFhvMdQJB8qSjCZ
         bYf2+1uV+dlROcUPSSyE16WZtEq6fWL2TEQjzmi9HljwherVdkOltJkyNPV1V+aoFAV8
         B/mFMchrBU/ABAwIeThCicCPr8bjA8BXkpR+7Fxobjy9sgGbR812qzYdAJSUNdvh5QbK
         VtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ca6k9nMpi4aqLKUkwZYVOyHetlZsbnRlRoDNuS14m6s=;
        b=8KxlUus/kIG7TTQLlRD/b9Z2gdaBI6w3vLFlAIAi9bVJkCQb0l91nCKH3Nw32emLt1
         f+EwkapAkc723iS21xzP0WDijr07lDSlM01A7QofXtytIOL3uUD1Bp3xSRCMXvbsrC6F
         7hNvAHrUMuuL3f0sYeKaBfgtptGYMKKgDAQwr4M+5Ipf2NWcvT5TQyIuEpO8scyzcD9q
         cfZc7qe85qYPodd+bXQkEOvwFv+OJbUU5h9LX89xsjY68+ViqEy4uRwgZfd4tlcVbRkW
         +a4FXp6Mea5CR3ux/Q4SzvhEk52kh0gznhXxg6LhoaiKCqrdfmMnPgNgVtFpSi6sMSul
         zedw==
X-Gm-Message-State: AOAM533orZJbCfEasoTjFnpga3ZEHfQ751EZAYWsmHnOmphuI8oi0rab
        Oh4FJgY34i2q1pYHw22dA3PZDA==
X-Google-Smtp-Source: ABdhPJzj5HLhWUceMFg16vu9/lFJUZ3wJW+uUuxT69Bv38zZ9IfCYD90Y5el81L07KyTdb1SD+5Fkw==
X-Received: by 2002:a05:620a:28d0:: with SMTP id l16mr35198177qkp.500.1638818918211;
        Mon, 06 Dec 2021 11:28:38 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l25sm6719636qkk.48.2021.12.06.11.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 11:28:37 -0800 (PST)
Date:   Mon, 6 Dec 2021 14:28:31 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Chandan Babu R <chandan.babu@oracle.com>
Cc:     Filipe Manana <fdmanana@kernel.org>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: UDEV_SETTLE_PROG before dmsetup create
Message-ID: <Ya5kX3C+WD+D96rg@localhost.localdomain>
References: <ebf63c27065c5fa676701184501353a9f2014832.1638382705.git.josef@toxicpanda.com>
 <YajcBNMm3dR4YI/N@debian9.Home>
 <YajqH1Njtqz0ZXF+@localhost.localdomain>
 <87ilw2qo6z.fsf@debian-BULLSEYE-live-builder-AMD64>
 <87fsr5rfmk.fsf@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsr5rfmk.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 06, 2021 at 07:37:31PM +0530, Chandan Babu R wrote:
> On 06 Dec 2021 at 11:17, Chandan Babu R wrote:
> > On 02 Dec 2021 at 21:15, Josef Bacik wrote:
> >> On Thu, Dec 02, 2021 at 02:45:24PM +0000, Filipe Manana wrote:
> >>> On Wed, Dec 01, 2021 at 01:18:52PM -0500, Josef Bacik wrote:
> >>> > We've been seeing transient errors with any test that uses a dm device
> >>> > for the entirety of the time that we've been running nightly xfstests
> >>> 
> >>> I have been having it on my tests vms since ever as well.
> >>> It's really annoying, but fortunatelly it doesn't happen too often.
> >>> 
> >>
> >> Yeah before this change we'd fail ~6 tests on every configruation on every
> >> overnight run.  With this change we fail 0.  It's rare, but with our continual
> >> testing it happens sooooooo much.
> >>
> >>> > runs.  This turns out to be because sometimes we get EBUSY while trying
> >>> > to create our new dm device.  Generally this is because the test comes
> >>> > right after another test that messes with the dm device, and thus we
> >>> > still have udev messing around with the device when DM tries to O_EXCL
> >>> > the block device.
> >>> > 
> >>> > Add a UDEV_SETTLE_PROG before creating the device to make sure we can
> >>> > create our new dm device without getting this transient error.
> >>> 
> >>> I suspect this might only make it seem the problem goes away but does not
> >>> really fix it.
> >>> 
> >>> I say that for 2 reasons:
> >>> 
> >>> 1) All tests that use dm end up calling _dmsetup_remove(), like through
> >>>    _log_writes_remove() or _cleanup_flakey() for example. Normally those
> >>>    are called in the _cleanup() function, which ensures it's done even if
> >>>    the test fails for some reason.
> >>> 
> >>>    So I don't understand why we need that UDEV_SETTLE_PROG at _dmsetup_create().
> >>> 
> >>>    And I've seen the ebusy failure happen even when the previous tests did
> >>>    not use any dm device;
> >>> 
> >>> 2) Some tests fail after creating the dm device and using it. For example
> >>>    btrfs/206 often fails when it tries to fsck the filesystem:
> >>> 
> >>>    btrfs/206 3s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/206.out.bad)
> >>>         --- tests/btrfs/206.out     2020-10-16 23:13:46.554152652 +0100
> >>>         +++ /home/fdmanana/git/hub/xfstests/results//btrfs/206.out.bad      2021-12-01 21:09:46.317632589 +0000
> >>>         @@ -3,3 +3,5 @@
> >>>         XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >>>         wrote 8192/8192 bytes at offset 0
> >>>         XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >>>         +_check_btrfs_filesystem: filesystem on /dev/sdc is inconsistent
> >>>         +(see /home/fdmanana/git/hub/xfstests/results//btrfs/206.full for details)
> >>>         ...
> >>> 
> >>>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/206.out /home/fdmanana/git/hub/xfstests/results//btrfs/206.out.bad'  to see the entire diff)
> >>> 
> >>>     In the .full file I got:
> >>> 
> >>>     (...)
> >>>     replaying 1239@11201: sector 2173408, size 16384, flags 0x10(METADATA)
> >>>     replaying 1240@11234: sector 0, size 0, flags 0x1(FLUSH)
> >>>     replaying 1241@11235: sector 128, size 4096, flags 0x12(FUA|METADATA)
> >>>     _check_btrfs_filesystem: filesystem on /dev/sdc is inconsistent
> >>>     *** fsck.btrfs output ***
> >>>     ERROR: cannot open device '/dev/sdc': Device or resource busy
> >>>     ERROR: cannot open file system
> >>>     Opening filesystem to check...
> >>>     *** end fsck.btrfs output
> >>>     *** mount output ***
> >>> 
> >>>    The ebusy failure is not when the test starts, but when somewhere in the middle
> >>>    of the replay loop when it calls fsck, or when it ends and the fstests framework
> >>>    calls fsck.
> >>> 
> >>>    I've seen that with btrfs/172 too, which also uses dm logwrites in a similar way.
> >>> 
> >>> So to me this suggests 2 things:
> >>> 
> >>> 1) Calling UDEV_SETTLE_PROG at _dmsetup_create() doesn't solve that problem with
> >>>    btrfs/206 (and other tests) - the problem is fsck failing to open the scratch
> >>>    device after it called _log_writes_remove() -> _dmsetup_remove(), and not a
> >>>    failure to create the dm device;
> >>> 
> >>> 2) The problem is likely something missing at _dmsetup_remove(). Perhaps add
> >>>    another UDEV_SETTLE_PROG there:
> >>> 
> >>>    diff --git a/common/rc b/common/rc
> >>>    index 8e351f17..22b34677 100644
> >>>    --- a/common/rc
> >>>    +++ b/common/rc
> >>>    @@ -4563,6 +4563,7 @@ _dmsetup_remove()
> >>>             $UDEV_SETTLE_PROG >/dev/null 2>&1
> >>>             $DMSETUP_PROG remove "$@" >>$seqres.full 2>&1
> >>>             $DMSETUP_PROG mknodes >/dev/null 2>&1
> >>>     +       $UDEV_SETTLE_PROG >/dev/null 2>&1
> >>>      }
> >>>  
> >>>     _dmsetup_create()
> >>> 
> >>>   I can't say if that change to _dmsetup_remove() is correct, or what it's
> >>>   needed, as I really haven't spent time trying to figure out why the issue
> >>>   happens.
> >>> 
> >>
> >> I actually tried a few iterations before I settled on this one, but I was only
> >> trying to reproduce the EBUSY when creating the flakey device, I hadn't seen it
> >> with fsck.  So I originally started with your change, but it didn't fix the
> >> problem.  Then I did both, UDEV_SETTLE at the end of remove and at the beginning
> >> of create and the problem went away, and then I removed the one from remove and
> >> the problem still was gone.
> >>
> >> But since I've made this change I also have been investigating another problem
> >> where we'll get EBUSY at mkfs time when we use SCRATCH_DEV_POOL.  I have a test
> >> patch in our staging branch to make sure it actuall fixes it, but I have to add
> >> this to the start of _scratch_pool_mkfs as well.
> >>
> >> It turns out that udev is doing this thing where it writes to
> >> /sys/block/whatever/uevent to make sure that a KOBJ_CHANGE event gets sent out
> >> for the device.
> >>
> >> This is racing with the test doing a mount.  So the mount gets O_EXCL, which
> >> means the uevent doesn't get emitted until umount.  This would explain what
> >> you're seeing, we umount, we get the KOBJ_CHANGE event once the O_EXCL is
> >> dropped, udev runs, and then fsck gets an EBUSY.
> >
> > I started debugging this issue late last week. Among several tests which
> > failed, xfs/033 was failing once in a while because the umount syscall
> > returned -EBUSY. Debugging this further led me to the following,
> >
> > 1. Mounting an fs causes udev to invoke xfs_spaceman (via udisksd => xfs_info).
> >    This causes the per-cpu counter at mount->mnt_pcp->mnt_count to increase by
> >    1.
> > 2. Unmount at this stage causes the umount syscall to fail since the refcount
> >    on struct mount is greater than 2.
> >
> > I changed my test disks from the regular /dev/sd* devices to loop devices. I
> > then added loop devices to be ignored by udev with the following change in
> > /lib/udev/rules.d/60-persistent-storage.rules,
> >
> > KERNEL!="sr*|loop*", IMPORT{builtin}="blkid"
> >
> > This led to xfs/033 execute fine for 100 times without failure.
> 
> > However, other tests which use device mapper devices are still failing
> > arbitrarily. 
> 
> This failure occurs because 60-persistent-storage-dm.rules has the following,
> 
> # Add inotify watch to track changes on this device.
> # Using the watch rule is not optimal - it generates a lot of spurious
> # and useless events whenever the device opened for read-write is closed.
> # The best would be to generete the event directly in the tool changing
> # relevant information so only relevant events will be processed
> # (like creating a filesystem, changing filesystem label etc.).
> #
> # But let's use this until we have something better...                                                                                          
> LABEL="dm_watch"
> OPTIONS+="watch"
> 
> Hence any change to the device will generate a uevent causing udev's internal
> blkid to be invoked. This ends up forking and executing xfs_spaceman.
> 

First of all excellent work digging into this Chandan, thanks so much!

<snip>

> >
> > To be honest, I don't understand udev well enough. But as pointed above, a
> > simple invocation of mount is causing xfs_spaceman to be executed (indirectly)
> > by udevd.  Hence, may be executing UDEV_SETTLE_PROG is probably not
> > sufficient.
> >

Yeah so the question is what do we do here to make xfstests and udev co-exist
nicely?  I imagine if you added UDEV_SETTLE_PROG around every operation we do
(for example before umount in your test) we would stop hitting these problems.

But this clearly sucks.  Should we instead come up with a couple of udev rules
and put them here in fstests with the disclaimer "hey if you see problems,
install these udev rules" and call it good enough?  I see there's
UDEV_DISABLE_PERSISTENT_STORAGE_RULES_FLAG and DM_NOSCAN, I don't know how to
write udev rules, but is there a way we could write a script to use the
local.config to generate a udev rule to be copied into place based on the users
device settings in local.config that would keep udev from touching the devices
we're using?  Thanks,

Josef
