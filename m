Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 697AD903DF
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 16:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfHPOUH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 10:20:07 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40327 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfHPOUG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 10:20:06 -0400
Received: by mail-qk1-f194.google.com with SMTP id s145so4816289qke.7
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 07:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=B0u3dNaxmo1oe1+tYLlm/QD+8MJtMyi6w2gf440T4A4=;
        b=mIRQhxg7MVOrQpBHpxVL1fmvdy3olIw6OaELj9+i3NLKCrAyRt+8TLD2fnN7gmoIQj
         omKmVp+Y8Km0tCXbbTPmDS0VwSo9cbDF9nuyoD79Nw13Ii76n05rD/qNKkSEQNBFRvMN
         M2p1wJYBG1fa3rHL7VV67P19AVrTGY85+BNQXfMAcxY3HhHGmatjGjTz8AUo9oPv7Qk9
         uIPJXMAxb+civB8TMf3o49I3bHCp8djvh+BU6QYAV2DZFXSDeTc49dm9lxoBYRkQqaGW
         gOgyfYStRWdY+ZPZtbjMf6wKa0rIBgqkSbceqnAQR9uY6jtMH9B2oX7V1GvmtFmNKUYZ
         xDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B0u3dNaxmo1oe1+tYLlm/QD+8MJtMyi6w2gf440T4A4=;
        b=MG+5pzpM10Toa8kvqDWVVU22944J2UxA8w/h2H28eC8Ctr9jMGyfJq9u8TifLvNmTV
         4kDtcJqqKUmZw6kuNSVhMWuuKtLAg4ByuDijKGyzk6/FAk1a+8n+J1kFH3y/wONOzgPv
         +DSf9N3N4Vr+lJC72TsnWWMqAJBdt87b8L+KxpF7LVm1oUw6dUCszTM/IIFzf+ekCPUx
         Qr+CYZBaFqf59rhyAtnQpMXNoKeElrnTUbOs1LJ694p4OAyMR5SBrBxUU4IeHiq5pnd7
         lZUVv1ib8cWS/A6ej4mThPXyC0KF9ROpQZksA/6XiOc46Ah9re4z8lkNDswG5pj1c0ez
         4viw==
X-Gm-Message-State: APjAAAWWhbyNQ+1sHAt0yOG+qqDdDKOyq2IR4CLaHk73ycuH6PwZwCs4
        cUFmumwYGbIPVwuPSMynSfi48luOLyl4kA==
X-Google-Smtp-Source: APXvYqy7RmqkWYxBnCNRx/GQ08k3MC4jLEezmjAGTenfRxsL3MWby90dJRO9CJjwm3mpSUPcCX/TsA==
X-Received: by 2002:a05:620a:11ba:: with SMTP id c26mr8089757qkk.201.1565965204684;
        Fri, 16 Aug 2019 07:20:04 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o29sm3221637qtf.19.2019.08.16.07.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 07:20:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/8] btrfs: refactor the ticket wakeup code
Date:   Fri, 16 Aug 2019 10:19:49 -0400
Message-Id: <20190816141952.19369-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816141952.19369-1-josef@toxicpanda.com>
References: <20190816141952.19369-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that btrfs_space_info_add_old_bytes simply checks if we can make the
reservation and updates bytes_may_use, there's no reason to have both
helpers in place.  Factor out the ticket wakeup logic into it's own
helper, make btrfs_space_info_add_old_bytes() update bytes_may_use and
then call the wakeup helper, and replace all calls to
btrfs_space_info_add_new_bytes() with the wakeup helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c |  4 ++--
 fs/btrfs/space-info.c  | 53 +++---------------------------------------
 fs/btrfs/space-info.h  | 19 ++++++++++-----
 3 files changed, 18 insertions(+), 58 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 32f9473c8426..08c6fcfc418d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2863,8 +2863,8 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 			spin_unlock(&global_rsv->lock);
 			/* Add to any tickets we may have */
 			if (len)
-				btrfs_space_info_add_new_bytes(fs_info,
-						space_info, len);
+				btrfs_try_to_wakeup_tickets(fs_info,
+							    space_info);
 		}
 		spin_unlock(&space_info->lock);
 	}
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 5f123b36fdcd..8a1c7ada67cb 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -131,9 +131,7 @@ void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 	found->bytes_readonly += bytes_readonly;
 	if (total_bytes > 0)
 		found->full = 0;
