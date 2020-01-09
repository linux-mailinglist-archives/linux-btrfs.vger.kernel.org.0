Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11FF513539A
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 08:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgAIHQt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 02:16:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:60424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbgAIHQs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jan 2020 02:16:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 65161AC65
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2020 07:16:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 0/4] Introduce per-profile available space array to avoid over-confident can_overcommit()
Date:   Thu,  9 Jan 2020 15:16:30 +0800
Message-Id: <20200109071634.32384-1-wqu@suse.com>
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
  Revert device size to prevent possible mismatch.

- Ensure all failure caused by calc_per_profile_available() is the same
  with existing error handling
  So no new failure pattern.

- Fix a bug where chunk_mutex is not released in btrfs_shrink_device()


Qu Wenruo (4):
  btrfs: Reset device size when btrfs_update_device() failed in
    btrfs_grow_device()
  btrfs: Introduce per-profile available space facility
  btrfs: space-info: Use per-profile available space in can_overcommit()
  btrfs: statfs: Use pre-calculated per-profile available space

 fs/btrfs/space-info.c |  15 ++-
 fs/btrfs/super.c      | 182 +++++++++------------------------
 fs/btrfs/volumes.c    | 229 ++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/volumes.h    |  11 ++
 4 files changed, 274 insertions(+), 163 deletions(-)

-- 
2.24.1

