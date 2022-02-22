Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6074C047F
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbiBVWXN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbiBVWXM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:23:12 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481056A053
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:22:46 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id j11so3645445qvy.0
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fDoa7wYFkdWRI3HBjncU8tIUs/ZSJ6olZrfU3RVf3Ig=;
        b=wXsyhR8+xEBjtkKap3gfGfHxrTOFARtLg9e6aYkWHNyeN3SZv6HG+DXxx8NzqHMIko
         aXt5RvTbjXNbh8xe1rP4aUnqBXmCN/El2hZwzDdMX7MVTxAwKC3ctPFFNJQRECCUXbSa
         jTPU1F/pOxNnP4Z0CR+ZwZ/8t94/7owz/D5yPJdQr37Z+wBs8zia279p5vY1UJ9VJP71
         tZOS+GJFll5tDA6Sbu9Szk4T99mJ8NCDIOn1hzCEg2qPXhQUHSvmgTwrM/x0wAqVyGOs
         YHvjXsHdxTpqj6hboKJ2Gqn3P09fdR4sEuWqbsJ/rgHWtWrmgAyuSZeX7TaTUVi+2yHq
         W5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDoa7wYFkdWRI3HBjncU8tIUs/ZSJ6olZrfU3RVf3Ig=;
        b=kHwXB7PW8Drew3u0/m87uPNJCeQuCKvgOXpdylUH3JwaWrpj5Mjcg2HCh6VVz6Go7a
         OO12gFCRxesuGQ2lgrl+hVvNLvjfrUbDov6RxPgWmtNVkICWH9mGQ6lASW14ZoTIiHtc
         61XeXl9EwUWX1ZDzjy/xk0vfso8SO/eDnWiPIEvh0/xzIwG5y17wNziD9j5RIACNlyrj
         LZdssjIjmqRx2W2JaoiAXlMiqw3mYkPQVzeN18UECdJx365XEI49VWA7GG8ACzm+474z
         XEaJoLqOeOk/csGSXiTcE8wr7yZ5DZDwK9Za+Ek2aj1p6ZqgzK+8JLgSBsJsQnuaSC6F
         1kyQ==
X-Gm-Message-State: AOAM532waaY2HU9ToAGApVMfmwkeFkR7quq/vR0f8J0j+2aM2j/z5x+i
        Vwm+WbEoUItrx7peb7l876mNPnq+AjJHSZOH
X-Google-Smtp-Source: ABdhPJxeDiNwt86+Zw/aPjjzIxBC4qxVxBsaGIkXFks/4qDrdAKnDev7KIhbt8OomxZNqBFZW2gxGw==
X-Received: by 2002:a05:6214:21ed:b0:42c:11d1:70cd with SMTP id p13-20020a05621421ed00b0042c11d170cdmr20965448qvj.115.1645568565069;
        Tue, 22 Feb 2022 14:22:45 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c14sm709104qtc.31.2022.02.22.14.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:22:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/7] btrfs-progs: check: fix check_global_roots_uptodate
Date:   Tue, 22 Feb 2022 17:22:36 -0500
Message-Id: <d62401f4e8b5294e589cd8be1ecac0082ccac56b.1645567860.git.josef@toxicpanda.com>
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

While running make test on other patches I noticed we are now
segfaulting on the fuzz tests.  This is because when I converted us to a
rb tree for the global roots we lost the ability to catch that there's
no extent root at all.  Before we'd populate a dummy
fs_info->extent_root with a not uptodate node, but now you simply don't
get an extent root in the rb_tree.  Fix the check_global_roots_uptodate
helper to count how many roots we find and make sure it matches the
number we expect.  If it doesn't then we can return -EIO.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index 8ccba447..abe208df 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10207,6 +10207,8 @@ static int check_global_roots_uptodate(void)
 {
 	struct btrfs_root *root;
 	struct rb_node *n;
+	int found_csum = 0, found_extent = 0, found_fst = 0;
+	int ret = 0;
 
 	for (n = rb_first(&gfs_info->global_roots_tree); n; n = rb_next(n)) {
 		root = rb_entry(n, struct btrfs_root, rb_node);
@@ -10215,9 +10217,39 @@ static int check_global_roots_uptodate(void)
 			      root->root_key.objectid, root->root_key.offset);
 			return -EIO;
 		}
+		switch(root->root_key.objectid) {
+		case BTRFS_EXTENT_TREE_OBJECTID:
+			found_extent++;
+			break;
+		case BTRFS_CSUM_TREE_OBJECTID:
+			found_csum++;
+			break;
+		case BTRFS_FREE_SPACE_TREE_OBJECTID:
+			found_fst++;
+			break;
+		default:
+			break;
+		}
 	}
 
-	return 0;
+	if (found_extent != gfs_info->nr_global_roots) {
+		error("found %d extent roots, expected %llu\n", found_extent,
+		      gfs_info->nr_global_roots);
+		ret = -EIO;
+	}
+	if (found_csum != gfs_info->nr_global_roots) {
+		error("found %d csum roots, expected %llu\n", found_csum,
+		      gfs_info->nr_global_roots);
+		ret = -EIO;
+	}
+	if (!btrfs_fs_compat_ro(gfs_info, FREE_SPACE_TREE))
+		return ret;
+	if (found_fst != gfs_info->nr_global_roots) {
+		error("found %d free space roots, expected %llu\n", found_fst,
+		      gfs_info->nr_global_roots);
+		ret = -EIO;
+	}
+	return ret;
 }
 
 static const char * const cmd_check_usage[] = {
-- 
2.26.3

