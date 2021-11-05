Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469504469AA
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhKEUbb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhKEUb3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:31:29 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31D9C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:28:49 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h14so8298765qtb.3
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=i4E1TlaM/3X+HVnR+wg1ccNB6CtWbin4PtRvMdf4eEw=;
        b=6COnBnl5OAyQpKQD2R3ZvtzSFUysYGCT0Zip2BOrd36SmWQ3yjPxkpfsg6jNCzlK20
         SmGsJMxeHXzcg9zGMLsHTurRb+O4kvizvhkORwfxOnJHPXgyuZDmAUvK02RaJs3623kA
         /lQR11NC3fqtoNxNb4JEz4ZG4MPhL+2DSjZInb00eyrItj1kmEYc1RNawbGLPVZ3Bcbc
         3Z96Pan3WFBz5CnDUGqmnh2t9rBYfCHt0q00wMwSWSR5ExymdwtaqyndGekWz6Gk/xAa
         Hqi4AkheDtZvhCuhVN1N1TAVSFktv3ga87HHx5rvGV8HeC/n2diJOZyMsWnJL8oWyHGc
         yHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i4E1TlaM/3X+HVnR+wg1ccNB6CtWbin4PtRvMdf4eEw=;
        b=vGFnoSve3Hzm+FkWiTCLf8BM7cIyWeDPCLI4uiYmhrXxWDsTnoXF8UKlEkGQgJIe/5
         9EYxUK3AJdro/DfVfGGWZHZTl31ErkXiAWuRavz49HHpejG2rSYdOiL6iu9iIL5HmJ8x
         Dvm8mrbOu2wzObU/h/s+hfM8x/kyCsFfuza/PshSQoaoyqzJnC0PM3blSqlxfgq6k6qa
         oZXxcWBVlELyZ9rgk9ADowOVP//ucJfVuoYqQXi/Cd87utcOI1pduFzTRTWK0TrqT2KD
         zjlKBbD8CCubtIOPzG5JdA3TA/b2nNPpaauSriuENG15CWB7oInxZeu6r4/tCGupyf8c
         B6ng==
X-Gm-Message-State: AOAM533Dx0niS5TSO2zbhKRPGY91XMev/PToYBQRvGVS0s+GIkh3L+OJ
        qG6vmUWVliaBkR4jC9P+8g9eKTSab8pJ/w==
X-Google-Smtp-Source: ABdhPJzbQFPRVksaUKhkx18vxZCvkkjMTHNrSWdH1+4M27wmY1e3CsPg89boD8TfCD9f/TbjlIn7MA==
X-Received: by 2002:ac8:5904:: with SMTP id 4mr4845491qty.408.1636144128816;
        Fri, 05 Nov 2021 13:28:48 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j24sm5869528qkg.133.2021.11.05.13.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:28:48 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/20] btrfs-progs: simplify btrfs_make_block_group
Date:   Fri,  5 Nov 2021 16:28:26 -0400
Message-Id: <c34d973b32d46595546ac9f7b80984a0fb21f74c.1636143924.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636143924.git.josef@toxicpanda.com>
References: <cover.1636143924.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is doing the same work as insert_block_group_item, rework it to
call the helper instead.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent-tree.c | 43 ++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 8e0614e0..a918e5aa 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -2791,33 +2791,6 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 	return cache;
 }
 
-int btrfs_make_block_group(struct btrfs_trans_handle *trans,
-			   struct btrfs_fs_info *fs_info, u64 bytes_used,
-			   u64 type, u64 chunk_offset, u64 size)
-{
-	int ret;
-	struct btrfs_root *extent_root = fs_info->extent_root;
-	struct btrfs_block_group *cache;
-	struct btrfs_block_group_item bgi;
-	struct btrfs_key key;
-
-	cache = btrfs_add_block_group(fs_info, bytes_used, type, chunk_offset,
-				      size);
-	btrfs_set_stack_block_group_used(&bgi, cache->used);
-	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
-	btrfs_set_stack_block_group_chunk_objectid(&bgi,
-			BTRFS_FIRST_CHUNK_TREE_OBJECTID);
-	key.objectid = cache->start;
-	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
-	key.offset = cache->length;
-	ret = btrfs_insert_item(trans, extent_root, &key, &bgi, sizeof(bgi));
-	BUG_ON(ret);
-
-	add_block_group_free_space(trans, cache);
-
-	return 0;
-}
-
 static int insert_block_group_item(struct btrfs_trans_handle *trans,
 				   struct btrfs_block_group *block_group)
 {
@@ -2838,6 +2811,22 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	return btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
 }
 
+int btrfs_make_block_group(struct btrfs_trans_handle *trans,
+			   struct btrfs_fs_info *fs_info, u64 bytes_used,
+			   u64 type, u64 chunk_offset, u64 size)
+{
+	struct btrfs_block_group *cache;
+	int ret;
+
+	cache = btrfs_add_block_group(fs_info, bytes_used, type, chunk_offset,
+				      size);
+	ret = insert_block_group_item(trans, cache);
+	if (ret)
+		return ret;
+	add_block_group_free_space(trans, cache);
+	return 0;
+}
+
 /*
  * This is for converter use only.
  *
-- 
2.26.3

