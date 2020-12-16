Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E4C2DC3FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgLPQXE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgLPQXD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:23:03 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E22C0617A6
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:23 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id b64so19005374qkc.12
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CN7hDsMRgbM0MWHoaiwEwjqwKPVUXjjBW3O499vqrDg=;
        b=qckAQcJJFTMlFhelpByD3/ORGIp3GOp+BUwhuS6+GcBE3D+98iihVX9FSFsOrOchLG
         CTsqQqrFiZXVWgBLrnRlzdNQ7J1StAJoTa0mcHp5RJvj8BwNh2vky/jEs+Z71QheysQ4
         1kuGOBNbKJcmRCThhudxZ7YQTIvj/g3L2V/t+SWINgoMQNtPEl+JJ+vc/csyTN9MXBws
         C1h3rRHLzdSrLUu/xN0raX/Z5AFFjgQTQnwhXOQSUoG8WCUtt+s4SSSeVjd8o5aL7Bb2
         pbzQaoEemQ74sHdlWcgagb7j4+AXksxMSFRK4krhOxET3TKqX+sNH9ScHqRvzKRZhGMh
         2r+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CN7hDsMRgbM0MWHoaiwEwjqwKPVUXjjBW3O499vqrDg=;
        b=BbunYGm4cu3wnsJ1AsY5k6tH5eC2Q7/Xnd+2E34f6XYksHlpi8KccWgb2fCr0fipUN
         NQHyP+vj6vdI9YQBLgGuEaEWUyurK05YjS2FkKSc4fH0Q1zebxNecqtPQTvwO5Uq/Qav
         +ESB2/ZPUwfSNg5EIZQp96/CW344AEGlP3b4BMGpP9D9N2hoF0v+vaI7Kv93uSERRn1y
         XD4XgkpF50TVcqSipMttFjDDcMwsrlISagC+hISMoIs6twdP9wegXV8GtwAr9q/TZd5r
         HuWABXalgJADc+TC8dPlmlkgm2WH9iRa85Y9hVoUY9MGdr/gLr+gKI77ozaT2xCHOg33
         DilA==
X-Gm-Message-State: AOAM532UBbbjCXys8jtyAwCHWycjRvDEcSG/YihQnK7gOG7pQQyfEOtR
        dfQQUCAUI9UCnSb7SrGbikqr6A1ROzBHPAX7
X-Google-Smtp-Source: ABdhPJzUA36FUtnjieYjLQ95jtDLsLWMRGh0Bw1k33mE4HngBa93S2bznhmUCxFEvo/U9/vvjnPicQ==
X-Received: by 2002:a37:58c1:: with SMTP id m184mr42483555qkb.115.1608135742540;
        Wed, 16 Dec 2020 08:22:22 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t68sm1451481qkd.35.2020.12.16.08.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:22:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/13] btrfs: initialize test inodes location
Date:   Wed, 16 Dec 2020 11:22:06 -0500
Message-Id: <33244ea952212da691e6723057488f8143efd949.1608135557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135557.git.josef@toxicpanda.com>
References: <cover.1608135557.git.josef@toxicpanda.com>
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

