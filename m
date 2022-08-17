Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E1E596D81
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 13:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbiHQLXK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 07:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiHQLXH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 07:23:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7538C113
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 04:23:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BDD4B81CD1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD37C433C1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660735383;
        bh=x8BSqGugTS6NCFR4Ed40bSJN1R2bqTqkyp500w7s47M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=e8Ni7L5mXZNT5D/5Cy0yA8rPha+fL/1jc3vN7WcI7BMjL6XypaOjf9tZ2ekTwMfKA
         YtTfHQ90xsjXBNENkuNfwoZJp0l3C3CZaOL2Ov3tBa9SP5/LmdEcva2yIotPLFby5a
         gsD0Qni5UxFEVVi9vgVogvbv+Kpo4gvATEE0hUkAR0QQc9OrLWf3f3SaJf3RfHLhu0
         zJnL4e0MIFpyZ7AokoZkkOIMCPH8DoR1fx6rydBScwfcDPr79K3LOpFoTYAT3vMdu8
         H13rYgVF81sti7Uzwapm/pD087b89RLiuxajQoBFFRdL+ddihbOkg2ZJxBz1jdERlw
         CdYkaxMajvEfg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/15] btrfs: search for last logged dir index if it's not cached in the inode
Date:   Wed, 17 Aug 2022 12:22:43 +0100
Message-Id: <a9117bbdd5d3d0c4378a599eb6d856b577aea6c3.1660735025.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660735024.git.fdmanana@suse.com>
References: <cover.1660735024.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The key offset of the last dir index item that was logged is stored in
the inode's last_dir_index_offset field. However that field is not
persisted in the inode item or elsewhere, so if the inode gets evicted
and reloaded, it gets a value of (u64)-1, so that when we are logging
dir index items we check if they were logged before, to avoid attempts
to insert duplicated keys and fallback to a transaction commit.

Improve on this by searching for the last dir index that was logged when
we start logging a directory if the inode's last_dir_index_offset is not
set (has a value of (u64)-1) and it was not logged before. This avoids
checking if each dir index item we find was already logged before.

This will also be needed for an incoming change where we start logging
delayed items directly, without flushing them first.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 54 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 94026098bb68..4678bf5d6224 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3995,6 +3995,56 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 	return err;
 }
 
+/*
+ * If the inode was logged before and it was evicted, then its
+ * last_dir_index_offset is (u64)-1, so we don't the value of the last index
+ * key offset. If that's the case, search for it and update the inode. This
+ * is to avoid lookups in the log tree every time we try to insert a dir index
+ * key from a leaf changed in the current transaction, and to allow us to always
+ * do batch insertions of dir index keys.
+ */
+static int update_last_dir_index_offset(struct btrfs_inode *inode,
+					struct btrfs_path *path,
+					const struct btrfs_log_ctx *ctx)
+{
+	const u64 ino = btrfs_ino(inode);
+	struct btrfs_key key;
+	int ret;
+
+	lockdep_assert_held(&inode->log_mutex);
+
+	if (inode->last_dir_index_offset != (u64)-1)
+		return 0;
+
+	if (!ctx->logged_before) {
+		inode->last_dir_index_offset = BTRFS_DIR_START_INDEX - 1;
+		return 0;
+	}
+
+	key.objectid = ino;
+	key.type = BTRFS_DIR_INDEX_KEY;
+	key.offset = (u64)-1;
+
+	ret = btrfs_search_slot(NULL, inode->root->log_root, &key, path, 0, 0);
+	if (ret <= 0)
+		goto out;
+
+	ret = 0;
+	inode->last_dir_index_offset = BTRFS_DIR_START_INDEX - 1;
+
+	if (path->slots[0] == 0)
+		goto out;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0] - 1);
+	if (key.objectid == ino && key.type == BTRFS_DIR_INDEX_KEY)
+		inode->last_dir_index_offset = key.offset;
+
+out:
+	btrfs_release_path(path);
+
+	return ret;
+}
+
 /*
  * logging directories is very similar to logging inodes, We find all the items
  * from the current transaction and write them to the log.
@@ -4017,6 +4067,10 @@ static noinline int log_directory_changes(struct btrfs_trans_handle *trans,
 	u64 max_key;
 	int ret;
 
+	ret = update_last_dir_index_offset(inode, path, ctx);
+	if (ret)
+		return ret;
+
 	min_key = BTRFS_DIR_START_INDEX;
 	max_key = 0;
 	ctx->last_dir_item_offset = inode->last_dir_index_offset;
-- 
2.35.1

