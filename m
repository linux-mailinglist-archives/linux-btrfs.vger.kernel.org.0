Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B298A4C047E
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbiBVWXP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbiBVWXO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:23:14 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF7D6A052
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:22:48 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id a19so3481592qvm.4
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yqdw4YVw5sSSiHWU/iJ/VPFp1vA39yJmgksyJJqcEms=;
        b=m+2FGDyafrrPXtb17sjNj9/ed8nQA4ySvEddEzJCTgNmrVt23UwSUs/KZryKA2/61v
         A5f9k8DEwlzTX/xiuGwb9rXUrxLLlIlMUfhwo2vQp8B9X4jFArR6tK0WS0r5WVfkQeVT
         REop4AVGomgONpRlFVzcETlsxC07XxcZkl6Cilkwhu30VAwRmS2rxVlrGwZm/g+3RTz0
         P00Mb1FWyosFDkiujJwKKpRO+/h9aF8Yyx9Z4D7BYLKzRSrsJTKV+sLCTrq+oUznxDsD
         ZkMX6wA9AQ8qiyl95xBHRaaJVXQSJacd/uMDhYQA/Gz/YiMdQdfgys1+4tOt5yuihXcB
         U7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yqdw4YVw5sSSiHWU/iJ/VPFp1vA39yJmgksyJJqcEms=;
        b=bfD4YaLuCLLUAmuul7C8K+ZqEa+RSECIXYLtLqAlzOb5+7eKKnkNj7PV2pEPjDMJqr
         E3USTxQSwsuCYtEDw9xIFMYOXrHel2N+zqSQtBU1KkKNqGULfVy02VKS7E0Fh3GqVYfs
         evey0CEE/5E5OqLQQuIhS0rSphVaCS01KDbJ/+VyWvjnwujbBBgBXavIIZATiNpzDC/R
         uhvqs2tLofOqQimU2IqG/mNnacr+udd9brc1iMuTq10JY7hFhDixUzgTCEZftAq+u4ZR
         yKMlZZdQkSnqd+vvDH9xUXvl7cNGBh0Q+B8+0F3Pd1R4DQFwIBtJLi41V/5sxn3tnboQ
         CU3w==
X-Gm-Message-State: AOAM532v5+Xf5wGCpkjCPjWbDHXQ2eb0TWMBCCBwpsIkDnMqYjVE3tM6
        5GPUTelF9m0rQOAfhoZbP9m92AoMYCOImc1c
X-Google-Smtp-Source: ABdhPJwnofHeephwR2sRrqegFLarHqCSdGsFnxTA0ypeK4pgkik0GKlnjydnJ/MIeXt7zeKF6tMRdQ==
X-Received: by 2002:a05:6214:e43:b0:432:58fa:4cbb with SMTP id o3-20020a0562140e4300b0043258fa4cbbmr2057890qvc.94.1645568567697;
        Tue, 22 Feb 2022 14:22:47 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f9sm580617qkp.94.2022.02.22.14.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:22:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/7] btrfs-progs: repair: bail if we find an unaligned extent
Date:   Tue, 22 Feb 2022 17:22:38 -0500
Message-Id: <447c176d9eea07e902c7ba81e307d64b496443d4.1645567860.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645567860.git.josef@toxicpanda.com>
References: <cover.1645567860.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The fuzz test 003 was infinite looping when I reworked the code to
re-calculate the used bytes for the superblock.  This is because fsck
wasn't properly fixing the bad extent before my change, it just happened
to error out nicely, whereas my change made it so we go the wrong bytes
used count and just infinite looped trying to fix the problem.

Fix this by sanity checking the extent when we try to re-calculate the
bytes_used.  This makes us no longer infinite loop so we can get through
the fuzz tests.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/repair.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/common/repair.c b/common/repair.c
index f8c3f89c..a73949b0 100644
--- a/common/repair.c
+++ b/common/repair.c
@@ -178,9 +178,11 @@ static int populate_used_from_extent_root(struct btrfs_root *root,
 		if (slot >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(root, &path);
 			if (ret < 0)
-				return ret;
-			if (ret > 0)
 				break;
+			if (ret > 0) {
+				ret = 0;
+				break;
+			}
 			leaf = path.nodes[0];
 			slot = path.slots[0];
 		}
@@ -191,13 +193,20 @@ static int populate_used_from_extent_root(struct btrfs_root *root,
 		else if (key.type == BTRFS_METADATA_ITEM_KEY)
 			end = start + fs_info->nodesize - 1;
 
-		if (start != end)
+		if (start != end) {
+			if (!IS_ALIGNED(start, fs_info->sectorsize) ||
+			    !IS_ALIGNED(end + 1, fs_info->sectorsize)) {
+				fprintf(stderr, "unaligned value in the extent tree\n");
+				ret = -EINVAL;
+				break;
+			}
 			set_extent_dirty(io_tree, start, end);
+		}
 
 		path.slots[0]++;
 	}
 	btrfs_release_path(&path);
-	return 0;
+	return ret;
 }
 
 int btrfs_mark_used_blocks(struct btrfs_fs_info *fs_info,
-- 
2.26.3

