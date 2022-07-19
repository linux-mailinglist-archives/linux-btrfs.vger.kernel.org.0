Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593F3579258
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 07:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbiGSFLp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 01:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiGSFLm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 01:11:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AE52B24A
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 22:11:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A2BC1343DF;
        Tue, 19 Jul 2022 05:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658207500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZiqQjTy1KvIZEc1TPEU/fAp7QJW+gird9Zf1nCI278=;
        b=akTbspcmzavCmrD9/X6MMG5UkZ6x7Zb/jLMuNTehbKXsn3xAqXRyUk5yQRiVYGDn8FiOu7
        HVBto9H4YawemWZS6GvemldTndEKowePueQYm2qJN6HTTOyEsrWYwty91VjOWMbXOyxHOb
        zliJIkdg9cHCwerctLunl1JIyvh7nvc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CAB2413754;
        Tue, 19 Jul 2022 05:11:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IMuZJQs91mJTeAAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 19 Jul 2022 05:11:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 3/4] btrfs: make DUMP_BLOCK_RSV() to have better output
Date:   Tue, 19 Jul 2022 13:11:17 +0800
Message-Id: <92480f4ce87377ab24c835d87754113f655898f5.1658207325.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1658207325.git.wqu@suse.com>
References: <cover.1658207325.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This involves the following change:

- Remove "_block_rsv" suffix

- Better alignment for the numbers

- Better naming distinguish for delayed refs and delayed inode

- Skip "size" and "reserved" output
  Just output the numbers directly

Before:

  BTRFS info (device dm-1: state A): global_block_rsv: size 3670016 reserved 3653632
  BTRFS info (device dm-1: state A): trans_block_rsv: size 0 reserved 0
  BTRFS info (device dm-1: state A): chunk_block_rsv: size 0 reserved 0
  BTRFS info (device dm-1: state A): delayed_block_rsv: size 0 reserved 0
  BTRFS info (device dm-1: state A): delayed_refs_rsv: size 524288 reserved 360448

After:

 BTRFS info (device dm-1: state A): dumping metadata reservation: (reserved/size)
 BTRFS info (device dm-1: state A):   global:          (3670016/3670016)
 BTRFS info (device dm-1: state A):   trans:           (0/0)
 BTRFS info (device dm-1: state A):   chunk:           (0/0)
 BTRFS info (device dm-1: state A):   delayed_inode:   (0/0)
 BTRFS info (device dm-1: state A):   delayed_refs:    (524288/524288)

Also, this patch will separate the metadata reservation dumping into a
separate function for later usage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/space-info.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 623fa0488545..81457049816e 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -441,12 +441,12 @@ void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
 	}
 }
 
-#define DUMP_BLOCK_RSV(fs_info, rsv_name)				\
+#define DUMP_BLOCK_RSV(fs_info, member, name)				\
 do {									\
-	struct btrfs_block_rsv *__rsv = &(fs_info)->rsv_name;		\
+	struct btrfs_block_rsv *__rsv = &(fs_info)->member;		\
 	spin_lock(&__rsv->lock);					\
-	btrfs_info(fs_info, #rsv_name ": size %llu reserved %llu",	\
-		   __rsv->size, __rsv->reserved);			\
+	btrfs_info(fs_info, "  %-16s (%llu/%llu)",			\
+		   name, __rsv->reserved, __rsv->size);			\
 	spin_unlock(&__rsv->lock);					\
 } while (0)
 
@@ -484,13 +484,16 @@ static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 	if (btrfs_is_zoned(fs_info))
 		btrfs_info(fs_info,
 			    "  zone_unusable: %llu", info->bytes_zone_unusable);
+}
 
-	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
-	DUMP_BLOCK_RSV(fs_info, trans_block_rsv);
-	DUMP_BLOCK_RSV(fs_info, chunk_block_rsv);
-	DUMP_BLOCK_RSV(fs_info, delayed_block_rsv);
-	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv);
-
+static void dump_metadata_rsv(struct btrfs_fs_info *fs_info)
+{
+	btrfs_info(fs_info, "dumping metadata reservation: (reserved/size)");
+	DUMP_BLOCK_RSV(fs_info, global_block_rsv, "global:");
+	DUMP_BLOCK_RSV(fs_info, trans_block_rsv, "trans:");
+	DUMP_BLOCK_RSV(fs_info, chunk_block_rsv, "chunk:");
+	DUMP_BLOCK_RSV(fs_info, delayed_block_rsv, "delayed_inode:");
+	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv, "delayed_refs:");
 }
 
 void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
@@ -502,6 +505,7 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 
 	spin_lock(&info->lock);
 	__btrfs_dump_space_info(fs_info, info);
+	dump_metadata_rsv(fs_info);
 	spin_unlock(&info->lock);
 
 	if (!dump_block_groups)
@@ -957,6 +961,7 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 	if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
 		btrfs_info(fs_info, "cannot satisfy tickets, dumping space info");
 		__btrfs_dump_space_info(fs_info, space_info);
+		dump_metadata_rsv(fs_info);
 	}
 
 	while (!list_empty(&space_info->tickets) &&
-- 
2.37.0

