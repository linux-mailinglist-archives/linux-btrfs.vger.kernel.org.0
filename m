Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E13C6F263A
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjD2UHs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjD2UHn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:07:43 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFADA210A
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:39 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so14214114276.0
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682798859; x=1685390859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uC3+bynHUqSF92rBvWCVvjTD5QoqGnqyMiaUmIEAOug=;
        b=YzzzrC/EGgFJBgFAi01SarUTXBtXcW2ESTp3hp5V0Y3qWMgKstyxql1Fl7ksSd76gD
         ElE4pxnqWkuL0lgoeDy8re1zHovdvq4Vg3iIsp0z8bCP1qDOLP9AZO8W6KTTn3/E/zgu
         KLATYxjTIcRim5P0f0KzKeR9uuuysSml66I4DaH4G6IvN+F1hTN2KCQtQyOvNBdMh2Qv
         i4s8bCULSEKko1F/EBKeYBuBvWCUzqwetz+mRavyfaHXOxTGXoLBZ10dkmX1u89GSWQC
         0u+sQ6wAnt+0793e+ZxXCcVZdDH4jLvM+BQCYCuveM2lv/bIDc4lWBUaiCqYBxwMrD3b
         LGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682798859; x=1685390859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uC3+bynHUqSF92rBvWCVvjTD5QoqGnqyMiaUmIEAOug=;
        b=Z1CJ7c12L4KZPnztIYLwz/fZQdK7qZf24OpB0F1QwOpKr7wm/K28HyWhj+yFIb0eh8
         MzHoQrVKqcpyJYcvEQKPV1R/iAP1ftsoFCCAtHYo3Z4Zn3ZwEFa64IdxM7EphYX6GXWT
         djpM4pQ3EWPfdlwXBoQirOcxBz9hwACbrbzvUN18MXxil2HLtkLJlMHcV6E+R1UboEDB
         BqEkgHuFJDmiNHdQzdF7PZDBx+Fck79G0ojpJBes2EDYulGq2f2DDtQJaDejjqDQ3bFP
         apaW5CRMz6coqX9SU2xNRaniRdI9nVXuAElH+Midva67P+H+vUA/hLN9hTTCfVXiUGCR
         dnGw==
X-Gm-Message-State: AC+VfDyNA8efprO30HEYlfsO9YZrvluPRXSIF+H/wXrSXzc36MQ99FWx
        RQ9qaspq3HAnEJX2wI661yB/BHUpqtbRci42ckqF4Q==
X-Google-Smtp-Source: ACHHUZ7/DO0NvJMy3IJi5fydtSmgc+zzhtCSVk4836OHks3Yn3fR47TrmovY5bVauGDy9HabbdfV7w==
X-Received: by 2002:a81:4bc9:0:b0:559:ed24:6bd9 with SMTP id y192-20020a814bc9000000b00559ed246bd9mr2238117ywa.1.1682798859034;
        Sat, 29 Apr 2023 13:07:39 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j65-20020a816e44000000b00559be540b56sm1111219ywc.134.2023.04.29.13.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:07:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/12] btrfs: move btrfs_verify_level_key into tree-checker.c
Date:   Sat, 29 Apr 2023 16:07:17 -0400
Message-Id: <dfd15f7bebb3c35f9c3632b51d823f103e9e7213.1682798736.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682798736.git.josef@toxicpanda.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
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

