Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576C34C0480
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbiBVWXR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbiBVWXQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:23:16 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAAC6A052
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:22:50 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id o5so3495811qvm.3
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WTqlgxxXhrlzo4psylQE4cqYdLntx9kuBQkywth5G54=;
        b=pjes3EOBdNhPAOFMYWSmM+yOHVH+u8nXl/6mmTKmeNDeT96Uk9Eb1HguKq6I0B2A7l
         0FAEO6xPLkMJWUs1maga7GL275v4c7HV/0WGy6vheoUu1tDdrVlAxQSs+WliFPpRFEBo
         xuW+gJbXVjeE5JJif/qtsnLLOfL+TrPJ7yoVtxO6ZVokU1W63dM3tl0zsydt5a5azOKp
         mdfTX8vbFERMZHpiqRPN57hUQ4B1oy4GBS/8F0BdkJtIGJnj3wXnb6cfNX+kTfcykBzq
         gOl57IT+YxRSDOClwH8Ug7t2FYGDEICFykX924V6biuauzzdm7e1ofVFMKO7B86lWOdL
         nIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTqlgxxXhrlzo4psylQE4cqYdLntx9kuBQkywth5G54=;
        b=pkpbWRH5AzI4iUg6gYSM09u5IpgU9+WEKsyd5Cswsb3f2Wrm8r2uCasOzKgiSSIDwc
         a2prp1Fvswx8r6Nf7Pp99PbvRuRRoEVMVR3CGJNf1hS1I3wjl8MEmNlc3Ubi05vBzhPq
         Dx5+XbfdLVpDifnLrgVhUIlSdXbInsJycJkf3vC79dvJ99Nm+zkJAf+wWQ+iqrYsWdhP
         /Z2f1Y29dZdf6lzvcAcL1s3xKchR71pOBgYUbCk1pk1+2Tzt8VBt+w/k/ackwEjRVRO6
         NbEGcOr/C48nqoFxoNsb5adHFYlfeX/gDkn/qPca1EhHAHt3GprpGnUovtEIoGtPQ8jX
         Q2YA==
X-Gm-Message-State: AOAM530Rjjf+OHocDWMzHQkElTN8rNXJQNYU6bTFfaEcwvzkIzB945b+
        VtiJVe6tb59wAkmhdNFu2h0LcAvdx0gHPyZt
X-Google-Smtp-Source: ABdhPJxySsQdbtDtlgLKc/Vz7GxWdfkIGDUJ9AWMZxjv/dWxJMOSLlOkhYSlBzo1RLSMf5DQ152dlg==
X-Received: by 2002:a05:6214:10e8:b0:42c:6e7:c7d2 with SMTP id q8-20020a05621410e800b0042c06e7c7d2mr21008485qvt.56.1645568568999;
        Tue, 22 Feb 2022 14:22:48 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s126sm592174qkb.72.2022.02.22.14.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:22:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/7] btrfs-progs: properly populate missing trees
Date:   Tue, 22 Feb 2022 17:22:39 -0500
Message-Id: <0acd92a3b95f21b89e249fdf2f78e914b6b9c1c0.1645567860.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645567860.git.josef@toxicpanda.com>
References: <cover.1645567860.git.josef@toxicpanda.com>
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

With my global roots prep patches I regressed us on handling the case
where we didn't find a root at all.  In this case we need to return an
error (prior we returned -ENOENT) or we need to populate a dummy tree if
we have OPEN_CTREE_PARTIAL set.  This fixes a segfault of fuzz test 006.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/disk-io.c | 43 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index e7eab1a1..1cd965aa 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1059,6 +1059,7 @@ static int load_global_roots_objectid(struct btrfs_fs_info *fs_info,
 	struct btrfs_root *tree_root = fs_info->tree_root;
 	struct btrfs_root *root;
 	int ret;
+	int found = 0;
 	struct btrfs_key key = {
 		.objectid = objectid,
 		.type = BTRFS_ROOT_ITEM_KEY,
@@ -1124,9 +1125,51 @@ static int load_global_roots_objectid(struct btrfs_fs_info *fs_info,
 			break;
 		}
 
+		found++;
 		path->slots[0]++;
 	}
 	btrfs_release_path(path);
+
+	/*
+	 * We didn't find all of our roots, create empty ones if we have PARTIAL
+	 * set.
+	 */
+	if (!ret && found < fs_info->nr_global_roots) {
+		int i;
+
+		if (!(flags & OPEN_CTREE_PARTIAL)) {
+			error("could not setup %s tree", str);
+			return -EIO;
+		}
+
+		warning("could not setup %s tree, skipping it", str);
+		for (i = found; i < fs_info->nr_global_roots; i++) {
+			root = calloc(1, sizeof(*root));
+			if (!root) {
+				ret = -ENOMEM;
+				break;
+			}
+			btrfs_setup_root(root, fs_info, objectid);
+			root->root_key.objectid = objectid;
+			root->root_key.type = BTRFS_ROOT_ITEM_KEY;
+			root->root_key.offset = i;
+			root->track_dirty = 1;
+			root->node = btrfs_find_create_tree_block(fs_info, 0);
+			if (!root->node) {
+				free(root);
+				ret = -ENOMEM;
+				break;
+			}
+			clear_extent_buffer_uptodate(root->node);
+			ret = btrfs_global_root_insert(fs_info, root);
+			if (ret) {
+				free_extent_buffer(root->node);
+				free(root);
+				break;
+			}
+		}
+	}
+
 	return ret;
 }
 
-- 
2.26.3

