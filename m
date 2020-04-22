Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BB91B37D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 08:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgDVGuS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 02:50:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:51026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgDVGuS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 02:50:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 26F9AAB91;
        Wed, 22 Apr 2020 06:50:13 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        u-boot@lists.denx.de
Cc:     marek.behun@nic.cz
Subject: [PATCH U-BOOT 00/26] fs: btrfs: Re-implement btrfs support using the more widely used extent buffer base code
Date:   Wed, 22 Apr 2020 14:49:43 +0800
Message-Id: <20200422065009.69392-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The branch can be fetched from github:
https://github.com/adam900710/u-boot/tree/btrfs_rebuild

The current btrfs code in U-boot is using a creative way to read on-disk
data.
It's pretty simple, involving the least amount of code, but pretty
different from btrfs-progs nor kernel, making it pretty hard to sync
code between different projects.

This big patchset will rework the btrfs support, to use code mostly from
btrfs-progs, thus all existing btrfs developers will feel at home.

During the rework, the following new features are added:
- More hash algorithm support
  SHA256 and XXHASH support are added.
  BLAKE2 needs more backport, will happen in a separate patchset.

- The ability to read degraded RAID1
  Although we still only support one device btrfs, the new code base
  can choose from different copies already.
  As long as new device scan interface is provided, multi-device support
  is pretty simple.

- More correct handling of compressed extents with offset
  For compressed extent with offset, we should read the whole compressed
  extent, decompress them, then copy the referred part.

There are some more features incoming, with the new code base it would
be much easier to implement:
- Data checksum support
  The check would happen in read_extent_data(), btrfs-progs has the
  needed facility to locate data csum.

- BLAKE2 support
  Need BLAKE2 library cross ported.
  For btrfs it's just several lines of modification.

- Multi-device support along wit degraded RAID support
  We only need an interface to scan one device without opening it.
  The infrastructure is already provided in this patchset.

These new features would be submitted after the patchset get merged,
since the patchset is already large, I don't want to make it more scary.

Although this patchset look horribly large, most of them are code copy
from btrfs-progs.
E.g extent-cache.[ch], rbtree-utils.[ch], btrfs_btree.h.
And ctree.h has over 1000 lines copied just for various accessors.

While for disk-io.[ch] and volumes-io.[ch], they have some small
modifications to adapt the interface of U-boot.
E.g. btrfs_device::fd is replace with blkdev_desc and disk_partition_t.

The new code for U-boot are related to the following functions:
- btrfs_readlink()
- btrfs_lookup_path()
- btrfs_read_extent_inline()
- btrfs_read_extent_reg()
- lookup_data_extent()
- btrfs_file_read()

Thus only the following 5 patches need extra review attention:
- Patch 0017
- Patch 0018
- Patch 0022
- Patch 0023
- Patch 0024

