Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75250798B63
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 19:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245370AbjIHRUz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 13:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245159AbjIHRUw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 13:20:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DF5CE6
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 10:20:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1B9C433C8
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 17:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694193649;
        bh=ch6hzQCf5+/4tM6R9la/DCt2U4s80l5B2XAUzv8/kfU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=R5ImJ/byTjS18Aw2J29vcyy0P0Gk87dRwg1cTAC6EA5KW7oaKMbUYsGXXxPIjK/Mk
         pqxLtGxePQQTRV6XcFjcNrKFmop9N0fNz1MMMkYgLaCyoevR0AhKxhJ2Krd4azNWoc
         kr/tUI47qT7ZMEsQYbM9+6uk8t9oi55xVqbnak8MYNds+oe4/kVVjqk8E4olQC0VZ0
         McNEjii1w7D/G8sHxIwc00/8SegSetpXDb20EJ8ftVTunYTh/b/fMm+8JAcosyBSf0
         ijUfOS8xBNsJNgBlowSP4+JVFIKR/2n6j+wIMnuzG8ECCPSZDfKUAomSXDRbias9ZR
         K0piDE1cqXZ2w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 07/21] btrfs: remove redundant BUG_ON() from __btrfs_inc_extent_ref()
Date:   Fri,  8 Sep 2023 18:20:24 +0100
Message-Id: <d4ddcd79bae6c937a9f878d3afe3c8747566b6e0.1694192469.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694192469.git.fdmanana@suse.com>
References: <cover.1694192469.git.fdmanana@suse.com>
MIME-Version: 1.0
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

At __btrfs_inc_extent_ref() we are doing a BUG_ON() if we are dealing with
a tree block reference that has a reference count that is different from 1,
but we have already dealt with this case at run_delayed_tree_ref(), making
it useless. So remove the BUG_ON().

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8fca9c2b8917..cf503f2972a1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1514,15 +1514,14 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	btrfs_release_path(path);
 
 	/* now insert the actual backref */
-	if (owner < BTRFS_FIRST_FREE_OBJECTID) {
-		BUG_ON(refs_to_add != 1);
+	if (owner < BTRFS_FIRST_FREE_OBJECTID)
 		ret = insert_tree_block_ref(trans, path, bytenr, parent,
 					    root_objectid);
-	} else {
+	else
 		ret = insert_extent_data_ref(trans, path, bytenr, parent,
 					     root_objectid, owner, offset,
 					     refs_to_add);
-	}
+
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
 out:
-- 
2.40.1

