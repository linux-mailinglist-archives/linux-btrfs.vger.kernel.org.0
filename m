Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9F74C048E
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbiBVW1F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbiBVW1E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:27:04 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2B7B12C4
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:38 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id f21so1811211qke.13
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kZbMxv4vgwHhp3peCvKIqfSOQ0hBL08KPgI29O/3s/o=;
        b=303ihiWIpDhP69p4yyVVEQiQ4O4C7cmZ5d48mvuiviLX9DBO1N+rKdcooI8qBca1n0
         Ee9LNjDgaf0upgdyx1fGBEWfaF5Bm/kkbPuHuDOPlJ50B+nxNCgK6v8/J/NQ+10x04vI
         bUSNeV6Pp/7FuJ51i350KA5MF6qFIZfrpM0nB6cyhM09/lxTfExCZio2zjxZjE2hUrof
         Giv+sRWRgnBmtGx0WPtXdVUu8PvaAunXLWLjcICgpdLCmwPCeO4bIzv/zOGIk+civVLM
         dan68LlYw6jd98IAQBrgLNoEmo6iYa9uq6jwbLVX/7cr8xa2u9CqQ8FFWCbAX7HLd5dc
         OEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kZbMxv4vgwHhp3peCvKIqfSOQ0hBL08KPgI29O/3s/o=;
        b=bnVhG3K5rMMrUQJaleY5DJl8sraf+pwKvOYihasEp42fjKd61vEOYylfMKwV5YzB+u
         GOu9e7UhyEQ4zA+Nve2hxv/n+j4AAIlEyVDZlEi5sQbN+k8YVYvWaUMT6FitwbfHRI4q
         gKWLBYZcHvaGs5hGAE20aKzQTuA3f5fJR/w22zsQpXg9dR30z588MTAKhbmuGBzotmLF
         LHPOZgRQzHckouF20iTDinVH0yovtoWS9HErKNZMDDzhpXfWtNrpCENCUPnD4qa2gJxz
         b2ll3Ry7GD6Qz0MyjNji08IMxeyeDU/edN7IwnVD+DuXSmrkrl6FVMHFicPy3mvuMFbj
         A35w==
X-Gm-Message-State: AOAM530W7POLt2zZh0/aXcRP5NiFvm8tL0sfQ3gxYz3mMAsDDnUVtSox
        ylTbXa77vSnE13BVRSfduKFZ/NkMbjB3Vxxe
X-Google-Smtp-Source: ABdhPJz5vHwqV58aOmcq1mmjfhNM4uKlU5ijorlkmoHf52BtEug9dQN5VF5VwdWgW4Vc0OTv+38evg==
X-Received: by 2002:a37:2f43:0:b0:648:acc2:d109 with SMTP id v64-20020a372f43000000b00648acc2d109mr10819588qkh.526.1645568796876;
        Tue, 22 Feb 2022 14:26:36 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k205sm651623qke.31.2022.02.22.14.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:26:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/13] btrfs-progs: rename btrfs_item_end_nr to btrfs_item_end
Date:   Tue, 22 Feb 2022 17:26:19 -0500
Message-Id: <f33b88ff5a9ebabcc049e1460c714e8d0041f36d.1645568701.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645568701.git.josef@toxicpanda.com>
References: <cover.1645568701.git.josef@toxicpanda.com>
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

All callers use the btrfs_item_end_nr() variation, simply drop
btrfs_item_end() and make btrfs_item_end_nr() use the _nr() variations
of the item get helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c          | 12 ++++++------
 kernel-shared/ctree.c | 20 ++++++++++----------
 kernel-shared/ctree.h | 16 +++++-----------
 3 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/check/main.c b/check/main.c
