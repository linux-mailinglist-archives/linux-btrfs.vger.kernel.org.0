Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685036263A8
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 22:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiKKVao (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 16:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbiKKVab (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 16:30:31 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA087E00E
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 13:30:30 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id o8so4114043qvw.5
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 13:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqek6as9SELqSqTyhT+DiKLOqxbM1xNThUv+t6ZPSF0=;
        b=xolhkWu9cPKWPS8uiCrIN/1c/3/64ueUodGlfs0ugNUgAPrOMN+nsG/udcTbwAMgmg
         yKyi79LcpH9tqPNA2UBRjBBBCLro4w/P+58Mdy//UM4gArA5C53ceYPhRFpCGR6sD4Tk
         7r5ssoidCyCcpBIf0MsZ+X6gOfTA4ek3b3QktmfR/Gb9JgiFrePXHGflebx1F1ex8gHL
         3WRg7FMkDwhBcuEhPoWWvH2ijgXR/+GjBucawXuJ4FyKJcq3GDsSDmK+hRzeRbRc3d+m
         RDiuNZFyGI0ffUqJmoEBn47PztBBM70QiyPIA7yUvR6hfiE23+fJyTtAmdgvhoopYpl7
         +xFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqek6as9SELqSqTyhT+DiKLOqxbM1xNThUv+t6ZPSF0=;
        b=PO01Qs+Y00jSCoYOLRK9Fhfak8tFfK2oh/5CZXC31CNB1zCBEkrdoTgIoQDwXru6Xj
         w5YQDvs7Y1Bbw/1SzhmAWOiiJwHwzKR/o5Ja45TPWH8NhzlAvqRUV4R5X85Q5i8bJS3x
         94ZT7Eh2DuMzCMgbnXJeIn7gErWt6B66jWd9vck3DHF5r+xOwJFZuBIgQELD3PcJDgAC
         W+QWPZOEaGjWbroacXFdR8tE3GKAD0d56az5ePjNEHp9LTB/3FLoGxH6bmXcWNlHl3ih
         gIGaCV0coJOpEw740WLRZMBOMmO3Re0sibzS1g0WA1lVHBzTL28lfr2gTDT8vqcZBckJ
         gnpA==
X-Gm-Message-State: ANoB5pmbp2AZ3e9x/lCWcAXjyMZu80KKrb6fTeve1QBwADDokvY30D9Y
        JPj10gqobNV6k0ClnRf6I1tEUx/vylh9uA==
X-Google-Smtp-Source: AA0mqf6+fl6ou0Nq0tP1KQr99eVNzdVfgBdoeY/6TsAx586goiehccGsb6fhDiiQt/c+90stuYE7uQ==
X-Received: by 2002:a05:6214:1902:b0:4a4:474a:1394 with SMTP id er2-20020a056214190200b004a4474a1394mr3674377qvb.36.1668202229751;
        Fri, 11 Nov 2022 13:30:29 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a0b8b00b006fab68c7e87sm2006973qkh.70.2022.11.11.13.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 13:30:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/14] btrfs-progs: rename btrfs_item_end to btrfs_item_data_end
Date:   Fri, 11 Nov 2022 16:30:10 -0500
Message-Id: <1e027c6e2e601fe4b7e2d2d245b8e23076ef9087.1668201935.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668201935.git.josef@toxicpanda.com>
References: <cover.1668201935.git.josef@toxicpanda.com>
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

This matches what we did in the kernel, btrfs_item_data_end is more
inline with what the helper does, which is give us the offset of the end
of the data portion of the item, not the offset of the end of the item
itself.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c          | 12 ++++++------
 kernel-shared/ctree.c | 12 ++++++------
 kernel-shared/ctree.h |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/check/main.c b/check/main.c
index 25b13ce1..4c8e6bdf 100644
--- a/check/main.c
+++ b/check/main.c
@@ -4393,9 +4393,9 @@ again:
 	for (i = 0; i < btrfs_header_nritems(buf); i++) {
 		unsigned int shift = 0, offset;
 
-		if (i == 0 && btrfs_item_end(buf, i) !=
+		if (i == 0 && btrfs_item_data_end(buf, i) !=
 		    BTRFS_LEAF_DATA_SIZE(gfs_info)) {
-			if (btrfs_item_end(buf, i) >
+			if (btrfs_item_data_end(buf, i) >
 			    BTRFS_LEAF_DATA_SIZE(gfs_info)) {
 				ret = delete_bogus_item(root, path, buf, i);
 				if (!ret)
@@ -4406,10 +4406,10 @@ again:
 				break;
 			}
 			shift = BTRFS_LEAF_DATA_SIZE(gfs_info) -
-				btrfs_item_end(buf, i);
-		} else if (i > 0 && btrfs_item_end(buf, i) !=
+				btrfs_item_data_end(buf, i);
+		} else if (i > 0 && btrfs_item_data_end(buf, i) !=
 			   btrfs_item_offset(buf, i - 1)) {
-			if (btrfs_item_end(buf, i) >
+			if (btrfs_item_data_end(buf, i) >
 			    btrfs_item_offset(buf, i - 1)) {
 				ret = delete_bogus_item(root, path, buf, i);
 				if (!ret)
@@ -4419,7 +4419,7 @@ again:
 				break;
 			}
 			shift = btrfs_item_offset(buf, i - 1) -
-				btrfs_item_end(buf, i);
+				btrfs_item_data_end(buf, i);
 		}
 		if (!shift)
 			continue;
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 08c494af..d6ff0008 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -1938,7 +1938,7 @@ static int leaf_space_used(struct extent_buffer *l, int start, int nr)
 
 	if (!nr)
 		return 0;
-	data_len = btrfs_item_end(l, start);
+	data_len = btrfs_item_data_end(l, start);
 	data_len = data_len - btrfs_item_offset(l, end);
 	data_len += sizeof(struct btrfs_item) * nr;
 	WARN_ON(data_len < 0);
@@ -2066,7 +2066,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	/* push left to right */
 	right_nritems = btrfs_header_nritems(right);
 
-	push_space = btrfs_item_end(left, left_nritems - push_items);
+	push_space = btrfs_item_data_end(left, left_nritems - push_items);
 	push_space -= leaf_data_end(left);
 
 	/* make room in the right data area */
@@ -2301,7 +2301,7 @@ static noinline int copy_for_split(struct btrfs_trans_handle *trans,
 
 	nritems = nritems - mid;
 	btrfs_set_header_nritems(right, nritems);
-	data_copy_size = btrfs_item_end(l, mid) - leaf_data_end(l);
+	data_copy_size = btrfs_item_data_end(l, mid) - leaf_data_end(l);
 
 	copy_extent_buffer(right, l, btrfs_leaf_data(right),
 			   btrfs_item_nr_offset(l, mid),
@@ -2313,7 +2313,7 @@ static noinline int copy_for_split(struct btrfs_trans_handle *trans,
 			 btrfs_leaf_data(l) + leaf_data_end(l), data_copy_size);
 
 	rt_data_off = BTRFS_LEAF_DATA_SIZE(root->fs_info) -
-		      btrfs_item_end(l, mid);
+		      btrfs_item_data_end(l, mid);
 
 	for (i = 0; i < nritems; i++) {
 		u32 ioff = btrfs_item_offset(right, i);
@@ -2734,7 +2734,7 @@ int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 		BUG();
 	}
 	slot = path->slots[0];
-	old_data = btrfs_item_end(leaf, slot);
+	old_data = btrfs_item_data_end(leaf, slot);
 
 	BUG_ON(slot < 0);
 	if (slot >= nritems) {
@@ -2823,7 +2823,7 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 	BUG_ON(slot < 0);
 
 	if (slot < nritems) {
-		unsigned int old_data = btrfs_item_end(leaf, slot);
+		unsigned int old_data = btrfs_item_data_end(leaf, slot);
 
 		if (old_data < data_end) {
 			btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 68e5a08f..98f55cc6 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -2022,7 +2022,7 @@ static inline void btrfs_set_item_##member(struct extent_buffer *eb,		\
 BTRFS_ITEM_SETGET_FUNCS(size)
 BTRFS_ITEM_SETGET_FUNCS(offset)
 
-static inline u32 btrfs_item_end(struct extent_buffer *eb, int nr)
+static inline u32 btrfs_item_data_end(struct extent_buffer *eb, int nr)
 {
 	return btrfs_item_offset(eb, nr) + btrfs_item_size(eb, nr);
 }
-- 
2.26.3

