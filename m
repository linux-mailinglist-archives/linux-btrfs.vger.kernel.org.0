Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651461C22EF
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 06:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgEBEbj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 2 May 2020 00:31:39 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48280 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgEBEbj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 May 2020 00:31:39 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 90FC069F964; Sat,  2 May 2020 00:31:34 -0400 (EDT)
Date:   Sat, 2 May 2020 00:31:34 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Phil Karn <karn@ka9q.net>
Cc:     Jean-Denis Girard <jd.girard@sysnux.pf>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Extremely slow device removals
Message-ID: <20200502043134.GI10769@hungrycats.org>
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
 <r8f4gb$8qt$1@ciao.gmane.io>
 <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net>
 <20200502033509.GG10769@hungrycats.org>
 <CAMwB8mjUw+KV8mxg8ynPsv0sj5vSpwG7_khw=oP5n+SnPYzumQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAMwB8mjUw+KV8mxg8ynPsv0sj5vSpwG7_khw=oP5n+SnPYzumQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 01, 2020 at 09:12:11PM -0700, Phil Karn wrote:
>    Thanks for the explanations of what replace and delete ("remove"?)
>    actually do; that's helpful. I'm still puzzled as to why there was so much
>    write activity to the drive I was removing; can you explain that?
>    My hand was ultimately forced today. The device remove running since last
>    weekend bombed out with a "no space" message in the kernel log despite
>    there being plenty of free space on all devices. The file system had been

Debugging metadata space reservations is an activity that was started 7
years ago and has maybe 2-5 years of debugging left.  (half-;)

>    remounted read-only. When I brought it back up, the mount system call
>    blocked while it underwent what was apparently a lengthy file system
>    check. (I got one message about a block group free space cache being
>    rebuilt). 

OK, you aren't using space_cache=v2 yet.  Unmount the filesystem and
mount with -o space_cache=v2.  It will take a long time to build the
cache (up to an hour per TB), but once it has, it should get a lot faster.

>    It really doesn't seem like such a good idea for a really basic
>    system call like "mount" to block indefinitely during system boot. 

mount has to take apart any relocation tree that may have been in
progress during shutdown (up to one block group's worth of metadata),
so it can take an arbitrary amount of time (though not usually more than
40 minutes, unless you're mounting with space_cache=v2 for the first time).

>    systemd
>    eventually gives up, but it does take a while. Lots and lots of stack
>    traces in dmesg about system calls blocking for more than 120 sec. Usually
>    mount, but also sd-sync when trying to shut the system down gracefully.
>    Eventually I was forced to hit hard reset.
>    These blocking mounts make it kinda painful to get a root shell just so
>    you can see what's going on. This is why I'll never put a root filesystem
>    on btrfs. I keep my root filesystems in XFS or ext4 on a SSD so I can at
>    least pull all the other drives and boot up single user fairly quickly.

I had a few systems configured that way--then some disk failures happened,
and it turns out that in the real world, ext4 is as fragile as btrfs but
lacks the integrity measurement and self-repair features.  So now I just
put two root filesystems on each machine, then if something bad happens
to the primary, the secondary root can be easily selected from a grub
"rescue" option.

>    I'll manually rsync the root file system onto a spare disk partition as a
>    backup.
>    Before rebooting I physically pulled the drive I was trying to replace and
>    set noauto in /etc/fstab on the btrfs fs. Back in multi-user mode at last,
>    I did a mount with degraded enabled and got the expected message about the
>    missing device (confirming I pulled the right one). It's still madly doing
>    I/O, but since it's not telling me what's going on (and the mount has not
>    completed) I have to assume from the I/O patterns that it's continuing the
>    device remove without it being physically present. I guess if I'm lucky
>    I'll be able to use my filesystem in a week or so. I do have a backup but
>    I'd rather not touch it except as a last resort.
>    On Fri, May 1, 2020 at 8:35 PM Zygo Blaxell
>    <[1]ce3g8jdj@umail.furryterror.org> wrote:
> 
>      On Fri, May 01, 2020 at 01:05:20AM -0700, Phil Karn wrote:
>      > On 4/30/20 11:13, Jean-Denis Girard wrote:
>      > >
>      > > Hi Phil,
>      > >
>      > > I did something similar one month ago. It took less than 4 hours for
>      > > 1.71 TiB of data:
>      > >
>      > > [xxx@taina ~]$ sudo btrfs replace status /home/SysNux
>      > > Started on 21.Mar 11:13:20, finished on 21.Mar 15:06:33, 0 write
>      errs, 0
>      > > uncorr. read errs
>      >
>      > I just realized you did a *replace* rather than a *remove*. When I did
>      a
>      > replace on another drive, it also went much faster. It must copy the
>      > data from the old drive to the new one in larger and/or more
>      contiguous
>      > chunks. It's only the remove operation that's painfully slow.
> 
>      "Replace" is a modified form of scrub which assumes that you want to
>      reconstruct an entire drive instead of verifying an existing one.
>      It reads and writes all the blocks roughly in physical disk order,
>      and doesn't need to update any metadata since it's not changing any of
>      the data as it passes through.
> 
>      "Delete" is resize to 0 followed by remove the empty device.  Resize
>      requires relocating all data onto other disks--or other locations on
>      the same disk--one extent at a time, and updating all of the reference
>      pointers in the filesystem.
> 
>      The difference in speed can be several orders of magnitude.
> 
>      > Phil
>      >
>      >
> 
> References
> 
>    Visible links
>    1. mailto:ce3g8jdj@umail.furryterror.org
