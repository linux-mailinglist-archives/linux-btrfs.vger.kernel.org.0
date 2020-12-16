Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7232DC449
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgLPQ3F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgLPQ3F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:29:05 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A70CC0619DD
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:55 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id h4so18167948qkk.4
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=q3ZFkc4fZopbKKht4JgMg7mSZw6aGECg8+ejGJXrEGM=;
        b=vzLf3OO/MJA+uooK0qmLotMVo+n9OgvbbCWsvQosTYja+SZkq4NUCbbuoQhBXLWerv
         j7fDDQHpDwm/3NH4hmESnwEPVEXqs0fKy1/PX7k5dLaX78SJXen41Xu3fc4XjxBRvCCT
         PPYqPLWSe4XktEJeOns6fA/MC65hTYKJsTdJz8CdrQMEH338TMYclpuk//wlj/QMfpu1
         a7o5vgnHxYNYw6dNb9VXYfS8Yjvi9qs2674R2p3QZXlUfjd9yl9yXUjjkqqD4rPmvlzo
         QTiEnU7dC19nIglBTVDySg8cpYcie6ImUEEOfShFyZopKO4u5XRvaV7Io7vlmpOwiGYz
         PgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q3ZFkc4fZopbKKht4JgMg7mSZw6aGECg8+ejGJXrEGM=;
        b=s+aQ3qso+br7f6xvw8/Po8OyzjVjvUlCvkgjDiFJ1tUDIDewo6RsGzOLgMx5eeav27
         G0exFO8843bVYIqLX+2+4M5ju0KHGia+hj4UfQSXM+e9YyrrTGrietz/fWx2hftBzp0O
         RXG3cVtk/0RRP2r9NabD8nYi12lbQJcbpkPNZEZnXff3kpw+iL0o0Qzm6KzF0oTwxSk8
         Lo5LeEmjqqxUP0AkCcfDj1LIF1ZgbrOpmB5q9a4AM4vBm/tiAp2gN3TSqs1G1/daFIzr
         /WWbvAyuF1QULKSvWOqwMc3Cy/W2VIbIDSeAZd9fvnHL/zJLFp8DVn6s5+eAoPy5ILMK
         +xhw==
X-Gm-Message-State: AOAM530jpNLoaFic6f4FxC5eFfwFXpSmnVIXu+LHrk5gAKEfhWop467W
        6PIspEZ/n0I1sqD62T3l6+vtfP5TeDMifoey
X-Google-Smtp-Source: ABdhPJzYoCGLGUsW5Z/ewTG/wOk2fPamvB5VVHUoGpLBaX4QF2Nm2ZfVLgqOg06MDXpKt/+Cf+JTZg==
X-Received: by 2002:a05:620a:38b:: with SMTP id q11mr18232108qkm.239.1608136073967;
        Wed, 16 Dec 2020 08:27:53 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c7sm1195499qtw.70.2020.12.16.08.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:53 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 33/38] btrfs: do proper error handling in create_reloc_inode
Date:   Wed, 16 Dec 2020 11:26:49 -0500
Message-Id: <0635eb64208e5b6ddcebf6fea00d4928376c14c2.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
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
index 93446ec5bcd9..26b85ab4b295 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3609,6 +3609,35 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
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
@@ -3635,10 +3664,16 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
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

