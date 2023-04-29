Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A915A6F265F
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjD2UUX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjD2UUV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:21 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2430D271C
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:15 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-b97ec4bbc5aso784557276.3
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799614; x=1685391614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XzgAoXnHiCe7K9J9y1gABU4TzASdEaVMvWOIksRyrpM=;
        b=5BcyLe21QuqTl5owzaPJG1cdwHnrKhf2BFuv63lmCf9bzqDwxcAj68ZpLD1B0QQpKK
         nXW6nt+P4iB4KsflKzg1+kiEiSGiXFiZ7Zg1fG0tCNp8SOrFG4LfzVjbk+my3bQIoZZP
         wOzVWUuCtqAACiaTjxLX3lt0Hx5md/PcB4J7FN+qopdSJbbFg6/b6GGAYSZX1qbBk4y5
         6/Dx8eClUdIRrM7oli6Ei2KCdNbAuhjqiPIDOEiQN3789uY6FZqMeEq//gmNS+QYm9Jn
         YeGoHfUTRjbAzeVaf1ZGgMf8XSnd1X4o6KeG1d2RlCv3ucshzYPniKjbb5ojniNwBaBs
         Ea6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799614; x=1685391614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzgAoXnHiCe7K9J9y1gABU4TzASdEaVMvWOIksRyrpM=;
        b=CXDZ/Idy5lLgAOHokB4KvnENzRPOCWAZ6kAaFweBvOzIci9bFuQ8nejsOB3vw5gXMh
         BYEqcAC6y72EuMO95rU6RMBs/WWTc9UpYEio9mqp8ULaxYWDM4mgY4GeQ5M4IYtOcU3C
         gj1MxpCCbXc8o+8INOW8KtY/G94QW956l5btA5Gy6lzPJDHxTLW1SyxPa2i1FBg49KIL
         JvyJGHi2tWZT34BJlLPxGLfSe+6Ioxi+k+v8IZddHrCloa0MFNFzD1daCg2LYF+xxutm
         gAs0ypb7xrFIbkOG3TTFOpUoc+Dlv2+H/XhgDNnvd9w99oa0o+tHG4712L6MbcbCSGTC
         cyHw==
X-Gm-Message-State: AC+VfDzjybgt8hgws08cjwSKrpMChOZalnvAglw3FG25nio7/D0LSkzU
        sq+UUHP7/ln6iV8IrnSFsup7WN0av6MvdVL3hSgfEg==
X-Google-Smtp-Source: ACHHUZ7dU4FP8RJYfH/wGGyP0/Mv9Rcpl+xErc1cu898RQRbWJdgnaqrpLHS7UP3FK+sA2D4dTHAJQ==
X-Received: by 2002:a05:6902:1248:b0:b8d:a9e9:be74 with SMTP id t8-20020a056902124800b00b8da9e9be74mr9547805ybu.38.1682799613663;
        Sat, 29 Apr 2023 13:20:13 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t124-20020a0dd182000000b0054f9dc9c7f2sm5463127ywd.44.2023.04.29.13.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:13 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/26] btrfs-progs: update btrfs_set_item_key_safe to match kernel definition
Date:   Sat, 29 Apr 2023 16:19:39 -0400
Message-Id: <83d99b43f200e65bd4ff9719da3128ca21a14424.1682799405.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682799405.git.josef@toxicpanda.com>
References: <cover.1682799405.git.josef@toxicpanda.com>
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

In the kernel we just pass the btrfs_fs_info, and we const'ify the
new_key.  Update the btrfs-progs definition to make syncing ctree.c
easier.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c     | 12 +++++-------
 kernel-shared/ctree.h     |  5 +++--
 kernel-shared/file-item.c |  3 +--
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 2e7b6c9a..94aa45a3 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -1355,8 +1355,9 @@ void btrfs_fixup_low_keys( struct btrfs_path *path, struct btrfs_disk_key *key,
  * This function isn't completely safe. It's the caller's responsibility
  * that the new key won't break the order
  */
-int btrfs_set_item_key_safe(struct btrfs_root *root, struct btrfs_path *path,
-			    struct btrfs_key *new_key)
+void btrfs_set_item_key_safe(struct btrfs_fs_info *fs_info,
+			     struct btrfs_path *path,
+			     const struct btrfs_key *new_key)
 {
 	struct btrfs_disk_key disk_key;
 	struct extent_buffer *eb;
@@ -1366,13 +1367,11 @@ int btrfs_set_item_key_safe(struct btrfs_root *root, struct btrfs_path *path,
 	slot = path->slots[0];
 	if (slot > 0) {
 		btrfs_item_key(eb, &disk_key, slot - 1);
-		if (btrfs_comp_keys(&disk_key, new_key) >= 0)
-			return -1;
+		BUG_ON(btrfs_comp_keys(&disk_key, new_key) >= 0);
 	}
 	if (slot < btrfs_header_nritems(eb) - 1) {
 		btrfs_item_key(eb, &disk_key, slot + 1);
-		if (btrfs_comp_keys(&disk_key, new_key) <= 0)
-			return -1;
+		BUG_ON(btrfs_comp_keys(&disk_key, new_key) <= 0);
 	}
 
 	btrfs_cpu_key_to_disk(&disk_key, new_key);
@@ -1380,7 +1379,6 @@ int btrfs_set_item_key_safe(struct btrfs_root *root, struct btrfs_path *path,
 	btrfs_mark_buffer_dirty(eb);
 	if (slot == 0)
 		btrfs_fixup_low_keys(path, &disk_key, 1);
-	return 0;
 }
 
 /*
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index d5797d09..e54d3bc3 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1055,8 +1055,9 @@ int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path);
 int btrfs_leaf_free_space(struct extent_buffer *leaf);
 void btrfs_fixup_low_keys(struct btrfs_path *path, struct btrfs_disk_key *key,
 		int level);
-int btrfs_set_item_key_safe(struct btrfs_root *root, struct btrfs_path *path,
-			    struct btrfs_key *new_key);
+void btrfs_set_item_key_safe(struct btrfs_fs_info *fs_info,
+			     struct btrfs_path *path,
+			     const struct btrfs_key *new_key);
 void btrfs_set_item_key_unsafe(struct btrfs_root *root,
 			       struct btrfs_path *path,
 			       struct btrfs_key *new_key);
diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
index 9f8a3296..87f80bfe 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -389,8 +389,7 @@ static noinline int truncate_one_csum(struct btrfs_root *root,
 		BUG_ON(ret);
 
 		key->offset = end_byte;
-		ret = btrfs_set_item_key_safe(root, path, key);
-		BUG_ON(ret);
+		btrfs_set_item_key_safe(root->fs_info, path, key);
 	} else {
 		BUG();
 	}
-- 
2.40.0

