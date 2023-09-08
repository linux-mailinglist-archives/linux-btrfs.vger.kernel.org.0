Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18297986C6
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 14:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243153AbjIHMJg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 08:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243101AbjIHMJf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 08:09:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999C31BE7
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 05:09:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D95C433C8
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 12:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694174971;
        bh=4rSp1bl4srJlcoc8eK6Hkfg6+ySetUte9rVjPTPcvlU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WMQn3Se54lGig0DdBfeter1quSmSQRqXEhe5QREyxSZwFNi8MPqI4oq2+/Y05jlJ2
         Qi+b09LJ40c4j4G2egUYqMfPYkg4wRKC77w06LBjZklHzFdQCn0TRGjx0KktaGyWC8
         SXsKZAkYn4Yzjiz7ysmJfwKM3l0L0d0BW7Rg/Hh0agY0jKs7AWgssxjTRP/MSy9x+s
         96UkzUycelMMenPrDjJ5LeGXAXnUKioKffQbw0TiKfR8ays9kdr7tHFbOoWAj3DVjf
         MFI1Mq9OZ3P3OVcmuf7Kkfww87hf2fa7Qruwt64vWa2YG2MBcPQrSI5FhUK8YTpRjW
         9lHG8eFqG93/A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/21] btrfs: remove unnecessary logic when running new delayed references
Date:   Fri,  8 Sep 2023 13:09:06 +0100
Message-Id: <fbc35af56c5b21fbceba9c0c1038a03907361427.1694174371.git.fdmanana@suse.com>
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

When running delayed references, at btrfs_run_delayed_refs(), we have this
logic to run any new delayed references that might have been added just
after we ran all delayed references. This logic grabs the first delayed
reference, then locks it to wait for any contention on it before running
all new delayed references. This however is pointless and not necessary
because at __btrfs_run_delayed_refs() when we start running delayed
references, we pick the first reference with btrfs_obtain_ref_head() and
then we will lock it (with btrfs_delayed_ref_lock()).

So remove the duplicate and unnecessary logic at btrfs_run_delayed_refs().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 07d3896e6824..929fbb620d68 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2135,9 +2135,7 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 			   unsigned long count)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct rb_node *node;
 	struct btrfs_delayed_ref_root *delayed_refs;
-	struct btrfs_delayed_ref_head *head;
 	int ret;
 	int run_all = count == (unsigned long)-1;
 
@@ -2166,25 +2164,16 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 		btrfs_create_pending_block_groups(trans);
 
 		spin_lock(&delayed_refs->lock);
-		node = rb_first_cached(&delayed_refs->href_root);
-		if (!node) {
+		if (RB_EMPTY_ROOT(&delayed_refs->href_root.rb_root)) {
 			spin_unlock(&delayed_refs->lock);
-			goto out;
+			return 0;
 		}
-		head = rb_entry(node, struct btrfs_delayed_ref_head,
-				href_node);
-		refcount_inc(&head->refs);
 		spin_unlock(&delayed_refs->lock);
 
-		/* Mutex was contended, block until it's released and retry. */
-		mutex_lock(&head->mutex);
-		mutex_unlock(&head->mutex);
-
-		btrfs_put_delayed_ref_head(head);
 		cond_resched();
 		goto again;
 	}
-out:
+
 	return 0;
 }
 
-- 
2.40.1

