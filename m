Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5851839C3DA
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Jun 2021 01:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhFDXZq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 19:25:46 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:39916 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhFDXZq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 19:25:46 -0400
Received: by mail-wr1-f42.google.com with SMTP id l2so10803487wrw.6
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Jun 2021 16:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=15sfOMJDOZvFlglXiHxRbXvEcgHO+/sbWa77gWuTOa8=;
        b=FBHcmwtKk9+YqcSDsM7Rlub+q7Il0bX6W51CvtAzdI+q/unB2ZbGdcs3OPEln1VpAq
         dBEZjla4zy4wM+r7x86qurlmP9rgc/0Vv7TnksWDZqLoJM7OdnxGtzA/8ITseVdjJ6p8
         YTvG3hI18IIMcCGwhdLaMLJ1SNlacdQIbGTBJaFxraVMhcSt8HxdDEbgK7T2Fb7IomGt
         Og/KN0ps1mhLK4zpB/XawYd1iU+DwD5MnTef8nx92fRJyq/tjwqdJ3TS9H9BnUSeoygh
         XjdjK3VNNkPzQRCfvJ1yTMsVBuZ2ZWe5sx+/MwPYvs9H0ZfyExJp3DqgNhNZYC8nreyq
         uRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=15sfOMJDOZvFlglXiHxRbXvEcgHO+/sbWa77gWuTOa8=;
        b=puh/YweeesmTZ7h4HNrY2APBjJK5H+bSVuINtG4q/cIfM40sUnbx/O1UhomoHuB0w+
         Xn0ALpcxgiafALMIoUSR1Go3R917OSgyhP43dZVl5ZEuupXkE7D9VyPMjqXokGNQxFls
         s+PdRUzZe2WHAI1OB8KqFIciTBZNXFb9cim8d37drXA1pzBJNZN6lpOYhxdLo32Co6zk
         6+Ug//U5WhGr5cDO84pxpiqpvIzcn0to+t92dqj6Q4rmYmvf5FDdnBZLJxiajsPaMqTQ
         hOMl3SLNoWlleBMEVc7j8HNYyz0ts8Rx8gjjNCmW8Szr5OaWpKaVTIaFrnkdCSHZrIH4
         7+Cg==
X-Gm-Message-State: AOAM532KXJy6J/jhrpE/G7bVNTiM5x5Ph6uaKzuhchr3h7eoPfSL2zzb
        LI0xwuXPZrIcTIdSL/HGh2yxTNmgJ9qEnZKQTzJLBw==
X-Google-Smtp-Source: ABdhPJxOvsS8FzJDZG3wFeZy1KajGkEj6EWg4tw+nu+4j06zUpqsn6wlIczl8ys4dq9dq7IayS/3Oe0bhacRw7+e6Ek=
X-Received: by 2002:a05:6000:1447:: with SMTP id v7mr6011755wrx.252.1622848967459;
 Fri, 04 Jun 2021 16:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <cf633d62-73ab-1ce2-f31c-a4a8407a38b4@gmail.com>
 <CAJCQCtRkZPqQ_Rfx1Kk6rXZ_GyxDcLymdFjJkS12zZZ0mep3vQ@mail.gmail.com> <5272b826-ec8e-f3a3-6fc1-bb863b698c83@gmail.com>
