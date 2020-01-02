Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8E7912E5A3
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 12:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgABL1x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 06:27:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:42506 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbgABL1x (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 06:27:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 873B3AB7F
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jan 2020 11:27:51 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] Introduce per-profile available space array to avoid over-confident can_overcommit()
Date:   Thu,  2 Jan 2020 19:27:42 +0800
Message-Id: <20200102112746.145045-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are several bug reports of ENOSPC error in
btrfs_run_delalloc_range().

With some extra info from one reporter, it turns out that
can_overcommit() is using a wrong way to calculate allocatable metadata
space.

The most typical case would look like:
  devid 1 unallocated:	1G
  devid 2 unallocated:  10G
  metadata profile:	RAID1

In above case, we can at most allocate 1G chunk for metadata, due to
unbalanced disk free space.
But current can_overcommit() uses factor based calculation, which never
consider the disk free space balance.


To address this problem, here comes the per-profile available space
array, which gets updated every time a chunk get allocated/removed or a
device get grown or shrunk.

This provides a quick way for hotter place like can_overcommit() to grab
an estimation on how many bytes it can over-commit.

The per-profile available space calculation tries to keep the behavior
of chunk allocator, thus it can handle uneven disks pretty well.

Although per-profile is not clever enough to handle estimation when both
data and metadata chunks need to be considered, its virtual chunk
infrastructure is flex enough to handle such case.

So for statfs(), we also re-use virtual chunk allocator to handle
available data space, with metadata over-commit space considered.
This brings an unexpected advantage, now we can handle RAID5/6 pretty OK
in statfs().

Changelog:
v1:
- Fix a bug where we forgot to update per-profile array after allocating
  a chunk.
  To avoid ABBA deadlock, this introduce a small windows at the end
  __btrfs_alloc_chunk(), it's not elegant but should be good enough
  before we rework chunk and device list mutex.
  
- Make statfs() to use virtual chunk allocator to do better estimation
  Now statfs() can report not only more accurate result, but can also
  handle RAID5/6 better.

v2:
- Fix a deadlock caused by acquiring device_list_mutex under
  __btrfs_alloc_chunk()
  There is no need to acquire device_list_mutex when holding
  chunk_mutex.
  Fix it and remove the lockdep assert.

Qu Wenruo (4):
  btrfs: Introduce per-profile available space facility
  btrfs: Update per-profile available space when device size/used space
    get updated
  btrfs: space-info: Use per-profile available space in can_overcommit()
  btrfs: statfs: Use virtual chunk allocation to calculation available
    data space

 fs/btrfs/space-info.c |  15 ++-
 fs/btrfs/super.c      | 190 +++++++++++++-----------------------
 fs/btrfs/volumes.c    | 218 ++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/volumes.h    |  14 +++
 4 files changed, 288 insertions(+), 149 deletions(-)

-- 
2.24.1

