Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4324469FF
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbhKEUs5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbhKEUst (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:48:49 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9A2C06120B
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:46:09 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id u16so8070988qvk.4
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qi22l4TAYaYOCH//25fd4g9toXBPnCIefzcYDmUrsdA=;
        b=rbX72g/DzVRcttsa+eu/QiRO1Jt0oLcwUsZwQjmZt32KcM8KN92eftPAzIcnzk/6X9
         8Q6WCHhfeQ4hFvmvernGTQo98kdJVFZ38CmNvk12op7Q5kCv1b0PSeW3StFt3j3xITdJ
         YTVp8KPQFlufq/m0gi0Xxx4+ODR1BhzyQ2oltWdRmWT1gWVrHhbf9WIBVTpH3pndi6oa
         pmKV0CIrrrVJyPEXWqW765wPaaPi14APR+LuX+b4PoqflqVk7S3Spq+ArBysE9R+hpAN
         UWpAGgIRCLPnLUrZxogHESpA+7DKNb0nTsuVs0K7PFDvWMKyBjSuw1pD75aXhv7qG0QN
         5NIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qi22l4TAYaYOCH//25fd4g9toXBPnCIefzcYDmUrsdA=;
        b=J7dGG5wEh02LmcQlPiUbfbxnmEM1UGkswfqfgIVTYMxCa1u6/duUCI+lLKq//BiqbC
         9Kp/ofvS/57gMRQduKbwwjN8KHl4IPqrmsGHy6Zdf6pq0DYj8/vrnkfvoEEJpFY9DrTv
         +abVeIrAviZzq6Y355TPYaHjtKJhTd+TX83jNvNSarDl7q7bjzToawo/NhlAfsuZ9s0a
         RZAeiSxQEJuE/l2Ceh1Sb3aYjX+O+q+QiRYM2dphow7lbAOjGIxMxRcH8hpX4Y9TBTnm
         RUlwvRHg5DDGKFVMV2XFJySWKWqGPSjK79aRNGpmxJ4T98az0gmtyH1DojFaQU+/Lzw/
         K/wg==
X-Gm-Message-State: AOAM532X91eqHJ0GJ7X/RZp2go2kUBPhUoClyEB4tWiXtBJHmxXTO+eB
        2FwWhwLX53moZ3AFH3ybHgsHivqGxnUnyQ==
X-Google-Smtp-Source: ABdhPJwdPIUtJd6BxvjUnWG2PVYTr49C0GGWn0d1o7fLl/LSI3itxZDkSqI4W8I6V9pEeTfkUJJbsA==
X-Received: by 2002:a05:6214:ace:: with SMTP id g14mr20359733qvi.12.1636145168447;
        Fri, 05 Nov 2021 13:46:08 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e10sm6398269qte.57.2021.11.05.13.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:46:08 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/25] btrfs: make remove_extent_backref pass the root
Date:   Fri,  5 Nov 2021 16:45:37 -0400
Message-Id: <7424f75366a05ed0660adc5a9330580ceea987e2.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With extent tree v2 we'll have a different extent root based on where
the bytenr is located, so adjust the remove_extent_backref() helper and
it's helpers to pass the extent_root around.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3fd736a02c1e..c33f3dc6b322 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -593,6 +593,7 @@ static noinline int insert_extent_data_ref(struct btrfs_trans_handle *trans,
 }
 
 static noinline int remove_extent_data_ref(struct btrfs_trans_handle *trans,
+					   struct btrfs_root *root,
 					   struct btrfs_path *path,
 					   int refs_to_drop, int *last_ref)
 {
@@ -626,7 +627,7 @@ static noinline int remove_extent_data_ref(struct btrfs_trans_handle *trans,
 	num_refs -= refs_to_drop;
 
 	if (num_refs == 0) {
-		ret = btrfs_del_item(trans, trans->fs_info->extent_root, path);
+		ret = btrfs_del_item(trans, root, path);
 		*last_ref = 1;
 	} else {
 		if (key.type == BTRFS_EXTENT_DATA_REF_KEY)
@@ -1174,6 +1175,7 @@ int insert_inline_extent_backref(struct btrfs_trans_handle *trans,
 }
 
 static int remove_extent_backref(struct btrfs_trans_handle *trans,
+				 struct btrfs_root *root,
 				 struct btrfs_path *path,
 				 struct btrfs_extent_inline_ref *iref,
 				 int refs_to_drop, int is_data, int *last_ref)
@@ -1185,11 +1187,11 @@ static int remove_extent_backref(struct btrfs_trans_handle *trans,
 		update_inline_extent_backref(path, iref, -refs_to_drop, NULL,
 					     last_ref);
 	} else if (is_data) {
-		ret = remove_extent_data_ref(trans, path, refs_to_drop,
+		ret = remove_extent_data_ref(trans, root, path, refs_to_drop,
 					     last_ref);
 	} else {
 		*last_ref = 1;
-		ret = btrfs_del_item(trans, trans->fs_info->extent_root, path);
+		ret = btrfs_del_item(trans, root, path);
 	}
 	return ret;
 }
@@ -2996,9 +2998,9 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 				goto err_dump;
 			}
 			/* Must be SHARED_* item, remove the backref first */
-			ret = remove_extent_backref(trans, path, NULL,
-						    refs_to_drop,
-						    is_data, &last_ref);
+			ret = remove_extent_backref(trans, extent_root, path,
+						    NULL, refs_to_drop, is_data,
+						    &last_ref);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
 				goto out;
@@ -3122,8 +3124,8 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			btrfs_mark_buffer_dirty(leaf);
 		}
 		if (found_extent) {
-			ret = remove_extent_backref(trans, path, iref,
-						    refs_to_drop, is_data,
+			ret = remove_extent_backref(trans, extent_root, path,
+						    iref, refs_to_drop, is_data,
 						    &last_ref);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
-- 
2.26.3

