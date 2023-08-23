Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA51785AB5
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbjHWOds (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjHWOds (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:48 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2993CE6C
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:46 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5922b96c5fcso30193117b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801225; x=1693406025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gj6qbpzq+O76NzAkrP/HnYs6Gn+voslRowEty2olNHY=;
        b=4XzZDGPO6H7zTlz/lgICmk3k7NHPSSxaNTkLmnleeOz9A2BIUg4Yl5VD6YSMIEO4TQ
         WI/UHu4nmxmLnAB1BTG3heFZRWIVSaZLbpePOlNcl+S+ZX1ckMbZrEDT8tqGFiPFoKI4
         Q4ZhE4Hid6Qg0FiizKx65UKUOFedfFv1/QoRUx0BPf34N0Rr18X0BTqfW3RzFW81dNK6
         DVKXrXxizRoAQ20f+nw0PbjGuUkQ1sr/jMF2SvCiVTIime/zxYj2HQMLqZUUfyj2cgoD
         yptU2qxLjiS10kqvylS/6uzN6N7hHsQ7aI9mJfvFmlQAwTIBsA+Q7hNFWOdZE/5xZ472
         82Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801225; x=1693406025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gj6qbpzq+O76NzAkrP/HnYs6Gn+voslRowEty2olNHY=;
        b=D21tnvyqm7PU2vUU5iTc+7LopgHMENW+WEKvVJZtJ9s7JmDsB9TAKaiISzIV561ixt
         LZsTuBwbwqeXxenUGVoYGFmMZJXX42vHElTk23KQtMAuljo4IbIrIC0z+lTsKMmgwWYv
         ExfuUgVWWE9rJMKmcr5+T2sa+ykW5BGQmsgZ058tn9gz4np3Cl7ncBC2VhaDSBZzR9GM
         jFchOgDlXRcXHUHidC+kxewwKMMDPLuadazKowuHL3j5XBktm3M4FFFEPGg3Tk6AjyGw
         vWAO0JL31FerXPF6UbCB/62Uli5a1ocxd98n3qj4F7Gxpp05rBDIWNh4WfhwC/RH6B1g
         /Ccg==
X-Gm-Message-State: AOJu0YzuLFRsE2xT77DDMiwrWkxb5ND/A4K1dHURjLzKA1Sge+GiSs0D
        MTXnwIbTb+ugWE5iDBSdxhTNG2b2ifpgZhMI0yQ=
X-Google-Smtp-Source: AGHT+IFgK7sRAur8ll6XmKxKaPP19vCGNezhQPjNLwqDyD+tcFZ776eTPl1/xTINsFCVKwU0OUEBwA==
X-Received: by 2002:a81:9144:0:b0:584:4b5f:bac3 with SMTP id i65-20020a819144000000b005844b5fbac3mr13163968ywg.15.1692801225276;
        Wed, 23 Aug 2023 07:33:45 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c13-20020a814e0d000000b0058c668e46cbsm3299690ywb.46.2023.08.23.07.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:45 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 31/38] btrfs-progs: update btrfs_del_ptr to match the kernel
Date:   Wed, 23 Aug 2023 10:32:57 -0400
Message-ID: <ccae066a07bd30b0a58b2d1ebdf25ba07ffef6ca.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The kernel version of btrfs_del_ptr takes a trans handle as an argument
and returns an error in the case of tree-mod-log, update our version to
match to make syncing ctree.c more straightforward.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c          |  4 ++--
 kernel-shared/ctree.c | 12 +++++++-----
 kernel-shared/ctree.h |  4 ++--
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/check/main.c b/check/main.c
index 08c49f7a..04c965ab 100644
--- a/check/main.c
+++ b/check/main.c
@@ -3569,7 +3569,7 @@ static int repair_btree(struct btrfs_root *root,
 					     path.slots[level]);
 
 		/* Remove the ptr */
-		btrfs_del_ptr(root, &path, level, path.slots[level]);
+		btrfs_del_ptr(trans, root, &path, level, path.slots[level]);
 
 		/*
 		 * Remove the corresponding extent
@@ -7828,7 +7828,7 @@ again:
 
 del_ptr:
 	printk("deleting pointer to block %llu\n", corrupt->cache.start);
-	btrfs_del_ptr(extent_root, &path, level, slot);
+	btrfs_del_ptr(trans, extent_root, &path, level, slot);
 
 out:
 	btrfs_release_path(&path);
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index c3b86e2e..47938f01 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -855,7 +855,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			btrfs_clear_buffer_dirty(trans, right);
 			free_extent_buffer(right);
 			right = NULL;
-			btrfs_del_ptr(root, path, level + 1, pslot + 1);
+			btrfs_del_ptr(trans, root, path, level + 1, pslot + 1);
 
 			root_sub_used(root, blocksize);
 			wret = btrfs_free_extent(trans, bytenr, blocksize, 0,
@@ -900,7 +900,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		btrfs_clear_buffer_dirty(trans, mid);
 		free_extent_buffer(mid);
 		mid = NULL;
-		btrfs_del_ptr(root, path, level + 1, pslot);
+		btrfs_del_ptr(trans, root, path, level + 1, pslot);
 
 		root_sub_used(root, blocksize);
 		wret = btrfs_free_extent(trans, bytenr, blocksize, 0,
@@ -2711,8 +2711,8 @@ int btrfs_insert_item(struct btrfs_trans_handle *trans, struct btrfs_root
  * continuing all the way the root if required.  The root is converted into
  * a leaf if all the nodes are emptied.
  */
-void btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
-		int level, int slot)
+int btrfs_del_ptr(struct btrfs_trans_handle *trans, struct btrfs_root *root,
+		  struct btrfs_path *path, int level, int slot)
 {
 	struct extent_buffer *parent = path->nodes[level];
 	u32 nritems;
@@ -2739,6 +2739,8 @@ void btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 		fixup_low_keys(path, &disk_key, level + 1);
 	}
 	btrfs_mark_buffer_dirty(parent);
+
+	return 0;
 }
 
 /*
@@ -2759,7 +2761,7 @@ static noinline int btrfs_del_leaf(struct btrfs_trans_handle *trans,
 	int ret;
 
 	WARN_ON(btrfs_header_generation(leaf) != trans->transid);
-	btrfs_del_ptr(root, path, 1, path->slots[1]);
+	btrfs_del_ptr(trans, root, path, 1, path->slots[1]);
 
 	root_sub_used(root, leaf->len);
 
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index ce2122d7..d15c16c0 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -945,8 +945,8 @@ int btrfs_convert_one_bg(struct btrfs_trans_handle *trans, u64 bytenr);
 
 /* ctree.c */
 int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
-void btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
-		int level, int slot);
+int btrfs_del_ptr(struct btrfs_trans_handle *trans, struct btrfs_root *root,
+		  struct btrfs_path *path, int level, int slot);
 struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
 					   int slot);
 int btrfs_previous_item(struct btrfs_root *root,
-- 
2.41.0

