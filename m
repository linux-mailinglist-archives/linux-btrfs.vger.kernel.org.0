Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A634469F8
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbhKEUsl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhKEUsk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:48:40 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D2DC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:46:00 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g13so7880094qtk.12
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8CZlK/mVRjCE83Floj+bdzaWZVtmNB/g8tMTKubriWc=;
        b=g7g7f7nzCm78efB/ozeAqi4d8ih1IIXRTZDPqj5wyd3AkZHfDruk30WzAng78nngA4
         7wuh/GC9n3mu0h4LmN8ZBa4aPSFH+Y65t51PmK70g0m1WXjQLav2/JzSinWePtYUwkcI
         QwOVw+sfxmPIaL0937uaCE7qJo/2uNL9q4YJ9o3c6wjQycdoHnmTuNFTMKCOv5y0ByJM
         Y9yKPnVXzQ9P0Q0ooCYfTQFh0P+N8EwAXv6sI+bdY2h89YhNSTaRN19BzzX+tsutyimQ
         RpC1FvpXmMiIvhuWTmP0q4mVDRxGRZbN8uT885BqHK5eCkpnNetXy+u9e1EGlzw22ZLo
         jvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8CZlK/mVRjCE83Floj+bdzaWZVtmNB/g8tMTKubriWc=;
        b=ssMwBn4AV5RkA5pvBCVUS1lbEk0NscQnt260a7Q/OVt5eaxh2FO5T+rJaKb9J2aRmT
         7796IhkeQ4VZXoTDBlBA59zVQYpZ4n6uHXixqvCFa3427DLTZo6pxZ6n7cqtFsg+S1l0
         mSZ55vppl9XYGTIRdrQyGFEHAmNgdewmck3J6D8bEB6/JfGI9daaXpjZiS5p6PH3PZ1n
         mCeAsd26rmBAD2AHam//f0or5S8igMm7HHDMJfMnGlROF/d0Ls6sXdm/gm4Gw7FqrbjK
         i0lmcHU/npkEZQ/LJ/gd75yNn2rGAEJT1wx0MSnKFiNWVlym85HkLt24AlF3I6ZYPrtS
         lTbw==
X-Gm-Message-State: AOAM531NqfJgPPFC9B20uDsrhgkLlUmDv4We3Viuu9RhqajynZH87fml
        3m65vKwTwsAeya/kDwo2u0RB5REXDK2PKw==
X-Google-Smtp-Source: ABdhPJyiYF9C5aIUjsrly9JtyperJIoBhLV0H6EokdOcGmDsV9KmFRxAvKHL+EfTn0VUXY/SSboeXQ==
X-Received: by 2002:ac8:5716:: with SMTP id 22mr33119529qtw.20.1636145159740;
        Fri, 05 Nov 2021 13:45:59 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q13sm6068367qkl.7.2021.11.05.13.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:45:59 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/25] btrfs: pass the root to add_keyed_refs
Date:   Fri,  5 Nov 2021 16:45:31 -0400
Message-Id: <c45818a51dc912d2f61dc05ce8944ee69c23b2dd.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We pass in the path, but use btrfs_next_item() using the root we
searched with.  Pass the root down to add_keyed_refs() instead of the
fs_info so we can continue to use the same root we searched with.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index f735b8798ba1..53140f6ba78a 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1049,12 +1049,12 @@ static int add_inline_refs(const struct btrfs_fs_info *fs_info,
  *
  * Returns 0 on success, <0 on error, or BACKREF_FOUND_SHARED.
  */
-static int add_keyed_refs(struct btrfs_fs_info *fs_info,
+static int add_keyed_refs(struct btrfs_root *extent_root,
 			  struct btrfs_path *path, u64 bytenr,
 			  int info_level, struct preftrees *preftrees,
 			  struct share_check *sc)
 {
-	struct btrfs_root *extent_root = fs_info->extent_root;
+	struct btrfs_fs_info *fs_info = extent_root->fs_info;
 	int ret;
 	int slot;
 	struct extent_buffer *leaf;
@@ -1170,6 +1170,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 			     struct ulist *roots, const u64 *extent_item_pos,
 			     struct share_check *sc, bool ignore_offset)
 {
+	struct btrfs_root *root = fs_info->extent_root;
 	struct btrfs_key key;
 	struct btrfs_path *path;
 	struct btrfs_delayed_ref_root *delayed_refs = NULL;
@@ -1211,7 +1212,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 again:
 	head = NULL;
 
-	ret = btrfs_search_slot(NULL, fs_info->extent_root, &key, path, 0, 0);
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
 		goto out;
 	BUG_ON(ret == 0);
@@ -1271,7 +1272,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 					      &info_level, &preftrees, sc);
 			if (ret)
 				goto out;
-			ret = add_keyed_refs(fs_info, path, bytenr, info_level,
+			ret = add_keyed_refs(root, path, bytenr, info_level,
 					     &preftrees, sc);
 			if (ret)
 				goto out;
-- 
2.26.3

