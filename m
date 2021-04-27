Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B0236CF11
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbhD0XEi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:04:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:36610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235395AbhD0XEi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:04:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Vt8P5iADZDo6B+g4/DH6cNTpAfctBcGBYEUxEg4y/Q4=;
        b=sKluMFb+JwqM9opuZ1TvUGeLJMHjISR555BWe3vw+QiyjpcillSbLF62BCqEboWv76o4ci
        Ya+P+uL4B3p8/FJf9zS3Fb/ymRr4hV2qx4s/CQRQTG9M3wrzcbfedJ4R5PrkVx0j3euGfo
        idri5G3graEVjRmK/kLdM6k2HCYmCA4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B1519ABED
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Apr 2021 23:03:53 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [Patch v2 00/42] btrfs: add data write support for subpage
Date:   Wed, 28 Apr 2021 07:03:07 +0800
Message-Id: <20210427230349.369603-1-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This huge patchset can be fetched from github:
https://github.com/adam900710/linux/tree/subpage

=== Current stage ===
The tests on x86 pass without new failure, and generic test group on
arm64 with 64K page size passes except known failure and defrag group.

For anyone who is interested in testing, please apply this patch for
btrfs-progs before testing.
https://patchwork.kernel.org/project/linux-btrfs/patch/20210420073036.243715-1-wqu@suse.com/
Or there will be too many false alerts.

=== Limitation ===
There are several limitations introduced just for subpage:
- No compressed write support
  Read is no problem, but compression write path has more things left to
  be modified.
  Thus for current patchset, no matter what inode attribute or mount
  option is, no new compressed extent can be created for subpage case.

- No inline extent will be created
  This is mostly due to the fact that filemap_fdatawrite_range() will
  trigger more write than the range specified.
  In fallocate calls, this behavior can make us to writeback which can
  be inlined, before we enlarge the isize, causing inline extent being
  created along with regular extents.

- No sector size base repair for read-time data repair
  Btrfs supports repair for corrupted data at read time.
  But for current subpage repair, the unit is bvec, which can var from
  4K to 64K.
  If one data extent is only 4K sized, then we can do the repair in 4K size.
  But if the extent size grows, then the repair size grows until it
  reaches 64K.
  This behavior can be later enhanced by introducing a bitmap for
  corrupted blocks.

- No support for RAID56
  There are still too many hardcoded PAGE_SIZE in raid56 code.
  Considering it's already considered unsafe due to its write-hole
  problem, disabling RAID56 for subpage looks sane to me.

- No sector-sized defrag support
  Currently defrag is still done in PAGE_SIZE, meaning if there is a
  hole in a 64K page, we still write a full 64K back to disk.
  This causes more disk space usage.

=== Patchset structure ===

Patch 01~02:	hardcoded PAGE_SIZE related fixes
Patch 03~05:	submit_extent_page() refactor which will reduce overhead
		for write path.
		This should benefit 4K page the most. Although the
		primary objective is just to make the code easier to
		read.
Patch 06:	Cleanup for metadata writepath, to reduce the impact on
		regular sectorsize path.
Patch 07~13:	PagePrivate2 and ordered extent related refactor.
		Although it's still a refactor, the refactor is pretty
		important for subpage data write path, as for subpage we
		could have btrfs_writepage_endio_finish_ordered() call
		across several sectors, which may or may not have
		ordered extent for those sectors.

^^^ Above patches are all subpage data write preparation ^^^

Patch 14~32:	Make data write path to be subpage compatible
Patch 33~34:	Make data relocation path to be subpage compatible
Patch 35~41:	Subpage specific fixes/workarounds for various corner cases
Patch 42:	Enable subpage data write

=== Changelog ===
v2:
- Rebased to latest misc-next
  Now metadata write patches are removed from the series, as they are
  already merged into misc-next.

- Added new Reviewed-by/Tested-by/Reported-by tags

- Use separate endio functions to subpage metadata write path

- Re-order the patches, to make refactors at the top of the series
  One refactor, the submit_extent_page() one, should benefit 4K page
  size more than 64K page size, thus it's worthy to be merged early

- New bug fixes exposed by Ritesh Harjani on Power

- Reject RAID56 completely
  Exposed by btrfs test group, which caused BUG_ON() for various sites.
  Considering RAID56 is already not considered safe, it's better to
  reject them completely for now.

- Fix subpage scrub repair failure
  Caused by hardcoded PAGE_SIZE

