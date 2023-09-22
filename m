Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DE47AB9EC
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 21:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjIVTRL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 15:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjIVTRK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 15:17:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78700A3
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 12:17:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 368A421845;
        Fri, 22 Sep 2023 19:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695410223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PMISc5NzcM1J17puirQSiNTefPswrgCFfkWhYjgz2Zs=;
        b=mC5tgKPpkaCJya5d7q4DSXfDkqMdgsyOkWA/rNSYQpOF33YjHCOFrtr+8ziylmRIOdqPrR
        eQrl8iwJW9NMXnIoHSYKwa81VXjfMVcH9soDFIDTHdHMQgtjZw2ZWb4UkJgdv3/Nwd7sH4
        VO12Pj2H/JSxLgOh3b6V5Bmvov3g7XI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1BA9F2C142;
        Fri, 22 Sep 2023 19:17:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 10B6ADA832; Fri, 22 Sep 2023 21:10:29 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/5] btrfs: use on-stack variable for block reserve in btrfs_replace_file_extents
Date:   Fri, 22 Sep 2023 21:10:28 +0200
Message-ID: <14f18cb66e7f762352fdda4df02d6d56b5b4485c.1695408280.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695408280.git.dsterba@suse.com>
References: <cover.1695408280.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can avoid potential memory allocation failure in btrfs_truncate as
the block reserve lifetime is limited to the scope of the function. This
requires +48 bytes on stack.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/file.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7a070f114a21..1bae9b3d50e1 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2324,7 +2324,7 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 	u64 min_size = btrfs_calc_insert_metadata_size(fs_info, 1);
 	u64 ino_size = round_up(inode->vfs_inode.i_size, fs_info->sectorsize);
 	struct btrfs_trans_handle *trans = NULL;
-	struct btrfs_block_rsv *rsv;
+	struct btrfs_block_rsv rsv;
 	unsigned int rsv_count;
 	u64 cur_offset;
 	u64 len = end - start;
@@ -2333,13 +2333,9 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 	if (end <= start)
 		return -EINVAL;
 
-	rsv = btrfs_alloc_block_rsv(fs_info, BTRFS_BLOCK_RSV_TEMP);
-	if (!rsv) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	rsv->size = btrfs_calc_insert_metadata_size(fs_info, 1);
-	rsv->failfast = true;
+	btrfs_init_metadata_block_rsv(fs_info, &rsv, BTRFS_BLOCK_RSV_TEMP);
+	rsv.size = btrfs_calc_insert_metadata_size(fs_info, 1);
+	rsv.failfast = true;
 
 	/*
 	 * 1 - update the inode
@@ -2356,14 +2352,14 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		trans = NULL;
-		goto out_free;
+		goto out_release;
 	}
 
-	ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv, rsv,
+	ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv, &rsv,
 				      min_size, false);
 	if (WARN_ON(ret))
 		goto out_trans;
-	trans->block_rsv = rsv;
+	trans->block_rsv = &rsv;
 
 	cur_offset = start;
 	drop_args.path = path;
@@ -2478,10 +2474,10 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 		}
 
 		ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv,
-					      rsv, min_size, false);
+					      &rsv, min_size, false);
 		if (WARN_ON(ret))
 			break;
-		trans->block_rsv = rsv;
+		trans->block_rsv = &rsv;
 
 		cur_offset = drop_args.drop_end;
 		len = end - cur_offset;
@@ -2558,16 +2554,15 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 
 out_trans:
 	if (!trans)
-		goto out_free;
+		goto out_release;
 
 	trans->block_rsv = &fs_info->trans_block_rsv;
 	if (ret)
 		btrfs_end_transaction(trans);
 	else
 		*trans_out = trans;
-out_free:
-	btrfs_free_block_rsv(fs_info, rsv);
-out:
+out_release:
+	btrfs_block_rsv_release(fs_info, &rsv, (u64)-1, NULL);
 	return ret;
 }
 
-- 
2.41.0

