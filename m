Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60F7645C61
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 15:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLGOXE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 09:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiLGOWd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 09:22:33 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8366D5916D
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 06:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670422947; x=1701958947;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CGjChc/qHGKYseniLzzVqupqt2Kl7LbOxrkCVa6kupI=;
  b=WbRXGXH4cWg1M9Nb9axFx1QaxKIZC+dAfkYFqk8VpNwqW7N3iljY0en7
   HxBs4vxn5LdEiy3A6xWjejcANkMcbLN1tb9fcq+VuUaiHmX1ZTj+c8A8M
   +u/jdIbDu1Guw2CVWXWcdTtX0ifqYgSIT/qQ4Iw/4BfxY+eloQWqAgO7I
   JHra3ySUtMLadOQvLjXCJ4+oOPI9Uuo6qKX04TEQYVYqaJqSOHonLqz+t
   Wx8RCRzX/jNgjWVklg0KUIrHNLNGI0OuDoYhmCBSMczaY1w11J3/3ukd1
   cnp18R8NQvEzM1Zcqw9TU4JeRcC2URYdw5gePW8aExLwe+sTanV7ET8Js
   g==;
X-IronPort-AV: E=Sophos;i="5.96,225,1665417600"; 
   d="scan'208";a="218099473"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2022 22:22:27 +0800
IronPort-SDR: hDN7pqOr7eD/MPulxCRC5b6w6hMK2FGCPKu8jB8mYesQKj0lghdkisGGyjU4/SZl9hGZpFnmnb
 9iBX06rLJ+S4shmz28Wqr2+vazNr/S1wHMjOjf5QSJxZilEjIz1Cuhk+6iXTHW2n60MyRFFsc6
 rQ9UMzKWL+UsL6TU2QcoSQkB53QVmPD/bw05VqiUyDOCA132L2qtkulGq52nDsqIMWn/qO56Rw
 ybdtLNypSY5MvMKtKbRfgE2ZZ6vOn42HYr9asvlaBt5ekC2a04p6iC/gfzmfHmB2HZ3hIYNJTK
 M7U=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2022 05:35:13 -0800
IronPort-SDR: /DSLC+1v3FLG6c5UINGnHxIm3FujSasxAjlgu+tMfItZN+HH9+s1RqudPwQEGaIZ/W8tnVhxVB
 1mJ0y5VJsbinHxr5moTL5UgZjrSpBrGq5xcuoyeNCmpjDjcHXg9H0z+h3luqYDC1VPeos0Ogdx
 3pmLpgia6QI4fbzOybykQLT0cDgZoSRnWyO4hm+2xIGpCZN+uhQkeHFVdUmHG7FEQOo/MBktLL
 b53pbyLvcfkUn9lDR4M+R6BaYqVtwkbdtkTICykwQMHhv19vm2PPzDPowaDZixZsaFZyfDq/gP
 qLI=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Dec 2022 06:22:26 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH v4 0/9] btrfs: introduce RAID stripe tree
Date:   Wed,  7 Dec 2022 06:22:09 -0800
Message-Id: <cover.1670422590.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Updates of the raid-stripe-tree are done at delayed-ref time to safe on
bandwidth while for reading we do the stripe-tree lookup on bio mapping time,
i.e. when the logical to physical translation happens for regular btrfs RAID
as well.

The stripe tree is keyed by an extent's disk_bytenr and disk_num_bytes and
it's contents are the respective physical device id and position.

For an example 1M write (split into 126K segments due to zone-append)
rapido2:/home/johannes/src/fstests# xfs_io -fdc "pwrite -b 1M 0 1M" -c fsync /mnt/test/test
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 0.0065 sec (151.538 MiB/sec and 151.5381 ops/sec)

The tree will look as follows:

