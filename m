Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E77269DD5
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 07:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgIOFfi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 01:35:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:42936 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgIOFfh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 01:35:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6889AC98
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Sep 2020 05:35:51 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/19] btrfs: add read-only support for subpage sector size
Date:   Tue, 15 Sep 2020 13:35:13 +0800
Message-Id: <20200915053532.63279-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patches can be fetched from github:
https://github.com/adam900710/linux/tree/subpage

Currently btrfs only allows to mount fs with sectorsize == PAGE_SIZE.

That means, for 64K page size system, they can only use 64K sector size
fs.
This brings a big compatible problem for btrfs.

This patch is going to slightly solve the problem by, allowing 64K
system to mount 4K sectorsize fs in read-only mode.

The main objective here, is to remove the blockage in the code base, and
pave the road to full RW mount support.

== What works ==

Existing regular page sized sector size support
Subpage read-only Mount (with all self tests and ASSERT)
Subpage metadata read (including all trees and inline extents, and csum checking)
Subpage uncompressed data read (with csum checking)

== What doesn't work ==

Read-write mount (see the subject)
Compressed data read

== Challenge we meet ==

The main problem is metadata, where we have several limitations:
- We always read the full page of a metadata
  In subpage case, one full page can contain several tree blocks.

- We use page::private to point to extent buffer
  This means we currently can only support one-page-to-one-extent-buffer
  mapping.
  For subpage size support, we need one-page-to-multiple-extent-buffer
  mapping.


== Solutions ==

So here for the metadata part, we use the following methods to
workaround the problem:

- Completely rely on extent_io_tree for metadata status/locking
  Now for subpage metadata, page::private is never utilized. It always
  points to NULL.
  And we only utilize private page status, other status
  (locked/uptodate/dirty/...) are all ignored.

  Instead, page lock is replayed by EXTENT_LOCK of extent_io_tree.
  Page uptodate is replaced by EXTENT_UPTODATE of extent_io_tree.
  And if a range has extent buffer is represented by EXTENT_NEW.

  This provides the full potential for later RW support.

- Do subpage read for metadata
  Now we do proper subpage read for both data and metadata.
  For metadata we never merge bio for adjacent tree blocks, but always
  submit one bio for one tree block.
  This allows us to do proper verification for each tree blocks.

For data part, it's pretty simple, all existing infrastructure can be
easily converted to support subpage read, without any subpage specific
handing yet.

== Patchset structure ==

The structure of the patchset:
Patch 01~15: Preparation patches for data and metadata subpage read support.
             These patches can be merged without problem, and work for
             both regular and subpage case.
	     This part can conflict with Nikolay's latest cleanup, but
	     the conflicts should be pretty controllable.

Patch 16~19: Patches for metadata subpage read support.
	     The main part of the patchset. It converts metadata to
	     purely extent_io_tree based solution for subpage read.

	     In theory, page sized routine can also be converted to
	     extent_io_tree. But that would be another topic in the
	     future.

The number of patches is the main reason I'm submitting them to the mail
list. As there are too many preparation patches already.

Qu Wenruo (19):
  btrfs: extent-io-tests: remove invalid tests
  btrfs: remove the unnecessary parameter @start and @len for
    check_data_csum()
  btrfs: calculate inline extent buffer page size based on page size
  btrfs: remove the open-code to read disk-key
  btrfs: make btrfs_fs_info::buffer_radix to take sector size devided
    values
  btrfs: don't allow tree block to cross page boundary for subpage
    support
  btrfs: update num_extent_pages() to support subpage sized extent
    buffer
  btrfs: handle sectorsize < PAGE_SIZE case for extent buffer accessors
  btrfs: make csum_tree_block() handle sectorsize smaller than page size
  btrfs: add assert_spin_locked() for attach_extent_buffer_page()
  btrfs: extract the extent buffer verification from
    btree_readpage_end_io_hook()
  btrfs: extent_io: only require sector size alignment for page read
  btrfs: make btrfs_readpage_end_io_hook() follow sector size
  btrfs: make btree inode io_tree has its special owner
  btrfs: don't set extent_io_tree bits for btree inode at endio time
  btrfs: use extent_io_tree to handle subpage extent buffer allocation
  btrfs: implement subpage metadata read and its endio function
  btrfs: implement btree_readpage() and try_release_extent_buffer() for
    subpage
  btrfs: allow RO mount of 4K sector size fs on 64K page system

 fs/btrfs/btrfs_inode.h           |  12 +
 fs/btrfs/ctree.c                 |  13 +-
 fs/btrfs/ctree.h                 |  38 +++-
 fs/btrfs/disk-io.c               | 217 ++++++++++++++----
 fs/btrfs/extent-io-tree.h        |   8 +
 fs/btrfs/extent_io.c             | 376 +++++++++++++++++++++++++++----
 fs/btrfs/extent_io.h             |  19 +-
 fs/btrfs/inode.c                 |  40 +++-
 fs/btrfs/ordered-data.c          |   8 +
 fs/btrfs/qgroup.c                |   4 +
 fs/btrfs/struct-funcs.c          |  18 +-
 fs/btrfs/super.c                 |   7 +
 fs/btrfs/tests/extent-io-tests.c |  26 +--
 13 files changed, 642 insertions(+), 144 deletions(-)

-- 
2.28.0

