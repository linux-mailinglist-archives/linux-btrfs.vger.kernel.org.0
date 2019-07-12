Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27313676BA
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jul 2019 01:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfGLXRJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jul 2019 19:17:09 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:48826 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbfGLXRJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jul 2019 19:17:09 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id EF9C7885D
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Jul 2019 01:17:05 +0200 (MEST)
Date:   Sat, 13 Jul 2019 01:17:05 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: find subvolume directories
Message-ID: <20190712231705.GA16856@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I need to find (all) subvolume directories.
I know, btrfs subvolumes root directories have inode #256, but a
"find / -inum 256" is horrible slow!

Next idea: "btrfs subvolume list /" is really fast, but its output is not
always direct usable to find the subvolume directory.

Example output on a SUSE system:

root@trulla:~# btrfs subvolume list /
ID 257 gen 2280099 top level 5 path @
ID 258 gen 2280769 top level 257 path @/home
ID 259 gen 2280947 top level 257 path @/opt
ID 260 gen 2280098 top level 257 path @/srv
ID 261 gen 2280954 top level 257 path @/tmp
ID 262 gen 2280187 top level 257 path @/usr/local
ID 263 gen 2280099 top level 257 path @/var/crash
ID 264 gen 2280949 top level 257 path @/var/log
ID 265 gen 2280099 top level 257 path @/var/opt
ID 266 gen 2280954 top level 257 path @/var/spool
ID 267 gen 2280947 top level 257 path @/var/tmp
ID 270 gen 2280222 top level 257 path @/.snapshots
ID 453 gen 2280954 top level 270 path @/.snapshots/128/snapshot
ID 1235 gen 2280099 top level 257 path @/var/lib/machines
ID 12392 gen 2123118 top level 270 path @/.snapshots/1065/snapshot
ID 12393 gen 2123120 top level 270 path @/.snapshots/1066/snapshot
ID 13273 gen 2176640 top level 270 path @/.snapshots/1089/snapshot
ID 13274 gen 2176651 top level 270 path @/.snapshots/1090/snapshot
ID 13553 gen 2203681 top level 270 path @/.snapshots/1103/snapshot

There is no /@/ directory in the default filesystem because of:

root@trulla:/# stat /@/.snapshots/128/snapshot
stat: cannot stat '/@/.snapshots/128/snapshot': No such file or directory

root@trulla:~# btrfs subvolume get-default /
ID 453 gen 2280954 top level 270 path @/.snapshots/128/snapshot

root@trulla:/# mount | grep " / "
/dev/sda2 on / type btrfs (rw,relatime,space_cache,subvolid=453,subvol=/@/.snapshots/128/snapshot)

On this particular system I could remove "@" from the subvolume path to
get the subvolume directory:

root@trulla:/# stat /.snapshots/128/snapshot
  File: '/.snapshots/128/snapshot'
  Size: 198             Blocks: 0          IO Block: 4096   directory
Device: 27h/39d Inode: 256         Links: 1
Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2019-07-13 01:03:08.543830085 +0200
Modify: 2019-07-13 01:03:37.336445461 +0200
Change: 2019-07-13 01:03:37.336445461 +0200
 Birth: -

But what if a btrfs filesystem does not have a toplevel /@/ directory, but
anything else, like /this/is/my/top/directory ?

Will be the first output line of "btrfs subvolume list /"
always look like

ID 257 gen 2280099 top level 5 path this/is/my/top/directory 

?



-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20190712231705.GA16856@tik.uni-stuttgart.de>