rapido2:/home/johannes/src/fstests# btrfs inspect-internal dump-tree -t raid_stripe /dev/nullb0
btrfs-progs v5.16.1 
raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
leaf 805847040 items 9 free space 15770 generation 9 owner RAID_STRIPE_TREE
leaf 805847040 flags 0x1(WRITTEN) backref revision 1
checksum stored 1b22e13800000000000000000000000000000000000000000000000000000000
checksum calced 1b22e13800000000000000000000000000000000000000000000000000000000
fs uuid e4f523d1-89a1-41f9-ab75-6ba3c42a28fb
chunk uuid 6f2d8aaa-d348-4bf2-9b5e-141a37ba4c77
        item 0 key (939524096 RAID_STRIPE_KEY 126976) itemoff 16251 itemsize 32
                        stripe 0 devid 1 offset 939524096
                        stripe 1 devid 2 offset 536870912
        item 1 key (939651072 RAID_STRIPE_KEY 126976) itemoff 16219 itemsize 32
                        stripe 0 devid 1 offset 939651072
                        stripe 1 devid 2 offset 536997888
        item 2 key (939778048 RAID_STRIPE_KEY 126976) itemoff 16187 itemsize 32
                        stripe 0 devid 1 offset 939778048
                        stripe 1 devid 2 offset 537124864
        item 3 key (939905024 RAID_STRIPE_KEY 126976) itemoff 16155 itemsize 32
                        stripe 0 devid 1 offset 939905024
                        stripe 1 devid 2 offset 537251840
        item 4 key (940032000 RAID_STRIPE_KEY 126976) itemoff 16123 itemsize 32
                        stripe 0 devid 1 offset 940032000
                        stripe 1 devid 2 offset 537378816
        item 5 key (940158976 RAID_STRIPE_KEY 126976) itemoff 16091 itemsize 32
                        stripe 0 devid 1 offset 940158976
                        stripe 1 devid 2 offset 537505792
        item 6 key (940285952 RAID_STRIPE_KEY 126976) itemoff 16059 itemsize 32
                        stripe 0 devid 1 offset 940285952
                        stripe 1 devid 2 offset 537632768
        item 7 key (940412928 RAID_STRIPE_KEY 126976) itemoff 16027 itemsize 32
                        stripe 0 devid 1 offset 940412928
                        stripe 1 devid 2 offset 537759744
        item 8 key (940539904 RAID_STRIPE_KEY 32768) itemoff 15995 itemsize 32
                        stripe 0 devid 1 offset 940539904
                        stripe 1 devid 2 offset 537886720
total bytes 26843545600
bytes used 1245184
uuid e4f523d1-89a1-41f9-ab75-6ba3c42a28fb

A design document can be found here:
https://docs.google.com/document/d/1Iui_jMidCd4MVBNSSLXRfO7p5KmvnoQL/edit?usp=sharing&ouid=103609947580185458266&rtpof=true&sd=true


Changes to v3:
- Rebased onto 20221120124734.18634-1-hch@lst.de
- Incorporated Josef's review
- Merged related patches

v3 of the patchset can be found here:
https://lore/kernel.org/linux-btrfs/cover.1666007330.git.johannes.thumshirn@wdc.com

Changes to v2:
- Bug fixes
- Rebased onto 20220901074216.1849941-1-hch@lst.de
- Added tracepoints
- Added leak checker
- Added RAID0 and RAID10

v2 of the patchset can be found here:
https://lore.kernel.org/linux-btrfs/cover.1656513330.git.johannes.thumshirn@wdc.com

Changes to v1:
- Write the stripe-tree at delayed-ref time (Qu)
- Add a different write path for preallocation

v1 of the patchset can be found here:
https://lore.kernel.org/linux-btrfs/cover.1652711187.git.johannes.thumshirn@wdc.com/

Johannes Thumshirn (9):
  btrfs: add raid stripe tree definitions
  btrfs: read raid-stripe-tree from disk
  btrfs: add support for inserting raid stripe extents
  btrfs: delete stripe extent on extent deletion
  btrfs: lookup physical address from stripe extent
  btrfs: add raid stripe tree pretty printer
  btrfs: zoned: allow zoned RAID
  btrfs: check for leaks of ordered stripes on umount
  btrfs: add tracepoints for ordered stripes

 fs/btrfs/Makefile               |   3 +-
 fs/btrfs/accessors.h            |  29 +++
 fs/btrfs/bio.c                  |  30 ++-
 fs/btrfs/bio.h                  |   2 +
 fs/btrfs/block-rsv.c            |   1 +
 fs/btrfs/delayed-ref.c          |   5 +-
 fs/btrfs/disk-io.c              |  24 ++
 fs/btrfs/disk-io.h              |   5 +
 fs/btrfs/extent-tree.c          |  57 +++++
 fs/btrfs/fs.h                   |   7 +-
 fs/btrfs/inode.c                |   6 +
 fs/btrfs/print-tree.c           |  21 ++
 fs/btrfs/raid-stripe-tree.c     | 402 ++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h     |  81 +++++++
 fs/btrfs/super.c                |   1 +
 fs/btrfs/volumes.c              |  38 ++-
 fs/btrfs/volumes.h              |  12 +-
 fs/btrfs/zoned.c                |  43 ++++
 include/trace/events/btrfs.h    |  50 ++++
 include/uapi/linux/btrfs.h      |   1 +
 include/uapi/linux/btrfs_tree.h |  20 +-
 21 files changed, 818 insertions(+), 20 deletions(-)
 create mode 100644 fs/btrfs/raid-stripe-tree.c
 create mode 100644 fs/btrfs/raid-stripe-tree.h

-- 
2.38.1

