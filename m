Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED83A6F0594
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Apr 2023 14:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243761AbjD0MRS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 08:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243828AbjD0MRQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 08:17:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D109755A2
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 05:16:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 82FAE1FE0C
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 12:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682597807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XzIsuFyZ8z/dFjw+zfiyMMHNjVgdneE/PTsVmcxMh2k=;
        b=UF1pkj7U2Q3Qbd+PWG9AuPWQF6JAKWIfNZ2jSg4eM6O2w7kWKuXXipHploSDt0CylsZXoc
        LhBhrier/HvpnGf4IoDqWt4CClBgUIwtlOHemmvS5sfVvB4TrvTX+yzaxenUMuwZftFnkg
        I5b2XS8KIpvyZ60OP4kgKJhGgvoaTKQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6E8013910
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 12:16:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QAHxLK5nSmQOUAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 12:16:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: print-tree: accept const extent buffer pointer
Date:   Thu, 27 Apr 2023 20:16:27 +0800
Message-Id: <b403f26f3e9358e89f402a3d31843a8d9d9f7012.1682597619.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1682597619.git.wqu@suse.com>
References: <cover.1682597619.git.wqu@suse.com>
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

Since print-tree infrastructure only prints the content of a tree block,
we can make them to accept const extent buffer pointer.

This removes a forced type convert in extent-tree, where we convert a
const extent buffer pointer to regular one, just to avoid compiler
warning.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.c       |  4 ++--
 fs/btrfs/ctree.h       |  2 +-
 fs/btrfs/extent-tree.c |  2 +-
 fs/btrfs/print-tree.c  | 16 ++++++++--------
 fs/btrfs/print-tree.h  |  4 ++--
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 4caea775e7e0..71b8905ebd01 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3073,7 +3073,7 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
  * and nr indicate which items in the leaf to check.  This totals up the
  * space used both by the item structs and the item data
  */
-static int leaf_space_used(struct extent_buffer *l, int start, int nr)
+static int leaf_space_used(const struct extent_buffer *l, int start, int nr)
 {
 	int data_len;
 	int nritems = btrfs_header_nritems(l);
@@ -3093,7 +3093,7 @@ static int leaf_space_used(struct extent_buffer *l, int start, int nr)
  * the start of the leaf data.  IOW, how much room
  * the leaf has left for both items and data
  */
-noinline int btrfs_leaf_free_space(struct extent_buffer *leaf)
+int btrfs_leaf_free_space(const struct extent_buffer *leaf)
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	int nritems = btrfs_header_nritems(leaf);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e81f10e12867..b7ab7fa2b73a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -685,7 +685,7 @@ static inline int btrfs_next_item(struct btrfs_root *root, struct btrfs_path *p)
 {
 	return btrfs_next_old_item(root, p, 0);
 }
-int btrfs_leaf_free_space(struct extent_buffer *leaf);
+int btrfs_leaf_free_space(const struct extent_buffer *leaf);
 
 static inline int is_fstree(u64 rootid)
 {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5cd289de4e92..e1d5198d1f5e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -402,7 +402,7 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 		}
 	}
 
-	btrfs_print_leaf((struct extent_buffer *)eb);
+	btrfs_print_leaf(eb);
 	btrfs_err(eb->fs_info,
 		  "eb %llu iref 0x%lx invalid extent inline ref type %d",
 		  eb->start, (unsigned long)iref, type);
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index b93c96213304..737e1664330e 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -49,7 +49,7 @@ const char *btrfs_root_name(const struct btrfs_key *key, char *buf)
 	return buf;
 }
 
-static void print_chunk(struct extent_buffer *eb, struct btrfs_chunk *chunk)
+static void print_chunk(const struct extent_buffer *eb, struct btrfs_chunk *chunk)
 {
 	int num_stripes = btrfs_chunk_num_stripes(eb, chunk);
 	int i;
@@ -62,7 +62,7 @@ static void print_chunk(struct extent_buffer *eb, struct btrfs_chunk *chunk)
 		      btrfs_stripe_offset_nr(eb, chunk, i));
 	}
 }
