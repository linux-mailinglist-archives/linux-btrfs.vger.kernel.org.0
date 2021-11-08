Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28452449C77
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbhKHT37 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbhKHT36 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:29:58 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7400C061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 11:27:13 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id t34so6103643qtc.7
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 11:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Bpqw75jqbcDSIbk5WrH7KTaX40c8yGb9tmuEntpkosI=;
        b=YnuIeOKzcJ8kAVclXugpw9aT4NjnE/0Ak57W9MhGugxiuiELS1S6gkMO9ku3YBStw3
         45oaHfRq7DfV3FbwwfzlWLtVm3cUiSUs+1z2MAiHwZBfYqk4ls4JPFUftiphqJCfqhy1
         5D7rNv0RHmgr5vOOLQJ7U17riQFliWQQc/obJbXJQbgkaxvatUE3hOV2uDO1yNDJGTDM
         OpI2RCN6Incl/q+gxLrAJRbWQ4cRSvDcExNFs+j8NPN3MXvtX7w+tgSHpV0jKbCuMEwJ
         sZX5Dnvt81+C4ycHTNindoboyeyaddgyDjtGTkVEpMo61Hy030tR34eMMU1G85i5dlh3
         yeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bpqw75jqbcDSIbk5WrH7KTaX40c8yGb9tmuEntpkosI=;
        b=u9m1TyL+/07FVd5ut6fWXrJIMx4BlLrN+WfVGCMpfzushKryYuJ6HjVvd1X/9SnaoG
         7LIQObEUnFUst7PLOC1ISFsaU1GZo2l5zcJkxJJjL88A0o1dRM9WjJK1LlZImQDBbU0d
         RzsYdPzHT2n+7RH9EZh9o8VTsJYaZ1IOXbi4QX5WSiJNcJitnpMs+meXVpGsuf4R3iMK
         R2AvnLZZYIdpX8/dV0gIbuC7NJnjNuJKQx7F4cIFQh9iYZyoNFXvOEv50hgVGhsOrIee
         hlSQeJD/KoA5AUFO0EnpLfLFTOhlr84i0PJEUzwRZFsCxSPOeq6JXExvVy/CUpq9uLhO
         ArAA==
X-Gm-Message-State: AOAM533Icp7I7S83c6A0aMofqXqwgWQs1I1HC2NijgSM/0r7E83IkR4x
        JOpEXGtqAKkxqU4iarG/Dtxc6aiqN+jdQg==
X-Google-Smtp-Source: ABdhPJzxVAPayzfRwGy9C+Rj0B0V0V6GBg65dOATjSGC/vq2t8TIV9GkT9XIphu4XtbdwlbrvuKFGw==
X-Received: by 2002:a05:622a:1705:: with SMTP id h5mr2071228qtk.331.1636399632660;
        Mon, 08 Nov 2021 11:27:12 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c24sm10874409qkp.43.2021.11.08.11.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:27:12 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 17/20] btrfs-progs: check: check the global roots for uptodate root nodes
Date:   Mon,  8 Nov 2021 14:26:45 -0500
Message-Id: <07c0de4a82ace97e1f4cfdab0ca0d69ca116401c.1636399482.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636399481.git.josef@toxicpanda.com>
References: <cover.1636399481.git.josef@toxicpanda.com>
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
index 140cd427..6795e675 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10379,6 +10379,23 @@ out:
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
@@ -10771,18 +10788,9 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
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

