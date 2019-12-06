Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92AF8114AC1
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 03:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfLFCE0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 21:04:26 -0500
Received: from mail.virtall.com ([46.4.129.203]:60274 "EHLO mail.virtall.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfLFCE0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 21:04:26 -0500
Received: from mail.virtall.com (localhost [127.0.0.1])
        by mail.virtall.com (Postfix) with ESMTP id 0F05F398F986
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2019 02:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wpkg.org; s=default;
        t=1575597862; bh=/78HoSrkT/HAlguBN1NUcKjFes1BZpH6K7uLvVxEwzU=;
        h=Date:From:To:Subject;
        b=YW/4bUyDJ/ScaQvhC19saOseONx8td/fSnGWeOx80xWsQ/tfkbFwL+ZgGEg/EJU7M
         FQxCD8vg9f2Q7R1YR4KWm7jE/T8aIQX1x4ABEpV/EELZt5dNfzoVS02IxqaQqi9SWH
         truFr64SnmZq9hTYBLWp1N6QhXFCZ7zkigujL7cR9r2GtPQeW34JfQ/OswhGUapDt8
         wZ+2flkxBxA9WUMG2IjVP9dkR+CgBvoxhQFtgZsKNzt8zrGl90Hr5mRwaDAsnMWMJT
         K1ZwD/46BIlw8vRlRlrXOLcXRQgLsOYWxwB/bfYm0mGjrOOHK04fKTmwCQjS/VB/44
         KOd98366piVaA==
X-Fuglu-Suspect: c5d3cca83c6b4f1f80cf583d6d35924a
X-Fuglu-Spamstatus: NO
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.virtall.com
X-Spam-Status: No, score=-0.4 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TO_NO_BRKTS_PCNT autolearn=no autolearn_force=no
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: tch@virtall.com)
        by mail.virtall.com (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2019 02:04:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Dec 2019 11:04:20 +0900
From:   Tomasz Chmielewski <mangoo@wpkg.org>
To:     linux-btrfs@vger.kernel.org
Subject: 100% disk usage reported by "df", 60% disk usage reported by "btrfs
 fi usage" - this breaks userspace behaviour
Message-ID: <eb9cfb919176c239d864f78e5756f1db@wpkg.org>
X-Sender: mangoo@wpkg.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I know that "df -h" is not to be trusted with btrfs, but some userspace 
tools (i.e. apt, monitoring checks) rely on it.

Sometimes, "df -h" will report 100% disk usage on a btrfs filesystem, 
while there is still space available and writes are possible.

Linux 5.4.1, LXD containers located in /data:

# df -h
/dev/nvme1n1               1000G  571G     0 100% /data

# btrfs fi usage /data
Overall:
     Device size:                1000.00GiB
     Device allocated:            580.02GiB
     Device unallocated:          419.98GiB
     Device missing:                  0.00B
     Used:                        570.06GiB
     Free (estimated):            429.45GiB      (min: 429.45GiB)
     Data ratio:                       1.00
     Metadata ratio:                   1.00
     Global reserve:              512.00MiB      (used: 0.00B)

Data,single: Size:578.01GiB, Used:568.54GiB
    /dev/nvme1n1  578.01GiB

Metadata,single: Size:2.01GiB, Used:1.53GiB
    /dev/nvme1n1    2.01GiB

System,single: Size:4.00MiB, Used:80.00KiB
    /dev/nvme1n1    4.00MiB

Unallocated:
    /dev/nvme1n1  419.98GiB


 From container point of view, it looks like:

container# df -h
Filesystem                  Size  Used Avail Use% Mounted on
/dev/nvme1n1               1000G  571G     0 100% /


Let's see if we can still write? Yes we can:

container# dd if=/dev/urandom of=/bigfile.img bs=1M count=1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 7.28306 s, 147 MB/s
container# sync
container# rm /bigfile.img


Let's try to use apt - unfortunately it says that there is not enough 
space in /var/cache/apt/archives/:

container# apt install lzop
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following additional packages will be installed:
   liblzo2-2
The following NEW packages will be installed:
   liblzo2-2 lzop
0 upgraded, 2 newly installed, 0 to remove and 0 not upgraded.
Need to get 88.5 kB of archives.
After this operation, 282 kB of additional disk space will be used.
E: You don't have enough free space in /var/cache/apt/archives/.


So let's try to write 1 GB to /var/cache/apt/archives/:

container# dd if=/dev/urandom of=/var/cache/apt/archives/bigfile.img 
bs=1M count=1024
sync
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 7.66032 s, 140 MB/s

container# sync
container# rm /var/cache/apt/archives/bigfile.img


This IMO is a filesystem bug?


Some more info:

# btrfs fi df /data
Data, single: total=580.01GiB, used=569.78GiB
System, single: total=4.00MiB, used=80.00KiB
Metadata, single: total=2.01GiB, used=1.53GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

# btrfs fi show /data
Label: 'data'  uuid: 38fc3739-8695-49f1-bf14-946d0c0869c5
         Total devices 1 FS bytes used 571.30GiB
         devid    1 size 1000.00GiB used 582.02GiB path /dev/nvme1n1


Tomasz Chmielewski
https://lxadm.com