In-Reply-To: <5272b826-ec8e-f3a3-6fc1-bb863b698c83@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 4 Jun 2021 17:22:31 -0600
Message-ID: <CAJCQCtTdZ6LiYQPi-tb95auE1K1bxJ04iDPbu03k4W-Pu5xbEA@mail.gmail.com>
Subject: Re: Corrupted data, failed drive(s)
To:     Gaardiolor <gaardiolor@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 4, 2021 at 3:27 AM Gaardiolor <gaardiolor@gmail.com> wrote:
>
> Hi Chris,
>
> Thanks for your reply. Just noticed I forgot to mention I'm running
> kernel 5.12.8-300.fc34.x86_64 with btrfs-progs-5.12.1-1.fc34.x86_64 .
>
>
> >> I have a couple of questions:
> >>
> >> 1) Unpacking some .tar.gz files from /storage resulted in files with
> >> weird names, data was unusable. But, it's raid1. Why is my data corrupt,
> >> I've read that BTRFS checks the checksum on read ?
> >
> > It suggests an additional problem, but we kinda need full dmesg to
> > figure it out I think. If it were just one device having either
> > partial or full failure, you'd get a bunch of messages indicating
> > those failure or csum mismatches as  well as fixup attempts which then
> > either succeed or fail. But no EIO. That there's EIO  suggests both
> > copies are somehow bad, so it could be two independent problems. That
> > there's four drives with a small number of reported corruptions could
> > mean some common problem affecting all of them: cabling or power
> > supply.
> >
>
> First try on unpacking the .tar.gz worked. Second try on the same
> .tar.gz now results in:
>
> gzip: stdin: Input/output error
> tar: Unexpected EOF in archive
> tar: Unexpected EOF in archive
> tar: Error is not recoverable: exiting now
>
> dmesg:
> [Fri Jun  4 09:53:03 2021] BTRFS warning (device sdc): csum failed root
> 5 ino 5114941 off 5247860736 csum 0x545eef4e expected csum 0x2cd08f83
> mirror 1
> [Fri Jun  4 09:53:03 2021] BTRFS error (device sdc): bdev /dev/sdb errs:
> wr 0, rd 0, flush 0, corrupt 323, gen 0
> [Fri Jun  4 09:53:03 2021] BTRFS warning (device sdc): csum failed root
> 5 ino 5114941 off 5247864832 csum 0x79b50174 expected csum 0xa744e4f5
> mirror 1
> [Fri Jun  4 09:53:03 2021] BTRFS error (device sdc): bdev /dev/sdb errs:
> wr 0, rd 0, flush 0, corrupt 324, gen 0
> [Fri Jun  4 09:53:03 2021] BTRFS warning (device sdc): csum failed root
> 5 ino 5114941 off 5247864832 csum 0x79b50174 expected csum 0xa744e4f5
> mirror 2
> [Fri Jun  4 09:53:03 2021] BTRFS error (device sdc): bdev /dev/sda errs:
> wr 0, rd 0, flush 0, corrupt 409, gen 0
> [Fri Jun  4 09:53:03 2021] repair_io_failure: 326 callbacks suppressed
> [Fri Jun  4 09:53:03 2021] BTRFS info (device sdc): read error
> corrected: ino 5114941 off 5247860736 (dev /dev/sdb sector 6674359360)
> [Fri Jun  4 09:53:03 2021] BTRFS warning (device sdc): csum failed root
> 5 ino 5114941 off 5247864832 csum 0x79b50174 expected csum 0xa744e4f5
> mirror 1
> [Fri Jun  4 09:53:03 2021] BTRFS error (device sdc): bdev /dev/sdb errs:
> wr 0, rd 0, flush 0, corrupt 325, gen 0
> [Fri Jun  4 09:53:03 2021] BTRFS warning (device sdc): csum failed root
> 5 ino 5114941 off 5247864832 csum 0x81568248 expected csum 0xa744e4f5
> mirror 2
> [Fri Jun  4 09:53:03 2021] BTRFS error (device sdc): bdev /dev/sda errs:
> wr 0, rd 0, flush 0, corrupt 410, gen 0
> [Fri Jun  4 09:53:03 2021] BTRFS warning (device sdc): csum failed root
> 5 ino 5114941 off 5247864832 csum 0x81568248 expected csum 0xa744e4f5
> mirror 1
> [Fri Jun  4 09:53:03 2021] BTRFS error (device sdc): bdev /dev/sdb errs:
> wr 0, rd 0, flush 0, corrupt 326, gen 0
> [Fri Jun  4 09:53:03 2021] BTRFS warning (device sdc): csum failed root
> 5 ino 5114941 off 5247864832 csum 0x81568248 expected csum 0xa744e4f5
> mirror 2
> [Fri Jun  4 09:53:03 2021] BTRFS error (device sdc): bdev /dev/sda errs:
> wr 0, rd 0, flush 0, corrupt 411, gen 0
> [Fri Jun  4 09:53:03 2021] BTRFS warning (device sdc): csum failed root
> 5 ino 5114941 off 5247864832 csum 0x79b50174 expected csum 0xa744e4f5
> mirror 1
> [Fri Jun  4 09:53:03 2021] BTRFS error (device sdc): bdev /dev/sdb errs:
> wr 0, rd 0, flush 0, corrupt 327, gen 0
> [Fri Jun  4 09:53:03 2021] BTRFS warning (device sdc): csum failed root
> 5 ino 5114941 off 5247864832 csum 0x81568248 expected csum 0xa744e4f5
> mirror 2
> [Fri Jun  4 09:53:03 2021] BTRFS error (device sdc): bdev /dev/sda errs:
> wr 0, rd 0, flush 0, corrupt 412, gen 0


