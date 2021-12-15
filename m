Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1E7476399
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbhLOUnx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbhLOUnw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:43:52 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573C8C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:43:52 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id q14so23178897qtx.10
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=q9o34NHR5kE9m71ZOS9JN2+5Tz4BMq0dx5uuh8fIGRk=;
        b=ckHgoFpl8cSE6+z1KJ0+nWUhvfisbEbVvObW7OcUVQWxBMi2iUEZgCwFN4xdo+751c
         nGmtCfBoMhZgrv4wRVT9u80K+hdGni5I2Au3fcHtMGww5qE+8AenUIo1iGYPCcih3lRN
         j1t4aC3YHXQ5ysgCUqSReHChnUdPaLK1qUsopZHmWyxoS4GrCjU7BsBECVEsO7igHhpm
         dVEVqbbBuK36d+ivqfTsLXDkc2aUGTJOiI9I3JtHMRacVYPtgHPiLRTDJSOhY785lw71
         U6Tn1AoNxrGHDWA6GWoUSjleN196Wo+xnPK91BB+wf5mBvklRn9XUnLS6rmmoHqZcxJF
         uDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q9o34NHR5kE9m71ZOS9JN2+5Tz4BMq0dx5uuh8fIGRk=;
        b=mNXG1RuHCb/SMfZrYKm12+desgH+nG8Uuw72/HVj6ntvFzxELAB+EhogyZ4a3I/gl4
         dG6BllTDTv1XRG7yFOPRvOtm7TJr7oV3g8vAgAKYR1xvYmF27C/WS1hbdJeEYeiXlMtp
         wT1uZfmhPNg5MOiuxYkEydqU0efwgY+MTr3J3MdYFwIaKmO2SgOoGINE+evRZCC8qEx5
         z1RbdhjnlqzPhvwNk/RZWbGgkI+BRyfOogcBF+yG2CwUN6lxTmNt5z2dcJ+JVoRmoS6T
         s8vxWCMZRjPkLIFLhDLkaWdGZdadRBpaPWFddmE6VUAT2YWt9t2ir/hpeSfW1v2RdCBg
         6Glg==
X-Gm-Message-State: AOAM530d9qnhYubM7yUuNNOaojnNBi+0XkoC1Cw44YpQR24qpKgLOwP8
        UANPo2f2B3Y4sZf/9dbmwG9YpZrqxa++Iw==
X-Google-Smtp-Source: ABdhPJyGz6kqMpQUkkhOD1yBvoOxZIoNcfLhSF0A29M83x+6H4LLAUrq4FpAIh7R3VKJrscanLug/A==
X-Received: by 2002:ac8:5841:: with SMTP id h1mr14027747qth.517.1639601031147;
        Wed, 15 Dec 2021 12:43:51 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b9sm2273290qtb.53.2021.12.15.12.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:43:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/9] btrfs: remove `last_ref` from the extent freeing code
