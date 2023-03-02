Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7536A7E58
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 10:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCBJp4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 04:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjCBJpy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 04:45:54 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54AA39CEC
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 01:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677750339; x=1709286339;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kfK4865ErD0LzBrq6GGJgDzoS0atDgG0ZnQUZX3HTgw=;
  b=ch7vKbeuQ9SHKDX1cOmwrUQ021kBzebcyBpZJFG6re5N+fxg6peoBrsL
   NFYn/SfyqInWm5MiFPhyBSFpqVfwVnJ671ryTdZPOEcWlAOTJeUmvkG06
   YvQao0nZZZNOVaAkmoslfnQmAwfP1ptUoNOJakSjZRhHE9KhFyjlH+FHV
   Qenp5dl/WipItr6CiK0x46Ph6/UXLEKh0eb8suWwaDAMK7PC+5Ttys0gz
   9JRak0tgGWQ+aUf+TyY9duD6MFPbHXIfSOhHVYZmT/qdDva/TqAT1sPdC
   sekkNHWkV+mpOKyDsIezhwSdt41lnVHHqDzTCv8rWGHO8c5AZjaxzlVF8
   w==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="328939162"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 17:45:38 +0800
IronPort-SDR: ebyB7houRz4tthhgImpxBGY2EyVb9Iu4vPTMObmLekxjv/e8NqV4YgU6Uf9wF1ACz+ig+ier6D
 mFFex8kCZEzakj8eUaoq6aEy64WcO5faNXaUpqLftrEkNmfWubwN6jC2aRJBpJyYpc87wIQXLI
 kKiJJD8Yrd4BYiZvVU7C76JSriBC+YH9vpu03tRvtOHey+6I4ewiBIEVKBy/yzeHcJaFyfyEWp
 jQDqv2XJFcD/bWAI7wU7vuQ8IwtAEKtm2Z3h6x0NtHq3f1Ok/pqKHpBm5f3k68kWf7E2w33wFK
 9YI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2023 00:56:42 -0800
IronPort-SDR: DDwf7/qh4L4HGHGNNc9gwro4okAwo/2E/atyYFCQFBqRad+bRVG4X/lm1PloRdgqMqRY8Y6lrY
 0Mevk9bj4HaREQXbR+hVIkgXDRJ2mEOGUU+ZKvWRZuXeVy8CCi4T9hTYVz66Gcda/0NiZX/edc
 IYjpsxP0XLP7m7mY6Z+80l/2hSHbhfoKnH7DoJUBuQGNCRuMsrzcTtVYabCGRstQZH9ttedrVv
 lXLNPQ29eZLh5B4GS9NmZKJly/Dc7Dds9ppW89Um3hIBSZF6cEp0pJ25agR6gdtrRMQ6ecKfc4
 tJY=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Mar 2023 01:45:38 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 00/13] btrfs: introduce RAID stripe tree
Date:   Thu,  2 Mar 2023 01:45:22 -0800
Message-Id: <cover.1677750131.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.1
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

The user-space part of this series can be found here:
https://lore.kernel.org/linux-btrfs/20230215143109.2721722-1-johannes.thumshirn@wdc.com

Changes to v6:
- Fix degraded RAID1 mounts
- Fix RAID0/10 mounts

v6 of the patchset can be found here:
https://lore/kernel.org/linux-btrfs/cover.1676470614.git.johannes.thumshirn@wdc.com

Changes to v5:
- Incroporated review comments from Josef and Christoph
- Rebased onto misc-next

v5 of the patchset can be found here:
https://lore/kernel.org/linux-btrfs/cover.1675853489.git.johannes.thumshirn@wdc.com

Changes to v4:
- Added patch to check for RST feature in sysfs
- Added RST lookups for scrubbing 
- Fixed the error handling bug Josef pointed out
- Only check if we need to write out a RST once per delayed_ref head
- Added support for zoned data DUP with RST

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

Johannes Thumshirn (13):
  btrfs: re-add trans parameter to insert_delayed_ref
  btrfs: add raid stripe tree definitions
  btrfs: read raid-stripe-tree from disk
  btrfs: add support for inserting raid stripe extents
  btrfs: delete stripe extent on extent deletion
  btrfs: lookup physical address from stripe extent
  btrfs: add raid stripe tree pretty printer
  btrfs: zoned: allow zoned RAID
  btrfs: check for leaks of ordered stripes on umount
  btrfs: add tracepoints for ordered stripes
  btrfs: announce presence of raid-stripe-tree in sysfs
  btrfs: consult raid-stripe-tree when scrubbing
  btrfs: add raid-stripe-tree to features enabled with debug

 fs/btrfs/Makefile               |   2 +-
 fs/btrfs/accessors.h            |  29 +++
 fs/btrfs/bio.c                  |  29 +++
 fs/btrfs/block-rsv.c            |   1 +
 fs/btrfs/delayed-ref.c          |  13 +-
 fs/btrfs/delayed-ref.h          |   2 +
 fs/btrfs/disk-io.c              |  24 ++
 fs/btrfs/disk-io.h              |   5 +
 fs/btrfs/extent-tree.c          |  68 ++++++
 fs/btrfs/fs.h                   |   7 +-
 fs/btrfs/inode.c                |  15 +-
 fs/btrfs/print-tree.c           |  21 ++
 fs/btrfs/raid-stripe-tree.c     | 416 ++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h     |  87 +++++++
 fs/btrfs/scrub.c                |  33 ++-
 fs/btrfs/super.c                |   1 +
 fs/btrfs/sysfs.c                |   3 +
 fs/btrfs/volumes.c              |  46 +++-
 fs/btrfs/volumes.h              |  13 +-
 fs/btrfs/zoned.c                | 119 ++++++++-
 include/trace/events/btrfs.h    |  50 ++++
 include/uapi/linux/btrfs.h      |   1 +
 include/uapi/linux/btrfs_tree.h |  20 +-
 23 files changed, 973 insertions(+), 32 deletions(-)
 create mode 100644 fs/btrfs/raid-stripe-tree.c
 create mode 100644 fs/btrfs/raid-stripe-tree.h

-- 
2.39.1