This is more a buffer validation helper, move it into the tree-checker
files where it makes more sense.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c      | 58 -----------------------------------------
 fs/btrfs/disk-io.h      |  2 --
 fs/btrfs/tree-checker.c | 58 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/tree-checker.h |  2 ++
 4 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index aea1ee834a80..cd0e8f394420 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -180,64 +180,6 @@ int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-int btrfs_verify_level_key(struct extent_buffer *eb, int level,
-			   struct btrfs_key *first_key, u64 parent_transid)
-{
-	struct btrfs_fs_info *fs_info = eb->fs_info;
-	int found_level;
-	struct btrfs_key found_key;
-	int ret;
-
-	found_level = btrfs_header_level(eb);
-	if (found_level != level) {
-		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
-		     KERN_ERR "BTRFS: tree level check failed\n");
-		btrfs_err(fs_info,
-"tree level mismatch detected, bytenr=%llu level expected=%u has=%u",
-			  eb->start, level, found_level);
-		return -EIO;
-	}
-
-	if (!first_key)
-		return 0;
-
-	/*
-	 * For live tree block (new tree blocks in current transaction),
-	 * we need proper lock context to avoid race, which is impossible here.
-	 * So we only checks tree blocks which is read from disk, whose
-	 * generation <= fs_info->last_trans_committed.
-	 */
-	if (btrfs_header_generation(eb) > fs_info->last_trans_committed)
-		return 0;
-
-	/* We have @first_key, so this @eb must have at least one item */
-	if (btrfs_header_nritems(eb) == 0) {
-		btrfs_err(fs_info,
-		"invalid tree nritems, bytenr=%llu nritems=0 expect >0",
-			  eb->start);
-		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
-		return -EUCLEAN;
-	}
-
-	if (found_level)
-		btrfs_node_key_to_cpu(eb, &found_key, 0);
-	else
-		btrfs_item_key_to_cpu(eb, &found_key, 0);
-	ret = btrfs_comp_cpu_keys(first_key, &found_key);
-
-	if (ret) {
-		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
-		     KERN_ERR "BTRFS: tree first key check failed\n");
-		btrfs_err(fs_info,
-"tree first key mismatch detected, bytenr=%llu parent_transid=%llu key expected=(%llu,%u,%llu) has=(%llu,%u,%llu)",
-			  eb->start, parent_transid, first_key->objectid,
-			  first_key->type, first_key->offset,
-			  found_key.objectid, found_key.type,
-			  found_key.offset);
-	}
-	return ret;
-}
-
 static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
 				      int mirror_num)
 {
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 4d5772330110..a26ab3cbb449 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -31,8 +31,6 @@ struct btrfs_tree_parent_check;
 
 void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info);
 void btrfs_init_fs_info(struct btrfs_fs_info *fs_info);
-int btrfs_verify_level_key(struct extent_buffer *eb, int level,
-			   struct btrfs_key *first_key, u64 parent_transid);
 struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 				      struct btrfs_tree_parent_check *check);
 struct extent_buffer *btrfs_find_create_tree_block(
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index eb9ba48d92aa..a1038156d57d 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1964,3 +1964,61 @@ int btrfs_check_eb_owner(const struct extent_buffer *eb, u64 root_owner)
 	}
 	return 0;
 }
+
+int btrfs_verify_level_key(struct extent_buffer *eb, int level,
+			   struct btrfs_key *first_key, u64 parent_transid)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	int found_level;
+	struct btrfs_key found_key;
+	int ret;
+
+	found_level = btrfs_header_level(eb);
+	if (found_level != level) {
+		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
+		     KERN_ERR "BTRFS: tree level check failed\n");
+		btrfs_err(fs_info,
+"tree level mismatch detected, bytenr=%llu level expected=%u has=%u",
+			  eb->start, level, found_level);
+		return -EIO;
+	}
+
+	if (!first_key)
+		return 0;
+
+	/*
+	 * For live tree block (new tree blocks in current transaction),
+	 * we need proper lock context to avoid race, which is impossible here.
+	 * So we only checks tree blocks which is read from disk, whose
+	 * generation <= fs_info->last_trans_committed.
+	 */
+	if (btrfs_header_generation(eb) > fs_info->last_trans_committed)
+		return 0;
+
+	/* We have @first_key, so this @eb must have at least one item */
+	if (btrfs_header_nritems(eb) == 0) {
+		btrfs_err(fs_info,
+		"invalid tree nritems, bytenr=%llu nritems=0 expect >0",
+			  eb->start);
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		return -EUCLEAN;
+	}
+
+	if (found_level)
+		btrfs_node_key_to_cpu(eb, &found_key, 0);
+	else
+		btrfs_item_key_to_cpu(eb, &found_key, 0);
+	ret = btrfs_comp_cpu_keys(first_key, &found_key);
+
+	if (ret) {
+		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
+		     KERN_ERR "BTRFS: tree first key check failed\n");
+		btrfs_err(fs_info,
+"tree first key mismatch detected, bytenr=%llu parent_transid=%llu key expected=(%llu,%u,%llu) has=(%llu,%u,%llu)",
+			  eb->start, parent_transid, first_key->objectid,
+			  first_key->type, first_key->offset,
+			  found_key.objectid, found_key.type,
+			  found_key.offset);
+	}
+	return ret;
+}
diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
index c0861ce1429b..3c2a02a72f64 100644
--- a/fs/btrfs/tree-checker.h
+++ b/fs/btrfs/tree-checker.h
@@ -66,5 +66,7 @@ int btrfs_check_node(struct extent_buffer *node);
 int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 			    struct btrfs_chunk *chunk, u64 logical);
 int btrfs_check_eb_owner(const struct extent_buffer *eb, u64 root_owner);
+int btrfs_verify_level_key(struct extent_buffer *eb, int level,
+			   struct btrfs_key *first_key, u64 parent_transid);
 
 #endif
-- 
2.40.0

