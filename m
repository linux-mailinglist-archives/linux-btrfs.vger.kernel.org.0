Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5555E185FA0
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Mar 2020 20:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgCOTqz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 15 Mar 2020 15:46:55 -0400
Received: from smtp66.iad3a.emailsrvr.com ([173.203.187.66]:41361 "EHLO
        smtp66.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727329AbgCOTqy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Mar 2020 15:46:54 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Mar 2020 15:46:53 EDT
Received: from app55.wa-webapps.iad3a (relay-webapps.rsapps.net [172.27.255.140])
        by smtp33.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 2841119BD
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Mar 2020 15:40:43 -0400 (EDT)
X-Sender-Id: rmosemann@futurefoam.com
Received: from app55.wa-webapps.iad3a (relay-webapps.rsapps.net [172.27.255.140])
        by 0.0.0.0:25 (trex/5.7.12);
        Sun, 15 Mar 2020 15:40:43 -0400
Received: from futurefoam.com (localhost.localdomain [127.0.0.1])
        by app55.wa-webapps.iad3a (Postfix) with ESMTP id 159CF6057F
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Mar 2020 15:40:43 -0400 (EDT)
Received: by webmail.futurefoam.com
    (Authenticated sender: rmosemann@futurefoam.com, from: rmosemann@futurefoam.com) 
    with HTTP; Sun, 15 Mar 2020 14:40:43 -0500 (CDT)
X-Auth-ID: rmosemann@futurefoam.com
Date:   Sun, 15 Mar 2020 14:40:43 -0500 (CDT)
Subject: 100% disk usage reported by "df"
From:   "Russell Mosemann" <rmosemann@futurefoam.com>
To:     linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8BIT
Importance: Normal
X-Priority: 3 (Normal)
X-Type: plain
Message-ID: <1584301243.085416989@webmail.futurefoam.com>
X-Mailer: webmail/17.2.10-RC
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

df displays 100% disk usage when 119GB is used out of 9TB on a freeshly-installed system. The issue surfaces when disk usage is somewhere over the low 100GBs. Existing systems with lots of data that were upgraded to kernel 5.4 do not exhibit this problem. Other freshly-installed systems with less than 100GB do not show this problem. It is unknown if they will exhibit the problem, as disk usage increases. btrfs reports the correct disk space, and the system is writable. I wiped the drive, recreated the file system and the problem reappeared after a couple of days, when disk usage exceeded 100GB. Files are being copied with --reflink every day. Snapshots are not being made, and there are no subvolumes.

# uname -a
Linux vhost361 5.4.0-0.bpo.3-amd64 #1 SMP Debian 5.4.13-1~bpo10+1 (2020-02-07) x86_64 GNU/Linux

# cat /etc/fstab
UUID=913... /usr/local/data/datastore2 btrfs   noatime,compress-force=zstd   0  0

# df
Filesystem      1K-blocks      Used  Available Use% Mounted on
/dev/sdc1      9766434816 123744020          0 100% /usr/local/data/datastore2

# btrfs subvolume list /usr/local/data/datastore2
#

# btrfs fi show
Label: 'datastore2'  uuid: 91361c03-cb4f-4d8d-954d-5a1e983daabd
       Total devices 1 FS bytes used 116.77GiB
       devid    1 size 9.09TiB used 120.02GiB path /dev/sdc1

# btrfs fi df /usr/local/data/datastore2
Data, single: total=118.00GiB, used=115.96GiB
System, DUP: total=8.00MiB, used=16.00KiB
Metadata, DUP: total=1.00GiB, used=827.66MiB
GlobalReserve, single: total=444.61MiB, used=0.00B

# btrfs fi usage /usr/local/data/datastore2
Overall:
   Device size:                   9.09TiB
   Device allocated:            120.02GiB
   Device unallocated:            8.98TiB
   Device missing:                  0.00B
   Used:                        117.58GiB
   Free (estimated):              8.98TiB      (min: 4.49TiB)
   Data ratio:                       1.00
   Metadata ratio:                   2.00
   Global reserve:              444.61MiB      (used: 0.00B)

Data,single: Size:118.00GiB, Used:115.96GiB
  /dev/sdc1     118.00GiB

Metadata,DUP: Size:1.00GiB, Used:827.66MiB
  /dev/sdc1       2.00GiB

System,DUP: Size:8.00MiB, Used:16.00KiB
  /dev/sdc1      16.00MiB

Unallocated:
  /dev/sdc1       8.98TiB

# btrfsck /dev/sdc1
Opening filesystem to check...
Checking filesystem on /dev/sdc1
UUID: 91361c03-cb4f-4d8d-954d-5a1e983daabd
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 125379792896 bytes used, no error found
total csum bytes: 121563204
total tree bytes: 867876864
total fs tree bytes: 401555456
total extent tree bytes: 317325312
btree space waste bytes: 104952067
file data blocks allocated: 265984520192
referenced 747687165952

--
Russell Mosemann

