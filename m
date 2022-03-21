Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7087D4E35E0
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 02:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbiCVBO7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Mar 2022 21:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbiCVBO6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Mar 2022 21:14:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B4313CC4;
        Mon, 21 Mar 2022 18:13:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7A874210F0;
        Mon, 21 Mar 2022 21:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647898630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JKHx/9SwDe6T3GQCr95qMN28gaKErxUDbVaf8UGzMsw=;
        b=BW0E9LCuwRXo4Ds1QoIFeRmhaMdmZJUs/LcGm12IBqAKuSdS+OpjxwZuuMR2OfkwZ1/278
        nk5VW4qrG5d3OV7doEr3nB76QF+PEoAcX54cDSHux2+5tGrmdKattYdQcc2eDW6N8oBIlS
        i+nyAabqTCU9amREdOjVdz8HwvLXWnE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6EF26A3B81;
        Mon, 21 Mar 2022 21:37:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 508D9DA818; Mon, 21 Mar 2022 22:33:08 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.18
Date:   Mon, 21 Mar 2022 22:33:04 +0100
Message-Id: <cover.1647894991.git.dsterba@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

this update contains feature updates, performance improvements,
preparatory and core work and some related VFS updates.  Please pull,
thanks.

Features:

- encoded read/write ioctls, allows user space to read or write raw data
  directly to extents (now compressed, encrypted in the future), will be
  used by send/receive v2 where it saves processing time

- zoned mode now works with metadata DUP (the mkfs.btrfs default)

- error message header updates:
  - print error state: transaction abort, other error, log tree errors
  - print transient filesystem state: remount, device replace, ignored
    checksum verifications

- tree-checker: verify the transaction id of the to-be-written dirty
  extent buffer

Performance improvements:

- fsync speedups
  - directory logging speedups (up to -90% run time)
  - avoid logging all directory changes during renames (up to -60% run
    time)
  - avoid inode logging during rename and link when possible (up to -60%
    run time)
  - prepare extents to be logged before locking a log tree path
    (throughput +7%)
  - stop copying old file extents when doing a full fsync ()
  - improved logging of old extents after truncate

Core, fixes:

- improved stale device identification by dev_t and not just path (for
  devices that are behind other layers like device mapper)

- continued extent tree v2 preparatory work
  - disable features that won't work yet
  - add wrappers and abstractions for new tree roots

- improved error handling

- add super block write annotations around background block group
  reclaim

- fix device scanning messages potentially accessing stale pointer

- cleanups and refactoring

VFS:

- allow reflinks/deduplication from two different mounts of the same
  filesystem

- export and add helpers for read/write range verification, for the
  encoded ioctls

