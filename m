Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90963697E69
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 15:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjBOOdx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 09:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBOOdw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 09:33:52 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882E824495
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676471620; x=1708007620;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HA0JmQ1XZdQ7dMCuu+VwSBn0w8haJH2p2L9En865nic=;
  b=UdJpATZMU3zej7yQfhFXr9VGCTWp3JxE3qCQpj/itkfKcDFZ5eanvMFO
   0YlxdpHf35o8s56WAxw6Stbha580Hyo6NrxIWQTUNa51fRDPhFsYaqTeV
   +vz46zt+G/gyRobFL0hccu4EZTbD/6c5LFHex/AoEsLrl0rMn9tkXmZga
   joRUcQWwJNRnaWfzOtypaaNoOyByV+xdHuU+7uGbuRSLRmfaPaR09sSv+
   2vE0UH3j2WYtI3wgMTaxcn/lfknvuk4VT/IGBAHKimvzZaQACGvmCB3TQ
   MFZWKbATo32pllESIm0qdcwdQ+ykCFkPrix9n2RkJKIHLCSJD/iGZzor8
   w==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="223394062"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 22:33:39 +0800
IronPort-SDR: KDbbUugj3BJYFZaYyFMiA8oju//NzgQ70UPh7s3U9PQEU7kkEy8RiWU3M+iuektqBL83ZMT9lb
 NBfIv2fkHD3QxWMgo0rbzrBM0gAy756wFmCe6+JOD5CtqpsjUbVxqov7uzYzTOU7x1kGDkAdiw
 S79OTE2IJm9RhSc9cHEFL+3IMairtIOy/n8zA/ZpbnzogMk1nlWhskBa5CzZNsCQMk+0GMVsX8
 50w9cfzsLzRhWstkTscUsqnECDlAAWJtaf+FzdxeEhlDWL7tNuVT+IEYrzFmvlN1Vv+8A3eEhc
 ZpQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 05:45:01 -0800
IronPort-SDR: v4Ps+Qgee286O2wujLYw+6V7Tg7it5nlVboqJgsh88QPkoMmxhDUO1TrC+44FxxvXSNtZ1rhwi
 +LfpWp4DZDXAJ2kd2EMpL/X12UsMF9dPtBUqf0NwhGT6iAdmVmH34YSqnuZ52PcmbGOevzNgZQ
 SrHswgIN4Nn1sgA65wfUlsSEm8N91cB1/Mnq7/JmCKYlL0YU19rRpKwAgv79uwfnZNLkn5KGNX
 lEa11pUkhSwVIgVPv+DUsIwWKiwr0UDI8Ntxj9/IS/N6/rB12OefFFBB/2UcTxNuL2+yQLZbuv
 ACU=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Feb 2023 06:33:40 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 00/13] btrfs: introduce RAID stripe tree
Date:   Wed, 15 Feb 2023 06:33:21 -0800
Message-Id: <cover.1676470614.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
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
 fs/btrfs/volumes.c              |  39 ++-
 fs/btrfs/volumes.h              |  12 +-
 fs/btrfs/zoned.c                |  48 +++-
 include/trace/events/btrfs.h    |  50 ++++
 include/uapi/linux/btrfs.h      |   1 +
 include/uapi/linux/btrfs_tree.h |  20 +-
 23 files changed, 897 insertions(+), 29 deletions(-)
 create mode 100644 fs/btrfs/raid-stripe-tree.c
 create mode 100644 fs/btrfs/raid-stripe-tree.h

-- 
2.39.0

