Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02B77986CD
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 14:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241557AbjIHMJr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 08:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbjIHMJq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 08:09:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EDC1BC5
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 05:09:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F640C433C8
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 12:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694174982;
        bh=WpLaJ0PmwGZxfUWa6spM04Hfy13Dwhu2fQCqMTAcM3I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=q7JQrQlbokLgJJ9P3S38qeAg8xSWFwVXlTxBdpkERG/qBRN7SzdAGD4fXzfSLUjfu
         cZrrVnJ8iYyLDPZQLF7oFuQbP9J1VXE0TPxFXyJkF5tE7Rgzn4YPTw+YP0Xj5t2w9B
         WMhQ/FT2YpquPERxM9Fpo/62EBAhNesmy7ihe0K3vpIlQ70FdJRvPhhgwU6Ofv8w0L
         o4V1b4CzkAizI8SgC/F50sR10WFafVgepYa9Eh6dtKMcyZUYtftt9wBF3Z8RbBem3w
         vL/C11R2V3GWc9cUzJW0bb5Dbj794i+NJ+1D+iVZBTmgvRcc/ZVFMjAMtuSwuxe8ah
         Sjs6MnHr2EVpg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 16/21] btrfs: simplify check for extent item overrun at lookup_inline_extent_backref()
Date:   Fri,  8 Sep 2023 13:09:18 +0100
Message-Id: <1e6e5a365ce01567b0334ac2792c8e8aa1fe1a64.1694174371.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694174371.git.fdmanana@suse.com>
References: <cover.1694174371.git.fdmanana@suse.com>
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

At lookup_inline_extent_backref() we can simplify the check for an overrun
of the extent item by making the while loop's condition to be "ptr < end"
and then check after the loop if an overrun happened ("ptr > end"). This
reduces indentation and makes the loop condition more clear. So move the
check out of the loop and change the loop condition accordingly, while
also adding the 'unlikely' tag to the check since it's not supposed to be
triggered.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 756589195ed7..b27e0a6878b3 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -883,17 +883,7 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 		needed = BTRFS_REF_TYPE_BLOCK;
 
 	ret = -ENOENT;
-	while (1) {
-		if (ptr >= end) {
-			if (ptr > end) {
-				ret = -EUCLEAN;
-				btrfs_print_leaf(path->nodes[0]);
-				btrfs_crit(fs_info,
-"overrun extent record at slot %d while looking for inline extent for root %llu owner %llu offset %llu parent %llu",
-					path->slots[0], root_objectid, owner, offset, parent);
-			}
-			break;
-		}
+	while (ptr < end) {
 		iref = (struct btrfs_extent_inline_ref *)ptr;
 		type = btrfs_get_extent_inline_ref_type(leaf, iref, needed);
 		if (type == BTRFS_REF_TYPE_INVALID) {
@@ -940,6 +930,16 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 		}
 		ptr += btrfs_extent_inline_ref_size(type);
 	}
+
+	if (unlikely(ptr > end)) {
+		ret = -EUCLEAN;
+		btrfs_print_leaf(path->nodes[0]);
+		btrfs_crit(fs_info,
+"overrun extent record at slot %d while looking for inline extent for root %llu owner %llu offset %llu parent %llu",
+			   path->slots[0], root_objectid, owner, offset, parent);
+		goto out;
+	}
+
 	if (ret == -ENOENT && insert) {
 		if (item_size + extra_size >=
 		    BTRFS_MAX_EXTENT_ITEM_SIZE(root)) {
-- 
2.40.1

