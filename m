Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C56636D51
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiKWWiV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 17:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKWWhz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:37:55 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E24D42F46
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:53 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id d18so9595415qvs.6
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3N1E6gVteJkHBweW43ajyMRy92VMEYEPt/eL23IpKcM=;
        b=XurG+mRlrQTYbBUkRc8ASiDsyAOF2IeArbO2DFRSUQ3lrwUhYMFt15CW1Mi0rvIyN9
         VIo/J2dQgxY+MmFWU33DBaehDn0X0Duog5FPyGXnUbbOcsBKhdPr42f40Qlv6q+rtO0h
         86/LvhGoy5ucsllv+F6gAJbEmKqPXJl3/1v+I3Px0sylRrF2FwHb4hzpckxiA3+io1iF
         6gqYFfYqb8SzDS0ghwr28MQt+FdI+OJ+KsKFf/vqq9HAe1HDJgB5WEJOPIH8XiJpeCax
         VfBLim+Hggpl1a6g1o62HSRiD2VCudNjqLQELxip6baJGXnHcG1XcMYEo+RnyMRwvemE
         cb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3N1E6gVteJkHBweW43ajyMRy92VMEYEPt/eL23IpKcM=;
        b=GU+87q71O0G0WcO2tJNf5rDTJ2uvsllyK/CQPsXDXwVF0eXkoqdlfpk6dURuyX6DrV
         Cd+9P44GftAi0hOfknzoqMvdqffujy6iUMyK+INLLOjLo8O0DQx/PPTW2R+gKvWpSEiv
         aYdvywjAL8h3WiURykFdk/hhmeA81Z39ERJTBS2QGKSDFcWRkajZLo2oD4/55huIFNgl
         QMK5765PMk6+IkaE6QVw4oZO+0hynSmaaot3kDcOOzibWJ/6bjiYVFnbv8wXFVmSoXdh
         hZZEMcQAveSH06BlHYtCUTn4FK6tvupTOaK1AM2ArpQVuJnGGLl9UPjtSERguBn4fpOC
         JXNQ==
X-Gm-Message-State: ANoB5pl9KPix/cXhKVzIgF3JLfdH4GNXqNyqZKPlj2KWfqE7wAA3GYfL
        Vv8hFqy7cqD3MPw7G1V/IYQl74zXkPCM3A==
X-Google-Smtp-Source: AA0mqf6bsmsdPJ+UJpWt6TQHMwtd9d1YO75983gRLyL6vlObf/9ZLQuwfxsjAEVqAy18l1oWgAF9uQ==
X-Received: by 2002:a0c:ff28:0:b0:4bb:798d:879c with SMTP id x8-20020a0cff28000000b004bb798d879cmr10851843qvt.7.1669243072196;
        Wed, 23 Nov 2022 14:37:52 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id fy11-20020a05622a5a0b00b003a4f435e381sm10585850qtb.18.2022.11.23.14.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:37:51 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 10/29] btrfs-progs: rename btrfs_item_end to btrfs_item_data_end
Date:   Wed, 23 Nov 2022 17:37:18 -0500
Message-Id: <c2fc759bfb806134b4e2bb8af3c369befabbdd21.1669242804.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1669242804.git.josef@toxicpanda.com>
References: <cover.1669242804.git.josef@toxicpanda.com>
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
index 61eaab55..85ecc16b 100644
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

