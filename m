Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA0847639B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbhLOUnz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbhLOUny (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:43:54 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF879C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:43:54 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id n15so23261579qta.0
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2lQJcwueKcvb6OXnd0CqYNH4rfJrVvQ3zmNLJ9ouJew=;
        b=c83U5VnbNFQgefwnB06+AC+HrItilY+K2Jp3aAQ+DEvB3NWpoDpzgX7C9ka650Ws9N
         UZLi8ptOkV8pjtPenZIkyRVfoKvKPzclZNloGW37xBXfPPRiMKaTgXm/dS4TBWE2+sSP
         m6aVzyPU1SBbxX/Hs0qrl/v2j1fmk3j/fzWOnbtH1jlaNAY0KZ5AyfcBZtc0/Vk+Xp5P
         XCHKKGjVAWd1EAGlxD+epiPcBgAXbxtapDxmKUk9c3TMj/lXdcvgAyg2eqc0y7ZwirGc
         AnDXb6ed5W0Hfe8EgCSLUf9af7yrQJFjkDLZytPqNgYxrblHJD4qpAZt5pYU+2rjkkRH
         iunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2lQJcwueKcvb6OXnd0CqYNH4rfJrVvQ3zmNLJ9ouJew=;
        b=VisSNE49hpX09Eq1vkfrFlGixgZbgGT7OwsFyaDGW3q+x5T2zL/XnmuycDoh9/HZ9Z
         Gf13fJR+mww5TaaDX3AUaQo+bmCNTuga6k5fJ9G7o5FLedWje1ELJQ9ZPPgM/NAe66iJ
         6tS3fUr/7IqlqDb+Oy1N6XApMv0CIfpI8mPM0Hi3EP+NsOHnaO3WsSGy5U2mbtWbeBpU
         B3Ft2YOcWskDmery9G/IlXCzpVctij4GtHO/2CBg9EfkZyEYSGrxMeVZGwznFIlq4i8g
         ftVQkBRSYgUE4d1FD5iAjZVsBPl1lstH7YT8z4Vrui73Lsou9I592winMetWUiHcBP4E
         tj3A==
X-Gm-Message-State: AOAM532IlZT12Kdqx4fux1658YQIgIkwakjL7ko+fuoYglaXWnST4W1R
        +v+l4uLipxwyzfZ5Afz6RFEoauzNcHRY/A==
X-Google-Smtp-Source: ABdhPJzLsUAMwbaDNtQlb+SXo5vFngU9AZ6OH5T/jGKI4l0rSFfiBfKP5l6Z03uwC2zjMbHrqe3qBQ==
X-Received: by 2002:a05:622a:f:: with SMTP id x15mr13892035qtw.481.1639601033602;
        Wed, 15 Dec 2021 12:43:53 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 143sm1674523qkg.87.2021.12.15.12.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:43:53 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/9] btrfs: don't do backref modification for metadata for extent tree v2
Date:   Wed, 15 Dec 2021 15:43:41 -0500
Message-Id: <93e8cecd8b11b8eeee846d7a07ebd198c2730726.1639600854.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639600854.git.josef@toxicpanda.com>
References: <cover.1639600854.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For extent tree v2 we will no longer track references for metadata in
the extent tree.  Make changes at the alloc and free sides so the proper
accounting is done but skip the extent tree modification parts.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0c1988a7f845..369489394660 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2957,7 +2957,6 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_extent_item *ei;
 	struct btrfs_extent_inline_ref *iref;
 	int ret;
-	int is_data;
 	int extent_slot = 0;
 	int found_extent = 0;
 	int num_to_del = 1;
@@ -2966,6 +2965,11 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	u64 bytenr = node->bytenr;
 	u64 num_bytes = node->num_bytes;
 	bool skinny_metadata = btrfs_fs_incompat(info, SKINNY_METADATA);
+	bool is_data = owner_objectid >= BTRFS_FIRST_FREE_OBJECTID;
+
+	if (btrfs_fs_incompat(info, EXTENT_TREE_V2) && !is_data)
+		return do_free_extent_accounting(trans, bytenr, num_bytes,
+						 is_data);
 
 	extent_root = btrfs_extent_root(info, bytenr);
 	ASSERT(extent_root);
@@ -2974,8 +2978,6 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	is_data = owner_objectid >= BTRFS_FIRST_FREE_OBJECTID;
-
 	if (!is_data && refs_to_drop != 1) {
 		btrfs_crit(info,
 "invalid refs_to_drop, dropping more than 1 refs for tree block %llu refs_to_drop %u",
@@ -4706,6 +4708,9 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	u64 flags = extent_op->flags_to_set;
 	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		goto out;
+
 	ref = btrfs_delayed_node_to_tree_ref(node);
 
 	extent_key.objectid = node->bytenr;
@@ -4759,7 +4764,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_free_path(path);
-
+out:
 	return alloc_reserved_extent(trans, node->bytenr, fs_info->nodesize);
 }
 
-- 
2.26.3

