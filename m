Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF1B6C300C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjCULPJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjCULPD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:15:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6A936083
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E120661AE3
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C1AC4339B
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397264;
        bh=xhDIXlapDsSvaL087fSXlZVNLBMQqHq8SOQJRYoqb3I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MPOgLVOYLZJWGGKF1jtIlM5F3ZPltgTG3eZrf+edmx2+UHhabPpIX0yz8BC/Semxh
         t0GM9r87igfaaiUC9PAM7JgNjJ1LsFUsjVgU/tgllNrmWOfdaHrDmGODoqlU5NJJRJ
         363je/MGihSEcpBgGBgzzw4ApRBtPta3UMPS/8wiXikouUHo7mL5L4rC0l1I+31DEK
         SBeCPuuSdiCjN5Xo1IJkLWdHYET50+NzXlfJGG8akoGF4FZSiPW6ehgsRgsTkrDq9Z
         nlPctaM5Nj/PGUhww3TQ6wnatGdf4T6AuEc1zDLcQcnjyrdNj/8XeckXF0gZoLvPEZ
         5BmhsMFABBvQQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 22/24] btrfs: use a constant for the number of metadata units needed for an unlink
Date:   Tue, 21 Mar 2023 11:13:58 +0000
Message-Id: <25c3d88a6f706ae21fa100159e0aedacb6c75230.1679326434.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679326426.git.fdmanana@suse.com>
References: <cover.1679326426.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Instead of hard coding the number of metadata units for an unlink operation
in a couple places, define a macro and use it instead. This eliminates the
problem of one place getting out of sync with the other, such as recently
fixed by the previous patch in the series ("btrfs: fix calculation of the
global block reserve's size").

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-rsv.c | 11 ++++++-----
 fs/btrfs/fs.h        | 12 ++++++++++++
 fs/btrfs/inode.c     | 11 ++---------
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 6edcb32ed4c9..b4a1f1bc340f 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -350,14 +350,15 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 
 	/*
 	 * But we also want to reserve enough space so we can do the fallback
-	 * global reserve for an unlink, which is an additional 6 items (see the
-	 * comment in __unlink_start_trans for what we're modifying.)
+	 * global reserve for an unlink, which is an additional
+	 * BTRFS_UNLINK_METADATA_UNITS items.
 	 *
 	 * But we also need space for the delayed ref updates from the unlink,
-	 * so its 12, 6 for the actual operation, and 6 for the delayed ref
-	 * updates.
+	 * so it's BTRFS_UNLINK_METADATA_UNITS * 2, BTRFS_UNLINK_METADATA_UNITS
+	 * for the actual operation, and BTRFS_UNLINK_METADATA_UNITS more for
+	 * the delayed ref updates.
 	 */
-	min_items += 12;
+	min_items += BTRFS_UNLINK_METADATA_UNITS * 2;
 
 	num_bytes = max_t(u64, num_bytes,
 			  btrfs_calc_insert_metadata_size(fs_info, min_items));
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 0ce43318ac0e..ca17a7fc3ac3 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -24,6 +24,18 @@
 #define BTRFS_SUPER_INFO_SIZE			4096
 static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 
+/*
+ * Number of metadata items necessary for an unlink operation:
+ *
+ * 1 for the possible orphan item
+ * 1 for the dir item
+ * 1 for the dir index
+ * 1 for the inode ref
+ * 1 for the inode
+ * 1 for the parent inode
+ */
+#define BTRFS_UNLINK_METADATA_UNITS		6
+
 /*
  * The reserved space at the beginning of each device.  It covers the primary
  * super block and leaves space for potential use by other tools like
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2e181a0a6f37..0b3710d47dd0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4248,15 +4248,8 @@ static struct btrfs_trans_handle *__unlink_start_trans(struct btrfs_inode *dir)
 {
 	struct btrfs_root *root = dir->root;
 
-	/*
-	 * 1 for the possible orphan item
-	 * 1 for the dir item
-	 * 1 for the dir index
-	 * 1 for the inode ref
-	 * 1 for the inode
-	 * 1 for the parent inode
-	 */
-	return btrfs_start_transaction_fallback_global_rsv(root, 6);
+	return btrfs_start_transaction_fallback_global_rsv(root,
+						   BTRFS_UNLINK_METADATA_UNITS);
 }
 
 static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
-- 
2.34.1

