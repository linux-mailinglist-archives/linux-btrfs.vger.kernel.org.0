Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29BB212332E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 18:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfLQRIW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 12:08:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:47194 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbfLQRIV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 12:08:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6D88BACCA;
        Tue, 17 Dec 2019 17:08:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AA7AEDA791; Tue, 17 Dec 2019 18:08:17 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.5-rc3
Date:   Tue, 17 Dec 2019 18:08:16 +0100
Message-Id: <cover.1576601647.git.dsterba@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a mix of regression fixes and regular fixes for stable trees. Please
pull. Thanks.

Changes:

- fix swapped error messages for qgroup enable/rescan

- fixes for NO_HOLES feature with clone range

- fix deadlock between iget/srcu lock/synchronize srcu while freeing an
  inode

- fix double lock on subvolume cross-rename

- tree log fixes
  - fix missing data checksums after replaying a log tree
  - also teach tree-checker about this problem
  - skip log replay on orphaned roots

- fix maximum devices constraints for RAID1C -3 and -4

- send: don't print warning on read-only mount regarding orphan cleanup

- error handling fixes

----------------------------------------------------------------
The following changes since commit fa17ed069c61286b26382e23b57a62930657b9c1:

  btrfs: drop bdev argument from submit_extent_page (2019-11-18 23:43:58 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.5-rc2-tag

for you to fetch changes up to fbd542971aa1e9ec33212afe1d9b4f1106cd85a1:

  btrfs: send: remove WARN_ON for readonly mount (2019-12-13 14:10:46 +0100)

----------------------------------------------------------------
Anand Jain (1):
      btrfs: send: remove WARN_ON for readonly mount

Andreas Färber (1):
      btrfs: tree-checker: Fix error format string for size_t

Dan Carpenter (1):
      btrfs: return error pointer from alloc_test_extent_buffer

David Sterba (1):
      btrfs: fix devs_max constraints for raid1c3 and raid1c4

Filipe Manana (5):
      Btrfs: fix cloning range with a hole when using the NO_HOLES feature
      Btrfs: fix missing data checksums after replaying a log tree
      Btrfs: make tree checker detect checksum items with overlapping ranges
      Btrfs: fix removal logic of the tree mod log that leads to use-after-free issues
      Btrfs: fix hole extent items with a zero size after range cloning

Josef Bacik (7):
      btrfs: do not call synchronize_srcu() in inode_tree_del
      btrfs: handle error in btrfs_cache_block_group
      btrfs: don't double lock the subvol_sem for rename exchange
      btrfs: abort transaction after failed inode updates in create_subvol
      btrfs: handle ENOENT in btrfs_uuid_tree_iterate
      btrfs: skip log replay on orphaned roots
      btrfs: do not leak reloc root if we fail to read the fs root

Nikolay Borisov (1):
      btrfs: Fix error messages in qgroup_rescan_init

 fs/btrfs/ctree.c                       |  2 +-
 fs/btrfs/ctree.h                       |  2 +-
 fs/btrfs/extent-tree.c                 | 27 ++++++++++++++----
 fs/btrfs/extent_io.c                   |  6 ++--
 fs/btrfs/file-item.c                   |  7 +++--
 fs/btrfs/file.c                        |  4 +--
 fs/btrfs/inode.c                       | 12 +++-----
 fs/btrfs/ioctl.c                       | 26 ++++++++---------
 fs/btrfs/qgroup.c                      |  4 +--
 fs/btrfs/relocation.c                  |  1 +
 fs/btrfs/send.c                        |  6 ----
 fs/btrfs/tests/free-space-tree-tests.c |  4 +--
 fs/btrfs/tests/qgroup-tests.c          |  4 +--
 fs/btrfs/tree-checker.c                | 20 +++++++++++--
 fs/btrfs/tree-log.c                    | 52 ++++++++++++++++++++++++++++++----
 fs/btrfs/uuid-tree.c                   |  2 ++
 fs/btrfs/volumes.c                     |  4 +--
 17 files changed, 127 insertions(+), 56 deletions(-)
