Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BED4469C1
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhKEUb4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbhKEUbz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:31:55 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAFBC061205
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:29:15 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id bi29so9847855qkb.5
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iJXWVIvO1tuVtnIozW4eE+rzIC8d+GMpsaxozXvZXMY=;
        b=dct8L4HSzAFU/yvJ3jJk6MuDAXomEgql5/Cehe6VvLYvl4k+5zjFhloIi5V7BpmgUY
         e0KquaxffEpsnufmb53XZWHopL1a/z2PWjbXNhj29WfLhn5q0KMn21R6IQB+yhm/wXPz
         rAJqcPWdNVHYe40QvXpQAh65NJjFah3AHna+BQYcW7cABPtzBO4dFBiLL5SIdgVtlHnY
         nt4ZzSpOaw95gZ5VRFbxpYzwxu3gReFxBpweu/l++0MgYu958RSKl+OKnyd2aqAjcXD5
         SQECcbcl6L+oVJ6Bh456fDWb8ok9v+4n+9hCB+uhiX2KvdzWIT2T2bTZJqcUPas477CB
         h7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJXWVIvO1tuVtnIozW4eE+rzIC8d+GMpsaxozXvZXMY=;
        b=ovBxed4eZUYqPnDE9YNaqUOadM0+uWOptb0UegqqZDWt+QUAEG3NNIqRPjECxDb+4k
         FeDzizqcJ2yyovwQgAGSpbVmR1KeX3xi/6MmpeBK7X66dsPjtb16hxZlrKVLhIpq86Kx
         6IPd/uEJTW/2jBDugxSd947X84AusL3Q9OSyvXKusxBuO2JWYU3/jBBE7gaS1zxnLMTr
         zgh/DLMoVxb3+7KkSpVC+QWwPIxfeXC/eeD1Mb+y7gCiqlkd05WYXddRb07JjgQ5ORGW
         toozNm1K10dnG1k6ied4MnCIb/wpKjfNQxXu70YArX1mMwKeOeTgRTsLCaIp6GvoJlVV
         AZdQ==
X-Gm-Message-State: AOAM533yNuA/GSVVzfttl9ZOA8pzrKQOWLN6teXQvxTJEehYVRr7zQSv
        5aAGGWSOrKfkA3K8mQzeroLkmc9USqw8Fw==
X-Google-Smtp-Source: ABdhPJzrMGjpxy1I2fWv65SxEqQ4qABDfbCKM0DjBtp2K//En+KLuh3MwtpukVI7gxDj4xjkmb+X9g==
X-Received: by 2002:a05:620a:4722:: with SMTP id bs34mr48382815qkb.28.1636144154652;
        Fri, 05 Nov 2021 13:29:14 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f66sm5909480qkj.76.2021.11.05.13.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:29:13 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 18/20] btrfs-progs: check: check all of the csum roots
Date:   Fri,  5 Nov 2021 16:28:43 -0400
Message-Id: <3f368f78df03050d975704be9b2bb1654fc05000.1636143924.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636143924.git.josef@toxicpanda.com>
References: <cover.1636143924.git.josef@toxicpanda.com>
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

