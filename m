Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2620375F4DB
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 13:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjGXLVc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 07:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjGXLVc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 07:21:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B18E3;
        Mon, 24 Jul 2023 04:21:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 30B7C229C0;
        Mon, 24 Jul 2023 11:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690197689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fSuQy8bgPAwBhTJEjrrJpwdZYxA+welDhb6P1mNOaMA=;
        b=DOsJNhznvKbk71xWrPn+4V30Fv7N/9tvnpp+vtcO5CeP4f5UE6ucWMhB3rdQFN205fVI6T
        ujDGfTpCXoEGKRtf9X8j53fFdVq6hN3OW+yINcudrKNKr4+p+ca7G9s6sCWGN4n1hsCp2P
        TJjzrlWhFKKTQG8qTrJ0G4Ixb6h5qyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690197689;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fSuQy8bgPAwBhTJEjrrJpwdZYxA+welDhb6P1mNOaMA=;
        b=Pww+kgyGf/qgb+NiljCZY9krEDdOvePfpydZYKiaz0ura6o1m/x6lbIxe+wkm+HIBRUGgb
        uqfOWYgN9KwTI2AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A940D13476;
        Mon, 24 Jul 2023 11:21:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YCQkJrhevmT/awAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 24 Jul 2023 11:21:28 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 8fe5094a;
        Mon, 24 Jul 2023 11:21:24 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH v3] btrfs: propagate error from function unpin_extent_cache()
Date:   Mon, 24 Jul 2023 12:21:23 +0100
Message-Id: <20230724112123.1879-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Function unpin_extent_cache() currently never returns any error, even in
the event of an extent lookup failure.  This commit fixes this by returning
-EINVAL when no extent is found.  Additionally, it adds extra information
that may help debug any (hopefully) rare occasion when a lookup fails.  The
only caller of this function is also modified to handle this error
condition.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---

Changes since v2:
- As per Filipe's suggestion, provide as much debug info as possible.
  This required modifying the function to get the inode instead of the
  ext map tree.
- Since Filipe mentioned this WARN_ON() has been hit before, I guess it's
  better to also handle this error in the caller instead of just continue.
  But this is a change of the current behaviour and I may be wrong.

Changes since v1:
Instead of changing unpin_extent_cache() into a void function, make it
propagate an error code instead.

 fs/btrfs/extent_map.c | 26 +++++++++++++++++++++-----
 fs/btrfs/extent_map.h |  2 +-
 fs/btrfs/inode.c      |  8 +++++---
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 0cdb3e86f29b..1a2e791cbfb4 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -292,20 +292,37 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
  * to the generation that actually added the file item to the inode so we know
  * we need to sync this extent when we call fsync().
  */
-int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
+int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len,
 		       u64 gen)
 {
 	int ret = 0;
+	struct extent_map_tree *tree = &inode->extent_tree;
 	struct extent_map *em;
 	bool prealloc = false;
 
 	write_lock(&tree->lock);
 	em = lookup_extent_mapping(tree, start, len);
 
-	WARN_ON(!em || em->start != start);
+	if (!em || em->start != start) {
+		struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
-	if (!em)
-		goto out;
+		if (!em)
+			btrfs_warn(fs_info,
+				   "failed to find extent map");
+		else
+			btrfs_warn(fs_info,
+		"extent with wrong offset: start: %llu len: %llu flags: %lu",
+				   em->start, em->len, em->flags);
+		btrfs_warn(fs_info,
+			   "root %lld inode %llu offset %llu len: %llu",
+			   inode->root->root_key.objectid, btrfs_ino(inode),
+			   start, len);
+		WARN_ON(1);
+		if (!em) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
 
 	em->generation = gen;
 	clear_bit(EXTENT_FLAG_PINNED, &em->flags);
@@ -328,7 +345,6 @@ int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
 out:
 	write_unlock(&tree->lock);
 	return ret;
-
 }
 
 void clear_em_logging(struct extent_map_tree *tree, struct extent_map *em)
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 35d27c756e08..7a4ff55ee133 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -97,7 +97,7 @@ struct extent_map *alloc_extent_map(void);
 void free_extent_map(struct extent_map *em);
 int __init extent_map_init(void);
 void __cold extent_map_exit(void);
-int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len, u64 gen);
+int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen);
 void clear_em_logging(struct extent_map_tree *tree, struct extent_map *em);
 struct extent_map *search_extent_mapping(struct extent_map_tree *tree,
 					 u64 start, u64 len);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 49cef61f6a39..90efc2582f81 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3181,7 +3181,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 	struct extent_state *cached_state = NULL;
 	u64 start, end;
 	int compress_type = 0;
-	int ret = 0;
+	int ret = 0, ret2;
 	u64 logical_len = ordered_extent->num_bytes;
 	bool freespace_inode;
 	bool truncated = false;
@@ -3273,8 +3273,10 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 						ordered_extent->disk_num_bytes);
 		}
 	}
-	unpin_extent_cache(&inode->extent_tree, ordered_extent->file_offset,
-			   ordered_extent->num_bytes, trans->transid);
+	ret2 = unpin_extent_cache(inode, ordered_extent->file_offset,
+				  ordered_extent->num_bytes, trans->transid);
+	if (ret >= 0)
+		ret = ret2;
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
