Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DA74654FB
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238868AbhLASTP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244368AbhLASTB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:19:01 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58289C0613DD
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:15:23 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id z9so24949834qtj.9
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hYC736ztLtlhoIe941WFg2Z0cC7bUKCUrEBNVCna6D0=;
        b=GjpEh3KHUU8SNsq5ULYB6BKbB8N/MPmEERF3jGOflZJXdJwAnFu+A36E7zbCs4yjOf
         2wmc0xi8bq8HgjmgqXxPXLI96ccvIOcLgTvYhm1GZdzsSQyMgSpzHasieO9r7vgGzRFx
         Wd19shZ/JmeAPU8hokAEB6u30GZrTERz6mEg+Jz5K1y+SvwnpV1U3TNltzgORzZ1b4Ua
         Y95DzvBWB1ehF55G7PsP3LHT+Hrrk+NC3XCrIk1JcTvnt4I3UKCpkYIgmlda3zSbwnML
         Ho3VbnwJIcf9FndJlAjvPZzS2qia4Bb6f3cbtkUG/orW6K+0nJ5yZsGfe4F4fJf63sCJ
         s8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hYC736ztLtlhoIe941WFg2Z0cC7bUKCUrEBNVCna6D0=;
        b=NtCGuM654AAv3qBhSkCoKZpPh1q9Fie6SP5I5ZfC/+MS6CHPcy6BKSS/LkrNfkIRZJ
         1UXKMTbs47/ZEsptcXPgLh68a5iiIJKizPjGyjbRmAI+JRCOZ2hEX61YTrOXD034olB7
         sv2kpS+aEQYuF4t4TAyZsbr1TKss6lRr66d9z6p+som9k17eFqh4A52+yNmG8H6G5nfc
         rc8J2hLarSYiKZ9zC5lWBOgvqvOJsB/7sMb3UTyUvo0bTSq+eEo7sQwCoQWdzi1bxAJL
         MBMh9+0+D7ZTMsKRV1RIcYB8vZ1+cqw8sJv41H7AUOVogCgUW8DXkxN47pFCFXldDyi+
         g6Fg==
X-Gm-Message-State: AOAM531elpE5zwmm9OjhDCu8XG2hVJ1RoudDQ9OUvPdtOMCb+fGIkflC
        gBj+BxHCqO1ZXX7wgZCEWbmZqU7F0/tyNA==
X-Google-Smtp-Source: ABdhPJzsNE86mUQLGJCSQGzH9/0P2lV5tsROKy55K6r/QP5uVgxoCGvWVsGmMrRGSNNWwTenK1e/nw==
X-Received: by 2002:ac8:5a91:: with SMTP id c17mr9408201qtc.73.1638382522314;
        Wed, 01 Dec 2021 10:15:22 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p1sm225429qke.109.2021.12.01.10.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:15:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 7/8] btrfs-progs: check: fill csum root from all extent roots
Date:   Wed,  1 Dec 2021 13:15:09 -0500
Message-Id: <6228f313182b80f59a540f2dc2c01f41828aceae.1638382443.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638382443.git.josef@toxicpanda.com>
References: <cover.1638382443.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We may have multiple extent roots, so cycle through all of the extent
roots and populate the csum tree based on the content of every extent
root we have in the file system.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/check/main.c b/check/main.c
index 337ab82f..5d1eed52 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9703,9 +9703,9 @@ out:
 	return ret;
 }
 
-static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans)
+static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans,
+				      struct btrfs_root *extent_root)
 {
-	struct btrfs_root *extent_root = btrfs_extent_root(gfs_info, 0);
 	struct btrfs_root *csum_root;
 	struct btrfs_path path;
 	struct btrfs_extent_item *ei;
@@ -9779,10 +9779,26 @@ static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans)
 static int fill_csum_tree(struct btrfs_trans_handle *trans,
 			  int search_fs_tree)
 {
+	struct btrfs_root *root;
+	struct rb_node *n;
+	int ret;
+
 	if (search_fs_tree)
 		return fill_csum_tree_from_fs(trans);
-	else
-		return fill_csum_tree_from_extent(trans);
+
+	root = btrfs_extent_root(gfs_info, 0);
+	while (1) {
+		ret = fill_csum_tree_from_extent(trans, root);
+		if (ret)
+			break;
+		n = rb_next(&root->rb_node);
+		if (!n)
+			break;
+		root = rb_entry(n, struct btrfs_root, rb_node);
+		if (root->root_key.objectid != BTRFS_EXTENT_TREE_OBJECTID)
+			break;
+	}
+	return ret;
 }
 
 static void free_roots_info_cache(void)
-- 
2.26.3

