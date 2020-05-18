Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A341D767E
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 May 2020 13:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgERLPV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 May 2020 07:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgERLPV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 May 2020 07:15:21 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 718B9207F5
        for <linux-btrfs@vger.kernel.org>; Mon, 18 May 2020 11:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589800520;
        bh=yGWutGgACSorq2W/OXenDP8sAK8+8S5WoQNVhYKNv2E=;
        h=From:To:Subject:Date:From;
        b=fEiuwT3aPBagX9eVrbwfr7ului3IbxRhHNH0XhWwjSULDd/+VfZBovLTu30Y97+02
         GXSsuKg1IvhhFftHqzEOO3jVprEA3XWdXKAixYMwpzCnNwcfrFpZTUYcc8XvTNNpUl
         DFB5I53ISI8il8d07wCa5uTI3Zd1JeSZZ+bIzSdU=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] Btrfs: remove useless 'fail_unlock' label from btrfs_csum_file_blocks()
Date:   Mon, 18 May 2020 12:15:18 +0100
Message-Id: <20200518111518.18334-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The label 'fail_unlock' is pointless, all it does is to jump to the label
'out', so just remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file-item.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 4f563469c97a..80a4651b72f5 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -869,7 +869,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	}
 	ret = PTR_ERR(item);
 	if (ret != -EFBIG && ret != -ENOENT)
-		goto fail_unlock;
+		goto out;
 
 	if (ret == -EFBIG) {
 		u32 item_size;
@@ -927,7 +927,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	ret = btrfs_search_slot(trans, root, &file_key, path,
 				csum_size, 1);
 	if (ret < 0)
-		goto fail_unlock;
+		goto out;
 
 	if (ret > 0) {
 		if (path->slots[0] == 0)
@@ -994,9 +994,9 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 				      ins_size);
 	path->leave_spinning = 0;
 	if (ret < 0)
-		goto fail_unlock;
+		goto out;
 	if (WARN_ON(ret != 0))
-		goto fail_unlock;
+		goto out;
 	leaf = path->nodes[0];
 csum:
 	item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_csum_item);
@@ -1026,9 +1026,6 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 out:
 	btrfs_free_path(path);
 	return ret;
-
-fail_unlock:
-	goto out;
 }
 
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
-- 
2.11.0