-static void print_dev_item(struct extent_buffer *eb,
+static void print_dev_item(const struct extent_buffer *eb,
 			   struct btrfs_dev_item *dev_item)
 {
 	pr_info("\t\tdev item devid %llu total_bytes %llu bytes used %llu\n",
@@ -70,7 +70,7 @@ static void print_dev_item(struct extent_buffer *eb,
 	       btrfs_device_total_bytes(eb, dev_item),
 	       btrfs_device_bytes_used(eb, dev_item));
 }
-static void print_extent_data_ref(struct extent_buffer *eb,
+static void print_extent_data_ref(const struct extent_buffer *eb,
 				  struct btrfs_extent_data_ref *ref)
 {
 	pr_cont("extent data backref root %llu objectid %llu offset %llu count %u\n",
@@ -80,7 +80,7 @@ static void print_extent_data_ref(struct extent_buffer *eb,
 	       btrfs_extent_data_ref_count(eb, ref));
 }
 
-static void print_extent_item(struct extent_buffer *eb, int slot, int type)
+static void print_extent_item(const struct extent_buffer *eb, int slot, int type)
 {
 	struct btrfs_extent_item *ei;
 	struct btrfs_extent_inline_ref *iref;
@@ -169,7 +169,7 @@ static void print_extent_item(struct extent_buffer *eb, int slot, int type)
 	WARN_ON(ptr > end);
 }
 
-static void print_uuid_item(struct extent_buffer *l, unsigned long offset,
+static void print_uuid_item(const struct extent_buffer *l, unsigned long offset,
 			    u32 item_size)
 {
 	if (!IS_ALIGNED(item_size, sizeof(u64))) {
@@ -191,7 +191,7 @@ static void print_uuid_item(struct extent_buffer *l, unsigned long offset,
  * Helper to output refs and locking status of extent buffer.  Useful to debug
  * race condition related problems.
  */
-static void print_eb_refs_lock(struct extent_buffer *eb)
+static void print_eb_refs_lock(const struct extent_buffer *eb)
 {
 #ifdef CONFIG_BTRFS_DEBUG
 	btrfs_info(eb->fs_info, "refs %u lock_owner %u current %u",
@@ -199,7 +199,7 @@ static void print_eb_refs_lock(struct extent_buffer *eb)
 #endif
 }
 
-void btrfs_print_leaf(struct extent_buffer *l)
+void btrfs_print_leaf(const struct extent_buffer *l)
 {
 	struct btrfs_fs_info *fs_info;
 	int i;
@@ -355,7 +355,7 @@ void btrfs_print_leaf(struct extent_buffer *l)
 	}
 }
 
-void btrfs_print_tree(struct extent_buffer *c, bool follow)
+void btrfs_print_tree(const struct extent_buffer *c, bool follow)
 {
 	struct btrfs_fs_info *fs_info;
 	int i; u32 nr;
diff --git a/fs/btrfs/print-tree.h b/fs/btrfs/print-tree.h
index 8c3e9319ec4e..c42bc666d5ee 100644
--- a/fs/btrfs/print-tree.h
+++ b/fs/btrfs/print-tree.h
@@ -9,8 +9,8 @@
 /* Buffer size to contain tree name and possibly additional data (offset) */
 #define BTRFS_ROOT_NAME_BUF_LEN				48
 
-void btrfs_print_leaf(struct extent_buffer *l);
-void btrfs_print_tree(struct extent_buffer *c, bool follow);
+void btrfs_print_leaf(const struct extent_buffer *l);
+void btrfs_print_tree(const struct extent_buffer *c, bool follow);
 const char *btrfs_root_name(const struct btrfs_key *key, char *buf);
 
 #endif
-- 
2.39.2

