Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4542E25F3B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2019 10:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfEVITP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 May 2019 04:19:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:60400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726514AbfEVITO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 May 2019 04:19:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4A33ADE3;
        Wed, 22 May 2019 08:19:13 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 00/13] Add support for other checksums
Date:   Wed, 22 May 2019 10:18:57 +0200
Message-Id: <20190522081910.7689-1-jthumshirn@suse.de>
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

This is an intermediate submission, as a) mkfs.btrfs support is still missing
and b) David requested to have three hash algorithms, where 1 is crc32c, one
cryptographically secure and one in between.

A changelog can be found directly in the patches. The branch is also available
on a gitweb at
https://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git/log/?h=btrfs-csum-rework.v3

Johannes Thumshirn (13):
  btrfs: use btrfs_csum_data() instead of directly calling crc32c
  btrfs: resurrect btrfs_crc32c()
  btrfs: use btrfs_crc32c{,_final}() in for free space cache
  btrfs: don't assume ordered sums to be 4 bytes
  btrfs: dont assume compressed_bio sums to be 4 bytes
  btrfs: format checksums according to type for printing
  btrfs: add common checksum type validation
  btrfs: check for supported superblock checksum type before checksum
    validation
  btrfs: Simplify btrfs_check_super_csum() and get rid of size
    assumptions
  btrfs: add boilerplate code for directly including the crypto
    framework
  btrfs: directly call into crypto framework for checsumming
  btrfs: remove assumption about csum type form
    btrfs_print_data_csum_error()
  btrfs: add sha256 as another checksum algorithm

 fs/btrfs/Kconfig                |   4 +-
 fs/btrfs/btrfs_inode.h          |  33 +++++++--
 fs/btrfs/check-integrity.c      |  12 ++--
 fs/btrfs/compression.c          |  40 +++++++----
 fs/btrfs/compression.h          |   2 +-
 fs/btrfs/ctree.h                |  27 +++++++-
 fs/btrfs/disk-io.c              | 146 ++++++++++++++++++++++++++--------------
 fs/btrfs/disk-io.h              |   2 -
 fs/btrfs/extent-tree.c          |   6 +-
 fs/btrfs/file-item.c            |  44 +++++++-----
 fs/btrfs/free-space-cache.c     |  10 ++-
 fs/btrfs/inode.c                |  20 ++++--
 fs/btrfs/ordered-data.c         |  10 +--
 fs/btrfs/ordered-data.h         |   4 +-
 fs/btrfs/scrub.c                |  39 ++++++++---
 fs/btrfs/send.c                 |   2 +-
 fs/btrfs/super.c                |   2 +
 include/uapi/linux/btrfs_tree.h |   6 +-
 18 files changed, 280 insertions(+), 129 deletions(-)

-- 
2.16.4

