Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8090E7B0271
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 13:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjI0LJh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 07:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjI0LJh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 07:09:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED95FF3
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 04:09:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157AFC433C8
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 11:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695812975;
        bh=wkyhGgnWDEVTQKWXSFMOPVrGp3WWFMurduUQPv2w1KE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nPPO7ZNyIOeb68svFWVStQD/zlzvM8jdrKOoR0GBqKyP11fsMC3Uo6a5yaB0g7h8k
         VKjImUXEGK9PSmbKfzLaKr4bxhXEabWlbVhQrtNRcvorEBjOe+kmhp0nEZboADjyuR
         qa1B7VMkMNUpVfQck0ZEb58KlPDn3Eqeqje894deh6a3YnltQFvu6Xe874vprLxq71
         6C/kFktOIKwjMcJsTb5Q0ftw+4QTdi45PZZNe1vg+l0795gk/QXDqrtKEpfLR5Pe/3
         AhoyuTaSf/U3r2j9LDp8mgxzz/Z4bnUYiCy8Z/rV+BC+bumEhbteHFIx9CvHBPOlU7
         qeuMVd4riT6jg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/8] btrfs: error out when reallocating block for defrag using a stale transaction
Date:   Wed, 27 Sep 2023 12:09:23 +0100
Message-Id: <1bdbd3ce36b1b6c0e6eca75ac02b2cde581eb72c.1695812791.git.fdmanana@suse.com>
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

At btrfs_realloc_node() we have these checks to verify we are not using a
stale transaction (a past transaction with an unblocked state or higher),
and the only thing we do is to trigger two WARN_ON(). This however is a
critical problem, highly unexpected and if it happens it's most likely due
to a bug, so we should error out and turn the fs into error state so that
such issue is much more easily noticed if it's triggered.

The problem is critical because in btrfs_realloc_node() we COW tree blocks,
and using such stale transaction will lead to not persisting the extent
buffers used for the COW operations, as allocating tree block adds the
range of the respective extent buffers to the ->dirty_pages iotree of the
transaction, and a stale transaction, in the unlocked state or higher,
will not flush dirty extent buffers anymore, therefore resulting in not
persisting the tree block and resource leaks (not cleaning the dirty_pages
iotree for example).

So do the following changes:

1) Return -EUCLEAN if we find a stale transaction;

2) Turn the fs into error state, with error -EUCLEAN, so that no
   transaction can be committed, and generate a stack trace;

3) Combine both conditions into a single if statement, as both are related
   and have the same error message;

4) Mark the check as unlikely, since this is not expected to ever happen.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index e3382542f642..2a51cac7f21d 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -817,8 +817,22 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 	int progress_passed = 0;
 	struct btrfs_disk_key disk_key;
 
-	WARN_ON(trans->transaction != fs_info->running_transaction);
-	WARN_ON(trans->transid != fs_info->generation);
+	/*
+	 * COWing must happen through a running transaction, which always
+	 * matches the current fs generation (it's a transaction with a state
+	 * less than TRANS_STATE_UNBLOCKED). If it doesn't, then turn the fs
+	 * into error state to prevent the commit of any transaction.
+	 */
+	if (unlikely(trans->transaction != fs_info->running_transaction ||
+		     trans->transid != fs_info->generation)) {
+		btrfs_abort_transaction(trans, -EUCLEAN);
+		btrfs_crit(fs_info,
+"unexpected transaction when attempting to reallocate parent %llu for root %llu, transaction %llu running transaction %llu fs generation %llu",
+			   parent->start, btrfs_root_id(root), trans->transid,
+			   fs_info->running_transaction->transid,
+			   fs_info->generation);
+		return -EUCLEAN;
+	}
 
 	parent_nritems = btrfs_header_nritems(parent);
 	blocksize = fs_info->nodesize;
-- 
2.40.1

