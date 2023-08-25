Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E110788847
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 15:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjHYNS1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 09:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245072AbjHYNSA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 09:18:00 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BA0198A
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 06:17:51 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-649a653479bso5419696d6.0
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692969470; x=1693574270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2zql8aOxiBtww710j0LOhZ9zVEv/h0oj5yvqFWZVFLg=;
        b=wFZ7ILk2BWvWp8rkpFLLmG76C6UI9KD2juvD6Fa7x9hv5uIJKEDAsvyEmrD6tEDbbU
         YQL0mUCEj6TxLMNV1GeniA0pV50OyDDzu+xK5/YdC5LQO2kodgd+A0F9nlZy7Ae8K4JD
         oxaP/HcMXsLYqY9hoydIg/+7SIuOHIBurOXoGISkIzzSrZtQzAnu/6qGR3EyZ+XiAFD6
         IPckCUGIpAoEgRhUAyF8aUPTLpefffVBAHTO2pQH/3vPy8JxvUC7T7XmcSyisXeWJ9mZ
         4BMXYE8zX5B1lxZmpZ4bqv+5nDnSyWH30YPdZeoOGqnSGC3QdsuQVFParYfVHET8wXBQ
         F6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692969470; x=1693574270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2zql8aOxiBtww710j0LOhZ9zVEv/h0oj5yvqFWZVFLg=;
        b=fYsZULrwAhwrvdz9M3rQMTnoszhHSoeSZqk71aEGwSkC1gl//DRDG5s/ZVbpSNk4Yo
         gpxsdc99uXbbZjrZJtroRDYnpCssRo2PdNoELI/y/brknrqca2raovXfGb7Qxg5RErrQ
         h0SGRktCEWx5x2xyyQBR65okzOMmNflqqYznuhyMAIpAsRy6JMlF7m6GKvJZk6Fsoawh
         3OAbmt6H5LKQQIV9fBsEX3UeM9c7M3/q9ovmDuOYba0jfYgn/k7vCzAmr+aMc6dnHNq4
         vtB7djHt4xn/lCs48suyF9/01VaLt1bTICF/W5QJeYyR8qHvsQNu2PvdD7UI4yRQZ6VI
         ywSA==
X-Gm-Message-State: AOJu0YzBLY7ck5tJLvjzYFMKMpqCwkSRo18AQx1ucoQk3vh5VrjzXZwa
        2TmKNcyR8FzEePN2Zluz60CgaJ3B6gWn/VjXxxI=
X-Google-Smtp-Source: AGHT+IEL98VuawiXqpwIkmWMADnVgele2XnFxkq2XzAdO2cH5yil4izD9aU3+VDaY3XB8tXdTvThxA==
X-Received: by 2002:a05:6214:320b:b0:63c:f964:dd67 with SMTP id qj11-20020a056214320b00b0063cf964dd67mr20245512qvb.49.1692969470132;
        Fri, 25 Aug 2023 06:17:50 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u8-20020a0cf1c8000000b00647432144cfsm540287qvl.99.2023.08.25.06.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 06:17:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: add a free_root_extent_buffers helper
Date:   Fri, 25 Aug 2023 09:17:45 -0400
Message-ID: <9dde35bf7b2817ae22d60510ec8f4fc6e0614221.1692969459.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Our CI started failing a bunch because I accidentally introduced an
extent buffer leak.  This is because we haphazardly have ->commit_roots
used in btrfs-progs, and they get freed when the transaction commits and
then they're cleared out.  In the kernel we make sure to free all this
when we free the root, but we don't have the same thing in btrfs-progs.
Fix this by bringing over the free_root_extent_buffers helper and use
this for free'ing up all the roots.  This brings us inline with the
kernel more and eliminates the extent buffer leak.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/disk-io.c | 48 +++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 7916bf5c..9c987f7d 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -563,12 +563,21 @@ static int find_and_setup_log_root(struct btrfs_root *tree_root,
 	return 0;
 }
 
+static void free_root_extent_buffers(struct btrfs_root *root)
+{
+	if (root) {
+		if (root->node)
+			free_extent_buffer(root->node);
+		if (root->commit_root)
+			free_extent_buffer(root->commit_root);
+		root->node = NULL;
+		root->commit_root = NULL;
+	}
+}
+
 int btrfs_free_fs_root(struct btrfs_root *root)
 {
-	if (root->node)
-		free_extent_buffer(root->node);
-	if (root->commit_root)
-		free_extent_buffer(root->commit_root);
+	free_root_extent_buffers(root);
 	kfree(root);
 	return 0;
 }
@@ -1291,32 +1300,20 @@ static void release_global_roots(struct btrfs_fs_info *fs_info)
 
 	for (n = rb_first(&fs_info->global_roots_tree); n; n = rb_next(n)) {
 		root = rb_entry(n, struct btrfs_root, rb_node);
-		if (root->node)
-			free_extent_buffer(root->node);
-		if (root->commit_root)
-			free_extent_buffer(root->commit_root);
-		root->node = NULL;
-		root->commit_root = NULL;
+		free_root_extent_buffers(root);
 	}
 }
 
 void btrfs_release_all_roots(struct btrfs_fs_info *fs_info)
 {
 	release_global_roots(fs_info);
-	if (fs_info->block_group_root)
-		free_extent_buffer(fs_info->block_group_root->node);
-	if (fs_info->quota_root)
-		free_extent_buffer(fs_info->quota_root->node);
-	if (fs_info->dev_root)
-		free_extent_buffer(fs_info->dev_root->node);
-	if (fs_info->tree_root)
-		free_extent_buffer(fs_info->tree_root->node);
-	if (fs_info->log_root_tree)
-		free_extent_buffer(fs_info->log_root_tree->node);
-	if (fs_info->chunk_root)
-		free_extent_buffer(fs_info->chunk_root->node);
-	if (fs_info->uuid_root)
-		free_extent_buffer(fs_info->uuid_root->node);
+	free_root_extent_buffers(fs_info->block_group_root);
+	free_root_extent_buffers(fs_info->quota_root);
+	free_root_extent_buffers(fs_info->dev_root);
+	free_root_extent_buffers(fs_info->tree_root);
+	free_root_extent_buffers(fs_info->log_root_tree);
+	free_root_extent_buffers(fs_info->chunk_root);
+	free_root_extent_buffers(fs_info->uuid_root);
 }
 
 static void free_map_lookup(struct cache_extent *ce)
@@ -2300,8 +2297,7 @@ int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
 		return ret;
 	if (is_global_root(root))
 		rb_erase(&root->rb_node, &fs_info->global_roots_tree);
-	free_extent_buffer(root->node);
-	free_extent_buffer(root->commit_root);
+	free_root_extent_buffers(root);
 	kfree(root);
 	return 0;
 }
-- 
2.41.0

