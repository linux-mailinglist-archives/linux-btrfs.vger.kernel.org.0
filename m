Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F1646670A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 16:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242136AbhLBPtE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 10:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359157AbhLBPtA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 10:49:00 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830EBC06175A
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 07:45:38 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id bu11so25356596qvb.0
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Dec 2021 07:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iXhj9Dahb/XR7UJf3qPZ7hMpxbCT43vslMTNNGwBHaU=;
        b=K2G8XPyaVebT7Ox/0ppsy0W2p9aU8hp7TAuAOSECXjWsG8KNY5Js1xRMvdLE9CMAY8
         VjJ2egDvUa3L/4EZNCZLoUn/eS1GRT+nzNk52NM6wWKV2QLvSphDYkl2FACTu8Wo1QaR
         aEKMZqAanOSU+0DBrPY5JWbJYaUZBXI4IWQ72iiek/dIMxaZfyDneUs9+tVWHBX1t8st
         w4rBa8L6kJLULxVVmPbOFiE0+JKWgwfmWsouRt4yhRtH897hGRU0r3XeqUcyNb6phhS0
         IyX+F/gaOjXi6IKgd208JtQKBh3G1Im8386NwBWCHWcvoDBSp2N6UdEkTJctjrL14ipY
         OiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iXhj9Dahb/XR7UJf3qPZ7hMpxbCT43vslMTNNGwBHaU=;
        b=E2uS+dgrHoB3ANrGkvOXsbTIlmmyTNVQ09xKuZ8d6YkdZazp7TKp9W9+e2GzYMXkcz
         y1jBvzufKrQ91JBFos4UJOFC4f2CfHPMxTQdAz78gzc1Y3LgGCnaNFZLg/IvAQsj2s8o
         IUxB8XaC+/+bymvA5t07isZEPVkUnVyVR54TAmx1OJFwU/Zhj/pQoOUU2XzhsNEtEtB9
         kJQsy2g/BJ1rGTxmB0UD3Qjdv44yj1ZbenZGlUWW52uFOKNjN5C3zN/0cFOBOyDCBwUg
         rU7qlFyMJull5iUOqqlIVEmD/t1SvZwG3sdW8yBE5zp5+/OWclSA0lKWSpyD7JCtVGPQ
         fnaA==
X-Gm-Message-State: AOAM5328dHFV+KOE5CStKwaOnfsCae/oBLJJTOg1enggQCXpDQP2+2mX
        EYZO1MFefQww+MVGZaLh7mmrZ/2Vo2Fmqw==
X-Google-Smtp-Source: ABdhPJwGWNeBSn9jbgb9oGSKd3xHsRx1lpgBwrXU1KR3M+WevqZptIgyCCdkdAjoQwCnh6h1OT5aVA==
X-Received: by 2002:a05:6214:18c7:: with SMTP id cy7mr13586545qvb.0.1638459937321;
        Thu, 02 Dec 2021 07:45:37 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s11sm98645qki.95.2021.12.02.07.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 07:45:36 -0800 (PST)
Date:   Thu, 2 Dec 2021 10:45:35 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: UDEV_SETTLE_PROG before dmsetup create
Message-ID: <YajqH1Njtqz0ZXF+@localhost.localdomain>
References: <ebf63c27065c5fa676701184501353a9f2014832.1638382705.git.josef@toxicpanda.com>
 <YajcBNMm3dR4YI/N@debian9.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YajcBNMm3dR4YI/N@debian9.Home>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 02, 2021 at 02:45:24PM +0000, Filipe Manana wrote:
> On Wed, Dec 01, 2021 at 01:18:52PM -0500, Josef Bacik wrote:
> > We've been seeing transient errors with any test that uses a dm device
> > for the entirety of the time that we've been running nightly xfstests
> 
> I have been having it on my tests vms since ever as well.
> It's really annoying, but fortunatelly it doesn't happen too often.
> 

Yeah before this change we'd fail ~6 tests on every configruation on every
overnight run.  With this change we fail 0.  It's rare, but with our continual
testing it happens sooooooo much.

