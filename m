Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B12798B6C
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 19:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbjIHRVD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 13:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjIHRVC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 13:21:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCDD199F
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 10:20:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C09AC433D9
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 17:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694193658;
        bh=p4DpYQJU4IDKKFFOXXn+x0V0ymG8TqWRwOgMEQPyZcc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fPqnuyo06B2RbN5SE0Zk6kyAvr3IMp7DZHjd/XhA5iHUo/AzwUibQzJzhtV7r3Fy1
         5NAI/teh2m5lv8NoHk6ssAluy9VC6b7ib6f/+a8ojdKZD1ekQilVCUx5bsni56usZ2
         p1CrjON7ImZ9m/2CZ4rbYQ0t+TeMVJVx++NlIXDgb1YwO1UDAO4wPIFJdZcCI6yjM+
         oP9qXs4alnHHs1AmxXn+X3QHfGmEPrYgncBfa0cxvCCbEoL4Ucd2czgHyPGJmQP/AD
         L2vqOKZ1Jp2n6Kt63PXGFYK7zpLIQsJixgpgyrJLQziFFHE4bijRs1HZ7QJKH93Yd2
         AlPhiQWquIUBA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 16/21] btrfs: simplify check for extent item overrun at lookup_inline_extent_backref()
Date:   Fri,  8 Sep 2023 18:20:33 +0100
Message-Id: <85ad072aedd963064108b0bdc643a7b11140aac6.1694192469.git.fdmanana@suse.com>
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

At lookup_inline_extent_backref() we can simplify the check for an overrun
of the extent item by making the while loop's condition to be "ptr < end"
and then check after the loop if an overrun happened ("ptr > end"). This
reduces indentation and makes the loop condition more clear. So move the
check out of the loop and change the loop condition accordingly, while
also adding the 'unlikely' tag to the check since it's not supposed to be
triggered.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
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

