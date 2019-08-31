Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44FB5A45CA
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Aug 2019 20:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfHaShG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Aug 2019 14:37:06 -0400
Received: from augustus.math.duke.edu ([152.3.25.8]:45152 "EHLO math.duke.edu"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728510AbfHaShG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Aug 2019 14:37:06 -0400
X-Greylist: delayed 1031 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Aug 2019 14:37:06 EDT
X-Virus-Scanned: amavisd-new at math.duke.edu
Received: from [192.168.101.7] (cpe-76-182-105-20.nc.res.rr.com [76.182.105.20])
        (authenticated bits=0)
        by math.duke.edu (8.14.4/8.14.4) with ESMTP id x7VIJsDx027312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Aug 2019 14:19:54 -0400
Message-ID: <bdd368bc2e910523525c54844c5c47dd877f1a0d.camel@math.duke.edu>
Subject: block corruption
From:   Rann Bar-On <rann@math.duke.edu>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Date:   Sat, 31 Aug 2019 14:19:53 -0400
Organization: Duke University Mathematics Department
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I have a btrfs filesystem with a corrupt block. After finding errors
such as 

BTRFS critical (device nvme0n1p6): corrupt leaf: root=5
block=154977681408 slot=19 ino=8708079, invalid mode: has 00 expect
valid S_IF* bit(s)

spamming my dmesg, I examined the block with 

btrfs-debug-tree -b 154977681408 /dev/nvme0n1p6

I found the source of the error in this line:

item 19 key (8708079 INODE_ITEM 0) itemoff 14769 itemsize 160   inode 
generation 292430 transid 292449 size 0 block group 0 mode 0 links 1
uid 0 gid 0 rdev 0 flags 0x0

I then ran 

find <mount point> -type f -exec cp {} /dev/null \;

to look for corrupt files. Almost all files that appeared in the list
also appeared in the btrfs-debug-tree command above.

I conclude that this block is corrupt.

Two questions:

1. Given that none of the files in the list are critical, I'd like to
remove the block, or at least the files. Is this possible? How?

2. Is this an indicator of a problem with the drive? smartctl does not
give errors, nor does scrubbing the file system.

More info below:

# uname -a
Linux debian-x1yoga 5.2.0-2-amd64 #1 SMP Debian 5.2.9-2 (2019-08-21)
x86_64 GNU/Linux

#   btrfs --version
Btrfs v3.17

#   btrfs fi show
Label: none  uuid: 91624ec9-49ef-469e-a949-7699dc681c52
        Total devices 1 FS bytes used 13.27GiB
        devid    1 size 19.26GiB used 16.03GiB path /dev/nvme0n1p2

Label: none  uuid: 4133c951-4327-4040-83ed-9e8a71270cc2
        Total devices 1 FS bytes used 6.85GiB
        devid    1 size 9.93GiB used 9.51GiB path /dev/nvme0n1p3

Label: none  uuid: be5b72e2-5cd1-498e-b38c-d83b10548ef3
        Total devices 1 FS bytes used 174.09GiB
        devid    1 size 182.99GiB used 182.99GiB path /dev/nvme0n1p6

Label: none  uuid: bbba344c-b256-4509-ac49-4b69b1a73607
        Total devices 1 FS bytes used 1.93MiB
        devid    1 size 381.00MiB used 381.00MiB path /dev/nvme0n1p5

Btrfs v3.17

# btrfs fi df /home
Data, single: total=180.98GiB, used=173.41GiB
System, single: total=4.00MiB, used=48.00KiB
Metadata, single: total=2.01GiB, used=698.38MiB
GlobalReserve, single: total=512.00MiB, used=0.00B

The only error in dmesg is the one referred to above.

I appreciate any help! 

Cheers,
Rann

