Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91E74654FE
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244368AbhLASTQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352138AbhLASTB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:19:01 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16E1C061748
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:15:20 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id q14so24924819qtx.10
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=POZASy4PjQgWwHPrYBMDH90ogcVtf2FZANLTjXt5jYM=;
        b=ci3WzenL8MuhUqNiBc3yeIbuXyLSAEUPgyJQR04mfJaAKedld+OP/e/zFSsrWtlXZD
         MO6bPWze80Uy1Lcnw+AQ5sf8K5L/PChlWzbFNTVn3qjcPtzL7HAfRWqVxXH+Ausf/9D6
         09GFk1+OOPw2FzFURfFuYL/cO7UaMghdsC9qEI8gLCwVX3uvhwdk8H9waep9MESpUNNv
         Dqw0CPdtPA0MDq/T2ztyUamTnhDYi8pSEEDEhYESBBMWCQuvHxkYpLCdvAge4jf6k1oH
         ksAqfbCjUX9zharE2UecyKwBcJMklBYuybdyTEEDfTX/zkHGxIM/rgiHLyK3hErVde23
         uS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=POZASy4PjQgWwHPrYBMDH90ogcVtf2FZANLTjXt5jYM=;
        b=n2IlE/mvWqCviQmBdTjv+DVbt1mrkio+IYS1I7pgKZZF073l+uPRPkIJEFxcj7R349
         GSLNHv/GpBHgfFV2Xzf5AJJ+TR6E26v/Uj9zCH4pBPFDMiQ5w9y0kMeMhRnQOc/50vw7
         NKiVwU39qbUEBrrO03dmzelO+rbw+AX987+7GBOtfgmn9a+/uJmFk5i3BO7A7xadA5IX
         KAY7Q41ZlydIBcHxeBL6nWqCrL1gVRL9fFcJS7Pc+fo4gN8543duPkHwXKnahV0VWp+c
         ZNRoeEJM4O9lOPEVEqABuVEwgTlBcBmGclhmqxBf8wWevpbdQJf0cN+9EsTippimO+Dt
         UUiQ==
X-Gm-Message-State: AOAM532s6Z58an5I/hbea8z2ayToBuKxSP9jBgpx+TpFbyV8DrS0qg5G
        A12ZDEyv4BNGCcf4z8yuu6wOddW5SwVSvQ==
X-Google-Smtp-Source: ABdhPJxq37Uj3HRnEARW234C+R6UJc3pSr8U3yHlx5+DNCX5Nxt4klrF9+Vp/tNCAlpHb3gW3ukucQ==
X-Received: by 2002:a05:622a:613:: with SMTP id z19mr8726452qta.577.1638382519571;
        Wed, 01 Dec 2021 10:15:19 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r4sm245484qtu.21.2021.12.01.10.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:15:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 5/8] btrfs-progs: check: check the global roots for uptodate root nodes
Date:   Wed,  1 Dec 2021 13:15:07 -0500
Message-Id: <5f24c68ba47225616cddd88029179f46d09a1431.1638382443.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638382443.git.josef@toxicpanda.com>
References: <cover.1638382443.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of checking the csum and extent tree individually, walk through
the global roots and validate them all.  This will work properly if we
have extent tree v1 or extent tree v2.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/check/main.c b/check/main.c
index d296aeda..f873de09 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10392,6 +10392,23 @@ out:
 	return ret;
 }
 
+static int check_global_roots_uptodate(void)
+{
+	struct btrfs_root *root;
+	struct rb_node *n;
+
+	for (n = rb_first(&gfs_info->global_roots_tree); n; n = rb_next(n)) {
+		root = rb_entry(n, struct btrfs_root, rb_node);
+		if (!extent_buffer_uptodate(root->node)) {
+			error("chritical: global root [%llu %llu] not uptodate, unable to check the file system",
+			      root->root_key.objectid, root->root_key.offset);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
 static const char * const cmd_check_usage[] = {
 	"btrfs check [options] <device>",
 	"Check structural integrity of a filesystem (unmounted).",
@@ -10784,18 +10801,9 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		if (ret)
 			goto close_out;
 	}
-	root = btrfs_extent_root(gfs_info, 0);
-	if (!extent_buffer_uptodate(root->node)) {
-		error("critical: extent_root, unable to check the filesystem");
-		ret = -EIO;
-		err |= !!ret;
-		goto close_out;
-	}
 
-	root = btrfs_csum_root(gfs_info, 0);
-	if (!extent_buffer_uptodate(root->node)) {
-		error("critical: csum_root, unable to check the filesystem");
-		ret = -EIO;
+	ret = check_global_roots_uptodate();
+	if (ret) {
 		err |= !!ret;
 		goto close_out;
 	}
-- 
2.26.3

