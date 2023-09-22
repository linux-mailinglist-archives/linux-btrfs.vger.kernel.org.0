Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648697AB052
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 13:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbjIVLOJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 07:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjIVLOG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 07:14:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69885AF
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 04:14:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 266D421A56;
        Fri, 22 Sep 2023 11:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695381239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+DJmWxb171UcF3DOATpFN9FYsN5aM/1YXL6/sVmeVzg=;
        b=GUgkTlZv79Phq8MAq+IiVd1Es16/g2NzrbRwW3fYHKnbQsscPBa1wBYJ9YcKPZM0FeMGB/
        C4TjOxAPsLWwC5vpjP+DcYfgBY8OKhIeFQc6OQa3LR5iKF+b1ziYZEXzPELpCpJfZbcGRK
        loaBzETkl1iRA1l4zKgb5mkGCUlSWW0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0CB0D2C142;
        Fri, 22 Sep 2023 11:13:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 402ADDA832; Fri, 22 Sep 2023 13:07:25 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 6/8] btrfs: relocation: return bool from btrfs_should_ignore_reloc_root
Date:   Fri, 22 Sep 2023 13:07:25 +0200
Message-ID: <54a6cbc4c91d872ec7eb9d1f7c1240d137fcfe5b.1695380646.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695380646.git.dsterba@suse.com>
References: <cover.1695380646.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_should_ignore_reloc_root() is a predicate so it should return
bool.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/relocation.c | 19 +++++++++----------
 fs/btrfs/relocation.h |  2 +-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 75463377f418..d1dcbb15baa7 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -325,31 +325,30 @@ static bool have_reloc_root(struct btrfs_root *root)
 	return true;
 }
 
-int btrfs_should_ignore_reloc_root(struct btrfs_root *root)
+bool btrfs_should_ignore_reloc_root(struct btrfs_root *root)
 {
 	struct btrfs_root *reloc_root;
 
 	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
-		return 0;
+		return false;
 
 	/* This root has been merged with its reloc tree, we can ignore it */
 	if (reloc_root_is_dead(root))
-		return 1;
+		return true;
 
 	reloc_root = root->reloc_root;
 	if (!reloc_root)
-		return 0;
+		return false;
 
 	if (btrfs_header_generation(reloc_root->commit_root) ==
 	    root->fs_info->running_transaction->transid)
-		return 0;
+		return false;
 	/*
-	 * if there is reloc tree and it was created in previous
-	 * transaction backref lookup can find the reloc tree,
-	 * so backref node for the fs tree root is useless for
-	 * relocation.
+	 * If there is reloc tree and it was created in previous transaction
+	 * backref lookup can find the reloc tree, so backref node for the fs
+	 * tree root is useless for relocation.
 	 */
-	return 1;
+	return true;
 }
 
 /*
diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
index 77d69f6ae967..af749c780b4e 100644
--- a/fs/btrfs/relocation.h
+++ b/fs/btrfs/relocation.h
@@ -18,7 +18,7 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 			      struct btrfs_pending_snapshot *pending);
 int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info);
 struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info, u64 bytenr);
-int btrfs_should_ignore_reloc_root(struct btrfs_root *root);
+bool btrfs_should_ignore_reloc_root(struct btrfs_root *root);
 u64 btrfs_get_reloc_bg_bytenr(struct btrfs_fs_info *fs_info);
 
 #endif
-- 
2.41.0

