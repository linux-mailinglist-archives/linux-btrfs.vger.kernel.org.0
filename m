Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB7614D40C
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 00:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgA2Xu5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 18:50:57 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35853 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgA2Xu4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 18:50:56 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so1035414qto.3
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 15:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hyUq1OaNdTP+EDj//jJSCsTrNAEfoWaviYj/MlWnzdo=;
        b=XkpIblCXMeI+G73RNrhmH1YOKbUDfz6HioI+ZooIPayencQGyUVW/UEDT7qwwdEKJa
         6OtMJsJcPRnMLShYQXauk4gszLZV48vA0ofNtY7SDoc4PfWvrLqXnMjjKGYwbLfiD4jx
         k+kpdG4R0Rtgz2vtBbVEk17F83OphPRNwbSAI9+CKxgD9eQftGZ3sqYE6b8osc2LNIKT
         /vnS0T2jNybzvt/86btVI3j9xovVXhBkRlvxNPyLeHMfQOUh+zgd/aeVbvjDDqERNanA
         mABT2Zo4QKFWhtwPl5kssPi/E252bk+PX1ouAkA4Dp+OwfYo7F48LAWUCWAefKsNzrzf
         coCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hyUq1OaNdTP+EDj//jJSCsTrNAEfoWaviYj/MlWnzdo=;
        b=Je0sPJed4EiwPUNeONDQBB4Otw+DIqps23j1ygLOpWAxxs02VC5ZF8GVcBoUVNcwGC
         2s6b+MYPpzMXhkZJkFKphbd9n0Fb3DMjzCXI7LfHA7dZY5OFGeQColy8QR1dqkuTNgv/
         YpU1WkLEfXqz9JBiYOJV43TqosNDv2nL/t7VdI+rzuMtD4uXkFkyGn+zBjh7NmBY3van
         1o/PhTrrDMQWmmj44VpIR7zKVrY+1QI+I3FL/kLMm73X+V6CmPc4aOR61z8GHtkD6nUv
         p/rVprwV87EulfYLdOIPNGl3gwlORLamXcrEJr7FCJTc+/hd/xkHXXUbS/sgiHz5xDvj
         iYwQ==
X-Gm-Message-State: APjAAAVt1kDVr8RxsmH6xCTKRhu28zdMzdZjccA9vOl5zqMj2dSK5K+9
        xuQ0jnBjRiDIpKqzoDDMcpltGufSb+4CiQ==
X-Google-Smtp-Source: APXvYqzWnG8lQriQQa+mDugZExeGq/cX0byH8//29twSBdUcVktqcZN0i0TLFv/fAVG1CKYyYkuCPg==
X-Received: by 2002:ac8:7158:: with SMTP id h24mr1974633qtp.63.1580341854232;
        Wed, 29 Jan 2020 15:50:54 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u13sm2148537qta.30.2020.01.29.15.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 15:50:53 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 16/20] btrfs: rework chunk allocate for data reservations
Date:   Wed, 29 Jan 2020 18:50:20 -0500
Message-Id: <20200129235024.24774-17-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129235024.24774-1-josef@toxicpanda.com>
References: <20200129235024.24774-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The chunk allocator only allocates chunks in min(10% ofs fs, 1gib)
chunks at a time, but if our data reservation is larger than that we
need to allocate more chunks.  Historically this just magically happened
because we looped through the flushing logic a few times for data
reservations, so we were getting lucky.

Fix this by looping trying to allocate enough space to make our
reservation until it's satisfied or until we cannot allocate chunks
anymore.

Since this may result in too many chunk allocations we'll do our normal
flushing series once, and then fall back on allocate data chunks to
satisfy our reservation.

We will keep our initial one-shot chunk allocation in the normal case
for performance reasons, there's no sense in flushing all the things if
we can just allocate a single chunk and carry on.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 64 ++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 3668c2d4fadf..7a401f1c3724 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -862,17 +862,12 @@ static const enum btrfs_flush_state data_flush_states[] = {
 	COMMIT_TRANS,
 };
 
-static const enum btrfs_flush_state free_space_inode_flush_states[] = {
-	ALLOC_CHUNK_FORCE,
-};
-
-
-static void priority_reclaim_space(struct btrfs_fs_info *fs_info,
-				   struct btrfs_space_info *space_info,
-				   struct reserve_ticket *ticket,
-				   u64 to_reclaim,
-				   const enum btrfs_flush_state *states,
-				   int states_nr)
+static int priority_reclaim_space(struct btrfs_fs_info *fs_info,
+				  struct btrfs_space_info *space_info,
+				  struct reserve_ticket *ticket,
+				  u64 to_reclaim,
+				  const enum btrfs_flush_state *states,
+				  int states_nr)
 {
 	int flush_state = 0;
 	do {
@@ -881,10 +876,11 @@ static void priority_reclaim_space(struct btrfs_fs_info *fs_info,
 		spin_lock(&space_info->lock);
 		if (ticket->bytes == 0) {
 			spin_unlock(&space_info->lock);
-			return;
+			return 0;
 		}
 		spin_unlock(&space_info->lock);
 	} while (flush_state < states_nr);
+	return -ENOSPC;
 }
 
 static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
@@ -906,6 +902,41 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 			       states, states_nr);
 }
 
+static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
+					struct btrfs_space_info *space_info,
+					struct reserve_ticket *ticket,
+					enum btrfs_reserve_flush_enum flush)
+{
+	int ret;
+
+	/*
+	 * First see if we can reclaim pinned space before forcing a bunch of
+	 * chunk allocations.
+	 */
+	if (flush == BTRFS_RESERVE_FLUSH_DATA) {
+		ret = priority_reclaim_space(fs_info, space_info, ticket,
+					     U64_MAX, data_flush_states,
+					     ARRAY_SIZE(data_flush_states));
+		if (!ret)
+			return;
+	}
+
+	/*
+	 * The chunk allocator will only allocate min(10% of the fs, 1gib) at a
+	 * time, but our reservation may be much larger than that threshold, so
+	 * loop allocating chunks until we're able to satisfy our allocation.
+	 */
+	while (1) {
+		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE);
+		spin_lock(&space_info->lock);
+		if (ticket->bytes == 0 || space_info->full) {
+			spin_unlock(&space_info->lock);
+			return;
+		}
+		spin_unlock(&space_info->lock);
+	}
+}
+
 static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info,
 				struct reserve_ticket *ticket)
@@ -972,14 +1003,9 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 						ARRAY_SIZE(evict_flush_states));
 		break;
 	case BTRFS_RESERVE_FLUSH_DATA:
-		priority_reclaim_space(fs_info, space_info, ticket, U64_MAX,
-				       data_flush_states,
-				       ARRAY_SIZE(data_flush_states));
-		break;
 	case BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE:
-		priority_reclaim_space(fs_info, space_info, ticket, U64_MAX,
-				free_space_inode_flush_states,
-				ARRAY_SIZE(free_space_inode_flush_states));
+		priority_reclaim_data_space(fs_info, space_info, ticket,
+					    flush);
 		break;
 	default:
 		ASSERT(0);
-- 
2.24.1

