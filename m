Return-Path: <linux-btrfs+bounces-15110-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C4AAEE16E
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 16:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39285188B77B
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 14:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E4E28C872;
	Mon, 30 Jun 2025 14:47:51 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B3C28C2D0
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294870; cv=none; b=ujpEHTWMOJe6A1z0mXb7iX0h0S9ihy9Y0r8gHosZEQuKr41O849tPjDmj0Q8zkIgXD12haSiHejBy/JVdNdaa9ElBKaL1r1yVLRDkElMlUmZjLXpagK74TDPaZY79KH68/+B0nOD1TEyyq7jOlVxf1vMsQwtdmdPecFd/AiDn2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294870; c=relaxed/simple;
	bh=6U9NIw+TBgcwKX/uSVif4Lo15oGZcYXhzkato9RDbPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F2Mq3BUb5Q8xtN9rUX0zVxEqGjK2k88+Rugo5Iau42vPkGZVfF55lI9VdoeaZJQqhGsD2KzerAVFjAYuhh9fx4QSTDxtqRLXbwjps1xN1RO+NGfSEp+XU39JzSOXkP3rFz6k/FYKl1DJDRlQ5jB9BY4CDi2hYGOjluyua4XAbBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso1713885f8f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 07:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751294867; x=1751899667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFa0r1V3q5i6nnqf23YjChymvfFs5dzoPa2YI+HYluI=;
        b=TWOh4DPLYeP/p99THyDkFsFsmk4MC9uGMwrWCjbx0ciF2cVZXCnupL3s0KN3AdKT5l
         a6EOLVaoBoRCHMSUvXIbuFFWXoG8QEu28Fq0+2Z6gk+OBNvtCMevtTCnIO7T67LZN52O
         FmNCaf7vG5KcpOq4CG8BhGRb7VIMkXQmRE1aoMUU6LCTZhWSg/3MnVUq71HvwwF4vc95
         r4FYYm7BMqy0bdsiHrvD1b64teW+6gcBdDcEbZqE4U1skJEsWfak3aBqgm3O7To4NeRP
         4Rbywt3e0C4Ii5ZIAztSJXmqVq2tOpAoZye9PK36OTW4llDN5CmgrZ6s8a9JaQDQKa8m
         VSWQ==
X-Gm-Message-State: AOJu0YzZYHnrXQQszWoFwJE+rcJYuK547I4yeuJOjZAKwVEhRgCXBzth
	G7l7ynUodbAJsSx7WQ2U3Bx7m0rA/x0gQiDT8ENxsEf6GbfP9NZZcsYuMC8uHw==
X-Gm-Gg: ASbGncsp9iSiTxYCDRfIgeM3CIWqOSUo30OuTyGlcaaAHZMeWBYcv3XxFxxLM7xssBN
	08O3x3M3fF5jmz0acMC7rrZETVlaXjVpJWbgzq33eO7BnGy/PZOeH971WJHlmwZyTV4Vb2SgbGs
	E5UzgxUdL/gBXPbnT/U0APB2YXKiqP/Pvai1fdO4+MohmlNXZqfN5uFdw75OMeCu0DFDFY7ymLH
	YZcodjIx4RcIu2bJpnwsr+xe12ZO/koJupdvK87aAcYLaPKsviNQmA2MLapi+wnmNcWABU3KQLL
	MHPsdXzQ+8wpKaTj9lZgODuAq8CfyeJYqFXCtewVVqD3w3KNNqzi4fFYhv09hp+9fraQUAWMKuc
	t0gqtbHhDE03FWZTeM+Go7w1Qe0kkZR1ByIIfe44F/QutFaAzGg==
