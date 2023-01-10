Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E776643C9
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 15:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238752AbjAJO5X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 09:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238732AbjAJO4t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 09:56:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8BD10FCE
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 06:56:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E7A2B816AA
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 14:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAEDC433D2
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 14:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673362605;
        bh=TPcb0N83Ojv3uuSsiRNIqW2wrR0rXtDPYvdZ1Qzz/Ts=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NXGRulTqcFUs4pltlLT+Rm6Ln/dd5Kk+gEBef3UnAU7UNbM/H+L12TG8gMT7SzgiK
         ACmHAMsMAcYVQEW6bndWs5ltgXnbrv8ykEHwFx/ul7nHj1lklgJehxQkdP0cD8mWU4
         P2nnW/W+wt73SJYmI0xJPqOLL1Cey95HKtxXeLKNFk2SW27duFqL+Vu7AvirxgvG18
         f5XSPBWiXPkiOhlfgBpAX+dghl5PalGNjiwhV3YDm4fFVm1wUXzUl0jVjwLwFS3LS3
         8vuuj8gignWnR+2uYrY4ksD1/eXF/NOw/KfUW95JC4nxRwioLka9yoshcSSWbrR3BB
         oRuN+2j125bTA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/8] btrfs: fix missing error handling when logging directory items
Date:   Tue, 10 Jan 2023 14:56:34 +0000
Message-Id: <23a61ed49b94ac73f5a05ca17c6324c7ad7eaad3.1673361215.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1673361215.git.fdmanana@suse.com>
References: <cover.1673361215.git.fdmanana@suse.com>
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

When logging a directory, at log_dir_items(), if we get an error when
attempting to search the subvolume tree for a dir index item, we end up
returning 0 (success) from log_dir_items() because 'err' is left with a
value of 0.

This can lead to a few problems, specially in the case the variable
'last_offset' has a value of (u64)-1 (and it's initialized to that when
it was declared):

1) By returning from log_dir_items() with success (0) and a value of
   (u64)-1 for '*last_offset_ret', we end up not logging any other dir
   index keys that follow the missing, just deleted, index key. The
   (u64)-1 value makes log_directory_changes() not call log_dir_items()
   again;

2) Before returning with success (0), log_dir_items(), will log a dir
   index range item covering a range from the last old dentry index
   (stored in the variable 'last_old_dentry_offset') to the value of
   'last_offset'. If 'last_offset' has a value of (u64)-1, then it means
   if the log is persisted and replayed after a power failure, it will
   cause deletion of all the directory entries that have an index number
   between last_old_dentry_offset + 1 and (u64)-1;

3) We can end up returning from log_dir_items() with
   ctx->last_dir_item_offset having a lower value than
   inode->last_dir_index_offset, because the former is set to the current
   key we are processing at process_dir_items_leaf(), and at the end of
   log_directory_changes() we set inode->last_dir_index_offset to the
   current value of ctx->last_dir_item_offset. So if for example a
   deletion of a lower dir index key happened, we set
   ctx->last_dir_item_offset to that index value, then if we return from
   log_dir_items() because btrfs_search_slot() returned an error, we end up
   returning without any error from log_dir_items() and then
   log_directory_changes() sets inode->last_dir_index_offset to a lower
   value than it had before.
   This can result in unpredictable and unexpected behaviour when we
   need to log again the directory in the same transaction, and can result
   in ending up with a log tree leaf that has duplicated keys, as we do
   batch insertions of dir index keys into a log tree.

Fix this by setting 'err' to the value of 'ret' in case
btrfs_search_slot() or btrfs_previous_item() returned an error. That will
result in falling back to a full transaction commit.

Reported-by: David Arendt <admin@prnet.org>
Link: https://lore.kernel.org/linux-btrfs/ae169fc6-f504-28f0-a098-6fa6a4dfb612@leemhuis.info/
Fixes: e02119d5a7b4 ("Btrfs: Add a write ahead tree log to optimize synchronous operations")
CC: stable@vger.kernel.org # 4.14+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index fb52aa060093..3ef0266e9527 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3826,7 +3826,10 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 					      path->slots[0]);
 			if (tmp.type == BTRFS_DIR_INDEX_KEY)
 				last_old_dentry_offset = tmp.offset;
+		} else if (ret < 0) {
+			err = ret;
 		}
+
 		goto done;
 	}
 
@@ -3846,7 +3849,11 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 		 */
 		if (tmp.type == BTRFS_DIR_INDEX_KEY)
 			last_old_dentry_offset = tmp.offset;
+	} else if (ret < 0) {
+		err = ret;
+		goto done;
 	}
+
 	btrfs_release_path(path);
 
 	/*
@@ -3859,6 +3866,8 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 	 */
 search:
 	ret = btrfs_search_slot(NULL, root, &min_key, path, 0, 0);
+	if (ret < 0)
+		err = ret;
 	if (ret != 0)
 		goto done;
 
-- 
2.35.1

