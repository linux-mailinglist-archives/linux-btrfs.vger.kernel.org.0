Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C009530466A
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 19:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbhAZRW6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 12:22:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:54270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390244AbhAZIex (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 03:34:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611650046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xIe/SwwOriTqLUR2ISzoOm0mObVWoBrmAJUYyKHgxqU=;
        b=suLehiakYxTCtHn3SCkOWb62MyoPQkprEkBzlJE33BkCCcBvwQWppmv/Iz90K08ZU8DFPY
        ZA9xPu5MOmcX0XTaDcEHNvCNKqNNu+3WS7g0P4WVO+yv/SmfVaEbojoa8F4SfFzEwDWnu3
        3fb6wb1sjlsQUAqXdd18rNR0JPXSbRY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 46BBCAC4F
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 08:34:06 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 00/18] btrfs: add read-only support for subpage sector size
Date:   Tue, 26 Jan 2021 16:33:44 +0800
Message-Id: <20210126083402.142577-1-wqu@suse.com>
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
btrfs with 4K sector size read-only.
This should provide the ability to migrate data at least.

While on the github branch, there are already experimental RW supports,
there are still ordered extent related bugs for me to fix.
Thus only the RO part is sent for review and testing.

=== Patchset structure ===
Patch 01~02:	Preparation patches which don't have functional change
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

v5:
- Use the updated version from David as base
  Most comment/commit message update should be kept as is.

- A new separate patch to move UNMAPPED bit set timing

- New comment on why we need to prealloc subpage inside a loop
  Mostly for further 16K page size support, where we can have
  eb across multiple pages.

- Remove one patch which is too RW specific
  Since it introduces functional change which only makes sense for RW
  support, it's not a good idea to include it in RO support.

- Error handling fixes
  Great thanks to Josef.

- Refactor btrfs_subpage allocation/freeing
  Now we have btrfs_alloc_subpage() and btrfs_free_subpage() helpers to
  do all the allocation/freeing.
  It's pretty easy to convert to kmem_cache using above helpers.
  (already internally tested using kmem_cache without problem, in fact
   it's all the problems found in kmem_cache test leads to the new
   interface)

- Use btrfs_subpage::eb_refs to replace old under_alloc
  This makes checking whether the page has any eb left much easier.

Qu Wenruo (18):
  btrfs: merge PAGE_CLEAR_DIRTY and PAGE_SET_WRITEBACK to
    PAGE_START_WRITEBACK
  btrfs: set UNMAPPED bit early in btrfs_clone_extent_buffer() for
    subpage support
  btrfs: introduce the skeleton of btrfs_subpage structure
  btrfs: make attach_extent_buffer_page() handle subpage case
  btrfs: make grab_extent_buffer_from_page() handle subpage case
  btrfs: support subpage for extent buffer page release
  btrfs: attach private to dummy extent buffer pages
  btrfs: introduce helpers for subpage uptodate status
  btrfs: introduce helpers for subpage error status
  btrfs: support subpage in set/clear_extent_buffer_uptodate()
  btrfs: support subpage in btrfs_clone_extent_buffer
  btrfs: support subpage in try_release_extent_buffer()
  btrfs: introduce read_extent_buffer_subpage()
  btrfs: support subpage in endio_readpage_update_page_status()
  btrfs: introduce subpage metadata validation check
  btrfs: introduce btrfs_subpage for data inodes
  btrfs: integrate page status update for data read path into
    begin/end_page_read()
  btrfs: allow RO mount of 4K sector size fs on 64K page system

 fs/btrfs/Makefile           |   3 +-
 fs/btrfs/compression.c      |  10 +-
 fs/btrfs/disk-io.c          |  81 +++++-
 fs/btrfs/extent_io.c        | 485 ++++++++++++++++++++++++++++++++----
 fs/btrfs/extent_io.h        |  15 +-
 fs/btrfs/file.c             |  24 +-
 fs/btrfs/free-space-cache.c |  15 +-
 fs/btrfs/inode.c            |  42 ++--
 fs/btrfs/ioctl.c            |   8 +-
 fs/btrfs/reflink.c          |   5 +-
 fs/btrfs/relocation.c       |  11 +-
 fs/btrfs/subpage.c          | 278 +++++++++++++++++++++
 fs/btrfs/subpage.h          |  92 +++++++
 fs/btrfs/super.c            |   8 +-
 14 files changed, 964 insertions(+), 113 deletions(-)
 create mode 100644 fs/btrfs/subpage.c
 create mode 100644 fs/btrfs/subpage.h

-- 
2.30.0

