Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E2953FE33
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 14:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbiFGMBj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 08:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiFGMBi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 08:01:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40704C9EC6
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 05:01:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F1BE11F95C
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 12:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654603295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=GvlMGZU7tKS7ye+mxlN0GMQTX/ZJbQxpETWtPKUwtLs=;
        b=hi75bMt6bMfkCZoL4iw/YXf5t3AlG62tNonrPNl68zY6qcm94Gf+uzrCBFqae9WmdCnIRF
        H4RU+Qze3hpweihG3vE4ttSxh8UITXqiMD3VdPVk9KHKW2+HDarR61cqcRIUqaL9nCFZdj
        +oTxGQWj67cZ7WN9uzxN9jxCeVsSKsE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 420DD13638
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 12:01:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xOknAh8+n2LeewAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jun 2022 12:01:35 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: make btrfs_super_block::log_root_transid deprecated
Date:   Tue,  7 Jun 2022 20:01:17 +0800
Message-Id: <ad5b8dbe66567eddd09025cf46114cc9412d1add.1654603274.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
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

This is the same on-disk format update synchronized from the kernel
code.

Unlike kernel, there are two callers reading this member:

- btrfs inspect dump-super
  It's just outputting the value, since it's always 0 we can skip
  that output.

- btrfs-find-root
  In that case, since we always got 0, the root search for log root
  should never find a perfect match.

  Use btrfs_super_geneartion() + 1 to provide a better result.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfs-find-root.c          |  2 +-
 kernel-shared/ctree.h      | 11 +++++++----
 kernel-shared/print-tree.c |  2 --
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/btrfs-find-root.c b/btrfs-find-root.c
index e328334034ea..5ae808cc5def 100644
--- a/btrfs-find-root.c
+++ b/btrfs-find-root.c
@@ -249,7 +249,7 @@ static void get_root_gen_and_level(u64 objectid, struct btrfs_fs_info *fs_info,
 		break;
 	case BTRFS_TREE_LOG_OBJECTID:
 		level = btrfs_super_log_root_level(super);
-		gen = btrfs_super_log_root_transid(super);
+		gen = btrfs_super_generation(super) + 1;
 		break;
 	case BTRFS_UUID_TREE_OBJECTID:
 		gen = btrfs_super_uuid_tree_generation(super);
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index fc8b61eda829..5d1d07b1d308 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -426,8 +426,13 @@ struct btrfs_super_block {
 	__le64 chunk_root;
 	__le64 log_root;
 
-	/* this will help find the new super based on the log root */
-	__le64 log_root_transid;
+	/*
+	 * This member is never utlized from the very beginning of btrfs, thus
+	 * it's always 0 no matter kernel versions.
+	 * We always use generation + 1 to read log tree root.
+	 * So here we mark it deprecated.
+	 */
+	__le64 __unused_log_root_transid;
 	__le64 total_bytes;
 	__le64 bytes_used;
 	__le64 root_dir_objectid;
@@ -2334,8 +2339,6 @@ BTRFS_SETGET_STACK_FUNCS(super_chunk_root_level, struct btrfs_super_block,
 			 chunk_root_level, 8);
 BTRFS_SETGET_STACK_FUNCS(super_log_root, struct btrfs_super_block,
 			 log_root, 64);
-BTRFS_SETGET_STACK_FUNCS(super_log_root_transid, struct btrfs_super_block,
-			 log_root_transid, 64);
 BTRFS_SETGET_STACK_FUNCS(super_log_root_level, struct btrfs_super_block,
 			 log_root_level, 8);
 BTRFS_SETGET_STACK_FUNCS(super_total_bytes, struct btrfs_super_block,
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index a5886ff602ee..7285d471c81b 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -2014,8 +2014,6 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
 	       (unsigned long long)btrfs_super_chunk_root_level(sb));
 	printf("log_root\t\t%llu\n",
 	       (unsigned long long)btrfs_super_log_root(sb));
-	printf("log_root_transid\t%llu\n",
-	       (unsigned long long)btrfs_super_log_root_transid(sb));
 	printf("log_root_level\t\t%llu\n",
 	       (unsigned long long)btrfs_super_log_root_level(sb));
 	printf("total_bytes\t\t%llu\n",
-- 
2.36.1

