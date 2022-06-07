Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEA653FDFA
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 13:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243209AbiFGLv4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 07:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243213AbiFGLvp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 07:51:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E3BB7167
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 04:51:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 131AC1F95B;
        Tue,  7 Jun 2022 11:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654602678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UnjOFeAK+aoEDLeK+jMwTdOtPZvf+zLnD9axg8vIBUc=;
        b=t7xFoSKz2B240VBlgwWWbEz7lrxN41PQfQZEpXdngicLeYCRSqn+KZL5PXNylwk7Kbm8RU
        xtA/4ckCfS6kffoaoDFVFYOCBIjHta4FmqqXVNOyvkZ7EPRH/OkKNcWFkY/ZXGgY1LUGxY
        EfK1K7UHozrnA6sXnJAGKiVmSYp30+8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B85913638;
        Tue,  7 Jun 2022 11:51:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EiW8ObQ7n2LddgAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 07 Jun 2022 11:51:16 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>
Subject: [PATCH] btrfs: make btrfs_super_block::log_root_transid deprecated
Date:   Tue,  7 Jun 2022 19:50:59 +0800
Message-Id: <d271efe6a00ed1b8de9150e96399636dedd38e3c.1654602650.git.wqu@suse.com>
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

When using "btrfs inspect-internal dump-super" to inspect an fs with
dirty log, it always shows the log_root_transid as 0:

 log_root                30474240
 log_root_transid        0 <<<
 log_root_level          0

It turns out that, btrfs_super_block::log_root_transid is never really
utilized (even no read for it).

This can date back to the introduction of btrfs into upstream kernel.

In fact, when reading log tree root, we always use
btrfs_super_block::generation + 1 as the expected generation.
So here we're completely safe to mark this member deprecated.

In theory we can easily reuse this member for other purposes, but to be
extra safe, here we follow the leafsize way, by adding "__unused_" for
log_root_transid.
And we can safely remove the accessors, since there is no such callers
from the very beginning.

Cc: Chris Mason <clm@fb.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0e49b1a0c071..71ba3b9fd8c2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -248,8 +248,13 @@ struct btrfs_super_block {
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
@@ -2475,8 +2480,6 @@ BTRFS_SETGET_STACK_FUNCS(super_chunk_root_level, struct btrfs_super_block,
 			 chunk_root_level, 8);
 BTRFS_SETGET_STACK_FUNCS(super_log_root, struct btrfs_super_block,
 			 log_root, 64);
-BTRFS_SETGET_STACK_FUNCS(super_log_root_transid, struct btrfs_super_block,
-			 log_root_transid, 64);
 BTRFS_SETGET_STACK_FUNCS(super_log_root_level, struct btrfs_super_block,
 			 log_root_level, 8);
 BTRFS_SETGET_STACK_FUNCS(super_total_bytes, struct btrfs_super_block,
-- 
2.36.1

