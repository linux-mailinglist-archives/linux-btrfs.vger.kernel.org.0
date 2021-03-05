Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE66232E2D4
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Mar 2021 08:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhCEHPm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Mar 2021 02:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhCEHPm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Mar 2021 02:15:42 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11550C061574
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Mar 2021 23:15:42 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id r23so1521638ljh.1
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Mar 2021 23:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hypertriangle-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=IFuCx27MOXCkPlpIJRAXixQd3XX+hvowqlit6tXgSX4=;
        b=cevTK1PxxzEmqhwr2lGJdYcTBDc4UXx4tAUxt6jE+G0i8PpdsIA04TEydtSUxWKw5Y
         F/q6j3FOe6TWECMAjoBI7NWPPKmHsqn4n1vd7aSnzTLdFJK0j121T+QKKMraPLMIWLRp
         Bx2Seiwq9FOOYAt7pMv9Q44BU158psZU1S4GeunQmbPX3qXFWtmz24+u48Tcs9/7ZM1M
         9AL/+eAE/UlrQ8uhIdqsSXog5E0HnI0oztiWqhUFWCx6pvPJKpkFfjlTz7JeyJoxrlC3
         GNEy9kK6pAObGouhZGy/r3kcC6CXvVN8rgJohRkkzl1v0mQCI2La/g5te2Nu5cZquRdx
         RuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IFuCx27MOXCkPlpIJRAXixQd3XX+hvowqlit6tXgSX4=;
        b=G7Gat7ORuCPXk2F2kUo6VL9Ple+OY2+EINyyUMUuLYev0NxagkB8N5WYnVFbNNRgMt
         PvVHM3EJM/v4HwqrtY22cvnhYt0WYSn5aGpyFK04DDX/BFVM0Til55fOoObHtAUhUTKn
         C38+3amdEZviUN8Tc09CzR+fbEGd+O0J0McVSzNQl7+TOZIhU1OC+KdfRiPt9RCEI+JV
         L1TWRAGG5BuLx94U0ikj93NKKxJDIdjIo3uWWCRquJYBS4mIKXACKYj0ELCB95LZRvmC
         JaTVyDs/g+P/p1frGOaw02oOgLNn01hfsXR/oudN49QmgtyFw44jaxni/gfN1pHGNjiD
         VflA==
X-Gm-Message-State: AOAM533llJ2HqHpN3Fmy7uIDHmbPPLWln9XzOvMjesJL4gm3tx31gNPt
        XL3toGuStwxNhiuUQDxARxiwAoblwOZhsD/68YqKpAYCB8fgrDV5
X-Google-Smtp-Source: ABdhPJwbTnQIh75VIfZRXYsduTwDdAS6GT+Q/dI+3J60A+h2gcwP+sdopUQ09UxX4KAXuxQNX8CUUQ9fC0VBz9K+dTg=
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr4228005ljp.495.1614928540056;
 Thu, 04 Mar 2021 23:15:40 -0800 (PST)
MIME-Version: 1.0
From:   Alexandru Stan <alex@hypertriangle.com>
Date:   Thu, 4 Mar 2021 23:15:03 -0800
Message-ID: <CAE9tQ0dz-c05oGgzwwuJVfO9WUorwdUM_aDPy8Cc53cAK8AT9A@mail.gmail.com>
Subject: Scared with degraded raid1 fs
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

My raid1 btrfs fs went read only recently. It was comprised of 2 drives:
/dev/sda ST4000VN008 (firmware SC60) - 6 month old drive
/dev/sdb ST4000VN000 (firmware SC44) - 5 year old drive (but it was
mostly idly spinning, very little accesses were done in that time)
The drives are pretty similar (size/performance/market segment/rpm),
but they're of different generations.

