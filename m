Return-Path: <linux-btrfs+bounces-7550-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC639607A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 12:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE48283DC3
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 10:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB6519DFAE;
	Tue, 27 Aug 2024 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISB8/xEL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE4A199E98
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724755283; cv=none; b=Hcsb9oYmm/o+Td/Fvi+T9kSL8eKtjhWNpfcOmVkS+b/SPyli/br75KqX/r7iluNZK2f7gP4HTnoEXoFL3MEf3Kf9L78p1k7LHncN1sjGSa5b9tee6Vw8FCax+24U8BkGp9/KWauev3zOul6zNVK92/jo8akrhYnbTipOaw2by4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724755283; c=relaxed/simple;
	bh=x8ORMQzBO/tp8la8oamiq/OyXKkWe96U8vjDGCLomsg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=OU0tUdHHpjttyN5IXnrk4eMrO4961y40qsJjZmEmAJbz9mW+MjYwFvrQrIUM0f+eR3qvie4fIx7WOUb9nlhHfv1sM+0av7VyvmfXBJb87zI86dJ8mCPQWuUmOqfPkkPjFmwOQm1CFUhA2i6CYXRk62hVsQCsW1gHKjbzKmHUdyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISB8/xEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849C2C4DDE7
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 10:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724755283;
	bh=x8ORMQzBO/tp8la8oamiq/OyXKkWe96U8vjDGCLomsg=;
	h=From:To:Subject:Date:From;
	b=ISB8/xELmLj+DE+qtKLRspxYs9AhucEm7iDdKPLI4+bN8yUmVm+7AMxCF5zMXh6se
	 PW60ZSKqxMcSVVvHGsJOHDd0Fr0hyNQnuxYz5lRci3yA/on+aoOU8yWRGsUxRsQOXq
	 r1wJAQV2Zaut4OgZh2/3LAk5oeAeCLWtcPZ2d3/OkHqg2lGbMgX/ago09cvcofS6s5
	 +LgflUDrALSs6/fvZbTA3FKoQRIAC1ZMi2UhM24zdK6lNw2tuKja8yOv0pNB7skNz3
	 EMSQCg9P8Zi/PmsJOmwGssKpIE0rg5tnxRT8uBt1uG+nyrT5yD0BUlwen6qDQZfmum
	 jhKXUJY4D5kMw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix uninitialized return value from btrfs_reclaim_sweep()
Date: Tue, 27 Aug 2024 11:41:19 +0100
Message-Id: <e6fea9cb64a7c98b4f83e2fd75de31a1475fce28.1724755223.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The return variable 'ret' at btrfs_reclaim_sweep() is never assigned if
none of the space infos is reclaimable (for example if periodic reclaim
is disabled, which is the default), so we return an undefined value.

This can be fixed my making btrfs_reclaim_sweep() not return any value
as well as do_reclaim_sweep() because:

1) do_reclaim_sweep() always returns 0, so we can make it return void;

2) The only caller of btrfs_reclaim_sweep() (btrfs_reclaim_bgs()) doesn't
   care about its return value, and in its context there's nothing to do
   about any errors anyway.

Therefore return the return value from btrfs_reclaim_sweep() and
do_reclaim_sweep().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 17 +++++------------
 fs/btrfs/space-info.h |  2 +-
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 68e14fd48638..c691784b4660 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1985,8 +1985,8 @@ static bool is_reclaim_urgent(struct btrfs_space_info *space_info)
 	return unalloc < data_chunk_size;
 }
 
-static int do_reclaim_sweep(struct btrfs_fs_info *fs_info,
-			    struct btrfs_space_info *space_info, int raid)
+static void do_reclaim_sweep(struct btrfs_fs_info *fs_info,
+			     struct btrfs_space_info *space_info, int raid)
 {
 	struct btrfs_block_group *bg;
 	int thresh_pct;
@@ -2031,7 +2031,6 @@ static int do_reclaim_sweep(struct btrfs_fs_info *fs_info,
 	}
 
 	up_read(&space_info->groups_sem);
-	return 0;
 }
 
 void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes)
@@ -2074,21 +2073,15 @@ bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info)
 	return ret;
 }
 
-int btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info)
+void btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info)
 {
-	int ret;
 	int raid;
 	struct btrfs_space_info *space_info;
 
 	list_for_each_entry(space_info, &fs_info->space_info, list) {
 		if (!btrfs_should_periodic_reclaim(space_info))
 			continue;
-		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++) {
-			ret = do_reclaim_sweep(fs_info, space_info, raid);
-			if (ret)
-				return ret;
-		}
+		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++)
+			do_reclaim_sweep(fs_info, space_info, raid);
 	}
-
-	return ret;
 }
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 88b44221ce97..5602026c5e14 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -294,6 +294,6 @@ void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s6
 void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready);
 bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info);
 int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info);
-int btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info);
+void btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info);
 
 #endif /* BTRFS_SPACE_INFO_H */
-- 
2.43.0


