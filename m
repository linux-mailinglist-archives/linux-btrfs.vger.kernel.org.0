Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B8E6F68E7
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 12:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjEDKMX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 06:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjEDKMT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 06:12:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4524C26;
        Thu,  4 May 2023 03:12:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 660A0632D4;
        Thu,  4 May 2023 10:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97E4C433D2;
        Thu,  4 May 2023 10:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683195135;
        bh=onvVQ3+1KpThaLhopBbyOqMFIiqDs9AO5jNZlwVbH8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DkbyU9ry46ovyngXuBT//AFYDo8oI14c6vKqLk8bR+ekurqBSN4JeeDF9LPPwLKqz
         mz1HGe4ETPGa6LftRurkFPAI+sw+ptJaYSZ3Sut+4mwkIEJMQ3NY/uqJ/goarZPpEG
         6FPm6xm6zR3RvywYpEVMhc0zBCuMsl6x2IjOjK9PgE5JFymlUZiu4ZtT+z8/HZMw0G
         xrpjHKhbOgMkt7v5plBffKhYjdLboSjZ8NzJjDU9boqZAsVSmqVkkC2fMy783j3sR5
         F8g3hNWEUTgTKJF3CtK8YBsGWLUTFjhBdsEMi2nCVF5fuDb4Qhw9yNgSyRtWuY1Vbj
         q01FZs7l5SXDQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     git@vladimir.panteleev.md, Filipe Manana <fdmanana@suse.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] btrfs: fix backref walking not returning all inode refs
Date:   Thu,  4 May 2023 11:12:03 +0100
Message-Id: <b04cbeb31e221edea8afa75679e4a55633748af7.1683194376.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <77994dd9ede2084d45dd0a36938c67de70d8e859.1683123587.git.fdmanana@suse.com>
References: <77994dd9ede2084d45dd0a36938c67de70d8e859.1683123587.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When using the logical to ino ioctl v2, if the flag to ignore offsets of
file extent items (BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET) is given, the
backref walking code ends up not returning references for all file offsets
of an inode that point to the given logical bytenr. This happens since
kernel 6.2, commit 6ce6ba534418 ("btrfs: use a single argument for extent
offset in backref walking functions"), as it mistakenly skipped the search
for file extent items in a leaf that point to the target extent if that
flag is given. Instead it should only skip the filtering done by
check_extent_in_eb() - that is, it should not avoid the calls to that
function (or find_extent_in_eb(), which uses it).

So fix this by always calling check_extent_in_eb() and find_extent_in_eb()
and have check_extent_in_eb() do the filtering only if the flag to ignore
offsets is set.

Fixes: 6ce6ba534418 ("btrfs: use a single argument for extent offset in backref walking functions")
Reported-by: Vladimir Panteleev <git@vladimir.panteleev.md>
Link: https://lore.kernel.org/linux-btrfs/CAHhfkvwo=nmzrJSqZ2qMfF-rZB-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com/
Tested-by: Vladimir Panteleev <git@vladimir.panteleev.md>
CC: stable@vger.kernel.org # 6.2+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Remove wrong check for a non-zero extent item offset.
    Apply the same logic at find_parent_nodes(), that is, search for file
    extent items on a leaf if the ignore flag is given - the filtering
    will be done later at check_extent_in_eb(). Spotted by Vladimir Panteleev
    in the thread mentioned above.

 fs/btrfs/backref.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index e54f0884802a..787417f9893c 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -45,7 +45,8 @@ static int check_extent_in_eb(struct btrfs_backref_walk_ctx *ctx,
 	int root_count;
 	bool cached;
 
-	if (!btrfs_file_extent_compression(eb, fi) &&
+	if (!ctx->ignore_extent_item_pos &&
+	    !btrfs_file_extent_compression(eb, fi) &&
 	    !btrfs_file_extent_encryption(eb, fi) &&
 	    !btrfs_file_extent_other_encoding(eb, fi)) {
 		u64 data_offset;
@@ -552,13 +553,10 @@ static int add_all_parents(struct btrfs_backref_walk_ctx *ctx,
 				count++;
 			else
 				goto next;
-			if (!ctx->ignore_extent_item_pos) {
-				ret = check_extent_in_eb(ctx, &key, eb, fi, &eie);
-				if (ret == BTRFS_ITERATE_EXTENT_INODES_STOP ||
-				    ret < 0)
-					break;
-			}
-			if (ret > 0)
+			ret = check_extent_in_eb(ctx, &key, eb, fi, &eie);
+			if (ret == BTRFS_ITERATE_EXTENT_INODES_STOP || ret < 0)
+				break;
+			else if (ret > 0)
 				goto next;
 			ret = ulist_add_merge_ptr(parents, eb->start,
 						  eie, (void **)&old, GFP_NOFS);
@@ -1606,8 +1604,7 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
 				goto out;
 		}
 		if (ref->count && ref->parent) {
-			if (!ctx->ignore_extent_item_pos && !ref->inode_list &&
-			    ref->level == 0) {
+			if (!ref->inode_list && ref->level == 0) {
 				struct btrfs_tree_parent_check check = { 0 };
 				struct extent_buffer *eb;
 
-- 
2.35.1

