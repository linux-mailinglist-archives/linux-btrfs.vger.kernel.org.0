Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE73A14894C
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404592AbgAXOeB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:34:01 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:39341 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390591AbgAXOd7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:59 -0500
Received: by mail-qv1-f66.google.com with SMTP id y8so980197qvk.6
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FwNTEst1m2U3SR0GtEueCY9s2aSODxSlAQjE0Suamz0=;
        b=OIvCKI0XAUnZYIAEZSHe70k6bA83h9mkUyNAg3cnN6Ym5OTQRXfTXG5sRoYUe5XeI0
         u2t1U4VsDWZyTdG5P05hABfnV8w/5SjS6VQzHtH6SDonxgr1tl8WvM9v6xd1D5dpxPU/
         b2zjuaFuE5tV/QrQo36BbxJOKthMsjAbyost/qeH05f3g/ARuDyifsXtqs+NqXL1KmXY
         NySzV4iYK3RFRnLH4BuTNuDk+D06dC+cetHG5fSq6eYjQ0HPi5xy5HVWswXWxnaXOAFL
         rPrmwV5QrgY/11zfgg3be4fBwAR6FR4YaMG9MWN0Cjbgn1H6iDbkMk1ihXeNR3MGZk1e
         Ov1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FwNTEst1m2U3SR0GtEueCY9s2aSODxSlAQjE0Suamz0=;
        b=WaUsCEZGWEva8Y/OFjAYbitT6Z81Ti51TLQPPmWm+e6hU5hio+h1KY92xiTGLm+dwr
         O8u93Xgsgk7bUVfZ70eT41oJfECPOBUKZmac3UeeQ1f3UzfHbcGp2ALp+/u2I9wlppDg
         MJepyh1f2IZBeeN70+vheryAIYuSLXx9z9Muu6pdF2dx02nmG3p/cziROG3u3p6Shmaa
         beBBKETKA1l9F08QH9zngLn2FZdslM7/z/844EDXerxOgFfPP4ElysOGflHaY1nEifmg
         WSRcEc5Ad0WCSVCOKBh/R1JWapMTWHmZEmLHJ55KjiQrbzvmTjECKcWrXgxSfpvKqUcH
         MkjA==
X-Gm-Message-State: APjAAAU1GZog80TLoRwxs/ghuPLN0sXAEAw/xxoCqOOsI8zW8jc/eUuZ
        lV8Rxa+kZY9rpTe56UP872tNqw==
X-Google-Smtp-Source: APXvYqzqqJ5e45355axcDm5ZgavQdMWfjVvAEHXQGY22H8/iU8crNWpRzuzk1B3sR1S0b/RftehLkA==
X-Received: by 2002:a0c:c28e:: with SMTP id b14mr3101561qvi.72.1579876438131;
        Fri, 24 Jan 2020 06:33:58 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d25sm3209705qtq.11.2020.01.24.06.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:57 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 31/44] btrfs: hold a ref on the root in btrfs_ioctl_send
Date:   Fri, 24 Jan 2020 09:32:48 -0500
Message-Id: <20200124143301.2186319-32-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We lookup all the clone roots and the parent root for send, so we need
to hold refs on all of these roots while we're processing them.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/send.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 57eae56dd743..ee2fc9ea9d7e 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7200,11 +7200,17 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 				ret = PTR_ERR(clone_root);
 				goto out;
 			}
+			if (!btrfs_grab_fs_root(clone_root)) {
+				srcu_read_unlock(&fs_info->subvol_srcu, index);
+				ret = -ENOENT;
+				goto out;
+			}
 			spin_lock(&clone_root->root_item_lock);
 			if (!btrfs_root_readonly(clone_root) ||
 			    btrfs_root_dead(clone_root)) {
 				spin_unlock(&clone_root->root_item_lock);
 				srcu_read_unlock(&fs_info->subvol_srcu, index);
+				btrfs_put_fs_root(clone_root);
 				ret = -EPERM;
 				goto out;
 			}
@@ -7212,6 +7218,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 				dedupe_in_progress_warn(clone_root);
 				spin_unlock(&clone_root->root_item_lock);
 				srcu_read_unlock(&fs_info->subvol_srcu, index);
+				btrfs_put_fs_root(clone_root);
 				ret = -EAGAIN;
 				goto out;
 			}
@@ -7239,6 +7246,12 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 			ret = PTR_ERR(sctx->parent_root);
 			goto out;
 		}
+		if (!btrfs_grab_fs_root(sctx->parent_root)) {
+			srcu_read_unlock(&fs_info->subvol_srcu, index);
+			ret = -ENOENT;
+			sctx->parent_root = ERR_PTR(ret);
+			goto out;
+		}
 
 		spin_lock(&sctx->parent_root->root_item_lock);
 		sctx->parent_root->send_in_progress++;
@@ -7266,7 +7279,8 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	 * is behind the current send position. This is checked while searching
 	 * for possible clone sources.
 	 */
-	sctx->clone_roots[sctx->clone_roots_cnt++].root = sctx->send_root;
+	sctx->clone_roots[sctx->clone_roots_cnt++].root =
+		btrfs_grab_fs_root(sctx->send_root);
 
 	/* We do a bsearch later */
 	sort(sctx->clone_roots, sctx->clone_roots_cnt,
@@ -7351,18 +7365,24 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	}
 
 	if (sort_clone_roots) {
-		for (i = 0; i < sctx->clone_roots_cnt; i++)
+		for (i = 0; i < sctx->clone_roots_cnt; i++) {
 			btrfs_root_dec_send_in_progress(
 					sctx->clone_roots[i].root);
+			btrfs_put_fs_root(sctx->clone_roots[i].root);
+		}
 	} else {
-		for (i = 0; sctx && i < clone_sources_to_rollback; i++)
+		for (i = 0; sctx && i < clone_sources_to_rollback; i++) {
 			btrfs_root_dec_send_in_progress(
 					sctx->clone_roots[i].root);
+			btrfs_put_fs_root(sctx->clone_roots[i].root);
+		}
 
 		btrfs_root_dec_send_in_progress(send_root);
 	}
-	if (sctx && !IS_ERR_OR_NULL(sctx->parent_root))
+	if (sctx && !IS_ERR_OR_NULL(sctx->parent_root)) {
 		btrfs_root_dec_send_in_progress(sctx->parent_root);
+		btrfs_put_fs_root(sctx->parent_root);
+	}
 
 	kvfree(clone_sources_tmp);
 
-- 
2.24.1

