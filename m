Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7088F449C78
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237442AbhKHTaA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbhKHT37 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:29:59 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33A3C061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 11:27:14 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id b17so12616916qvl.9
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 11:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iJXWVIvO1tuVtnIozW4eE+rzIC8d+GMpsaxozXvZXMY=;
        b=4mHQJ7R6OGpMOE95J9zphG4N/lbwcNv0pWz4UGrHQ6+8o2l5B+/Y34mvcT2nPRA+Wt
         ACOVifoY/OSD6p5wobP6lt621Ju3mtqUY/HphX+88smCjwplsQxC8hE7CVMSoR5coUpL
         5LQLk5BZYEJTEjk5KpYHaGjHZJGDCUqED9w5+z2ZKQvDO7MX0az1Rvs36pdSTOuKUFs+
         hZTrBno124uStD4wIotkI2xHkz64tBD1pWYioJ7lFgSaALXuGg4Jddj8KU29T56++PAL
         Uw2PBHPl+ivWJqw44gu/iDnidh/7I+bGDgwDbRutrpmM0YgY43ODYgVMWsuvfXMFs8BZ
         H15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJXWVIvO1tuVtnIozW4eE+rzIC8d+GMpsaxozXvZXMY=;
        b=qnQ0/UUdqrOpR+bE5NcRpdVyaKnkOM17xNSz3QHB49zKpQNEjxCAOOcGoPRGksR42G
         znEtMpjwnunwMCKbrjiKYGE6VJqYnIYIrlCpByKMI3qBm7/XTSOffuHqBXlut5qhhG6L
         VFOih3icnrf1UtgRZLm5fnVFatjMmXwuXsnZBBjEy76ySKYEPO/0eXVlrgrJalOsrry+
         mswqHA5y0tHmHeiIjL3VUwCGp/DGJPbn7rTgRNvYbYrURqUYo2QE0sqkaMa/P/pwxmyy
         lMeBafeEWqm5y83kzZPySEOIyCyrXxWxvCjpDGnjbVV8j5WYsnSiq2VEWJpB/GdtbU46
         yMPQ==
X-Gm-Message-State: AOAM532KVr3XIg5xzAALVj0xFa2+MRCPECiMpFkmVtOcXlU8jWxUAdYW
        KeausJjRAITxceh0rug1W7U0JlfAhmnL4w==
X-Google-Smtp-Source: ABdhPJzZkB9BC6jQfb8XahM3KjuBBRa3ugQej6VejpP30U8neZRoMeLO4qJRnr+aGCPYGDvtCqDYKA==
X-Received: by 2002:ad4:5ae5:: with SMTP id c5mr1492994qvh.29.1636399633887;
        Mon, 08 Nov 2021 11:27:13 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bm27sm399248qkb.4.2021.11.08.11.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:27:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 18/20] btrfs-progs: check: check all of the csum roots
Date:   Mon,  8 Nov 2021 14:26:46 -0500
Message-Id: <86579c198c8f691cbd2c8f9bf5c5d9e350f8c3cb.1636399482.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636399481.git.josef@toxicpanda.com>
References: <cover.1636399481.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use the global roots tree to find all of the csum roots in the system
and check all of them as appropriate.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index 6795e675..175fe616 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5977,7 +5977,7 @@ out:
 	return ret;
 }
 
-static int check_csums(struct btrfs_root *root)
+static int check_csum_root(struct btrfs_root *root)
 {
 	struct btrfs_path path;
 	struct extent_buffer *leaf;
@@ -5991,7 +5991,6 @@ static int check_csums(struct btrfs_root *root)
 	unsigned long leaf_offset;
 	bool verify_csum = !!check_data_csum;
 
-	root = btrfs_csum_root(gfs_info, 0);
 	if (!extent_buffer_uptodate(root->node)) {
 		fprintf(stderr, "No valid csum tree found\n");
 		return -ENOENT;
@@ -6087,6 +6086,27 @@ skip_csum_check:
 	return errors;
 }
 
+static int check_csums(void)
+{
+	struct rb_node *n;
+	struct btrfs_root *root;
+	int ret;
+
+	root = btrfs_csum_root(gfs_info, 0);
+	while (1) {
+		ret = check_csum_root(root);
+		if (ret)
+			break;
+		n = rb_next(&root->rb_node);
+		if (!n)
+			break;
+		root = rb_entry(n, struct btrfs_root, rb_node);
+		if (root->root_key.objectid != BTRFS_CSUM_TREE_OBJECTID)
+			break;
+	}
+	return ret;
+}
+
 static int is_dropped_key(struct btrfs_key *key,
 			  struct btrfs_key *drop_key)
 {
@@ -10899,7 +10919,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		task_start(ctx.info, &ctx.start_time, &ctx.item_count);
 	}
 
-	ret = check_csums(root);
+	ret = check_csums();
 	task_stop(ctx.info);
 	/*
 	 * Data csum error is not fatal, and it may indicate more serious
-- 
2.26.3

