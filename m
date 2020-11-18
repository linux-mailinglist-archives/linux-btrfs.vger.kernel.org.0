Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F642B798F
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 09:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgKRIx0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 03:53:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:47480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgKRIx0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 03:53:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605689604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=FgA5IIMlnVYmKpb3+RCVZllKUCaBEtaLPtFi2qJcxW0=;
        b=sO7bbK6idF9e4i64tc9mLBgEs28P4FteeUyb8LY5wyGutjLdGZ1OsKA8t0MrzQTJGkBm6E
        h8XxQiOPQgIhNBnFwZI6nI38hj6JkOkh5os+lE1BJdKmNXYpAn4qelAa2c8TTr7dCv+URt
        y3krFtHqeAqk8Kn7sjl0Fh2isANXhYA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9F095ABF4
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Nov 2020 08:53:24 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v1 00/14] btrfs: add read-only support for subpage sector size
Date:   Wed, 18 Nov 2020 16:53:05 +0800
Message-Id: <20201118085319.56668-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patches can be fetched from github:
https://github.com/adam900710/linux/tree/subpage
Currently the branch also contains RW metadata support (partly tested).
The schedule is when a milestone (for this case, metadata RW)is mostly
finishes, send out previous milestone (metadata RO) for review.

Please note that, due to the following reasons, please don't expect patches
can be applies without conflicts or checkpatch warning:

- Ongoing development
  Since the development is still ongoing, the rebase is not that
  frequent.
  So until the development calms down, just don't complain about the
  checkpatch/conflicts.

- Slow full kernel compile
  Even with cross distcc, it will still take tens of minutes to compile
  the full kernel.
  Not to mention the new regressions from current cycle affecting my
  aarch64 environment.
  (regulator regression screwing up all RK3399 boards, lockdep bugs).

- Stupid checkpatch script
  ` if (PAGE_SIZE == SZ_64K && ) {}. `
  Above check will be handled at compile time as both macros are fixed
  value, but checkpatch can't detect that and always want the user to
  put the fixed value to the right of the "==".

- Dependency on previous patches
  This patchset is mainly focus on the read-only implementation.
  The prep patches are sent in previous patchset.

== What works ==

Existing regular page sized sector size support
Subpage read-only Mount (with all self tests and ASSERT)
Subpage metadata read (including all trees and inline extents, and csum checking)
Subpage compressed/uncompressed data read (with csum checking)

== What doesn't work ==

Read-write mount (see the subject)

=== Need feedback ===
The following points need feedback from the community:

- The error handling for page::private memory allocation
  This introduces new failure patterns. And the iomap code is not a good
  example either (just uses __NOFAIL, and skip NULL check).

- Whether to use helpers for various bitmap operations
  Almost all patches have some bitmap based operation to update patch
  status. All of them have some patterns but not completely the same.
  Thus I'm not sure whether it's a good idea to introduce a helper.

- u16 vs u32 bitmap
  Currently subpage support only needs 16 bits for it operations.
  But all the bitmap operations uses 32 bits.

  This means:
  * Extra memory just get wasted
    Memory usage for each bitmap get doubled.
  * Ugly way to check if a range has its bits all set
    Currently we need to we need to define a temporary
    bitmap, set the temporary bitmap, then call bitmap_subset().
    If use u16 directly, we can use bit and and to do it more easily.

- Should we handle subpage and regular sector size case separately?
  Handling them separately makes the existing behavior untouched, thus
  mostly regression free. But this bloats the code obviously.

  Unifying to subpage would cause obvious memory overhead, and obviously
  regression for 4K page systems.

  Currently I prefer to trade code complexity for 4K regression free.

=== Changelog ===
v1:
- Separate the main implementation from previous huge patchset
  Huge patchset doesn't make much sense.

- Use bitmap implementation
  Now page::private will be a pointer to btrfs_subpage structure, which
  contains bitmaps for various page status.


Qu Wenruo (14):
  btrfs: extent_io: Use detach_page_private() for alloc_extent_buffer()
  btrfs: extent_io: introduce a helper to grab an existing extent buffer
    from a page
  btrfs: extent_io: introduce the skeleton of btrfs_subpage structure
  btrfs: extent_io: make attach_extent_buffer_page() to handle subpage
    case
  btrfs: extent_io: make grab_extent_buffer_from_page() to handle
    subpage case
  btrfs: extent_io: support subpage for extent buffer page release
  btrfs: extent_io: make set/clear_extent_buffer_uptodate() to support
    subpage size
  btrfs: extent_io: implement try_release_extent_buffer()  for subpage
    metadata support
  btrfs: extent_io: introduce read_extent_buffer_subpage()
  btrfs: extent_io: make endio_readpage_update_page_status() to handle
    subpage case
  btrfs: disk-io: introduce subpage metadata validation check
  btrfs: introduce btrfs_subpage for data inodes
  btrfs: integrate page status update for read path into
    begin/end_page_read()
  btrfs: allow RO mount of 4K sector size fs on 64K page system

 fs/btrfs/compression.c      |  10 +-
 fs/btrfs/disk-io.c          | 107 ++++++-
 fs/btrfs/extent_io.c        | 566 +++++++++++++++++++++++++++++++-----
 fs/btrfs/extent_io.h        |  14 +-
 fs/btrfs/file.c             |  10 +-
 fs/btrfs/free-space-cache.c |  15 +-
 fs/btrfs/inode.c            |  12 +-
 fs/btrfs/ioctl.c            |   5 +-
 fs/btrfs/reflink.c          |   5 +-
 fs/btrfs/relocation.c       |  12 +-
 fs/btrfs/super.c            |   7 +
 11 files changed, 666 insertions(+), 97 deletions(-)

-- 
2.29.2

