Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40858102C2F
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 19:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKSS7E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 13:59:04 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43448 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfKSS7E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 13:59:04 -0500
Received: by mail-qk1-f195.google.com with SMTP id z23so18801906qkj.10
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2019 10:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U7QKmfLdx1zngWxVOM6YTeEq3mt+7mcdS/RF7CexT2w=;
        b=HZQ2RCyhZa2F6jl9C7ceLpD6P4XeyHBe648mFTadcKY5cneDswGKgsjLqa+IpHicEl
         wjQiBHSqCSYG6mD/k2BgukbRKgnHX3y3IRWykJRsRYY3MMDTFOKicWgfu/ldEh8ElQ2T
         fP0AAl94Ej1PzpbMFN4gtPOBe/QXf//31hN/pEu/ARZ4yK+tKDYJuLGPbvSCueMz65DU
         u6xd9D6QE8bONZkrm/feaxO8WwJO6kSpTHjbWt6h3obFqWX/5s1lZtuGYTb9oqXbERhp
         TLLWBl0b5xvp6N9hDOmjahGQjC6duvwVh2Qz11LzvU/7eJQDk8mQSyNZOBPAJIa7PZch
         DvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U7QKmfLdx1zngWxVOM6YTeEq3mt+7mcdS/RF7CexT2w=;
        b=k0DP18FyUAeSDnB+C/Lxho4TtGYGTj42wEQTgT75ZMLGtaCpz5KEvnuIP+Pzv1sr8g
         52XZp6ittb55gGod/iZF/+s0zRKHdtYGWMyrJ/fasggxokwjwkRK97cseVlgjhsH6ZGy
         wh4w7bhhVMuRV8yYq6sFifgclPayR8VZnA4kswd32qqDuuoYwXnX1YVT6wuGmt6ndSrK
         zwGcehPt82q6J6qyfoxgY22QOiSRIfT9HwIsutvX4NCNQKCrr8CRlpEb2/JNrhOAeN12
         UOWgFxnnyFnd4+lRQUnVn9xr2Xp6R8zohoDuA+vaNb4ST/qH6AedtBJSUQGNNm9WHmrE
         JFIw==
X-Gm-Message-State: APjAAAWqS6dhnGEKCo2sPRufYbcN/RLas3hiNd4QYkRiPG1Elfijxdh7
        XOj+UmzOLKG2CDLr3SnULEd+Uz0UTq3A4g==
X-Google-Smtp-Source: APXvYqzcCuVAXceLbVJZMDIL65hYhDhNJJZOg+fFYygYcwkwbUXU6Wc0+EezOfATCDdPYqYSPlLYNQ==
X-Received: by 2002:a37:8b06:: with SMTP id n6mr26145185qkd.263.1574189942413;
        Tue, 19 Nov 2019 10:59:02 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d139sm10535605qkb.36.2019.11.19.10.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 10:59:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: handle error in btrfs_cache_block_group
Date:   Tue, 19 Nov 2019 13:59:00 -0500
Message-Id: <20191119185900.2985-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a BUG_ON(ret < 0) in find_free_extent from
btrfs_cache_block_group.  If we fail to allocate our ctl we'll just
panic, which is not good.  Instead just go on to another block group.
If we fail to find a block group we don't want to return ENOSPC, because
really we got a ENOMEM and that's the root of the problem.  Save our
return from btrfs_cache_block_group(), and then if we still fail to make
our allocation return that ret so we get the right error back.

Tested with inject-error.py from bcc.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 153f71a5bba9..18df434bfe52 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3799,6 +3799,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 				u64 flags, int delalloc)
 {
 	int ret = 0;
+	int cache_block_group_error = 0;
 	struct btrfs_free_cluster *last_ptr = NULL;
 	struct btrfs_block_group *block_group = NULL;
 	struct find_free_extent_ctl ffe_ctl = {0};
@@ -3958,7 +3959,20 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		if (unlikely(!ffe_ctl.cached)) {
 			ffe_ctl.have_caching_bg = true;
 			ret = btrfs_cache_block_group(block_group, 0);
-			BUG_ON(ret < 0);
+
+			/*
+			 * If we get ENOMEM here or something else we want to
+			 * try other block groups, because it may not be fatal.
+			 * However if we can't find anything else we need to
+			 * save our return here so that we return the actual
+			 * error that caused problems, not ENOSPC.
+			 */
+			if (ret < 0) {
+				if (!cache_block_group_error)
+					cache_block_group_error = ret;
+				ret = 0;
+				goto loop;
+			}
 			ret = 0;
 		}
 
@@ -4045,7 +4059,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	if (ret > 0)
 		goto search;
 
-	if (ret == -ENOSPC) {
+	if (ret == -ENOSPC && !cache_block_group_error) {
 		/*
 		 * Use ffe_ctl->total_free_space as fallback if we can't find
 		 * any contiguous hole.
@@ -4056,6 +4070,8 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		space_info->max_extent_size = ffe_ctl.max_extent_size;
 		spin_unlock(&space_info->lock);
 		ins->offset = ffe_ctl.max_extent_size;
+	} else if (ret == -ENOSPC) {
+		ret = cache_block_group_error;
 	}
 	return ret;
 }
-- 
2.23.0

