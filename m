Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09ABB207837
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 18:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404761AbgFXQD1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 12:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404665AbgFXQDY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 12:03:24 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E542EC0613ED
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jun 2020 09:03:23 -0700 (PDT)
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 48E15140649;
        Wed, 24 Jun 2020 18:03:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1593014601; bh=ptR7h3DS3TGGee3QPjNfDFKzkXpNWXRw/mk2YNQrM8M=;
        h=From:To:Date;
        b=qJqOnuA6f3s1cSpvY13zqbVYs1Bxn/nXz+5vtzBoVZoHuyudAIe1O3XWSeR28qwbG
         o/3djhZap5EVGHfF3057FD1q90ki//uDH2VyIoNqQvyVJNuf2YZX2wLAZDO8l3UyiA
         /K2MWVBLlh3xqmL7JgYBiqPCvDHzKUs9aW7FEtog=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     u-boot@lists.denx.de
Cc:     =?UTF-8?q?Alberto=20S=C3=A1nchez=20Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH U-BOOT v3 00/30] PLEASE TEST fs: btrfs: Re-implement btrfs support using code from btrfs-progs
Date:   Wed, 24 Jun 2020 18:02:46 +0200
Message-Id: <20200624160316.5001-1-marek.behun@nic.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Spam-Status: No, score=0.00
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

this is a cleaned up version of Qu's patches that reimplements U-Boot's
btrfs driver with code from btrfs-progs.

I have tested this series, found and corrected one bug (failure when
accesing files via symlinks), and it looks it is working now, but I
would like more people to do some testing.

There are a lot of checkpatch warnings and errors left, I shall fix
this in the future.

Marek

Changes since v2:
- fixed btrfs_lookup_path() in patch 19 to correctly handle symlinks
- commit messages were updated some
  - for example they used the word "crossport" in 3 formats:
    "crossport", "cross-port" and "cross port", this was changed
    to "crossport"
  - corrected some typos
  - some English sentences were a bit weirdly written
- fixed 2 compiler warnings (one use of maybe uninitialized variable and
  one printf specifier warning)
- indentation in some places was wrong (usage of 8 spaces instead of a
  tab, for example)
- added my Reviewed-by
- the last patch, adding btrfs mailing list to MAINTAINRES, also adds
  Qu as designated reviewer, so that people add him to Cc when they send
  patches

Changes since v1:
- Implement btrfs_list_subvols()
  In v1 it's completely removed thus would cause problem if btrfsolume
  command is compiled in.
- Rebased to latest master
  Only minor conflicts due to header changes.
- Allow next_legnth() to return value > BTRFS_NAME_LEN

Below is Qu's explanation, from cover letter of v2:

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
- btrfs_list_subvols()

Qu Wenruo (30):
  fs: btrfs: Sync btrfs_btree.h from kernel
  fs: btrfs: Add more checksum algorithms
  fs: btrfs: Crossport btrfs_read_dev_super() from btrfs-progs
  fs: btrfs: Crossport rbtree-utils from btrfs-progs
  fs: btrfs: Crossport extent-cache.[ch] from btrfs-progs
  fs: btrfs: Crossport extent-io.[ch] from btrfs-progs
  fs: btrfs: Crossport structure accessor into ctree.h
  fs: btrfs: Crossport volumes.[ch] from btrfs-progs
  fs: btrfs: Crossport read_tree_block() from btrfs-progs
  fs: btrfs: Rename struct btrfs_path to struct __btrfs_path
  fs: btrfs: Rename btrfs_root to __btrfs_root
  fs: btrfs: Crossport struct btrfs_root to ctree.h
  fs: btrfs: Crossport btrfs_search_slot() from btrfs-progs
  fs: btrfs: Crossport btrfs_read_sys_array() and
    btrfs_read_chunk_tree()
  fs: btrfs: Crossport open_ctree_fs_info() from btrfs-progs
  fs: btrfs: Rename path resolve related functions to avoid name
    conflicts
  fs: btrfs: Use btrfs_readlink() to implement __btrfs_readlink()
  fs: btrfs: inode: Allow next_length() to return value > BTRFS_NAME_LEN
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
  fs: btrfs: Introduce function to resolve path in one subvolume
  fs: btrfs: Introduce function to resolve the path of one subvolume
  fs: btrfs: Imeplement btrfs_list_subvols() using new infrastructure
  fs: btrfs: Cleanup the old implementation
  MAINTAINERS: Add btrfs mailing list and myself as reviewer

 MAINTAINERS                         |    2 +
 fs/btrfs/Makefile                   |    5 +-
 fs/btrfs/btrfs.c                    |  319 +++---
 fs/btrfs/btrfs.h                    |   67 +-
 fs/btrfs/btrfs_tree.h               |  766 --------------
 fs/btrfs/chunk-map.c                |  178 ----
 fs/btrfs/common/rbtree-utils.c      |   83 ++
 fs/btrfs/common/rbtree-utils.h      |   53 +
 fs/btrfs/compat.h                   |   88 ++
 fs/btrfs/compression.c              |    2 +-
 fs/btrfs/crypto/hash.c              |   55 +
 fs/btrfs/crypto/hash.h              |   17 +
 fs/btrfs/ctree.c                    |  859 ++++++++++++----
 fs/btrfs/ctree.h                    | 1453 ++++++++++++++++++++++-----
 fs/btrfs/dir-item.c                 |  192 ++--
 fs/btrfs/disk-io.c                  | 1062 ++++++++++++++++++++
 fs/btrfs/disk-io.h                  |   50 +
 fs/btrfs/extent-cache.c             |  318 ++++++
 fs/btrfs/extent-cache.h             |  104 ++
 fs/btrfs/extent-io.c                |  847 ++++++++++++++--
 fs/btrfs/extent-io.h                |  164 +++
 fs/btrfs/hash.c                     |   38 -
 fs/btrfs/inode.c                    |  884 +++++++++++-----
 fs/btrfs/kernel-shared/btrfs_tree.h | 1333 ++++++++++++++++++++++++
 fs/btrfs/root-tree.c                |   47 +
 fs/btrfs/root.c                     |   92 --
 fs/btrfs/subvolume.c                |  310 ++++--
 fs/btrfs/super.c                    |  257 -----
 fs/btrfs/volumes.c                  | 1173 +++++++++++++++++++++
 fs/btrfs/volumes.h                  |  204 ++++
 30 files changed, 8531 insertions(+), 2491 deletions(-)
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
 delete mode 100644 fs/btrfs/super.c
 create mode 100644 fs/btrfs/volumes.c
 create mode 100644 fs/btrfs/volumes.h

-- 
2.26.2

