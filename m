Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98C97E2E08
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 21:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjKFURp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 15:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjKFURo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 15:17:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BA0DA
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 12:17:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A512FC433C8
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 20:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699301861;
        bh=WKIpRecyq/9xi4qj3L2MpgUZj1dTe5nplVKjtgqLi5A=;
        h=From:To:Subject:Date:From;
        b=jQiRzsaxkV3iWfX4Vz8L9V3LOxjDEbukM1XeQwNnicnPw/dgqGhZl74WQQWdsF+m1
         ScXp8TAe666aXXUvYLQ4eyRF4IM3y3GCvd0orx3J163WZdNwVmYH5cIBc5P980bTzl
         XCuix0TydHXVN9ygQ7IAiYOk9lSDClSOjwMtHI3lqiNbdV31QhNWk9owDr0LjE3FCe
         IgZt+u2JiFFNEmb1lZXhp0tL3NG8CYnWsUYcGULTYXn/9yb6895j1UNEJx9Iba2O4e
         QmVsBPRqBTOFlEwbqrcHV1ae5JYTKHSVlIhI2I8/DYIJj2XpKTGTrz+1bLkpd5sUmw
         Zoi9BT6FWqVfA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix qgroup record leaks when using simple quotas
Date:   Mon,  6 Nov 2023 20:17:37 +0000
Message-Id: <2431d473c04bede4387c081007d532758fcd2f28.1699301753.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When using simple quotas we are not supposed to allocate qgroup records
when adding delayed references. However we allocate them if either mode
of quotas is enabled (the new simple one or the old one), but then we
never free them because running the accounting, which frees the records,
is only run when using the old quotas (at btrfs_qgroup_account_extents()),
resulting in a memory leak of the records allocated when adding delayed
references.

Fix this by allocating the records only if the old quotas mode is enabled.
Also fix btrfs_qgroup_trace_extent_nolock() to return 1 if the old quotas
mode is not enabled - meaning the caller has to free the record.

Fixes: 182940f4f4db ("btrfs: qgroup: add new quota mode for simple quotas")
Reported-by: syzbot+d3ddc6dcc6386dea398b@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/00000000000004769106097f9a34@google.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 4 ++--
 fs/btrfs/qgroup.c      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 9223934d95f4..891ea2fa263c 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1041,7 +1041,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 	}
 
-	if (btrfs_qgroup_enabled(fs_info) && !generic_ref->skip_qgroup) {
+	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgroup) {
 		record = kzalloc(sizeof(*record), GFP_NOFS);
 		if (!record) {
 			kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
@@ -1144,7 +1144,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 	}
 
-	if (btrfs_qgroup_enabled(fs_info) && !generic_ref->skip_qgroup) {
+	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgroup) {
 		record = kzalloc(sizeof(*record), GFP_NOFS);
 		if (!record) {
 			kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index e48eba7e9379..ce446d9d7f23 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1888,7 +1888,7 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
 	u64 bytenr = record->bytenr;
 
 	if (!btrfs_qgroup_full_accounting(fs_info))
-		return 0;
+		return 1;
 
 	lockdep_assert_held(&delayed_refs->lock);
 	trace_btrfs_qgroup_trace_extent(fs_info, record);
-- 
2.40.1

