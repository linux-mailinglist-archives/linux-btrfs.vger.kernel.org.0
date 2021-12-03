Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363BC467FCF
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383394AbhLCWWB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383382AbhLCWV6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 17:21:58 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7304C061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 14:18:33 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 132so4966656qkj.11
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=imd6Mj5IpmPkMiVMmMNXrKBaVIdTu+C67zcm03S8NXA=;
        b=r64bE6UjeMJuxFWOwyfDtRJbGLddU5iTlG6wL6jSb37unjYN53z9fP4VwS0LNjqPYu
         GPb98fEmNco001Cjy+hFJn6kgN3yBIGowmKSkQgMg9zhoaiRZY+xJXBSpqSUdQJpXVyc
         5LczuLg/+WtUwqkovIn0CF55ao0Wr6hhOa/imxkVkgtUZPL4Cye1h4m5j1MrtG0Mayaz
         GOuIn4ap9Y5V9FeynGbUf3YEI9TGEDnvkMszRmulEVXL4g1xGFse2CGiCIKYZVzO1W/f
         6FV1AZniYQmruDCJg2DIF+gaxZquo/k/FZWMeCzyvqVaORyC0zlRTTzz14KkRS2TcZZB
         ZnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=imd6Mj5IpmPkMiVMmMNXrKBaVIdTu+C67zcm03S8NXA=;
        b=avOQD4+j1wmuGEqwDoq48TmpzTbpP4Hoqm/01Cd5PJaOWldfTxIL8Wu+hAMsACfDol
         3OLSlPThBM/TwAPBVmPa4HIEZ2j+9hY2LjS/JBi++V6yyTCGcViubnwfEraoOA+9sQE1
         kQxq/8564+Jf/1MvIwJvV7/z2h5F7SgigX2p5br9cYjxYQgnGrZ+RELjAHJIOqeor4lH
         CD6QPT4QvSa6bmEhAo3YbaCq8SfrCx6xaNE+8uBxUyoygM4hnmgWPL3SK/x8sWj/nZFR
         4p0LWttvd3NbGDzmjaI8JN4xtDD/rq0WEnPqVKde8jj9xpDzkxsN4FYjDmvlurnSORNk
         EO0g==
X-Gm-Message-State: AOAM530ErD4tBobwUdhJpZD+qsbFiSkekeeNMmcVoRWthS6BVg29Aajc
        pjwf0Bh6tLlTGQ+B7L+vnJb8rgQJ6StP1Q==
X-Google-Smtp-Source: ABdhPJzflypNss+/7nuaAYu4O62o53NrP+hcNN40wiO8+kNQTj3KUFv6RNhME4KIYBdQArvOSG4w+g==
X-Received: by 2002:a05:620a:13f9:: with SMTP id h25mr20277720qkl.99.1638569912726;
        Fri, 03 Dec 2021 14:18:32 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d16sm2999337qtn.59.2021.12.03.14.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:18:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/18] btrfs: only call inode_sub_bytes in truncate paths that care
Date:   Fri,  3 Dec 2021 17:18:11 -0500
Message-Id: <7ad98c17758eb33c309a3c453927a94ed9ea4264.1638569556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638569556.git.josef@toxicpanda.com>
References: <cover.1638569556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We currently have a bunch of awkward checks to make sure we only update
the inode i_bytes if we're truncating the real inode.  Instead keep
track of the number of bytes we need to sub in the
btrfs_truncate_control, and then do the appropriate adjustment in the
truncate paths that care.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/free-space-cache.c |  1 +
 fs/btrfs/inode-item.c       | 20 ++++++--------------
 fs/btrfs/inode-item.h       |  3 +++
 fs/btrfs/inode.c            |  1 +
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index fd469beb0985..d2f4716f8485 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -339,6 +339,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 	 */
 	ret = btrfs_truncate_inode_items(trans, root, inode, &control);
 
+	inode_sub_bytes(&inode->vfs_inode, control.sub_bytes);
 	btrfs_inode_safe_disk_i_size_write(inode, control.last_size);
 
 	unlock_extent_cached(&inode->io_tree, 0, (u64)-1, &cached_state);
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 15dc5352d08a..ebbe4054ae93 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -466,6 +466,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	BUG_ON(new_size > 0 && control->min_type != BTRFS_EXTENT_DATA_KEY);
 
 	control->last_size = new_size;
+	control->sub_bytes = 0;
 
 	/*
 	 * For shareable roots we want to back off from time to time, this turns
@@ -577,11 +578,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 							 extent_num_bytes);
 				num_dec = (orig_num_bytes -
 					   extent_num_bytes);
-				if (test_bit(BTRFS_ROOT_SHAREABLE,
-					     &root->state) &&
-				    extent_start != 0)
-					inode_sub_bytes(&inode->vfs_inode,
-							num_dec);
+				if (extent_start != 0)
+					control->sub_bytes += num_dec;
 				btrfs_mark_buffer_dirty(leaf);
 			} else {
 				extent_num_bytes =
@@ -592,12 +590,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 
 				/* FIXME blocksize != 4096 */
 				num_dec = btrfs_file_extent_num_bytes(leaf, fi);
-				if (extent_start != 0) {
-					if (test_bit(BTRFS_ROOT_SHAREABLE,
-						     &root->state))
-						inode_sub_bytes(&inode->vfs_inode,
-								num_dec);
-				}
+				if (extent_start != 0)
+					control->sub_bytes += num_dec;
 			}
 			clear_len = num_dec;
 		} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
@@ -630,9 +624,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 				clear_len = fs_info->sectorsize;
 			}
 
-			if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
-				inode_sub_bytes(&inode->vfs_inode,
-						item_end + 1 - new_size);
+			control->sub_bytes += item_end + 1 - new_size;
 		}
 delete:
 		/*
diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
index 21adab1df4e5..771e264a2ede 100644
--- a/fs/btrfs/inode-item.h
+++ b/fs/btrfs/inode-item.h
@@ -19,6 +19,9 @@ struct btrfs_truncate_control {
 	/* OUT: the last size we truncated this inode to. */
 	u64 last_size;
 
+	/* OUT: the number of bytes to sub from this inode. */
+	u64 sub_bytes;
+
 	/*
 	 * IN: minimum key type to remove.  All key types with this type are
 	 * removed only if their offset >= new_size.
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 23b47c7bce0f..306d410b4db4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8621,6 +8621,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 		ret = btrfs_truncate_inode_items(trans, root, BTRFS_I(inode),
 						 &control);
 
+		inode_sub_bytes(inode, control.sub_bytes);
 		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode),
 						   control.last_size);
 
-- 
2.26.3

