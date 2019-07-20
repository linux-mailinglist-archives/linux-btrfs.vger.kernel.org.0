Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC0CA6EEA4
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jul 2019 11:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfGTJ1n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Jul 2019 05:27:43 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:62351 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbfGTJ1n (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Jul 2019 05:27:43 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id 7F1416036
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Jul 2019 11:27:40 +0200 (MEST)
Date:   Sat, 20 Jul 2019 11:27:40 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: find subvolume directories
Message-ID: <20190720092740.GA8099@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20190712231705.GA16856@tik.uni-stuttgart.de>
 <04d6d375-ee33-8d77-d139-a81302efd7f8@tty0.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04d6d375-ee33-8d77-d139-a81302efd7f8@tty0.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu 2019-07-18 (14:00), Axel Burri wrote:

> > I need to find (all) subvolume directories.
> > I know, btrfs subvolumes root directories have inode #256, but a
> > "find / -inum 256" is horrible slow!
> 
> https://github.com/digint/btrbk/commit/e12d980502
> 
>  - get mounted filesystems from /proc/self/mountinfo
>  - fetch subvolumes using "btrfs subvolume list" (fast, needs root)
>  - filter and print subvolumes below mount point

Meanwhile I have come to the same solution :-)
Only I use /proc/mounts instead of /proc/self/mountinfo

framstag@fex:/tmp: btrfs_list
ACCESS-MODE SUBVOLUME
rw /local/home/framstag/blubb
ro /local/home/framstag/blubb/.snapshot/2017-09-15_1811.test
ro /local/home/framstag/blubb/.snapshot/2017-11-30_1007.test
ro /local/home/framstag/blubb/.snapshot/2017-12-02_1026.test
ro /local/home/framstag/blubb/.snapshot/2019-07-18_0139.test
rw /local/tmp/test

My first (wrong) approach was to use 
btrfs subvolume list TOPLEVEL_SUBVOLUME_MOUNTPOINT 
only, but not all btrfs mountpoints.


> Note that this approach needs root, as "btrfs subvolume list" requires
> "cap_sys_admin" and "cap_dac_read_search".

My btrfs_list uses sudo and lists only subvolumes belonging to the user.


> # cd /tmp
> # wget https://raw.githubusercontent.com/digint/btrbk/action-ls/btrbk
> # chmod +x /tmp/btrbk
> 
> 
> List subvolumes below /home:
> 
> # ./btrbk ls /home

root@fex:~# /tmp/btrbk ls /local/
ERROR: Configuration file not found: /etc/btrbk.conf, /etc/btrbk/btrbk.conf
ERROR: Failed to parse configuration file

root@fex:~# touch /etc/btrbk.conf

root@fex:~# /tmp/btrbk ls /local/
/local
/local/home
/local/home/.snapshot/2019-07-14_0000.weekly
/local/home/.snapshot/2019-07-18_0000.daily
/local/home/.snapshot/2019-07-19_0000.daily
/local/home/.snapshot/2019-07-20_0000.daily
/local/home/.snapshot/2019-07-20_0900.hourly
/local/home/.snapshot/2019-07-20_1000.hourly
/local/home/.snapshot/2019-07-20_1100.hourly
/local/home/framstag/blubb
/local/home/framstag/blubb/.snapshot/2017-09-15_1811.test
/local/home/framstag/blubb/.snapshot/2017-11-30_1007.test
/local/home/framstag/blubb/.snapshot/2017-12-02_1026.test
/local/home/framstag/blubb/.snapshot/2019-07-18_0139.test
/local/home/smc/test
/local/spool/fex
/local/tmp/test

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<04d6d375-ee33-8d77-d139-a81302efd7f8@tty0.ch>
