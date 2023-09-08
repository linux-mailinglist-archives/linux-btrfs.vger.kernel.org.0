Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5563798B5E
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 19:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244622AbjIHRUv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 13:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244595AbjIHRUs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 13:20:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43987CE6
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 10:20:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B513C433C9
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 17:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694193643;
        bh=jA9A5cGAuCBRpJRqXqg/35Vi9L6epnbirlaDi0GjMaI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DEu4ugEwPRUaxONXwQuVFGLmvjeQdG6WW+fybWbe/a6uUSQg1hNGr1xluOjng1Rl7
         QFloXGtiEtcoJ7wSNRzfcsP0yIYBv6AlDWFe7uzfyvWkwG+YtR490JA/f1d4hKKR40
         vSUqRNOSt78sCCDSwduFw4in/StU2K6epixSFOHJGKqcq0RZWQ+pe4kWOhzMjP/2ou
         2OOejyT/3bEE7YzfIwrcNanno8e5AJZ+l4n0owVUilN1gBJIpBtsy1OBQBFvQBAehY
         AqvmWg35N6b5bDaTrxgaaXed5+SwPCCkttkdNn2RV9AbbopJaLibKtMnCvxpqdsFr/
         2cpZ00ndoEKTw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 02/21] btrfs: prevent transaction block reserve underflow when starting transaction
Date:   Fri,  8 Sep 2023 18:20:19 +0100
Message-Id: <8043421e01104d45fa71cc2b7de7e3668558605e.1694192469.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694192469.git.fdmanana@suse.com>
References: <cover.1694192469.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When starting a transaction, with a non-zero number of items, we reserve
metadata space for that number of items and for delayed refs by doing a
call to btrfs_block_rsv_add(), with the transaction block reserve passed
as the block reserve argument. This reserves metadata space and adds it
to the transaction block reserve. Later we migrate the space we reserved
for delayed references from the transaction block reserve into the delayed
refs block reserve, by calling btrfs_migrate_to_delayed_refs_rsv().

btrfs_migrate_to_delayed_refs_rsv() decrements the number of bytes to
migrate from the source block reserve, and this however may result in an
underflow in case the space added to the transaction block reserve ended
up being used by another task that has not reserved enough space for its
own use - examples are tasks doing reflinks or hole punching because they
end up calling btrfs_replace_file_extents() -> btrfs_drop_extents() and
may need to modify/COW a variable number of leaves/paths, so they keep
trying to use space from the transaction block reserve when they need to
COW an extent buffer, and may end up trying to use more space then they
have reserved (1 unit/path only for removing file extent items).

This can be avoided by simply reserving space first without adding it to
the transaction block reserve, then add the space for delayed refs to the
delayed refs block reserve and finally add the remaining reserved space
to the transaction block reserve. This also makes the code a bit shorter
and simpler. So just do that.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 9 +--------
 fs/btrfs/delayed-ref.h | 1 -
 fs/btrfs/transaction.c | 5 +++--
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 1043f66cc130..9fe4ccca50a0 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -103,24 +103,17 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans)
  * Transfer bytes to our delayed refs rsv.
  *
  * @fs_info:   the filesystem
- * @src:       source block rsv to transfer from
  * @num_bytes: number of bytes to transfer
  *
- * This transfers up to the num_bytes amount from the src rsv to the
+ * This transfers up to the num_bytes amount, previously reserved, to the
  * delayed_refs_rsv.  Any extra bytes are returned to the space info.
  */
 void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
-				       struct btrfs_block_rsv *src,
 				       u64 num_bytes)
 {
 	struct btrfs_block_rsv *delayed_refs_rsv = &fs_info->delayed_refs_rsv;
 	u64 to_free = 0;
 
-	spin_lock(&src->lock);
-	src->reserved -= num_bytes;
-	src->size -= num_bytes;
-	spin_unlock(&src->lock);
-
 	spin_lock(&delayed_refs_rsv->lock);
 	if (delayed_refs_rsv->size > delayed_refs_rsv->reserved) {
 		u64 delta = delayed_refs_rsv->size -
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index b8e14b0ba5f1..fd9bf2b709c0 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -407,7 +407,6 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans);
 int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 				  enum btrfs_reserve_flush_enum flush);
 void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
-				       struct btrfs_block_rsv *src,
 				       u64 num_bytes);
 bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info);
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index ab09542f2170..1985ab543ad2 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -625,14 +625,15 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 			reloc_reserved = true;
 		}
 
-		ret = btrfs_block_rsv_add(fs_info, rsv, num_bytes, flush);
+		ret = btrfs_reserve_metadata_bytes(fs_info, rsv, num_bytes, flush);
 		if (ret)
 			goto reserve_fail;
 		if (delayed_refs_bytes) {
-			btrfs_migrate_to_delayed_refs_rsv(fs_info, rsv,
+			btrfs_migrate_to_delayed_refs_rsv(fs_info,
 							  delayed_refs_bytes);
 			num_bytes -= delayed_refs_bytes;
 		}
+		btrfs_block_rsv_add_bytes(rsv, num_bytes, true);
 
 		if (rsv->space_info->force_alloc)
 			do_chunk_alloc = true;
-- 
2.40.1

