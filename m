Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18BD2CDD8D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgLCSZ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502052AbgLCSZT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:19 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A20C09425B
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:24:19 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id r6so2068409qtm.3
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VtoHf3L4vkokxUxrJ85QLQy4x/t7HOVGr2Oo/WULWZo=;
        b=r4ow88xB41XvtXOssoAm3dkuOkbGu7MB0BFEN43nz4H8Bsgw8NFbonYnBawl2nhSDF
         wYp5QdLuuhwvhpNTIv3VJNL/rSCU7X1CvHOb/p70/rYYW3OTDjF86G9maitgM3xt/G1o
         PnwEJPqFIUrEYCY2e1ugdIsnPwgKl5v01rvU9ReTxGQ57iiOLUWwN/UUPcmh19ZZPhqm
         IUOnLGUpjBZ9ahHVns44BNvBgVk2UOBtgAHJh+kCJFlxhF4G8HpLnHfZsBXawgY+c9Qn
         a7kubeHLFml3gOoAmyTtfZQvq54gv5yd4agz/VpiclfW0f8fMrhBjWoEJiYQeqqgdzJX
         8NGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VtoHf3L4vkokxUxrJ85QLQy4x/t7HOVGr2Oo/WULWZo=;
        b=FgL7cRJiyM2/eNsJABTMil0dTlkMQv2jsWaDAM0IBidIJ8vlamoZQFwRtz+Mg1KyfH
         F2PfsnibeZZbuBqB4P05eM/TpCcVhM3rRfPFN/xr7Y0mg1x9fB/89OU6PJ8p8RLdMjT1
         QKaE0gp341cZuZSOzDyve/FfJEIsm82t9v6Zy90Cqt4C6mkBjYqWNuEgqJltxImiCKvU
         JfUCtRQ4nehkkSzDIP/U6nuQbcPHMpd+in9MI1VTo4b/Rkkpc/OTN7vGeA0cW3Yz5i1o
         3Nw26Tk7AfgBB54xk1fimmDwmvuc07NhllW0MO+BvvLjDAlchVIzI8mnYOzdiAJhXNba
         2Svg==
X-Gm-Message-State: AOAM531PLcNbBCjUTjghZgKp5ZTsBXN3Tuxkbq9Ql5lAx/3I8Ag6zCpK
        ZBPH7Wn+6Hyxg7USZxQTlor48RcXfxK7UKS4
X-Google-Smtp-Source: ABdhPJwe99/y0wjYpSjkFJkRkGbsmay+LNQ7nbBLV8BtResmDCecftQ650Sk6Sn4qcAkrTfZnbIDfg==
X-Received: by 2002:ac8:7559:: with SMTP id b25mr4608852qtr.51.1607019857945;
        Thu, 03 Dec 2020 10:24:17 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v204sm2307138qka.4.2020.12.03.10.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:24:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 44/53] btrfs: do proper error handling in create_reloc_inode
Date:   Thu,  3 Dec 2020 13:22:50 -0500
Message-Id: <d9f7ca2b1a5984a27d99ec7bcb6bfa3c3737d5a1.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We already handle some errors in this function, and the callers do the
correct error handling, so clean up the rest of the function to do the
appropriate error handling.

There's a little extra work that needs to be done here, as we create the
inode item before we create the orphan item.  We could potentially add
the orphan item, but if we failed to create the inode item we would have
to abort the transaction.  Instead add a helper to delete the inode item
we created in the case that we're unable to look up the inode (this
would likely be caused by an ENOMEM), which if it succeeds means we can
avoid a transaction abort in this particular error case.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5227b4f7d115..05b42a559da3 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3601,6 +3601,35 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static void delete_orphan_inode(struct btrfs_trans_handle *trans,
+				struct btrfs_root *root, u64 objectid)
+{
+	struct btrfs_path *path;
+	struct btrfs_key key;
+	int ret = 0;
+
+	path = btrfs_alloc_path();
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	key.objectid = objectid;
+	key.type = BTRFS_INODE_ITEM_KEY;
+	key.offset = 0;
+	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
+	if (ret) {
+		if (ret > 0)
+			ret = -ENOENT;
+		goto out;
+	}
+	ret = btrfs_del_item(trans, root, path);
+out:
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
+	btrfs_free_path(path);
+}
+
 /*
  * helper to create inode for data relocation.
  * the inode is in data relocation tree and its link count is 0
@@ -3627,10 +3656,16 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 		goto out;
 
 	err = __insert_orphan_inode(trans, root, objectid);
-	BUG_ON(err);
+	if (err)
+		goto out;
 
 	inode = btrfs_iget(fs_info->sb, objectid, root);
-	BUG_ON(IS_ERR(inode));
+	if (IS_ERR(inode)) {
+		delete_orphan_inode(trans, root, objectid);
+		err = PTR_ERR(inode);
+		inode = NULL;
+		goto out;
+	}
 	BTRFS_I(inode)->index_cnt = group->start;
 
 	err = btrfs_orphan_add(trans, BTRFS_I(inode));
-- 
2.26.2

