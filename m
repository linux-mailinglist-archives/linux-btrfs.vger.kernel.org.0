Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42E22D53F0
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 07:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgLJGj4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 01:39:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:44088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgLJGjz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 01:39:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607582349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pRHgvXvarDWzPgc+sd9pK8lPxwpDjmDjCzlEw7D3Kr0=;
        b=cKOrcG/85ndDJWZzUu6r+0kEGueOYSim3a7w9KdnMq52tTH70IpwJQeGtasFCLcEP55WFN
        6hUXOf0FbhXq8OLljlRv4E1g9j5h8W5BQI5V19pdE4mWSppELOsLUPHwGVJuQDLROGXXxD
        9LpS7Xx6YYlH6JXl6h0ICE7p2eloqDU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0BF0EAC28
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 06:39:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/18] btrfs: add read-only support for subpage sector size
Date:   Thu, 10 Dec 2020 14:38:47 +0800
Message-Id: <20201210063905.75727-1-wqu@suse.com>
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
- Metadata read write
  Not yet full tested due to data write still has bugs need to be
  solved.
  But considering that metadata operations from previous iteration
  is mostly untouched, metadata read write should be pretty stable.

- Data read write
  WIP. There are fsstress runs which leads to subpage dirty
  status out-of-sync and cause some ordered extent never finish.
  Still fixing it.

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

=== Patchset structure ===
Patch 01~03:	New preparation patches.
		Mostly readability related patches found during RW
		development
Patch 04~08:	Subpage handling for extent buffer allocation and
		freeing
Patch 09~18:	Subpage handling for extent buffer read path

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

Qu Wenruo (18):
  btrfs: extent_io: rename @offset parameter to @disk_bytenr for
    submit_extent_page()
  btrfs: extent_io: refactor __extent_writepage_io() to improve
    readability
  btrfs: file: update comment for btrfs_dirty_pages()
  btrfs: extent_io: introduce a helper to grab an existing extent buffer
    from a page
  btrfs: extent_io: introduce the skeleton of btrfs_subpage structure
  btrfs: extent_io: make attach_extent_buffer_page() to handle subpage
    case
  btrfs: extent_io: make grab_extent_buffer_from_page() to handle
    subpage case
  btrfs: extent_io: support subpage for extent buffer page release
  btrfs: subpage: introduce helper for subpage uptodate status
  btrfs: subpage: introduce helper for subpage error status
  btrfs: extent_io: make set/clear_extent_buffer_uptodate() to support
    subpage size
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
 fs/btrfs/disk-io.c          | 107 +++++++-
 fs/btrfs/extent_io.c        | 507 ++++++++++++++++++++++++++++--------
 fs/btrfs/extent_io.h        |   3 +-
 fs/btrfs/file.c             |  25 +-
 fs/btrfs/free-space-cache.c |  15 +-
 fs/btrfs/inode.c            |  12 +-
 fs/btrfs/ioctl.c            |   5 +-
 fs/btrfs/reflink.c          |   5 +-
 fs/btrfs/relocation.c       |  12 +-
 fs/btrfs/subpage.c          |  34 +++
 fs/btrfs/subpage.h          | 264 +++++++++++++++++++
 fs/btrfs/super.c            |   7 +
 14 files changed, 876 insertions(+), 133 deletions(-)
 create mode 100644 fs/btrfs/subpage.c
 create mode 100644 fs/btrfs/subpage.h

-- 
2.29.2

