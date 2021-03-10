Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E8233384F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 10:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhCJJIp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 04:08:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:34580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231197AbhCJJIj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 04:08:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615367317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=00NbkdADRHZEG4x50rmSQa6D1CXCzlhZ6lN13FZfS0E=;
        b=C5+pZTziCLxHyw/BI3kRQf4se0ZhNbOS53khOsDu6KdNkrOTGe2KqPjBDSEy5MVGBf8Gvr
        kqIKWeimIz3pwc9Z7syNpl+i702HooQwf/o6u21OoHNSPMND0b1QvpOZ2x8ZkMdeXJd5b3
        f6XR04Qn030Nvofn2HXORb9/vdCyQ+I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BAAFCAE55
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Mar 2021 09:08:37 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/15] btrfs: support read-write for subpage metadata
Date:   Wed, 10 Mar 2021 17:08:18 +0800
Message-Id: <20210310090833.105015-1-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset can be fetched from the following github repo, along with
the full subpage RW support:
https://github.com/adam900710/linux/tree/subpage

This patchset is for metadata read write support.

[FULL RW TEST]
Since the data write path is not included in this patchset, we can't
really test the patchset itself, but anyone can grab the patch from
github repo and do fstests/generic tests.

There are some known issues:
- Very very rare random ASSERT() failure for data page::private
  It looks like we can lock a data page without page::private set for
  subpage.
  This problem seems to be caused some set_page_extent_mapped() callers
  are not holding the page locked, thus leaving a small window.
  Investigating.

- Defrag related test failure
  Since current defrag is doing per-page defrag, to support subpage
  defrag, we need some change in the loop.
  Thus for now, defrag is disabled completely for subpage RW mount.

- No compression support yet
  There are at least 2 known bugs if forcing compression for subpage
  * Some hard coded PAGE_SIZE screwing up space rsv
  * Subpage ASSERT() triggered
    This is because some compression code is unlocking locked_page by
    calling extent_clear_unlock_delalloc() with locked_page == NULL.
  So for now compression is also disabled.

[DIFFERENCE AGAINST REGULAR SECTORSIZE]
The metadata part in fact has more new code than data part, as it has
some different behaviors compared to the regular sector size handling:

- No more page locking
  Now metadata read/write relies on extent io tree locking, other than
  page locking.
  This is to allow behaviors like read lock one eb while also try to
  read lock another eb in the same page.
  We can't rely on page lock as now we have multiple extent buffers in
  the same page.

- Page status update
  Now we use subpage wrappers to handle page status update.

- How to submit dirty extent buffers
  Instead of just grabbing extent buffer from page::private, we need to
  iterate all dirty extent buffers in the page and submit them.

[CHANGELOG]
v2:
- Rebased to latest misc-next
  No conflicts at all.

- Add new sysfs interface to grab supported RO/RW sectorsize
  This will allow mkfs.btrfs to detect unmountable fs better.

- Use newer naming schema for each patch
  No more "extent_io:" or "inode:" schema anymore.

- Move two pure cleanups to the series
  Patch 2~3, originally in RW part.

- Fix one uninitialized variable
  Patch 6.

Qu Wenruo (15):
  btrfs: add sysfs interface for supported sectorsize
  btrfs: use min() to replace open-code in btrfs_invalidatepage()
  btrfs: remove unnecessary variable shadowing in btrfs_invalidatepage()
  btrfs: introduce helpers for subpage dirty status
  btrfs: introduce helpers for subpage writeback status
  btrfs: allow btree_set_page_dirty() to do more sanity check on subpage
    metadata
  btrfs: support subpage metadata csum calculation at write time
  btrfs: make alloc_extent_buffer() check subpage dirty bitmap
  btrfs: make the page uptodate assert to be subpage compatible
  btrfs: make set/clear_extent_buffer_dirty() to be subpage compatible
  btrfs: make set_btree_ioerr() accept extent buffer and to be subpage
    compatible
  btrfs: introduce end_bio_subpage_eb_writepage() function
  btrfs: introduce write_one_subpage_eb() function
  btrfs: make lock_extent_buffer_for_io() to be subpage compatible
  btrfs: introduce submit_eb_subpage() to submit a subpage metadata page

 fs/btrfs/disk-io.c   | 143 +++++++++++----
 fs/btrfs/extent_io.c | 420 ++++++++++++++++++++++++++++++++++++-------
 fs/btrfs/inode.c     |  14 +-
 fs/btrfs/subpage.c   |  73 ++++++++
 fs/btrfs/subpage.h   |  17 ++
 fs/btrfs/sysfs.c     |  34 ++++
 6 files changed, 598 insertions(+), 103 deletions(-)

-- 
2.30.1

