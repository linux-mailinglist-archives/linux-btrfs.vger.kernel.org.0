Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D6F44CA53
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhKJURn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhKJURm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:17:42 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A93C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:14:54 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id bl12so3643831qkb.13
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Bpqw75jqbcDSIbk5WrH7KTaX40c8yGb9tmuEntpkosI=;
        b=uvpChxaeZMUw0PwBYRfiWMZUHu8hTOUDf7pK05QToC6/7ziR2/30olUpXfBkFNXAvP
         bspn7g6cuCBzgcHlbbCZiv6hzwZyp2Eh1a9jZu1FBByRTD9h4h7RsbrFLnfes2LSLr5W
         JbixIT8922h0D0eaaEXTmXczxXHOtKSwqC8id+W5WJb1so3YcZ1nmnwFV3StRaQmVDHr
         7pIKh3KMiDiw9ECj8Dfq7Lf/EANOlkCBDLCCc0Ck5wSdyzc8oZrCSzB629vsWv41Zxoh
         SRhD+Cl75gIeOSz+EeeCgXEXyCquwxLBU4AivBCfCs4tsjpbVHyuiA4NE18SsU0uUhoH
         5ZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bpqw75jqbcDSIbk5WrH7KTaX40c8yGb9tmuEntpkosI=;
        b=CqEHN0dwVb/QJquKp2lqDXNDuRgttMeizUIyL3bhsyXy7GqiSIxUWB+m+ibU7mq/7p
         cYfcQGIzkKPBmMrmEPgkJmugjOPPdBg6PrZF4qprBq/U+02nIjGMsVuNwsvvPgXNbs7f
         p9IJv3GMNk0nQQHtHYCpnYRR0KfG0f3Cb+e+ZumHo5NJPcuKdBWYlfWWyQ5QBUbjczJe
         rxDrazBn3p/3eFm2SFD3R7sBM42Svma1wwLqKozMzBNQ2X4h9z6oC6QwGSK/6qxOPqOn
         C0/qtUmXlIOGNZjSY+Z+pzNCfKT197A7XVp78sJr0gWbZnDXZUCvH35jvVD0o+OQRkXN
         Ijzg==
X-Gm-Message-State: AOAM5306hnkSwWyVIxETyxLnhs+fWEVGfjQwntYfjTqty1pdez09KPf8
        aZsa0/YNQJB+2I6LiqKCXcs7LSdT3Q9eGA==
X-Google-Smtp-Source: ABdhPJwF6KCeLtvP4bqZS8Gxl5P/m5OnJ7iFfglWNPq+PSmih0kAmo+JpWmWOalGhlUk1U1VSXRaDQ==
X-Received: by 2002:a05:620a:3183:: with SMTP id bi3mr1813839qkb.76.1636575293805;
        Wed, 10 Nov 2021 12:14:53 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 9sm351011qkm.5.2021.11.10.12.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:14:53 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 05/30] btrfs-progs: check: check the global roots for uptodate root nodes
Date:   Wed, 10 Nov 2021 15:14:17 -0500
Message-Id: <ee782525aa0ad82ad0683dfecd0edfac8dec4c98.1636575146.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
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

