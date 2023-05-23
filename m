Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC3470D7BE
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 10:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbjEWIlz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 04:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbjEWIlY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 04:41:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEBBE4C
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 01:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=o9KSxMeE48qQapgk8Q6zc11hw6uYlGdJ7DIF4C3Jkxg=; b=BGQCMBrkNYfDwSmOFYeW4yvaDr
        P4zjwWjwRXSLJ97jzQ71GjWcwRdwQ2WqlUBi0/hontATRuMxSIBnuc31hfByECLLItNyxbaMSotek
        5rIjIxKczUk5CePGlILZGb0oEqgG1x1Z9uMaOZgtZAemx4jsRhkbc7DepANx96Qp9chm1Fsg/oWH2
        ZvivXVPeYUe8ZS/0JmZDRXE7OUiJ+pCZ81ZOsQRxGKLRKqcCVKxkih1B8uoF9TMmF/pbUp8JgRCFW
        O+fDwTybfxKnKbvTQZ7b1vktcxowIbz3ufbMBiBxJKsSxCfwUwSQr/PYzxD5e9HulBbcaLKrl53oa
        s3mDocnw==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1NZB-009TZH-1W;
        Tue, 23 May 2023 08:40:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: convert btrfs_get_global_root to use a switch statement
Date:   Tue, 23 May 2023 10:40:19 +0200
Message-Id: <20230523084020.336697-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523084020.336697-1-hch@lst.de>
References: <20230523084020.336697-1-hch@lst.de>
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

Use a switch statement instead of an endless chain of if statements
to make the code a little cleaner.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5dc5d733ecfa4a..1edd6685df5760 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1347,25 +1347,28 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
 		.offset = 0,
 	};
 
-	if (objectid == BTRFS_ROOT_TREE_OBJECTID)
+	switch (objectid) {
+	case BTRFS_ROOT_TREE_OBJECTID:
 		return btrfs_grab_root(fs_info->tree_root);
-	if (objectid == BTRFS_EXTENT_TREE_OBJECTID)
+	case BTRFS_EXTENT_TREE_OBJECTID:
 		return btrfs_grab_root(btrfs_global_root(fs_info, &key));
-	if (objectid == BTRFS_CHUNK_TREE_OBJECTID)
+	case BTRFS_CHUNK_TREE_OBJECTID:
 		return btrfs_grab_root(fs_info->chunk_root);
-	if (objectid == BTRFS_DEV_TREE_OBJECTID)
+	case BTRFS_DEV_TREE_OBJECTID:
 		return btrfs_grab_root(fs_info->dev_root);
-	if (objectid == BTRFS_CSUM_TREE_OBJECTID)
+	case BTRFS_CSUM_TREE_OBJECTID:
 		return btrfs_grab_root(btrfs_global_root(fs_info, &key));
-	if (objectid == BTRFS_QUOTA_TREE_OBJECTID)
+	case BTRFS_QUOTA_TREE_OBJECTID:
 		return btrfs_grab_root(fs_info->quota_root);
-	if (objectid == BTRFS_UUID_TREE_OBJECTID)
+	case BTRFS_UUID_TREE_OBJECTID:
 		return btrfs_grab_root(fs_info->uuid_root);
-	if (objectid == BTRFS_BLOCK_GROUP_TREE_OBJECTID)
+	case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
 		return btrfs_grab_root(fs_info->block_group_root);
-	if (objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
+	case BTRFS_FREE_SPACE_TREE_OBJECTID:
 		return btrfs_grab_root(btrfs_global_root(fs_info, &key));
-	return NULL;
+	default:
+		return NULL;
+	}
 }
 
 int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
-- 
2.39.2

