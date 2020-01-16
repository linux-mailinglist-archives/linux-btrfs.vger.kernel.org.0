Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEA013D411
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 07:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbgAPGEO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 01:04:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:45134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbgAPGEN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 01:04:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B20C1B1A3
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2020 06:04:11 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v6 0/4] Introduce per-profile available space array to avoid over-confident can_overcommit()
Date:   Thu, 16 Jan 2020 14:03:59 +0800
Message-Id: <20200116060404.95200-1-wqu@suse.com>
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

And statfs() can also grab that pre-calculated value for instance usage.
For metadata over-commit, statfs() falls back to factor based educated
guess method.
Since over-commit can only happen when we have unallocated space, the
problem caused by over-commit should only be a first world problem.

Since this patch introduced a new failure pattern, some new error
handling are introduced:
- __btrfs_alloc_chunk()
  At the end of that function where calc_per_profile_avail() get called,
  if it failed due to -ENOMEM, we will revert device used space, and
  remove the allocated chunk.
  This is the only new error handling added by patch 5.

- btrfs_remove_chunk()
  There is no good way to revert the change. So here we abort
  transaction, just like what the old error handling does.

- btrfs_grow_device()
  This function has its problem by not reverting device used space from
  the very beginning.
  This patchset will enhance it in patch 4.

- btrfs_shrink_device()
  This function already has good error handling, reuse it.

- btrfs_verify_dev_extents()
  Mount time error will lead to mount failure, nothing to worry about.

Contents of the patchset:
Patch 1:	Core facility, with basic (not perfect) error handling
Patch 2:	Fix for over-confident can_overcommit()
Patch 3:	Make statfs() more accurate
Patch 4:	Better error handling for btrfs_grow_device()
Patch 5:	Better error handling for __btrfs_alloc_chunk()

If needed, patch 4 and patch 5 can be merged into patch 1.

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

v3:
- Use proper chunk_mutex instead of device_list_mutex
  Since they are protecting two different things, and we only care about
  alloc_list, we should only use chunk_mutex.
  With improved lock situation, it's easier to fold
  calc_per_profile_available() calls into the first patch.

- Add performance benchmark for statfs() modification
  As Facebook seems to run into some problems with statfs() calls, add
  some basic ftrace results.

v4:
- Keep the lock-free design for statfs()
  As extra sleeping in statfs() may not be a good idea, keep the old
  lock-free design, and use factor based calculation as fall back.

v5:
- Enhance btrfs_update_device() error handling in btrfs_grow_device()
- Ensure all failure caused by calc_per_profile_available() is the same
  with existing error handling
- Fix a bug where chunk_mutex is not released in btrfs_shrink_device()

v6:
- Don't update the array if we hit any error.
  To avoid calling calc_per_profile_avail() in error handling path.

- Re-order the patchset
  Make the core facility the first patch.
  Error handling improvement in later patches.

- Add better error handling
  Improve one existing bad error handling, and provide a better solution
  for __btrfs_alloc_chunk()

Qu Wenruo (5):
  btrfs: Introduce per-profile available space facility
  btrfs: space-info: Use per-profile available space in can_overcommit()
  btrfs: statfs: Use pre-calculated per-profile available space
  btrfs: Reset device size when btrfs_update_device() failed in
    btrfs_grow_device()
  btrfs: volumes: Revert device used bytes when calc_per_profile_avail()
    failed

 fs/btrfs/space-info.c |  15 ++-
 fs/btrfs/super.c      | 182 +++++++++----------------------
 fs/btrfs/volumes.c    | 245 ++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/volumes.h    |  11 ++
 4 files changed, 290 insertions(+), 163 deletions(-)

-- 
2.24.1

