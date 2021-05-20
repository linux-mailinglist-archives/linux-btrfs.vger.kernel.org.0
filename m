Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D7138B228
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 16:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhETOr2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 10:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhETOr1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 10:47:27 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E8DC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 20 May 2021 07:46:04 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id i19so6410187qtw.9
        for <linux-btrfs@vger.kernel.org>; Thu, 20 May 2021 07:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o0EaI8sL6uXG1wfqSQ8Ewbzco9uppl1gTg36C+diy74=;
        b=MuuGTNoVzEimF/rmoFnjA34DQNGx2wUGty11xd/z9mVe+Yb2TnVwZrp+4fTcFYSlhw
         QxE/ex+mNy1NGFzBj9Vs4OZ4Z5sSBiLMw4/X0EaMBuKKtJnaC1I0xUzUORZrwxKyflm3
         /ecbGg4XyTMafPsmpXE5OdzLdUMniJbnJ6RWm+y4+0kiSs0SyO++D1UNw0dEiPPduJfG
         quM+yQnhLWT3sCNy7wqyTuEgPMPizZhj3FiM7O76Z/86/AjJvbbKgA5hRnsoYbUN4be4
         D+vzv0+Ze+B/XYtemNKHKlmIvo6ZfkXo4jpQdOT5W71nMhOG7Jo12prQbaIRmEQ/A7Qo
         a76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o0EaI8sL6uXG1wfqSQ8Ewbzco9uppl1gTg36C+diy74=;
        b=s/i+QeGNy3rsqlNrGTu6IddM7dGX14DQSnqh0LNP8SandslL830dxnT9bKuuB9NCAW
         OHRGDxr48DhNhPdw6NfPaDt45lXwB2GnN+07tYRESKcOVcrGUYYwxhlHJKirVtN8dGgr
         0i23sOFS+NFCwvXv9yJONMw7Rs0xwXjGnwdHx6DYeJQ5dC0w0ByQ4DMFz07yw5JrBUEo
         JbGeUJ4siigIUnpiST2qA7fe1H9PzRS8TAeh8PCCuP6Xj3yqBwEwng9lsK+qloeiYnsP
         HcEGN7iNxBSkADfIZVLHdiBM77PZdJFTFIL2hJiTpUaCnrQaTALhYHb/YZdPTwLmaNwi
         vyhA==
X-Gm-Message-State: AOAM532GJyYg/mYFY3OvM2eKtYmjnLVOCu/+mepkQl+G7EFmuNBuRSNo
        JShpKPtFyadMHByP4aiMrG27L4iYXoO/wQ==
X-Google-Smtp-Source: ABdhPJwm3L2NNHZdg4SBSlGT8xrWCgliFT8czV5d+u29A30Vtx5pOpCLjwsLH+BDSGXUkRC5MoYcuQ==
X-Received: by 2002:aed:3169:: with SMTP id 96mr5567404qtg.164.1621521962922;
        Thu, 20 May 2021 07:46:02 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t6sm2168369qkh.117.2021.05.20.07.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 07:46:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2] btrfs: change handle_fs_error in recover_log_trees to aborts
Date:   Thu, 20 May 2021 10:46:01 -0400
Message-Id: <0bc5200e1d20ddcad6d5a858cf00272197b3df67.1621521913.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

During inspection of the return path for replay I noticed that we don't
actually abort the transaction if we get a failure during replay.  This
isn't a problem necessarily, as we properly return the error and will
fail to mount.  However we still leave this dangling transaction that
could conceivably be committed without thinking there was an error.
We were using btrfs_handle_fs_error() here, but that pre-dates the
transaction abort code.  Simply replace the btrfs_handle_fs_error()
calls with transaction aborts, so we still know where exactly things
went wrong, and add a few in some other un-handled error cases.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- instead of abort'ing at the end, convert the handle_fs_error's to aborts so we
  keep the information about where the problem occurred.

 fs/btrfs/tree-log.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 4dc74949040d..db8aa0950745 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6231,8 +6231,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		ret = btrfs_search_slot(NULL, log_root_tree, &key, path, 0, 0);
 
 		if (ret < 0) {
-			btrfs_handle_fs_error(fs_info, ret,
-				    "Couldn't find tree log root.");
+			btrfs_abort_transaction(trans, ret);
 			goto error;
 		}
 		if (ret > 0) {
@@ -6249,8 +6248,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		log = btrfs_read_tree_root(log_root_tree, &found_key);
 		if (IS_ERR(log)) {
 			ret = PTR_ERR(log);
-			btrfs_handle_fs_error(fs_info, ret,
-				    "Couldn't read tree log root.");
+			btrfs_abort_transaction(trans, ret);
 			goto error;
 		}
 
@@ -6278,8 +6276,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 
 			if (!ret)
 				goto next;
-			btrfs_handle_fs_error(fs_info, ret,
-				"Couldn't read target root for tree log recovery.");
+			btrfs_abort_transaction(trans, ret);
 			goto error;
 		}
 
@@ -6287,14 +6284,15 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		ret = btrfs_record_root_in_trans(trans, wc.replay_dest);
 		if (ret)
 			/* The loop needs to continue due to the root refs */
-			btrfs_handle_fs_error(fs_info, ret,
-				"failed to record the log root in transaction");
+			btrfs_abort_transaction(trans, ret);
 		else
 			ret = walk_log_tree(trans, log, &wc);
 
 		if (!ret && wc.stage == LOG_WALK_REPLAY_ALL) {
 			ret = fixup_inode_link_counts(trans, wc.replay_dest,
 						      path);
+			if (ret)
+				btrfs_abort_transaction(trans, ret);
 		}
 
 		if (!ret && wc.stage == LOG_WALK_REPLAY_ALL) {
@@ -6311,6 +6309,8 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			 * could only happen during mount.
 			 */
 			ret = btrfs_init_root_free_objectid(root);
+			if (ret)
+				btrfs_abort_transaction(trans, ret);
 		}
 
 		wc.replay_dest->log_root = NULL;
-- 
2.26.3

