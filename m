Return-Path: <linux-btrfs+bounces-15314-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82253AFC35F
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 08:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D087A7807
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 06:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20858224B05;
	Tue,  8 Jul 2025 06:55:17 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BB522154D
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957716; cv=none; b=KQ2BBbBdAu+AjYQe16rnUb070EKr8b7YGQdsW7VzC6RwPNMdvhYA34zZ9NhKAY/ROMg7p8teV/pDFnsLkZrZxs3NhTOcXvVE80LqM3geGkwJ9EHCF5m1MW+6aSXhbOcFd5mvEIGeG4529OMBu7QAvymFgGzh1sVkX1jVIpQR22A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957716; c=relaxed/simple;
	bh=eE5aaAyoMcjlvLjiuYG5BZBGfNEKeMQy8zFb6FLOOAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdI7eP8VqeF4V/xvY4l+h2ix1YwxJqcnYUp+FJAQEkWy0b5R/4u8fe1BHv1QnbdpQlNcb5vCDJ7OJ+e9vfvT9ycEOU1u1oxlL/nWD6A2WHDIU0LHJ/FJCJ4mkZVhqLzhTZ24bC/oEB/esXvDSUkLqHRhRkIEjeRF5lsIQKJ7rqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-454aaade1fbso44371535e9.3
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Jul 2025 23:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751957713; x=1752562513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGMV6AIZPdJaEqIudm5h7+iKHSpYsmY+mq4V7AFR13w=;
        b=l/BYX2kZv6JZn8SBiQa96HFWSIHx3QFVCV7xnY/giyUG9k8RASabXBPRI6kc9WdnBX
         OnymnifPKjmCJRJpisOeyL4AJiVT/8tI5SGmcWQn2op2lqRIdhzh96zL0D0iNgYYu/ph
         Xv638dQz47JHZB0U6G+3jdQF3+SfXe1X3XWWS4Qu7yJPSd50z2TzeHZ83aJH5HFaT6U0
         4vOlulD954mr21CkNmjr5T/t9+03VubWqdI+aiLnjjUe2M25ihQ8HzH5ZgGi+Ot9hUMi
         st9IYWtw/QUxh99PqeE8AET+X8llO7htk8nyp7U6YWQ0sJ9FDexeyVsWPnO7w7QTg1OK
         VSkw==
X-Gm-Message-State: AOJu0YzJcTskks2lxndZ47wU0QH1eAG7kLeosRSoUMfWGwRnlmxXMdoq
	leJt715Ht6yvbmtfMxf7QaMUlliw1vFzYkAbwpiYufy498F4KGHrmjOgMHc2RNRj
X-Gm-Gg: ASbGncvjshJX9XL5CktzM9wfnnv37D/FN2wW/r6AdSkm+cBzul8n1mtwKNkkMSBMK8P
	Rlf7AQD/bK68xnlaNPALGb+aKh4/Cl2BT6/Jvq/VfRE3/5yoSIYnChr8ZZSkKXtIx22CgLNAwKX
	IcGSdDBZPM57k0nCNqlZeOhswdBPC8K5ftrsPK3KdgtSAbFjOsOJ1QSOmPxIwkBrxc+/kbnz/0d
	5W3SikyNwWnhIsrUiKO5XnmO1/f1hCWWJWAMM4jbcUbZR2I4KEzOoJtWsrcpVCngScrE6AEsjgE
	J/rSKUmkb7m837zXOAPTs7WWrVQLRxMTmWWpZssH1Ll9dVXVu0hhGpN8kO0puJy6M1HeGE3oZFt
	7nPhcLO+oi6lT63NMQezH/6EPhmmrRif01D728ObeinzfM7nLoQ==
X-Google-Smtp-Source: AGHT+IF3O95LKMLja/5gJokswL2S55AWurjJtahqHQEIvSpWEvyMQ3fESu3ccsENvtMpMFtKxPdPDA==
X-Received: by 2002:a05:600c:5292:b0:453:6146:1172 with SMTP id 5b1f17b1804b1-454b4e6e64dmr153723645e9.3.1751957712987;
        Mon, 07 Jul 2025 23:55:12 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f71c45003fa4d1e815666221.dip0.t-ipconnect.de. [2003:f6:f71c:4500:3fa4:d1e8:1566:6221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3d275fsm12745075e9.20.2025.07.07.23.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 23:55:12 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/2] btrfs: don't print relocation messages from auto reclaim
Date: Tue,  8 Jul 2025 08:55:03 +0200
Message-ID: <20250708065504.63525-3-jth@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708065504.63525-1-jth@kernel.org>
References: <20250708065504.63525-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When BTRFS is doing automatic block-group reclaim, it is spamming the
kernel log messages a lot.

Add a `verbose` parameter to `btrfs_relocate_chunk()` and
`btrfs_relocate_block_group()` to control the verbosity of these log
message. This way the old behaviour of printing log messages on a
user-space initiated balance operation can be kept while excessive log
spamming due to auto reclaim is mitigated.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c |  2 +-
 fs/btrfs/relocation.c  | 12 ++++++++----
 fs/btrfs/relocation.h  |  3 ++-
 fs/btrfs/volumes.c     | 14 ++++++++------
 fs/btrfs/volumes.h     |  3 ++-
 5 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index b01408f0b92a..042f8566c7cc 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1964,7 +1964,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		spin_unlock(&bg->lock);
 
 		trace_btrfs_reclaim_block_group(bg);
