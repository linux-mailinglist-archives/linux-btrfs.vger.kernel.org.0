Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237894A89FD
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 18:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352839AbiBCR1R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 12:27:17 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47502 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352827AbiBCR1P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 12:27:15 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 416CF21128;
        Thu,  3 Feb 2022 17:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643909234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EvU8lL3FYBqaVC1loovwFyZkzTBq1hN+Y6IyBME0tUQ=;
        b=r2MQ5b3G9OD20S+B40M8pzVOGw4j0W5X4WNqh1B2heiO5nkkIlGEOKoC8ob6V6CSgG76+L
        +s86Fn90PdQWfqRLqfwckck5PnHXxSHu0lauiRHddRuBDwK9IvLN3ijsoUvGgUSkVBxAiG
        Gl8JuX5r7irGTPSfYLOcTjJR1KcfGJc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3BCE6A3B88;
        Thu,  3 Feb 2022 17:27:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3AD89DA781; Thu,  3 Feb 2022 18:26:29 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/5] btrfs: store details about first setget bounds check failure
Date:   Thu,  3 Feb 2022 18:26:29 +0100
Message-Id: <79c2eac1b0c7f0a1769bbe9b9ee4ca8b23ef0132.1643904960.git.dsterba@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643904960.git.dsterba@suse.com>
References: <cover.1643904960.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The way the setget helpers are used makes it hard to return an error
code at the call site, as this would require to clutter a lot of code
with potential failures that are expected to be rare.

Instead, do a delayed reporting, tracked by a filesystem-wide bit that
synchronizes potential races in the reporting function that records only
the first event. To give a bit more insight into the scale, count the
total number of events.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h        | 16 ++++++++++++++--
 fs/btrfs/struct-funcs.c | 12 ++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9f7a950b8a69..5d12a80d09f5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -127,6 +127,13 @@ static inline unsigned long btrfs_chunk_item_size(int num_stripes)
 enum {
 	/* Global indicator of serious filesystem errors */
 	BTRFS_FS_STATE_ERROR,
+	/* Track if a transaction abort has been reported on this filesystem */
+	BTRFS_FS_STATE_TRANS_ABORTED,
+	/*
+	 * There was a failed bounds check in check_setget_bounds, set this on
+	 * first event.
+	 */
+	BTRFS_FS_SETGET_COMPLAINS,
 	/*
 	 * Filesystem is being remounted, allow to skip some operations, like
 	 * defrag
@@ -134,8 +141,6 @@ enum {
 	BTRFS_FS_STATE_REMOUNTING,
 	/* Filesystem in RO mode */
 	BTRFS_FS_STATE_RO,
-	/* Track if a transaction abort has been reported on this filesystem */
-	BTRFS_FS_STATE_TRANS_ABORTED,
 	/*
 	 * Bio operations should be blocked on this filesystem because a source
 	 * or target device is being destroyed as part of a device replace
@@ -1060,6 +1065,13 @@ struct btrfs_fs_info {
 	spinlock_t zone_active_bgs_lock;
 	struct list_head zone_active_bgs;
 
+	/* Store details about the first bounds check failure in report_setget_bounds */
+	u64 setget_eb_start;
+	const void *setget_ptr;
+	unsigned setget_off;
+	int setget_size;
+	atomic_t setget_failures;
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index c97c69e29d64..28b9e62cdc86 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -11,11 +11,23 @@ static void report_setget_bounds(const struct extent_buffer *eb,
 				 const void *ptr, unsigned off, int size)
 {
 	const unsigned long member_offset = (unsigned long)ptr + off;
+	struct btrfs_fs_info *fs_info;
 
 	btrfs_err_rl(eb->fs_info,
 		"bad eb member %s: ptr 0x%lx start %llu member offset %lu size %d",
 		(member_offset > eb->len ? "start" : "end"),
 		(unsigned long)ptr, eb->start, member_offset, size);
+
+	/* Count events and record more details about the first one */
+	fs_info = eb->fs_info;
+	atomic_inc(&fs_info->setget_failures);
+	if (test_and_set_bit(BTRFS_FS_SETGET_COMPLAINS, &eb->fs_info->flags))
+		return;
+
+	fs_info->setget_eb_start = eb->start;
+	fs_info->setget_ptr = ptr;
+	fs_info->setget_off = member_offset;
+	fs_info->setget_size = size;
 }
 
 static inline bool check_setget_bounds(const struct extent_buffer *eb,
-- 
2.34.1

