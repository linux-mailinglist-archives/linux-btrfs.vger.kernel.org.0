Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01BB3F3E3A
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Aug 2021 09:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhHVHCu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Aug 2021 03:02:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44176 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhHVHCs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Aug 2021 03:02:48 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 74B9721DD6
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Aug 2021 07:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629615727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fwjeqp6jJmU0XrqVmSV9vzrc9tfdxJuicUroW8mGSOI=;
        b=JKborGLQVQMAttsrm+G+WszacQKPOWB5UaxazzUIFBvwt9U/N/6aGqtfhpMM1krgvg/bxt
        jjOtckIovCbOhQgc9Dh2k4Hq62Ctzz/sCJadX8eJfJuCbk/PFqEP96Ps/CDRhkfLSIH5LP
        nlX6TLFKJXgK063EtFKJElTHbhgzaOQ=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A4BBA13C43
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Aug 2021 07:02:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id MKiaGW72IWHLBwAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Aug 2021 07:02:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 3/4] btrfs: introduce BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup accounting
Date:   Sun, 22 Aug 2021 15:01:59 +0800
Message-Id: <20210822070200.36953-4-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210822070200.36953-1-wqu@suse.com>
References: <20210822070200.36953-1-wqu@suse.com>
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
index 91657ba1ebd1..291c404e8718 100644
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
@@ -1742,6 +1745,10 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 	 */
 	ASSERT(trans != NULL);
 
+	if (trans->fs_info->qgroup_flags &
+	    BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING)
+		return 0;
+
 	ret = btrfs_find_all_roots(NULL, trans->fs_info, bytenr, 0, &old_root,
 				   true);
 	if (ret < 0) {
@@ -2556,7 +2563,8 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	 * If quotas get disabled meanwhile, the resources need to be freed and
 	 * we can't just exit here.
 	 */
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
+	    fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING)
 		goto out_free;
 
 	if (new_roots) {
@@ -2652,7 +2660,8 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 		num_dirty_extents++;
 		trace_btrfs_qgroup_account_extents(fs_info, record);
 
-		if (!ret) {
+		if (!ret && !(fs_info->qgroup_flags &
+			      BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING)) {
 			/*
 			 * Old roots should be searched when inserting qgroup
 			 * extent record
@@ -3386,7 +3395,8 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 
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
2.32.0

