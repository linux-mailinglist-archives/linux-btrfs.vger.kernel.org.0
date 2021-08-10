Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823463E86DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 01:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbhHJXzP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 19:55:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35498 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbhHJXzM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 19:55:12 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6AF851FE86
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 23:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628639689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Rm7OkTetM2N9hGCl9yF+/qUlNP7EMY/75K4BGTihix8=;
        b=NhEdTnuuvPDmi4Vd9vDFWNiKWqWpzqWwIs1SQb07uRqeEjfXXDy2WsS0emfX17/aFVTbm2
        5abOML4QdABl9LQjeg/kt4H1w1Ty7dkj7gxH6EnOrXIxR+k7pPAdeFuQQMi8v2GeFalKhp
        z0lgWaW0s3Q/CsXDE+MpaSt6o+Phqo0=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9C6C113664
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 23:54:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id LOChFsgRE2FVGQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 23:54:48 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: map-logical: handle corrupted fs better
Date:   Wed, 11 Aug 2021 07:54:45 +0800
Message-Id: <20210810235445.44567-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently if running btrfs-map-logical on a filesystem with corrupted
extent tree, it will fail due to open_ctree() error.

But the truth is, btrfs-map-logical only requires chunk tree to do
logical bytenr mapping.

Make btrfs-map-logical more robust by:

- Loosen the open_ctree() requirement
  Now it doesn't require an extent tree to work.

- Don't return error for map_one_extent()
  Function map_one_extent() is too lookup extent tree to ensure there is
  at least one extent for the range we're looking for.

  But since now we don't require extent tree at all, there is no hard
  requirement for that function.
  Thus here we change it to return void, and only do the check when
  possible.

Now btrfs-map-logical can work on a filesystem with corrupted extent
tree.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfs-map-logical.c | 50 +++++++++++----------------------------------
 1 file changed, 12 insertions(+), 38 deletions(-)

diff --git a/btrfs-map-logical.c b/btrfs-map-logical.c
index b35677730374..f06a612f6c14 100644
--- a/btrfs-map-logical.c
+++ b/btrfs-map-logical.c
@@ -38,8 +38,8 @@
  * */
 static FILE *info_file;
 
-static int map_one_extent(struct btrfs_fs_info *fs_info,
-			  u64 *logical_ret, u64 *len_ret, int search_forward)
+static void map_one_extent(struct btrfs_fs_info *fs_info,
+			   u64 *logical_ret, u64 *len_ret, int search_forward)
 {
 	struct btrfs_path *path;
 	struct btrfs_key key;
@@ -52,7 +52,7 @@ static int map_one_extent(struct btrfs_fs_info *fs_info,
 
 	path = btrfs_alloc_path();
 	if (!path)
-		return -ENOMEM;
+		return;
 
 	key.objectid = logical;
 	key.type = 0;
@@ -94,7 +94,11 @@ out:
 		if (len_ret)
 			*len_ret = len;
 	}
-	return ret;
+	/*
+	 * Ignore any error for extent item lookup, it can be corrupted
+	 * extent tree or whatever. In that case, just ignore the
+	 * extent item lookup and reset @ret to 0.
+	 */
 }
 
 static int __print_mapping_info(struct btrfs_fs_info *fs_info, u64 logical,
@@ -261,7 +265,8 @@ int main(int argc, char **argv)
 	radix_tree_init();
 	cache_tree_init(&root_cache);
 
-	root = open_ctree(dev, 0, 0);
+	root = open_ctree(dev, 0, OPEN_CTREE_PARTIAL |
+				  OPEN_CTREE_NO_BLOCK_GROUPS);
 	if (!root) {
 		fprintf(stderr, "Open ctree failed\n");
 		free(output_file);
@@ -293,34 +298,7 @@ int main(int argc, char **argv)
 	cur_len = bytes;
 
 	/* First find the nearest extent */
-	ret = map_one_extent(root->fs_info, &cur_logical, &cur_len, 0);
-	if (ret < 0) {
-		errno = -ret;
-		fprintf(stderr, "Failed to find extent at [%llu,%llu): %m\n",
-			cur_logical, cur_logical + cur_len);
-		goto out_close_fd;
-	}
-	/*
-	 * Normally, search backward should be OK, but for special case like
-	 * given logical is quite small where no extents are before it,
-	 * we need to search forward.
-	 */
-	if (ret > 0) {
-		ret = map_one_extent(root->fs_info, &cur_logical, &cur_len, 1);
-		if (ret < 0) {
-			errno = -ret;
-			fprintf(stderr,
-				"Failed to find extent at [%llu,%llu): %m\n",
-				cur_logical, cur_logical + cur_len);
-			goto out_close_fd;
-		}
-		if (ret > 0) {
-			fprintf(stderr,
-				"Failed to find any extent at [%llu,%llu)\n",
-				cur_logical, cur_logical + cur_len);
-			goto out_close_fd;
-		}
-	}
+	map_one_extent(root->fs_info, &cur_logical, &cur_len, 0);
 
 	while (cur_logical + cur_len >= logical && cur_logical < logical +
 	       bytes) {
@@ -328,11 +306,7 @@ int main(int argc, char **argv)
 		u64 real_len;
 
 		found = 1;
-		ret = map_one_extent(root->fs_info, &cur_logical, &cur_len, 1);
-		if (ret < 0)
-			goto out_close_fd;
-		if (ret > 0)
-			break;
+		map_one_extent(root->fs_info, &cur_logical, &cur_len, 1);
 		/* check again if there is overlap. */
 		if (cur_logical + cur_len < logical ||
 		    cur_logical >= logical + bytes)
-- 
2.32.0

