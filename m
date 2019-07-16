Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6C286A000
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 02:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732557AbfGPAlo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jul 2019 20:41:44 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:54658 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730383AbfGPAlo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jul 2019 20:41:44 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id 9E9296349
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2019 02:41:41 +0200 (MEST)
Date:   Tue, 16 Jul 2019 02:41:40 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC] a standard user-friendly way to find a snapshot in nested
 subvolumes [was: find subvolume directories]
Message-ID: <20190716004140.GA32687@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20190712231705.GA16856@tik.uni-stuttgart.de>
 <75e5bd20-fafa-07fd-afd9-159e9aacb7db@gmail.com>
 <20190713082759.GB16856@tik.uni-stuttgart.de>
 <62366a29-a8ea-a889-f857-0305eba99051@gmail.com>
 <20190713112832.GA30696@tik.uni-stuttgart.de>
 <20190715132228.GF4212@pontus.sran>
 <20190715224051.GA30754@tik.uni-stuttgart.de>
 <20190715235821.rh7elbip3dgzkq7y@DigitalMercury.dynalias.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715235821.rh7elbip3dgzkq7y@DigitalMercury.dynalias.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon 2019-07-15 (19:58), Nicholas D Steeves wrote:

> > I need a list of all subvolumes DIRECTORIES, to be accessible with
> > standard UNIX commands like cd and ls or btrfs subvolume show
> > 
> 
> "a list of all subvolumes DIRECTORIES" doesn't make sense...  It
> sounds like you want to list all available subvolumes (presumably
> snapshots, given that the path has BUP in it), to find a specific one
> you want

Yes, but not limited to snapshots. I want a list of ALL subvolumes
directories. 


> and then access an older copy of one of your files.

Sometimes yes, sometimes not.
Sometimes I want make a new snapshot. But then I have to know what
directories are "snapshootable", aka btrfs subvolumes.
"btrfs subvolume snapshot" needs as first parameter the directory name of
the subvolume, so I have to know it!


> Something like the following method might do the trick:
> 
> First, mount /dev/sdX to /btrfs-admin without using a subvol option.
> This will wonly work if you haven't changed the default subvol.

Only root can do mounting.
I need a solution for every user!


>   sudo btrfs sub list -at /btrfs-admin/ | sed 's:<FS_TREE>:btrfs-admin:

Then I still do not know where it is in my standard UNIX filesystems.

I am looking for a faster (native btrfs command) version of:

root@trulla:~# find / -type d -inum 256
/
/home
/home/tux/blubb
/opt
/opt/.snapshot/2019-07-11_0000.daily
/opt/.snapshot/2019-07-12_0000.daily
/opt/.snapshot/2019-07-13_0000.daily
/opt/.snapshot/2019-07-15_0000.daily
/opt/.snapshot/2019-07-16_0000.daily
/opt/.snapshot/2019-07-16_0100.hourly
/opt/.snapshot/2019-07-16_0200.hourly
/srv
/tmp
/tmp/test
/usr/local
/var/crash
/var/log
/var/opt
/var/spool
/var/tmp
/var/lib/machines
/sys/fs/cgroup/systemd/system.slice/wickedd-auto4.service
/mnt/tmp
/mnt/tmp/ss
/.snapshots
find: File system loop detected; '/.snapshots/128/snapshot' is part of the same file system loop as '/'.
/.snapshots/1065/snapshot
/.snapshots/1066/snapshot
/.snapshots/1089/snapshot
/.snapshots/1090/snapshot
/.snapshots/1103/snapshot
/.snapshots/1104/snapshot
(...)

This is VERY slow, because it scans through all of my files, even on nfs!

My next idea was:

root@fex:~# df --output=fstype,target | awk '/^btrfs/{print "find "$2" -type d -inum 256 -xdev"}' | sh -x
+ find /backup -type d -inum 256 -xdev
/backup
/backup/fex
/backup/diaspora
+ find /local -type d -inum 256 -xdev
/local
/local/home
/local/spool/fex

But this does not descend subvolumes, because "find" thinks it is on a
different filesystem (-xdev)

For example, it does not find:

root@fex:~# ll /local/home/.snapshot/
drwxr-xr-x  root     root     - 2017-08-31 08:28:11  /local/home/.snapshot/2019-07-13_0000.daily
drwxr-xr-x  root     root     - 2017-08-31 08:28:11  /local/home/.snapshot/2019-07-14_0000.weekly
drwxr-xr-x  root     root     - 2017-08-31 08:28:11  /local/home/.snapshot/2019-07-15_0000.daily
drwxr-xr-x  root     root     - 2017-08-31 08:28:11  /local/home/.snapshot/2019-07-15_2300.hourly
drwxr-xr-x  root     root     - 2017-08-31 08:28:11  /local/home/.snapshot/2019-07-16_0000.daily
drwxr-xr-x  root     root     - 2017-08-31 08:28:11  /local/home/.snapshot/2019-07-16_0100.hourly
drwxr-xr-x  root     root     - 2017-08-31 08:28:11  /local/home/.snapshot/2019-07-16_0200.hourly

root@fex:~# btrfs subvolume show /local/home/.snapshot/2019-07-13_0000.daily
home/.snapshot/2019-07-13_0000.daily
        Name:                   2019-07-13_0000.daily
        UUID:                   084b1f18-b700-5845-a32d-f151db6a9f57
        Parent UUID:            ba4d388f-44bf-7b46-b2b8-00e2a9a87181
        Received UUID:          -
        Creation time:          2019-07-13 00:00:01 +0200
        Subvolume ID:           17957
        Generation:             1645903
        Gen at creation:        1645903
        Parent ID:              350
        Top level ID:           350
        Flags:                  readonly
        Snapshot(s):



-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20190715235821.rh7elbip3dgzkq7y@DigitalMercury.dynalias.net>
