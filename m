Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3B73F3E37
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Aug 2021 09:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhHVHCs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Aug 2021 03:02:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54392 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhHVHCq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Aug 2021 03:02:46 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0AAA91FEDD
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Aug 2021 07:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629615725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q/Ys2L+I3S27cgN9QMiNbpmIE5za3Gc4evRRg1t+TAU=;
        b=X/bHZpXhOUzSVXhzOmi4V9uM4O3wAg+X4tl4KJXzxs+HAyB7AG48u/oQ7PXBOVBjog58Je
        ei2BIRUhNhww562t0hW5G49UaqcL+9F3/PGV2QcdvPFHgz7N+ipm/oFavC1/bZgJCxm2+Q
        mGIe6kcFY6xW0NW3Y66+zualO8EiuWw=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3C62113C43
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Aug 2021 07:02:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id APtoAGz2IWHLBwAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Aug 2021 07:02:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 1/4] btrfs: introduce BTRFS_QGROUP_STATUS_FLAGS_MASK for later expansion
Date:   Sun, 22 Aug 2021 15:01:57 +0800
Message-Id: <20210822070200.36953-2-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210822070200.36953-1-wqu@suse.com>
References: <20210822070200.36953-1-wqu@suse.com>
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
index db680f5be745..9babf925bd59 100644
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
@@ -1027,7 +1028,8 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	btrfs_set_qgroup_status_version(leaf, ptr, BTRFS_QGROUP_STATUS_VERSION);
 	fs_info->qgroup_flags = BTRFS_QGROUP_STATUS_FLAG_ON |
 				BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
-	btrfs_set_qgroup_status_flags(leaf, ptr, fs_info->qgroup_flags);
+	btrfs_set_qgroup_status_flags(leaf, ptr, fs_info->qgroup_flags &
+				      BTRFS_QGROUP_STATUS_FLAGS_MASK);
 	btrfs_set_qgroup_status_rescan(leaf, ptr, 0);
 
 	btrfs_mark_buffer_dirty(leaf);
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index e1c4c732aaba..86dbd13a88f3 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -973,6 +973,10 @@ static inline __u16 btrfs_qgroup_level(__u64 qgroupid)
  */
 #define BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT	(1ULL << 2)
 
+#define BTRFS_QGROUP_STATUS_FLAGS_MASK	(BTRFS_QGROUP_STATUS_FLAG_ON |\
+					 BTRFS_QGROUP_STATUS_FLAG_RESCAN |\
+					 BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)
+
 #define BTRFS_QGROUP_STATUS_VERSION        1
 
 struct btrfs_qgroup_status_item {
-- 
2.32.0

