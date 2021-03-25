Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BC03489E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 08:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCYHPE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 03:15:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:36342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhCYHO7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 03:14:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616656498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=vlcE4Izu7HlbcZ0KUUxO8Q258zf+xkh8HCCLM64mPUM=;
        b=p0h9PQ0Tvu2vJnuNhtaSpwFTY7lSL3gP4dthMhZ8UMGvek0JrzdZWgE39Wf10U1XtyXJIQ
        ysPiiR9D57vxG0pU2kIZ92Iclxa99rAkX1547uVS9Qs9NXK3hDoxG/Os+p0udZ/oZMUaGT
        GsBBoVWUqX0kkvMuhMvTb0OWOSr7V1I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C646AA55
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Mar 2021 07:14:58 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Date:   Thu, 25 Mar 2021 15:14:32 +0800
Message-Id: <20210325071445.90896-1-wqu@suse.com>
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

But at least the full RW patchset can pass -g generic/quick -x defrag
for now.

There are some known issues:

- Defrag behavior change
  Since current defrag is doing per-page defrag, to support subpage
  defrag, we need some change in the loop.
  E.g. if a page has both hole and regular extents in it, then defrag
  will rewrite the full 64K page.

  Thus for now, defrag related failure is expected.
  But this should only cause behavior difference, no crash nor hang is
  expected.

- No compression support yet
  There are at least 2 known bugs if forcing compression for subpage
  * Some hard coded PAGE_SIZE screwing up space rsv
  * Subpage ASSERT() triggered
    This is because some compression code is unlocking locked_page by
    calling extent_clear_unlock_delalloc() with locked_page == NULL.
  So for now compression is also disabled.

- Inode nbytes mismatch
  Still debugging.
  The fastest way to trigger is fsx using the following parameters:

    fsx -l 262144 -o 65536 -S 30073 -N 256 -R -W $mnt/file > /tmp/fsx

  Which would cause inode nbytes differs from expected value and
  triggers btrfs check error.

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

v3:
- Rename the sysfs to supported_sectorsizes

- Rebased to latest misc-next branch
  This removes 2 cleanup patches.

- Add new overview comment for subpage metadata

Qu Wenruo (13):
  btrfs: add sysfs interface for supported sectorsize
  btrfs: use min() to replace open-code in btrfs_invalidatepage()
  btrfs: remove unnecessary variable shadowing in btrfs_invalidatepage()
  btrfs: refactor how we iterate ordered extent in
    btrfs_invalidatepage()
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
  btrfs: add subpage overview comments

 fs/btrfs/disk-io.c   | 143 ++++++++++++++++++++++++++++++++++---------
 fs/btrfs/extent_io.c | 127 ++++++++++++++++++++++++++++----------
 fs/btrfs/inode.c     | 128 ++++++++++++++++++++++----------------
 fs/btrfs/subpage.c   | 127 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/subpage.h   |  17 +++++
 fs/btrfs/sysfs.c     |  15 +++++
 6 files changed, 441 insertions(+), 116 deletions(-)

-- 
2.30.1

