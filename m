Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58C15145458
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 13:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgAVMX5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 07:23:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbgAVMX5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 07:23:57 -0500
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C6E524655
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2020 12:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579695836;
        bh=TauJFZlcokcHHlZHG5bXXEy13BZeQLSRUH2rIVzqVHM=;
        h=From:To:Subject:Date:From;
        b=ikRTrahvtgBGzZ7BMSYJlM0jqt71Tnp4wkpYaa2YVrFjAGmBWGB5UgCQ/SVVZD/DG
         Mr/H8UM2ho9NkbRDVu8K5tgjmsyqpz8ykbsybFLaYbuyZTo30mAq6iyBgxSO68Dxah
         2v81KBU06M+Z5+FV58XeHj6wEUafV4p9yutufTys=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] Btrfs: don't iterate mod seq list when putting a tree mod seq
Date:   Wed, 22 Jan 2020 12:23:54 +0000
Message-Id: <20200122122354.30132-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Each new element added to the mod seq list is always appended to the list,
and each one gets a sequence number coming from a counter which gets
incremented everytime a new element is added to the list (or a new node
is added to the tree mod log rbtree). Therefore the element with the
lowest sequence number is always the first element in the list.

So just remove the list iteration at btrfs_put_tree_mod_seq() that
computes the minimum sequence number in the list and replace it with
a check for the first element's sequence number.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index f2ec1a9bae28..968faaec0e39 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -341,7 +341,6 @@ void btrfs_put_tree_mod_seq(struct btrfs_fs_info *fs_info,
 	struct rb_root *tm_root;
 	struct rb_node *node;
 	struct rb_node *next;
-	struct seq_list *cur_elem;
 	struct tree_mod_elem *tm;
 	u64 min_seq = (u64)-1;
 	u64 seq_putting = elem->seq;
@@ -353,18 +352,20 @@ void btrfs_put_tree_mod_seq(struct btrfs_fs_info *fs_info,
 	list_del(&elem->list);
 	elem->seq = 0;
 
-	list_for_each_entry(cur_elem, &fs_info->tree_mod_seq_list, list) {
-		if (cur_elem->seq < min_seq) {
-			if (seq_putting > cur_elem->seq) {
-				/*
-				 * blocker with lower sequence number exists, we
-				 * cannot remove anything from the log
-				 */
-				write_unlock(&fs_info->tree_mod_log_lock);
-				return;
-			}
-			min_seq = cur_elem->seq;
+	if (!list_empty(&fs_info->tree_mod_seq_list)) {
+		struct seq_list *first;
+
+		first = list_first_entry(&fs_info->tree_mod_seq_list,
+					 struct seq_list, list);
+		if (seq_putting > first->seq) {
+			/*
+			 * Blocker with lower sequence number exists, we
+			 * cannot remove anything from the log.
+			 */
+			write_unlock(&fs_info->tree_mod_log_lock);
+			return;
 		}
+		min_seq = first->seq;
 	}
 
 	/*
-- 
2.11.0

