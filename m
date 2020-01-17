Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8259140B7E
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgAQNsz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:55 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34525 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbgAQNsz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:55 -0500
Received: by mail-qt1-f193.google.com with SMTP id 5so21798891qtz.1
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FwNTEst1m2U3SR0GtEueCY9s2aSODxSlAQjE0Suamz0=;
        b=LrubESjbgQel3gP6MP2NlooeR3fJ+FKEEbNYR/pLtCCy4ypslT7r2Hmox9RXrfXCw1
         A/iQkdhX1EN1j+CmL8mPcodCtk3XUzbSxlqPOVJtu1AnGIeX9moxNFwoxw2F3NMjMBj/
         P2x7GiK4yFKGr0+vOVfYZwQ2ZtBzWMoQYhZ3ryK47BPulfvI5f1zdff1EC2+pSlqoFfC
         3nFewBGMVBz9SuAxDVr1xNRpe1f0V/6GdEM+7xyNxoVxGY4fsb7ETghIz+WiffaBs70G
         pEwoWaYf7cX1JDg/igj2qOvadrx8nVkcBYpvIJhLN6hvRH+ZwDs+r/fvPn+fgA8hMAjF
         LzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FwNTEst1m2U3SR0GtEueCY9s2aSODxSlAQjE0Suamz0=;
        b=TdcewE0eRN01mK6M0fiDKfFFPaWo5Xt8v4zTLOEei65bE7j2LocYGFRglqtVGuIHHN
         lZeLaZMydYyGtd+GgCNzXXsWsiQA0xsCMB9xwd3S/KKDSyP48axFe6H5CJF0Xd1LxndM
         eW17Vg6fp8NAgJ/GyCyR1/GCqiNBxAwk89tt4jkaGDPBAFz+Sb8JS1idzWSpo3ptP4cv
         A3XbdhEii19FEWp1cBJVmFDBuJO5ozqPXykTiQNY1PAaMLb1CPI0zoqTs7nuJlJeQ8w9
         lDTW0fr8FSZOZr2ugI1Rg5jba3/rqo0FTlMt/+JmIs6n6mtW0k/Subg+8axrs6Q6Mhor
         w1ow==
X-Gm-Message-State: APjAAAVZ4MzuvvV2DzVOUaWMD5jQey3KDALIPwfJ/SYlQS1dC3uE1/b5
        QHmlBGlE6B4AJhT6nMxB3FJbotPpRyzzRg==
X-Google-Smtp-Source: APXvYqw6qMyodClZPglgPTigj7OUM9IT5HZHshwaJf+1a1S9f10jBZbJtpz2HKpSvyKWVH6mMlpauw==
X-Received: by 2002:ac8:424f:: with SMTP id r15mr7400643qtm.71.1579268933746;
        Fri, 17 Jan 2020 05:48:53 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s33sm13362188qtb.52.2020.01.17.05.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:53 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 31/43] btrfs: hold a ref on the root in btrfs_ioctl_send
Date:   Fri, 17 Jan 2020 08:47:46 -0500
Message-Id: <20200117134758.41494-32-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
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

