Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 059361412ED
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgAQV1E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:27:04 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33481 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbgAQV1B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:27:01 -0500
Received: by mail-qk1-f196.google.com with SMTP id d71so24192454qkc.0
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FwNTEst1m2U3SR0GtEueCY9s2aSODxSlAQjE0Suamz0=;
        b=JXs24EfAnLw5+VKds9Kd+N2Awyr/l5YEuWfp9DVYpuwxIMz24e41LAWH7+YBpdemgT
         zZ6ezpjUMezOhrIXzEOkDlurwBbxoZIpQ7H6RrdB6Vt70wvSrLiU0CtKzqqMilogF330
         X8mLN9xPlJZFqjBRKbHvvcAB0Ckle7R7FIPtaKOhkzrwAClrlo8/evMmdzKnaHf/GwC6
         1vudEMkfUkmyEB2znu+0tbKnmWU5pjVH6hAiCN9/wjgb1Em13SsjxU5SUdxXaajxQZTy
         tnOKzCXDtovWIqc5jpXIzULhMmala5YWAWhYvKVvsCK0TfPeHSLldL9h6FeCP/KuULcS
         1xGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FwNTEst1m2U3SR0GtEueCY9s2aSODxSlAQjE0Suamz0=;
        b=BIFldc+wRbYvWDEJVxuLaml6SWN6y68eGq/CNWd9aCZDaheVm3Q9UOjlgjv/dMl7Ws
         XANNgr0KeRgb/Y+0Lly4I+E5L1YgtTYKOTw3plrADzeZDK+iYLquSaYKGJabygP5En4W
         JxBfe9YgLHIMfETgw8ASgfrgOxOk7RD/Q1Op54RhW9xXUBBmb/YN2dFpLpmrR0znwLvU
         sytMkT3o8D42EvjSmjJrFaI/RaHv5WtSyYYYScqHKicGgSHHkPEOuurBt0tsiwniYHkS
         ubXt79TGnMpbABtSzCUePG2fpuH47IYJLSNScxYwLJXW8a2t0hscceuN8FeZGTxuhIgC
         vO6A==
X-Gm-Message-State: APjAAAVN4z8IEH/ZlYiyntptPeau/HRZZGzkbnDjdzWMT6edXIeWzN7p
        l7Mcf0Nz+TozpMg+/Sur6OU56KmZCesGQw==
X-Google-Smtp-Source: APXvYqx9OqFsMN/L+XSnbmyyxaRWpIUoS42WuiGDxobLMl+aGNI3KA6DPUHn+6fsub+5ehpMOWcAdA==
X-Received: by 2002:a37:2f47:: with SMTP id v68mr34316738qkh.217.1579296419854;
        Fri, 17 Jan 2020 13:26:59 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o9sm12544510qko.16.2020.01.17.13.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 31/43] btrfs: hold a ref on the root in btrfs_ioctl_send
Date:   Fri, 17 Jan 2020 16:25:50 -0500
Message-Id: <20200117212602.6737-32-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
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