----------------------------------------------------------------
The following changes since commit 09688c0166e76ce2fb85e86b9d99be8b0084cdf9:

  Linux 5.17-rc8 (2022-03-13 13:23:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.18-tag

for you to fetch changes up to d3e29967079c522ce1c5cab0e9fab2c280b977eb:

  btrfs: zoned: put block group after final usage (2022-03-14 13:13:54 +0100)

----------------------------------------------------------------
Anand Jain (6):
      btrfs: simplify fs_devices member access in btrfs_init_dev_replace_tgtdev
      btrfs: harden identification of a stale device
      btrfs: match stale devices by dev_t
      btrfs: add device major-minor info in the struct btrfs_device
      btrfs: use dev_t to match device in device_matched
      btrfs: cleanup temporary variables when finding rotational device status

David Sterba (1):
      btrfs: replace BUILD_BUG_ON by static_assert

Dongliang Mu (1):
      btrfs: don't access possibly stale fs_info data in device_list_add

Dāvis Mosāns (1):
      btrfs: add lzo workspace buffer length constants

Filipe Manana (28):
      btrfs: remove write and wait of struct walk_control
      btrfs: don't log unnecessary boundary keys when logging directory
      btrfs: put initial index value of a directory in a constant
      btrfs: stop copying old dir items when logging a directory
      btrfs: stop trying to log subdirectories created in past transactions
      btrfs: add helper to delete a dir entry from a log tree
      btrfs: pass the dentry to btrfs_log_new_name() instead of the inode
      btrfs: avoid logging all directory changes during renames
      btrfs: stop doing unnecessary log updates during a rename
      btrfs: avoid inode logging during rename and link when possible
      btrfs: use single variable to track return value at btrfs_log_inode()
      btrfs: remove unnecessary leaf free space checks when pushing items
      btrfs: avoid unnecessary COW of leaves when deleting items from a leaf
      btrfs: avoid unnecessary computation when deleting items from a leaf
      btrfs: remove constraint on number of visited leaves when replacing extents
      btrfs: remove useless path release in the fast fsync path
      btrfs: prepare extents to be logged before locking a log tree path
      btrfs: stop checking for NULL return from btrfs_get_extent()
      btrfs: fix lost error return value when reading a data page
      btrfs: remove no longer used counter when reading data page
      btrfs: assert we have a write lock when removing and replacing extent maps
      btrfs: stop copying old file extents when doing a full fsync
      btrfs: hold on to less memory when logging checksums during full fsync
      btrfs: voluntarily relinquish cpu when doing a full fsync
      btrfs: reset last_reflink_trans after fsyncing inode
      btrfs: fix unexpected error path when reflinking an inline extent
      btrfs: deal with unexpected extent type during reflinking
      btrfs: add and use helper for unlinking inode during log replay

Jiapeng Chong (2):
      btrfs: zoned: remove redundant initialization of to_add
      btrfs: scrub: remove redundant initialization of increment

Johannes Thumshirn (5):
      btrfs: zoned: make zone activation multi stripe capable
      btrfs: zoned: make zone finishing multi stripe capable
      btrfs: zoned: prepare for allowing DUP on zoned
      btrfs: zoned: allow DUP on meta-data block groups
      btrfs: stop checking for NULL return from btrfs_get_extent_fiemap()

Josef Bacik (27):
      btrfs: add definition for EXTENT_TREE_V2
      btrfs: disable balance for extent tree v2 for now
      btrfs: disable device manipulation ioctl's EXTENT_TREE_V2
      btrfs: disable qgroups in extent tree v2
      btrfs: disable scrub for extent-tree-v2
      btrfs: disable snapshot creation/deletion for extent tree v2
      btrfs: disable space cache related mount options for extent tree v2
      btrfs: tree-checker: don't fail on empty extent roots for extent tree v2
      btrfs: abstract out loading the tree root
      btrfs: add code to support the block group root
      btrfs: add support for multiple global roots
      btrfs: make search_csum_tree return 0 if we get -EFBIG
      btrfs: handle csum lookup errors properly on reads
      btrfs: check correct bio in finish_compressed_bio_read
      btrfs: remove the bio argument from finish_compressed_bio_read
      btrfs: track compressed bio errors as blk_status_t
      btrfs: do not double complete bio on errors during compressed reads
      btrfs: do not try to repair bio that has no mirror set
      btrfs: do not clean up repair bio if submit fails
      btrfs: pass btrfs_fs_info for deleting snapshots and cleaner
      btrfs: pass btrfs_fs_info to btrfs_recover_relocation
      btrfs: remove the cross file system checks from remap
      fs: allow cross-vfsmount reflink/dedupe
      btrfs: remove BUG_ON(ret) in alloc_reserved_tree_block
      btrfs: add a alloc_reserved_extent helper
      btrfs: remove last_ref from the extent freeing code
      btrfs: factor out do_free_extent_accounting helper

Minghao Chi (1):
      btrfs: send: remove redundant ret variable in fs_path_copy

Naohiro Aota (1):
      btrfs: zoned: mark relocation as writing

Niels Dossche (2):
      btrfs: extend locking to all space_info members accesses
      btrfs: add lockdep_assert_held to need_preemptive_reclaim

Nikolay Borisov (3):
      btrfs: move missing device handling in a dedicate function
      btrfs: move QUOTA_ENABLED check to rescan_should_stop from btrfs_qgroup_rescan_worker
      btrfs: zoned: put block group after final usage

Omar Sandoval (10):
      fs: export rw_verify_area()
      fs: export variant of generic_write_checks without iov_iter
      btrfs: don't advance offset for compressed bios in btrfs_csum_one_bio()
      btrfs: add ram_bytes and offset to btrfs_ordered_extent
      btrfs: support different disk extent size for delalloc
      btrfs: clean up cow_file_range_inline()
      btrfs: optionally extend i_size in cow_file_range_inline()
      btrfs: add definitions and documentation for encoded I/O ioctls
      btrfs: add BTRFS_IOC_ENCODED_READ ioctl
      btrfs: add BTRFS_IOC_ENCODED_WRITE

Pankaj Raghav (1):
      btrfs: zoned: remove redundant assignment in btrfs_check_zoned_mode

Qu Wenruo (4):
      btrfs: populate extent_map::generation when reading from disk
      btrfs: unify the error handling pattern for read_tree_block()
      btrfs: unify the error handling of btrfs_read_buffer()
      btrfs: verify the tranisd of the to-be-written dirty extent buffer

Sahil Kang (2):
      btrfs: reuse existing pointers from btrfs_ioctl
      btrfs: reuse existing inode from btrfs_ioctl

Sidong Yang (2):
      btrfs: qgroup: remove duplicated check in adding qgroup relations
      btrfs: qgroup: remove outdated TODO comments

Sweet Tea Dorminy (1):
      btrfs: add filesystems state details to error messages

 fs/btrfs/backref.c                |    7 +-
 fs/btrfs/block-group.c            |   36 +-
 fs/btrfs/block-group.h            |    1 +
 fs/btrfs/btrfs_inode.h            |   42 +-
 fs/btrfs/compression.c            |   63 +-
 fs/btrfs/compression.h            |   10 +-
 fs/btrfs/ctree.c                  |  108 ++--
 fs/btrfs/ctree.h                  |   83 ++-
 fs/btrfs/delalloc-space.c         |   18 +-
 fs/btrfs/dev-replace.c            |   18 +-
 fs/btrfs/disk-io.c                |  219 +++++--
 fs/btrfs/disk-io.h                |    2 +
 fs/btrfs/extent-tree.c            |  148 +++--
 fs/btrfs/extent_io.c              |   45 +-
 fs/btrfs/extent_map.c             |    4 +
 fs/btrfs/file-item.c              |   76 +--
 fs/btrfs/file.c                   |   79 ++-
 fs/btrfs/free-space-tree.c        |    2 +
 fs/btrfs/inode.c                  | 1183 +++++++++++++++++++++++++++++--------
 fs/btrfs/ioctl.c                  |  309 ++++++++--
 fs/btrfs/lzo.c                    |   11 +-
 fs/btrfs/ordered-data.c           |  132 ++---
 fs/btrfs/ordered-data.h           |   25 +-
 fs/btrfs/print-tree.c             |    5 +-
 fs/btrfs/qgroup.c                 |   72 ++-
 fs/btrfs/reflink.c                |   43 +-
 fs/btrfs/relocation.c             |   11 +-
 fs/btrfs/scrub.c                  |    2 +-
 fs/btrfs/send.c                   |   11 +-
 fs/btrfs/send.h                   |    2 +-
 fs/btrfs/space-info.c             |    5 +-
 fs/btrfs/super.c                  |   96 ++-
 fs/btrfs/sysfs.c                  |   15 +-
 fs/btrfs/tests/extent-map-tests.c |    2 +
 fs/btrfs/transaction.c            |   19 +-
 fs/btrfs/transaction.h            |    2 +-
 fs/btrfs/tree-checker.c           |   35 +-
 fs/btrfs/tree-log.c               |  982 ++++++++++++++++++------------
 fs/btrfs/tree-log.h               |    7 +-
 fs/btrfs/volumes.c                |  147 ++---
 fs/btrfs/volumes.h                |    7 +-
 fs/btrfs/zoned.c                  |  167 ++++--
 fs/internal.h                     |    5 -
 fs/ioctl.c                        |    4 -
 fs/read_write.c                   |   34 +-
 fs/remap_range.c                  |    7 +-
 include/linux/fs.h                |    2 +
 include/trace/events/btrfs.h      |    1 +
 include/uapi/linux/btrfs.h        |  133 +++++
 include/uapi/linux/btrfs_tree.h   |    3 +
 50 files changed, 3109 insertions(+), 1331 deletions(-)
