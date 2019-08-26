Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 282BA9CE83
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 13:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbfHZLs5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 07:48:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:39186 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727538AbfHZLs4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 07:48:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 98F93AE35
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 11:48:55 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 00/11] btrfs-progs: support xxhash64 checksums
Date:   Mon, 26 Aug 2019 13:48:42 +0200
Message-Id: <20190826114853.14860-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that Nikolay's XXHASH64 support for the Crypto API has landed and BTRFS is
prepared for an easy addition of new checksums, this patchset implements
XXHASH64 as a second, fast but not cryptographically secure checksum hash.

For changes since v1, please see the individual patches. Additionally a unit
test was added for regression testing this series.

David Sterba (3):
  btrfs-progs: update checksumming api
  btrfs-progs: add xxhash sources
  btrfs-progs: add xxhash64 as checksum algorithm

Johannes Thumshirn (8):
  btrfs-progs: don't blindly assume crc32c in csum_tree_block_size()
  btrfs-progs: cache csum_type in recover_control
  btrfs-progs: add checksum type to checksumming functions
  btrfs-progs: don't assume checksums are always 4 bytes
  btrfs-progs: pass checksum type to
    btrfs_csum_data()/btrfs_csum_final()
  btrfs-progs: simplify update_block_csum() in btrfs-sb-mod.c
  btrfs-progs: add option for checksum type to mkfs
  btrfs-progs: add test-case for mkfs with xxhash64

 Makefile                                    |    3 +-
 btrfs-corrupt-block.c                       |    3 +-
 btrfs-sb-mod.c                              |   30 +-
 check/main.c                                |   20 +-
 cmds/inspect-dump-super.c                   |   37 +-
 cmds/rescue-chunk-recover.c                 |   23 +-
 convert/common.c                            |   14 +-
 convert/main.c                              |    3 +-
 crypto/hash.c                               |   16 +
 crypto/hash.h                               |   10 +
 crypto/xxhash.c                             | 1024 +++++++++++++++++++++++++++
 crypto/xxhash.h                             |  445 ++++++++++++
 ctree.h                                     |   18 +-
 disk-io.c                                   |   80 ++-
 disk-io.h                                   |    8 +-
 file-item.c                                 |   11 +-
 free-space-cache.c                          |    2 +-
 image/main.c                                |    7 +-
 mkfs/common.c                               |   23 +-
 mkfs/common.h                               |    2 +
 mkfs/main.c                                 |   27 +-
 tests/mkfs-tests/001-basic-profiles/test.sh |    2 +
 22 files changed, 1686 insertions(+), 122 deletions(-)
 create mode 100644 crypto/hash.c
 create mode 100644 crypto/hash.h
 create mode 100644 crypto/xxhash.c
 create mode 100644 crypto/xxhash.h

-- 
2.16.4