Qu Wenruo (26):
  fs: btrfs: Sync btrfs_btree.h from kernel
  fs: btrfs: Add More checksum algorithm support to btrfs
  fs: btrfs: Cross-port btrfs_read_dev_super() from btrfs-progs
  fs: btrfs: Cross-port rbtree-utils from btrfs-progs
  fs: btrfs: Cross-port extent-cache.[ch] from btrfs-progs
  fs: btrfs: Cross-port extent-io.[ch] from btrfs-progs
  fs: btrfs: Cross port structure accessor into ctree.h
  fs: btrfs: Cross port volumes.[ch] from btrfs-progs
  fs: btrfs: Crossport read_tree_block() from btrfs-progs
  fs: btrfs: Rename struct btrfs_path to struct __btrfs_path
  fs: btrfs: Rename btrfs_root to __btrfs_root
  fs: btrfs: Cross port struct btrfs_root to ctree.h
  fs: btrfs: Crossport btrfs_search_slot() from btrfs-progs
  fs: btrfs: Crossport btrfs_read_sys_array() and
    btrfs_read_chunk_tree()
  fs: btrfs: Crossport open_ctree_fs_info()
  fs: btrfs: Rename path resolve related functions to avoid name
    conflicts
  fs: btrfs: Use btrfs_readlink() to implement __btrfs_readlink()
  fs: btrfs: Implement btrfs_lookup_path()
  fs: btrfs: Use btrfs_iter_dir() to replace btrfs_readdir()
  fs: btrfs: Use btrfs_lookup_path() to implement btrfs_exists() and
    btrfs_size()
  fs: btrfs: Rename btrfs_file_read() and its callees to avoid name
    conflicts
  fs: btrfs: Introduce btrfs_read_extent_inline() and
    btrfs_read_extent_reg()
  fs: btrfs: Introduce lookup_data_extent() for later use
  fs: btrfs: Implement btrfs_file_read()
  fs: btrfs: Cleanup the old implementation
  MAINTAINERS: Add btrfs mail list

 MAINTAINERS                         |    1 +
 fs/btrfs/Makefile                   |    5 +-
 fs/btrfs/btrfs.c                    |  311 +++---
 fs/btrfs/btrfs.h                    |   67 +-
 fs/btrfs/btrfs_tree.h               |  766 --------------
 fs/btrfs/chunk-map.c                |  177 ----
 fs/btrfs/common/rbtree-utils.c      |   83 ++
 fs/btrfs/common/rbtree-utils.h      |   53 +
 fs/btrfs/compat.h                   |   80 ++
 fs/btrfs/compression.c              |    2 +-
 fs/btrfs/crypto/hash.c              |   55 +
 fs/btrfs/crypto/hash.h              |   17 +
 fs/btrfs/ctree.c                    |  866 ++++++++++++----
 fs/btrfs/ctree.h                    | 1452 ++++++++++++++++++++++-----
 fs/btrfs/dir-item.c                 |  192 ++--
 fs/btrfs/disk-io.c                  | 1062 ++++++++++++++++++++
 fs/btrfs/disk-io.h                  |   50 +
 fs/btrfs/extent-cache.c             |  318 ++++++
 fs/btrfs/extent-cache.h             |  104 ++
 fs/btrfs/extent-io.c                |  845 ++++++++++++++--
 fs/btrfs/extent-io.h                |  164 +++
 fs/btrfs/hash.c                     |   38 -
 fs/btrfs/inode.c                    |  879 +++++++++++-----
 fs/btrfs/kernel-shared/btrfs_tree.h | 1333 ++++++++++++++++++++++++
 fs/btrfs/root-tree.c                |   47 +
 fs/btrfs/root.c                     |   92 --
 fs/btrfs/subvolume.c                |  130 ---
 fs/btrfs/super.c                    |  246 -----
 fs/btrfs/volumes.c                  | 1173 ++++++++++++++++++++++
 fs/btrfs/volumes.h                  |  204 ++++
 30 files changed, 8308 insertions(+), 2504 deletions(-)
 delete mode 100644 fs/btrfs/btrfs_tree.h
 delete mode 100644 fs/btrfs/chunk-map.c
 create mode 100644 fs/btrfs/common/rbtree-utils.c
 create mode 100644 fs/btrfs/common/rbtree-utils.h
 create mode 100644 fs/btrfs/compat.h
 create mode 100644 fs/btrfs/crypto/hash.c
 create mode 100644 fs/btrfs/crypto/hash.h
 create mode 100644 fs/btrfs/disk-io.c
 create mode 100644 fs/btrfs/disk-io.h
 create mode 100644 fs/btrfs/extent-cache.c
 create mode 100644 fs/btrfs/extent-cache.h
 create mode 100644 fs/btrfs/extent-io.h
 delete mode 100644 fs/btrfs/hash.c
 create mode 100644 fs/btrfs/kernel-shared/btrfs_tree.h
 create mode 100644 fs/btrfs/root-tree.c
 delete mode 100644 fs/btrfs/root.c
 delete mode 100644 fs/btrfs/subvolume.c
 delete mode 100644 fs/btrfs/super.c
 create mode 100644 fs/btrfs/volumes.c
 create mode 100644 fs/btrfs/volumes.h

-- 
2.26.0

