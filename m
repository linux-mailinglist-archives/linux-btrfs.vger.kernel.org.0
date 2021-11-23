Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE16E45A307
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 13:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbhKWMrf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 07:47:35 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40710 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236641AbhKWMrd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 07:47:33 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 30EE81FD65;
        Tue, 23 Nov 2021 12:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637671465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         in-reply-to:in-reply-to:references:references;
        bh=lk+M5gdYYwTitCeYOUzIuypYNdXIr/ehiUvlDXpFTU8=;
        b=RLJo/7gLoImcoCMZBtZwKrofNH0ZWWmdi6Kjc/nQbsLPhtJNgMWhpaWqwRccNFxuZXsVhP
        CerlAZWbH63FMkbobYdh5hx78Ofl+Qz0hLc44mal4DfTkjv+72nVS07bFkPonhcx4aNWBs
        RYDC+bZkn0/jnpCVTeKJtvRe7vJcr/c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0203113DF4;
        Tue, 23 Nov 2021 12:44:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eInsOSjinGEfdgAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 23 Nov 2021 12:44:24 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/4] btrfs: make __btrfs_add_free_space take just block group reference
Date:   Tue, 23 Nov 2021 14:44:21 +0200
Message-Id: <20211123124422.5830-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211123124422.5830-1-nborisov@suse.com>
References: <20211123124422.5830-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is no point in the function taking an fs_info and a
btrfs_free_space because the ctl passed always belongs to the block
group. Furthermore fs_info can be referenced from the block group. No
functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/free-space-cache.c | 25 ++++++++++---------------
 fs/btrfs/free-space-cache.h |  6 ++----
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 6bc35080afa6..1e1299bfe380 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2442,12 +2442,12 @@ static void steal_from_bitmap(struct btrfs_free_space_ctl *ctl,
 	}
 }
 
-int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
-			   struct btrfs_free_space_ctl *ctl,
+int __btrfs_add_free_space(struct btrfs_block_group *block_group,
 			   u64 offset, u64 bytes,
 			   enum btrfs_trim_state trim_state)
 {
-	struct btrfs_block_group *block_group = ctl->private;
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
+	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	struct btrfs_free_space *info;
 	int ret = 0;
 	u64 filter_bytes = bytes;
@@ -2578,9 +2578,7 @@ int btrfs_add_free_space(struct btrfs_block_group *block_group,
 	if (btrfs_test_opt(block_group->fs_info, DISCARD_SYNC))
 		trim_state = BTRFS_TRIM_STATE_TRIMMED;
 
-	return __btrfs_add_free_space(block_group->fs_info,
-				      block_group->free_space_ctl,
-				      bytenr, size, trim_state);
+	return __btrfs_add_free_space(block_group, bytenr, size, trim_state);
 }
 
 int btrfs_add_free_space_unused(struct btrfs_block_group *block_group,
@@ -2611,9 +2609,7 @@ int btrfs_add_free_space_async_trimmed(struct btrfs_block_group *block_group,
 	    btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
 		trim_state = BTRFS_TRIM_STATE_TRIMMED;
 
-	return __btrfs_add_free_space(block_group->fs_info,
-				      block_group->free_space_ctl,
-				      bytenr, size, trim_state);
+	return __btrfs_add_free_space(block_group, bytenr, size, trim_state);
 }
 
 int btrfs_remove_free_space(struct btrfs_block_group *block_group,
@@ -2708,7 +2704,7 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 			}
 			spin_unlock(&ctl->tree_lock);
 
-			ret = __btrfs_add_free_space(block_group->fs_info, ctl,
+			ret = __btrfs_add_free_space(block_group,
 						     offset + bytes,
 						     old_end - (offset + bytes),
 						     info->trim_state);
@@ -2982,8 +2978,7 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 	spin_unlock(&ctl->tree_lock);
 
 	if (align_gap_len)
-		__btrfs_add_free_space(block_group->fs_info, ctl,
-				       align_gap, align_gap_len,
+		__btrfs_add_free_space(block_group, align_gap, align_gap_len,
 				       align_gap_trim_state);
 	return ret;
 }
@@ -3511,13 +3506,13 @@ static int do_trimming(struct btrfs_block_group *block_group,
 
 	mutex_lock(&ctl->cache_writeout_mutex);
 	if (reserved_start < start)
-		__btrfs_add_free_space(fs_info, ctl, reserved_start,
+		__btrfs_add_free_space(block_group, reserved_start,
 				       start - reserved_start,
 				       reserved_trim_state);
 	if (start + bytes < reserved_start + reserved_bytes)
-		__btrfs_add_free_space(fs_info, ctl, end, reserved_end - end,
+		__btrfs_add_free_space(block_group, end, reserved_end - end,
 				       reserved_trim_state);
-	__btrfs_add_free_space(fs_info, ctl, start, bytes, trim_state);
+	__btrfs_add_free_space(block_group, start, bytes, trim_state);
 	list_del(&trim_entry->list);
 	mutex_unlock(&ctl->cache_writeout_mutex);
 
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 1f23088d43f9..b35137e1f21a 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -101,10 +101,8 @@ int btrfs_write_out_cache(struct btrfs_trans_handle *trans,
 
 void btrfs_init_free_space_ctl(struct btrfs_block_group *block_group,
 			       struct btrfs_free_space_ctl *ctl);
-int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
-			   struct btrfs_free_space_ctl *ctl,
-			   u64 bytenr, u64 size,
-			   enum btrfs_trim_state trim_state);
+int __btrfs_add_free_space(struct btrfs_block_group *block_group, u64 bytenr,
+			   u64 size, enum btrfs_trim_state trim_state);
 int btrfs_add_free_space(struct btrfs_block_group *block_group,
 			 u64 bytenr, u64 size);
 int btrfs_add_free_space_unused(struct btrfs_block_group *block_group,
-- 
2.17.1

