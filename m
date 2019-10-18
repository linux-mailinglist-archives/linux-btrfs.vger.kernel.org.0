Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57C3BDC1F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2019 11:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392688AbfJRJ6m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 05:58:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:40256 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403858AbfJRJ6l (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 05:58:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 59E11B585;
        Fri, 18 Oct 2019 09:58:40 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 3/4] btrfs: reduce indentation in btrfs_may_alloc_data_chunk
Date:   Fri, 18 Oct 2019 11:58:22 +0200
Message-Id: <20191018095823.15282-4-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191018095823.15282-1-jthumshirn@suse.de>
References: <20191018095823.15282-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_may_alloc_data_chunk() we're checking if the chunk type is of
type BTRFS_BLOCK_GROUP_DATA and if it is we process it.

Instead of checking if the chunk type is a BTRFS_BLOCK_GROUP_DATA chunk we
can negate the check and bail out early if it isn't.

This makes the code a bit more readable.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/volumes.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bba74e3bd9d8..4c630356bb30 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2982,27 +2982,28 @@ static int btrfs_may_alloc_data_chunk(struct btrfs_fs_info *fs_info,
 	chunk_type = cache->flags;
 	btrfs_put_block_group(cache);
 
-	if (chunk_type & BTRFS_BLOCK_GROUP_DATA) {
-		spin_lock(&fs_info->data_sinfo->lock);
-		bytes_used = fs_info->data_sinfo->bytes_used;
-		spin_unlock(&fs_info->data_sinfo->lock);
-
-		if (!bytes_used) {
-			struct btrfs_trans_handle *trans;
-			int ret;
-
-			trans =	btrfs_join_transaction(fs_info->tree_root);
-			if (IS_ERR(trans))
-				return PTR_ERR(trans);
-
-			ret = btrfs_force_chunk_alloc(trans,
-						      BTRFS_BLOCK_GROUP_DATA);
-			btrfs_end_transaction(trans);
-			if (ret < 0)
-				return ret;
-			return 1;
-		}
+	if (!(chunk_type & BTRFS_BLOCK_GROUP_DATA))
+		return 0;
+
+	spin_lock(&fs_info->data_sinfo->lock);
+	bytes_used = fs_info->data_sinfo->bytes_used;
+	spin_unlock(&fs_info->data_sinfo->lock);
+
+	if (!bytes_used) {
+		struct btrfs_trans_handle *trans;
+		int ret;
+
+		trans =	btrfs_join_transaction(fs_info->tree_root);
+		if (IS_ERR(trans))
+			return PTR_ERR(trans);
+
+		ret = btrfs_force_chunk_alloc(trans, BTRFS_BLOCK_GROUP_DATA);
+		btrfs_end_transaction(trans);
+		if (ret < 0)
+			return ret;
+		return 1;
 	}
+
 	return 0;
 }
 
-- 
2.16.4

