Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E491D6152F1
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiKAUNX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiKAUNT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:13:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F47A1E3DA
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:13:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C67D71F88E;
        Tue,  1 Nov 2022 20:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MOOjlKsXkiTLI8goEnZFRuBBjBV5ffmsJ5a9zl0E4mc=;
        b=AaGlYMl/7fsg91Ph7OliggSwHOdB5hL/9QdvvRbWeBhoyuzxGjaImGb0cBq0qs6kADdlLg
        XMEmk6NXEHS3ZDpN3Wpt2+TX26/oxXKW9RafKjrZ/N+pbxZ/Gk9EFq+utBfCySMNXS4HTG
        ZWRnJkEkZSWA/rXUiF4SshhD9nEr2Qc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C0BD22C141;
        Tue,  1 Nov 2022 20:13:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1C9E6DA79D; Tue,  1 Nov 2022 21:13:00 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 37/40] btrfs: switch async_chunk::inode to btrfs_inode
Date:   Tue,  1 Nov 2022 21:13:00 +0100
Message-Id: <34d2c194b87a5a5526e3bfcd098d12fafd445479.1667331829.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667331828.git.dsterba@suse.com>
References: <cover.1667331828.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The async_chunk::inode structure is for internal interfaces so we should
use the btrfs_inode.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cb284388896c..ad5038dec0db 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -520,7 +520,7 @@ struct async_extent {
 };
 
 struct async_chunk {
-	struct inode *inode;
+	struct btrfs_inode *inode;
 	struct page *locked_page;
 	u64 start;
 	u64 end;
@@ -648,7 +648,7 @@ static inline void inode_should_defrag(struct btrfs_inode *inode,
  */
 static noinline int compress_file_range(struct async_chunk *async_chunk)
 {
-	struct inode *inode = async_chunk->inode;
+	struct inode *inode = &async_chunk->inode->vfs_inode;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 blocksize = fs_info->sectorsize;
 	u64 start = async_chunk->start;
@@ -1113,7 +1113,7 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
  */
 static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 {
-	struct btrfs_inode *inode = BTRFS_I(async_chunk->inode);
+	struct btrfs_inode *inode = async_chunk->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct async_extent *async_extent;
 	u64 alloc_hint = 0;
@@ -1494,7 +1494,7 @@ static noinline void async_cow_start(struct btrfs_work *work)
 
 	compressed_extents = compress_file_range(async_chunk);
 	if (compressed_extents == 0) {
-		btrfs_add_delayed_iput(async_chunk->inode);
+		btrfs_add_delayed_iput(&async_chunk->inode->vfs_inode);
 		async_chunk->inode = NULL;
 	}
 }
@@ -1534,7 +1534,7 @@ static noinline void async_cow_free(struct btrfs_work *work)
 
 	async_chunk = container_of(work, struct async_chunk, work);
 	if (async_chunk->inode)
-		btrfs_add_delayed_iput(async_chunk->inode);
+		btrfs_add_delayed_iput(&async_chunk->inode->vfs_inode);
 	if (async_chunk->blkcg_css)
 		css_put(async_chunk->blkcg_css);
 
@@ -1602,7 +1602,7 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 		 */
 		ihold(&inode->vfs_inode);
 		async_chunk[i].async_cow = ctx;
-		async_chunk[i].inode = &inode->vfs_inode;
+		async_chunk[i].inode = inode;
 		async_chunk[i].start = start;
 		async_chunk[i].end = cur_end;
 		async_chunk[i].write_flags = write_flags;
-- 
2.37.3

