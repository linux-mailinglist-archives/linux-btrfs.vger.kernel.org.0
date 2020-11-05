Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8696E2A8283
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 16:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbgKEPpk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 10:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731411AbgKEPpi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 10:45:38 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C44C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 07:45:37 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id da2so887415qvb.0
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 07:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0soifh6Q38vSIJ4htvTmg/KHtvFA1GDz/hLULkcu+dw=;
        b=M4noD0+gFcz6rLHEPe/+8KaYxN762qRqoIOnOUVIqeVtVe/Lx9yaJ4Ie1lHWpXI0AZ
         tdwNeCSavOFLdJZhaxBcEe0FRGDzHwO2aKlEomPqxDaFm+HVkNBrjeIXNNM1zYbB24vY
         8ky06DnLOPsTCbUX8sO2+YmhxTw6JPLvpFTn+ZenJkcJNaZ/yqbj9QXKQdsswUXz867g
         NhqIq1/0il1vSaPtwUzYZx5Ak6CBXdIyvk6hYqdpCfvwZPc6+G2itY09g/T52w9OYmd3
         5eKTq6nJ6JtoFs6EyAA6CXv8GMLI/d+ruYb3bYhBEKPhtA+HAG28oyp0On8JfPtZrnL5
         4DIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0soifh6Q38vSIJ4htvTmg/KHtvFA1GDz/hLULkcu+dw=;
        b=KPk5VtcNrQmqHwnTaqhJxLNULi4ZGwV3lFwrAKl8H9iKJgVf2WnYIwcvTpj7OIKVCw
         5tnyEBWMSlx1JYy9mtaI643ZiOjd/FdEP65G4mrD2exw6HQYi/Rj954fQklonWhhq9Uj
         uSXSJgVoWnwu2jyAjyiDmHmszSj3fxto4+QbsV5eLYIVaFlAkUWFqNCcd9yMHs8a43oG
         IIZvhoNHk45QFQJyiAbfpsBZGUzZcCZSgqmfqtAnA1ngg6ySOK9aEWagnhRce7jTLdO6
         od2TVfmP5LNPhCVsznKH2+s9GeeLXHcZ3Twm28FiczQav3BcOR/HeEyLaMmtiTK4a5Ek
         GwvA==
X-Gm-Message-State: AOAM532FFIeOJAQ5Em7YkY0RBn2wBrEu8oRFdzHssCL0XUqSeIpjGr33
        q9qQn1qux7Igu/VZrDwmJNLNfDReLlUT9Aq+
X-Google-Smtp-Source: ABdhPJxQL58HQMDb+LapeDZ0/6796FuGLkv/KdAUq65UWo2Nwzx1EhbQxSLUSKU1b2e7x+2AvsOHiQ==
X-Received: by 2002:a0c:e944:: with SMTP id n4mr2890431qvo.50.1604591136587;
        Thu, 05 Nov 2020 07:45:36 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s17sm1233348qkg.67.2020.11.05.07.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:45:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/14] btrfs: use btrfs_read_node_slot in walk_down_tree
Date:   Thu,  5 Nov 2020 10:45:14 -0500
Message-Id: <145f1008e1f813a6a23677e9fe5b64f780824c3d.1604591048.git.josef@toxicpanda.com>
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
 fs/btrfs/ref-verify.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 488bc3dd3c2b..4b9b6c52a83b 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -551,29 +551,15 @@ static int process_leaf(struct btrfs_root *root,
 static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 			  int level, u64 *bytenr, u64 *num_bytes)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *eb;
-	u64 block_bytenr, gen;
 	int ret = 0;
 
 	while (level >= 0) {
 		if (level) {
-			struct btrfs_key first_key;
-
-			block_bytenr = btrfs_node_blockptr(path->nodes[level],
-							   path->slots[level]);
-			gen = btrfs_node_ptr_generation(path->nodes[level],
-							path->slots[level]);
-			btrfs_node_key_to_cpu(path->nodes[level], &first_key,
-					      path->slots[level]);
-			eb = read_tree_block(fs_info, block_bytenr, gen,
-					     level - 1, &first_key);
+			eb = btrfs_read_node_slot(path->nodes[level],
+						  path->slots[level]);
 			if (IS_ERR(eb))
 				return PTR_ERR(eb);
-			if (!extent_buffer_uptodate(eb)) {
-				free_extent_buffer(eb);
-				return -EIO;
-			}
 			btrfs_tree_read_lock(eb);
 			path->nodes[level-1] = eb;
 			path->slots[level-1] = 0;
-- 
2.26.2

