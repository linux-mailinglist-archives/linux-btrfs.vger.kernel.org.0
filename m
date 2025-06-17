Return-Path: <linux-btrfs+bounces-14745-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE28AADD5DE
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 18:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBEF2C33E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 16:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0A62F9495;
	Tue, 17 Jun 2025 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQLA369b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D5A2F9489
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176808; cv=none; b=QXu0RS+dVPMH99shlt9soVO/H+tbksVY4K4DMaq2Gk8Eg+NAqUGZhLkM7PaSLXUbv+0u8BwzpHciyUF67+FiG8mXqnRnrs8vUPO77mj+aADw+KhjmYlTb5PdWpcrKsWNcUskF2qUjzRRe67Rm5B9U1nJCWm2oQRqv7FhG/2peZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176808; c=relaxed/simple;
	bh=atx+T+2C3TD3AbJL42n0nOIP0wHMyRn9WChfm2hCHog=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XT7ODva9lK/2DrR8aSW5K6+nVPlcSuaNVv+gAtgUvdGSUdrEzeFgObP1QIzpAqqLGMd40J5jTeIj3k3A6nOghrCadw/Q9ftCmQBvpFfBivYDcuOvLR9wFmO9Bys3u2DQ8ASIUZZr9oupdWfD5tuSv8zYvvW2xs9w2yfCEahNs8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQLA369b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A301C4CEF1
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750176807;
	bh=atx+T+2C3TD3AbJL42n0nOIP0wHMyRn9WChfm2hCHog=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JQLA369b6KDQ51NCwO5eI6qR+R5XKw6NztyzGCYpkM0FB0Sd3U/Jh7zaUfzvdYMwG
	 /xt9kgPVTTSuEcqC3uOsmNISkfzOmowRASbxO/nwO3re2qyOuPfzlRuI19DPTHiXni
	 ibv+6GzhrdppMVRsW25NyyJeBgyYS42eG11s5aGnf991o/Qlppg2fNWN1zajPNKO74
	 H8FheCposRSXMxWdfr+djF+9QxWz7QA2Xr08JIiEEzcCYiaIrl+QulIUUmkWlxDZS7
	 A/g7bgejAtuwhZ2AiFbJ0hNW4mqLFRB/U8eJlAbA1589uS8H2gScl9KL5yax5ezSv+
	 c5drJqW02Ashg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 16/16] btrfs: cache if we are using free space bitmaps for a block group
Date: Tue, 17 Jun 2025 17:13:11 +0100
Message-ID: <b8dfd9adca4be0d65661e90e7c742b1c66ff4fe9.1750075579.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750075579.git.fdmanana@suse.com>
References: <cover.1750075579.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Every time we add free space to the free space tree or we remove free
space from the free space tree, we do a lookup for the block group's free
space info item in the free space tree. This takes time, navigating the
btree and we may block either on IO when reading extent buffers from disk
or on extent buffer lock contention due to concurrency.

Instead of doing this lookup everytime, cache the result in the block
structure and use it after the first lookup. This adds two boolean members
to the block group structure but doesn't increase the structure's size.

The following script that runs fs_mark was used to measure the time spent
on run_delayed_tree_ref(), since down that call chain we have calls to
add and remove free space to/from the free space tree (calls to
btrfs_add_to_free_space_tree() and btrfs_remove_from_free_space_tree()):

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/nullb0
  MNT=/mnt
  FILES=100000
  THREADS=$(nproc --all)

  echo "performance" | \
      tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

  umount $DEV &> /dev/null
  mkfs.btrfs -f $DEV
  mount -o ssd $DEV $MNT

  OPTS="-S 0 -L 5 -n $FILES -s 0 -t $THREADS -k"
  for ((i = 1; i <= $THREADS; i++)); do
      OPTS="$OPTS -d $MNT/d$i"
  done

  fs_mark $OPTS

  umount $MNT

This is a heavy metadata test as it's exercising only file creation, so a
lot of allocations of metadata extents, creating delayed refs for adding
new metadata extents and dropping existing ones due to COW. The results
of the times it took to execute run_delayed_tree_ref(), in nanoseconds,
are the following.

