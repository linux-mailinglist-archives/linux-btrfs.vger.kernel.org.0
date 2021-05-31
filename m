Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40ABC395767
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 10:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhEaIwy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 04:52:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:40624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhEaIwv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 04:52:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622451070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Y+WiVb8lePfnN/Nxv9puXpOPZ7g6A9bb7KZqZz1FZEE=;
        b=MUwVB7mszcEQG3ewtmhRa3Ttxgw3x/81MFhUwpn8DPGQk19EXbDkMElVGFFLLZCLWuCPQ3
        ZsYdGuV3Oovn3D7I2EqhUKJ1rKGBa8r1esnIhtdruoDU78045LZ+4CQOVtPLbeYIM/IILi
        m92a1uAGd0EnfkLCWghTdZ5qqejlgtg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2BACB2E9
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 08:51:10 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 00/30] btrfs: add data write support for subpage
Date:   Mon, 31 May 2021 16:50:36 +0800
Message-Id: <20210531085106.259490-1-wqu@suse.com>
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

For btrfs test group, all pass except compression/raid56/defrag.

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

- No support for RAID56
  There are still too many hardcoded PAGE_SIZE in raid56 code.
  Considering it's already considered unsafe due to its write-hole
  problem, disabling RAID56 for subpage looks sane to me.

- No defrag support for subpage
  The support for subpage defrag has already an initial version
  submitted to the mail list.
  Thus the correct support won't be included in this patchset.

=== Patchset structure ===

Patch 01~19:	Make data write path to be subpage compatible
Patch 20~21:	Make data relocation path to be subpage compatible
Patch 22~29:	Various fixes for subpage corner cases
Patch 30:	Enable subpage data write

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

v3:
- Rebased to remove write path prepration patches

- Properly enable btrfs defrag
  Previsouly, btrfs defrag is in fact just disabled.
  This makes tons of tests in btrfs/defrag to fail.

- More bug fixes for rare race/crashes
  * Fix relocation false alert on csum mismatch
  * Fix relocation data corruption
  * Fix a rare case of false ASSERT()
    The fix already get merged into the prepration patches, thus no
    longer in this patchset though.
  
  Mostly reported by Ritesh from IBM.

v4:
- Disable subpage defrag completely
  As full page defrag can race with fsstress in btrfs/062, causing
  strange ordered extent bugs.
  The full subpage defrag will be submitted as an indepdent patchset.

Qu Wenruo (30):
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
  btrfs: allow submit_extent_page() to do bio split for subpage
  btrfs: reject raid5/6 fs for subpage
  btrfs: fix a crash caused by race between prepare_pages() and
    btrfs_releasepage()
  btrfs: fix a use-after-free bug in writeback subpage helper
  btrfs: fix a subpage false alert for relocating partial preallocated
    data extents
  btrfs: fix a subpage relocation data corruption
  btrfs: allow read-write for 4K sectorsize on 64K page size systems

 fs/btrfs/ctree.h        |   2 +-
 fs/btrfs/disk-io.c      |  13 +-
 fs/btrfs/extent_io.c    | 563 ++++++++++++++++++++++++++++------------
 fs/btrfs/file.c         |  32 ++-
 fs/btrfs/inode.c        | 147 +++++++++--
 fs/btrfs/ioctl.c        |   6 +
 fs/btrfs/ordered-data.c |   5 +-
 fs/btrfs/reflink.c      |  14 +-
 fs/btrfs/relocation.c   | 287 ++++++++++++--------
 fs/btrfs/subpage.c      | 156 ++++++++++-
 fs/btrfs/subpage.h      |  31 +++
 fs/btrfs/super.c        |   7 -
 fs/btrfs/sysfs.c        |   5 +
 fs/btrfs/volumes.c      |   8 +
 14 files changed, 949 insertions(+), 327 deletions(-)

-- 
2.31.1

