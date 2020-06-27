Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B74E20BDB7
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jun 2020 04:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgF0CVZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 26 Jun 2020 22:21:25 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:39770 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgF0CVY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 22:21:24 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 0217A735853; Fri, 26 Jun 2020 22:21:21 -0400 (EDT)
Date:   Fri, 26 Jun 2020 22:21:21 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     DanglingPointer <danglingpointerexception@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: RAID5 scrub 1 or 2 disks at a time instead to speed up
Message-ID: <20200627022116.GR10769@hungrycats.org>
References: <75eef36f-b85a-9ec3-2d77-df646c536712@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <75eef36f-b85a-9ec3-2d77-df646c536712@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 25, 2020 at 08:23:35PM +1000, DanglingPointer wrote:
> Hi All,
> 
> I continually get frustrated each time I have a scrub a btrfs RAID5 array
> due to the slow rate.
> I was wondering if anyone has tried or seriously considered scrubbing 1 or 2
> disks at a time, instead of all disks engaged at the same time (perhaps a
> division check on number of disks before start) to see if it is indeed
> faster?
> 
> Zygo Blaxell mentioned the above idea on Feb 6 this year.  Just wondering if
> there's been any serious thought put into the merits of that idea?

When you run 'btrfs scrub' on a filesystem, userspace creates a thread
for each disk, and in that thread, invokes the kernel scrub ioctl which
takes a device ID as a parameter, i.e. each userspace thread runs scrub on
one disk in the array.  

Running a 'btrfs scrub start /dev/xyz' process on each disk in a btrfs
array in parallel is exactly equivalent to running 'btrfs scrub start
/mnt/filesystem' on the entire array.

For mirrored and striped RAID profiles, the kernelspace ioctl reads,
verifies, and repairs data blocks from only one disk, and each thread
ignores all the other disks.  In this case the kernel interface and
implementation are matched with the userspace program that operates them.

For parity RAID profiles, this does not work.  Entire stripes must be
read at once to compute and verify parity.  Each kernel thread will
read every disk, then correct errors on only the disk identified in
the scrub argument.  Running all of these threads at the same time will
create obvious performance penalties due to redundant reads (each disk
is read N times) and seeking (every thread is competing to read every
disk as fast as it can with no synchronization or ordering).

A quick and dirty short-term fix would be to have a btrfs scrub
command-line switch to run each disk's scrub thread sequentially instead
of in parallel.  Bonus points for enabling this switch by default if
the filesystem contains any raid5 or raid6 block groups, so admins don't
have to figure it out for themselves.

> The array I'm running the scrub on now has 7 disks (5x 2TB and 2x 6TB).  If
> it is a question of diminishing returns on speed as the number of disks
> increases; perhaps we say up to 8 disks then do 1 or 2 at a time
> sequentially, then over 8 just do default like right now?

The current problem isn't scalability across stripe width.  The current
problem is a kernel interface and implementation for scrub that was
designed prior to the existence of parity RAID on btrfs.

It's not possible to fix this with less effort than writing a completely
new scrub interface and implemenation for the kernel that is designed
to work well with raid56 block groups.

> If it is indeed faster then it would make the uptake of btrfs RAID56 a lot
> more friendlier and decrease the amount of flak it gets in the wild.
