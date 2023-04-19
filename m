Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A349D6E83A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjDSVZT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjDSVZB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:25:01 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70ABE170E
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:33 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-74d3c8843fbso230085a.1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939471; x=1684531471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbZbfl1/3ybk58N1Zx+oexqaSHq9AlNN0cAebew9vgM=;
        b=BBhHSNhkMtYPX2RY81cOUnpuVkIPfjHlleBD0poERtjOdRt/aZttFmaJk0NQkSiTbX
         YHSwku+TIbsn0duSIW32XyoQ3eXqAWcz1iJayI7oRBrK2Ei/ZspH72C9pvYiVpaODu2O
         txXpu2c+j9c02sprKEUSc1gmGaSxeQnnAu9TzZKvnBSUXwdGBoBOkb/QiW4cbsw0QSeo
         ll4W4vO+M/SDnftcZOuLSj9uuOV4enNeQo2EblCiu6e5x67WlW5CAajgrF3LjXaECoYU
         z9xFIg6u1t6uYytdd4RfvMbnGoKbn5It8v5mcNuOfz8LPEYl5PrruZJa2IoMihSSjxfB
         407Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939471; x=1684531471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbZbfl1/3ybk58N1Zx+oexqaSHq9AlNN0cAebew9vgM=;
        b=TQ+i7+RhpMb2f5HLijMRtOLjmkQ0DksxuhMPt1z0EJ/3fTYrm/c3wxLo1tO6Fui+5m
         1ZPdDu74coT49WFyW0g4QtY2OYVUz7kGuq6t7z7afUhhwHBN8seAPDOeO8Ls2KnOKnt2
         ROw9FKGS9h/Obh+lDQaRp/wq5JKk6JFGqeiWa7ZNIWcB2YXohqI5ugG81QnghUDSSvm0
         V6eWMyEL59CisdSnyOCsonQTBBWIpg/RnpNzv8yvexkv+Vkm+4Dbf+C0FoD4V59VmaDr
         GOwE/R3UESTVEcK3tV0vuG1KC1TR9W+/Det3UskQqWw9b5sczpP6gJ5bXb8tv/jCCWfl
         K3xw==
X-Gm-Message-State: AAQBX9fX/ZhKOnc5ZqHHAcMPD+jPBEW+K65BusRbvEhN6IDnkNFBsOfA
        2wiPHWk8cDeGMqazd++yirjNi+iJ1nKkQ8QJHuEECg==
X-Google-Smtp-Source: AKy350aG0DXC0XXK2U/ZcFOjuRrsRBYEpRgU/twdTkVnxor2JXPJ76fwgC/PosLGLVx7+eYJWJJPYQ==
X-Received: by 2002:ac8:5c45:0:b0:3ed:ac62:1039 with SMTP id j5-20020ac85c45000000b003edac621039mr37948qtj.8.1681939471457;
        Wed, 19 Apr 2023 14:24:31 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id dv22-20020a05620a1b9600b00746a7945d87sm4887056qkb.52.2023.04.19.14.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:24:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/18] btrfs-progs: add a btrfs_read_extent_buffer helper
Date:   Wed, 19 Apr 2023 17:24:05 -0400
Message-Id: <da6aef1cc75408edd38cb254b9a480cb35f1fea9.1681939316.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939316.git.josef@toxicpanda.com>
References: <cover.1681939316.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This exists in the kernel to do the read on an extent buffer we may have
already looked up and initialized.  Simply create this helper by
extracting out the existing code from read_tree_block and make
read_tree_block call this helper.  This gives us the helper we need to
sync ctree.c into btrfs-progs, and keeps the code the same in
btrfs-progs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/disk-io.c | 72 ++++++++++++++++++++++++-----------------
 kernel-shared/disk-io.h |  2 ++
 2 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 29fe9027..6e810bd1 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -337,39 +337,18 @@ int read_whole_eb(struct btrfs_fs_info *info, struct extent_buffer *eb, int mirr
 	return 0;
 }
 
-struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
-				      u64 owner_root, u64 parent_transid,
-				      int level, struct btrfs_key *first_key)
+int btrfs_read_extent_buffer(struct extent_buffer *eb, u64 parent_transid,
+			     int level, struct btrfs_key *first_key)
 {
+	struct btrfs_fs_info *fs_info = eb->fs_info;
 	int ret;
-	struct extent_buffer *eb;
 	u64 best_transid = 0;
-	u32 sectorsize = fs_info->sectorsize;
 	int mirror_num = 1;
 	int good_mirror = 0;
 	int candidate_mirror = 0;
 	int num_copies;
 	int ignore = 0;
 
-	/*
-	 * Don't even try to create tree block for unaligned tree block
-	 * bytenr.
-	 * Such unaligned tree block will free overlapping extent buffer,
-	 * causing use-after-free bugs for fuzzed images.
-	 */
-	if (bytenr < sectorsize || !IS_ALIGNED(bytenr, sectorsize)) {
-		error("tree block bytenr %llu is not aligned to sectorsize %u",
-		      bytenr, sectorsize);
-		return ERR_PTR(-EIO);
-	}
-
-	eb = btrfs_find_create_tree_block(fs_info, bytenr);
-	if (!eb)
-		return ERR_PTR(-ENOMEM);
-
-	if (btrfs_buffer_uptodate(eb, parent_transid, 0))
-		return eb;
-
 	num_copies = btrfs_num_copies(fs_info, eb->start, eb->len);
 	while (1) {
 		ret = read_whole_eb(fs_info, eb, mirror_num);
@@ -396,7 +375,7 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 				ret = btrfs_check_leaf(eb);
 			if (!ret || candidate_mirror == mirror_num) {
 				btrfs_set_buffer_uptodate(eb);
-				return eb;
+				return 0;
 			}
 			if (candidate_mirror <= 0)
 				candidate_mirror = mirror_num;
@@ -439,12 +418,47 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 			continue;
 		}
 	}
+	return ret;
+}
+
+struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
+				      u64 owner_root, u64 parent_transid,
+				      int level, struct btrfs_key *first_key)
+{
+	int ret;
+	struct extent_buffer *eb;
+	u32 sectorsize = fs_info->sectorsize;
+
 	/*
-	 * We failed to read this tree block, it be should deleted right now
-	 * to avoid stale cache populate the cache.
+	 * Don't even try to create tree block for unaligned tree block
+	 * bytenr.
+	 * Such unaligned tree block will free overlapping extent buffer,
+	 * causing use-after-free bugs for fuzzed images.
 	 */
-	free_extent_buffer_nocache(eb);
-	return ERR_PTR(ret);
+	if (bytenr < sectorsize || !IS_ALIGNED(bytenr, sectorsize)) {
+		error("tree block bytenr %llu is not aligned to sectorsize %u",
+		      bytenr, sectorsize);
+		return ERR_PTR(-EIO);
+	}
+
+	eb = btrfs_find_create_tree_block(fs_info, bytenr);
+	if (!eb)
+		return ERR_PTR(-ENOMEM);
+
+	if (btrfs_buffer_uptodate(eb, parent_transid, 0))
+		return eb;
+
+	ret = btrfs_read_extent_buffer(eb, parent_transid, level, first_key);
+	if (ret) {
+		/*
+		 * We failed to read this tree block, it be should deleted right
+		 * now to avoid stale cache populate the cache.
+		 */
+		free_extent_buffer_nocache(eb);
+		return ERR_PTR(ret);
+	}
+
+	return eb;
 }
 
 int write_and_map_eb(struct btrfs_fs_info *fs_info, struct extent_buffer *eb)
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index ed7f9259..4c63a4a8 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -233,6 +233,8 @@ int btrfs_global_root_insert(struct btrfs_fs_info *fs_info,
 int btrfs_find_and_setup_root(struct btrfs_root *tree_root,
 			      struct btrfs_fs_info *fs_info,
 			      u64 objectid, struct btrfs_root *root);
+int btrfs_read_extent_buffer(struct extent_buffer *eb, u64 parent_transid,
+			     int level, struct btrfs_key *first_key);
 
 static inline struct btrfs_root *btrfs_block_group_root(
 						struct btrfs_fs_info *fs_info)
-- 
2.40.0