- Fix free space cache inode size
  Same cause as scrub repair failure

Qu Wenruo (42):
  btrfs: scrub: fix subpage scrub repair error caused by hardcoded
    PAGE_SIZE
  btrfs: make free space cache size consistent across different
    PAGE_SIZE
  btrfs: remove the unused parameter @len for btrfs_bio_fits_in_stripe()
  btrfs: allow btrfs_bio_fits_in_stripe() to accept bio without any page
  btrfs: refactor submit_extent_page() to make bio and its flag tracing
    easier
  btrfs: make subpage metadata write path to call its own endio
    functions
  btrfs: pass btrfs_inode into btrfs_writepage_endio_finish_ordered()
  btrfs: make Private2 lifespan more consistent
  btrfs: refactor how we finish ordered extent io for endio functions
  btrfs: update the comments in btrfs_invalidatepage()
  btrfs: introduce btrfs_lookup_first_ordered_range()
  btrfs: refactor btrfs_invalidatepage()
  btrfs: rename PagePrivate2 to PageOrdered inside btrfs
  btrfs: pass bytenr directly to __process_pages_contig()
  btrfs: refactor the page status update into process_one_page()
  btrfs: provide btrfs_page_clamp_*() helpers
  btrfs: only require sector size alignment for
    end_bio_extent_writepage()
  btrfs: make btrfs_dirty_pages() to be subpage compatible
  btrfs: make __process_pages_contig() to handle subpage
    dirty/error/writeback status
  btrfs: make end_bio_extent_writepage() to be subpage compatible
  btrfs: make process_one_page() to handle subpage locking
  btrfs: introduce helpers for subpage ordered status
  btrfs: make page Ordered bit to be subpage compatible
  btrfs: update locked page dirty/writeback/error bits in
    __process_pages_contig
  btrfs: prevent extent_clear_unlock_delalloc() to unlock page not
    locked by __process_pages_contig()
  btrfs: make btrfs_set_range_writeback() subpage compatible
  btrfs: make __extent_writepage_io() only submit dirty range for
    subpage
  btrfs: make btrfs_truncate_block() to be subpage compatible
  btrfs: make btrfs_page_mkwrite() to be subpage compatible
  btrfs: reflink: make copy_inline_to_page() to be subpage compatible
  btrfs: fix the filemap_range_has_page() call in
    btrfs_punch_hole_lock_range()
  btrfs: don't clear page extent mapped if we're not invalidating the
    full page
  btrfs: extract relocation page read and dirty part into its own
    function
  btrfs: make relocate_one_page() to handle subpage case
  btrfs: fix wild subpage writeback which does not have ordered extent.
  btrfs: disable inline extent creation for subpage
  btrfs: skip validation for subpage read repair
  btrfs: allow submit_extent_page() to do bio split for subpage
  btrfs: reject raid5/6 fs for subpage
  btrfs: fix a crash caused by race between prepare_pages() and
    btrfs_releasepage()
  btrfs: fix the use-after-free bug in writeback subpage helper
  btrfs: allow read-write for 4K sectorsize on 64K page size systems

 fs/btrfs/block-group.c       |  18 +-
 fs/btrfs/compression.c       |   4 +-
 fs/btrfs/ctree.h             |  18 +-
 fs/btrfs/disk-io.c           |  13 +-
 fs/btrfs/extent_io.c         | 840 +++++++++++++++++++++++------------
 fs/btrfs/extent_io.h         |  15 +-
 fs/btrfs/file.c              |  31 +-
 fs/btrfs/inode.c             | 396 +++++++++--------
 fs/btrfs/ioctl.c             |   7 +
 fs/btrfs/ordered-data.c      | 252 ++++++++---
 fs/btrfs/ordered-data.h      |  11 +-
 fs/btrfs/reflink.c           |  14 +-
 fs/btrfs/relocation.c        | 249 ++++++-----
 fs/btrfs/scrub.c             |  80 ++--
 fs/btrfs/subpage.c           | 155 ++++++-
 fs/btrfs/subpage.h           |  31 ++
 fs/btrfs/super.c             |   7 -
 fs/btrfs/sysfs.c             |   5 +
 fs/btrfs/volumes.c           |   5 +-
 fs/btrfs/volumes.h           |   2 +-
 include/trace/events/btrfs.h |  19 +-
 21 files changed, 1440 insertions(+), 732 deletions(-)

-- 
2.31.1

