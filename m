Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96692A6C14
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 17:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbfICPAv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Sep 2019 11:00:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:57436 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727005AbfICPAt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Sep 2019 11:00:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3302AC97;
        Tue,  3 Sep 2019 15:00:47 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v4 00/12] btrfs-progs: support xxhash64 checksums
Date:   Tue,  3 Sep 2019 17:00:34 +0200
Message-Id: <20190903150046.14926-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that Nikolay's XXHASH64 support for the Crypto API has landed and BTRFS is
prepared for an easy addition of new checksums, this patchset implements
XXHASH64 as a second, fast but not cryptographically secure checksum hash.

For changes since v2, please see the individual patches. Additionally a patch
moving the CRC32C implementation from kernel-lib/ to crypto/ was added.

For changes since v1, please see the individual patches. Additionally a unit
test was added for regression testing this series.


David Sterba (3):
  btrfs-progs: update checksumming api
  btrfs-progs: add xxhash sources
  btrfs-progs: add xxhash64 as checksum algorithm

Johannes Thumshirn (9):
  btrfs-progs: don't blindly assume crc32c in csum_tree_block_size()
  btrfs-progs: cache csum_type in recover_control
  btrfs-progs: add checksum type to checksumming functions
  btrfs-progs: don't assume checksums are always 4 bytes
  btrfs-progs: pass checksum type to
    btrfs_csum_data()/btrfs_csum_final()
  btrfs-progs: simplify update_block_csum() in btrfs-sb-mod.c
  btrfs-progs: add option for checksum type to mkfs
  btrfs-progs: move crc32c implementation to crypto/
  btrfs-progs: add test-case for mkfs with xxhash64

 Android.mk                                  |    4 +-
 Makefile                                    |    7 +-
 btrfs-corrupt-block.c                       |    3 +-
 btrfs-crc.c                                 |    2 +-
 btrfs-find-root.c                           |    2 +-
 btrfs-sb-mod.c                              |   32 +-
 btrfs.c                                     |    2 +-
 check/main.c                                |   20 +-
 cmds/inspect-dump-super.c                   |   38 +-
 cmds/rescue-chunk-recover.c                 |   25 +-
 cmds/rescue-super-recover.c                 |    2 +-
 common/utils.c                              |    2 +-
 convert/common.c                            |   14 +-
 convert/main.c                              |    5 +-
 {kernel-lib => crypto}/crc32c.c             |    2 +-
 {kernel-lib => crypto}/crc32c.h             |    0
 crypto/hash.c                               |   16 +
 crypto/hash.h                               |   10 +
 crypto/xxhash.c                             | 1025 +++++++++++++++++++++++++++
 crypto/xxhash.h                             |  445 ++++++++++++
 ctree.h                                     |   18 +-
 disk-io.c                                   |   82 ++-
 disk-io.h                                   |    8 +-
 extent-tree.c                               |    2 +-
 file-item.c                                 |   13 +-
 free-space-cache.c                          |    4 +-
 hash.h                                      |    2 +-
 image/main.c                                |    9 +-
 image/sanitize.c                            |    2 +-
 library-test.c                              |    2 +-
 mkfs/common.c                               |   23 +-
 mkfs/common.h                               |    2 +
 mkfs/main.c                                 |   29 +-
 send-stream.c                               |    2 +-
 tests/mkfs-tests/001-basic-profiles/test.sh |    2 +
 35 files changed, 1710 insertions(+), 146 deletions(-)
 rename {kernel-lib => crypto}/crc32c.c (99%)
 rename {kernel-lib => crypto}/crc32c.h (100%)
 create mode 100644 crypto/hash.c
 create mode 100644 crypto/hash.h
 create mode 100644 crypto/xxhash.c
 create mode 100644 crypto/xxhash.h

-- 
2.16.4

