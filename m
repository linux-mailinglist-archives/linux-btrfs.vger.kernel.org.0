Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF40586EF4
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Aug 2022 18:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiHAQpN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Aug 2022 12:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbiHAQpK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Aug 2022 12:45:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B74D3F33E;
        Mon,  1 Aug 2022 09:45:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 980CB34D05;
        Mon,  1 Aug 2022 16:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659372304;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=h1FPaNtDoMLR8I0S3Xn6v/cI6bw+T887GxXiutCKHuI=;
        b=k4thbluyv0ml23QMWNDYaEJvIWieDjXKVPqJ5nSqDzXwOLY5U9XKjFqGZ05eAGbOwBK56t
        gdKy1ns+qhzMuDj3cV2mJrU+X0FA5naW5e4Q4sAFz3UkyzrsBB2N+hVw94gsSEqN46Ijzr
        0zPCSsvDyW7RePODkBRmjp/h5i6Z/44=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5AA1013AAE;
        Mon,  1 Aug 2022 16:45:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2G8mFRAD6GJ1FgAAMHmgww
        (envelope-from <dsterba@suse.com>); Mon, 01 Aug 2022 16:45:04 +0000
Date:   Mon, 1 Aug 2022 18:40:03 +0200
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 5.20
Message-ID: <cover.1659357652.git.dsterba@suse.com>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, torvalds@linux-foundation.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

this update brings some long awaited changes, the send protocol bump,
otherwise lots of small improvements and fixes. The main core part is
reworking bio handling, cleaning up the submission and endio and
improving error handling.

There are some non-btrfs patches adding helpers or updating API,
listed at the end of the changelog.

Please pull, thanks.

Features:

- sysfs:
  - export chunk size, in debug mode add tunable for setting its size
  - show zoned among features (was only in debug mode)
  - show commit stats (number, last/max/total duration)

- send protocol updated to 2
  - new commands:
    - ability write larger data chunks than 64K
    - send raw compressed extents (uses the encoded data ioctls), ie. no
      decompression on send side, no compression needed on receive side
      if supported
    - send 'otime' (inode creation time) among other timestamps
    - send file attributes (a.k.a file flags and xflags)
  - this is first version bump, backward compatibility on send and
    receive side is provided
  - there are still some known and wanted commands that will be
    implemented in the near future, another version bump will be needed,
    however we want to minimize that to avoid causing usability issues

- print checksum type and implementation at mount time

- don't print some messages at mount (mentioned as people asked about
  it), we want to print messages namely for new features so let's make
  some space for that
  - big metadata - this has been supported for a long time and is not a
                   feature that's worth mentioning
  - skinny metadata - same reason, set by default by mkfs

Performance improvements:

- reduced amount of reserved metadata for delayed items
  - when inserted items can be batched into one leaf
  - when deleting batched directory index items
  - when deleting delayed items used for deletion
  - overall improved count of files/sec, decreased subvolume lock
    contention

- metadata item access bounds checker micro-optimized, with a few
  percent of improved runtime for metadata-heavy operations

- increase direct io limit for read to 256 sectors, improved throughput
  by 3x on sample workload

Notable fixes:

- raid56
  - reduce parity writes, skip sectors of stripe when there are no data
    updates
  - restore reading from stripe cache instead of triggering new read

- refuse to replay log with unknown incompat read-only feature bit set

- zoned
  - fix page locking when COW fails in the middle of allocation
  - improved tracking of active zones, ZNS drives may limit the number
    and there are ENOSPC errors due to that limit and not actual lack of
    space
  - adjust maximum extent size for zone append so it does not cause late
    ENOSPC due to underreservation

- mirror reading error messages show the mirror number

- don't fallback to buffered IO for NOWAIT direct IO writes, we don't
  have the NOWAIT semantics for buffered io yet

- send, fix sending link commands for existing file paths when there are
  deleted and created hardlinks for same files

- repair all mirrors for profiles with more than 1 copy (raid1c34)

