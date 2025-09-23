Return-Path: <linux-btrfs+bounces-17099-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1B8B93CD8
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 03:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82212E14C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 01:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF4B1E008B;
	Tue, 23 Sep 2025 01:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsEsgYUh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334B21C6B4
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 01:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590003; cv=none; b=jQiQoYtr/X6Jpg1QBcTdeQPVlVxNx/eQ6sp9ZtAAr1p3GJU35FQur3JEAgu+bdTjJYaDNd77dT2Amq1HEfQ/jlDj0bdFmfZNa6iFp3yAj5CwYSyetRFF7u9qhi3SPX3cQZB8ZYa1Fnh9nD8eYlAX98LP8IyIik53akCjzguULP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590003; c=relaxed/simple;
	bh=QC8GwmgjLY2EqlX+yh8rq2Ea8HaJQro1PEFp9vrfHY8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3s3HW8r15txD7AJ9ilh5X56mb8luQC3Rb0pmaUDcO6uwA5wCeCO4rh2gyO+mffelbmMLC4jncqMuL+8tU4L6kwIUFpgdu6P8/ULlr9JSct+V3QpsDxdQUBTsmmN/LjVDal0tHasR3mfXASkWp9GeBiq/+6Pgz68jrrYFM98sZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsEsgYUh; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-ea3dbcc5410so3562553276.2
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 18:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758590000; x=1759194800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d50Jd6Bx/MVU3xznXL21ZjGYEmx76SMVgai5ScaRncA=;
        b=FsEsgYUhXfjz4+42+LbhK3ovFE2T7X3fhZ5unAWh4Tpa5DW0A71oONKfEnwEovrk0B
         xBUoWL0yADqFoTKqDf2pySIB/rAw7OUzW6DzOaqUwIYwz7MqOkuohgj9eDlQNSFrEOc6
         Jv2WzTsrdFTh0YheD1QpBsGSN81JiiqudUZ1D/snCGyeNwmL5rNongnaoZNeLsrVvorR
         PRzeKhcrvl8UrMz7WYiJOVKm/Fq7OINm4kGEOAZQTXzyC1IdHq5OGfiR6h1qyBKUuCnS
         5ALYLkJHQscF1SI1n7S+xG7aWghwm4dUPZP8F8VOOnRoYM/jiLFON4ro7zAFKHh7pRt4
         Xw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758590000; x=1759194800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d50Jd6Bx/MVU3xznXL21ZjGYEmx76SMVgai5ScaRncA=;
        b=gIW9LUQSVx/PpnLKcdrUcfS6m8FWz62o4PX2h4miT8JValIPiprqeNrRe2QoCaAIgh
         eTGjt6/yxlDa9wB7F2IoMJTmAJh7frVoTaeWS6axpjVAVjzLFJziu9Pq78liROKrZtZk
         QiLe8fhqFjUrOYp3qY3Dwt1ov78LJLwWEdQKzAuWwQCY+4PXtqyKYb9piLu3dCwydNgJ
         OtM3Tyw7lounKYivx1VWsNPrasOasvGoVJ4Paw9QkCLRgmUYKqJrYG6+3SkHcxTmtLeM
         20feuCZhD+6LRQ3obkMcpAkUOl0c3u/Ru7jOb0a6XgjL58Z+andI6gMGwe5ofQAcd+C5
         S5rA==
X-Gm-Message-State: AOJu0YzjNoRBur2qUyUwmtMsx2W+irNfoOPGo35qsM+jjEl57EZrEVT3
	Wg9SmowADM2z20uipLgxxxis+8Y7jfsEqrFcYEsuaMYaObgNWwMK3YamRsNBC4tH
X-Gm-Gg: ASbGncukQ4i64n11+GXLacoxVWoSE2jI4SPWJ4LYCEyhfuUVdIpVHUkaOkJ11JoSPn4
	8/Oi1UcCMcBBXol6ib+j8+aJDLKMEzcikp0mrRGgDcUGYQhzHz8AhyoLjfY8u9gZws3nUVjSeeC
	D7bgX8rugc4a91a7kJK7GRaladr0vtWdL0+BCKZLHCFF/+ZgQkCofYKOVYs3OkAWc6u/khqV/ce
	Fg8AEMA/ZZcUgF3JpLgAVdgGEdnbGFuBNNRVmptdOSHn/mf3KxGMGineF0tcfO4Q/u7bTOui/qE
	PG3AxjUY5WxTF8SzemzZVzTfbpUFv2iwjr9+R9kHwrw9ki16/xCzkl1mQTPje92iOPzjt9i6vGz
	Q4M/Hex9uOT01k2uFuA==
X-Google-Smtp-Source: AGHT+IGBYTEn95PbJl5tQVOrVcYsR5hiWSOWS5ehoO000PuxuI9QcixA+TDcJAomxd8lDs6/j84XSw==
X-Received: by 2002:a05:6902:160d:b0:eaf:b983:9a06 with SMTP id 3f1490d57ef6-eb32de6400cmr783441276.1.1758589999835;
        Mon, 22 Sep 2025 18:13:19 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce98f1b7sm4642189276.32.2025.09.22.18.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 18:13:19 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: remove ffe RAID loop
