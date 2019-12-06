Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC96115389
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfLFOqk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:40 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36217 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfLFOqk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:40 -0500
Received: by mail-qt1-f195.google.com with SMTP id k11so7365703qtm.3
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TQn3GkU5Dr16eJ46X601P/AomUBWnqS4KD7cwF4RRH8=;
        b=tyONsnc4vB7sVEkXM7Z8WzU2KAAxdxodICzBbxKzFD/zlY8GqdKO66H6IO5mV50cri
         D1ZBhFLSQ1vnmEyu+XofOCaR+tbrRdIwSeghYjIkXL9yP4vcJTriH6n6EXPzwqKKMit8
         aIB0hVElhIEXYkvM7Gwg0hLHHUjOaFo4h1Sj7NfLDdZv0fEzs387VFBhbRaRqMvoQKQS
         58WnGu8+/+vPP75fn5jNRAhyACtm5TtR9LN78t7YSlSwy7a+qV52HEiuWMNvxHeUS/D5
         uNAOAgTt4tjztRhgvzkyg14lVVdH0Bt9dXOaEbcazdMkkBsolBKYcbrSDpcEaiIo7hau
         Oxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TQn3GkU5Dr16eJ46X601P/AomUBWnqS4KD7cwF4RRH8=;
        b=Qy3Ik+/19gtstqMQEfdSDO0eT7LU3yjisTNunQNANZwABTZ+r/UkpUhX3wi4SWjKNv
         C/t0lAzzOYQUH2goKa5KGogMfoDL87p79XegFNLxkY//ttrq795hOyAdND7+S2mBblRS
         AChyPyYHHPb2IjduVPRSV1e0gt+wdmkMkDqRtvQJxDXpFzWfOz9RfuvazpJsS+Gsfb7d
         RD0TzROYgbAxYZ/WX2bKdUURmiSnr1tghclb911TOXiBCQkHmLi5Y6nRTVVG+ooDEBL4
         eAduTAsmgSD6Hop5nI41R+f+ql6aVxbFC8V/BXNDX7V9AyGpbaQEjW9GpmD6SWP+gZpn
         DZ/A==
X-Gm-Message-State: APjAAAWNrr+j4po3gP6pOXu/HKrdRw7yOoT0haBrhv6Bj2MAxOZm3IS+
        Sjyc1+wLZ+P2gkJIycb3Sy3/3JmayTSkBA==
X-Google-Smtp-Source: APXvYqzcTIWNkRTHH6CQbVtakoMJF7BtUqdhz1ANfvFS+N1uOI82szCH4Vl22MmWOO4Zoh98yaVJ2Q==
X-Received: by 2002:ac8:21ae:: with SMTP id 43mr782948qty.223.1575643599090;
        Fri, 06 Dec 2019 06:46:39 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q30sm298331qtd.5.2019.12.06.06.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 33/44] btrfs: hold a ref on the root in btrfs_ioctl_send
Date:   Fri,  6 Dec 2019 09:45:27 -0500
Message-Id: <20191206144538.168112-34-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
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

