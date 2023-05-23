Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E792B70D7BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 10:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbjEWIly (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 04:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbjEWIlX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 04:41:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE4DE49
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 01:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vUSIzPyibNrbKOA/j+6+lrk3QbtfAB5OHum8ukhPqWA=; b=dDgxwNzNW6xrZ7QnHY/IU5o40b
        2PNsWdU1E56CDsw+nYD0f86bS7o5OLg3lMJGKWIPlgmS2O2OzwzTihRh+wVtPHlK0bXxBCh8FL8TF
        B50a6C8w3v28IP9cnnykbbikXHbSEk8RkW2eXxtA3tN7Hh+RUtjzMVoAisQeuvoCX1FWpIJQPVZIP
        ZREfZJK5RDxbi7pVbuvR+m3YpnKootDjd7Tc2ES4eXsmTTXWgUrO1hX+Uu2ZO/Na+kkXPcH3POu60
        h3DhUcWTDkPgAGilcMdfcUIliAKYzt4rfKO8C3/r0sqqo1pQNgIXsVLtSdZn4qtWi27IGKbsmNJvY
        6QsuhtQQ==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1NZ8-009TZ1-2s;
        Tue, 23 May 2023 08:40:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: fix the btrfs_get_global_root return value
Date:   Tue, 23 May 2023 10:40:18 +0200
Message-Id: <20230523084020.336697-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_grab_root returns either the root or NULL, and the callers of
btrfs_get_global_root expect it to return the same.  But all the more
recently added roots instead return an ERR_PTR, so fix this.

Fixes: bcef60f24903 ("Btrfs: quota tree support and startup")
Fixes: f7a81ea4cc6b ("Btrfs: create UUID tree if required")
Fixes: 70f6d82ec73c ("Btrfs: add free space tree mount option")
Fixes: 14033b08a029 ("btrfs: don't save block group root into super block")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index dc2ad0bf88f84c..5dc5d733ecfa4a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1358,19 +1358,13 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
 	if (objectid == BTRFS_CSUM_TREE_OBJECTID)
 		return btrfs_grab_root(btrfs_global_root(fs_info, &key));
 	if (objectid == BTRFS_QUOTA_TREE_OBJECTID)
-		return btrfs_grab_root(fs_info->quota_root) ?
-			fs_info->quota_root : ERR_PTR(-ENOENT);
+		return btrfs_grab_root(fs_info->quota_root);
 	if (objectid == BTRFS_UUID_TREE_OBJECTID)
-		return btrfs_grab_root(fs_info->uuid_root) ?
-			fs_info->uuid_root : ERR_PTR(-ENOENT);
+		return btrfs_grab_root(fs_info->uuid_root);
 	if (objectid == BTRFS_BLOCK_GROUP_TREE_OBJECTID)
-		return btrfs_grab_root(fs_info->block_group_root) ?
-			fs_info->block_group_root : ERR_PTR(-ENOENT);
-	if (objectid == BTRFS_FREE_SPACE_TREE_OBJECTID) {
-		struct btrfs_root *root = btrfs_global_root(fs_info, &key);
-
-		return btrfs_grab_root(root) ? root : ERR_PTR(-ENOENT);
-	}
+		return btrfs_grab_root(fs_info->block_group_root);
+	if (objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
+		return btrfs_grab_root(btrfs_global_root(fs_info, &key));
 	return NULL;
 }
 
-- 
2.39.2

