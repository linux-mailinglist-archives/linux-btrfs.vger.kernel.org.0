Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0F06F59FC
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 16:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjECO2E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 10:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjECO2C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 10:28:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481D16A66;
        Wed,  3 May 2023 07:28:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4B3662E07;
        Wed,  3 May 2023 14:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9D1C433EF;
        Wed,  3 May 2023 14:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683124080;
        bh=ABuVTplRWRpQstx/1NGqjDcn+Pvo+vhiLgw2SQpDxxc=;
        h=From:To:Cc:Subject:Date:From;
        b=oHKk9ob10XBxLHs+egtk8X2pDBuadJ3qE9Rw6BuJK1MC3f8fPVVTWCJRHCQW//9fy
         PW5I2+ri/MD4r91wRLzcw/ojwFo578aG6QA68uVNsvb1Tq2Z4knG7EfbFnByxllFj4
         3dLX6YABX+zIYshH/TvkTVe2oePOnQWFj9B7D6AIxAaAOHk2spYSq28GVNj/Mmo6Gr
         j3va7q/cLNk2f/uBP+EvetdU3v79qXbomhri3TfDqufMc9/ANqbw9x6mzyUWaRVu4t
         5ivKB4Xu9UPGkeq+qGfUnGTa2Jjftdfqa9F8DHL05/2S9Idaaa7bp4Ia8wO68K7nEN
         1g+3bZ+LpWDBQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     git@vladimir.panteleev.md, Filipe Manana <fdmanana@suse.com>,
        stable@vger.kernel.org
Subject: [PATCH] btrfs: fix backref walking not returning all inode refs
Date:   Wed,  3 May 2023 15:27:44 +0100
Message-Id: <77994dd9ede2084d45dd0a36938c67de70d8e859.1683123587.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
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
function.

So fix this by always calling check_extent_in_eb() and have this function
do the filtering only if an extent offset is given and the flag to ignore
offsets is not set.

Fixes: 6ce6ba534418 ("btrfs: use a single argument for extent offset in backref walking functions")
Reported-by: Vladimir Panteleev <git@vladimir.panteleev.md>
Link: https://lore.kernel.org/linux-btrfs/CAHhfkvwo=nmzrJSqZ2qMfF-rZB-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com/
Tested-by: Vladimir Panteleev <git@vladimir.panteleev.md>
CC: stable@vger.kernel.org # 6.2+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index e54f0884802a..8e61be3fe9a8 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -45,7 +45,9 @@ static int check_extent_in_eb(struct btrfs_backref_walk_ctx *ctx,
 	int root_count;
 	bool cached;
 
-	if (!btrfs_file_extent_compression(eb, fi) &&
+	if (!ctx->ignore_extent_item_pos &&
+	    ctx->extent_item_pos > 0 &&
+	    !btrfs_file_extent_compression(eb, fi) &&
 	    !btrfs_file_extent_encryption(eb, fi) &&
 	    !btrfs_file_extent_other_encoding(eb, fi)) {
 		u64 data_offset;
@@ -552,13 +554,10 @@ static int add_all_parents(struct btrfs_backref_walk_ctx *ctx,
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
-- 
2.35.1