> > runs.  This turns out to be because sometimes we get EBUSY while trying
> > to create our new dm device.  Generally this is because the test comes
> > right after another test that messes with the dm device, and thus we
> > still have udev messing around with the device when DM tries to O_EXCL
> > the block device.
> > 
> > Add a UDEV_SETTLE_PROG before creating the device to make sure we can
> > create our new dm device without getting this transient error.
> 
> I suspect this might only make it seem the problem goes away but does not
> really fix it.
> 
> I say that for 2 reasons:
> 
> 1) All tests that use dm end up calling _dmsetup_remove(), like through
>    _log_writes_remove() or _cleanup_flakey() for example. Normally those
>    are called in the _cleanup() function, which ensures it's done even if
>    the test fails for some reason.
> 
>    So I don't understand why we need that UDEV_SETTLE_PROG at _dmsetup_create().
> 
>    And I've seen the ebusy failure happen even when the previous tests did
>    not use any dm device;
> 
> 2) Some tests fail after creating the dm device and using it. For example
>    btrfs/206 often fails when it tries to fsck the filesystem:
> 
>    btrfs/206 3s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/206.out.bad)
>         --- tests/btrfs/206.out     2020-10-16 23:13:46.554152652 +0100
>         +++ /home/fdmanana/git/hub/xfstests/results//btrfs/206.out.bad      2021-12-01 21:09:46.317632589 +0000
>         @@ -3,3 +3,5 @@
>         XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>         wrote 8192/8192 bytes at offset 0
>         XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>         +_check_btrfs_filesystem: filesystem on /dev/sdc is inconsistent
>         +(see /home/fdmanana/git/hub/xfstests/results//btrfs/206.full for details)
>         ...
> 
>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/206.out /home/fdmanana/git/hub/xfstests/results//btrfs/206.out.bad'  to see the entire diff)
> 
>     In the .full file I got:
> 
>     (...)
>     replaying 1239@11201: sector 2173408, size 16384, flags 0x10(METADATA)
>     replaying 1240@11234: sector 0, size 0, flags 0x1(FLUSH)
>     replaying 1241@11235: sector 128, size 4096, flags 0x12(FUA|METADATA)
>     _check_btrfs_filesystem: filesystem on /dev/sdc is inconsistent
>     *** fsck.btrfs output ***
>     ERROR: cannot open device '/dev/sdc': Device or resource busy
>     ERROR: cannot open file system
>     Opening filesystem to check...
>     *** end fsck.btrfs output
>     *** mount output ***
> 
>    The ebusy failure is not when the test starts, but when somewhere in the middle
>    of the replay loop when it calls fsck, or when it ends and the fstests framework
>    calls fsck.
> 
>    I've seen that with btrfs/172 too, which also uses dm logwrites in a similar way.
> 
> So to me this suggests 2 things:
> 
> 1) Calling UDEV_SETTLE_PROG at _dmsetup_create() doesn't solve that problem with
>    btrfs/206 (and other tests) - the problem is fsck failing to open the scratch
>    device after it called _log_writes_remove() -> _dmsetup_remove(), and not a
>    failure to create the dm device;
> 
> 2) The problem is likely something missing at _dmsetup_remove(). Perhaps add
>    another UDEV_SETTLE_PROG there:
> 
>    diff --git a/common/rc b/common/rc
>    index 8e351f17..22b34677 100644
>    --- a/common/rc
>    +++ b/common/rc
>    @@ -4563,6 +4563,7 @@ _dmsetup_remove()
>             $UDEV_SETTLE_PROG >/dev/null 2>&1
>             $DMSETUP_PROG remove "$@" >>$seqres.full 2>&1
>             $DMSETUP_PROG mknodes >/dev/null 2>&1
>     +       $UDEV_SETTLE_PROG >/dev/null 2>&1
>      }
>  
>     _dmsetup_create()
> 
>   I can't say if that change to _dmsetup_remove() is correct, or what it's
>   needed, as I really haven't spent time trying to figure out why the issue
>   happens.
> 

I actually tried a few iterations before I settled on this one, but I was only
trying to reproduce the EBUSY when creating the flakey device, I hadn't seen it
with fsck.  So I originally started with your change, but it didn't fix the
problem.  Then I did both, UDEV_SETTLE at the end of remove and at the beginning
of create and the problem went away, and then I removed the one from remove and
the problem still was gone.

But since I've made this change I also have been investigating another problem
where we'll get EBUSY at mkfs time when we use SCRATCH_DEV_POOL.  I have a test
patch in our staging branch to make sure it actuall fixes it, but I have to add
this to the start of _scratch_pool_mkfs as well.

It turns out that udev is doing this thing where it writes to
/sys/block/whatever/uevent to make sure that a KOBJ_CHANGE event gets sent out
for the device.

This is racing with the test doing a mount.  So the mount gets O_EXCL, which
means the uevent doesn't get emitted until umount.  This would explain what
you're seeing, we umount, we get the KOBJ_CHANGE event once the O_EXCL is
dropped, udev runs, and then fsck gets an EBUSY.

This is a very long email to say that udev is causing spurious failures because
of behavior I don't entirely understand.  We're going to need to sprinkle in
UDEV_SETTLE_PROG in different places to kill all of these different scenarios.

What do we think is best here?  Put UDEV_SETTLE_PROG at the start of any
function that needs to do O_EXCL?  So this would mean

_dmsetup_create
_dmsetup_remove
*_mkfs
*_mount
*_check

That would be safest, and I can certainly do that.  My initial approach was just
to do it where it was problematic, but the debugging I did yesterday around
btrfs/223 failures and the fact that udev is queue'ing up events that get
delivered at some point in the future makes it kind of hard to handle on a
case-by-case basis.  Thanks,

Josef
