Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE752DB213
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Dec 2020 18:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgLORBU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Dec 2020 12:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgLORBK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Dec 2020 12:01:10 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41475C0617A6
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Dec 2020 09:00:30 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id 7so15141985qtp.1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Dec 2020 09:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CN7hDsMRgbM0MWHoaiwEwjqwKPVUXjjBW3O499vqrDg=;
        b=hsZc4Ui2O5fRFX4teE9x23uNzan4RfnnOM41Xz6ij+++E78TC9q6hejdtZgPuJFCU3
         q3Rcv50MtmEgGiHKn53y5c7TvaAjqth2xL2AIFjmiChWLotfX+ZXyjgB/4yjW2aP7cz1
         B9sP3WX+6G1O7mVLU1tDUrxgPbp7n+4SNksysKUsjVUoXrdwtZcNXHxhNh2DZQbr2f/U
         dxOzszh3wCsFrqZ4i6kxqkkAyPQ5lmiql7rzB+ISv+HVz/5gtIwfBH9BUrzze+NnDLFK
         Rx9tm+RJDG1JemafXlWZkEH1wqE3C0d8bB7ecNEmSgXzP5jzwH8CCSfVhrofOx1rg0TH
         QIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CN7hDsMRgbM0MWHoaiwEwjqwKPVUXjjBW3O499vqrDg=;
        b=CtCp7uKO2FanMa1SRpbzhHVed2DuMKak2Dxhx3a44V4K5pizdqUJgHBXEKV369v610
         ZxRQukplNW7lIBi0p6tQIs3/1dIZz4iUCsk8ky3DjTOkamiVpGM7efSSVqpQ5zJUyDSU
         OUHgnd0jk5TkiR43NmmZJTlUGH0aup0AYi6QM4EZMl1vjShGCGYSY7BCmJm0ESYFfst5
         gsASHGqhafStHGz3PVbFpXgGXdX0MqGE308z5+dTCkPg7ny3nOx4tJ111kUV2nvzT2pb
         u0ZMQxjZsjZAkkD16zTdxrAb2fkRnzmphxOZmq7MJTnUtd9O1DtKCr2zGWQWqHgQLz0D
         8PbQ==
X-Gm-Message-State: AOAM533AW4OHlx9DFGjQ1qsx2M5QkhWdzcWbwYaviiRbOHGr+jsNnih+
        z8vJ6WAY2gjL+VFTvqTS0W2hv+BF2SAyjA9F
X-Google-Smtp-Source: ABdhPJzS3ctJ6FfLHGkWnrk4ez6pCVPY8denoLCAqwCfqLT9X/rg2gaONTd6fGegJlP/3+1pJ+lkaA==
X-Received: by 2002:ac8:58d1:: with SMTP id u17mr38328275qta.158.1608051628883;
        Tue, 15 Dec 2020 09:00:28 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h16sm17460351qko.135.2020.12.15.09.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 09:00:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: initialize test inodes location
Date:   Tue, 15 Dec 2020 12:00:26 -0500
Message-Id: <7d1759263b14140254494b1ae49fe69aff099dc1.1608051618.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While testing other things I was noticing that sometimes my VM would
fail to load the btrfs module because the self test failed like this

BTRFS: selftest: fs/btrfs/tests/inode-tests.c:963 miscount, wanted 1, got 0

This turned out to be because sometimes the btrfs ino would be the btree
inode number, and thus we'd skip calling the set extent delalloc bit
helper, and thus not adjust ->outstanding_extents.  Fix this by making
sure we init test inodes with a valid inode number so that we don't get
random failures during self tests.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tests/btrfs-tests.c | 7 ++++++-
 fs/btrfs/tests/inode-tests.c | 9 ---------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index 8ca334d554af..0fede1514a3e 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -55,8 +55,13 @@ struct inode *btrfs_new_test_inode(void)
 	struct inode *inode;
 
 	inode = new_inode(test_mnt->mnt_sb);
-	if (inode)
+	if (inode) {
+		inode->i_mode = S_IFREG;
+		BTRFS_I(inode)->location.type = BTRFS_INODE_ITEM_KEY;
+		BTRFS_I(inode)->location.objectid = BTRFS_FIRST_FREE_OBJECTID;
+		BTRFS_I(inode)->location.offset = 0;
 		inode_init_owner(inode, NULL, S_IFREG);
+	}
 
 	return inode;
 }
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index 04022069761d..c9874b12d337 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -232,11 +232,6 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		return ret;
 	}
 
-	inode->i_mode = S_IFREG;
-	BTRFS_I(inode)->location.type = BTRFS_INODE_ITEM_KEY;
-	BTRFS_I(inode)->location.objectid = BTRFS_FIRST_FREE_OBJECTID;
-	BTRFS_I(inode)->location.offset = 0;
-
 	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
@@ -835,10 +830,6 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 		return ret;
 	}
 
-	BTRFS_I(inode)->location.type = BTRFS_INODE_ITEM_KEY;
-	BTRFS_I(inode)->location.objectid = BTRFS_FIRST_FREE_OBJECTID;
-	BTRFS_I(inode)->location.offset = 0;
-
 	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
-- 
2.26.2

