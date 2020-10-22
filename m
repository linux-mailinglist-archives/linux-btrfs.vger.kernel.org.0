Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67BE2961C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Oct 2020 17:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368694AbgJVPkx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Oct 2020 11:40:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:55026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368692AbgJVPkw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Oct 2020 11:40:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603381251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jedhEnvGwr7hgNi6AOGCXqA9x0YVkoxOqfGf3pJNtQE=;
        b=YeJKceVpP3x8ny5QuJAMZRqiEtZKvYKargwsZj8MrrkjvS/dLk/waREOjeSu+DyOhw1ciq
        q53b4O8iNFD8sDjJpICSf738ubMERb2oHydgUPreHOBwW569GINez50jfznmw81txfkBcy
        HZGyJy/WydvnDev3MUc9TxHgaOi6gaM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 88DB8BA25;
        Thu, 22 Oct 2020 15:40:51 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Open code insert_orphan_item
Date:   Thu, 22 Oct 2020 18:40:46 +0300
Message-Id: <20201022154046.1654593-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just open code it in its sole caller and remove a level of indirection.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/tree-log.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 3ec3e06783a0..71bd0f08543b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1565,18 +1565,6 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static int insert_orphan_item(struct btrfs_trans_handle *trans,
-			      struct btrfs_root *root, u64 ino)
-{
-	int ret;
-
-	ret = btrfs_insert_orphan_item(trans, root, ino);
-	if (ret == -EEXIST)
-		ret = 0;
-
-	return ret;
-}
-
 static int count_inode_extrefs(struct btrfs_root *root,
 		struct btrfs_inode *inode, struct btrfs_path *path)
 {
@@ -1728,7 +1716,9 @@ static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
 			if (ret)
 				goto out;
 		}
-		ret = insert_orphan_item(trans, root, ino);
+		ret = btrfs_insert_orphan_item(trans, root, ino);
+		if (ret == -EEXIST)
+			ret = 0;
 	}
 
 out:
-- 
2.25.1

