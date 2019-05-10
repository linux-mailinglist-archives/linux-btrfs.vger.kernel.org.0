Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A72919C47
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2019 13:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfEJLPx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 May 2019 07:15:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:50516 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727225AbfEJLPx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 May 2019 07:15:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 10B02AF79
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2019 11:15:52 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 00/17] Add support for SHA-256 checksums
Date:   Fri, 10 May 2019 13:15:30 +0200
Message-Id: <20190510111547.15310-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset add support for adding new checksum types in BTRFS.

Currently BTRFS only supports CRC32C as data and metadata checksum, which is
good if you only want to detect errors due to data corruption in hardware.

But CRC32C isn't able cover other use-cases like de-duplication or
cryptographically save data integrity guarantees.

The following properties made SHA-256 interesting for these use-cases:
- Still considered cryptographically sound
- Reasonably well understood by the security industry
- Result fits into the 32Byte/256Bit we have for the checksum in the on-disk
  format
- Small enough collision space to make it feasible for data de-duplication
- Fast enough to calculate and offloadable to crypto hardware via the kernel's
  crypto_shash framework.

The patchset also provides mechanisms for plumbing in different hash
algorithms relatively easy.

Unfortunately this patchset also partially reverts commit: 
9678c54388b6 ("btrfs: Remove custom crc32c init code")

Patches 1 - 16 are preparation patches to make the change of the checksum
algorithm easy and patch 17 then finally adds SHA-256 as a new checksum
algorithm.

Only patch 17/17 is dependent on mkfs changes.

Johannes Thumshirn (17):
  btrfs: use btrfs_csum_data() instead of directly calling crc32c
  btrfs: resurrect btrfs_crc32c()
  btrfs: use btrfs_crc32c() instead of btrfs_extref_hash()
  btrfs: use btrfs_crc32c() instead of btrfs_name_hash()
  btrfs: don't assume ordered sums to be 4 bytes
  btrfs: dont assume compressed_bio sums to be 4 bytes
  btrfs: use btrfs_crc32c{,_final}() in for free space cache
  btrfs: format checksums according to type for printing
  btrfs: add common checksum type validation
  btrfs: check for supported superblock checksum type before checksum
    validation
  btrfs: Simplify btrfs_check_super_csum() and get rid of size
    assumptions
  btrfs: add boilerplate code for directly including the crypto
    framework
  btrfs: pass in an fs_info to btrfs_csum_{data,final}()
  btrfs: directly call into crypto framework for checsumming
  btrfs: remove assumption about csum type form
    btrfs_csum_{data,final}()
  btrfs: remove assumption about csum type form
    btrfs_print_data_csum_error()
  btrfs: add sha256 as another checksum algorithm

 fs/btrfs/btrfs_inode.h          |  33 ++++++--
 fs/btrfs/check-integrity.c      |   6 +-
 fs/btrfs/compression.c          |  34 +++++----
 fs/btrfs/compression.h          |   2 +-
 fs/btrfs/ctree.h                |  30 +++++---
 fs/btrfs/dir-item.c             |  10 +--
 fs/btrfs/disk-io.c              | 164 +++++++++++++++++++++++++++++-----------
 fs/btrfs/disk-io.h              |   5 +-
 fs/btrfs/extent-tree.c          |   6 +-
 fs/btrfs/file-item.c            |  35 ++++-----
 fs/btrfs/free-space-cache.c     |  10 +--
 fs/btrfs/inode-item.c           |   6 +-
 fs/btrfs/inode.c                |  21 +++--
 fs/btrfs/ordered-data.c         |  13 ++--
 fs/btrfs/ordered-data.h         |   4 +-
 fs/btrfs/props.c                |   5 +-
 fs/btrfs/scrub.c                |  22 +++---
 fs/btrfs/send.c                 |   5 +-
 fs/btrfs/tree-checker.c         |   3 +-
 fs/btrfs/tree-log.c             |   6 +-
 include/uapi/linux/btrfs_tree.h |   1 +
 21 files changed, 276 insertions(+), 145 deletions(-)

-- 
2.16.4