index fb0ef8cb..92e1399f 100644
--- a/check/main.c
+++ b/check/main.c
@@ -4327,9 +4327,9 @@ again:
 	for (i = 0; i < btrfs_header_nritems(buf); i++) {
 		unsigned int shift = 0, offset;
 
-		if (i == 0 && btrfs_item_end_nr(buf, i) !=
+		if (i == 0 && btrfs_item_end(buf, i) !=
 		    BTRFS_LEAF_DATA_SIZE(gfs_info)) {
-			if (btrfs_item_end_nr(buf, i) >
+			if (btrfs_item_end(buf, i) >
 			    BTRFS_LEAF_DATA_SIZE(gfs_info)) {
 				ret = delete_bogus_item(root, path, buf, i);
 				if (!ret)
@@ -4340,10 +4340,10 @@ again:
 				break;
 			}
 			shift = BTRFS_LEAF_DATA_SIZE(gfs_info) -
-				btrfs_item_end_nr(buf, i);
-		} else if (i > 0 && btrfs_item_end_nr(buf, i) !=
+				btrfs_item_end(buf, i);
+		} else if (i > 0 && btrfs_item_end(buf, i) !=
 			   btrfs_item_offset_nr(buf, i - 1)) {
-			if (btrfs_item_end_nr(buf, i) >
+			if (btrfs_item_end(buf, i) >
 			    btrfs_item_offset_nr(buf, i - 1)) {
 				ret = delete_bogus_item(root, path, buf, i);
 				if (!ret)
@@ -4353,7 +4353,7 @@ again:
 				break;
 			}
 			shift = btrfs_item_offset_nr(buf, i - 1) -
-				btrfs_item_end_nr(buf, i);
+				btrfs_item_end(buf, i);
 		}
 		if (!shift)
 			continue;
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 81a438c8..d18c91d1 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -730,10 +730,10 @@ btrfs_check_leaf(struct btrfs_fs_info *fs_info,
 		else
 			item_end_expected = btrfs_item_offset_nr(leaf,
 								 slot - 1);
-		if (btrfs_item_end_nr(leaf, slot) != item_end_expected) {
+		if (btrfs_item_end(leaf, slot) != item_end_expected) {
 			generic_err(leaf, slot,
 				"unexpected item end, have %u expect %u",
-				btrfs_item_end_nr(leaf, slot),
+				btrfs_item_end(leaf, slot),
 				item_end_expected);
 			ret = BTRFS_TREE_BLOCK_INVALID_OFFSETS;
 			goto fail;
@@ -744,11 +744,11 @@ btrfs_check_leaf(struct btrfs_fs_info *fs_info,
 		 * just in case all the items are consistent to each other, but
 		 * all point outside of the leaf.
 		 */
-		if (btrfs_item_end_nr(leaf, slot) >
+		if (btrfs_item_end(leaf, slot) >
 		    BTRFS_LEAF_DATA_SIZE(fs_info)) {
 			generic_err(leaf, slot,
 			"slot end outside of leaf, have %u expect range [0, %u]",
-				btrfs_item_end_nr(leaf, slot),
+				btrfs_item_end(leaf, slot),
 				BTRFS_LEAF_DATA_SIZE(fs_info));
 			ret = BTRFS_TREE_BLOCK_INVALID_OFFSETS;
 			goto fail;
@@ -1931,7 +1931,7 @@ static int leaf_space_used(struct extent_buffer *l, int start, int nr)
 
 	if (!nr)
 		return 0;
-	data_len = btrfs_item_end_nr(l, start);
+	data_len = btrfs_item_end(l, start);
 	data_len = data_len - btrfs_item_offset_nr(l, end);
 	data_len += sizeof(struct btrfs_item) * nr;
 	WARN_ON(data_len < 0);
@@ -2059,7 +2059,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	/* push left to right */
 	right_nritems = btrfs_header_nritems(right);
 
-	push_space = btrfs_item_end_nr(left, left_nritems - push_items);
+	push_space = btrfs_item_end(left, left_nritems - push_items);
 	push_space -= leaf_data_end(left);
 
 	/* make room in the right data area */
@@ -2294,7 +2294,7 @@ static noinline int copy_for_split(struct btrfs_trans_handle *trans,
 
 	nritems = nritems - mid;
 	btrfs_set_header_nritems(right, nritems);
-	data_copy_size = btrfs_item_end_nr(l, mid) - leaf_data_end(l);
+	data_copy_size = btrfs_item_end(l, mid) - leaf_data_end(l);
 
 	copy_extent_buffer(right, l, btrfs_item_nr_offset(0),
 			   btrfs_item_nr_offset(mid),
@@ -2306,7 +2306,7 @@ static noinline int copy_for_split(struct btrfs_trans_handle *trans,
 			 btrfs_leaf_data(l) + leaf_data_end(l), data_copy_size);
 
 	rt_data_off = BTRFS_LEAF_DATA_SIZE(root->fs_info) -
-		      btrfs_item_end_nr(l, mid);
+		      btrfs_item_end(l, mid);
 
 	for (i = 0; i < nritems; i++) {
 		u32 ioff = btrfs_item_offset_nr(right, i);
@@ -2727,7 +2727,7 @@ int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 		BUG();
 	}
 	slot = path->slots[0];
-	old_data = btrfs_item_end_nr(leaf, slot);
+	old_data = btrfs_item_end(leaf, slot);
 
 	BUG_ON(slot < 0);
 	if (slot >= nritems) {
@@ -2816,7 +2816,7 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 	BUG_ON(slot < 0);
 
 	if (slot < nritems) {
-		unsigned int old_data = btrfs_item_end_nr(leaf, slot);
+		unsigned int old_data = btrfs_item_end(leaf, slot);
 
 		if (old_data < data_end) {
 			btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 7fb66049..befa244f 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1994,17 +1994,6 @@ static inline struct btrfs_item *btrfs_item_nr(int nr)
 	return (struct btrfs_item *)btrfs_item_nr_offset(nr);
 }
 
-static inline u32 btrfs_item_end(struct extent_buffer *eb,
-				 struct btrfs_item *item)
-{
-	return btrfs_item_offset(eb, item) + btrfs_item_size(eb, item);
-}
-
-static inline u32 btrfs_item_end_nr(struct extent_buffer *eb, int nr)
-{
-	return btrfs_item_end(eb, btrfs_item_nr(nr));
-}
-
 static inline void btrfs_set_item_size_nr(struct extent_buffer *eb, int nr,
 					  u32 size)
 {
@@ -2027,6 +2016,11 @@ static inline u32 btrfs_item_size_nr(struct extent_buffer *eb, int nr)
 	return btrfs_item_size(eb, btrfs_item_nr(nr));
 }
 
+static inline u32 btrfs_item_end(struct extent_buffer *eb, int nr)
+{
+	return btrfs_item_offset_nr(eb, nr) + btrfs_item_size_nr(eb, nr);
+}
+
 static inline void btrfs_item_key(struct extent_buffer *eb,
 			   struct btrfs_disk_key *disk_key, int nr)
 {
-- 
2.26.3

