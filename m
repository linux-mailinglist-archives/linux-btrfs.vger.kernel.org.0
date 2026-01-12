Return-Path: <linux-btrfs+bounces-20416-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC428D13F3A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 17:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87DB930B960A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 16:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C844365A0C;
	Mon, 12 Jan 2026 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b="eidDzAUS";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="O1/8GzTC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from a4-2.smtp-out.eu-west-1.amazonses.com (a4-2.smtp-out.eu-west-1.amazonses.com [54.240.4.2])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ABC23ED6A
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.4.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234644; cv=none; b=lHcJO5uHVobSA1rNgPL1RrrjNWVMc4GUfH/7OeNzwr7P9rIC/6LjcOarTdanfb5Y+phmqpd++bH5GcWtyjQRss7BpSd8540nk+Ce2QTzyFMMHbOLamsIvS1b9dgoGbmGkAGoQPxJLPn13q9paRz766VZ37uhf2gOVDHbCxvzx7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234644; c=relaxed/simple;
	bh=k3EYnrCPCUWGlQQvRBMkLUPvBwXlARGhP6MutIHT1bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=faB1nDpCLvK5vKIB9af+budSdxSwM/Fs161WfpBzXeQIkN3493uxxUOKCV/pbT10+H5sFesYos3YSwzFmfFZ0h7sX5KMwGIfi3g/+yXQHDXU/qrpHUN+6RJopc/8kzjj3eL98We/uWBLx82N+NaZC6V01vNMayisat0L0Hq6PtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org; spf=pass smtp.mailfrom=bounce.urbackup.org; dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b=eidDzAUS; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=O1/8GzTC; arc=none smtp.client-ip=54.240.4.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.urbackup.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1768234637;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=k3EYnrCPCUWGlQQvRBMkLUPvBwXlARGhP6MutIHT1bU=;
	b=eidDzAUSmHzQG6maLITZozTeZ8LjnW0QzvJFB99BFLNLzISw5WzJ5oSWLTYk/hpX
	FcAcG1WdtntIKvkPxjs+16lVrvZdgorRNIJbQZI7mi9ls9Fa0c5XECyWtRhGrZ4Jn2H
	m3Ie7A8RCOFN016ufbenVx9vFOtcSKcZS+PuhjpE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1768234637;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=k3EYnrCPCUWGlQQvRBMkLUPvBwXlARGhP6MutIHT1bU=;
	b=O1/8GzTCgsOViqEmQnv4V3IrDPc2g+usLRlZ+/nQYyXV/162ZjaN5CYEZ8D99NP7
	xXIjUGYg5NwPQlwtT3d3UEAs9Q+k5wMB5+36/vmyUvcjCml0/w8OEYMXrSE0M/vTaTw
	EGCDw1tMqiQDYG0/T9SspW9vP0uolyENgk6enNGg=
From: Martin Raiber <martin@urbackup.org>
To: linux-btrfs@vger.kernel.org
Cc: Martin Raiber <martin@urbackup.org>
Subject: [PATCH 3/7] btrfs: Don't lock data_rwsem if space cache v1 is not used
Date: Mon, 12 Jan 2026 16:17:17 +0000
Message-ID: <0102019bb2ff5989-0b261fa3-b8ae-46ff-9e7f-de31783ecd39-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260112161549.2786827-1-martin@urbackup.org>
References: <20260112161549.2786827-1-martin@urbackup.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2026.01.12-54.240.4.2

Data_rwsem is only used in space cache v1. Introduce a new
cache state BTRFS_DC_DISABLED to easily tell if space cache v1
is not used for the block group. Then do not lock data_rwsem
if space cache v1 is not used.
This significantly improves performance in the common cases

Signed-off-by: Martin Raiber <martin@urbackup.org>
---
 fs/btrfs/block-group.c |  3 +++
 fs/btrfs/block-group.h |  3 ++-
 fs/btrfs/extent-tree.c | 12 +++++++-----
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 7569438ccbd5..d9ea62c32587 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2315,6 +2315,9 @@ static struct btrfs_block_group *btrfs_create_block_group(
 	atomic_set(&cache->frozen, 0);
 	mutex_init(&cache->free_space_lock);
 
+	if (!btrfs_test_opt(fs_info, SPACE_CACHE))
+		cache->disk_cache_state = BTRFS_DC_DISABLED;
+
 	return cache;
 }
 
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index d44675f9d601..cf877747fd56 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -22,9 +22,10 @@ struct btrfs_trans_handle;
 
 enum btrfs_disk_cache_state {
 	BTRFS_DC_WRITTEN,
+	BTRFS_DC_DISABLED,
 	BTRFS_DC_ERROR,
 	BTRFS_DC_CLEAR,
-	BTRFS_DC_SETUP,
+	BTRFS_DC_SETUP
 };
 
 enum btrfs_block_group_size_class {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ce2eef069663..7a5e4efd6cd8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3578,7 +3578,7 @@ enum btrfs_loop_type {
 static inline void
 btrfs_lock_block_group(struct btrfs_block_group *cache, bool delalloc)
 {
-	if (delalloc)
+	if (delalloc && cache->disk_cache_state != BTRFS_DC_DISABLED)
 		down_read(&cache->data_rwsem);
 }
 
@@ -3586,7 +3586,7 @@ static inline void btrfs_grab_block_group(struct btrfs_block_group *cache,
 					  bool delalloc)
 {
 	btrfs_get_block_group(cache);
-	if (delalloc)
+	if (delalloc && cache->disk_cache_state != BTRFS_DC_DISABLED)
 		down_read(&cache->data_rwsem);
 }
 
@@ -3612,7 +3612,8 @@ static struct btrfs_block_group *btrfs_lock_cluster(
 		if (!delalloc)
 			return used_bg;
 
-		if (down_read_trylock(&used_bg->data_rwsem))
+		if (used_bg->disk_cache_state != BTRFS_DC_DISABLED &&
+			 down_read_trylock(&used_bg->data_rwsem))
 			return used_bg;
 
 		spin_unlock(&cluster->refill_lock);
@@ -3624,7 +3625,8 @@ static struct btrfs_block_group *btrfs_lock_cluster(
 		if (used_bg == cluster->block_group)
 			return used_bg;
 
-		up_read(&used_bg->data_rwsem);
+		if (used_bg->disk_cache_state != BTRFS_DC_DISABLED)
+			up_read(&used_bg->data_rwsem);
 		btrfs_put_block_group(used_bg);
 	}
 }
@@ -3632,7 +3634,7 @@ static struct btrfs_block_group *btrfs_lock_cluster(
 static inline void
 btrfs_release_block_group(struct btrfs_block_group *cache, bool delalloc)
 {
-	if (delalloc)
+	if (delalloc && cache->disk_cache_state != BTRFS_DC_DISABLED)
 		up_read(&cache->data_rwsem);
 	btrfs_put_block_group(cache);
 }
-- 
2.39.5


