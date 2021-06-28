Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65073B6838
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 20:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbhF1SV1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 14:21:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56142 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbhF1SVY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 14:21:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3403E2250C;
        Mon, 28 Jun 2021 18:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624904336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=v9aFv0/k4SUkUHpkwXQmB2p8U/2u/2Z6zvkHz90KRWY=;
        b=ONm/ugNr1A2S1Qo4MRGLFa69eMGldgjkodiWisySCirP/IqWnzonEkt3eUi83oZN7RchHQ
        RabtoC1WGrzAOINB+XNatkkI2PIo3ChyW+vJP0UMy1rTYytDxrFi29+tKWozaYUdaiBuVv
        6cjvgCyLs+UmXptgd1J8ZRi4U/czuF4=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2C756A3B96;
        Mon, 28 Jun 2021 18:18:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EE3B4DA7F7; Mon, 28 Jun 2021 20:16:26 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.14
Date:   Mon, 28 Jun 2021 20:16:26 +0200
Message-Id: <cover.1624891843.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

here's a normal mix of improvements, core changes and features that user
have been missing or complaining about.

Please pull, thanks.

User visible changes:

- new sysfs exports
  - add sysfs knob to limit scrub IO bandwidth per device
  - device stats are also available in
    /sys/fs/btrfs/FSID/devinfo/DEVID/error_stats

- support cancellable resize and device delete ioctls

- change how the empty value is interpreted when setting a property,
  so far we have only 'btrfs.compression' and we need to distinguish a
  reset to defaults and setting "do not compress", in general the empty
  value will always mean 'reset to defaults' for any other property, for
  compression it's either 'no' or 'none' to forbid compression

Performance improvements:

- no need for full sync when truncation does not touch extents, reported
  run time change is -12%

- avoid unnecessary logging of xattrs during fast fsyncs (+17%
  throughput, -17% runtime on xattr stress workload)

Core:

- preemptive flushing improvements and fixes
  - adjust clamping logic on multi-threaded workloads to avoid flushing
    too soon
  - take into account global block reserve, may help on almost full
    filesystems
  - continue flushing when there are enough pending delalloc and ordered
    bytes

- simplify logic around conditional transaction commit, a workaround
  used in the past for throttling that's been superseded by ticket
  reservations that manage the throttling in a better way

- subpage blocksize preparation:
  - submit read time repair only for each corrupted sector
  - scrub repair now works with sectors and not pages
  - free space cache (v1) works with sectors and not pages
  - more fine grained bio tracking for extents
  - subpage support in page callbacks, extent callbacks, end io
    callbacks

- simplify transaction abort logic and always abort and don't check
  various potentially unreliable stats tracked by the transaction

- exclusive operations can do more checks when started and allow eg.
  cancellation of the same running operation

- ensure relocation never runs while we have send operations running,
  e.g. when zoned background auto reclaim starts

Fixes:

- zoned: more sanity checks of write pointer

- improve error handling in delayed inodes

- send:
  - fix invalid path for unlink operations after parent orphanization
  - fix crash when memory allocations trigger reclaim

