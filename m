Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41B1B17632F
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 19:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbgCBSsO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 13:48:14 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36887 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbgCBSsM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Mar 2020 13:48:12 -0500
Received: by mail-qt1-f194.google.com with SMTP id j34so784826qtk.4
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2020 10:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lMlrumEbfpf1/M7hxSvzyvFje29bK+/F/1pUN8J4PzU=;
        b=1PCR/SJl5Ms94zmp1XWv6+yFXEPVhiq3YH+LZaEmwKeE72DElUAg94AauftM6i04hN
         Ah6bT+BP+er+v7hNWaqzfuQjrkUk5bppXKrX8afTG53POQmAtSMytQG7dAPDp/k5swSy
         OJ9psYE/U9DchxHw5ApgnTRSPB3sFHy/EQnjAC5JMDVG3vDrbBTIZR9N40b22XoMIhkG
         FyHGP0JpKxTx6dJyKx3nZiuu/bvfDYzPvngaoB34iU2S0G3GF1kMwMdjTGqs6ZRHgRml
         K8pm1iIseZBzMiVCo/GBn/m98XnEpJxGICJpGtSsNcTp0/Eh17MXwYZweAbIF0oiCVE3
         i1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lMlrumEbfpf1/M7hxSvzyvFje29bK+/F/1pUN8J4PzU=;
        b=IqdVtyTwNNLPfbUG8owhdaZfkTNBC2Fq82mIzjtaBarBpSevcQVsA6chzFRLtI1Rou
         q2ZY7I16D617AXgK2xmMY+qzMnOK0YSJQQw3lhhgeDW9g7uB3yYgil+n60cZSPNruEOx
         XDY8g095OUfd9NyWXpGpKM8u9KFqPO+VgtPr5Tei0GGh7XCW/3FoBAWeuVkyqLjBCE2p
         i4oawy0vfQfKcFT1jQCd3sZwR6FAIK20q6ygRYbFSd41E5hfEOagD7MYthN7q3JAQ+Xx
         uHy5FK7P3EdNsV5enQ55dRLFOa3wg2La6rSqnnKavMNr27RXBeTvtncwzTJsurjO0hMB
         nc8Q==
X-Gm-Message-State: ANhLgQ0banZhiarRP4jxPH1+uUfHWBTZEjSbsygB+mzugsLxt4IpAq0V
        DzheeDcMzj4feflZFGD1oKe4uvH9iis=
X-Google-Smtp-Source: ADFU+vtZwMH1LX5wb8xs/ZKFQ/66v/SfhO6ypv1RCjHtMT6AjqgZymYtqgC10aFovAmFdtox0kz4eg==
X-Received: by 2002:ac8:7b4c:: with SMTP id m12mr1016193qtu.387.1583174890296;
        Mon, 02 Mar 2020 10:48:10 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w2sm10713412qto.73.2020.03.02.10.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 10:48:09 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 6/7] btrfs: hold a ref on the root->reloc_root
Date:   Mon,  2 Mar 2020 13:47:56 -0500
Message-Id: <20200302184757.44176-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200302184757.44176-1-josef@toxicpanda.com>
References: <20200302184757.44176-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We previously were relying on root->reloc_root to be cleaned up by the
drop snapshot, or the error handling.  However if btrfs_drop_snapshot()
failed it wouldn't drop the ref for the root.  Also we sort of depend on
the right thing to happen with moving reloc roots between lists and the
fs root they belong to, which makes it hard to figure out who owns the
reference.

Fix this by explicitly holding a reference on the reloc root for
roo->reloc_root.  This means that we hold two references on reloc roots,
one for whichever reloc_roots list it's attached to, and the
root->reloc_root we're on.

This makes it easier to reason out who owns a reference on the root, and
when it needs to be dropped.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 44 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index acd21c156378..c8ff28930677 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1384,6 +1384,7 @@ static void __del_reloc_root(struct btrfs_root *root)
 	struct rb_node *rb_node;
 	struct mapping_node *node = NULL;
 	struct reloc_control *rc = fs_info->reloc_ctl;
+	bool put_ref = false;
 
 	if (rc && root->node) {
 		spin_lock(&rc->reloc_root_tree.lock);
@@ -1400,8 +1401,13 @@ static void __del_reloc_root(struct btrfs_root *root)
 	}
 
 	spin_lock(&fs_info->trans_lock);
-	list_del_init(&root->root_list);
+	if (!list_empty(&root->root_list)) {
+		put_ref = true;
+		list_del_init(&root->root_list);
+	}
 	spin_unlock(&fs_info->trans_lock);
+	if (put_ref)
+		btrfs_put_root(root);
 	kfree(node);
 }
 
@@ -1555,7 +1561,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 
 	ret = __add_reloc_root(reloc_root);
 	BUG_ON(ret < 0);
-	root->reloc_root = reloc_root;
+	root->reloc_root = btrfs_grab_root(reloc_root);
 	return 0;
 }
 
@@ -1576,6 +1582,13 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 	reloc_root = root->reloc_root;
 	root_item = &reloc_root->root_item;
 
+	/*
+	 * We are probably ok here, but __del_reloc_root() will drop its ref of
+	 * the root.  We have the ref fro root->reloc_root, but just in case
+	 * hold it while we update the reloc root.
+	 */
+	btrfs_grab_root(reloc_root);
+
 	/* root->reloc_root will stay until current relocation finished */
 	if (fs_info->reloc_ctl->merge_reloc_tree &&
 	    btrfs_root_refs(root_item) == 0) {
@@ -1597,7 +1610,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 	ret = btrfs_update_root(trans, fs_info->tree_root,
 				&reloc_root->root_key, root_item);
 	BUG_ON(ret);
-
+	btrfs_put_root(reloc_root);
 out:
 	return 0;
 }
@@ -2297,19 +2310,28 @@ static int clean_dirty_subvols(struct reloc_control *rc)
 			 */
 			smp_wmb();
 			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
-
 			if (reloc_root) {
-
+				/*
+				 * btrfs_drop_snapshot drops our ref we hold for
+				 * ->reloc_root.  If it fails however we must
+				 * drop the ref ourselves.
+				 */
 				ret2 = btrfs_drop_snapshot(reloc_root, NULL, 0, 1);
-				if (ret2 < 0 && !ret)
-					ret = ret2;
+				if (ret2 < 0) {
+					btrfs_put_root(reloc_root);
+					if (!ret)
+						ret = ret2;
+				}
 			}
 			btrfs_put_root(root);
 		} else {
 			/* Orphan reloc tree, just clean it up */
 			ret2 = btrfs_drop_snapshot(root, NULL, 0, 1);
-			if (ret2 < 0 && !ret)
-				ret = ret2;
+			if (ret2 < 0) {
+				btrfs_put_root(root);
+				if (!ret)
+					ret = ret2;
+			}
 		}
 	}
 	return ret;
@@ -4687,7 +4709,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
 		err = __add_reloc_root(reloc_root);
 		BUG_ON(err < 0); /* -ENOMEM or logic error */
-		fs_root->reloc_root = reloc_root;
+		fs_root->reloc_root = btrfs_grab_root(reloc_root);
 		btrfs_put_root(fs_root);
 	}
 
@@ -4912,7 +4934,7 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 
 	ret = __add_reloc_root(reloc_root);
 	BUG_ON(ret < 0);
-	new_root->reloc_root = reloc_root;
+	new_root->reloc_root = btrfs_grab_root(reloc_root);
 
 	if (rc->create_reloc_tree)
 		ret = clone_backref_node(trans, rc, root, reloc_root);
-- 
2.24.1

