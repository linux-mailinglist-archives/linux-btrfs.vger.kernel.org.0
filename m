Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1885F1BB1
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Oct 2022 12:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJAKED convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 1 Oct 2022 06:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJAKEC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Oct 2022 06:04:02 -0400
X-Greylist: delayed 1803 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 01 Oct 2022 03:03:59 PDT
Received: from mail.vantomas.net (mail.vantomas.net [185.14.235.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4A9106519
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Oct 2022 03:03:59 -0700 (PDT)
X-Footer: dmFudG9tYXMubmV0
Received: from smtpclient.apple ([10.88.62.240])
        (authenticated user vantomas@vantomas.net)
        by mail.vantomas.net
        (using TLSv1/SSLv3 with cipher AES256-SHA (256 bits))
        for linux-btrfs@vger.kernel.org;
        Sat, 1 Oct 2022 11:33:51 +0200
From:   =?utf-8?B?VG9tw6HFoSBIb2zDvQ==?= <vantomas@vantomas.net>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Poor write performance with raid5 on 4 drives
Message-Id: <FB99D093-04BF-421D-8AE6-94BDA34728DB@vantomas.net>
Date:   Sat, 1 Oct 2022 11:33:51 +0200
To:     linux-btrfs@vger.kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
I’m building my personal tertiary backup box running on HP Microserver G8 with 4x 6TB hard drives and I was planning to use raid5 profile for reasonable data ratio but I ran into really poor write performance on raid5 with 4 drives. On a filesystem with -d=raid5 -m=raid1c4 on 4 drives I only get about 40MB/s of write speed, but with -d=raid5 -m=raid1c3 on 3 drives or -d=raid6 -m raid1c4 on 4 drives I get 500MB/s of write speed. 

I tried to investigate it somehow, I compared the properties of the filesystem and other variables in /sys/fs/btrfs between each other, but all I found was that raid5 on 4 drives reads from hard drives while writing data and that would be whole problem with poor performance imho. But that’s where my skills end. 

Do you know if there is a solution to this or can you point me in which direction to look?


Thanks, 
Tomas




[root@backupcube ~]# uname -a
Linux backupcube 5.19.11-200.fc36.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Sep 23 15:07:44 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
[root@backupcube ~]# btrfs --version
btrfs-progs v5.18


### -d=raid5 -m=raid1c4 on 4 drives ###

[root@backupcube ~]# mkfs.btrfs -f -d raid5 -m raid1c4 /dev/sda1 /dev/sdb1 /dev/sdd1 /dev/sde1
btrfs-progs v5.18
See http://btrfs.wiki.kernel.org for more information.

WARNING: RAID5/6 support has known problems is strongly discouraged
	 to be used besides testing or evaluation.

NOTE: several default settings have changed in version 5.15, please make sure
      this does not affect your deployments:
      - DUP for metadata (-m dup)
      - enabled no-holes (-O no-holes)
      - enabled free-space-tree (-R free-space-tree)

Label:              (null)
UUID:               279a913f-bf4a-44ba-a5cd-26c94c954365
Node size:          16384
Sector size:        4096
Filesystem size:    21.83TiB
Block group profiles:
  Data:             RAID5             3.00GiB
  Metadata:         RAID1C4           1.00GiB
  System:           RAID1C4           8.00MiB
SSD detected:       no
Zoned device:       no
Incompat features:  extref, raid56, skinny-metadata, no-holes, raid1c34
Runtime features:   free-space-tree
Checksum:           crc32c
Number of devices:  4
Devices:
   ID        SIZE  PATH
    1     5.46TiB  /dev/sda1
    2     5.46TiB  /dev/sdb1
    3     5.46TiB  /dev/sdd1
    4     5.46TiB  /dev/sde1


[root@backupcube ~]# dd if=/dev/zero of=/mnt/sda1/tempfile bs=1M count=4096 conv=fdatasync,notrunc status=progress oflag=direct
4270850048 bytes (4.3 GB, 4.0 GiB) copied, 106 s, 40.3 MB/s
4096+0 records in
4096+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 106.619 s, 40.3 MB/s


[root@backupcube ~]# dstat -d -D total,sda,sdb,sdd,sde
--dsk/sda-----dsk/sdb-----dsk/sdd-----dsk/sde----dsk/total-
 read  writ: read  writ: read  writ: read  writ: read  writ
1215k   13M:1215k   13M:1215k   13M:1215k   13M:4858k   52M
1216k   13M:1216k   13M:1216k   13M:1216k   13M:4864k   52M
1216k   13M:1216k   13M:1216k   13M:1216k   13M:4864k   52M
1280k   13M:1216k   13M:1216k   13M:1216k   13M:4928k   52M
1152k   13M:1216k   13M:1216k   13M:1216k   13M:4800k   52M
1216k   13M:1216k   13M:1216k   13M:1216k   13M:4864k   52M^C

[root@backupcube ~]#





### -d=raid6 -m=raid1c4 on 4 drives ###

[root@backupcube ~]# mkfs.btrfs -f -d raid6 -m raid1c4 /dev/sda1 /dev/sdb1 /dev/sdd1 /dev/sde1
btrfs-progs v5.18
See http://btrfs.wiki.kernel.org for more information.

WARNING: RAID5/6 support has known problems is strongly discouraged
	 to be used besides testing or evaluation.

NOTE: several default settings have changed in version 5.15, please make sure
      this does not affect your deployments:
      - DUP for metadata (-m dup)
      - enabled no-holes (-O no-holes)
      - enabled free-space-tree (-R free-space-tree)

Label:              (null)
UUID:               9e4f6691-971d-4950-a032-d3c83f2fda26
Node size:          16384
Sector size:        4096
Filesystem size:    21.83TiB
Block group profiles:
  Data:             RAID6             2.00GiB
  Metadata:         RAID1C4           1.00GiB
  System:           RAID1C4           8.00MiB
SSD detected:       no
Zoned device:       no
Incompat features:  extref, raid56, skinny-metadata, no-holes, raid1c34
Runtime features:   free-space-tree
Checksum:           crc32c
Number of devices:  4
Devices:
   ID        SIZE  PATH
    1     5.46TiB  /dev/sda1
    2     5.46TiB  /dev/sdb1
    3     5.46TiB  /dev/sdd1
    4     5.46TiB  /dev/sde1


[root@backupcube ~]# dd if=/dev/zero of=/mnt/sda1/tempfile bs=1M count=4096 conv=fdatasync,notrunc status=progress oflag=direct
4051697664 bytes (4.1 GB, 3.8 GiB) copied, 8 s, 506 MB/s
4096+0 records in
4096+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 8.58926 s, 500 MB/s

[root@backupcube ~]# dstat -d -D total,sda,sdb,sdd,sde
--dsk/sda-----dsk/sdb-----dsk/sdd-----dsk/sde----dsk/total-
 read  writ: read  writ: read  writ: read  writ: read  writ
   0   238M:   0   238M:   0   238M:   0   238M:   0   953M
   0   250M:   0   250M:   0   250M:   0   250M:   0  1001M
   0   242M:   0   242M:   0   242M:   0   242M:   0   968M
   0   238M:   0   238M:   0   238M:   0   238M:   0   953M
   0   242M:   0   242M:   0   243M:   0   242M:   0   970M
   0   243M:   0   243M:   0   243M:   0   243M:   0   972M
   0   192M:   0   192M:   0   192M:   0   192M:   0   769M
   0     0 :   0     0 :   0     0 :   0     0 :   0  6144B^C





### -d=raid5 -m=raid1c3 on 3 drives ###

[root@backupcube ~]# mkfs.btrfs -f -d raid5 -m raid1c3 /dev/sda1 /dev/sdb1 /dev/sdd1
btrfs-progs v5.18
See http://btrfs.wiki.kernel.org for more information.

WARNING: RAID5/6 support has known problems is strongly discouraged
	 to be used besides testing or evaluation.

NOTE: several default settings have changed in version 5.15, please make sure
      this does not affect your deployments:
      - DUP for metadata (-m dup)
      - enabled no-holes (-O no-holes)
      - enabled free-space-tree (-R free-space-tree)

Label:              (null)
UUID:               7f06fbb0-9655-4f8d-af4a-2d06d8dc1d80
Node size:          16384
Sector size:        4096
Filesystem size:    16.37TiB
Block group profiles:
  Data:             RAID5             2.00GiB
  Metadata:         RAID1C3           1.00GiB
  System:           RAID1C3           8.00MiB
SSD detected:       no
Zoned device:       no
Incompat features:  extref, raid56, skinny-metadata, no-holes, raid1c34
Runtime features:   free-space-tree
Checksum:           crc32c
Number of devices:  3
Devices:
   ID        SIZE  PATH
    1     5.46TiB  /dev/sda1
    2     5.46TiB  /dev/sdb1
    3     5.46TiB  /dev/sdd1

[root@backupcube ~]# dd if=/dev/zero of=/mnt/sda1/tempfile bs=1M count=4096 conv=fdatasync,notrunc status=progress oflag=direct
4034920448 bytes (4.0 GB, 3.8 GiB) copied, 8 s, 504 MB/s
4096+0 records in
4096+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 8.61927 s, 498 MB/s
[root@backupcube ~]#


[root@backupcube ~]# dstat -d -D total,sda,sdb,sdd,sde
--dsk/sda-----dsk/sdb-----dsk/sdd-----dsk/sde----dsk/total-
 read  writ: read  writ: read  writ: read  writ: read  writ
   0   231M:   0   231M:   0   231M:   0     0 :   0   694M
   0   244M:   0   244M:   0   244M:   0     0 :   0   733M
   0   250M:   0   250M:   0   250M:   0     0 :   0   751M
   0   238M:   0   238M:   0   238M:   0     0 :   0   715M
   0   239M:   0   239M:   0   239M:   0     0 :   0   718M
   0   243M:   0   243M:   0   243M:   0     0 :   0   729M
   0   243M:   0   243M:   0   243M:   0     0 :   0   728M
   0   117M:   0   117M:   0   117M:   0     0 :   0   351M
   0     0 :   0     0 :   0     0 :   0     0 :   0     0 ^C
