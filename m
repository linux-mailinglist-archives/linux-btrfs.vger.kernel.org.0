Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970D647639A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbhLOUny (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbhLOUnx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:43:53 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76924C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:43:53 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id p19so23140590qtw.12
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=M/E/UrOHwsjH8xoaWJXfduL+sNZo7/CMQm3HP8J44K8=;
        b=RHVGpGMoaVbBqHGibmTJuXNxwyPhMLzwEwBPLTy5wVW2biYpFn1lWz9GstuR7z9eQ8
         zeP+acU/2KqhUDmQ5wrDDBwVwxSsCfIvd390187C6Y3xB/r4z+bTazhibBt7xpRH6t6k
         lWAsQm6uuErwj8b706dUn3c+TnbiX8CBS/hOGY3gWTQoqLucoqQQTLt+qLw34PGTHZDR
         7BEynCXQ1LQLfAixiF+Zv1blNbZj0UHpXYzgu5vsp1yWRPdU9sgYKtsubUBnsrm0NE+4
         L6icx+CO/BChfC15r25SNAfDIjMYVpGyJN6Qn5Tq2t2CPP49GEpVjmh+J1eaZ+aNCWS3
         W7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M/E/UrOHwsjH8xoaWJXfduL+sNZo7/CMQm3HP8J44K8=;
        b=VTJ9kQlnRYS3F3m2EGxuHRq+SlZVwV6dWMNYx4Gao6/xlR1ce6V6sICNwTMO/VKLBH
         imm9gR7xtwBN/RPLadQRYbF2pBwj6XiM1k4nbWsCpaVFoBYZN/wDAXy5LLlYJU2lI3Qv
         R/S2mPS5PizcceUf1Du3oSx3s/bjd3o3XNbmrOf8YT3iWhcXhBpqkEq7N4obSJND8rAR
         3ViqxXjlTue0+eyD0sQzvlT3+Td3JQtsChj7ZKsf+kyiPcSP4CU/jxbF8krBVpPNWoV1
         BYaY3f3AkYOtPeT5B/PtIoozwk3Ef5/5emJopEq8qDWy8bLe0eUvfbuTqjxg0Z2rzXUA
         W28Q==
X-Gm-Message-State: AOAM533WlX3IErqs46Sy4uVeqXMyrG2FJ3HHm5T4NU5ggRA0Pzlwvuk7
        aWRzwf8UhjsCMltKdtBIy8UUrtAT46yB1w==
X-Google-Smtp-Source: ABdhPJxxOkRO/NFcMJmk/13D8x/EZoNNGLlHEQ2/zlqJpaNXzZLgW7QU8T0g5QTF2zChT2RYPNXptg==
X-Received: by 2002:a05:622a:1a9e:: with SMTP id s30mr14212160qtc.111.1639601032342;
        Wed, 15 Dec 2021 12:43:52 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x13sm1828814qkp.102.2021.12.15.12.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:43:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/9] btrfs: add a do_free_extent_accounting helper
Date:   Wed, 15 Dec 2021 15:43:40 -0500
Message-Id: <0c9e9fe88eecfe232cd42bb91d43f1f5f07aed56.1639600854.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639600854.git.josef@toxicpanda.com>
References: <cover.1639600854.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

__btrfs_free_extent() does all of the hard work of updating the extent
ref items, and then at the end if we dropped the extent completely it
does the cleanup accounting work.  We're going to only want to do that
work for metadata with extent tree v2, so extract this bit into its own
helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 53 ++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 4bd238ae0753..0c1988a7f845 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2855,6 +2855,35 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 	return 0;
 }
 
+static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
+				     u64 bytenr, u64 num_bytes, bool is_data)
+{
+	int ret;
+
+	if (is_data) {
+		struct btrfs_root *csum_root;
+		csum_root = btrfs_csum_root(trans->fs_info, bytenr);
+		ret = btrfs_del_csums(trans, csum_root, bytenr,
+				      num_bytes);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+	}
+
+	ret = add_to_free_space_tree(trans, bytenr, num_bytes);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
+	ret = btrfs_update_block_group(trans, bytenr, num_bytes, false);
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
+
+	return ret;
+}
+
 /*
  * Drop one or more refs of @node.
  *
@@ -3180,28 +3209,8 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		}
 		btrfs_release_path(path);
 
-		if (is_data) {
-			struct btrfs_root *csum_root;
-			csum_root = btrfs_csum_root(info, bytenr);
-			ret = btrfs_del_csums(trans, csum_root, bytenr,
-					      num_bytes);
-			if (ret) {
-				btrfs_abort_transaction(trans, ret);
-				goto out;
-			}
-		}
-
-		ret = add_to_free_space_tree(trans, bytenr, num_bytes);
-		if (ret) {
-			btrfs_abort_transaction(trans, ret);
-			goto out;
-		}
-
-		ret = btrfs_update_block_group(trans, bytenr, num_bytes, false);
-		if (ret) {
-			btrfs_abort_transaction(trans, ret);
-			goto out;
-		}
+		ret = do_free_extent_accounting(trans, bytenr, num_bytes,
+						is_data);
 	}
 	btrfs_release_path(path);
 
-- 
2.26.3

