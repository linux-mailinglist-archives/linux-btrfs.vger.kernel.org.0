Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD4CBDF18
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 15:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406449AbfIYNhn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 09:37:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:35620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406256AbfIYNhn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 09:37:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 223B7B038;
        Wed, 25 Sep 2019 13:37:42 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v5 0/7] btrfs-progs: support xxhash64 checksums
Date:   Wed, 25 Sep 2019 15:37:21 +0200
Message-Id: <20190925133728.18027-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that Nikolay's XXHASH64 support for the Crypto API has landed and BTRFS is
prepared for an easy addition of new checksums, this patchset implements
XXHASH64 as a second, fast but not cryptographically secure checksum hash.

This patchset is fully bisectible and available on github at
https://github.com/morbidrsa/btrfs-progs/tree/mkfs-xxhash64.v5

Changes since v4:
- Rebased onto latest 'devel' branch and dropped applied changes
- Split 'btrfs-progs: add xxhash64 as checksum algorithm' into several atomic
  patches
- Changed test code to using 'TEST_ENABLE_OVERRIDE'

Johannes Thumshirn (7):
  btrfs-progs: add option for checksum type to mkfs
  btrfs-progs: add is_valid_csum_type() helper
  btrfs-progs: add table for checksum type and name
  btrfs-progs: also print checksum type when running mkfs
  btrfs-progs: add xxhash64 to mkfs
  btrfs-progs: move crc32c implementation to crypto/
  btrfs-progs: add test override for mkfs to use different checksums

 Android.mk                                  |  4 ++--
 Makefile                                    |  7 ++++---
 btrfs-crc.c                                 |  2 +-
 btrfs-find-root.c                           |  2 +-
 btrfs-sb-mod.c                              |  2 +-
 btrfs.c                                     |  2 +-
 cmds/inspect-dump-super.c                   | 26 ++++++++++++++++----------
 cmds/rescue-chunk-recover.c                 |  2 +-
 cmds/rescue-super-recover.c                 |  2 +-
 common/utils.c                              |  2 +-
 convert/common.c                            |  2 +-
 convert/main.c                              |  6 +++---
 {kernel-lib => crypto}/crc32c.c             |  2 +-
 {kernel-lib => crypto}/crc32c.h             |  0
 crypto/hash.c                               | 17 +++++++++++++++++
 crypto/hash.h                               | 10 ++++++++++
 ctree.c                                     | 28 ++++++++++++++++++++++++++++
 ctree.h                                     | 18 +++++++-----------
 disk-io.c                                   |  9 ++++++---
 extent-tree.c                               |  2 +-
 file-item.c                                 |  2 +-
 free-space-cache.c                          |  2 +-
 hash.h                                      |  2 +-
 image/main.c                                |  7 ++++---
 image/sanitize.c                            |  2 +-
 library-test.c                              |  2 +-
 mkfs/common.c                               | 14 +++++++-------
 mkfs/main.c                                 | 10 ++++++++--
 send-stream.c                               |  2 +-
 tests/common                                | 10 ++++++++--
 tests/mkfs-tests/001-basic-profiles/test.sh |  8 +++++++-
 31 files changed, 143 insertions(+), 63 deletions(-)
 rename {kernel-lib => crypto}/crc32c.c (99%)
 rename {kernel-lib => crypto}/crc32c.h (100%)
 create mode 100644 crypto/hash.c
 create mode 100644 crypto/hash.h

-- 
2.16.4

