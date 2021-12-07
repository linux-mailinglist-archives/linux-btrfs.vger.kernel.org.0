Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DB346AF9C
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 02:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344676AbhLGBUv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 20:20:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:60576 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344230AbhLGBUt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 20:20:49 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CACC01FD54
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 01:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638839838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R0nwq6x+TF5/NGa5WhjgYTaH+FlklJ9gMvpwMMbkn88=;
        b=feejefxMybUvViy+6xG/RgGdV6Tg/n007ODk7YbDctTAVXM7qrw5E1LalQPIhc69VN3Uz7
        o044iFGzJpsLrcy+odhvf+ybnGzDFJzkVkENQN5dcmWbhwEH7ESZfMnV32lft51Qi+K+tu
        DT95GLloKnygfHXT+DCaPkrk37n8x6k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2573013A5C
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 01:17:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mHkDHR22rmE8LQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Dec 2021 01:17:17 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/5] btrfs: introduce BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup accounting
Date:   Tue,  7 Dec 2021 09:16:54 +0800
Message-Id: <20211207011655.21579-5-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211207011655.21579-1-wqu@suse.com>
References: <20211207011655.21579-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new flag will make btrfs qgroup to skip all its time consuming
qgroup accounting.

The lifespan is the same as BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN,
only get cleared after a new rescan.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 18 ++++++++++++++----
 fs/btrfs/qgroup.h |  1 +
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index d7c03b8ab926..6977ce093993 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -326,8 +326,11 @@ static void qgroup_mark_inconsistent(struct btrfs_fs_info *fs_info)
 {
 	BUILD_BUG_ON(BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN &
 		     BTRFS_QGROUP_STATUS_FLAGS_MASK);
+	BUILD_BUG_ON(BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING &
+		     BTRFS_QGROUP_STATUS_FLAGS_MASK);
 	fs_info->qgroup_flags |= (BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT |
-				  BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN);
+				  BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN |
+				  BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING);
 }
 
 /*
@@ -1761,6 +1764,10 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 	 */
 	ASSERT(trans != NULL);
 
+	if (trans->fs_info->qgroup_flags &
+	    BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING)
+		return 0;
+
 	ret = btrfs_find_all_roots(NULL, trans->fs_info, bytenr, 0, &old_root,
 				   true);
 	if (ret < 0) {
@@ -2575,7 +2582,8 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	 * If quotas get disabled meanwhile, the resources need to be freed and
 	 * we can't just exit here.
 	 */
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
+	    fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING)
 		goto out_free;
 
 	if (new_roots) {
@@ -2671,7 +2679,8 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 		num_dirty_extents++;
 		trace_btrfs_qgroup_account_extents(fs_info, record);
 
-		if (!ret) {
+		if (!ret && !(fs_info->qgroup_flags &
+			      BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING)) {
 			/*
 			 * Old roots should be searched when inserting qgroup
 			 * extent record
@@ -3408,7 +3417,8 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 
 	memset(&fs_info->qgroup_rescan_progress, 0,
 		sizeof(fs_info->qgroup_rescan_progress));
-	fs_info->qgroup_flags &= ~BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN;
+	fs_info->qgroup_flags &= ~(BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN |
+				   BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING);
 	fs_info->qgroup_rescan_progress.objectid = progress_objectid;
 	init_completion(&fs_info->qgroup_rescan_completion);
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index f92e635bfb69..fe42975dcea7 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -101,6 +101,7 @@
  */
 
 #define BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN		(1UL << 3)
+#define BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING		(1UL << 4)
 
 /*
  * Record a dirty extent, and info qgroup to update quota on it
-- 
2.34.1