-		ret = btrfs_relocate_chunk(fs_info, bg->start);
+		ret = btrfs_relocate_chunk(fs_info, bg->start, false);
 		if (ret) {
 			btrfs_dec_block_group_ro(bg);
 			btrfs_err(fs_info, "error relocating chunk %llu",
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 175fc3acc38b..47ee3216e1e0 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3908,7 +3908,8 @@ static const char *stage_to_string(enum reloc_stage stage)
 /*
  * function to relocate all extents in a block group.
  */
-int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
+int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
+			       bool verbose)
 {
 	struct btrfs_block_group *bg;
 	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, group_start);
@@ -4000,7 +4001,8 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 		goto out;
 	}
 
-	describe_relocation(rc->block_group);
+	if (verbose)
+		describe_relocation(rc->block_group);
 
 	btrfs_wait_block_group_reservations(rc->block_group);
 	btrfs_wait_nocow_writers(rc->block_group);
@@ -4044,8 +4046,10 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 		if (rc->extents_found == 0)
 			break;
 
-		btrfs_info(fs_info, "found %llu extents, stage: %s",
-			   rc->extents_found, stage_to_string(finishes_stage));
+		if (verbose)
+			btrfs_info(fs_info, "found %llu extents, stage: %s",
+				   rc->extents_found,
+				   stage_to_string(finishes_stage));
 	}
 
 	WARN_ON(rc->block_group->pinned > 0);
diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
index 788c86d8633a..5c36b3f84b57 100644
--- a/fs/btrfs/relocation.h
+++ b/fs/btrfs/relocation.h
@@ -12,7 +12,8 @@ struct btrfs_trans_handle;
 struct btrfs_ordered_extent;
 struct btrfs_pending_snapshot;
 
-int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start);
+int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
+			       bool verbose);
 int btrfs_init_reloc_root(struct btrfs_trans_handle *trans, struct btrfs_root *root);
 int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 31aecd291d6c..3f098ce07577 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3412,7 +3412,8 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 	return ret;
 }
 
-int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
+int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset,
+			 bool verbose)
 {
 	struct btrfs_root *root = fs_info->chunk_root;
 	struct btrfs_trans_handle *trans;
@@ -3442,7 +3443,7 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 
 	/* step one, relocate all the extents inside this chunk */
 	btrfs_scrub_pause(fs_info);
-	ret = btrfs_relocate_block_group(fs_info, chunk_offset);
+	ret = btrfs_relocate_block_group(fs_info, chunk_offset, true);
 	btrfs_scrub_continue(fs_info);
 	if (ret) {
 		/*
@@ -3552,7 +3553,8 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 		btrfs_release_path(path);
 
 		if (chunk_type & BTRFS_BLOCK_GROUP_SYSTEM) {
-			ret = btrfs_relocate_chunk(fs_info, found_key.offset);
+			ret = btrfs_relocate_chunk(fs_info, found_key.offset,
+						   true);
 			if (ret == -ENOSPC)
 				failed++;
 			else
@@ -4217,7 +4219,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 			}
 		}
 
-		ret = btrfs_relocate_chunk(fs_info, found_key.offset);
+		ret = btrfs_relocate_chunk(fs_info, found_key.offset, true);
 		mutex_unlock(&fs_info->reclaim_bgs_lock);
 		if (ret == -ENOSPC) {
 			enospc_errors++;
@@ -4985,7 +4987,7 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 			goto done;
 		}
 
-		ret = btrfs_relocate_chunk(fs_info, chunk_offset);
+		ret = btrfs_relocate_chunk(fs_info, chunk_offset, true);
 		mutex_unlock(&fs_info->reclaim_bgs_lock);
 		if (ret == -ENOSPC) {
 			failed++;
@@ -8198,7 +8200,7 @@ static int relocating_repair_kthread(void *data)
 	btrfs_info(fs_info,
 		   "zoned: relocating block group %llu to repair IO failure",
 		   target);
-	ret = btrfs_relocate_chunk(fs_info, target);
+	ret = btrfs_relocate_chunk(fs_info, target, true);
 
 out:
 	if (cache)
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 7395cb5e1238..ab3163897049 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -765,7 +765,8 @@ void btrfs_describe_block_groups(u64 flags, char *buf, u32 size_buf);
 int btrfs_resume_balance_async(struct btrfs_fs_info *fs_info);
 int btrfs_recover_balance(struct btrfs_fs_info *fs_info);
 int btrfs_pause_balance(struct btrfs_fs_info *fs_info);
-int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset);
+int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset,
+			 bool verbose);
 int btrfs_cancel_balance(struct btrfs_fs_info *fs_info);
 bool btrfs_chunk_writeable(struct btrfs_fs_info *fs_info, u64 chunk_offset);
 void btrfs_dev_stat_inc_and_print(struct btrfs_device *dev, int index);
-- 
2.50.0