This is data corruption being detected. We know this because of the
formatting "root X ino Y" which translates as subvolume ID inode
number. Scrub is a bit different because it will not only show path to
file, but also shows all instances of a bad block in common with every
snapshot/reflink. So it can be quite noisy (repetitive).

In the above sequence there is one inode, thus one file. But two
corrupt blocks. One was fixed from a good copy. The other was not. But
also some messages might be missing, which is indicated in this
message:

>[Fri Jun  4 09:53:03 2021] repair_io_failure: 326 callbacks suppressed

I'm not sure how to stop this suppression to make sure we've got a
complete picture of what's going on. Possibly it just means 326 of the
exact same prior message, but I'm not 100% certain of the meaning.


But there's more...

One block, both copies are bad. But mirror 2 is consistently bad,
whereas with mirror 1 there is an inconsistency. While three read
attempts are all wrong (csum does not match expected), 2 reads match
each other and 1 read is different. So there is even a transient
problem reading from this sector as it is, in addition to being wrong
all three times.

Is this system ever crashing or doing other weird things?


>
> No weird filenames though, and no sdd errors this time. I also see these
> errors in /var/log/messages (on a different filesystem), but I don't see
> any "csum failed" errors in the messages log of yesterday, when the
> strange filenames appeared..
>
> >
> >> 2) Are all my 4 drives faulty because of the corruption_errs ? If so, 4
> >> faulty drives is somewhat unusual. Any other possibilities ?
> >> 3) Given that
> >> - I can't 'btrfs device remove' the device
> >> - I do not have a free SATA port
> >> - I'd prefer a method that doesn't unnecessarily take a very long time
> >
> > You really don't want to remove a drive unless it's on fire. Partial
> > failures, you're better off leaving it in, until ready to be replaced.
> > And even then it is officially left in until replace completes. Btrfs
> > is AOK with partially failing drives, it can unambiguously determine
> > when any block is untrustworthy. But the partial failure case also
> > means possibly quite a lot of *good* blocks that you might need in
> > order to recover from this situation, so you don't want to throw the
> > baby out with the bath water, so to speak.
> >
> I think we're mixing 'btrfs device remove' with physically remove. I did
> not plan on physically remove, but I might be forced because the
> graceful 'btrfs device remove' results in an I/O error. Or is there a
> better way ? Can 'btrfs device remove' ignore errors and continue with
> the good blocks?

I recommend neither physical device removal nor btrfs device remove.
You really want to avoid that and use btrfs replace instead. If you do
a 'btrfs device remove' to go from 4x to 3x drives, it is a shrink
operation, involving reading every block on the entire array and
writing all new blocks to make a 3x array. It's expensive and slow.
Use btrfs replace instead. It's faster and safer.

> Apart from the general problem I might have (PSU for example), I might
> be able to hook up the new drive temporary via USB3 ? But, what would be
> the approach then ? I'd still need to 'btrfs device remove' sdd right,
> to evict data gracefully and replace it with the new one. But, btrfs
> remove results in an I/O error.

You still want to use 'btrfs replace' not 'btrfs dev add/remove'.
Btrfs replace can tolerate one bad copy and fix it up while also
replicating the new copy to the new drive. But btrfs remove should
tolerate it too if there is a good copy. If there is no good copy,
it's a huge fail whale and i expect btrfs just stops.

> Turns out my drives aren't very cool though. 2 have >45k hours, 2 have
>  >12k which should be kinda ok, but are SMR. Just might be that they are
> all failing.. any idea how plausible that scenario could be ?

I can't compute the probability. It does seem unlikely. Even if it's
something weird like all four drives are the same make/model/firmware
and are hitting some kind of firmware bug that's in common to them?
Rare but not impossible, perhaps even plausible. I think though, if
you have memory bitflips, this will show up elsewhere like in-memory
corruption unrelated to the file system, and cause weird behaviors
including random crashing. Same if it's power induced. I guess it
could be a SATA controller in common for all four drives. If that
becomes a real suspicion, moving two drives to USB SATA enclosures
might help isolate it. Not ideal but the key I've found to USB being
mostly reliable rather than mostly unreliable is the externally
powered USB hub - rather than direct connection to ports on the logic
board.


-- 
Chris Murphy
