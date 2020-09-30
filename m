Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BF927DDF8
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgI3Bzq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:55:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:49500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbgI3Bzp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:55:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601430943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2JZdHrk+dtWqlm1fmEH+avAmixzRyAdbeel8J+jmzA8=;
        b=VZ033oJBHnUpClbACOPWkol5P3W2TjimYsor0Gj1U9Yl8SIHwTNQ2ebiqv3w+w9JYA5Pls
        qIypBjKqxrOunEuPQol7ac2fR28xznY9w7pqXhw5kt82Hyvt4RuvIEkoZba7uxoX/+91em
        3HXCzK4JBcxOLB5B4CRDrhtVjAtWxMA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B7B34AE07
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:55:43 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 00/49] btrfs: add partial rw support for subpage sector size
Date:   Wed, 30 Sep 2020 09:54:50 +0800
Message-Id: <20200930015539.48867-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patches can be fetched from github:
https://github.com/adam900710/linux/tree/subpage

Currently btrfs only allows to mount fs with sectorsize == PAGE_SIZE.

That means, for 64K page size system, they can only use 64K sector size
fs.
This brings a big compatibility problem for btrfs.

This patch is going to slightly solve the problem by, allowing 64K
system to mount 4K sectorsize fs in metadata read-write mode.
Data write is not ensured to work yet.

The main objective here, is to remove the blockage in the code base, and
pave the road to full RW mount support.

== What works ==

Existing regular page sized sector size support
Subpage read-only Mount (with all self tests and ASSERT)
Subpage metadata read write (including all trees and inline extents, and csum checking)
Subpage data read (both compressed and uncompressed, with csum checking)

== What doesn't work ==

Subpage data write (neither compressed nor uncompressed)

Thus no full fstests yet.

== Challenge we meet ==

The main here problem is metadata, where we have several limitations:
- We always read the full page of a metadata
  In subpage case, one full page can contain several tree blocks.

- We use page::private to point to extent buffer
  This means we currently can only support one-page-to-one-extent-buffer
  mapping.
  For subpage size support, we need one-page-to-multiple-extent-buffer
  mapping.

But still, we have some challenge in data too.
- No EXTENT_* bits for certain page status
  The main example is Private2.

== Solutions ==

So here for the metadata part, we use the following methods to
workaround the problem:

- Rely on extent_io_tree more for metadata status/locking
  Now for subpage metadata, page::private is never utilized. It always
  points to NULL.

  The page status is updated according to the extent_io_tree now.
  E.g. if we have any extent marked EXTENT_DIRTY, then the page covering
  the range will be marked DIRTY.
  While only all extent ranges are UPTODATE, and no hole in the range,
  then the page will be UPTODATE.

  Current utilized bits for metadata btree are:
  * EXTENT_UPTODATE
    Similar to PageUptodate(), needs all range covered by the page to be
    UPTODATE.

  * EXTENT_DIRTY
    Similar to PageDirty(), any dirty extent will mark the page dirty.

  * EXTENT_WRITEBACK
    Similar to PageWriteback(), any extent under writeback will mark the
    page writeback.

  * EXTENT_LOCKED
    Similar to PageLocked(), however the locking sequence is different
    for subpage. We lock page first, then lock all ebs in the page
    for subpage. For regular sector size, we lock the eb, then
    lock all pages belongs to the eb.

- Do subpage read for metadata
  Now we do proper subpage read for both data and metadata.
  For metadata we never merge bio for adjacent tree blocks, but always
  submit one bio for one tree block.
  This allows us to do proper verification for each tree blocks.

- Do mergable subpage write for metadata
  We submit extent buffer in its nodesize, but still allow them to be
  merged.

For data part, we just convert the existing csum/read code to do proper
subpage check.

But now, we are at the crossroad for data write support.
We can either:
- Go iomap directly
  Iomap supports subpage, but I'm not yet sure how they support that.
  (Per-page bitmap? Or something similar to btrfs extent_io_tree?
   And how many call backs from btrfs is needed?)

- Go current direction
  I guess this would cause less problem, and less dependency.
  But the iomap seems to be the ultimate solution, thus even we go this
  way, we still need to go iomap one day.

Anyway, I'll still go extent_io_tree for data write and at least make it
able to run fstests.

== Patchset structure ==

This patchset is so big that even I tried my best to re-order the
patchset, it can still have some questionable order for the cleanups.

Anyway, the main priority is:
- Bug fix
  Obviously

- Subpage independent refactors
  Such refactors makes sense no matter if we support subpage or not.

- Subpage related but still independent refactors
  Those refactors makes more sense if we support subpage.
  But still it doesn't affect existing behavior

- Subpage specific code
  Most of these code will be a subroutine for existing code, thus they
  shouldn't change the existing behavior.
  But really only make sense for subpage usage.

So the patchset structure is:
Patch 01~04:	Small bug fixes found during the development.
Patch 05~17:	Mostly independent refactors
Pathc 18~26:	Refactors leans more towards subpage, but still makes
		sense for regular sector size case.
Patch 27~49:	Subpage specific code

Changelog:
v2:
- Migrating to extent_io_tree based status/locking mechanism
  This gets rid of the ad-hoc subpage_eb_mapping structure and extra
  timing to verify the extent buffers.

  This also brings some extra cleanups for btree inode extent io tree
  hooks which makes no sense for both subpage and regular sector size.

  This also completely removes the requirement for page status like
  Locked/Uptodate/Dirty. Now metadata pages only utilize Private status,
  while private pointer is always NULL.

- Submit proper subpage sized read for metadata
  With the help of extent io tree, we no longer need to bother full page
  read. Now submit subpage sized metadata read and do subpage locking.