Date:   Wed, 15 Dec 2021 15:43:39 -0500
Message-Id: <b575c5d56c42322f5a485caf3c9540bd131f5c50.1639600854.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639600854.git.josef@toxicpanda.com>
References: <cover.1639600854.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a remnant of the work I did for qgroups a long time ago to only
run for a block when we had dropped the last ref.  We haven't done that
for years, but the code remains.  Drop this remnant.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 832cbcd52fea..4bd238ae0753 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -598,7 +598,7 @@ static noinline int insert_extent_data_ref(struct btrfs_trans_handle *trans,
 static noinline int remove_extent_data_ref(struct btrfs_trans_handle *trans,
 					   struct btrfs_root *root,
 					   struct btrfs_path *path,
-					   int refs_to_drop, int *last_ref)
+					   int refs_to_drop)
 {
 	struct btrfs_key key;
 	struct btrfs_extent_data_ref *ref1 = NULL;
@@ -631,7 +631,6 @@ static noinline int remove_extent_data_ref(struct btrfs_trans_handle *trans,
 
 	if (num_refs == 0) {
 		ret = btrfs_del_item(trans, root, path);
-		*last_ref = 1;
 	} else {
 		if (key.type == BTRFS_EXTENT_DATA_REF_KEY)
 			btrfs_set_extent_data_ref_count(leaf, ref1, num_refs);
@@ -1072,8 +1071,7 @@ static noinline_for_stack
 void update_inline_extent_backref(struct btrfs_path *path,
 				  struct btrfs_extent_inline_ref *iref,
 				  int refs_to_mod,
-				  struct btrfs_delayed_extent_op *extent_op,
-				  int *last_ref)
+				  struct btrfs_delayed_extent_op *extent_op)
 {
 	struct extent_buffer *leaf = path->nodes[0];
 	struct btrfs_extent_item *ei;
@@ -1121,7 +1119,6 @@ void update_inline_extent_backref(struct btrfs_path *path,
 		else
 			btrfs_set_shared_data_ref_count(leaf, sref, refs);
 	} else {
-		*last_ref = 1;
 		size =  btrfs_extent_inline_ref_size(type);
 		item_size = btrfs_item_size(leaf, path->slots[0]);
 		ptr = (unsigned long)iref;
@@ -1167,7 +1164,7 @@ int insert_inline_extent_backref(struct btrfs_trans_handle *trans,
 			return -EUCLEAN;
 		}
 		update_inline_extent_backref(path, iref, refs_to_add,
-					     extent_op, NULL);
+					     extent_op);
 	} else if (ret == -ENOENT) {
 		setup_inline_extent_backref(trans->fs_info, path, iref, parent,
 					    root_objectid, owner, offset,
@@ -1181,21 +1178,17 @@ static int remove_extent_backref(struct btrfs_trans_handle *trans,
 				 struct btrfs_root *root,
 				 struct btrfs_path *path,
 				 struct btrfs_extent_inline_ref *iref,
-				 int refs_to_drop, int is_data, int *last_ref)
+				 int refs_to_drop, int is_data)
 {
 	int ret = 0;
 
 	BUG_ON(!is_data && refs_to_drop != 1);
-	if (iref) {
-		update_inline_extent_backref(path, iref, -refs_to_drop, NULL,
-					     last_ref);
-	} else if (is_data) {
-		ret = remove_extent_data_ref(trans, root, path, refs_to_drop,
-					     last_ref);
-	} else {
-		*last_ref = 1;
+	if (iref)
+		update_inline_extent_backref(path, iref, -refs_to_drop, NULL);
+	else if (is_data)
+		ret = remove_extent_data_ref(trans, root, path, refs_to_drop);
+	else
 		ret = btrfs_del_item(trans, root, path);
-	}
 	return ret;
 }
 
@@ -2943,7 +2936,6 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	u64 refs;
 	u64 bytenr = node->bytenr;
 	u64 num_bytes = node->num_bytes;
-	int last_ref = 0;
 	bool skinny_metadata = btrfs_fs_incompat(info, SKINNY_METADATA);
 
 	extent_root = btrfs_extent_root(info, bytenr);
@@ -3010,8 +3002,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			}
 			/* Must be SHARED_* item, remove the backref first */
 			ret = remove_extent_backref(trans, extent_root, path,
-						    NULL, refs_to_drop, is_data,
-						    &last_ref);
+						    NULL, refs_to_drop, is_data);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
 				goto out;
@@ -3136,8 +3127,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		}
 		if (found_extent) {
 			ret = remove_extent_backref(trans, extent_root, path,
-						    iref, refs_to_drop, is_data,
-						    &last_ref);
+						    iref, refs_to_drop, is_data);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
 				goto out;
@@ -3182,7 +3172,6 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			}
 		}
 
-		last_ref = 1;
 		ret = btrfs_del_items(trans, extent_root, path, path->slots[0],
 				      num_to_del);
 		if (ret) {
-- 
2.26.3

