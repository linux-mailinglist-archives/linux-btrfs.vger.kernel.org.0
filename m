Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D284CDBD8
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 19:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbiCDSLx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Mar 2022 13:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiCDSLw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Mar 2022 13:11:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817A71C666E
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Mar 2022 10:11:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A00EB82B5D
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Mar 2022 18:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F8FC340EE
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Mar 2022 18:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646417461;
        bh=iuEfCmPmGJ47Ew1KTwp1ug1Fk/gu+8927OlpIC8v3VM=;
        h=From:To:Subject:Date:From;
        b=itUC1zLYS6RNmoCBLl5VuC2YqLrM1SvYJ4sQLa8ut+08MK9W0JpVhOL+0CmPz9qyX
         PpB1V14nTdTtpUiigFAlqi1MB2Qp2CoR7lJ7Y3AeHvL6+qY3RPwMgAmh9TA6vXE/Wp
         Pdqlkrxr+1HCGfnpMNUAh0kAenaNrSr3RsIMTx7FLnRq7in1SLyacePOplGyFUWzB6
         wfaoSjCrHUV4Tfw66bWkxLfwHQVVsXC/MDAxsL2eUc63lwlELXxL+tpTG1uOK+6LeU
         rtqBP8EYacLmysSuUXFR0vRzwMei/Zgz8jju/gnN1EFj4magLnB448kAOCt0V/KRu3
         JhZgDn/n7PXSg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: avoid full commit due to race when logging dentry deletion
Date:   Fri,  4 Mar 2022 18:10:57 +0000
Message-Id: <78d0dffe5f48910e126886559d0c69194b32eab9.1646416779.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During a rename, when logging that a directory entry was deleted, we may
race with another task that is logging the directory. Even though the
directory is locked at the VFS level, its logging can be triggered when
other task is logging some other inode that had, or still has, a dentry
in the directory (because its last_unlink_trans matches the current
transaction).

The chances are slim, and if the race happens, recording the deletion
through insert_dir_log_key() can fail with -EEXIST and result in marking
the log for a full transaction commit, which will make the next fsync
fallback to a transaction commit. The opposite can also happen, we log the
key before the other task attempts to insert the same key, in which case
it fails with -EEXIST and fallsback to a transaction commit or trigger an
assertion at process_dir_items_leaf() due to the unexpected -EEXIST error.

So make that code that records a dentry deletion to be inside a critical
section delimited by the directory's log mutex.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

David, this can be optionally squashed into the following patch:

   "btrfs: avoid logging all directory changes during renames"

(misc-next only)

 fs/btrfs/tree-log.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 4f61b38bb186..571dae8ad65e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7015,6 +7015,17 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 			goto out;
 		}
 
+		/*
+		 * Other concurrent task might be logging the old directory,
+		 * as it can be triggered when logging other inode that had or
+		 * still has a dentry in the old directory. So take the old
+		 * directory's log_mutex to prevent getting an -EEXIST when
+		 * logging a key to record the deletion, or having that other
+		 * task logging the old directory get an -EEXIST if it attempts
+		 * to log the same key after we just did it. In both cases that
+		 * would result in falling back to a transaction commit.
+		 */
+		mutex_lock(&old_dir->log_mutex);
 		ret = del_logged_dentry(trans, log, path, btrfs_ino(old_dir),
 					old_dentry->d_name.name,
 					old_dentry->d_name.len, old_dir_index);
@@ -7028,6 +7039,7 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 						 btrfs_ino(old_dir),
 						 old_dir_index, old_dir_index);
 		}
+		mutex_unlock(&old_dir->log_mutex);
 
 		btrfs_free_path(path);
 		if (ret < 0)
-- 
2.33.0

