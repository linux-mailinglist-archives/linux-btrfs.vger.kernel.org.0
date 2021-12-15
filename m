Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32E04762E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbhLOUO6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbhLOUO6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:14:58 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE24C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:14:57 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id m25so23061811qtq.13
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NkHISBCj0ArxF11KRE/7CBbF3T2f7E1ZD2m++82RtMM=;
        b=j/7lSTBJV2iyTBnl3xeHq1I4PQ/Y/mTsgZ15dFjAxvF5wTcsr0tyfQFVSxSgVIXW4U
         FDfiYN3a/lzed/zpUCejjGuhVke7+A5FGoA3ShSxWmR2QgR6opcgIBtDmr5YpM6sbj2m
         inwqBpDXojRFdiY5/H6gQxj0cZLSr1qgW3ZbAP763cayPifDpVe0L53w0S9gMqit8WdC
         WFRWGH61p5is6f6LOlH73yV5WDJMbGnR2MP/xEITcWJ372QB+lBPMNFWeQudXJl+t8GV
         xMptDUTrszvpO1Ew4O2FRk33iFt9jLqsDT9AdhZUAI9VFKu9y5P3Ji87JUUim6RwV47m
         sy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NkHISBCj0ArxF11KRE/7CBbF3T2f7E1ZD2m++82RtMM=;
        b=ueuGNQxbApeOHRNvQz9cd+nB2d8xaCCz5DGj02VBBfOFBfvhwZr48Hd9X92nQ4nU0c
         7vk91XPcEZSXEGn3dt71giKpurxX273bWnXRWq0tUi+03xOvTVrNHjvROIoAv8jvY0BS
         L5Zx79CncMyCH0C5KfTux9gpCDxGHR1GYCqNRvVRh13Tfp8vHC0Cl1s1mNgClI9Dx5A0
         k4k1SEY9QR0N2pjlj13F3WwYVWGI/JwbrV9OGSBzlran5eWCY22lw6xrUtTVccgQexxv
         2yE5RBeGLuAFqG69zWy61FLqBkj95jb/uYbcxRbzp4zmp03sP65LbNA7dtHRlZQKrgz7
         eE/Q==
X-Gm-Message-State: AOAM533s2O1qCn5wUbpza1lxjqDzp3YK03r/4I292eun+XUJ+tzn/weo
        nV1KqtWmwHtUthCz2aNDwO0PCxDTxk1EvA==
X-Google-Smtp-Source: ABdhPJzrZWzYsPV0UwRdn+Vq+MjzB0mi7fDz/vmu2WUDxNO/KTHEDod5jxgBHLnNOWcVK3YiZ4gNNg==
X-Received: by 2002:a05:622a:1a1c:: with SMTP id f28mr13848031qtb.308.1639599296693;
        Wed, 15 Dec 2021 12:14:56 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q12sm2278562qtx.16.2021.12.15.12.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:14:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/15] btrfs-progs: extract out free extent accounting handling
Date:   Wed, 15 Dec 2021 15:14:39 -0500
Message-Id: <94d0edde14356cd695f7ab7efd24fe209afc4a7c.1639598612.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598612.git.josef@toxicpanda.com>
References: <cover.1639598612.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

__free_extent() currently handles the modification of the tree, but also
the accounting and cleaning up when we free the extent properly.
Extract the accounting portion out into it's own helper so it can be
used in the future.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent-tree.c | 45 +++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 1469f5c3..1af3eb06 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1905,6 +1905,30 @@ void btrfs_unpin_extent(struct btrfs_fs_info *fs_info,
 	update_pinned_extents(fs_info, bytenr, num_bytes, 0);
 }
 
+static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
+				     u64 bytenr, u64 num_bytes, bool is_data)
+{
+	int ret, mark_free = 0;
+
+	ret = pin_down_bytes(trans, bytenr, num_bytes, is_data);
+	if (ret > 0)
+		mark_free = 1;
+	else if (ret < 0)
+		return ret;
+
+	if (is_data) {
+		ret = btrfs_del_csums(trans, bytenr, num_bytes);
+		if (ret)
+			return ret;
+	}
+
+	ret = add_to_free_space_tree(trans, bytenr, num_bytes);
+	if (ret)
+		return ret;
+	update_block_group(trans, bytenr, num_bytes, 0, mark_free);
+	return ret;
+}
+
 /*
  * remove an extent from the root, returns 0 on success
  */
@@ -2075,8 +2099,6 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 			BUG_ON(ret);
 		}
 	} else {
-		int mark_free = 0;
-
 		if (found_extent) {
 			BUG_ON(is_data && refs_to_drop !=
 			       extent_data_ref_count(path, iref));
@@ -2089,28 +2111,13 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 			}
 		}
 
-		ret = pin_down_bytes(trans, bytenr, num_bytes,
-				     is_data);
-		if (ret > 0)
-			mark_free = 1;
-		BUG_ON(ret < 0);
-
 		ret = btrfs_del_items(trans, extent_root, path, path->slots[0],
 				      num_to_del);
 		BUG_ON(ret);
 		btrfs_release_path(path);
 
-		if (is_data) {
-			ret = btrfs_del_csums(trans, bytenr, num_bytes);
-			BUG_ON(ret);
-		}
-
-		ret = add_to_free_space_tree(trans, bytenr, num_bytes);
-		if (ret) {
-			goto fail;
-		}
-
-		update_block_group(trans, bytenr, num_bytes, 0, mark_free);
+		ret = do_free_extent_accounting(trans, bytenr, num_bytes, is_data);
+		BUG_ON(ret);
 	}
 fail:
 	btrfs_free_path(path);
-- 
2.26.3

