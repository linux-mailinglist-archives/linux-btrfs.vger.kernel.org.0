Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39744123093
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfLQPhj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:39 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38017 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfLQPhj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:39 -0500
Received: by mail-qk1-f195.google.com with SMTP id k6so6247523qki.5
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TQn3GkU5Dr16eJ46X601P/AomUBWnqS4KD7cwF4RRH8=;
        b=xkop6+NqQ4zqfw6To/ZB5SI5+Fv2A1RJP/FszZ/HCehxfB3GByLLFQPi3hCb15iS2z
         RbkzRQddAm07p18gYLfXCQDdz5DFpWaDdICZJB2f41SYQ0q4DwyZ1LvqrT5KoIDXdaBm
         KEzm9U8I1I9IxOa6XVhlhTic3ohrI0ALo10RzhcDET0tTye4AXM/RR+vQhKnyHAFz8BO
         r1s7KARaa4puAw4UT674ZVShMKiF/lvAaYt2t1Gabrg90r9uNfCKns016VNQpxJ4cDBs
         XGdmgTOD42qNweP7h2yR2biZ7SdOBpYI92zbfKx994CZ3yGjNIbGzUAi7xdLm62u+l1n
         a8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TQn3GkU5Dr16eJ46X601P/AomUBWnqS4KD7cwF4RRH8=;
        b=gU+tbcdToh+gGCaJRRcxzDXGFteW65zgfwbyKBHXbm0yRa8khx/AxaRykwL7Yc+PjW
         1JqEUI0c7vNNDFDbL3vaKVQsEcEi7pnwtlDGYJ7mHVO025AXRTc7uXFPHBzImoK5ramU
         vUPKas7LzHQU92F950/gVby6VjEPmMqb2y/wUX30m+GyyeRqZLh1qVcvioRc3mrIvGX/
         nzhFKjJ/D4hj1VR49Q5e42rA8EmWo2fWK+IPkftQ8Q39THWgtEr1qa/DD7akXuSZYMrb
         O5HIBaqL0iai/c+rqld+NWCZJhnr4VoaajTw+fXbpI/QspIU+GvgxJ4dmagyvKTm4+h0
         3OBA==
X-Gm-Message-State: APjAAAX6DMbQXEYoonX5ozFuvJRkztcqv8lhnFKVIOf+UpGFG5qbLDAS
        siibmGPN/2BS5Gu0L0hYmfU/hgUilIhDpg==
X-Google-Smtp-Source: APXvYqyHkBFP+2gMWzoddxdOWl6+Vh7m/ZCw3FxUJQQ9J/MATT7thC+qPEQxzrrA6VT9BmXJLqfKhg==
X-Received: by 2002:a37:9186:: with SMTP id t128mr5364309qkd.180.1576597057996;
        Tue, 17 Dec 2019 07:37:37 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d25sm7099358qka.39.2019.12.17.07.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 33/45] btrfs: hold a ref on the root in btrfs_ioctl_send
Date:   Tue, 17 Dec 2019 10:36:23 -0500
Message-Id: <20191217153635.44733-34-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
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
index 73e2e350f4a1..a82201e6979e 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7206,11 +7206,17 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
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
@@ -7218,6 +7224,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 				dedupe_in_progress_warn(clone_root);
 				spin_unlock(&clone_root->root_item_lock);
 				srcu_read_unlock(&fs_info->subvol_srcu, index);
+				btrfs_put_fs_root(clone_root);
 				ret = -EAGAIN;
 				goto out;
 			}
@@ -7245,6 +7252,12 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
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
@@ -7272,7 +7285,8 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	 * is behind the current send position. This is checked while searching
 	 * for possible clone sources.
 	 */
-	sctx->clone_roots[sctx->clone_roots_cnt++].root = sctx->send_root;
+	sctx->clone_roots[sctx->clone_roots_cnt++].root =
+		btrfs_grab_fs_root(sctx->send_root);
 
 	/* We do a bsearch later */
 	sort(sctx->clone_roots, sctx->clone_roots_cnt,
@@ -7357,18 +7371,24 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
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
2.23.0

