Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841604AE35A
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Feb 2022 23:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387224AbiBHWVx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 17:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386405AbiBHU1C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 15:27:02 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B99C0613CB
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 12:27:01 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id b35so14735180qkp.6
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Feb 2022 12:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WfD6fEYNCWAcGnrl7G6RugpHXHB+ojSvh2FjWGokIdA=;
        b=bNg9DVdeCKvWHDsDvHJ0OM6NVlbcHOuNlxpSEfgnDfA5kfg097HofGFNNicT38JLeO
         FDcZ/i2Qzn3EFfYVEYiduVcrUNhDZBYeMKojamw0SuYznfZEqZi4opij2Yx9rW5irDe3
         v8n8WijB6MTwjnWN8Q0KEW1f4sW+rQXLfgcYC1kAuGd8Hzozn/v3Tpfdd5BzPJdovm2n
         UbUEr84TkBqW08fZKkETTsWwev0oM9zXSHxqU2WVxMtrc3RGwawiz9KH6B9pmUsceZaE
         FmLCXhDJ/6quoPK/pr8h8IbnL9BUmKFsckahFwgwtZyvGg0HsTHp9tJfPfHBWDv1xzs9
         HPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WfD6fEYNCWAcGnrl7G6RugpHXHB+ojSvh2FjWGokIdA=;
        b=c6rmPurgrE6RnGhIlxRKaB5k+sIDfTDXkiWpCsZ+jvbNt9NiLpcajKApWpddQKik4v
         EqaLckQ89XNnBSmi0VMYa0QdVgSrrn7tmqEBSt/T38tAmGbnk0MYPgpU/5a0suEF9FK4
         GK2ricK/PxLk1+iUyQZFmMC9T5e3k3rK4GaqWF88v9F7Iwq7Jn6NJX/FFnvzwdq4zBmG
         bAII2Dj5juE4I+Z4fsoDuRfbE1xNjzrD4anECY4HcNt4CfEIh6P5WfZ/KQtuxK7IS8GT
         dXVQuMKeBw96Wx7eDtWZePKsSMKB7FZWsO16AoG+J/xbZsS9x7Wgg8vsaaFdaHuYbSf+
         YQlg==
X-Gm-Message-State: AOAM530Osk025yymdRd7IQroYXXoWDxjBPbsv7UqXrolNLsZd0j4+lkg
        mDoPv4eN941na/C+bp+wZDE82likVZOV9aRz
X-Google-Smtp-Source: ABdhPJzQlfZeNgliTi5eOWWlAdQyE0Gl+5fH7ZPZT0Klyx7fdiu2PDNUBu5SZwseWRZSQ/kMVpsLig==
X-Received: by 2002:a37:e117:: with SMTP id c23mr3751015qkm.138.1644352020157;
        Tue, 08 Feb 2022 12:27:00 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j15sm6308353qkp.88.2022.02.08.12.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 12:26:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: check: fix check_global_roots_uptodate
Date:   Tue,  8 Feb 2022 15:26:58 -0500
Message-Id: <b7bc0aeae661b1aa87f6e8eb331334c756ecb33e.1644351986.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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
Dave, sorry this should be applied as well to fix the other fuzz related tests
that will segfault.

 check/main.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index 8ccba447..fa8218c5 100644
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
@@ -10215,9 +10217,37 @@ static int check_global_roots_uptodate(void)
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
+	if (found_extent != gfs_info->num_global_roots) {
+		error("found %d extent roots, expected %llu\n", found_extent,
+		      gfs_info->num_global_roots);
+		ret = -EIO;
+	}
+	if (found_csum != gfs_info->num_global_roots) {
+		error("found %d csum roots, expected %llu\n", found_csum,
+		      gfs_info->num_global_roots);
+		ret = -EIO;
+	}
+	if (found_fst != gfs_info->num_global_roots) {
+		error("found %d free space roots, expected %llu\n", found_fst,
+		      gfs_info->num_global_roots);
+		ret = -EIO;
+	}
+	return ret;
 }
 
 static const char * const cmd_check_usage[] = {
-- 
2.26.3

