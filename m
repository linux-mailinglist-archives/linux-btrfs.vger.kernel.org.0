Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FFB46AF9A
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 02:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344567AbhLGBUt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 20:20:49 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:60570 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344156AbhLGBUq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 20:20:46 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2EBB81FD54
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 01:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638839836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=duOwEZSMg7o+0zd2sk2Rk2ve31I3HDtj4zz2I9iriu8=;
        b=pUGVWKuIvKJkGGqOsE97biRqwaQPVNe1Dy16Te0DaRCHDTAdl4+IV0XO9UJVp2sXluglnq
        3vQM/YF7FhTOdlFUszbbcPdPAQv5Mm6aEZsEoCYMThT5vub0dNAA6vkqBg+pR4DzNA1EB8
        P6WXlqZSyKFgmEJYLMqgtu8R4nppKx4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BB6D13A5C
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 01:17:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6CnnEBu2rmE8LQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Dec 2021 01:17:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/5] btrfs: introduce BTRFS_QGROUP_STATUS_FLAGS_MASK for later expansion
Date:   Tue,  7 Dec 2021 09:16:52 +0800
Message-Id: <20211207011655.21579-3-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211207011655.21579-1-wqu@suse.com>
References: <20211207011655.21579-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index b126cc39ffd4..d4d81c8df999 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -867,7 +867,8 @@ static int update_qgroup_status_item(struct btrfs_trans_handle *trans)
 	l = path->nodes[0];
 	slot = path->slots[0];
 	ptr = btrfs_item_ptr(l, slot, struct btrfs_qgroup_status_item);
-	btrfs_set_qgroup_status_flags(l, ptr, fs_info->qgroup_flags);
+	btrfs_set_qgroup_status_flags(l, ptr, fs_info->qgroup_flags &
+				      BTRFS_QGROUP_STATUS_FLAGS_MASK);
 	btrfs_set_qgroup_status_generation(l, ptr, trans->transid);
 	btrfs_set_qgroup_status_rescan(l, ptr,
 				fs_info->qgroup_rescan_progress.objectid);
@@ -1035,7 +1036,8 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	btrfs_set_qgroup_status_version(leaf, ptr, BTRFS_QGROUP_STATUS_VERSION);
 	fs_info->qgroup_flags = BTRFS_QGROUP_STATUS_FLAG_ON |
 				BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
-	btrfs_set_qgroup_status_flags(leaf, ptr, fs_info->qgroup_flags);
+	btrfs_set_qgroup_status_flags(leaf, ptr, fs_info->qgroup_flags &
+				      BTRFS_QGROUP_STATUS_FLAGS_MASK);
 	btrfs_set_qgroup_status_rescan(leaf, ptr, 0);
 
 	btrfs_mark_buffer_dirty(leaf);
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 5416f1f1a77a..5debe4b4e452 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -975,6 +975,10 @@ static inline __u16 btrfs_qgroup_level(__u64 qgroupid)
  */
 #define BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT	(1ULL << 2)
 
+#define BTRFS_QGROUP_STATUS_FLAGS_MASK	(BTRFS_QGROUP_STATUS_FLAG_ON |\
+					 BTRFS_QGROUP_STATUS_FLAG_RESCAN |\
+					 BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)
+
 #define BTRFS_QGROUP_STATUS_VERSION        1
 
 struct btrfs_qgroup_status_item {
-- 
2.34.1