- skip compression of we have only one page (can't make things better)

- empty value of a property newly means reset to default

Other:

- lots of cleanups, comment updates, yearly typo fixing
- disable build on platforms having page size 256K

----------------------------------------------------------------
The following changes since commit 13311e74253fe64329390df80bed3f07314ddd61:

  Linux 5.13-rc7 (2021-06-20 15:03:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.14-tag

for you to fetch changes up to 629e33a16809ae0274e1f5fc3d22b92b9bd0fdf1:

  btrfs: remove unused btrfs_fs_info::total_pinned (2021-06-22 19:58:26 +0200)

----------------------------------------------------------------
Anand Jain (4):
      btrfs: reduce the variable size to fit nr_pages
      btrfs: optimize variables size in btrfs_submit_compressed_read
      btrfs: optimize variables size in btrfs_submit_compressed_write
      btrfs: fix comment about max_out in btrfs_compress_pages

Baokun Li (1):
      btrfs: send: use list_move_tail instead of list_del/list_add_tail

Christophe Leroy (1):
      btrfs: disable build on platforms having page size 256K

David Sterba (24):
      btrfs: scrub: per-device bandwidth control
      btrfs: sysfs: fix format string for some discard stats
      btrfs: clear defrag status of a root if starting transaction fails
      btrfs: clear log tree recovering status if starting transaction fails
      btrfs: scrub: factor out common scrub_stripe constraints
      btrfs: document byte swap optimization of root_item::flags accessors
      btrfs: reduce compressed_bio members' types
      btrfs: remove extra sb::s_id from message in btrfs_validate_metadata_buffer
      btrfs: simplify eb checksum verification in btrfs_validate_metadata_buffer
      btrfs: clean up header members offsets in write helpers
      btrfs: protect exclusive_operation by super_lock
      btrfs: add cancellable chunk relocation support
      btrfs: introduce try-lock semantics for exclusive op start
      btrfs: add wrapper for conditional start of exclusive operation
      btrfs: add cancellation to resize
      btrfs: add device delete cancel
      btrfs: sink wait_for_unblock parameter to async commit
      btrfs: inline wait_current_trans_commit_start in its caller
      btrfs: fix typos in comments
      btrfs: sysfs: export dev stats in devinfo directory
      btrfs: compression: don't try to compress if we don't have enough pages
      btrfs: props: change how empty value is interpreted
      btrfs: switch mount option bits to enums and use wider type
      btrfs: shorten integrity checker extent data mount option

Filipe Manana (6):
      btrfs: fix misleading and incomplete comment of btrfs_truncate()
      btrfs: don't set the full sync flag when truncation does not touch extents
      btrfs: avoid unnecessary logging of xattrs during fast fsyncs
      btrfs: send: fix invalid path for unlink operations after parent orphanization
      btrfs: ensure relocation never runs while we have send operations running
      btrfs: send: fix crash when memory allocations trigger reclaim

Goldwyn Rodrigues (1):
      btrfs: correct try_lock_extent() usage in read_extent_buffer_subpage()

Johannes Thumshirn (3):
      btrfs: zoned: bail out if we can't read a reliable write pointer
      btrfs: rename check_async_write and let it return bool
      btrfs: zoned: factor out zoned device lookup

Josef Bacik (15):
      btrfs: check worker before need_preemptive_reclaim
      btrfs: only clamp the first time we have to start flushing
      btrfs: take into account global rsv in need_preemptive_reclaim
      btrfs: use the global rsv size in the preemptive thresh calculation
      btrfs: don't include the global rsv size in the preemptive used amount
      btrfs: only ignore delalloc if delalloc is much smaller than ordered
      btrfs: handle preemptive delalloc flushing slightly differently
      btrfs: make btrfs_release_delayed_iref handle the !iref case
      btrfs: fix error handling in __btrfs_update_delayed_inode
      btrfs: abort transaction if we fail to update the delayed inode
      btrfs: always abort the transaction if we abort a trans handle
      btrfs: rip out may_commit_transaction
      btrfs: remove FLUSH_DELAYED_REFS from data ENOSPC flushing
      btrfs: rip the first_ticket_bytes logic from fail_all_tickets
      btrfs: rip out btrfs_space_info::total_bytes_pinned

Naohiro Aota (2):
      btrfs: zoned: print message when zone sanity check type fails
      btrfs: fix unbalanced unlock in qgroup_account_snapshot()

Nathan Chancellor (1):
      btrfs: remove total_data_size variable in btrfs_batch_insert_items()

Nikolay Borisov (3):
      btrfs: use list_last_entry in add_falloc_range
      btrfs: eliminate insert label in add_falloc_range
      btrfs: remove unused btrfs_fs_info::total_pinned

Qu Wenruo (38):
      btrfs: make btrfs_verify_data_csum() to return a bitmap
      btrfs: submit read time repair only for each corrupted sector
      btrfs: remove io_failure_record::in_validation
      btrfs: scrub: fix subpage repair error caused by hard coded PAGE_SIZE
      btrfs: make free space cache size consistent across different PAGE_SIZE
      btrfs: remove the unused parameter @len for btrfs_bio_fits_in_stripe()
      btrfs: allow btrfs_bio_fits_in_stripe() to accept bio without any page
      btrfs: refactor submit_extent_page() to make bio and its flag tracing easier
      btrfs: make subpage metadata write path call its own endio functions
      btrfs: pass btrfs_inode to btrfs_writepage_endio_finish_ordered()
      btrfs: make Private2 lifespan more consistent
      btrfs: refactor how we finish ordered extent io for endio functions
      btrfs: update comments in btrfs_invalidatepage()
      btrfs: introduce btrfs_lookup_first_ordered_range()
      btrfs: refactor btrfs_invalidatepage() for subpage support
      btrfs: rename PagePrivate2 to PageOrdered inside btrfs
      btrfs: fix hang when run_delalloc_range() failed
      btrfs: pass bytenr directly to __process_pages_contig()
      btrfs: refactor page status update into process_one_page()
      btrfs: provide btrfs_page_clamp_*() helpers
      btrfs: only require sector size alignment for end_bio_extent_writepage()
      btrfs: make btrfs_dirty_pages() to be subpage compatible
      btrfs: make __process_pages_contig() to handle subpage dirty/error/writeback status
      btrfs: make end_bio_extent_writepage() to be subpage compatible
      btrfs: make process_one_page() to handle subpage locking
      btrfs: introduce helpers for subpage ordered status
      btrfs: make page Ordered bit to be subpage compatible
      btrfs: update locked page dirty/writeback/error bits in __process_pages_contig
      btrfs: prevent extent_clear_unlock_delalloc() to unlock page not locked by __process_pages_contig()
      btrfs: make btrfs_set_range_writeback() subpage compatible
      btrfs: make __extent_writepage_io() only submit dirty range for subpage
      btrfs: make btrfs_truncate_block() to be subpage compatible
      btrfs: make btrfs_page_mkwrite() to be subpage compatible
      btrfs: reflink: make copy_inline_to_page() to be subpage compatible
      btrfs: fix the filemap_range_has_page() call in btrfs_punch_hole_lock_range()
      btrfs: don't clear page extent mapped if we're not invalidating the full page
      btrfs: subpage: fix a rare race between metadata endio and eb freeing
      btrfs: remove a stale comment for btrfs_decompress_bio()

Su Yue (1):
      btrfs: remove stale comment for argument seed of btrfs_find_device

Tian Tao (1):
      btrfs: return EAGAIN if defrag is canceled

 fs/btrfs/Kconfig                  |   2 +
 fs/btrfs/backref.c                |   2 +-
 fs/btrfs/block-group.c            |  31 +-
 fs/btrfs/compression.c            |  57 +--
 fs/btrfs/compression.h            |  26 +-
 fs/btrfs/ctree.c                  |   5 +-
 fs/btrfs/ctree.h                  | 120 +++--
 fs/btrfs/delalloc-space.c         |   2 +-
 fs/btrfs/delayed-inode.c          |  41 +-
 fs/btrfs/delayed-ref.c            |  26 -
 fs/btrfs/dev-replace.c            |   2 +-
 fs/btrfs/discard.c                |   2 +-
 fs/btrfs/disk-io.c                |  55 +--
 fs/btrfs/extent-tree.c            |  18 +-
 fs/btrfs/extent_io.c              | 973 ++++++++++++++++++++++----------------
 fs/btrfs/extent_io.h              |  29 +-
 fs/btrfs/file-item.c              |   2 +-
 fs/btrfs/file.c                   |  44 +-
 fs/btrfs/free-space-cache.c       |   2 +-
 fs/btrfs/inode.c                  | 517 +++++++++++---------
 fs/btrfs/ioctl.c                  | 184 +++++--
 fs/btrfs/locking.c                |   4 +-
 fs/btrfs/ordered-data.c           | 253 +++++++---
 fs/btrfs/ordered-data.h           |  10 +-
 fs/btrfs/props.c                  |  16 +-
 fs/btrfs/qgroup.c                 |  10 +-
 fs/btrfs/reflink.c                |  14 +-
 fs/btrfs/relocation.c             |  75 ++-
 fs/btrfs/scrub.c                  | 159 +++++--
 fs/btrfs/send.c                   |  47 +-
 fs/btrfs/space-info.c             | 233 ++-------
 fs/btrfs/space-info.h             |  30 --
 fs/btrfs/subpage.c                | 155 +++++-
 fs/btrfs/subpage.h                |  33 +-
 fs/btrfs/super.c                  |  16 +-
 fs/btrfs/sysfs.c                  |  74 ++-
 fs/btrfs/tests/extent-map-tests.c |   2 +-
 fs/btrfs/transaction.c            |  61 +--
 fs/btrfs/transaction.h            |   6 +-
 fs/btrfs/tree-log.c               |  22 +-
 fs/btrfs/volumes.c                |  24 +-
 fs/btrfs/volumes.h                |   5 +-
 fs/btrfs/zoned.c                  |  43 +-
 fs/btrfs/zoned.h                  |   9 +
 include/trace/events/btrfs.h      |  23 +-
 include/uapi/linux/btrfs.h        |   4 +-
 include/uapi/linux/btrfs_tree.h   |   4 +-
 47 files changed, 2041 insertions(+), 1431 deletions(-)
