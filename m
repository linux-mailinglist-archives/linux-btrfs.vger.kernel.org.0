Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC9CA6A6EE
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 13:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbfGPLEt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jul 2019 07:04:49 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:33737 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733037AbfGPLEs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jul 2019 07:04:48 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id 33318A57B
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2019 13:04:45 +0200 (MEST)
Date:   Tue, 16 Jul 2019 13:04:45 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: find subvolume directories
Message-ID: <20190716110445.GA11010@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20190712231705.GA16856@tik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712231705.GA16856@tik.uni-stuttgart.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat 2019-07-13 (01:17), Ulli Horlacher wrote:
> I need to find (all) subvolume directories.
> I know, btrfs subvolumes root directories have inode #256, but a
> "find / -inum 256" is horrible slow!

Because it scans also non-btrfs filesystems. This is especially a bad idea
for nfs.

I have now implemented the search for inode 256 in Perl using the algorithm: 

- get a list of all mounted filesystems (via df)
- for each btrfs filesystem do a recursive search for directories with
  inode 256
- stop recursion if the directory is on another (mounted) filesystem


This speeds up the search:

root@trulla:/opt/btrfs-tools/bin# sysinfo 
System:        Linux trulla 4.4.180-94.97-default x86_64
Distribution:  SUSE Linux Enterprise Server 12 SP3
Hardware:      VMware, Inc. VMware Virtual Platform None (VMware)
CPU:           Intel(R) Xeon(R) CPU E5-2680 v4 @ 2.40GHz, 1 x 2394 MHz
RAM:           1024 MB

root@trulla:/opt/btrfs-tools/bin# dropfscache;time btrfs_list -r
ACCESS-MODE SUBVOLUME <- SNAPSHOT-PARENT
rw / <- -
rw /.snapshots
ro /.snapshots/1065/snapshot <- /
ro /.snapshots/1066/snapshot <- /
ro /.snapshots/1089/snapshot <- /
ro /.snapshots/1090/snapshot <- /
ro /.snapshots/1103/snapshot <- /
ro /.snapshots/1104/snapshot <- /
ro /.snapshots/1107/snapshot <- /
ro /.snapshots/1108/snapshot <- /
ro /.snapshots/1127/snapshot <- /
ro /.snapshots/1128/snapshot <- /
ro /.snapshots/1131/snapshot <- /
ro /.snapshots/1132/snapshot <- /
ro /.snapshots/1133/snapshot <- /
ro /.snapshots/1134/snapshot <- /
ro /.snapshots/1135/snapshot <- /
ro /.snapshots/1136/snapshot <- /
ro /.snapshots/1137/snapshot <- /
ro /.snapshots/1138/snapshot <- /
ro /.snapshots/1139/snapshot <- /
ro /.snapshots/1140/snapshot <- /
rw /.snapshots/128/snapshot <- -
rw /home
rw /home/tux/blubb
rw /mnt/tmp
ro /mnt/tmp/ss
rw /opt
ro /opt/.snapshot/2019-07-11_0000.daily <- /opt
ro /opt/.snapshot/2019-07-12_0000.daily <- /opt
ro /opt/.snapshot/2019-07-13_0000.daily <- /opt
ro /opt/.snapshot/2019-07-15_0000.daily <- /opt
ro /opt/.snapshot/2019-07-16_0000.daily <- /opt
ro /opt/.snapshot/2019-07-16_1100.hourly <- /opt
ro /opt/.snapshot/2019-07-16_1200.hourly <- /opt
rw /srv
rw /tmp
rw /tmp/blubb
ro /tmp/blubb/.snapshot/2017-09-20_1801.test <- /tmp/blubb
ro /tmp/blubb/.snapshot/2017-12-02_0940.test <- /tmp/blubb
ro /tmp/blubb/.snapshot/2018-01-11_1415.test <- /tmp/blubb
ro /tmp/test
rw /usr/local
rw /var/crash
rw /var/lib/machines
rw /var/log
rw /var/opt
rw /var/spool
rw /var/tmp

real    0m4.301s
user    0m1.352s
sys     0m1.438s


(dropfscache drops the filesystem cache to have a reproducable test)

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20190712231705.GA16856@tik.uni-stuttgart.de>