- Remove some unnecessary refactors
  Some refactors like extracting detach_extent_buffer_pages() doesn't
  really make the code cleaner. We can easily add subpage specific
  branch.

- Address the comments from v1

v3:
- Add compressed data read fix

- Also update page status according to extent status for btree inode
  This makes us to reuse more code from the existing code base.

- Add metadata write support
  Only manually tested (with a fs created under x86_64, and script to do
  metadata only operations under aarch64 with 64K page size).

- More cleanup/refactors during metadata write support development.

Goldwyn Rodrigues (1):
  btrfs: use iosize while reading compressed pages

Qu Wenruo (48):
  btrfs: extent-io-tests: remove invalid tests
  btrfs: extent_io: fix the comment on lock_extent_buffer_for_io().
  btrfs: extent_io: update the comment for find_first_extent_bit()
  btrfs: make btree inode io_tree has its special owner
  btrfs: disk-io: replace @fs_info and @private_data with @inode for
    btrfs_wq_submit_bio()
  btrfs: inode: sink parameter @start and @len for check_data_csum()
  btrfs: extent_io: unexport extent_invalidatepage()
  btrfs: extent_io: remove the forward declaration and rename
    __process_pages_contig
  btrfs: extent_io: rename pages_locked in process_pages_contig()
  btrfs: extent_io: make process_pages_contig() to accept bytenr
    directly
  btrfs: extent_io: only require sector size alignment for page read
  btrfs: extent_io: remove the extent_start/extent_len for
    end_bio_extent_readpage()
  btrfs: extent_io: integrate page status update into
    endio_readpage_release_extent()
  btrfs: extent_io: rename page_size to io_size in submit_extent_page()
  btrfs: extent_io: add assert_spin_locked() for
    attach_extent_buffer_page()
  btrfs: extent_io: extract the btree page submission code into its own
    helper function
  btrfs: extent_io: calculate inline extent buffer page size based on
    page size
  btrfs: extent_io: make btrfs_fs_info::buffer_radix to take sector size
    devided values
  btrfs: disk_io: grab fs_info from extent_buffer::fs_info directly for
    btrfs_mark_buffer_dirty()
  btrfs: disk-io: make csum_tree_block() handle sectorsize smaller than
    page size
  btrfs: disk-io: extract the extent buffer verification from
    btree_readpage_end_io_hook()
  btrfs: disk-io: accept bvec directly for csum_dirty_buffer()
  btrfs: inode: make btrfs_readpage_end_io_hook() follow sector size
  btrfs: introduce a helper to determine if the sectorsize is smaller
    than PAGE_SIZE
  btrfs: extent_io: allow find_first_extent_bit() to find a range with
    exact bits match
  btrfs: extent_io: don't allow tree block to cross page boundary for
    subpage support
  btrfs: extent_io: update num_extent_pages() to support subpage sized
    extent buffer
  btrfs: handle sectorsize < PAGE_SIZE case for extent buffer accessors
  btrfs: disk-io: only clear EXTENT_LOCK bit for extent_invalidatepage()
  btrfs: extent-io: make type of extent_state::state to be at least 32
    bits
  btrfs: extent_io: use extent_io_tree to handle subpage extent buffer
    allocation
  btrfs: extent_io: make set/clear_extent_buffer_uptodate() to support
    subpage size
  btrfs: extent_io: make the assert test on page uptodate able to handle
    subpage
  btrfs: extent_io: implement subpage metadata read and its endio
    function
  btrfs: extent_io: implement try_release_extent_buffer() for subpage
    metadata support
  btrfs: set btree inode track_uptodate for subpage support
  btrfs: allow RO mount of 4K sector size fs on 64K page system
  btrfs: disk-io: allow btree_set_page_dirty() to do more sanity check
    on subpage metadata
  btrfs: disk-io: support subpage metadata csum calculation at write
    time
  btrfs: extent_io: prevent extent_state from being merged for btree io
    tree
  btrfs: extent_io: make set_extent_buffer_dirty() to support subpage
    sized metadata
  btrfs: extent_io: add subpage support for clear_extent_buffer_dirty()
  btrfs: extent_io: make set_btree_ioerr() accept extent buffer
  btrfs: extent_io: introduce write_one_subpage_eb() function
  btrfs: extent_io: make lock_extent_buffer_for_io() subpage compatible
  btrfs: extent_io: introduce submit_btree_subpage() to submit a page
    for subpage metadata write
  btrfs: extent_io: introduce end_bio_subpage_eb_writepage() function
  btrfs: support metadata read write for test

 fs/btrfs/block-group.c           |    2 +-
 fs/btrfs/btrfs_inode.h           |   12 +
 fs/btrfs/ctree.c                 |    5 +-
 fs/btrfs/ctree.h                 |   43 +-
 fs/btrfs/disk-io.c               |  425 +++++++--
 fs/btrfs/disk-io.h               |    8 +-
 fs/btrfs/extent-io-tree.h        |   58 +-
 fs/btrfs/extent-tree.c           |    2 +-
 fs/btrfs/extent_io.c             | 1403 ++++++++++++++++++++++--------
 fs/btrfs/extent_io.h             |   27 +-
 fs/btrfs/file.c                  |    4 +
 fs/btrfs/free-space-cache.c      |    2 +-
 fs/btrfs/inode.c                 |   61 +-
 fs/btrfs/relocation.c            |    2 +-
 fs/btrfs/struct-funcs.c          |   18 +-
 fs/btrfs/tests/extent-io-tests.c |   26 +-
 fs/btrfs/transaction.c           |    4 +-
 fs/btrfs/volumes.c               |    2 +-
 include/trace/events/btrfs.h     |    1 +
 19 files changed, 1562 insertions(+), 543 deletions(-)

-- 
2.28.0

