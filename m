Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FE72B1B58
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 13:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgKMMwA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 07:52:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:46350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgKMMv7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 07:51:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605271918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TGN5pQ5prfT9ZEigU+ObvaSEY5k5ZYdmHDbKAcN39xY=;
        b=nhcG/c3j3XMtgZea+1ZTgZS5+ksq+u9Ayawr2BxK4QYAuaNYJkFEnsh5lVcKgN0Rihytup
        RWXuCTL65Fv/R9JfDsfD7E6JAnjmo/EO3jSO72uHpo9GRMHve6B9YlTRQL/sFRJ9k0wrls
        7s6poCDVPNXhPTZov9XvGaHFEZUudYw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 47F6CABD6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 12:51:58 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/24] btrfs: preparation patches for subpage support
Date:   Fri, 13 Nov 2020 20:51:25 +0800
Message-Id: <20201113125149.140836-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the rebased preparation branch for all patches not yet merged into
misc-next.

It can be fetched from github (with RO mount support using page->private)
https://github.com/adam900710/linux/tree/subpage

This patchset includes all the unmerged preparation patches for subpage
support.

The patchset is sent without the main core for subpage support, as
myself has proven that, big patchset bombarding won't really make
reviewers happy, but only make the author happy (for a very short time).

Thanks for the hard work from David, there are only 24 patches unmerged.

Patch 01:	Special hotfix, for selftests. Should be folded into the
		offending patch.
Patch 02:	Fix to remove invalid test cases for 64K sector size.
Patch 03~08:	Refactors around endio functions (both data and
		metadata)
Patch 09~14:	Update metadata related handling to support subpage.
Patch 15:	Make extent io bits to be u32. (no longer utilized
		by later subpage, but the cleanup should still make
		sense)
Patch 16~18:	Refactor btrfs_lookup_bio_sums()
Patch 19~23:	Scrub support for subpage
		Since scrub is completely unrelated to regular data/meta
 		read write, the scrub support for subpage can be
		implemented independently and easily.
Patch 24:	Page->private related refactor, will be utilized by
		later subpage patches soon.

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

v2:
- Remove new extent_io tree features
  Now we won't utilize extent io tree for subpage support, thus new
  features along with some aggressive refactor is no longer needed.

- Reduce extent_io tree operations to reduce endio time latency
  Although extent_io tree can do a lot of things like page status, but
  it has obvious overhead, namingly search btree.
  So keep the original behavior by only calling extent_io operation in a
  big extent, to reduce latency


Qu Wenruo (24):
  btrfs: tests: fix free space tree test failure on 64K page system
  btrfs: extent-io-tests: remove invalid tests
  btrfs: extent_io: replace extent_start/extent_len with better
    structure for end_bio_extent_readpage()
  btrfs: extent_io: introduce helper to handle page status update in
    end_bio_extent_readpage()
  btrfs: extent_io: extract the btree page submission code into its own
    helper function
  btrfs: remove the phy_offset parameter for
    btrfs_validate_metadata_buffer()
  btrfs: pass bio_offset to check_data_csum() directly
  btrfs: inode: make btrfs_verify_data_csum() follow sector size
  btrfs: extent_io: calculate inline extent buffer page size based on
    page size
  btrfs: introduce a helper to determine if the sectorsize is smaller
    than PAGE_SIZE
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
  btrfs: scrub: remove the anonymous structure from scrub_page
  btrfs: scrub: always allocate one full page for one sector for RAID56
  btrfs: scrub: support subpage tree block scrub
  btrfs: scrub: support subpage data scrub
  btrfs: scrub: allow scrub to work with subpage sectorsize
  btrfs: extent_io: Use detach_page_private() for alloc_extent_buffer()

 fs/btrfs/compression.c           |   5 +-
 fs/btrfs/ctree.c                 |   5 +-
 fs/btrfs/ctree.h                 |  47 +++-
 fs/btrfs/disk-io.c               |   2 +-
 fs/btrfs/disk-io.h               |   2 +-
 fs/btrfs/extent-io-tree.h        |  33 +--
 fs/btrfs/extent_io.c             | 403 +++++++++++++++++++------------
 fs/btrfs/extent_io.h             |  21 +-
 fs/btrfs/file-item.c             | 259 +++++++++++++-------
 fs/btrfs/inode.c                 |  43 ++--
 fs/btrfs/ordered-data.c          |  44 ----
 fs/btrfs/ordered-data.h          |   2 -
 fs/btrfs/scrub.c                 |  57 +++--
 fs/btrfs/struct-funcs.c          |  18 +-
 fs/btrfs/tests/btrfs-tests.c     |   1 +
 fs/btrfs/tests/extent-io-tests.c |  26 +-
 16 files changed, 584 insertions(+), 384 deletions(-)

-- 
2.29.2

