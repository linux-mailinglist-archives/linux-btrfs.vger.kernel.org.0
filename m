Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F31E600E41
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 13:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiJQLzk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 07:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiJQLzj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 07:55:39 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5004E420
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 04:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666007736; x=1697543736;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mHAxvqY01vyOGPlLar7Ynfgaap1sJXdGENTu58LxvzQ=;
  b=hWKD552W/EIe8XjhORUqPnh7oyO9fLom/aBevcZ0c5EzKLpSJTllJvxH
   GSXfn+hPVhNfqPdmBGXXwR54h0eiGtt7W12xsFFFgB6N1XDIR9scPQ7Dk
   Q99SrUzk3+dPt3BMz/4cHfISOHrZXHqDFvEK5Fkm8a84O6bk/qcCUEYa0
   sV3BW/GI56egGLO5y80neO47DXaRCwSPdBkTEjDhjcIW8Ms9hnkiaL4++
   lD889Ntqhso76bQePgh/BeFgG00l0J9JnB/NEeRSVu86iq6bC+JtTaxnA
   J77YknRVfkny3RtqtE4EgYXk+4MoQb8CAsDaxsjj4UMYwObMOoXvTAH4z
   w==;
X-IronPort-AV: E=Sophos;i="5.95,191,1661788800"; 
   d="scan'208";a="212337153"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 19:55:35 +0800
IronPort-SDR: 5qbNo28ycaUXWQvH6Ob1T+rD6GO6NzYei0nRKVOj96HKkHz59yeF6FNMSyOBLjwE3b7stY+OIg
 33TNqHVoezddglXh+GaprtimnhENWeOMYqjHDAYF0+M6gYod2NbB+meJUPnPYJHhRR5cezJr2+
 zvizXwwsqk91Lgh3eoZUU1F3wzkp8u5/ad+Dg/sC8GLzyAy1JiUDx9zEStwVXRj/Aj8hzrz4ON
 Kt3bGWTc247tJYp/QrVw4zGC9Z8WRrno/RDByX3kCucjvA/afFOWBZqAsZ3MTUsnkgUjotFuTV
 vjW/PWg2OgK11YpAW5SUyWJp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2022 04:15:08 -0700
IronPort-SDR: VN2A8SG1v3mGTlVngu1qPyAoxEoU1hdisJqbLFzeztHPaAMnhnGZzCJM6MPYtybWbswokRCgXz
 F0+JOfnJmYtALnWqPlhiX27F/FUvM/HSzn9b61U7hSvZtx1sdFqQBolGjOJITMZ4WSQ8xwxQDP
 FuTs6DpE7PGbw/H02g8AmKN+yfyeJbReSpG0Fp1vrH8Al8iPejzsZjQDT5NyG1Ilw0QDBK+8c6
 jiUHrTIXiEHt7YMyEJ7XBGRDKEvr/bRtllwDE+eXpX2JUcrPzYfrYPFGe3bUs/7FKhWpn44P72
 EeU=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Oct 2022 04:55:35 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC v3 00/11] btrfs: raid-stripe-tree draft patches
Date:   Mon, 17 Oct 2022 04:55:18 -0700
Message-Id: <cover.1666007330.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.37.3
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

Here's a yet another draft of my btrfs zoned RAID patches. It's based on
Christoph's bio splitting series for btrfs.

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

Johannes Thumshirn (11):
  btrfs: add raid stripe tree definitions
  btrfs: read raid-stripe-tree from disk
  btrfs: add support for inserting raid stripe extents
  btrfs: delete stripe extent on extent deletion
  btrfs: lookup physical address from stripe extent
  btrfs: add raid stripe tree pretty printer
  btrfs: zoned: allow zoned RAID1
  btrfs: allow zoned RAID0 and 10
  btrfs: fix striping with RST
  btrfs: check for leaks of ordered stripes on umount
  btrfs: add tracepoints for ordered stripes

 fs/btrfs/Makefile               |   2 +-
 fs/btrfs/block-rsv.c            |   1 +
 fs/btrfs/ctree.h                |  33 +++
 fs/btrfs/disk-io.c              |  17 ++
 fs/btrfs/extent-tree.c          |  56 +++++
 fs/btrfs/inode.c                |   6 +
 fs/btrfs/print-tree.c           |  21 ++
 fs/btrfs/raid-stripe-tree.c     | 394 ++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h     |  60 +++++
 fs/btrfs/super.c                |   1 +
 fs/btrfs/volumes.c              |  66 +++++-
 fs/btrfs/volumes.h              |  14 +-
 fs/btrfs/zoned.c                |  43 ++++
 include/trace/events/btrfs.h    |  50 ++++
 include/uapi/linux/btrfs.h      |   1 +
 include/uapi/linux/btrfs_tree.h |  20 +-
 16 files changed, 768 insertions(+), 17 deletions(-)
 create mode 100644 fs/btrfs/raid-stripe-tree.c
 create mode 100644 fs/btrfs/raid-stripe-tree.h

-- 
2.37.3

