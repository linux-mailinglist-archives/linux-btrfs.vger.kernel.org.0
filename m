Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED16638832
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2019 12:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfFGKsq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jun 2019 06:48:46 -0400
Received: from mout02.posteo.de ([185.67.36.66]:42917 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbfFGKsq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Jun 2019 06:48:46 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jun 2019 06:48:45 EDT
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 00D402400E5
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2019 12:40:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1559904023; bh=PyxjFoiHennUxeH9hhqI478lOj8OTQUfkiyC0yrO584=;
        h=From:To:Subject:Date:From;
        b=KmFanV3/L5cPQINTsUaKcg6lsm0oVvmRgJlbGh1fATCUIEB3M6NDnjKCYXNDH806B
         1U+s3aQ67JsZyHoJIwP1Y0LHJkzCu83mqp8kO9GwPz60x2Mj8E26VqvrEgz18nRS6W
         DBui9EYZAAv4zNJM/c23ohTrEfwAaQoPP1kWtktz1pCfbgWiUkNxSujYAJR5nJJe98
         G/NEzcNDoXwpNy1SKJPfjEDja42HK61uFuTM4ZA3745oFsmivwp8dfMPBJxyfHYWPK
         RSpZzHstCfLDTeg3JysRRnra+I1kxXd00ZPRWJuA3yX0ec4Ef0KS82YKXI/3gU3eTh
         xDKntO6pz+LOw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 45KzZG1wyXz9rxN
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2019 12:40:22 +0200 (CEST)
From:   "marcos k." <Marcos.Ka@posteo.net>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs progs v5.1: tree block bytenr 0 is not aligned to sectorsize 4096
Date:   Fri, 07 Jun 2019 12:40:21 +0200
Message-ID: <3057842.IWvHFmXsFP@ernsv0>
Organization: Ernesto
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hallo to all of you,
and sorry for asking the very specialists directly, 
but I found no useful answer to my problem.

my btrfs-filesystem is corrupt and can not be mounted==>
btrfsprogs v5.1 and btrfsprogs v4.15.1
# btrfs check /dev/dm-2
ERROR: tree block bytenr 0 is not aligned to sectorsize 4096

BUT btrfsprogs v4.4 can at least check the filesystem and I have (limited)
access to it. Still can not mount ...

I would appreciate it very much, if someone could give me a hint,
marcos k.

======= output ============= output =============
lap13:~ # uname -a 
Linux ernnb113 5.1.5-1-default #1 SMP Mon May 27 07:14:33 UTC 2019 (6ad4f79) x86_64 x86_64 x86_64 GNU/Linux

lap13:~ # btrfs --version 
btrfs-progs v5.1 

lap13:~ # btrfs fi show 
Label: 'rootfs'  uuid: 0fe9bec5-fd4e-4a4b-a855-b0412d9916a4
        Total devices 1 FS bytes used 134.48GiB
        devid    1 size 310.13GiB used 143.06GiB path /dev/mapper/linuxvg-rootlv

Label: 'homefs'  uuid: d3659317-3d28-42f0-beb3-2480fb2b0900
        Total devices 1 FS bytes used 406.77GiB
        devid    1 size 590.00GiB used 577.00GiB path /dev/mapper/linuxvg-homelv

lap13:~ # btrfs fi df /dev/dm-2 
ERROR: not a btrfs filesystem: /dev/dm-2

lap13:~ # dmesg | grep -i btrfs
[    7.485437] Btrfs loaded, crc32c=crc32c-intel, assert=on
[    7.487711] BTRFS: device label rootfs devid 1 transid 3190209 /dev/dm-1
[    7.616145] BTRFS info (device dm-1): disk space caching is enabled
[    7.616148] BTRFS info (device dm-1): has skinny extents
[    7.662371] BTRFS info (device dm-1): enabling ssd optimizations
[    8.263761] BTRFS info (device dm-1): turning on discard
[    8.263763] BTRFS info (device dm-1): disk space caching is enabled
[    8.998829] BTRFS info (device dm-1): device fsid 0fe9bec5-fd4e-4a4b-a855-b0412d9916a4 devid 1 moved old:/dev/mapper/linuxvg-rootlv new:/dev/dm-1
[    8.999507] BTRFS info (device dm-1): device fsid 0fe9bec5-fd4e-4a4b-a855-b0412d9916a4 devid 1 moved old:/dev/dm-1 new:/dev/mapper/linuxvg-rootlv
[   10.484594] BTRFS: device label homefs devid 1 transid 2087298 /dev/dm-2
[   10.520725] BTRFS info (device dm-2): turning on discard
[   10.520728] BTRFS info (device dm-2): disk space caching is enabled
[   10.520730] BTRFS info (device dm-2): has skinny extents
[   10.522139] BTRFS critical (device dm-2): corrupt node: root=3 block=16384 slot=0, invalid NULL node pointer
[   10.523238] BTRFS error (device dm-2): failed to read chunk root
[   10.545271] BTRFS error (device dm-2): open_ctree failed

lap13:~ # btrfs check /dev/dm-2
ERROR: tree block bytenr 0 is not aligned to sectorsize 4096
Couldn't read chunk tree
ERROR: cannot open file system
Opening filesystem to check...

lap13:~ # btrfs rescue super-recover /dev/dm-2
All supers are valid, no need to recover

lap13 :~ # btrfs rescue chunk-recovery /dev/dm-2
Scanning: DONE in dev0
Check chunks successfully with no orphans
Chunk tree recovered successfully

lap13:~ # btrfs check /dev/dm-2
ERROR: tree block bytenr 0 is not aligned to sectorsize 4096
Couldn't read chunk tree
ERROR: cannot open file system
Opening filesystem to check...