-	btrfs_space_info_add_new_bytes(info, found,
-				       total_bytes - bytes_used -
-				       bytes_readonly);
+	btrfs_try_to_wakeup_tickets(info, found);
 	spin_unlock(&found->lock);
 	*space_info = found;
 }
@@ -229,17 +227,13 @@ static int can_overcommit(struct btrfs_fs_info *fs_info,
  * This is for space we already have accounted in space_info->bytes_may_use, so
  * basically when we're returning space from block_rsv's.
  */
-void btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *space_info,
-				    u64 num_bytes)
+void btrfs_try_to_wakeup_tickets(struct btrfs_fs_info *fs_info,
+				 struct btrfs_space_info *space_info)
 {
 	struct list_head *head;
 	enum btrfs_reserve_flush_enum flush = BTRFS_RESERVE_NO_FLUSH;
 
-	spin_lock(&space_info->lock);
 	head = &space_info->priority_tickets;
-	btrfs_space_info_update_bytes_may_use(fs_info, space_info, -num_bytes);
-
 again:
 	while (!list_empty(head)) {
 		struct reserve_ticket *ticket;
@@ -268,47 +262,6 @@ void btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
 		flush = BTRFS_RESERVE_FLUSH_ALL;
 		goto again;
 	}
-	spin_unlock(&space_info->lock);
-}
-
-/*
- * This is for newly allocated space that isn't accounted in
- * space_info->bytes_may_use yet.  So if we allocate a chunk or unpin an extent
- * we use this helper.
- */
-void btrfs_space_info_add_new_bytes(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *space_info,
-				    u64 num_bytes)
-{
-	struct reserve_ticket *ticket;
-	struct list_head *head = &space_info->priority_tickets;
-
-again:
-	while (!list_empty(head) && num_bytes) {
-		ticket = list_first_entry(head, struct reserve_ticket,
-					  list);
-		if (num_bytes >= ticket->bytes) {
-			list_del_init(&ticket->list);
-			num_bytes -= ticket->bytes;
-			btrfs_space_info_update_bytes_may_use(fs_info,
-							      space_info,
-							      ticket->bytes);
-			ticket->bytes = 0;
-			space_info->tickets_id++;
-			wake_up(&ticket->wait);
-		} else {
-			btrfs_space_info_update_bytes_may_use(fs_info,
-							      space_info,
-							      num_bytes);
-			ticket->bytes -= num_bytes;
-			num_bytes = 0;
-		}
-	}
-
-	if (num_bytes && head == &space_info->priority_tickets) {
-		head = &space_info->tickets;
-		goto again;
-	}
 }
 
 #define DUMP_BLOCK_RSV(fs_info, rsv_name)				\
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 025f7ce2c9b1..9ae5cae52fde 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -110,12 +110,6 @@ btrfs_space_info_update_##name(struct btrfs_fs_info *fs_info,		\
 DECLARE_SPACE_INFO_UPDATE(bytes_may_use, "space_info");
 DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
 
-void btrfs_space_info_add_new_bytes(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *space_info,
-				    u64 num_bytes);
-void btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *space_info,
-				    u64 num_bytes);
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
 void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 			     u64 total_bytes, u64 bytes_used,
@@ -133,5 +127,18 @@ int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
 				 struct btrfs_block_rsv *block_rsv,
 				 u64 orig_bytes,
 				 enum btrfs_reserve_flush_enum flush);
+void btrfs_try_to_wakeup_tickets(struct btrfs_fs_info *fs_info,
+				 struct btrfs_space_info *space_info);
+
+static inline void
+btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
+			       struct btrfs_space_info *space_info,
+			       u64 num_bytes)
+{
+	spin_lock(&space_info->lock);
+	btrfs_space_info_update_bytes_may_use(fs_info, space_info, -num_bytes);
+	btrfs_try_to_wakeup_tickets(fs_info, space_info);
+	spin_unlock(&space_info->lock);
+}
 
 #endif /* BTRFS_SPACE_INFO_H */
-- 
2.21.0

