Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D39785AB3
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbjHWOdq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbjHWOdp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:45 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B604EE54
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:43 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-58d31f142eeso60776487b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801223; x=1693406023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CiUcmOreLVu8AWBRtee+YCkD4MmXgQZd0jqvEJH/atM=;
        b=1J04DnguzKXcJsQZtHQZIpxRodPzoZxAW+FNDREmsnO4mAyak63nKfgMxAKYaLSusT
         EmJyKUibn9AFFA7VkusvgZ3hRoJfio/qt7e1xn2hkPfMGZgoR9Gxi7T16wbNaokanBgF
         Tn4bYkWbQkJLqT/fG04JnfX+HFOmvCxBKuOzrsm8NYL74TWfeX1ElmumV5ocYoMaogTM
         cSKKcX3Ib2FKbc7EBaozwcz9P9RASCkRCuHYtJLknQn4GOVDUYh/yvb55C/6AKetT1tJ
         jl5oPI1OuGifSosNI2JvCNzUgZPJiD841oHNOz2FEZNeYZH5jgLy+GsVpqvZxViJebQk
         EFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801223; x=1693406023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CiUcmOreLVu8AWBRtee+YCkD4MmXgQZd0jqvEJH/atM=;
        b=d+ou/Pc3zIlU2H53tb+K3DT6yfuJowmxpW81ZqlOMlZ1JfVz2Jh26MOPEpzxhueTPF
         Gxw3KpHoxX/J5JOCVxqtC5vqC4R1Gc60Lh3M9SGWGd10AsHPEJQcIiRMrxTE7z394IUP
         lo02WdV5h9XaRAMh9ieRCSrROu1PQpvnRn+SkPUQpn+ccIZqn/CeAlzwBaK186CPcFQ2
         dHSDRfVG14FQDXAaEoR49SAjWiNXJCMBYO4QZ4FqLsNsZ+ZFPE5m80iazTth9XAe90xq
         u3gCWLEohMp5BvTh+MEwAwC6soKLoncSYe/V8vEznxX1nhLhB1nDt9a6agYsbduWv4SV
         dSPA==
X-Gm-Message-State: AOJu0YwCMjL+bwkXm7VRe680x3Gt2YebaQG/DL1nI1Z4YDuzK0i77UlG
        iSlWPNBbS2iTPia6nzYoUG8c3i6V6Os3KlbvFnI=
X-Google-Smtp-Source: AGHT+IEbdcY+cgk4AG5iYDc0EwUjXBCq7fcYfyR/hMrrQ+cZf/EFQTzTwEY7NRheE9PwMcfJ28+s3A==
X-Received: by 2002:a0d:d68c:0:b0:565:cf47:7331 with SMTP id y134-20020a0dd68c000000b00565cf477331mr14976393ywd.2.1692801222818;
        Wed, 23 Aug 2023 07:33:42 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p5-20020a0dcd05000000b00589a1dc0809sm3370006ywd.120.2023.08.23.07.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:42 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 29/38] btrfs-progs: update btrfs_insert_empty_items to match the kernel
Date:   Wed, 23 Aug 2023 10:32:55 -0400
Message-ID: <2181de3ff24d50339f61f74bf57798147b2893c4.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the kernel we have a control struct called btrfs_item_batch that
encodes all of the information for bulk inserting a bunch of items.
Update btrfs_insert_empty_times to match the in-kernel implementation to
make sync'ing ctree.c more straightforward.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c | 36 +++++++++++++++++-------------------
 kernel-shared/ctree.h | 37 +++++++++++++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 13f8a437..c3b86e2e 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -2576,8 +2576,7 @@ void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
 int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root,
 			    struct btrfs_path *path,
-			    struct btrfs_key *cpu_key, u32 *data_size,
-			    int nr)
+			    const struct btrfs_item_batch *batch)
 {
 	struct extent_buffer *leaf;
 	int ret = 0;
@@ -2585,20 +2584,16 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 	int i;
 	u32 nritems;
 	u32 total_size = 0;
-	u32 total_data = 0;
 	unsigned int data_end;
 	struct btrfs_disk_key disk_key;
 
-	for (i = 0; i < nr; i++) {
-		total_data += data_size[i];
-	}
-
 	/* create a root if there isn't one */
 	if (!root->node)
 		BUG();
 
-	total_size = total_data + nr * sizeof(struct btrfs_item);
-	ret = btrfs_search_slot(trans, root, cpu_key, path, total_size, 1);
+	total_size = batch->total_data_size +
+		(batch->nr * sizeof(struct btrfs_item));
+	ret = btrfs_search_slot(trans, root, &batch->keys[0], path, total_size, 1);
 	if (ret == 0) {
 		return -EEXIST;
 	}
@@ -2637,35 +2632,38 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 			u32 ioff;
 
 			ioff = btrfs_item_offset(leaf, i);
-			btrfs_set_item_offset(leaf, i, ioff - total_data);
+			btrfs_set_item_offset(leaf, i,
+					      ioff - batch->total_data_size);
 		}
 
 		/* shift the items */
