Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8803E9DF6
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 07:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbhHLFfm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 01:35:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54284 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbhHLFfl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 01:35:41 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 75DDC2221F
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 05:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628746516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H3MgDoaC3pxWGK5X1JCZRr36bFxsdVGgVeN+lrOj88w=;
        b=M6pP6V+fR0UjDZjaT1RdIowAJtH0ILyHWr9ORQklk3/rq4S1/AypIio9gxHj55TQUyYqzO
        ZVJbX+GqJHXaYqUyrORtDb+r5mZRjb+IXejWef7Zzv4v8zzM9tQZHihBWdYPB8TMeIcmD8
        5PFHZaznxAacJGtX4HhKD+n39OKKNeI=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B3F7213838
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 05:35:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id iNqTHROzFGFeZQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 05:35:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs-progs: map-logical: remove the extent item check
Date:   Thu, 12 Aug 2021 13:35:08 +0800
Message-Id: <20210812053508.175737-5-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812053508.175737-1-wqu@suse.com>
References: <20210812053508.175737-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Tool btrfs-map-logical is really only doing logical -> physical mapping,
mostly utilized by developers or experienced users.

There is really no need to check whether the specified range has an
extent or not.

In fact the extent check behavior is a big blockage for corrupted fs as
such fs can have corrupted extent tree, doing an extent item search can
lead to -EIO error.

This patch will just remove the extent item check, allowing users to do
any logical -> physical mapping lookup as long as there is a chunk.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfs-map-logical.c | 145 ++------------------------------------------
 1 file changed, 5 insertions(+), 140 deletions(-)

diff --git a/btrfs-map-logical.c b/btrfs-map-logical.c
index 9f119d08bad8..96263013a5c6 100644
--- a/btrfs-map-logical.c
+++ b/btrfs-map-logical.c
@@ -38,65 +38,6 @@
  * */
 static FILE *info_file;
 
-static int map_one_extent(struct btrfs_fs_info *fs_info,
-			  u64 *logical_ret, u64 *len_ret, int search_forward)
-{
-	struct btrfs_path *path;
-	struct btrfs_key key;
-	u64 logical;
-	u64 len = 0;
-	int ret = 0;
-
-	BUG_ON(!logical_ret);
-	logical = *logical_ret;
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	key.objectid = logical;
-	key.type = 0;
-	key.offset = 0;
-
-	ret = btrfs_search_slot(NULL, fs_info->extent_root, &key, path,
-				0, 0);
-	if (ret < 0)
-		goto out;
-	BUG_ON(ret == 0);
-	ret = 0;
-
-again:
-	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-	if ((search_forward && key.objectid < logical) ||
-	    (!search_forward && key.objectid > logical) ||
-	    (key.type != BTRFS_EXTENT_ITEM_KEY &&
-	     key.type != BTRFS_METADATA_ITEM_KEY)) {
-		if (!search_forward)
-			ret = btrfs_previous_extent_item(fs_info->extent_root,
-							 path, 0);
-		else
-			ret = btrfs_next_extent_item(fs_info->extent_root,
-						     path, 0);
-		if (ret)
-			goto out;
-		goto again;
-	}
-	logical = key.objectid;
-	if (key.type == BTRFS_METADATA_ITEM_KEY)
-		len = fs_info->nodesize;
-	else
-		len = key.offset;
-
-out:
-	btrfs_free_path(path);
-	if (!ret) {
-		*logical_ret = logical;
-		if (len_ret)
-			*len_ret = len;
-	}
-	return ret;
-}
-
 static int __print_mapping_info(struct btrfs_fs_info *fs_info, u64 logical,
 				u64 len, int mirror_num)
 {
@@ -134,16 +75,6 @@ static int __print_mapping_info(struct btrfs_fs_info *fs_info, u64 logical,
 	return ret;
 }
 
-/*
- * Logical and len is the exact value of a extent.
- * And offset is the offset inside the extent. It's only used for case
- * where user only want to print part of the extent.
- *
- * Caller *MUST* ensure the range [logical,logical+len) are in one extent.
- * Or we can encounter the following case, causing a -ENOENT error:
- * |<-----given parameter------>|
- *		|<------ Extent A ----->|
- */
 static int print_mapping_info(struct btrfs_fs_info *fs_info, u64 logical,
 			      u64 len)
 {
@@ -213,10 +144,7 @@ int main(int argc, char **argv)
 	u64 copy = 0;
 	u64 logical = 0;
 	u64 bytes = 0;
-	u64 cur_logical = 0;
-	u64 cur_len = 0;
 	int out_fd = -1;
-	int found = 0;
 	int ret = 0;
 
 	while(1) {
@@ -300,76 +228,13 @@ int main(int argc, char **argv)
 		goto close;
 	}
 
-	cur_logical = logical;
-	cur_len = bytes;
-
-	/* First find the nearest extent */
-	ret = map_one_extent(root->fs_info, &cur_logical, &cur_len, 0);
-	if (ret < 0) {
-		errno = -ret;
-		fprintf(stderr, "Failed to find extent at [%llu,%llu): %m\n",
-			cur_logical, cur_logical + cur_len);
+	ret = print_mapping_info(root->fs_info, logical, bytes);
+	if (ret < 0)
 		goto out_close_fd;
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
-
-	while (cur_logical + cur_len >= logical && cur_logical < logical +
-	       bytes) {
-		u64 real_logical;
-		u64 real_len;
+	if (output_file && out_fd != -1)
+		ret = write_extent_content(root->fs_info, out_fd, logical,
+					   bytes, copy);
 
-		found = 1;
-		ret = map_one_extent(root->fs_info, &cur_logical, &cur_len, 1);
-		if (ret < 0)
-			goto out_close_fd;
-		if (ret > 0)
-			break;
-		/* check again if there is overlap. */
-		if (cur_logical + cur_len < logical ||
-		    cur_logical >= logical + bytes)
-			break;
-
-		real_logical = max(logical, cur_logical);
-		real_len = min(logical + bytes, cur_logical + cur_len) -
-			   real_logical;
-
-		ret = print_mapping_info(root->fs_info, real_logical, real_len);
-		if (ret < 0)
-			goto out_close_fd;
-		if (output_file && out_fd != -1) {
-			ret = write_extent_content(root->fs_info, out_fd,
-					real_logical, real_len, copy);
-			if (ret < 0)
-				goto out_close_fd;
-		}
-
-		cur_logical += cur_len;
-	}
-
-	if (!found) {
-		fprintf(stderr, "No extent found at range [%llu,%llu)\n",
-			logical, logical + bytes);
-	}
 out_close_fd:
 	if (output_file && out_fd != 1)
 		close(out_fd);
-- 
2.32.0

