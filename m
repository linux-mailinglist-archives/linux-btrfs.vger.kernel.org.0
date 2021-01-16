Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462622F8BF7
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 08:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbhAPHQ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jan 2021 02:16:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:55930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbhAPHQ0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jan 2021 02:16:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610781339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=v1uX31JylcyH10KgcdpaM9TgSElpzyXobVIKxBYcwi4=;
        b=JRQMTyTXULEGeOOSndDredjylH1njJbA1uXaq3hdf9pkQca1k/Vz799HUhUmIX1b+NjMXl
        GACIZP8HfD2pBGoJk+ST/WhAXpZ1S8coyLcPdpCNVt7p0b53RHXyvH2rboLFC4lsqBrQiz
        Pcs6T99SZhfYd4Drb/Uak8zz+GKxPuU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E04DAB7A
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jan 2021 07:15:39 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 00/18] btrfs: add read-only support for subpage sector size
Date:   Sat, 16 Jan 2021 15:15:15 +0800
Message-Id: <20210116071533.105780-1-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patches can be fetched from github:
https://github.com/adam900710/linux/tree/subpage
Currently the branch also contains partial RW data support (still some
ordered extent and data csum mismatch problems)

Great thanks to David/Nikolay/Josef for their effort reviewing and
merging the preparation patches into misc-next.

=== What works ===

Just from the patchset:
- Data read
  Both regular and compressed data, with csum check.

- Metadata read

This means, with these patchset, 64K page systems can at least mount
btrfs with 4K sector size.

In the subpage branch
- Metadata read write and balance
  Not yet full tested due to data write still has bugs need to be
  solved.
  But considering that metadata operations from previous iteration
  is mostly untouched, metadata read write should be pretty stable.

- Data read write and balance
  Only uncompressed data writes. Fsstress can survive for around 5000
  ops and more.
  But still some random data csum error, and even more rare ordered
  extent related BUG_ON().
  Still invetigating.

=== Needs feedback ===
The following design needs extra comments:

- u16 bitmap
  As David mentioned, using u16 as bit map is not the fastest way.
  That's also why current bitmap code requires unsigned long (u32) as
  minimal unit.
  But using bitmap directly would double the memory usage.
  Thus the best way is to pack two u16 bitmap into one u32 bitmap, but
  that still needs extra investigation to find better practice.

  Anyway the skeleton should be pretty simple to expand.

- Separate handling for subpage metadata
  Currently the metadata read and (later write path) handles subpage
  metadata differently. Mostly due to the page locking must be skipped
  for subpage metadata.
  I tried several times to use as many common code as possible, but
  every time I ended up reverting back to current code.

  Thankfully, for data handling we will use the same common code.

- Incompatible subpage strcuture against iomap_page
  In btrfs we need extra bits than iomap_page.
  This is due to we need sector perfect write for data balance.
  E.g. if only one 4K sector is dirty in a 64K page, we should only
  write that dirty 4K back to disk, not the full 64K page.

  As data balance requires the new data extents to have exactly the
  same size as the original ones.
  This means, unless iomap_page get extra bits like what we're doing in
  btrfs for dirty, we can't merge the btrfs_subpage with iomap_page.

=== Patchset structure ===
Patch 01~02:	More RW preparation patches.
		This is to separate page lock/unlock from plain
		lock/unlock_page() call with __process_pages_contig().
		This makes more sense for subpage data write, but it
		also works for regular sector size.
Patch 03~12:	Subpage metadata allocation and freeing
Patch 13~15:	Subpage metadata read path
Patch 16~17:	Subpage data read path
Patch 18:	Enable subpage RO support

=== Changelog ===
v1:
- Separate the main implementation from previous huge patchset
  Huge patchset doesn't make much sense.

- Use bitmap implementation
  Now page::private will be a pointer to btrfs_subpage structure, which
  contains bitmaps for various page status.

v2:
- Use page::private as btrfs_subpage for extra info
  This replace old extent io tree based solution, which reduces latency
  and don't require memory allocation for its operations.

- Cherry-pick new preparation patches from RW development
  Those new preparation patches improves the readability by their own.

v3:
- Make dummy extent buffer to follow the same subpage accessors
  Fsstress exposed several ASSERT() for dummy extent buffers.
  It turns out we need to make dummy extent buffer to own the same
  btrfs_subpage structure to make eb accessors to work properly

- Two new small __process_pages_contig() related preparation patches
  One to make __process_pages_contig() to enhance the error handling
  path for locked_page, one to merge one macro.

- Extent buffers refs count update
  Except try_release_extent_buffer(), all other eb uses will try to
  increase the ref count of the eb.
  For try_release_extent_buffer(), the eb refs check will happen inside
  the rcu critical section to avoid eb being freed.

- Comment updates
  Addressing the comments from the mail list.

v4:
- Get rid of btrfs_subpage::tree_block_bitmap
  This is to reduce lock complexity (no need to bother extra subpage
  lock for metadata, all locks are existing locks)
  Now eb looking up mostly depends on radix tree, with small help from
  btrfs_subpage::under_alloc.
  Now I haven't experieneced metadata related problems any more during
  my local fsstress tests.

- Fix a race where metadata page dirty bit can race
  Fixed in the metadata RW patchset though.

- Rebased to latest misc-next branch
  With 4 patches removed, as they are already in misc-next.

Qu Wenruo (18):
  btrfs: update locked page dirty/writeback/error bits in
    __process_pages_contig()
  btrfs: merge PAGE_CLEAR_DIRTY and PAGE_SET_WRITEBACK into
    PAGE_START_WRITEBACK
  btrfs: introduce the skeleton of btrfs_subpage structure
  btrfs: make attach_extent_buffer_page() to handle subpage case
  btrfs: make grab_extent_buffer_from_page() to handle subpage case
  btrfs: support subpage for extent buffer page release
  btrfs: attach private to dummy extent buffer pages
  btrfs: introduce helper for subpage uptodate status
  btrfs: introduce helper for subpage error status
  btrfs: make set/clear_extent_buffer_uptodate() to support subpage size
  btrfs: make btrfs_clone_extent_buffer() to be subpage compatible
  btrfs: implement try_release_extent_buffer() for subpage metadata
    support
  btrfs: introduce read_extent_buffer_subpage()
  btrfs: extent_io: make endio_readpage_update_page_status() to handle
    subpage case
  btrfs: disk-io: introduce subpage metadata validation check
  btrfs: introduce btrfs_subpage for data inodes
  btrfs: integrate page status update for data read path into
    begin/end_page_read()
  btrfs: allow RO mount of 4K sector size fs on 64K page system

 fs/btrfs/Makefile           |   3 +-
 fs/btrfs/compression.c      |  10 +-
 fs/btrfs/disk-io.c          |  82 +++++-
 fs/btrfs/extent_io.c        | 520 +++++++++++++++++++++++++++++++-----
 fs/btrfs/extent_io.h        |  15 +-
 fs/btrfs/file.c             |  24 +-
 fs/btrfs/free-space-cache.c |  15 +-
 fs/btrfs/inode.c            |  40 ++-
 fs/btrfs/ioctl.c            |   5 +-
 fs/btrfs/reflink.c          |   5 +-
 fs/btrfs/relocation.c       |  12 +-
 fs/btrfs/subpage.c          |  39 +++
 fs/btrfs/subpage.h          | 263 ++++++++++++++++++
 fs/btrfs/super.c            |   7 +
 14 files changed, 920 insertions(+), 120 deletions(-)
 create mode 100644 fs/btrfs/subpage.c
 create mode 100644 fs/btrfs/subpage.h

-- 
2.30.0

