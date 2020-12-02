Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E772CB53D
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 07:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgLBGtE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 01:49:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:53216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgLBGtE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 01:49:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606891697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zcZCmIq5pk9F4fVP9FNMc5jFhAVtuKPD1wUaKQw8jY0=;
        b=KWsslZArAL9BWyKjZv8oOugLrq2xnV0aIMVTHSDsnO/8lcNOpebBMj6gdQO4upDZfXkcud
        X/9X+wAzhDN22l0ojFF2FTw39RRhzUdU47F8ZvcCh/f7118y5WVGlCREw7edvS350Ussnl
        XXhSxm4ZbOktVmUydSowvqS3YOP1n38=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6DC31ABD2
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 06:48:17 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 00/15] btrfs: preparation patches for subpage support
Date:   Wed,  2 Dec 2020 14:47:56 +0800
Message-Id: <20201202064811.100688-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the rebased preparation branch for all patches not yet merged into
misc-next.

It can be fetched from github (with experimental sector aligned data write
support)
https://github.com/adam900710/linux/tree/subpage

This patchset includes all the unmerged preparation patches for subpage
support.

The patchset is sent without the main core for subpage support, as
myself has proven that, big patchset bombarding won't really make
reviewers happy, but only make the author happy (for a very short time).

Thanks for the hard work from David, there are only 15 patches unmerged.
(With 2 new small patches to address u32 u64 problem)

Patch 01~02:	bio_offset related fixes. Make bio_offset to be u32.
Patch 03:	Refactor metadata submission for later metadata write
		support.
Patch 04~08:	Metadata related refactor.
Patch 09~10:	Data related refactor
Patch 11~15:	Scrub related refactor and cleanup

For the scrub patch, there was a discussion with David, about whether we
should use sector size as the unit for metadata scrub.

His idea is, sector size should be the minimal unit for DATA, not
metadata. This indicates there is a undefined "minimal unit" of access.

But my argument is, sector size is the minimal unit for all btrfs
access, current btrfs has an undefined "data size", and that "data size"
must equal to sectorsize for current btrfs implementation.

Thus for "data size" < nodesize case, we should first add support for
"data size" > sectorsize first.

Thus I kept the scrub patch untouched, since IMHO sector size is still
the minimal unit to access, thus iterating using sectorsize is
completely sane.

Changelog:
v1:
- Separate prep patches from the huge subpage patchset

- Rebased to misc-next

- Add more commit message for patch "btrfs: extent_io: remove the
  extent_start/extent_len for end_bio_extent_readpage()"
  With one runtime example to explain why we are doing the same thing.

- Fix the assert_spin_lock() usage
  What we really want is lockdep_assert_held()

- Re-iterate the reason why some extent io tests are invalid
  This is especially important since later patches will reduce
  extent_buffer::pages[] to bare minimal, killing the ability to
  handle certain invalid extent buffers.

- Use sectorsize_bits for division
  During the convert, we should only use sectorsize_bits for division,
  this solves the hassle on 32bit system to do division.
  But we should not use sectorsize_bits no brain, as bit shift is not
  straight forward as multiple/division.

- Address the comments for btrfs_lookup_bio_sums() cleanup patchset
  From naming to macro usages, all of those comments should further
  improve the readability.

v2:
- Remove new extent_io tree features
  Now we won't utilize extent io tree for subpage support, thus new
  features along with some aggressive refactor is no longer needed.

- Reduce extent_io tree operations to reduce endio time latency
  Although extent_io tree can do a lot of things like page status, but
  it has obvious overhead, namingly search btree.
  So keep the original behavior by only calling extent_io operation in a
  big extent, to reduce latency

v3:
- Rebased to latest misc-next
  Now only 15 patches to submit.

- Add two new patches to address u32 and u64 problems
  The root problem is the on-disk format is abusing u64 for its length.
  We have to draw a line between where we should convert to u32.
  Currently for bio_offset and extent_len, we can safely use u32.
  Just to be extra safe, added more ASSERT() for this.

- Put BTRFS_MAX_METADATA_BLOCKSIZE into uapi
  To avoid circle including "ctree.h"

- Add more changelog for the patch enabling subpage scrub


Qu Wenruo (15):
  btrfs: rename bio_offset of extent_submit_bio_start_t to
    opt_file_offset
  btrfs: pass bio_offset to check_data_csum() directly
  btrfs: inode: make btrfs_verify_data_csum() follow sector size
  btrfs: extent_io: extract the btree page submission code into its own
    helper function
  btrfs: extent_io: calculate inline extent buffer page size based on
    page size
  btrfs: extent_io: don't allow tree block to cross page boundary for
    subpage support
  btrfs: extent_io: update num_extent_pages() to support subpage sized
    extent buffer
  btrfs: handle sectorsize < PAGE_SIZE case for extent buffer accessors
  btrfs: file-item: remove the btrfs_find_ordered_sum() call in
    btrfs_lookup_bio_sums()
  btrfs: file-item: refactor btrfs_lookup_bio_sums() to handle
    out-of-order bvecs
  btrfs: scrub: reduce the width for extent_len/stripe_len from 64 bits
    to 32 bits
  btrfs: scrub: always allocate one full page for one sector for RAID56
  btrfs: scrub: support subpage tree block scrub
  btrfs: scrub: support subpage data scrub
  btrfs: scrub: allow scrub to work with subpage sectorsize

 fs/btrfs/compression.c          |   5 +-
 fs/btrfs/ctree.c                |   3 +-
 fs/btrfs/ctree.h                |  48 ++++--
 fs/btrfs/disk-io.c              |  17 +-
 fs/btrfs/disk-io.h              |   2 +-
 fs/btrfs/extent_io.c            | 232 +++++++++++++++++-----------
 fs/btrfs/extent_io.h            |  18 ++-
 fs/btrfs/file-item.c            | 266 +++++++++++++++++++++-----------
 fs/btrfs/inode.c                |  61 +++++---
 fs/btrfs/ordered-data.c         |  44 ------
 fs/btrfs/ordered-data.h         |   2 -
 fs/btrfs/scrub.c                | 102 +++++++-----
 fs/btrfs/struct-funcs.c         |  18 ++-
 include/uapi/linux/btrfs_tree.h |   4 +
 14 files changed, 496 insertions(+), 326 deletions(-)

-- 
2.29.2