- fix repair of compressed extents, unify where error detection and
  repair happen

Core changes:

- bio completion cleanups
  - don't double defer compression bios
  - simplify endio workqueues
  - add more data to btrfs_bio to avoid allocation for read requests
  - rework bio error handling so it's same what block layer does, the
    submission works and errors are consumed in endio
  - when asynchronous bio offload fails fall back to synchronous
    checksum calculation to avoid errors under writeback or memory
    pressure

- new trace points
  - raid56 events
  - ordered extent operations

- super block log_root_transid deprecated (never used)

- mixed_backref and big_metadata sysfs feature files removed, they've
  been default for sufficiently long time, there are no known users and
  mixed_backref could be confused with mixed_groups

Non-btrfs changes, API updates:

- minor highmem API update to cover const arguments

- switch all kmap/kmap_atomic to kmap_local

- remove redundant flush_dcache_page()

- address_space_operations::writepage callback removed

- add bdev_max_segments() helper

----------------------------------------------------------------
The following changes since commit e0dccc3b76fb35bb257b4118367a883073d7390e:

  Linux 5.19-rc8 (2022-07-24 13:26:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.20-tag

for you to fetch changes up to 0b078d9db8793b1bd911e97be854e3c964235c78:

  btrfs: don't call btrfs_page_set_checked in finish_compressed_bio_read (2022-07-25 19:56:16 +0200)

----------------------------------------------------------------
BingJing Chang (2):
      btrfs: send: introduce recorded_ref_alloc and recorded_ref_free
      btrfs: send: fix sending link commands for existing file paths

Christoph Hellwig (37):
      btrfs: factor out a helper to end a single sector buffer I/O
      btrfs: refactor end_bio_extent_readpage code flow
      btrfs: factor out a btrfs_csum_ptr helper
      btrfs: use btrfs_bio_for_each_sector in btrfs_check_read_dio_bio
      btrfs: move more work into btrfs_end_bioc
      btrfs: simplify code flow in btrfs_submit_dio_bio
      btrfs: split btrfs_submit_data_bio to read and write parts
      btrfs: defer I/O completion based on the btrfs_raid_bio
      btrfs: don't double-defer bio completions for compressed reads
      btrfs: don't use btrfs_bio_wq_end_io for compressed writes
      btrfs: centralize setting REQ_META
      btrfs: remove btrfs_end_io_wq
      btrfs: factor stripe submission logic out of btrfs_map_bio
      btrfs: do not allocate a btrfs_bio for low-level bios
      btrfs: don't use bio->bi_private to pass the inode to submit_one_bio
      btrfs: merge end_write_bio and flush_write_bio
      btrfs: pass the btrfs_bio_ctrl to submit_one_bio
      btrfs: stop looking at btrfs_bio->iter in index_one_bio
      btrfs: split discard handling out of btrfs_map_block
      btrfs: remove the finish_func argument to btrfs_mark_ordered_io_finished
      btrfs: increase direct io read size limit to 256 sectors
      btrfs: remove extent writepage address space operation
      btrfs: raid56: use fixed stripe length everywhere
      btrfs: do not return errors from btrfs_map_bio
      btrfs: do not return errors from raid56_parity_write
      btrfs: do not return errors from raid56_parity_recover
      btrfs: raid56: transfer the bio counter reference to the raid submission helpers
      btrfs: simplify sync/async submission in btrfs_submit_data_write_bio
      btrfs: handle allocation failure in btrfs_wq_submit_bio gracefully
      btrfs: do not return errors from btrfs_submit_dio_bio
      btrfs: merge btrfs_dev_stat_print_on_error with its only caller
      btrfs: repair all known bad mirrors
      btrfs: simplify the pending I/O counting in struct compressed_bio
      btrfs: pass a btrfs_bio to btrfs_repair_one_sector
      btrfs: remove the start argument to check_data_csum and export
      btrfs: fix repair of compressed extents
      btrfs: don't call btrfs_page_set_checked in finish_compressed_bio_read

David Sterba (30):
      btrfs: fix typos in comments
      btrfs: remove redundant calls to flush_dcache_page
      btrfs: remove redundant check in up check_setget_bounds
      btrfs: sysfs: advertise zoned support among features
      btrfs: open code rbtree search in split_state
      btrfs: open code rbtree search in insert_state
      btrfs: lift start and end parameters to callers of insert_state
      btrfs: pass bits by value not by pointer for extent_state helpers
      btrfs: add fast path for extent_state insertion
      btrfs: remove node and parent parameters from insert_state
      btrfs: open code inexact rbtree search in tree_search
      btrfs: make tree search for insert more generic and use it for tree_search
      btrfs: unify tree search helper returning prev and next nodes
      btrfs: call inode_to_path directly and drop indirection
      btrfs: simplify parameters of backref iterators
      btrfs: sink iterator parameter to btrfs_ioctl_logical_to_ino
      btrfs: remove unused typedefs get_extent_t and btrfs_work_func_t
      btrfs: send: drop __KERNEL__ ifdef from send.h
      btrfs: send: simplify includes
      btrfs: send: remove old TODO regarding ERESTARTSYS
      btrfs: send: use boolean types for current inode status
      btrfs: send: add OTIME as utimes attribute for proto 2+ by default
      btrfs: send: add new command FILEATTR for file attributes
      btrfs: print checksum type and implementation at mount time
      btrfs: use mask for all RAID1* profiles in btrfs_calc_avail_data_space
      btrfs: merge calculations for simple striped profiles in btrfs_rmap_block
      btrfs: clean up chained assignments
      btrfs: switch btrfs_block_rsv::full to bool
      btrfs: switch btrfs_block_rsv::failfast to bool
      btrfs: use enum for btrfs_block_rsv::type

Fabio M. De Francesco (7):
      btrfs: replace kmap() with kmap_local_page() in inode.c
      btrfs: replace kmap() with kmap_local_page() in lzo.c
      highmem: Make __kunmap_{local,atomic}() take const void pointer
      btrfs: zstd: replace kmap() with kmap_local_page()
      btrfs: zlib: replace kmap() with kmap_local_page() in zlib_compress_pages()
      btrfs: zlib: replace kmap() with kmap_local_page() in zlib_decompress_bio()
      btrfs: replace kmap_atomic() with kmap_local_page()

Fanjun Kong (1):
      btrfs: use PAGE_ALIGNED instead of IS_ALIGNED

Filipe Manana (18):
      btrfs: balance btree dirty pages and delayed items after a rename
      btrfs: free the path earlier when creating a new inode
      btrfs: balance btree dirty pages and delayed items after clone and dedupe
      btrfs: add assertions when deleting batches of delayed items
      btrfs: deal with deletion errors when deleting delayed items
      btrfs: refactor the delayed item deletion entry point
      btrfs: improve batch deletion of delayed dir index items
      btrfs: assert that delayed item is a dir index item when adding it
      btrfs: improve batch insertion of delayed dir index items
      btrfs: do not BUG_ON() on failure to reserve metadata for delayed item
      btrfs: set delayed item type when initializing it
      btrfs: reduce amount of reserved metadata for delayed item insertion
      btrfs: remove the inode cache check at btrfs_is_free_space_inode()
      btrfs: don't fallback to buffered IO for NOWAIT direct IO writes
      btrfs: set the objectid of the btree inode's location key
      btrfs: add optimized btrfs_ino() version for 64 bits systems
      btrfs: send: always use the rbtree based inode ref management infrastructure
      btrfs: join running log transaction when logging new name

Ioannis Angelakopoulos (2):
      btrfs: collect commit stats, count, duration
      btrfs: sysfs: export commit stats

Johannes Thumshirn (1):
      btrfs: add tracepoints for ordered extents

Josef Bacik (3):
      btrfs: do not batch insert non-consecutive dir indexes during log replay
      btrfs: tree-log: make the return value for log syncing consistent
      btrfs: reset block group chunk force if we have to wait

Naohiro Aota (17):
      btrfs: ensure pages are unlocked on cow_file_range() failure
      btrfs: extend btrfs_cleanup_ordered_extents for NULL locked_page
      btrfs: fix error handling of fallback uncompress write
      btrfs: replace unnecessary goto with direct return at cow_file_range()
      block: add bdev_max_segments() helper
      btrfs: zoned: revive max_zone_append_bytes
      btrfs: replace BTRFS_MAX_EXTENT_SIZE with fs_info->max_extent_size
      btrfs: convert count_max_extents() to use fs_info->max_extent_size
      btrfs: use fs_info->max_extent_size in get_extent_max_capacity()
      btrfs: let can_allocate_chunk return error
      btrfs: zoned: finish least available block group on data bg allocation
      btrfs: zoned: introduce space_info->active_total_bytes
      btrfs: zoned: disable metadata overcommit for zoned
      btrfs: zoned: activate metadata block group on flush_space
      btrfs: zoned: activate necessary block group
      btrfs: zoned: write out partially allocated region
      btrfs: zoned: wait until zone is finished when allocation didn't progress

Nikolay Borisov (9):
      btrfs: introduce btrfs_try_lock_balance
      btrfs: use btrfs_try_lock_balance in btrfs_ioctl_balance
      btrfs: batch up release of reserved metadata for delayed items used for deletion
      btrfs: properly flag filesystem with BTRFS_FEATURE_INCOMPAT_BIG_METADATA
      btrfs: don't print 'flagging with big metadata' anymore on mount
      btrfs: don't print 'has skinny extents' anymore on mount
      btrfs: sysfs: remove MIXED_BACKREF feature file
      btrfs: sysfs: remove BIG_METADATA feature files
      btrfs: simplify error handling in btrfs_lookup_dentry

Omar Sandoval (7):
      btrfs: send: remove unused send_ctx::{total,cmd}_send_size
      btrfs: send: explicitly number commands and attributes
      btrfs: send: add stream v2 definitions
      btrfs: send: write larger chunks when using stream v2
      btrfs: send: get send buffer pages for protocol v2
      btrfs: send: send compressed extents with encoded writes
      btrfs: send: enable support for stream v2 and compressed writes

Pankaj Raghav (1):
      btrfs: zoned: fix comment description for sb_write_pointer logic

Qu Wenruo (25):
      btrfs: quit early if the fs has no RAID56 support for raid56 related checks
      btrfs: introduce a data checksum checking helper
      btrfs: remove duplicated parameters from submit_data_read_repair()
      btrfs: add a helper to iterate through a btrfs_bio with sector sized chunks
      btrfs: use integrated bitmaps for btrfs_raid_bio::dbitmap and finish_pbitmap
      btrfs: use integrated bitmaps for scrub_parity::dbitmap and ebitmap
      btrfs: only write the sectors in the vertical stripe which has data stripes
      btrfs: update stripe_sectors::uptodate in steal_rbio
      btrfs: add trace event for submitted RAID56 bio
      btrfs: make btrfs_super_block::log_root_transid deprecated
      btrfs: reject log replay if there is unsupported RO compat flag
      btrfs: raid56: avoid double for loop inside finish_rmw()
      btrfs: raid56: avoid double for loop inside __raid56_parity_recover()
      btrfs: raid56: avoid double for loop inside alloc_rbio_essential_pages()
      btrfs: raid56: avoid double for loop inside raid56_rmw_stripe()
      btrfs: raid56: avoid double for loop inside raid56_parity_scrub_stripe()
      btrfs: remove parameter dev_extent_len from scrub_stripe()
      btrfs: use btrfs_chunk_max_errors() to replace tolerance calculation
      btrfs: use btrfs_raid_array to calculate number of parity stripes
      btrfs: use ncopies from btrfs_raid_array in btrfs_num_copies()
      btrfs: use named constant for reserved device space
      btrfs: warn about dev extents that are inside the reserved range
      btrfs: raid56: don't trust any cached sector in __raid56_parity_recover()
      btrfs: output mirror number for bad metadata
      btrfs: return proper mapped length for RAID56 profiles in __btrfs_map_block()

Stefan Roesch (3):
      btrfs: store chunk size in space-info struct
      btrfs: sysfs: export chunk size in space infos
      btrfs: sysfs: add force_chunk_alloc trigger to force allocation

 arch/parisc/include/asm/cacheflush.h |   6 +-
 arch/parisc/kernel/cache.c           |   2 +-
 fs/btrfs/async-thread.h              |   1 -
 fs/btrfs/backref.c                   |  88 ++--
 fs/btrfs/backref.h                   |   3 +-
 fs/btrfs/block-group.c               |  34 +-
 fs/btrfs/block-rsv.c                 |  21 +-
 fs/btrfs/block-rsv.h                 |  15 +-
 fs/btrfs/btrfs_inode.h               |  25 +-
 fs/btrfs/compression.c               | 359 ++++----------
 fs/btrfs/compression.h               |  18 +-
 fs/btrfs/ctree.h                     | 105 ++++-
 fs/btrfs/delalloc-space.c            |   6 +-
 fs/btrfs/delayed-inode.c             | 395 +++++++++++-----
 fs/btrfs/delayed-inode.h             |  11 +
 fs/btrfs/delayed-ref.c               |   4 +-
 fs/btrfs/dev-replace.c               |   3 +-
 fs/btrfs/disk-io.c                   | 268 ++++-------
 fs/btrfs/disk-io.h                   |  17 +-
 fs/btrfs/extent-tree.c               | 149 +++---
 fs/btrfs/extent_io.c                 | 873 ++++++++++++++++-------------------
 fs/btrfs/extent_io.h                 |  15 +-
 fs/btrfs/file.c                      |  29 +-
 fs/btrfs/free-space-cache.c          |   3 +-
 fs/btrfs/inode.c                     | 764 +++++++++++++++---------------
 fs/btrfs/ioctl.c                     | 150 +++---
 fs/btrfs/lzo.c                       |  28 +-
 fs/btrfs/ordered-data.c              |  40 +-
 fs/btrfs/ordered-data.h              |   5 +-
 fs/btrfs/raid56.c                    | 792 +++++++++++++++----------------
 fs/btrfs/raid56.h                    | 168 ++++++-
 fs/btrfs/reflink.c                   |  19 +-
 fs/btrfs/scrub.c                     |  71 ++-
 fs/btrfs/send.c                      | 781 +++++++++++++++++++++----------
 fs/btrfs/send.h                      | 169 ++++---
 fs/btrfs/space-info.c                | 110 ++++-
 fs/btrfs/space-info.h                |   8 +-
 fs/btrfs/struct-funcs.c              |  11 +-
 fs/btrfs/subpage.c                   |   4 +-
 fs/btrfs/super.c                     |  36 +-
 fs/btrfs/sysfs.c                     | 186 +++++++-
 fs/btrfs/tests/btrfs-tests.c         |   1 +
 fs/btrfs/tests/extent-buffer-tests.c |   3 +-
 fs/btrfs/transaction.c               |  26 +-
 fs/btrfs/tree-log.c                  |  29 +-
 fs/btrfs/tree-log.h                  |   3 +
 fs/btrfs/volumes.c                   | 362 +++++++--------
 fs/btrfs/volumes.h                   |  46 +-
 fs/btrfs/zlib.c                      |  42 +-
 fs/btrfs/zoned.c                     | 131 +++++-
 fs/btrfs/zoned.h                     |  18 +
 fs/btrfs/zstd.c                      |  33 +-
 include/linux/blkdev.h               |   5 +
 include/linux/highmem-internal.h     |  10 +-
 include/trace/events/btrfs.h         | 158 +++++++
 include/uapi/linux/btrfs.h           |  10 +-
 mm/highmem.c                         |   2 +-
 57 files changed, 3842 insertions(+), 2829 deletions(-)
