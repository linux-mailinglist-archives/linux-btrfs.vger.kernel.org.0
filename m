Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3492260C6D
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 09:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgIHHwo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 03:52:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:50890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729414AbgIHHwo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Sep 2020 03:52:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05097AE24
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Sep 2020 07:52:43 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/17] btrfs: add read-only support for subpage sector size
Date:   Tue,  8 Sep 2020 15:52:13 +0800
Message-Id: <20200908075230.86856-1-wqu@suse.com>
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

- Introduce subpage_eb_mapping structure to do bitmap
  Now for subpage, page::private points to a subpage_eb_mapping
  structure, which has a bitmap to mapping one page to multiple extent
  buffers.

- Still do full page read for metadata
  This means, at read time, we're not reading just one extent buffer,
  but possibly many more.
  In that case, we first do tree block verification for the tree blocks
  triggering the read, and mark the page uptodate.

  For newly incoming tree block read, they will check if the tree block
  is verified. If not verified, even if the page is uptodate, we still
  need to check the extent buffer.

  By this all subpage extent buffers are verified properly.

For data part, it's pretty simple, all existing infrastructure can be
easily converted to support subpage read, without any subpage specific
handing yet.

== Patchset structure ==

The structure of the patchset:
Patch 01~11: Preparation patches for metadata subpage read support.
             These patches can be merged without problem, and work for
             both regular and subpage case.
Patch 12~14: Patches for data subpage read support.
             These patches works for both cases.

That means, patch 01~14 can be applied to current kernel, and shouldn't
affect any existing behavior.

Patch 15~17: Subpage metadata read specific patches.
             These patches introduces the main part of the subpage
             metadata read support.

The number of patches is the main reason I'm submitting them to the mail
list. As there are too many preparation patches already.

Qu Wenruo (17):
  btrfs: extent-io-tests: remove invalid tests
  btrfs: calculate inline extent buffer page size based on page size
  btrfs: remove the open-code to read disk-key
  btrfs: make btrfs_fs_info::buffer_radix to take sector size devided
    values
  btrfs: don't allow tree block to cross page boundary for subpage
    support
  btrfs: handle sectorsize < PAGE_SIZE case for extent buffer accessors
  btrfs: make csum_tree_block() handle sectorsize smaller than page size
  btrfs: refactor how we extract extent buffer from page for
    alloc_extent_buffer()
  btrfs: refactor btrfs_release_extent_buffer_pages()
  btrfs: add assert_spin_locked() for attach_extent_buffer_page()
  btrfs: extract the extent buffer verification from
    btree_readpage_end_io_hook()
  btrfs: remove the unnecessary parameter @start and @len for
    check_data_csum()
  btrfs: extent_io: only require sector size alignment for page read
  btrfs: make btrfs_readpage_end_io_hook() follow sector size
  btrfs: introduce subpage_eb_mapping for extent buffers
  btrfs: handle extent buffer verification proper for subpage size
  btrfs: allow RO mount of 4K sector size fs on 64K page system

 fs/btrfs/ctree.c                 |  13 +-
 fs/btrfs/ctree.h                 |  38 ++-
 fs/btrfs/disk-io.c               | 111 ++++---
 fs/btrfs/disk-io.h               |   1 +
 fs/btrfs/extent_io.c             | 538 +++++++++++++++++++++++++------
 fs/btrfs/extent_io.h             |  19 +-
 fs/btrfs/inode.c                 |  40 ++-
 fs/btrfs/struct-funcs.c          |  18 +-
 fs/btrfs/super.c                 |   7 +
 fs/btrfs/tests/extent-io-tests.c |  26 +-
 10 files changed, 633 insertions(+), 178 deletions(-)

-- 
2.28.0

