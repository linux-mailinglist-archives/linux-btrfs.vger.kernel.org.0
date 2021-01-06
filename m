Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC55E2EB74F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 02:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbhAFBCx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 20:02:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:45450 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbhAFBCw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 20:02:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609894925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5mSMTAOG2mBSdnGAtv+o0WUmYZNJGi4L/f8pZdfK2Os=;
        b=NaO4tcp6T96HNB/g+VbGlu6Z7dFVZ/F94E113Dsu6qlUtivm7cHthWp0V4xQqSeR1pR+pN
        bkNo9LFNgSub8t0J0V7xfkYYkcaRh35Mm8sA/2SAboC19oNBSp37v+DWAjCVSSYFv2JcND
        XMLcmXXJCLezU6W6N1q9C3tf8UQbKBQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 924A8ACAF
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jan 2021 01:02:05 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 00/22] btrfs: add read-only support for subpage sector size
Date:   Wed,  6 Jan 2021 09:01:39 +0800
Message-Id: <20210106010201.37864-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patches can be fetched from github:
https://github.com/adam900710/linux/tree/subpage
Currently the branch also contains partial RW data support (still some
out-of-sync subpage data page status).

Great thanks to David for his effort reviewing and merging the
preparation patches into misc-next.
Now all previously submitted preparation patches are already in
misc-next.

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

- Baisc data balance
  This is new.

- Data read write
  Only uncompressed data writes. Fsstress can survive.
  But still very rare data csum error, which only happens in bookend data
  extents (part of the data extent which is not referred by any file).
  This looks like something related to reflink/invalidate page and cow
  fixup.
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
Patch 01~03:	Existing preparation patches.
		Mostly readability related patches found during RW
		development
Patch 04~05:	New preparation patches.
		Mostly related to __process_pages_contig().
Patch 06~10:	Subpage handling for extent buffer allocation and
		freeing
Patch 11~22:	Subpage handling for extent buffer read path

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

Qu Wenruo (22):
  btrfs: extent_io: rename @offset parameter to @disk_bytenr for
    submit_extent_page()
  btrfs: extent_io: refactor __extent_writepage_io() to improve
    readability
  btrfs: file: update comment for btrfs_dirty_pages()
  btrfs: extent_io: update locked page dirty/writeback/error bits in
    __process_pages_contig()
  btrfs: extent_io: merge PAGE_CLEAR_DIRTY and PAGE_SET_WRITEBACK into
    PAGE_START_WRITEBACK
  btrfs: extent_io: introduce a helper to grab an existing extent buffer
    from a page
  btrfs: extent_io: introduce the skeleton of btrfs_subpage structure
  btrfs: extent_io: make attach_extent_buffer_page() to handle subpage
    case
  btrfs: extent_io: make grab_extent_buffer_from_page() to handle
    subpage case
  btrfs: extent_io: support subpage for extent buffer page release
  btrfs: extent_io: attach private to dummy extent buffer pages
  btrfs: subpage: introduce helper for subpage uptodate status
  btrfs: subpage: introduce helper for subpage error status
  btrfs: extent_io: make set/clear_extent_buffer_uptodate() to support
    subpage size
  btrfs: extent_io: make btrfs_clone_extent_buffer() to be subpage
    compatible
  btrfs: extent_io: implement try_release_extent_buffer() for subpage
    metadata support
  btrfs: extent_io: introduce read_extent_buffer_subpage()
  btrfs: extent_io: make endio_readpage_update_page_status() to handle
    subpage case
  btrfs: disk-io: introduce subpage metadata validation check
  btrfs: introduce btrfs_subpage for data inodes
  btrfs: integrate page status update for read path into
    begin/end_page_read()
  btrfs: allow RO mount of 4K sector size fs on 64K page system

 fs/btrfs/Makefile           |   3 +-
 fs/btrfs/compression.c      |  10 +-
 fs/btrfs/disk-io.c          |  82 +++++-
 fs/btrfs/extent_io.c        | 534 ++++++++++++++++++++++++++++--------
 fs/btrfs/extent_io.h        |  15 +-
 fs/btrfs/file.c             |  35 +--
 fs/btrfs/free-space-cache.c |  15 +-
 fs/btrfs/inode.c            |  40 ++-
 fs/btrfs/ioctl.c            |   5 +-
 fs/btrfs/reflink.c          |   5 +-
 fs/btrfs/relocation.c       |  12 +-
 fs/btrfs/subpage.c          |  39 +++
 fs/btrfs/subpage.h          | 256 +++++++++++++++++
 fs/btrfs/super.c            |   7 +
 14 files changed, 876 insertions(+), 182 deletions(-)
 create mode 100644 fs/btrfs/subpage.c
 create mode 100644 fs/btrfs/subpage.h

-- 
2.29.2