X-Google-Smtp-Source: AGHT+IFSk2Dc+IhvokfHJNzgbX9PgGGkEljgWldSA6ftqAO5ulzfag29vKbfb9//umOkXU9wH4Uadw==
X-Received: by 2002:a05:6000:2704:b0:3a4:d994:be4b with SMTP id ffacd0b85a97d-3a8f454905amr10843213f8f.1.1751294867153;
        Mon, 30 Jun 2025 07:47:47 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f72c40008e33df2436c66ffb.dip0.t-ipconnect.de. [2003:f6:f72c:4000:8e33:df24:36c6:6ffb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52a35sm10780283f8f.57.2025.06.30.07.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:47:46 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: change dump_block_groups in btrfs_dump_space_info from int to bool
Date: Mon, 30 Jun 2025 16:47:35 +0200
Message-ID: <20250630144735.224222-1-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

btrfs_dump_space_info()'s parameter dump_block_groups is used as a boolean
although it is defined as an integer.

Change it from int to bool.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 8 ++++----
 fs/btrfs/space-info.c  | 7 ++++---
 fs/btrfs/space-info.h  | 2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 4259d955e70f..dc0b29ed46c0 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1417,7 +1417,7 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 	if (ret == -ENOSPC && btrfs_test_opt(cache->fs_info, ENOSPC_DEBUG)) {
 		btrfs_info(cache->fs_info,
 			"unable to make block group %llu ro", cache->start);
-		btrfs_dump_space_info(cache->fs_info, cache->space_info, 0, 0);
+		btrfs_dump_space_info(cache->fs_info, cache->space_info, 0, false);
 	}
 	return ret;
 }
@@ -4315,7 +4315,7 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
 	if (left < bytes && btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
 		btrfs_info(fs_info, "left=%llu, need=%llu, flags=%llu",
 			   left, bytes, type);
-		btrfs_dump_space_info(fs_info, info, 0, 0);
+		btrfs_dump_space_info(fs_info, info, 0, false);
 	}
 
 	if (left < bytes) {
@@ -4460,7 +4460,7 @@ static void check_removing_space_info(struct btrfs_space_info *space_info)
 	 * indicates a real bug if this happens.
 	 */
 	if (WARN_ON(space_info->bytes_pinned > 0 || space_info->bytes_may_use > 0))
-		btrfs_dump_space_info(info, space_info, 0, 0);
+		btrfs_dump_space_info(info, space_info, 0, false);
 
 	/*
 	 * If there was a failure to cleanup a log tree, very likely due to an
@@ -4471,7 +4471,7 @@ static void check_removing_space_info(struct btrfs_space_info *space_info)
 	if (!(space_info->flags & BTRFS_BLOCK_GROUP_METADATA) ||
 	    !BTRFS_FS_LOG_CLEANUP_ERROR(info)) {
 		if (WARN_ON(space_info->bytes_reserved > 0))
-			btrfs_dump_space_info(info, space_info, 0, 0);
+			btrfs_dump_space_info(info, space_info, 0, false);
 	}
 
 	WARN_ON(space_info->reclaim_size > 0);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 102fcc34ffe2..65cc36ef3f75 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -615,7 +615,7 @@ static void __btrfs_dump_space_info(const struct btrfs_fs_info *fs_info,
 
 void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 			   struct btrfs_space_info *info, u64 bytes,
-			   int dump_block_groups)
+			   bool dump_block_groups)
 {
 	struct btrfs_block_group *cache;
 	u64 total_avail = 0;
@@ -1890,7 +1890,8 @@ int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 					      space_info->flags, orig_bytes, 1);
 
 		if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
-			btrfs_dump_space_info(fs_info, space_info, orig_bytes, 0);
+			btrfs_dump_space_info(fs_info, space_info, orig_bytes,
+					      false);
 	}
 	return ret;
 }
@@ -1921,7 +1922,7 @@ int btrfs_reserve_data_bytes(struct btrfs_space_info *space_info, u64 bytes,
 		trace_btrfs_space_reservation(fs_info, "space_info:enospc",
 					      space_info->flags, bytes, 1);
 		if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
-			btrfs_dump_space_info(fs_info, space_info, bytes, 0);
+			btrfs_dump_space_info(fs_info, space_info, bytes, false);
 	}
 	return ret;
 }
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 7de31541ab45..679f22efb407 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -278,7 +278,7 @@ u64 __pure btrfs_space_info_used(const struct btrfs_space_info *s_info,
 void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
 void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 			   struct btrfs_space_info *info, u64 bytes,
-			   int dump_block_groups);
+			   bool dump_block_groups);
 int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 				 struct btrfs_space_info *space_info,
 				 u64 orig_bytes,
-- 
2.49.0


