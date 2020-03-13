Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2379185104
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbgCMVX6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:23:58 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32884 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbgCMVX5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:23:57 -0400
Received: by mail-qt1-f196.google.com with SMTP id d22so8916401qtn.0
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O09kyuVKhx5DnmVq0UhYwwe1Jjhy86WgZU1kNa9gJa4=;
        b=OQyi6/MttZj/zZn9QC3hk7+zy81gHJIxRaS9Nxl+w7JJe+qx9R6Bi90JNMXCG1PZZ9
         polOL9Flyr4nAuf1RVxztYse4M3juvVpV9tZDoiekcgWVhXvmX2l8kCY4ywFF9C+hVAf
         5N6fLyZkeqN3MeU3647pnguHOnyHTCWxXrms+xatGCpb6gbSDvCsi1GmOKaiC9oMpTQ4
         RorjV1U4cf7bR6UbsoPNMTHqtIrRTrjHXZmyEtCKmTpkMXXdUVNna/RpSVxNI1SeQIC6
         LXzim9EbRoTYfcfHb/ohTGsGbBIn5YftpZP8cqFA8aY7Cp8DBt9ZGvUaBWEl909nuL4m
         hvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O09kyuVKhx5DnmVq0UhYwwe1Jjhy86WgZU1kNa9gJa4=;
        b=WNyAW7Ert8TupmlklzTu5TkrdzB2Qd/srzvfJM19HuTbNls09lq9PPujBExdSXEByP
         Dv8sVzECuRZK49xQxk+WIBmRhOMHY/RZ+KQGwBZJ+OAgQbQIgY+JE91NFnWajHRRfJCF
         SmGLQgQEIYsg8d1TMdoCr3MFCRSUjnlxMT03+YTgEBV2NtAfENztQ+FkKqnboSdXU2NU
         9+8WBnHa6Xfe9KZzLCTU5D99dvzTbB0xr7ncG9bfq/ijHEtjTTKERY7cU/6pnZKy89Ij
         tGgz9kx6rgUJkITIsRWSUVdNhzC20CzfTZeaVg+5kboyoA8wU1cwGDXh0F8Hj7vdewZH
         dQRw==
X-Gm-Message-State: ANhLgQ2IOLLcr/pozkeIRYZpVLnvKw6FVpoJ/bQVUqV481KFPj5NXBMk
        /2kBkA61kkBomgbmCAxJvo8B+I2aApf92Q==
X-Google-Smtp-Source: ADFU+vuLpeQIj7bC/dqVm2w5TRWJD8swrTVFIhjZ/l0aeqpsUy6twlGsoiRXkL1EJD0EC4cwIK4Qhg==
X-Received: by 2002:ac8:72d1:: with SMTP id o17mr11246648qtp.347.1584134635431;
        Fri, 13 Mar 2020 14:23:55 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q7sm797812qti.58.2020.03.13.14.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:23:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/13] btrfs: throttle snapshot delete on delayed refs
Date:   Fri, 13 Mar 2020 17:23:30 -0400
Message-Id: <20200313212330.149024-14-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313212330.149024-1-josef@toxicpanda.com>
References: <20200313212330.149024-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

One of the largest generators of delayed refs is snapshot delete.  This
is because we'll walk down to a shared node/leaf and drop all of the
references to the lower layer in that node/leaf.  With our default
nodesize of 16kib this can be hundreds of delayed refs, which can easily
put us over our threshold for running delayed refs.

Instead check and see if we need to throttle ourselves, and if we do
break out with -EAGAIN.  If this happens we do not want to do the
walk_up_tree because we need to keep processing the node we're on.

We also have to get rid of our BUG_ON(drop_level == 0) everywhere,
because we can actually stop at the 0 level.  Since we already have the
ability to restart snapshot deletions from an arbitrary key this works
out fine.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e490ce994d1d..718c99e5674f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4662,6 +4662,7 @@ struct walk_control {
 	int reada_slot;
 	int reada_count;
 	int restarted;
+	int drop_subtree;
 };
 
 #define DROP_REFERENCE	1
@@ -4766,6 +4767,21 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 	u64 flag = BTRFS_BLOCK_FLAG_FULL_BACKREF;
 	int ret;
 
+	/*
+	 * We only want to break if we aren't yet at the end of our leaf/node.
+	 * The reason for this is if we're at DROP_REFERENCE we'll grab the
+	 * current slot's key for the drop_progress.  If we're at the end this
+	 * will obviously go wrong.  We are also not going to generate many more
+	 * delayed refs at this point, so allowing us to continue will not hurt
+	 * us.
+	 */
+	if (!wc->drop_subtree &&
+	    (path->slots[level] < btrfs_header_nritems(path->nodes[level])) &&
+	    btrfs_should_throttle_delayed_refs(fs_info,
+					       &trans->transaction->delayed_refs,
+					       true))
+		return -EAGAIN;
+
 	if (wc->stage == UPDATE_BACKREF &&
 	    btrfs_header_owner(eb) != root->root_key.objectid)
 		return 1;
@@ -5198,6 +5214,8 @@ static noinline int walk_down_tree(struct btrfs_trans_handle *trans,
 		ret = walk_down_proc(trans, root, path, wc, lookup_info);
 		if (ret > 0)
 			break;
+		if (ret < 0)
+			return ret;
 
 		if (level == 0)
 			break;
@@ -5332,7 +5350,6 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
 		       sizeof(wc->update_progress));
 
 		level = root_item->drop_level;
-		BUG_ON(level == 0);
 		path->lowest_level = level;
 		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 		path->lowest_level = 0;
@@ -5381,19 +5398,23 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
 	wc->update_ref = update_ref;
 	wc->keep_locks = 0;
 	wc->reada_count = BTRFS_NODEPTRS_PER_BLOCK(fs_info);
+	wc->drop_subtree = 0;
 
 	while (1) {
 
 		ret = walk_down_tree(trans, root, path, wc);
-		if (ret < 0) {
-			err = ret;
-			break;
-		}
-
-		ret = walk_up_tree(trans, root, path, wc, BTRFS_MAX_LEVEL);
-		if (ret < 0) {
+		if (ret < 0 && ret != -EAGAIN) {
 			err = ret;
 			break;
+		} else if (ret != -EAGAIN) {
+			ret = walk_up_tree(trans, root, path, wc,
+					   BTRFS_MAX_LEVEL);
+			if (ret < 0) {
+				err = ret;
+				break;
+			}
+		} else {
+			ret = 0;
 		}
 
 		if (ret > 0) {
@@ -5411,7 +5432,6 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
 				      &wc->drop_progress);
 		root_item->drop_level = wc->drop_level;
 
-		BUG_ON(wc->level == 0);
 		if (btrfs_should_end_transaction(trans) ||
 		    (!for_reloc && btrfs_need_cleaner_sleep(fs_info))) {
 			ret = btrfs_update_root(trans, tree_root,
@@ -5544,6 +5564,7 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 	wc->stage = DROP_REFERENCE;
 	wc->update_ref = 0;
 	wc->keep_locks = 1;
+	wc->drop_subtree = 1;
 	wc->reada_count = BTRFS_NODEPTRS_PER_BLOCK(fs_info);
 
 	while (1) {
-- 
2.24.1

