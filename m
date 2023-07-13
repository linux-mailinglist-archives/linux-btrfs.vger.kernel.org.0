Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECFF7524E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 16:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbjGMORM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 10:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjGMORD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 10:17:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C49F273F
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 07:17:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1B66C2215F;
        Thu, 13 Jul 2023 14:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689257820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N7IqGi3DF5Arep4d0M1L2/RC1ebdG6+JgIdxB52CfxY=;
        b=mrzdGAW6VZAp9ljBTEjaka4OSmlCJUW2UHYKNUUsnz25qYJdfmXEGh4RHjJg7lp9dQ+m4T
        lcnn7mELOGU9ea4XQC/j5RraKpKVVl2JtE0gUgGqZuORpwgoKEmaFIugQ7gfhdaKT6ei1R
        3nDc+DUZI58MavRnNdGfMXl29J/rBSs=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0DFB52C142;
        Thu, 13 Jul 2023 14:17:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E05A6DA85A; Thu, 13 Jul 2023 16:10:24 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: replace unsigned char with u8 for type casts
Date:   Thu, 13 Jul 2023 16:10:24 +0200
Message-Id: <903ef08411ce5f8456f1c5b7a099c526d19dbf21.1689257327.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1689257327.git.dsterba@suse.com>
References: <cover.1689257327.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's no reason to use 'unsigned char' when we can simply use u8
for byte buffers like for checksums or send buffers. The char could be
signed or unsigned depending on the compiler settings, per [1] it's not
simple.

[1] https://lore.kernel.org/lkml/CAHk-=wgz3Uba8w7kdXhsqR1qvfemYL+OFQdefJnkeqXG8qZ_pA@mail.gmail.com/

Checksum buffer item already uses u8 so this unifies the types and in
btrfs_readdir_delayed_dir_index() the unsigned char has been probably
inherited from fs_ftype_to_dtype() bit it's not strictly necessary

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/delayed-inode.c | 2 +-
 fs/btrfs/file-item.c     | 8 +++-----
 fs/btrfs/send.c          | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 6b457b010cbc..fd8a9916bf64 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1733,7 +1733,7 @@ int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
 	char *name;
 	int name_len;
 	int over = 0;
-	unsigned char d_type;
+	u8 d_type;
 
 	if (list_empty(ins_list))
 		return 0;
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 696bf695d8eb..acd09cfaf62c 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -245,8 +245,7 @@ btrfs_lookup_csum(struct btrfs_trans_handle *trans,
 		}
 	}
 	item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_csum_item);
-	item = (struct btrfs_csum_item *)((unsigned char *)item +
-					  csum_offset * csum_size);
+	item = (struct btrfs_csum_item *)((u8 *)item + csum_offset * csum_size);
 	return item;
 fail:
 	if (ret > 0)
@@ -1223,10 +1222,9 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 csum:
 	item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_csum_item);
-	item_end = (struct btrfs_csum_item *)((unsigned char *)item +
+	item_end = (struct btrfs_csum_item *)((u8 *)item +
 				      btrfs_item_size(leaf, path->slots[0]));
-	item = (struct btrfs_csum_item *)((unsigned char *)item +
-					  csum_offset * csum_size);
+	item = (struct btrfs_csum_item *)((u8 *)item + csum_offset * csum_size);
 found:
 	ins_size = (u32)(sums->len - total_bytes) >> fs_info->sectorsize_bits;
 	ins_size *= csum_size;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 8bfd44750efe..dffdf6c54726 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -796,7 +796,7 @@ static int send_cmd(struct send_ctx *sctx)
 	put_unaligned_le32(sctx->send_size - sizeof(*hdr), &hdr->len);
 	put_unaligned_le32(0, &hdr->crc);
 
-	crc = btrfs_crc32c(0, (unsigned char *)sctx->send_buf, sctx->send_size);
+	crc = btrfs_crc32c(0, (u8 *)sctx->send_buf, sctx->send_size);
 	put_unaligned_le32(crc, &hdr->crc);
 
 	ret = write_buf(sctx->send_filp, sctx->send_buf, sctx->send_size,
-- 
2.40.0

