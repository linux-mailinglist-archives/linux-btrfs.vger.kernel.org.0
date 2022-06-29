Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64770560365
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jun 2022 16:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiF2OlX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jun 2022 10:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiF2OlW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jun 2022 10:41:22 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05FF393D3
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 07:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656513681; x=1688049681;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B5Apv68gAsDDkcyHRujIX9imHJnFyJ0lC76h0PUCfTg=;
  b=kO9LbWBED/aG7l4GO5VVjTzMfif3aKblSJNFA+BFrODKVNXjWKTApGIa
   srx7rSSBxRNkzZIuYagaBWEhUKc/5o65H3TUyauID9Kz9Q50gQCol3Dr9
   1Uxm8ZSJ1FT6eD5CzcUad8wd5dL1JhstMU2pOHZvS2Wy4v3mb6A0H8f2Q
   xenZmEJ4CpZNGt9vXe3tzrrZu5OpWhMG/+aaaXKY0naZLqyXhQwL/AlVK
   AVw60IFQnZ+75rSPL9pbKibfsUUdo5a6J/9D2mT3WtE2iabp1GiHPUiCM
   sFM/O9GW/GL8oFUqn/0e5BqLd/2Q9rJKd4psmPbqkRCP7jws2tA/0+Ovt
   g==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650902400"; 
   d="scan'208";a="203064879"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 22:41:20 +0800
IronPort-SDR: pJ/DKL5b5JPQiFEI21Cnqx0ud27GA9VjFfHySHdtbyn7vzGpJyp9QyWCQa5+pRU5eTo2F7GBah
 1TThFkS0Q+dPYof6fwS+IUonDX4rlAXs0OCqzCmi2RyQTkvWxUSakAG1RnpX9tghYdWPeOCC51
 ZFoMoKLbku2h9Hf391d0mjnP5hESOx2wM72aAZgWBtsiCvD7Cn0+lyVwSUJ/zs9sN7gcQ1E2VQ
 DhEByRaWo15XH7ud0gt1EcEKbsegoT5gKZYvBe+XvVmiNU4lCJ3ZoWfaTvVm2s4PHoe7LWDTP+
 u8OektVOPgNsFmECNV1eQXai
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 06:58:59 -0700
IronPort-SDR: gPPenga/BEYUsPVVCkXkRscM2HPOiC2ri+XC+1KQqNWuEnswTMzfCTdb8mvbItrHo8oIOzgT8B
 N1kyQoP31mnbZTKjDDB4PurUJB/01Yg2Sw7Y0YkXO13qkW/dkrHzFM+wBn0Z60iwUPWIy4dZMq
 U5rbh7XKb7sCViQalvAU1NQgXs3sEmHYbwYmSbU8kO8NnO/I5UOYX2FPQwOqs0Wk+B9YC+cFQa
 c0ha1Er+fr8wUY7igggjoWRKhnnsdmu8MmdbI/28ebXz74xI26STZqyAqYj0lE4+zZJlzuzAOo
 w7k=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Jun 2022 07:41:20 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC v2 0/8] btrfs: raid-stripe-tree draft patches
Date:   Wed, 29 Jun 2022 07:41:06 -0700
Message-Id: <cover.1656513330.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here's a second draft of my btrfs zoned RAID1 patches.

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

The performance deviation is meassurable but overall not too bad for a first shot:

RAID1:
READ: bw=81.6MiB/s (85.6MB/s), 81.6MiB/s-81.6MiB/s (85.6MB/s-85.6MB/s), io=496MiB (520MB), run=6075-6075msec
WRITE: bw=86.9MiB/s (91.1MB/s), 86.9MiB/s-86.9MiB/s (91.1MB/s-91.1MB/s), io=528MiB (554MB), run=6075-6075msec

Single:
READ: bw=92.5MiB/s (97.0MB/s), 92.5MiB/s-92.5MiB/s (97.0MB/s-97.0MB/s), io=496MiB (520MB), run=5360-5360msec
WRITE: bw=98.5MiB/s (103MB/s), 98.5MiB/s-98.5MiB/s (103MB/s-103MB/s), io=528MiB (554MB), run=5360-5360msec

Changes to v1:
- Write the stripe-tree at delayed-ref time (Qu)
- Add a different write path for preallocation

v1 of the patchset can be found here:
https://lore.kernel.org/linux-btrfs/cover.1652711187.git.johannes.thumshirn@wdc.com/

Johannes Thumshirn (8):
  btrfs: add raid stripe tree definitions
  btrfs: read raid-stripe-tree from disk
  btrfs: add boilerplate code to insert raid extent
  btrfs: add boilerplate code to insert stripe entries for preallocated
    extents
  btrfs: add code to delete raid extent
  btrfs: add code to read raid extent
  btrfs: zoned: allow zoned RAID1
  btrfs: add raid stripe tree pretty printer

 fs/btrfs/Makefile               |   2 +-
 fs/btrfs/block-rsv.c            |   1 +
 fs/btrfs/ctree.h                |  33 ++++
 fs/btrfs/disk-io.c              |  15 ++
 fs/btrfs/extent-tree.c          |  53 ++++++
 fs/btrfs/inode.c                |   6 +
 fs/btrfs/print-tree.c           |  21 +++
 fs/btrfs/raid-stripe-tree.c     | 318 ++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h     |  72 ++++++++
 fs/btrfs/volumes.c              |  35 +++-
 fs/btrfs/volumes.h              |   4 +
 fs/btrfs/zoned.c                |  39 ++++
 include/uapi/linux/btrfs.h      |   1 +
 include/uapi/linux/btrfs_tree.h |  17 ++
 14 files changed, 614 insertions(+), 3 deletions(-)
 create mode 100644 fs/btrfs/raid-stripe-tree.c
 create mode 100644 fs/btrfs/raid-stripe-tree.h

-- 
2.35.3

