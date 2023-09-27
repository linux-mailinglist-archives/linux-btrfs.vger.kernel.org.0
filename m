Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0348A7B0270
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 13:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjI0LJg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 07:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjI0LJf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 07:09:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6416F3
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 04:09:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12033C433CA
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 11:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695812974;
        bh=xXuWEQOi3gdc7GHIrTSkVszM4BD0dUjzQcYv8cXbhaY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=r1KrrJ+I1ReLn0LG7alVJRScQ0VrUO8xKjqJYg7rusiAJzX/L2z3zN/yx+vwpyGi/
         bMCJp3JARGCTjkFiA+qQe94j0ImlwCpOc8vVJ2AyHyqk67OP06A9R71zbgYMq8FYWt
         qzReP/W/KkcvfDtpR3swshR5sOaxryhHUEV4NzK3dLgb1jkPxeLJHOwg/E422jJlLF
         8/xnf5NLSNizQRFIX1LpQxqQSaTmOeidGHrpAUU++VXTS0N8RjGdSQM2ckDhfzr0xs
         SqMhKsN2VeaW1s/WnlStBVgprpQoahtIeEuPB7KN4X/v2A0ZJMP5iYjwnrd1Yvhk8C
         xOLBvBu3OeifA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/8] btrfs: error when COWing block from a root that is being deleted
Date:   Wed, 27 Sep 2023 12:09:22 +0100
Message-Id: <1ca7eb533712b99bea8e5e00141176df15270b3b.1695812791.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695812791.git.fdmanana@suse.com>
References: <cover.1695812791.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_cow_block() we check if the block being COWed belongs to a root
that is being deleted and if so we log an error message. However this is
an unexpected case and it indicates a bug somewhere, so we should return
an error and abort the transaction. So change this in the following ways:

1) Abort the transaction with -EUCLEAN, so that if the issue ever happens
   it can easily be noticed;

2) Change the logged message level from error to critical, and change the
   message itself to print the block's logical address and the ID of the
   root;

3) Return -EUCLEAN to the caller;

4) As this is an unexpected scenario, that should never happen, mark the
   check as unlikely, allowing the compiler to potentially generate better
   code.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 29b887ffe682..e3382542f642 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -682,9 +682,13 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 	u64 search_start;
 	int ret;
 
-	if (test_bit(BTRFS_ROOT_DELETING, &root->state))
-		btrfs_err(fs_info,
-			"COW'ing blocks on a fs root that's being dropped");
+	if (unlikely(test_bit(BTRFS_ROOT_DELETING, &root->state))) {
+		btrfs_abort_transaction(trans, -EUCLEAN);
+		btrfs_crit(fs_info,
+		   "attempt to COW block %llu on root %llu that is being deleted",
+			   buf->start, btrfs_root_id(root));
+		return -EUCLEAN;
+	}
 
 	/*
 	 * COWing must happen through a running transaction, which always
-- 
2.40.1