-		memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, slot + nr),
+		memmove_extent_buffer(leaf,
+			      btrfs_item_nr_offset(leaf, slot + batch->nr),
 			      btrfs_item_nr_offset(leaf, slot),
 			      (nritems - slot) * sizeof(struct btrfs_item));
 
 		/* shift the data */
 		memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, 0) +
-			      data_end - total_data, btrfs_item_nr_offset(leaf, 0) +
+			      data_end - batch->total_data_size,
+			      btrfs_item_nr_offset(leaf, 0) +
 			      data_end, old_data - data_end);
 		data_end = old_data;
 	}
 
 	/* setup the item for the new data */
-	for (i = 0; i < nr; i++) {
-		btrfs_cpu_key_to_disk(&disk_key, cpu_key + i);
+	for (i = 0; i < batch->nr; i++) {
+		btrfs_cpu_key_to_disk(&disk_key, &batch->keys[i]);
 		btrfs_set_item_key(leaf, &disk_key, slot + i);
-		btrfs_set_item_offset(leaf, slot + i, data_end - data_size[i]);
-		data_end -= data_size[i];
-		btrfs_set_item_size(leaf, slot + i, data_size[i]);
+		data_end -= batch->data_sizes[i];
+		btrfs_set_item_offset(leaf, slot + i, data_end);
+		btrfs_set_item_size(leaf, slot + i, batch->data_sizes[i]);
 	}
-	btrfs_set_header_nritems(leaf, nritems + nr);
+	btrfs_set_header_nritems(leaf, nritems + batch->nr);
 	btrfs_mark_buffer_dirty(leaf);
 
 	ret = 0;
 	if (slot == 0) {
-		btrfs_cpu_key_to_disk(&disk_key, cpu_key);
+		btrfs_cpu_key_to_disk(&disk_key, &batch->keys[0]);
 		fixup_low_keys(path, &disk_key, 1);
 	}
 
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 07a5992c..d2b1b421 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -995,12 +995,38 @@ static inline int btrfs_del_item(struct btrfs_trans_handle *trans,
 	return btrfs_del_items(trans, root, path, path->slots[0], 1);
 }
 
+/*
+ * Describes a batch of items to insert in a btree. This is used by
+ * btrfs_insert_empty_items().
+ */
+struct btrfs_item_batch {
+	/*
+	 * Pointer to an array containing the keys of the items to insert (in
+	 * sorted order).
+	 */
+	const struct btrfs_key *keys;
+	/* Pointer to an array containing the data size for each item to insert. */
+	const u32 *data_sizes;
+	/*
+	 * The sum of data sizes for all items. The caller can compute this while
+	 * setting up the data_sizes array, so it ends up being more efficient
+	 * than having btrfs_insert_empty_items() or setup_item_for_insert()
+	 * doing it, as it would avoid an extra loop over a potentially large
+	 * array, and in the case of setup_item_for_insert(), we would be doing
+	 * it while holding a write lock on a leaf and often on upper level nodes
+	 * too, unnecessarily increasing the size of a critical section.
+	 */
+	u32 total_data_size;
+	/* Size of the keys and data_sizes arrays (number of items in the batch). */
+	int nr;
+};
+
 int btrfs_insert_item(struct btrfs_trans_handle *trans, struct btrfs_root
 		      *root, struct btrfs_key *key, void *data, u32 data_size);
 int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
 			     struct btrfs_path *path,
-			     struct btrfs_key *cpu_key, u32 *data_size, int nr);
+			     const struct btrfs_item_batch *batch);
 
 static inline int btrfs_insert_empty_item(struct btrfs_trans_handle *trans,
 					  struct btrfs_root *root,
@@ -1008,7 +1034,14 @@ static inline int btrfs_insert_empty_item(struct btrfs_trans_handle *trans,
 					  struct btrfs_key *key,
 					  u32 data_size)
 {
-	return btrfs_insert_empty_items(trans, root, path, key, &data_size, 1);
+	struct btrfs_item_batch batch;
+
+	batch.keys = key;
+	batch.data_sizes = &data_size;
+	batch.total_data_size = data_size;
+	batch.nr = 1;
+
+	return btrfs_insert_empty_items(trans, root, path, &batch);
 }
 
 int btrfs_next_sibling_tree_block(struct btrfs_fs_info *fs_info,
-- 
2.41.0

