Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B9856B28A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 08:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbiGHGHz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 02:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbiGHGHy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 02:07:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E86C252B2
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 23:07:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C77021D55
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 06:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657260472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xap51VZOxnFM1IGNNJ90fVn58FyLZGlD0JD3GijoaeE=;
        b=KgwG0RJ546s2LXmBDYGGwN8B+4vdcNcj/u2PN5gNl1iP3r79ox6gv5Reu9cCux8tV7QK9K
        Ogm23eRNR4XhOGhmu+vkwVUmpc8NbXKU2iqdsWuCyTUDfjqWQxGyLpo6XYuwuq5IrBza49
        XcCvmPSd+PKzLKUNsRO/Ir7YXBQc2z0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0E6B13A80
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 06:07:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IJmQGrfJx2KUcgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Jul 2022 06:07:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/5] btrfs: introduce BTRFS_QGROUP_STATUS_FLAGS_MASK for later expansion
Date:   Fri,  8 Jul 2022 14:07:27 +0800
Message-Id: <a8b0ed9c35599b80056cfe59dbbf56c41bf977f1.1657260271.git.wqu@suse.com>
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

Currently we only have 3 qgroup flags:
- BTRFS_QGROUP_STATUS_FLAG_ON
- BTRFS_QGROUP_STATUS_FLAG_RESCAN
- BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT

These flags matches the on-disk flags used in btrfs_qgroup_status.

But we're going to introduce extra runtime flags which will not reach
disks.

So here we introduce a new mask, BTRFS_QGROUP_STATUS_FLAGS_MASK, to
make sure only those flags can reach disks.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c               | 6 ++++--
 include/uapi/linux/btrfs_tree.h | 4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index db723c0026bd..c2d07995516b 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -878,7 +878,8 @@ static int update_qgroup_status_item(struct btrfs_trans_handle *trans)
 	l = path->nodes[0];
 	slot = path->slots[0];
 	ptr = btrfs_item_ptr(l, slot, struct btrfs_qgroup_status_item);
-	btrfs_set_qgroup_status_flags(l, ptr, fs_info->qgroup_flags);
+	btrfs_set_qgroup_status_flags(l, ptr, fs_info->qgroup_flags &
+				      BTRFS_QGROUP_STATUS_FLAGS_MASK);
 	btrfs_set_qgroup_status_generation(l, ptr, trans->transid);
 	btrfs_set_qgroup_status_rescan(l, ptr,
 				fs_info->qgroup_rescan_progress.objectid);
@@ -1052,7 +1053,8 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	btrfs_set_qgroup_status_version(leaf, ptr, BTRFS_QGROUP_STATUS_VERSION);
 	fs_info->qgroup_flags = BTRFS_QGROUP_STATUS_FLAG_ON |
 				BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
-	btrfs_set_qgroup_status_flags(leaf, ptr, fs_info->qgroup_flags);
+	btrfs_set_qgroup_status_flags(leaf, ptr, fs_info->qgroup_flags &
+				      BTRFS_QGROUP_STATUS_FLAGS_MASK);
 	btrfs_set_qgroup_status_rescan(leaf, ptr, 0);
 
 	btrfs_mark_buffer_dirty(leaf);
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index d4117152d907..7863f320838e 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -965,6 +965,10 @@ static inline __u16 btrfs_qgroup_level(__u64 qgroupid)
  */
 #define BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT	(1ULL << 2)
 
+#define BTRFS_QGROUP_STATUS_FLAGS_MASK	(BTRFS_QGROUP_STATUS_FLAG_ON |\
+					 BTRFS_QGROUP_STATUS_FLAG_RESCAN |\
+					 BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)
+
 #define BTRFS_QGROUP_STATUS_VERSION        1
 
 struct btrfs_qgroup_status_item {
-- 
2.36.1

