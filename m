Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0972A4676
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgKCNbR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:31:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:44012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729043AbgKCNbQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:31:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Aoc3QAACpjClu47yL4ozSuCvp2B2eQjT2uXa6jI4Z2A=;
        b=l+TD5C6+twspKjFnqfHLV+E4sTZhI+haPdRREU81YAZzP7+9dnanCH6coyfzb7frIy3QcA
        VmNO9jGk1pM6bzpZzGKshBuDNiR9PDGgQRu6m7uNXkrYah48oUy+jn2bwZb5zoo3bOCPcU
        tYOI2Ajdbpq596QN1Oirve5wwPOeLUY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D510ACC0
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 13:31:15 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/32] btrfs: preparation patches for subpage support
Date:   Tue,  3 Nov 2020 21:30:36 +0800
Message-Id: <20201103133108.148112-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the rebased preparation branch for all patches not yet merged into
misc-next.
It can be fetched from github:
https://github.com/adam900710/linux/tree/subpage_prep_rebased

This patchset includes all the unmerged preparation patches for subpage
support.

The patchset is sent without the main core for subpage support, as
myself has proven that, big patchset bombarding won't really make
reviewers happy, but only make the author happy (for a very short time).

But we still got 32 patches for them, thus we still need a summary for
the patchset:

Patch 01~21:	Generic preparation patches.
		Mostly pave the way for metadata and data read.

Patch 22~24:	Recent btrfs_lookup_bio_sums() cleanup
		The most subpage unrelated patches, but still helps
		refactor related functions for incoming subpage support.

Patch 25~32:	Scrub support for subpage.
		Since scrub is completely unrelated to regular data/meta
 		read write, the scrub support for subpage can be
		implemented independently and easily.

Changelog:
v1:
- Separate prep patches from the huge subpage patchset

- Rebased to misc-next

- Add more commit message for patch "btrfs: extent_io: remove the
  extent_start/extent_len for end_bio_extent_readpage()"
  With one runtime example to explain why we are doing the same thing.

- Fix the assert_spin_lock() usage
  What we really want is lockdep_assert_held()

- Re-iterate the reason why some extent io tests are invalid
  This is especially important since later patches will reduce
  extent_buffer::pages[] to bare minimal, killing the ability to
  handle certain invalid extent buffers.

- Use sectorsize_bits for division
  During the convert, we should only use sectorsize_bits for division,
  this solves the hassle on 32bit system to do division.
  But we should not use sectorsize_bits no brain, as bit shift is not
  straight forward as multiple/division.

- Address the comments for btrfs_lookup_bio_sums() cleanup patchset
  From naming to macro usages, all of those comments should further
  improve the readability.

Qu Wenruo (32):
  btrfs: extent_io: remove the extent_start/extent_len for
    end_bio_extent_readpage()
  btrfs: extent_io: integrate page status update into
    endio_readpage_release_extent()
  btrfs: extent_io: add lockdep_assert_held() for
    attach_extent_buffer_page()
  btrfs: extent_io: extract the btree page submission code into its own
    helper function
  btrfs: extent-io-tests: remove invalid tests
  btrfs: extent_io: calculate inline extent buffer page size based on
    page size
  btrfs: extent_io: make btrfs_fs_info::buffer_radix to take sector size
    devided values
  btrfs: extent_io: sink less common parameters for __set_extent_bit()
  btrfs: extent_io: sink less common parameters for __clear_extent_bit()
  btrfs: disk_io: grab fs_info from extent_buffer::fs_info directly for
    btrfs_mark_buffer_dirty()
  btrfs: disk-io: make csum_tree_block() handle sectorsize smaller than
    page size
  btrfs: disk-io: extract the extent buffer verification from
    btrfs_validate_metadata_buffer()
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
  btrfs: file-item: use nodesize to determine whether we need readahead
    for btrfs_lookup_bio_sums()
  btrfs: file-item: remove the btrfs_find_ordered_sum() call in
    btrfs_lookup_bio_sums()
  btrfs: file-item: refactor btrfs_lookup_bio_sums() to handle
    out-of-order bvecs
  btrfs: scrub: distinguish scrub_page from regular page
  btrfs: scrub: remove the @force parameter of scrub_pages()
  btrfs: scrub: use flexible array for scrub_page::csums
  btrfs: scrub: refactor scrub_find_csum()
  btrfs: scrub: introduce scrub_page::page_len for subpage support
  btrfs: scrub: always allocate one full page for one sector for RAID56
  btrfs: scrub: support subpage tree block scrub
  btrfs: scrub: support subpage data scrub

 fs/btrfs/block-group.c           |   2 +-
 fs/btrfs/compression.c           |   5 +-
 fs/btrfs/ctree.c                 |   5 +-
 fs/btrfs/ctree.h                 |  45 ++-
 fs/btrfs/dev-replace.c           |   2 +-
 fs/btrfs/disk-io.c               |  98 ++++---
 fs/btrfs/extent-io-tree.h        |  88 ++++--
 fs/btrfs/extent-tree.c           |   2 +-
 fs/btrfs/extent_io.c             | 478 +++++++++++++++++++------------
 fs/btrfs/extent_io.h             |  21 +-
 fs/btrfs/extent_map.c            |   2 +-
 fs/btrfs/file-item.c             | 256 +++++++++++------
 fs/btrfs/free-space-cache.c      |   2 +-
 fs/btrfs/inode.c                 |  17 +-
 fs/btrfs/ordered-data.c          |  44 ---
 fs/btrfs/ordered-data.h          |   2 -
 fs/btrfs/relocation.c            |   2 +-
 fs/btrfs/scrub.c                 | 293 ++++++++++++-------
 fs/btrfs/struct-funcs.c          |  18 +-
 fs/btrfs/tests/extent-io-tests.c |  26 +-
 fs/btrfs/transaction.c           |   4 +-
 fs/btrfs/volumes.c               |   2 +-
 22 files changed, 870 insertions(+), 544 deletions(-)

-- 
2.29.2