Before this change:

  Range: 1868.000 - 6482857.000; Mean: 10231.430; Median: 7005.000; Stddev: 27993.173
  Percentiles:  90th: 13342.000; 95th: 23279.000; 99th: 82448.000
  1868.000 - 4222.038: 270696 ############
  4222.038 - 9541.029: 1201327 #####################################################
  9541.029 - 21559.383: 385436 #################
  21559.383 - 48715.063: 64942 ###
  48715.063 - 110073.800: 31454 #
  110073.800 - 248714.944:  8218 |
  248714.944 - 561977.042:  1030 |
  561977.042 - 1269798.254:   295 |
  1269798.254 - 2869132.711:   116 |
  2869132.711 - 6482857.000:    28 |

After this change:

  Range: 1554.000 - 4557014.000; Mean: 9168.164; Median: 6391.000; Stddev: 21467.060
  Percentiles:  90th: 12478.000; 95th: 20964.000; 99th: 72234.000
  1554.000 - 3453.820: 219004 ############
  3453.820 - 7674.743: 980645 #####################################################
  7674.743 - 17052.574: 552486 ##############################
  17052.574 - 37887.762: 68558 ####
  37887.762 - 84178.322: 31557 ##
  84178.322 - 187024.331: 12102 #
  187024.331 - 415522.355:  1364 |
  415522.355 - 923187.626:   256 |
  923187.626 - 2051092.468:   125 |
  2051092.468 - 4557014.000:    21 |

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.h     |  5 +++++
 fs/btrfs/free-space-tree.c | 12 +++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index aa176cc9a324..8a8f1fff7e5b 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -246,6 +246,11 @@ struct btrfs_block_group {
 	/* Lock for free space tree operations. */
 	struct mutex free_space_lock;
 
+	/* Protected by @free_space_lock. */
+	bool use_free_space_bitmaps;
+	/* Protected by @free_space_lock. */
+	bool use_free_space_bitmaps_cached;
+
 	/*
 	 * Number of extents in this block group used for swap files.
 	 * All accesses protected by the spinlock 'lock'.
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 3c8bb95fa044..1bd07e91fd5a 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -287,6 +287,8 @@ int btrfs_convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 	flags = btrfs_free_space_flags(leaf, info);
 	flags |= BTRFS_FREE_SPACE_USING_BITMAPS;
+	block_group->use_free_space_bitmaps = true;
+	block_group->use_free_space_bitmaps_cached = true;
 	btrfs_set_free_space_flags(leaf, info, flags);
 	expected_extent_count = btrfs_free_space_extent_count(leaf, info);
 	btrfs_release_path(path);
@@ -434,6 +436,8 @@ int btrfs_convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 	flags = btrfs_free_space_flags(leaf, info);
 	flags &= ~BTRFS_FREE_SPACE_USING_BITMAPS;
+	block_group->use_free_space_bitmaps = false;
+	block_group->use_free_space_bitmaps_cached = true;
 	btrfs_set_free_space_flags(leaf, info, flags);
 	expected_extent_count = btrfs_free_space_extent_count(leaf, info);
 	btrfs_release_path(path);
@@ -796,13 +800,19 @@ static int use_bitmaps(struct btrfs_block_group *bg, struct btrfs_path *path)
 	struct btrfs_free_space_info *info;
 	u32 flags;
 
+	if (bg->use_free_space_bitmaps_cached)
+		return bg->use_free_space_bitmaps;
+
 	info = btrfs_search_free_space_info(NULL, bg, path, 0);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 	flags = btrfs_free_space_flags(path->nodes[0], info);
 	btrfs_release_path(path);
 
-	return (flags & BTRFS_FREE_SPACE_USING_BITMAPS) ? 1 : 0;
+	bg->use_free_space_bitmaps = (flags & BTRFS_FREE_SPACE_USING_BITMAPS);
+	bg->use_free_space_bitmaps_cached = true;
+
+	return bg->use_free_space_bitmaps;
 }
 
 EXPORT_FOR_TESTS
-- 
2.47.2


