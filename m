Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A5136014F
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhDOFFQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:05:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:36770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhDOFFQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:05:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=KQpDLVrM4dhyU11RwI62G10BavkQPCWF/xBdjhjChvg=;
        b=TMapbeJzCCIN5OmYfMmVYcBZ3A9WBuqIoAn9bVRobGV1nzWSCBy7NM+PmaXdhp3WFvfc7p
        hdVf8TRIlr5nogbuSEEUDHUCa3NkmtsacZ+2MVwlBDt39J5h+SOw/Gpoy13a5gyZ7cVfc2
        LDBvaMgs9oAw9hPnRp2nohB0FpzskYM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 755D4AF39
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:04:52 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/42] btrfs: add full read-write support for subpage
Date:   Thu, 15 Apr 2021 13:04:06 +0800
Message-Id: <20210415050448.267306-1-wqu@suse.com>
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

Although full fstests run needs to disable the warning message in
mkfs.btrfs, or it will cause too many false alerts.
The patch for mkfs.btrfs to use new sysfs interface to avoid such
behavior is under way.

But considering how slow my ARM boards are, I haven't run that many
loops.
So extra test will always help.

=== Limitation ===
There are several limitations introduced just for subpage:
- No compressed write support
  Read is no problem, but compression write path has more things left to
  be modified.
  Thus for current patchset, no matter what inode attribute or mount
  option is, no new compressed extent can be created for subpage case.

- No sector-sized defrag support
  Currently defrag is still done in PAGE_SIZE, meaning if there is a
  hole in a 64K page, we still write a full 64K back to disk.
  This causes more disk space usage.

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

=== Patchset structure ===

Patch 01~04:	The missing patches for metadata write path
		My bad, during previous submission I forgot them.
		No code change, just re-send.
Patch 05~08:	Cleanups and small refactors.
Patch 09~13:	Code refactors around btrfs_invalidate() and endio
		This is one critical part for subpage.
		Although this part has no subpage related code yet, just
		pure refactor.
Patch 14~15:	Refactor around __precess_pages_contig() for incoming
		subpage support.
--- Above are all refactors/cleanups ---
Patch 16~31:	The main part of subpage support
Patch 32~39:	Subpage code corner case fixes
--- Above is the main part of the subpage support ---
Patch 40:	Refactor submit_extent_page() for incoming subpage
		support.
		This refactor would also reduce the overhead for X86, as
		it removed the per-page boundary check, making the check
		only executed once for one bio.
Patch 41:	Make submit_extent_page() able to split large page to
		two bios. A subpage specific requirement.
Patch 42:	Enable subpage data write path.


Qu Wenruo (42):
  btrfs: introduce end_bio_subpage_eb_writepage() function
  btrfs: introduce write_one_subpage_eb() function
  btrfs: make lock_extent_buffer_for_io() to be subpage compatible
  btrfs: introduce submit_eb_subpage() to submit a subpage metadata page
  btrfs: remove the unused parameter @len for btrfs_bio_fits_in_stripe()
  btrfs: allow btrfs_bio_fits_in_stripe() to accept bio without any page
  btrfs: use u32 for length related members of btrfs_ordered_extent
  btrfs: pass btrfs_inode into btrfs_writepage_endio_finish_ordered()
  btrfs: refactor how we finish ordered extent io for endio functions
  btrfs: update the comments in btrfs_invalidatepage()
  btrfs: refactor btrfs_invalidatepage()
  btrfs: make Private2 lifespan more consistent
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
  btrfs: add extra assert for submit_extent_page()
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
  btrfs: make free space cache size consistent across different
    PAGE_SIZE
  btrfs: refactor submit_extent_page() to make bio and its flag tracing
    easier
  btrfs: allow submit_extent_page() to do bio split for subpage
  btrfs: allow read-write for 4K sectorsize on 64K page size systems

 fs/btrfs/block-group.c       |   18 +-
 fs/btrfs/compression.c       |    4 +-
 fs/btrfs/ctree.h             |   18 +-
 fs/btrfs/disk-io.c           |   13 +-
 fs/btrfs/extent_io.c         | 1053 +++++++++++++++++++++++++---------
 fs/btrfs/extent_io.h         |   15 +-
 fs/btrfs/file.c              |   19 +-
 fs/btrfs/inode.c             |  402 ++++++-------
 fs/btrfs/ioctl.c             |    7 +
 fs/btrfs/ordered-data.c      |  195 +++++--
 fs/btrfs/ordered-data.h      |   31 +-
 fs/btrfs/reflink.c           |   14 +-
 fs/btrfs/relocation.c        |  249 ++++----
 fs/btrfs/subpage.c           |  151 ++++-
 fs/btrfs/subpage.h           |   31 +
 fs/btrfs/super.c             |    7 -
 fs/btrfs/sysfs.c             |    5 +
 fs/btrfs/volumes.c           |    5 +-
 fs/btrfs/volumes.h           |    2 +-
 include/trace/events/btrfs.h |   19 +-
 20 files changed, 1553 insertions(+), 705 deletions(-)

-- 
2.31.1

