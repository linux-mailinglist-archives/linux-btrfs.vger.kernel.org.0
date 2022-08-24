Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070F159F0B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 03:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiHXBOf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 21:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiHXBOd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 21:14:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AC16CD30
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 18:14:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 95C12336B7
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 01:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661303670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O/qb5MK/9CS/Wu1DYyYM3pWgh1I3SoRtvg7XxnDVGJ8=;
        b=gq0glOFExw4lXOIM3XeK5j5SCLB+JvWGoY1cgJgkb1ywr/JT2Tl0qZHoa0j/lHBggZc34h
        DDoocqaklyp7lSYfG+deT3EURylF2qaUfEVXX0YNADNhff1F1C7SX6v2+uo65u7538i8+G
        kCYhm9XQhu+7g5GajrXPQFy/IBO25Xw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA1F213A89
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 01:14:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wAVyJ3V7BWNnWAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 01:14:29 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 2/5] btrfs: introduce BTRFS_QGROUP_STATUS_FLAGS_MASK for later expansion
Date:   Wed, 24 Aug 2022 09:14:06 +0800
Message-Id: <9eef0d25f4e268caab250064f65e0a5c365ad9bd.1661302005.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1661302005.git.wqu@suse.com>
References: <cover.1661302005.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
index ba323dcb0a0b..fc2ed19ced9b 100644
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
index 5f32a2a495dc..804b40fe455a 100644
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
2.37.2

