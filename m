Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D86984AB77
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 22:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbfFRUJv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 16:09:51 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43234 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730568AbfFRUJu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 16:09:50 -0400
Received: by mail-qk1-f196.google.com with SMTP id m14so9424806qka.10
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 13:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=KTzCVPq0bK/K8aJQcfi3SFT/XGM2uIKwkVBqxKxf0JU=;
        b=pXJrP4mUva+7Trp5g/kNFJ6HQmptCYUpjpaRKaspJHbPKCBM7FxdyJK6OBsLtnQiuN
         +rjYAOF0tSIy3i1HTOibFQCfO+bt+xkpvU7lqvF/V5h2HVA5A8Y+8FKqWY+UPmTO6kB3
         MRhrQwK6LoDdlyr6iH3aGCA6JXH/Bbi8lgAXBaQSG6nuZoIeSQsp36cX2zvocJBsikKU
         iifhlxvxy9AI+Ybq1ZHI+5j0zZ6ou244i+BL4/maLk+Uh07xI3I48FYoEKbQoZfQAPez
         C1nEujtqeGN62tV5Re4sbbx0ySNx8rsD0QjAudrE1gOtOma8qdK9qFizsY3bqwacPqwa
         syVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=KTzCVPq0bK/K8aJQcfi3SFT/XGM2uIKwkVBqxKxf0JU=;
        b=rSUngCfpYtgQ3neY0CFCAR+YanQeIutXFLsf2rPiZ1V0i8wlqAr14JPNcHHZEdVz1P
         mE0Y842VxQr1GhvDz/XJxZbrSKaLAFcMkcZS5V6XccgYUZ0KTbGURaY2AYUFM9bvtERH
         G7eozWImdDDd+ZB/v+gLWsJA0U74F1t/gSzsiXLiJYaGb5Msd4I69mvD/andOmRjJRxa
         7Tvtak0Vg0RkVRxShsk3JLtZ6RyAexvqYQP2lT8DEX7NyOe2v448r3o12og2iiijdTih
         3ATVy8G4iYFnFiexp+p1+IbQk0C4bdSsJHNwEzt+yGlZbbcBPs55cNXjCFRzIpZ/4Ahy
         bSkg==
X-Gm-Message-State: APjAAAX1Ftsk3wIvpTONfVbX/yH3eitiGCWY96pNYvfciekCCiZoERuO
        VMyhaCCbrXwoXGMbEfxxEjDaJTs+9ray+w==
X-Google-Smtp-Source: APXvYqymEAkGUWAtnN7K9FrtrRO40oVmWwCvmqOr5pGO5wGxl0s4kY82TC1fLohjpj8OdNDvKu9rDA==
X-Received: by 2002:a05:620a:1286:: with SMTP id w6mr93697341qki.219.1560888589499;
        Tue, 18 Jun 2019 13:09:49 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q187sm7592474qkd.19.2019.06.18.13.09.48
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 13:09:48 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/11] btrfs: unexport can_overcommit
Date:   Tue, 18 Jun 2019 16:09:26 -0400
Message-Id: <20190618200926.3352-12-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190618200926.3352-1-josef@toxicpanda.com>
References: <20190618200926.3352-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we've moved all of the users to space-info.c, unexport it and
name it back to can_overcommit.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 23 +++++++++++------------
 fs/btrfs/space-info.h |  4 ----
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 3d6b197e6c0f..4efb817d1f0f 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -185,10 +185,10 @@ static inline u64 calc_global_rsv_need_space(struct btrfs_block_rsv *global)
 	return (global->size << 1);
 }
 
-int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
-			 struct btrfs_space_info *space_info, u64 bytes,
-			 enum btrfs_reserve_flush_enum flush,
-			 bool system_chunk)
+static int can_overcommit(struct btrfs_fs_info *fs_info,
+			  struct btrfs_space_info *space_info, u64 bytes,
+			  enum btrfs_reserve_flush_enum flush,
+			  bool system_chunk)
 {
 	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	u64 profile;
@@ -282,8 +282,7 @@ void btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
 		 * adding the ticket space would be a double count.
 		 */
 		if (check_overcommit &&
-		    !btrfs_can_overcommit(fs_info, space_info, 0, flush,
-					  false))
+		    !can_overcommit(fs_info, space_info, 0, flush, false))
 			break;
 		if (num_bytes >= ticket->bytes) {
 			list_del_init(&ticket->list);
@@ -727,14 +726,14 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 		return to_reclaim;
 
 	to_reclaim = min_t(u64, num_online_cpus() * SZ_1M, SZ_16M);
-	if (btrfs_can_overcommit(fs_info, space_info, to_reclaim,
-				 BTRFS_RESERVE_FLUSH_ALL, system_chunk))
+	if (can_overcommit(fs_info, space_info, to_reclaim,
+			   BTRFS_RESERVE_FLUSH_ALL, system_chunk))
 		return 0;
 
 	used = btrfs_space_info_used(space_info, true);
 
-	if (btrfs_can_overcommit(fs_info, space_info, SZ_1M,
-				 BTRFS_RESERVE_FLUSH_ALL, system_chunk))
+	if (can_overcommit(fs_info, space_info, SZ_1M,
+			   BTRFS_RESERVE_FLUSH_ALL, system_chunk))
 		expected = div_factor_fine(space_info->total_bytes, 95);
 	else
 		expected = div_factor_fine(space_info->total_bytes, 90);
@@ -981,8 +980,8 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 		trace_btrfs_space_reservation(fs_info, "space_info",
 					      space_info->flags, orig_bytes, 1);
 		ret = 0;
-	} else if (btrfs_can_overcommit(fs_info, space_info, orig_bytes, flush,
-					system_chunk)) {
+	} else if (can_overcommit(fs_info, space_info, orig_bytes, flush,
+				  system_chunk)) {
 		btrfs_space_info_update_bytes_may_use(fs_info, space_info,
 						      orig_bytes);
 		trace_btrfs_space_reservation(fs_info, "space_info",
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 05bfd8e5b10e..af9c3b016d6a 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -124,10 +124,6 @@ struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
 u64 btrfs_space_info_used(struct btrfs_space_info *s_info,
 			  bool may_use_included);
 void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
-int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
-			 struct btrfs_space_info *space_info, u64 bytes,
-			 enum btrfs_reserve_flush_enum flush,
-			 bool system_chunk);
 void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 			   struct btrfs_space_info *info, u64 bytes,
 			   int dump_block_groups);
-- 
2.14.3