Date: Mon, 22 Sep 2025 18:13:14 -0700
Message-ID: <f873e980f092dc282ea934d5a77ca2ad463e377d.1758587352.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1758587352.git.loemra.dev@gmail.com>
References: <cover.1758587352.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes the RAID loop from find_free_extent since it
is impossible to allocate from a block group with a different
RAID profile.

Historically, we've been able to fulfill allocation requests
from any block group. For example, a request for RAID0 could be
fulfilled by a RAID1 block group or a request for METADATA could be
fulfilled by a DATA block group.

"btrfs: extent-tree: Make sure we only allocate extents from block
groups with the same type" changed this behavior to skip block groups
with different flags than the request. This makes the duplication
compatibility check redundant since we're going to keep searching
regardless.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/extent-tree.c | 40 +++-------------------------------------
 1 file changed, 3 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a4416c451b25..072d9bb84dd8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4153,8 +4153,7 @@ static int can_allocate_chunk(struct btrfs_fs_info *fs_info,
 static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 					struct btrfs_key *ins,
 					struct find_free_extent_ctl *ffe_ctl,
-					struct btrfs_space_info *space_info,
-					bool full_search)
+					struct btrfs_space_info *space_info)
 {
 	struct btrfs_root *root = fs_info->chunk_root;
 	int ret;
@@ -4171,20 +4170,15 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 	if (ffe_ctl->loop >= LOOP_CACHING_WAIT && ffe_ctl->have_caching_bg)
 		return 1;
 
-	ffe_ctl->index++;
-	if (ffe_ctl->index < BTRFS_NR_RAID_TYPES)
-		return 1;
-
 	/* See the comments for btrfs_loop_type for an explanation of the phases. */
 	if (ffe_ctl->loop < LOOP_NO_EMPTY_SIZE) {
-		ffe_ctl->index = 0;
 		/*
 		 * We want to skip the LOOP_CACHING_WAIT step if we don't have
 		 * any uncached bgs and we've already done a full search
 		 * through.
 		 */
 		if (ffe_ctl->loop == LOOP_CACHING_NOWAIT &&
-		    (!ffe_ctl->orig_have_caching_bg && full_search))
+		    (!ffe_ctl->orig_have_caching_bg))
 			ffe_ctl->loop++;
 		ffe_ctl->loop++;
 
@@ -4384,7 +4378,6 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	int cache_block_group_error = 0;
 	struct btrfs_block_group *block_group = NULL;
 	struct btrfs_space_info *space_info;
-	bool full_search = false;
 
 	WARN_ON(ffe_ctl->num_bytes < fs_info->sectorsize);
 
@@ -4477,9 +4470,6 @@ static noinline int find_free_extent(struct btrfs_root *root,
 search:
 	trace_btrfs_find_free_extent_search_loop(root, ffe_ctl);
 	ffe_ctl->have_caching_bg = false;
-	if (ffe_ctl->index == btrfs_bg_flags_to_raid_index(ffe_ctl->flags) ||
-	    ffe_ctl->index == 0)
-		full_search = true;
 	down_read(&space_info->groups_sem);
 	list_for_each_entry(block_group,
 			    &space_info->block_groups[ffe_ctl->index], list) {
@@ -4498,30 +4488,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		btrfs_grab_block_group(block_group, ffe_ctl->delalloc);
 		ffe_ctl->search_start = block_group->start;
 
-		/*
-		 * this can happen if we end up cycling through all the
-		 * raid types, but we want to make sure we only allocate
-		 * for the proper type.
-		 */
 		if (!block_group_bits(block_group, ffe_ctl->flags)) {
-			u64 extra = BTRFS_BLOCK_GROUP_DUP |
-				BTRFS_BLOCK_GROUP_RAID1_MASK |
-				BTRFS_BLOCK_GROUP_RAID56_MASK |
-				BTRFS_BLOCK_GROUP_RAID10;
-
-			/*
-			 * if they asked for extra copies and this block group
-			 * doesn't provide them, bail.  This does allow us to
-			 * fill raid0 from raid1.
-			 */
-			if ((ffe_ctl->flags & extra) && !(block_group->flags & extra))
-				goto loop;
-
-			/*
-			 * This block group has different flags than we want.
-			 * It's possible that we have MIXED_GROUP flag but no
-			 * block group is mixed.  Just skip such block group.
-			 */
 			btrfs_release_block_group(block_group, ffe_ctl->delalloc);
 			continue;
 		}
@@ -4620,8 +4587,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	}
 	up_read(&space_info->groups_sem);
 
-	ret = find_free_extent_update_loop(fs_info, ins, ffe_ctl, space_info,
-					   full_search);
+	ret = find_free_extent_update_loop(fs_info, ins, ffe_ctl, space_info);
 	if (ret > 0)
 		goto search;
 
-- 
2.47.3


