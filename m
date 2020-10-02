Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E0A280C5A
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 04:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbgJBCot convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 1 Oct 2020 22:44:49 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44550 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgJBCot (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Oct 2020 22:44:49 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 82243834DDE; Thu,  1 Oct 2020 22:44:43 -0400 (EDT)
Date:   Thu, 1 Oct 2020 22:44:43 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Giovanni Biscuolo <g@xelera.eu>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: how to recover from "enospc errors during balance"
Message-ID: <20201002024216.GK5890@hungrycats.org>
References: <87r1qk4q4d.fsf@roquette.i-did-not-set--mail-host-address--so-tickle-me>
 <20200930000417.GH5890@hungrycats.org>
 <878scq1g0g.fsf@roquette.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <878scq1g0g.fsf@roquette.i-did-not-set--mail-host-address--so-tickle-me>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 01, 2020 at 10:56:15AM +0200, Giovanni Biscuolo wrote:
> Hello Zygo,
> 
> thank you for your help!
> 
> ...but I still cannot mount the filesystem RW, see below.
> 
> Zygo Blaxell <ce3g8jdj@umail.furryterror.org> writes:
> 
> > On Tue, Sep 29, 2020 at 04:25:06PM +0200, Giovanni Biscuolo wrote:
> 
> [...]
> 
> >> [6928066.755704] BTRFS info (device sda3): balance: start -dusage=50 -musage=70 -susage=70
> >
> > Never balance metadata on a schedule.  If it is done too often, and the
> > disk fills up, it will eventually lead to ENOSPC errors that are hard
> > to get out of...
> 
> OK I got it: I'll fix it as soon as I'll get to remount the (root)
> filesystem.
> 
> I was using an option I did not fully understand and I was not able to
> find such a warning in the documentation.
> 
> [...]
> 
> >> I tried to add a new device (I have 2 spare disks) but it does not work
> >> with a read-only filesystem.
> >> 
> >> Please how can I remount the filesystem read-write and free some space
> >> deleting some files?
> >
> > Add 'skip_balance' to mount options so that the next mount will not
> > attempt to resume balancing metadata.  Keep mounting and umounting
> > (not remounting) until it completes orphan and relocation cleanup (it
> > may take more than one attempt, probably fewer than 20 attempts).
> 
> I try to mount with this command:
> 
> --8<---------------cut here---------------start------------->8---
> 
> ~$ mount -o skip_balance,relatime,ssd,subvol=/ /dev/sda3 /
> mount: /: wrong fs type, bad option, bad superblock on /dev/sda3, missing codepage or helper program, or other error.
> 
> --8<---------------cut here---------------end--------------->8---
> 
> dmesg says:
> 
> --8<---------------cut here---------------start------------->8---
> 
> [7484575.970136] BTRFS info (device sda3): disk space caching is enabled
> [7484576.001375] BTRFS error (device sda3): Remounting read-write after error is not allowed
> 
> --8<---------------cut here---------------end--------------->8---
> 
> Am I doing something wrong?
> 
> It seems that the filesystem is not allowed to be remounted RW after the
> error.
> 
> I don't think rebooting is a good option since it will be unbootable
> (and it's a remote machine).
> 
> I fear the only option is to reboot from USB and revover :(
> 
> Do you have any other option in mind please?

Unfortunately, that's the only option that is known to work.  As dmesg
says, remounts are not allowed.  You have to umount and mount again,
and for a root fs that implies at least one reboot.  If you have /boot
on a separate filesystem you can add skip_balance to the rootflags and
then use a remote power switch to do the necessary reboots.  If /boot is
on the root filesystem you'll need remote console access or boot from USB.

If the system was expendable, I'd try booting it in qemu-kvm using its
own disks as raw filesystem images, but that has high risk of trashing
the whole filesystem (and might be hard to implement if you don't already
have kvm installed on the host).

> > Once you have the filesystem mounted, run 'btrfs balance cancel' on
> > the mount point.  Then edit your maintenance scripts and remove the
> > metadata balance (-m flag to 'btrfs balance start').
> 
> OK clear thanks.
> 
> >> Additional data:
> >> 
> >> --8<---------------cut here---------------start------------->8---
> 
> [...]
> 
> >> ~$ sudo btrfs fi usage /
> >> Overall:
> >>     Device size:                 899.07GiB
> >>     Device allocated:            899.07GiB
> >>     Device unallocated:            2.01MiB
> >>     Device missing:                  0.00B
> >>     Used:                        897.05GiB
> >>     Free (estimated):             85.87MiB      (min: 85.87MiB)
> >>     Data ratio:                       2.00
> >>     Metadata ratio:                   2.00
> >>     Global reserve:              512.00MiB      (used: 5.53MiB)
> >> 
> >> Data,RAID1: Size:446.50GiB, Used:446.42GiB (99.98%)
> >>    /dev/sda3     446.50GiB
> >>    /dev/sdb3     446.50GiB
> >> 
> >> Metadata,RAID1: Size:3.00GiB, Used:2.11GiB (70.22%)
> >>    /dev/sda3       3.00GiB
> >>    /dev/sdb3       3.00GiB
> >> 
> >> System,RAID1: Size:32.00MiB, Used:80.00KiB (0.24%)
> >>    /dev/sda3      32.00MiB
> >>    /dev/sdb3      32.00MiB
> >> 
> >> Unallocated:
> >>    /dev/sda3       1.00MiB
> >>    /dev/sdb3       1.00MiB
> 
> [...]
> 
> > To avoid this, never run metadata balances from a scheduled job (or for
> > any reason other than working around a kernel bug or adding disks to a
> > RAID array) so that an appropriate number of metadata block groups is
> > allocated and _stay_ allocated.
> 
> [...]
> 
> > Scheduled data balances (-d) are OK.  They defragment free space and
> > improve allocator performance, and make unallocated space available so
> > that additional metadata block groups can be allocated when necessary.
> 
> OK got it: thank you for the clear and complete explanation.
> 
> No doubt I made a bad mistake with that scheduled job :-(
> 
> [...]
> 
> Thanks, Giovanni.
> 
> -- 
> Giovanni Biscuolo
> 
> Xelera IT Infrastructures


