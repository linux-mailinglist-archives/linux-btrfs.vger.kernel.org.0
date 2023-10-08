Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1607BCAEE
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Oct 2023 02:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjJHAub (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Oct 2023 20:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbjJHAuF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Oct 2023 20:50:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D3BDB;
        Sat,  7 Oct 2023 17:49:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D2BC433BC;
        Sun,  8 Oct 2023 00:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696726177;
        bh=aySlpxPzYKweouPrs23+PsDDuAGtneQiFKNVAje+y6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wg/IJ9WKuMZNj/TA93oXJuA5PbhXBz3DzfQ7FVw8g1M8UE0i+35xQFMdnByfh7P6J
         HFmRnY4m/TJbSUlWayMqNu80Ghx9MgizRRR43sMBUW4OhREh8lYU6djf0IaPKdmb+E
         9nRsPdwxC5raKG3dZjO0emG9WSZkqW8TFb05KAXYLrzFC79BBDoKptXJNy/ZcYiIqC
         VFK3dCOGVB6mQjKwSiLdcX9dMKAwxta+XLbYT+rZpZPXNP6Q0cZaYRyZIJTejeFczR
         Cof3LVLpeAPZiYsDVM79KJDknb6fXHzyCOWNDTMaa67Wqp1O7+sgutAqzVtXgpl6TV
         Z/1eGclP7p+rQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/12] btrfs: prevent transaction block reserve underflow when starting transaction
Date:   Sat,  7 Oct 2023 20:49:21 -0400
Message-Id: <20231008004929.3767992-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008004929.3767992-1-sashal@kernel.org>
References: <20231008004929.3767992-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.56
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

[ Upstream commit a7ddeeb079505961355cf0106154da0110f1fdff ]

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
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/delayed-ref.c | 9 +--------
 fs/btrfs/delayed-ref.h | 1 -
 fs/btrfs/transaction.c | 6 +++---
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 36a3debe94930..e08e3852c4788 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -141,24 +141,17 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans)
  * Transfer bytes to our delayed refs rsv
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
index d6304b690ec4a..712a6315e956b 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -383,7 +383,6 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans);
 int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 				  enum btrfs_reserve_flush_enum flush);
 void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
-				       struct btrfs_block_rsv *src,
 				       u64 num_bytes);
 int btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans);
 bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index a555567594418..847eee1e0db6f 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -613,14 +613,14 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 			reloc_reserved = true;
 		}
 
-		ret = btrfs_block_rsv_add(fs_info, rsv, num_bytes, flush);
+		ret = btrfs_reserve_metadata_bytes(fs_info, rsv, num_bytes, flush);
 		if (ret)
 			goto reserve_fail;
 		if (delayed_refs_bytes) {
-			btrfs_migrate_to_delayed_refs_rsv(fs_info, rsv,
-							  delayed_refs_bytes);
+			btrfs_migrate_to_delayed_refs_rsv(fs_info, delayed_refs_bytes);
 			num_bytes -= delayed_refs_bytes;
 		}
+		btrfs_block_rsv_add_bytes(rsv, num_bytes, true);
 
 		if (rsv->space_info->force_alloc)
 			do_chunk_alloc = true;
-- 
2.40.1

