Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8BB6742F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 20:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjASTjo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 14:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjASTjl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 14:39:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE89F951B4
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 11:39:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FE8461D57
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460F7C433F0
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674157179;
        bh=Jwof/HOXT1lKIQJf1gyF4f3kf2bv29gwLrIBHzj9FfU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pYWQJvNxyCETlYOpteVgqz7ikVOjatiSTEV42ya8QD7HfFPWqi9Ibs6S/eazwdcoK
         odNLvtVw3uogX5gfTTDaxViXrXPc/+ssfFyZ4EGNgKHTRHLQKRlkkzeW4YLAMEo/cK
         EmTuQjB6yC8eoAnWS1k6LHShs9zF37jt2/pBrY6vL3p7Mm5N5ekico5GEY7QCROOWc
         35Ipw57InVxSMcQ5o540c/I+HW6lCwBwtnZRwzXz12o9yz8pG9vZHDKfBrVG6LyhRD
         cbSER/Ega7Dik9zhTN35RfdikaNLw7mG5iN5kyXWrWQXZ8ibWR30d7HsnHmmxcnKNs
         MsFEY8T7fJiDw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 06/18] btrfs: send: avoid duplicated orphan dir allocation and initialization
Date:   Thu, 19 Jan 2023 19:39:18 +0000
Message-Id: <32617d6f2caa097cdd66227a5701de21c51c8c2d.1674157020.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1674157020.git.fdmanana@suse.com>
References: <cover.1674157020.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At can_rmdir() we are allocating and initializing an orphan dir object
twice. This can be deduplicated outside of the loop that iterates over
the dir index keys. So deduplicate that code, even because other patch
in the series will need to add more initializion code and another one
will add one more condition.

This patch is part of a larger patchset and the changelog of the last
patch in the series contains a sample performance test and results.
The patches that comprise the patchset are the following:

  btrfs: send: directly return from did_overwrite_ref() and simplify it
  btrfs: send: avoid unnecessary generation search at did_overwrite_ref()
  btrfs: send: directly return from will_overwrite_ref() and simplify it
  btrfs: send: avoid extra b+tree searches when checking reference overrides
  btrfs: send: remove send_progress argument from can_rmdir()
  btrfs: send: avoid duplicated orphan dir allocation and initialization
  btrfs: send: avoid unnecessary orphan dir rbtree search at can_rmdir()
  btrfs: send: reduce searches on parent root when checking if dir can be removed
  btrfs: send: iterate waiting dir move rbtree only once when processing refs
  btrfs: send: initialize all the red black trees earlier
  btrfs: send: genericize the backref cache to allow it to be reused
  btrfs: adapt lru cache to allow for 64 bits keys on 32 bits systems
  btrfs: send: cache information about created directories
  btrfs: allow a generation number to be associated with lru cache entries
  btrfs: add an api to delete a specific entry from the lru cache
  btrfs: send: use the lru cache to implement the name cache
  btrfs: send: update size of roots array for backref cache entries
  btrfs: send: cache utimes operations for directories if possible

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 32dd88ed629a..f7d533c364b1 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -3253,13 +3253,6 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen)
 
 		dm = get_waiting_dir_move(sctx, loc.objectid);
 		if (dm) {
-			odi = add_orphan_dir_info(sctx, dir, dir_gen);
-			if (IS_ERR(odi)) {
-				ret = PTR_ERR(odi);
-				goto out;
-			}
-			odi->gen = dir_gen;
-			odi->last_dir_index_offset = found_key.offset;
 			dm->rmdir_ino = dir;
 			dm->rmdir_gen = dir_gen;
 			ret = 0;
@@ -3267,13 +3260,6 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen)
 		}
 
 		if (loc.objectid > sctx->cur_ino) {
-			odi = add_orphan_dir_info(sctx, dir, dir_gen);
-			if (IS_ERR(odi)) {
-				ret = PTR_ERR(odi);
-				goto out;
-			}
-			odi->gen = dir_gen;
-			odi->last_dir_index_offset = found_key.offset;
 			ret = 0;
 			goto out;
 		}
@@ -3288,7 +3274,18 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen)
 
 out:
 	btrfs_free_path(path);
-	return ret;
+
+	if (ret)
+		return ret;
+
+	odi = add_orphan_dir_info(sctx, dir, dir_gen);
+	if (IS_ERR(odi))
+		return PTR_ERR(odi);
+
+	odi->gen = dir_gen;
+	odi->last_dir_index_offset = found_key.offset;
+
+	return 0;
 }
 
 static int is_waiting_for_move(struct send_ctx *sctx, u64 ino)
-- 
2.35.1