FWIW kernel is v5.11.2 (https://archlinux.org/packages/core/x86_64/linux/)

I noticed something was wrong when the filesystem was read only. Dmesg
showed a single error about 50 min previous:
> Mar 04 19:04:13  kernel: BTRFS critical (device sda3): corrupt leaf: block=4664769363968 slot=17 extent bytenr=4706905751552 len=8192 invalid extent refs, have 1 expect >= inline 129
> Mar 04 19:04:13  kernel: BTRFS info (device sda3): leaf 4664769363968 gen 1143228 total ptrs 112 free space 6300 owner 2
> Mar 04 19:04:14  kernel:         item 0 key (4706904485888 168 8192) itemoff 16230 itemsize 53
> Mar 04 19:04:14  kernel:                 extent refs 1 gen 1123380 flags 1
> Mar 04 19:04:14  kernel:                 ref#0: extent data backref root 431 objectid 923767 offset 175349760 count 1
No other ATA errors nearby, there wasn't much activity going on around
there either.

I tried to remount everything using the fstab, but it wasn't too happy:
> ~% sudo mount -a
> mount: /mnt/fs: wrong fs type, bad option, bad superblock on /dev/sdb3, missing codepage or helper program, or other error.
I regret not checking dmesg after that command, that was stupid of me
(though I do have dmesg output of this later on).

Catting /dev/sda seemed just fine, so at least one could still read
from the supposedly bad drive. I also think that the error message
just above always lists a random (per boot) drive of the array, not
necessarily the one that causes problems, which scares me for a second
there.

The next "bright" idea I had was maybe this was a small bad block on
/dev/sda and what are the chances that the array will try to write
again to that spot. Maybe the next reboot will be fine. So I just
rebooted.

The system didn't come back up anymore (and so did my 3000 mile ssh
access that was dear to me). SInce my rootfs was on that array I was
dumped to an initrd shell.
Any attempts to mount were met with more scary superblock errors (even
if i tried /dev/sdb)

This time I checked dmesg:
> BTRFS info (device sda3): disk space caching is enabled
> BTRFS info (device sda3): has skinny extents
> BTRFS info (device sda3): start tree-log replay
> BTRFS error (device sda3): parent transid verify failed on 4664769363968 wanted 1143228 found 1143173
> BTRFS error (device sda3): parent transid verify failed on 4664769363968 wanted 1143228 found 1143173
> BTRFS: error (device sda3) in btrfs_free_extent:3103 errno-5 IO failure
> BTRFS: error (device sda3) in btrfs_run_delayed_refs:2171: errno=-5 IO failure
> BTRFS warning (device sda3): Skipping commit of aborted transaction.
> BTRFS: error (device sda3) in cleanup_transaction:1938: errno-5 10 failure
> BTRFS: error (device sda3) in btrfs_replay_log:2254: errno-5 I0 failure (Failed to recover log tree)
> BTRFS error (device sda3): open_ctree failed
A fuller log (but not OCRd) can be found at
https://lh3.googleusercontent.com/-aV23XURv_f0/YEGLDeEavbI/AAAAAAAALYI/bFuSQsTYbCM7-z9SSNbcZq-7p1I7wGyLQCK8BGAsYHg/s0/2021-03-04.jpg,
though please excuse the format, I have to debug/fix this over VC.

I managed to successfully mount by doing `mount -o
degraded,ro,norecovery,subvol=/root /new_root`. Seems to work fine for
RO access.

I can't really boot anything from this though, systemd refuses to go
past what the fstab dictates and without either a root password for
the emergency shell (which i don't evne have) or being able to change
the fstab (which I don't think I am capable of getting right in that
one RW attempt).

I used a chroot in that RO mount to start a long smart scan of both
drives. I guess I'll find results in a couple of hours.

In the meantime I ordered another ST4000VN008 drive for more room for
activities, maybe I can do a `btrfs replace` if needed.

I was earlier on irc/#btrfs, Zygo mentioned that these (at least the
later transid verify errors) are very strange and are either drive
firmware, ram or kernel bugs. Hoping this brings a fuller picture.
Ram might be a little suspect, it's a newish machine I built, but I
have run memtest86 on it for 12 hours with no problems. No ECC though.

My questions:
* If both my drives' smart run report no errors, how do I recover my
array? Ideally I would do this inplace.
    * Any suggestions how to use my new third drive to make things safer?
* I would be ok with doing a 3 device raid1 in the future, would that
protect me from something similar while not degrading to RO?

When this is all over I'm setting up my daily btrbk remote snapshot
that I've been putting off for an extra piece of mind (then I'll have
my data copied on 5 drives in total).

Thanks,
Alexandru Stan
