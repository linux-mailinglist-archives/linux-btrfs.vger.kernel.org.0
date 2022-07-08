Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED57856B289
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 08:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbiGHGH6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 02:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbiGHGH4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 02:07:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A15424F17
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 23:07:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CF73F21D55
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 06:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657260474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZgE/NvbxUZrxn493zZPrNShAuZy0i4HUW2TWbxht4A=;
        b=Xefeb1kjc3T5xkM4XlR5FUCwMk1bebsqa2I3/hMnQUpeHDA8tug8YCtWrFSyGJ42Kr8cOU
        mGiTAabiVxyxnERGTWuf0q1dgF0yBITb7xbJ2OYGhigyZybUzXKBjLApNtLJrZTQvghTcS
        XkbjdbeXkeUrCNq8jG8ZT+0Sz4sWRLQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFBD913A80
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 06:07:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YDXkIbnJx2KUcgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Jul 2022 06:07:53 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 4/5] btrfs: introduce BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup accounting
Date:   Fri,  8 Jul 2022 14:07:29 +0800
Message-Id: <2101234c3d491846623724f6d5dbd31fe7831093.1657260271.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657260271.git.wqu@suse.com>
References: <cover.1657260271.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 57e24a8ebc2a..32aef75af9b7 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -337,8 +337,11 @@ static void qgroup_mark_inconsistent(struct btrfs_fs_info *fs_info)
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
@@ -1800,6 +1803,10 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 	 */
 	ASSERT(trans != NULL);
 
+	if (trans->fs_info->qgroup_flags &
+	    BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING)
+		return 0;
+
 	ret = btrfs_find_all_roots(NULL, trans->fs_info, bytenr, 0, &old_root,
 				   true);
 	if (ret < 0) {
@@ -2614,7 +2621,8 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	 * If quotas get disabled meanwhile, the resources need to be freed and
 	 * we can't just exit here.
 	 */
-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
+	    fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING)
 		goto out_free;
 
 	if (new_roots) {
@@ -2710,7 +2718,8 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 		num_dirty_extents++;
 		trace_btrfs_qgroup_account_extents(fs_info, record);
 
-		if (!ret) {
+		if (!ret && !(fs_info->qgroup_flags &
+			      BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING)) {
 			/*
 			 * Old roots should be searched when inserting qgroup
 			 * extent record
@@ -3448,7 +3457,8 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 
 	memset(&fs_info->qgroup_rescan_progress, 0,
 		sizeof(fs_info->qgroup_rescan_progress));
-	fs_info->qgroup_flags &= ~BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN;
+	fs_info->qgroup_flags &= ~(BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN |
+				   BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING);
 	fs_info->qgroup_rescan_progress.objectid = progress_objectid;
 	init_completion(&fs_info->qgroup_rescan_completion);
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 90d3632c5524..578c77e94200 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -101,6 +101,7 @@
  */
 
 #define BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN		(1UL << 3)
+#define BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING		(1UL << 4)
 
 /*
  * Record a dirty extent, and info qgroup to update quota on it
-- 
2.36.1

