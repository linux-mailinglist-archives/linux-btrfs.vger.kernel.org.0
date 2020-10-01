Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F2327F932
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 07:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgJAF5x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 01:57:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:40030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730301AbgJAF5x (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 01:57:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601531871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JcJSDXQXYo1WycIARlLoi4LRa1XljdIHaK/Gy2ZmbD0=;
        b=KP3t1qXEOioieT9ZI47jLRYF1ptwZld6AnV/fzreT1P6/r+P8pebt7U8Wt5pXzAgQU/1d7
        yg3DOaEfwYnSZ9XfKD3UUJjE287GA07zApsjPxRbBOXZE9qChEB2snNrmni28RXkk2q2ya
        JIw7wdwFBc4Rp0S+MDGQ70UoS+Qg+D0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BF0A7B328
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Oct 2020 05:57:51 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 9 00/12] Introduce per-profile available space array to avoid over-confident can_overcommit()
Date:   Thu,  1 Oct 2020 13:57:32 +0800
Message-Id: <20201001055744.103261-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There are several bug reports of ENOSPC error in various locations.
Some of the most series case can't even start transaction for device
add.
This makes the fs mostly unusable, can only act as a cold storage, no
write is allowed any more.

[CAUSE]
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

[FIX]
To address this problem, here comes the per-profile available space
array, which gets updated every time a chunk get allocated/removed or a
device get grown or shrunk.

This provides a quick way for hotter place like can_overcommit() to grab
an estimation on how many bytes it can over-commit.

The per-profile available space calculation tries to keep the behavior
of chunk allocator, thus it can handle uneven disks pretty well.

And statfs() can also grab that pre-calculated value for instance usage.

Since this patch introduced a new failure pattern, some new error
handling are introduced:
- __btrfs_alloc_chunk()
  At the end of that function where calc_per_profile_avail() get called,
  if it failed due to -ENOMEM, we will revert device used space, and
  remove the allocated chunk and block group.

- btrfs_init_new_device()
- btrfs_remove_chunk()
  There is no good way to revert the change. So here we abort
  transaction, just like what the old error handling does.

- btrfs_grow_device()
  We need to revert device size to its old size.

- btrfs_shrink_device()
- btrfs_rm_device()
  This function already has good error handling, reuse it.

- btrfs_verify_dev_extents()
  Mount time error will lead to mount failure, nothing to worry about.

[PATCH CONTENT]
Patch 01~05:	Refactors and cleanups
Patch 06:	Introduce the needed cleanup function for error handling
Patch 07~12:	Implement the per-profile available space.

I have tested the patchset using error injection to verify the non-abort
error cases, and no obvious problem is reported by btrfs.
(In fact, there are several problems during error injection, but I just
 fixed them)

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

v7:
- Remove btrfs_calc_avail_data_space() completely
  Now we only need to grab the pre-calculated number, no need for a
  function over 100 lines.

- Keep the 0-avail-if-metadata-exhausted behavior
  Now it's handled by space_info->full, which indicates if we can
  allocate new chunks in metadata space info.
  We have no need to bother that now.

v8:
- Cosmetic changes
  * Comment fixes
  * Use rounddown() to replace one open-code
  * while() loop reformat
  * Remove one redundant 0-size check
  * Add one lockdep_assert() for calc_one_profile_avail()
  * Use atomic64_t to remove spinlock

- Add two more timing to call calc_per_profile_avail()
  * btrfs_rm_device()
  * btrfs_init_new_device()

v9:
- Rebased to v5.9-rc4
- More cleanup and refactors for properly reverting a newly created
  block group
- Do proper block group revert for chunk allocation failure case.
- Better patch split
  Now the implementation and added btrfs_update_per_profile_avail()
  calls are in separate patches.
  Allowing reviewers to exam each failure pattern.

Qu Wenruo (12):
  btrfs: block-group: cleanup btrfs_add_block_group_cache()
  btrfs: block-group: extra the code to delete block group from fs_info
    rb tree
  btrfs: block-group: make link_block_group() to handle avail alloc bits
  btrfs: block-group: extract the code to unlink block group from space
    info
  btrfs: space-info: update btrfs_update_space_info() to handle block
    group removal
  btrfs: block-group: introduce btrfs_revert_block_group()
  btrfs: volumes: introduce the device layout aware per-profile
    available space infrastructure
  btrfs: volumes: update per-profile available space at mount time
  btrfs: volumes: call btrfs_update_per_profile_avail() for chunk
    allocation and removal
  btrfs: volumes: update per-profile available space for device update
  btrfs: space-info: Use per-profile available space in can_overcommit()
  btrfs: statfs: Use pre-calculated per-profile available space

 fs/btrfs/block-group.c | 144 +++++++++++++----------
 fs/btrfs/block-group.h |   1 +
 fs/btrfs/space-info.c  |  70 ++++++++----
 fs/btrfs/space-info.h  |   4 +-
 fs/btrfs/super.c       | 131 ++-------------------
 fs/btrfs/volumes.c     | 251 ++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/volumes.h     |  10 ++
 7 files changed, 375 insertions(+), 236 deletions(-)

-- 
2.28.0

