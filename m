Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DBA785A9C
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbjHWOda (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbjHWOd0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:26 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B11EE5F
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:19 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a85cc7304fso2130210b6e.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801198; x=1693405998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9x70RyqRpYDJDVmuZlQA7eX1lKYX5heI8LbHX9VPsM=;
        b=yqwb2kQcXNpx4Tj5mbbdkbrjZqKnH7U1MKHJzveQf9MaoRDyV4Rf0Q1wP3qjE2HoAd
         +vlznQtxrD7HkCNqDwFbsPRZo7ZRpYDiPfDP/bHO1gT8wM8VNgMSJJiCg4d8+8LQpUHF
         C2jM82FGdMaVyBEc6Q1A8rZE448tnoEllFGQeUzyQRupSC506LfeH2QIZkOxgfDHuf9N
         JZE5iREK5/iyDfmxVGVKTYHWP0YmtTWB+cmzt3aN0mRLXOu6h0q2pfue84oCeUnW2Jhq
         puzhVY9pioTWmNchYhQWg6kSKeXc+1LYJ7YrSChyA1lgjxNpw6z6V7Liigc22fXHctaT
         MDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801198; x=1693405998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9x70RyqRpYDJDVmuZlQA7eX1lKYX5heI8LbHX9VPsM=;
        b=Y7Mhx/GgrLk3sOtmdcsrrW3E1PLF2nUiv2osNQ0hoZ5MT8CKfL4QGs1pNUb5Tr3ID3
         aX4xhYxgaLXy7tyxfte8RHcah5TG9uWZAsRSoFHfYOKlz7UclyzXipSq8KqjH8vK3j1+
         /k8livfzw69Pl4V7hBOE5kjZwt2wJyDooxuyDPpl0X88Q/qufz7Lb2EZGxE8AlpWSPX3
         x47jWUoxXjQROx49I0RZzYOzhjL1PcFI4V7bLHesIqY5KgFkqHgSZXKV4Mniq+RNUcZD
         HrhXKnObgPeKf0L5eUnYghl//HDPPwXLlF5UBgS0Hf94wI7laHNBBkbHNZQTnE892pis
         vwyw==
X-Gm-Message-State: AOJu0Yw5s2cl5mDdMSjOGMlpZTn6dN2KqgkGDzXGYdhtYA77lp3RzXfu
        YtfCfm4UIJTdZxyyjsUYAqM2HF8yY5BrHf+BNdg=
X-Google-Smtp-Source: AGHT+IH2YQAsZPQ0x6MyrPYeyvego6akXjwYWLnJFIfqpcYiD57NZzXZrK8XMRfgZDCvVqoWS87w6Q==
X-Received: by 2002:a05:6358:71b:b0:13a:3062:8d72 with SMTP id e27-20020a056358071b00b0013a30628d72mr13669698rwj.9.1692801198209;
        Wed, 23 Aug 2023 07:33:18 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v17-20020a814811000000b00583b40d907esm3377420ywa.16.2023.08.23.07.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/38] btrfs-progs: update btrfs_set_item_key_safe to match kernel definition
Date:   Wed, 23 Aug 2023 10:32:34 -0400
Message-ID: <53ff718ecdf1f3d743ad2334f9321439f3ad432c.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
 tune/change-csum.c        |  8 +-------
 4 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 4d269e45..f94d3ef1 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -1514,8 +1514,9 @@ void btrfs_fixup_low_keys( struct btrfs_path *path, struct btrfs_disk_key *key,
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
@@ -1525,13 +1526,11 @@ int btrfs_set_item_key_safe(struct btrfs_root *root, struct btrfs_path *path,
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
@@ -1539,7 +1538,6 @@ int btrfs_set_item_key_safe(struct btrfs_root *root, struct btrfs_path *path,
 	btrfs_mark_buffer_dirty(eb);
 	if (slot == 0)
 		btrfs_fixup_low_keys(path, &disk_key, 1);
-	return 0;
 }
 
 /*
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 66c05a69..bf5dde14 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1056,8 +1056,9 @@ int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path);
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
index 1a2f5f14..30a89094 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -379,8 +379,7 @@ static noinline int truncate_one_csum(struct btrfs_root *root,
 		BUG_ON(ret);
 
 		key->offset = end_byte;
-		ret = btrfs_set_item_key_safe(root, path, key);
-		BUG_ON(ret);
+		btrfs_set_item_key_safe(root->fs_info, path, key);
 	} else {
 		BUG();
 	}
diff --git a/tune/change-csum.c b/tune/change-csum.c
index 17372890..9edddb05 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -459,13 +459,7 @@ static int change_csum_objectids(struct btrfs_fs_info *fs_info)
 			btrfs_item_key_to_cpu(path.nodes[0], &found_key, i);
 			found_key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
 			path.slots[0] = i;
-			ret = btrfs_set_item_key_safe(csum_root, &path, &found_key);
-			if (ret < 0) {
-				errno = -ret;
-				error("failed to set item key for data csum at logical %llu: %m",
-				      found_key.offset);
-				goto out;
-			}
+			btrfs_set_item_key_safe(fs_info, &path, &found_key);
 		}
 		btrfs_release_path(&path);
 	}
-- 
2.41.0

