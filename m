Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA3D2A8286
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 16:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbgKEPpp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 10:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730977AbgKEPpo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 10:45:44 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86550C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 07:45:44 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 11so1560060qkd.5
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 07:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rqDn/hfh8jMZcwToNMbIvBFhrfNCYILIh01yziBkINw=;
        b=qZ9YZB4ybL1BfdcEOv7JeQ/XArWELEzV9y3msiTuLfXN9y3l9OUzGApQRGfUV7FQNi
         1eLPSGlTdoZKAMMbLzRDdKTjVzO0nhbz73f9Vgk8mB9IXjIGiZfMLHMSXPUgZQkLP3mg
         Ha0kWwd7FOyyDG27izNbFnahR4VMsJDC4XH03R04QMT8YYymoCNAQ7kfjDyLDxLb/Hqz
         ttZonbCQEclHXehqHAFnxDU5L2gIRSEY2LGDEEyL9ciw15Hmx/+MMiuQTYTjeOcsaVWk
         AMcgdOpSqdkY93oh07fPNiogVqi5O27RTyCfw+K6fFtN2Jc38WSVQGMojhrTFqtXXmpw
         XkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rqDn/hfh8jMZcwToNMbIvBFhrfNCYILIh01yziBkINw=;
        b=lagRSX6Nr0TAyFnW/PDKuffrkvMRAYz4JPgLBEXaWug9FfDqpEDSLKKzfBw6qFvuf7
         pRCTIScw1dmEgMyd9mKUA37KUKusTEvluyoQzYGYeEapdqBIINCEeZx2Yex7CWc1jV+W
         CfrS8LR7X58wGCH1FLS7OHapQ9ogcICx6z4kLW2C3fWaJ+sq9en0MgtiuPa3z931wjz7
         p1AvBmPQ3bfxixOozc11y2J7Rcq7fa4JHoP8fBJkgxuBp5WotIQWl5nRGE2CmCepGr5+
         73p0j6iUZ/Ky2tMXxHBKBktdJ5Yd91ihlDtEEeO4iskjvxlOcBY7CymvSzqPcEzcZxq0
         6CyQ==
X-Gm-Message-State: AOAM532Yjzp8/heJ6whwsqUxVUnYPklCDXOq2MIQp4sof5vmG5LuJpBs
        3A0ZHfHHOO947HQPcG8mDN1999X1RouSSXL9
X-Google-Smtp-Source: ABdhPJxBtzQgR7prH0ZwRVT45QbhO7SSgCCWAnnaIiejtN5wTxhBukXH5yKVyKrPT5Gd6j+M7UMg4A==
X-Received: by 2002:a05:620a:c0f:: with SMTP id l15mr2614415qki.494.1604591142349;
        Thu, 05 Nov 2020 07:45:42 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t20sm1139378qtt.70.2020.11.05.07.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:45:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/14] btrfs: use btrfs_read_node_slot in btrfs_qgroup_trace_subtree
Date:   Thu,  5 Nov 2020 10:45:17 -0500
Message-Id: <4e8c871927bd508d2226eefc65c977b252377aa0.1604591048.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604591048.git.josef@toxicpanda.com>
References: <cover.1604591048.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're open-coding btrfs_read_node_slot() here, replace with the helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/qgroup.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 8d112ff7b5ae..25e3b7105e8a 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2182,30 +2182,21 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 	level = root_level;
 	while (level >= 0) {
 		if (path->nodes[level] == NULL) {
-			struct btrfs_key first_key;
 			int parent_slot;
-			u64 child_gen;
 			u64 child_bytenr;
 
 			/*
-			 * We need to get child blockptr/gen from parent before
-			 * we can read it.
+			 * We need to get child blockptr from parent before we
+			 * can read it.
 			  */
 			eb = path->nodes[level + 1];
 			parent_slot = path->slots[level + 1];
 			child_bytenr = btrfs_node_blockptr(eb, parent_slot);
-			child_gen = btrfs_node_ptr_generation(eb, parent_slot);
-			btrfs_node_key_to_cpu(eb, &first_key, parent_slot);
 
-			eb = read_tree_block(fs_info, child_bytenr, child_gen,
-					     level, &first_key);
+			eb = btrfs_read_node_slot(eb, parent_slot);
 			if (IS_ERR(eb)) {
 				ret = PTR_ERR(eb);
 				goto out;
-			} else if (!extent_buffer_uptodate(eb)) {
-				free_extent_buffer(eb);
-				ret = -EIO;
-				goto out;
 			}
 
 			path->nodes[level] = eb;
-- 
2.26.2

