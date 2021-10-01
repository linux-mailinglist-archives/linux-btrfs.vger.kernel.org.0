Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0869E41EDDB
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Oct 2021 14:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhJAMyW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Oct 2021 08:54:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231424AbhJAMyW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Oct 2021 08:54:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA9D861A8F
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Oct 2021 12:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633092758;
        bh=RQmbvW61K+AtjvJ2v0xERFcVK7K/KSRXgmyGfls2lfA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XtwiC+ijLhLo3xcHcS8yS4rS9m+RHYL4fNEc7hQNOozab9uq3VQppd1+g5Yg6lTYw
         DLJxVvs6roRmHst5Hj7wTxhAh5cg9jhs94qqzSe0s41dicyl7uj4s8ftrnz8TAZKSv
         yyNGtC07aLd5DL29zd9JJuUOsKjlQHM79QcnFt4aGBnXE2TEH7quW0xXjYWDql7mRm
         fC5e07CgtUdOzIq1+2XajrSfyQUxsWdKo9WeNW6xolWA1xQheXCWhKdNOR005l/nCi
         rYKUcOgS4L0UCRUweqvoW/uTDQ9WvrOoA14Zo05S3qspf+bT2X81lSQZ2t+i9vmfcA
         n0fRJk6urmtzw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: deal with errors when adding inode reference during log replay
Date:   Fri,  1 Oct 2021 13:52:32 +0100
Message-Id: <a51086e7a99ea7601a91842bcdac28a7be67e1a9.1633082623.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633082623.git.fdmanana@suse.com>
References: <cover.1633082623.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At __inode_add_ref(), we treating any error returned from
btrfs_lookup_dir_item() or from btrfs_lookup_dir_index_item() as meaning
that there is no existing directory entry in the fs/subvolume tree.
This is not correct since we can get errors such as, for example, -EIO
when reading extent buffers while searching the fs/subvolume's btree.

So fix that and return the error to the caller when it is not -ENOENT.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 61bcd09feedc..0091ec39f57c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1218,7 +1218,10 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 	/* look for a conflicting sequence number */
 	di = btrfs_lookup_dir_index_item(trans, root, path, btrfs_ino(dir),
 					 ref_index, name, namelen, 0);
-	if (di && !IS_ERR(di)) {
+	if (IS_ERR(di)) {
+		if (PTR_ERR(di) != -ENOENT)
+			return PTR_ERR(di);
+	} else if (di) {
 		ret = drop_one_dir_item(trans, root, path, dir, di);
 		if (ret)
 			return ret;
@@ -1228,7 +1231,9 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 	/* look for a conflicting name */
 	di = btrfs_lookup_dir_item(trans, root, path, btrfs_ino(dir),
 				   name, namelen, 0);
-	if (di && !IS_ERR(di)) {
+	if (IS_ERR(di)) {
+		return PTR_ERR(di);
+	} else if (di) {
 		ret = drop_one_dir_item(trans, root, path, dir, di);
 		if (ret)
 			return ret;
-- 
2.33.0

