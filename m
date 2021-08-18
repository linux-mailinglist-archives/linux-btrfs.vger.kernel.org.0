Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869213F0D6B
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 23:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhHRVe1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 17:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbhHRVeS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 17:34:18 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445CDC061764
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:43 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id az7so4773548qkb.5
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vwZ5jBL5egFitM5gfoIJEh+cvYe69lKb16NGwWPKnYI=;
        b=ku+8zN+kGMsMyhNylDZ+5C3NREbH3+insfpyWOIC915MO2WDGzI8gseP1er5Gt4mVq
         6uqXpBNjnEt3dvTG05Q6PVZtRtqBWiP/TmjOS2zucPY7ww5BXXlJj622o0MFzmbLsXzw
         BHv2KIykdcwR/Z48tV39SmdmWHcxMW5bnTKDiVcOH1tGt5nM9BvCi8IlQaVDzbfNt+0t
         DjgfTIBv/xjinh4K2mJdNRckwkf60kif6AiRgjJp+l/APyfT+wZU8j3RgeiWvo4famJ+
         aIGcIvG1GLWtlybdCZzpVR9wXozdTpIs/c+j5orIWXhnfnpKIJh/q13ymNPghd8wi2S0
         DufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vwZ5jBL5egFitM5gfoIJEh+cvYe69lKb16NGwWPKnYI=;
        b=ZnliBvoj8vzosEtkaYtciJb0W5mmZzsn99H0+H0l5oTI0ovCwKXxpkBw9tGwSA46Ik
         PXfBSETBjan4ErGNQps1fqOyzbVE0CwXlNRigjh7fjdrNeLVl2pR2X7W9XMxsceTiSOL
         XWKirtkZOTs+Ir8CQZxmquMjysiWzMIP/cJpX+rJn8hYfYN1KIp1DmYk0G9yNqcv3Onl
         qzb9JeND+y0aBnb/mNBdWU8PnRoHUY0uqIgxuXR5yZO7fR1GyDsilypqX/ZdDEfRDF62
         mQBROhy1JMhqkl9TvSj8A8bFveBQ3AFkagGb17VN4eFQRNA+UNO8D5g8FXPa10idQ62j
         AL+Q==
X-Gm-Message-State: AOAM532EKvKTVals0q7hpLM5vQTYLb9NVuwOAHt2ClggPLTxYH89kMVK
        aN5D0J6njbzfjirIRr4I4tPjDM/Yk2WOFQ==
X-Google-Smtp-Source: ABdhPJwRY26wJ7eY47IIfGjNBb1NUWf86ycoYLY23Ht3Bmn+WxDnEQid7hSFlE9ETtbAXbDRAFtXEA==
X-Received: by 2002:ae9:e858:: with SMTP id a85mr371353qkg.97.1629322422220;
        Wed, 18 Aug 2021 14:33:42 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d7sm557304qth.70.2021.08.18.14.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 14:33:41 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 10/12] btrfs-progs: check btrfs_super_used in lowmem check
Date:   Wed, 18 Aug 2021 17:33:22 -0400
Message-Id: <ebeaf9c035019f2d5b210ad752caca5655c69edc.1629322156.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629322156.git.josef@toxicpanda.com>
References: <cover.1629322156.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can already fix this problem with the block accounting code, we just
need to keep track of how much we should have used on the file system,
and then check it against the bytes_super.  The repair just piggy backs
on the block group used repair.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/mode-lowmem.c | 13 ++++++++++++-
 check/mode-lowmem.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 14815519..dacc5445 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -28,6 +28,7 @@
 #include "check/mode-lowmem.h"
 
 static u64 last_allocated_chunk;
+static u64 total_used = 0;
 
 static int calc_extent_flag(struct btrfs_root *root, struct extent_buffer *eb,
 			    u64 *flags_ret)
@@ -3654,6 +3655,8 @@ next:
 out:
 	btrfs_release_path(&path);
 
+	total_used += used;
+
 	if (total != used) {
 		error(
 		"block group[%llu %llu] used %llu but extent items used %llu",
@@ -5556,6 +5559,14 @@ next:
 	}
 out:
 
+	if (total_used != btrfs_super_bytes_used(gfs_info->super_copy)) {
+		fprintf(stderr,
+			"super bytes used %llu mismatches actual used %llu\n",
+			btrfs_super_bytes_used(gfs_info->super_copy),
+			total_used);
+		err |= SUPER_BYTES_USED_ERROR;
+	}
+
 	if (repair) {
 		ret = end_avoid_extents_overwrite();
 		if (ret < 0)
@@ -5568,7 +5579,7 @@ out:
 		if (ret)
 			err |= ret;
 		else
-			err &= ~BG_ACCOUNTING_ERROR;
+			err &= ~(BG_ACCOUNTING_ERROR|SUPER_BYTES_USED_ERROR);
 	}
 
 	btrfs_release_path(&path);
diff --git a/check/mode-lowmem.h b/check/mode-lowmem.h
index da9f8600..0bcc338b 100644
--- a/check/mode-lowmem.h
+++ b/check/mode-lowmem.h
@@ -48,6 +48,7 @@
 #define DIR_ITEM_HASH_MISMATCH	(1<<24) /* Dir item hash mismatch */
 #define INODE_MODE_ERROR	(1<<25) /* Bad inode mode */
 #define INVALID_GENERATION	(1<<26)	/* Generation is too new */
+#define SUPER_BYTES_USED_ERROR	(1<<27)	/* Super bytes_used is invalid */
 
 /*
  * Error bit for low memory mode check.
-- 
2.26.3

