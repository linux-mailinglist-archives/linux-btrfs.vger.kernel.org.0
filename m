Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0627D339858
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbhCLU0p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbhCLU02 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:28 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DADC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:28 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id u7so4832983qtq.12
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VJeRDVtsShdZ/YnML0L/8HRbj02FsVdcpDFIMPC6hBg=;
        b=v+1VGNOgK91dBBpn4B4nERYRw6zVpv9bAzMrFCzw3Wl5N2YTfVYkxMCy3uLQgL8tva
         XbezOAzOjAsz6oHoB6z6peYgyskY+B+ml30P6y9ulFf4DGkeNJlFniKolfaMxucutx9D
         lAMWPvD+X4AZHoamfYKbqFn2NSyf23tRl8CnP8xre+poNeDq2NsedPSmuXMMCmk000Q7
         DUd0Y8xMFtu+2pIkwUBaNnopqK9BafjZycMxmtlnMFRDC6b8TQv7n8YZgMb/OY8a8W83
         mL6vMmSjcv94L9HIPeVLR5NKUUVevr7zP6qQHIDXO7AP3lY0zx+0pbTa3VDQorPYHC3v
         t7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VJeRDVtsShdZ/YnML0L/8HRbj02FsVdcpDFIMPC6hBg=;
        b=qUbIIEQIvWAZkGiIEmK/tdHBzeeRybl1MK5MSs6wytyUpDHDjPVCf3rhKiFV7CE36T
         F0a76IViH1kaJAXvySts/aqvSEITiaNxnY+WslCOZU9rMeWSVksdJBC46vHblr6GfsRr
         dCNOAjOFkNu5t87oq3j9WYNb58z3OIOkLEeNG8HckPPQJm5/exdl0453LZf/g1FOHEyr
         MgqmIfApOpvJHvtTlhCQ4CYx4BxJB0L1WtSb/wy+YWMVBwekXJvNrY6eYTMuptq9ze0Z
         yW244zhVGhynI8X2fYY7qdu4bCmjeFqRRp+6x9tT7+8nNUM0SRaPS4ndnxwmhuB3fquT
         HPDQ==
X-Gm-Message-State: AOAM530NIEm6iL89WebKjVK6r8FgI+bt1OzI4db71SX7doxfUie8OANZ
        7R4kYTFCSCB4AQ5qlAQA7yKIVrCj/v9pAGDd
X-Google-Smtp-Source: ABdhPJw6WQ8X1jF7G0wQaEL/Sri0RM9wYBIW6hGR2Tg2olJlHKq8DeyF8dzBAYfrUuTDLy8FK/6eLA==
X-Received: by 2002:ac8:6e85:: with SMTP id c5mr13142795qtv.299.1615580787286;
        Fri, 12 Mar 2021 12:26:27 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m25sm4552198qtq.59.2021.03.12.12.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v8 33/39] btrfs: do proper error handling in create_reloc_inode
Date:   Fri, 12 Mar 2021 15:25:28 -0500
Message-Id: <d1a48c450d207e922607c373f6d6cf4bec344961.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
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
index 288d5df39fa0..43037cb302fd 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3648,6 +3648,35 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
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
@@ -3674,10 +3703,16 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
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

