Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8DA4C1B68
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Feb 2022 20:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244138AbiBWTHY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Feb 2022 14:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244139AbiBWTHW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Feb 2022 14:07:22 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176D133A14
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Feb 2022 11:06:54 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id d84so5202401qke.8
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Feb 2022 11:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wcESVMOgK2q6rOIlehEcwryBQW0f2UHkj6B3CPhnAug=;
        b=q3xNmxZCd2sMCeVqccihmp/4apKfbO9MAdqIUkSX9WeT26B06Xgj10LN4iSQZfLVqK
         r7UwyzueqjUZ6cwB+UIqRXv+Ks1d8Z9CPrbz9uDd4RIQotAOCmv1FE6AnQqQSJB50Gnd
         6TCgbOzAb6v+1bly8RixqHTUbTnxw0P3zJMtF4N3mGI0w5k8kLfoEsT7qd82budI2u3b
         DMfzrEHc/QVVlFzAR0QYS8DNq7z5HBfO1A0JxOVAg8Qzx15auo548HWP6JnVYYGnKZJQ
         QhUE4dkg7LQDbxZ8HkjMKV0pWSNopHrpnyE9/WBBdrdKqqAcE+czfQYuGUUy3hAeCejH
         36lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wcESVMOgK2q6rOIlehEcwryBQW0f2UHkj6B3CPhnAug=;
        b=cdAjSiBRjkROhzPdX6enULir9yyLM8ii63nzIzQtMIsdzgt5wLqr7i76LMaRpqY7U8
         NeHdQ0YTPMTWtU4tjf5uX+H8hArk15O+4ogrpGnOZxDuDzF7HzWjMpvdbDfrQDLdOUcv
         qnm8CTRwoEATjEyuQTfNTyXRmX9f3JQlTMC61q/bHd19byHF/GOwKntcW7/yCjr5cGej
         80bto++daMah6qKREMzrGQDibtMuHOOcg9R5J8O0GjBXLcDKT9ZGV/M42HZvQoipAA9k
         NIgDPD2nbpy4Cnd0fUEYFBo9ZK4lr8Is0Xj0GGBasNElA/2V6yzalQS7VTwP+1vEWLcE
         JTOQ==
X-Gm-Message-State: AOAM5307DWZdEJ+25gjBoBHpB9YR6RLAKMNaICwma5YgiIKwJygs/NdC
        ovJjFdKk4NUIPPlNj/TYFWTl+MW0SdJJL2+a
X-Google-Smtp-Source: ABdhPJy5s6bQh9v1ySIJutt24xh253yFISqc9x6TxnwNiY2EBcaMjmgGYxVhw4KCdiJbcXMkFpGl3A==
X-Received: by 2002:ae9:dd47:0:b0:507:a35:6cb8 with SMTP id r68-20020ae9dd47000000b005070a356cb8mr772972qkf.676.1645643212935;
        Wed, 23 Feb 2022 11:06:52 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h23sm262363qto.36.2022.02.23.11.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:06:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/4] btrfs: remove `last_ref` from the extent freeing code
Date:   Wed, 23 Feb 2022 14:06:45 -0500
Message-Id: <58a2bf7403b10ba1d0da1647504b5ee10812c077.1645643109.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645643109.git.josef@toxicpanda.com>
References: <cover.1645643109.git.josef@toxicpanda.com>
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

This is a remnant of the work I did for qgroups a long time ago to only
run for a block when we had dropped the last ref.  We haven't done that
for years, but the code remains.  Drop this remnant.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2738af449767..4ec03d004040 100644
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
 
@@ -2942,7 +2935,6 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	u64 refs;
 	u64 bytenr = node->bytenr;
 	u64 num_bytes = node->num_bytes;
-	int last_ref = 0;
 	bool skinny_metadata = btrfs_fs_incompat(info, SKINNY_METADATA);
 
 	extent_root = btrfs_extent_root(info, bytenr);
@@ -3009,8 +3001,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			}
 			/* Must be SHARED_* item, remove the backref first */
 			ret = remove_extent_backref(trans, extent_root, path,
-						    NULL, refs_to_drop, is_data,
-						    &last_ref);
+						    NULL, refs_to_drop, is_data);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
 				goto out;
@@ -3135,8 +3126,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		}
 		if (found_extent) {
 			ret = remove_extent_backref(trans, extent_root, path,
-						    iref, refs_to_drop, is_data,
-						    &last_ref);
+						    iref, refs_to_drop, is_data);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
 				goto out;
@@ -3181,7 +3171,6 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			}
 		}
 
-		last_ref = 1;
 		ret = btrfs_del_items(trans, extent_root, path, path->slots[0],
 				      num_to_del);
 		if (ret) {
-- 
2.26.3

