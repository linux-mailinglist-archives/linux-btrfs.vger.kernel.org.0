Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D897C2DD192
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 13:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgLQMkf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 07:40:35 -0500
Received: from smtp01.belwue.de ([129.143.71.86]:45968 "EHLO smtp01.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgLQMkf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 07:40:35 -0500
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Dec 2020 07:40:33 EST
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp01.belwue.de (Postfix) with SMTP id A80119CD0
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 13:30:08 +0100 (MET)
Date:   Thu, 17 Dec 2020 13:30:08 +0100
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: how to extend a btrfs disk image?
Message-ID: <20201217123008.GA22831@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


How can I add a second disk-image to an existing btrfs filesystem?

I have to use btrfs via a disk image on a nfs Netapp storage system with a
16 TB file size limit. One cannot use bigger files.

I have set up sucessfully:

root@fextest:/nfs/rusnas/fex# touch disk1.btrfs
root@fextest:/nfs/rusnas/fex# truncate -s 16TB disk1.btrfs
root@fextest:/nfs/rusnas/fex# ll disk1.btrfs
-rw-r--r-- root root 16,000,000,000,000 2020-12-17 13:18:59 disk1.btrfs
root@fextest:/nfs/rusnas/fex# mkfs.btrfs disk1.btrfs
btrfs-progs v5.4.1
See http://btrfs.wiki.kernel.org for more information.

Label:              (null)
UUID:               4f7befb1-c892-497f-a40c-c6ac1a18368d
Node size:          16384
Sector size:        4096
Filesystem size:    14.55TiB
Block group profiles:
  Data:             single            8.00MiB
  Metadata:         DUP               1.00GiB
  System:           DUP               8.00MiB
SSD detected:       no
Incompat features:  extref, skinny-metadata
Checksum:           crc32c
Number of devices:  1
Devices:
   ID        SIZE  PATH
    1    14.55TiB  disk1.btrfs

root@fextest:/nfs/rusnas/fex# mount disk1.btrfs /mnt/tmp
root@fextest:/nfs/rusnas/fex# df -TH /mnt/tmp
Filesystem     Type   Size  Used Avail Use% Mounted on
/dev/loop2     btrfs   16T  3.7M   16T   1% /mnt/tmp


No problem so far, everything is easy ;-)

Now I want to extend this filesystem, but this approach fails:

root@fextest:/nfs/rusnas/fex# touch disk2.btrfs
root@fextest:/nfs/rusnas/fex# truncate -s 16TB disk2.btrfs
root@fextest:/nfs/rusnas/fex# btrfs device add /nfs/rusnas/fex/disk2.btrfs /mnt/tmp
ERROR: /nfs/rusnas/fex/disk2.btrfs is not a block device


root@fextest:/nfs/rusnas/fex# sysinfo 
System:        Linux fextest 5.4.0-58-generic x86_64
Distribution:  Ubuntu 20.04.1 LTS
Hardware:      VMware, Inc. VMware Virtual Platform None (VMware)
CPU:           Intel(R) Xeon(R) CPU E5-2680 v4 @ 2.40GHz, 4 x 2394 MHz
RAM:           4095 MB

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20201217123008.GA22831@tik.uni-stuttgart.de>
