Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A052A0FDF
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 22:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgJ3VDT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 17:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgJ3VDT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 17:03:19 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B25C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:19 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id i21so5457962qka.12
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=489xY/ksKkbphR6OI0Tcd5nO9x9Gb8yGvGWYLqRlrv0=;
        b=QxjRj6intARIE+TX+7e32N4Wd5S3mWkXfqzvFEMyB+XNaUAOJc700ftA94pEfXvq7z
         oEW8ZYDKFQLi1pqymxu1cuhfP02bsL8HahDPQpiBRokCaHE0qMg4Y0u+BVv2TmzGZHQi
         304erLg8PZpQI8oxYPtyZ9aF4L9RNNs25P6HnYng0kzc/0kddghG8rdvTUbxBwOqIhOr
         PWQLcLBHn1yvTDAr/iRJ+CkvVtxhT5CqoeQhlTMPStd+PzSFCDP1uwaMn1eJYmMAM3kl
         Rre6ekP7vC9EWq3Pij46VCW6cAGKDbkX7LDHen3MNJ4fh8mFKYxP68j6TxSvLequAII9
         kojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=489xY/ksKkbphR6OI0Tcd5nO9x9Gb8yGvGWYLqRlrv0=;
        b=H+eY92Nmr+LfFXbomYt20QVbEfFkMb3PXdj0jjnQBORxOMV9cV6aSemB865iJsfpQ6
         63WPBvl3ifrgIsI3mp7VH06wSHYFjlZHNKDNrAfQRsXcTImzcCPC5+84h/tXztdKeNWq
         c42P1m5+AWUdRm/6QK5BKZg4RpxSi+o8Tpxw9Toajuw8SvsRd3ciaNpRicIRRMzd7zOH
         WjurcIS8SF4bIoOleu5xeOvKbj4IA80HYfncbh5M+364boYhzuQKZH/52Uw8w15GzeJJ
         9yI8/SGwgJmZM4z61wTz97VqtbuZ+AkAPqQc4Uj8Wzg0nx4n1FRVuqZdkLyEiqCeBUT5
         J7hQ==
X-Gm-Message-State: AOAM530tOvjOwL2Pllwenm7RhROfj6G4s47JnD0D3ToyItP2QU62+Lf7
        stTsANwofvw379H+59mE8OpWmNRBL6EfMRi5
X-Google-Smtp-Source: ABdhPJzLUiIB0T/BQWKUdr8c5lXFf0eT8fazNtDyG4io5lhkoaVmztD7yshanS/1obqymCJxJLjRGQ==
X-Received: by 2002:a37:a411:: with SMTP id n17mr4059033qke.230.1604091797939;
        Fri, 30 Oct 2020 14:03:17 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u5sm3340415qtg.57.2020.10.30.14.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 14:03:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/14] btrfs: use btrfs_read_node_slot in do_relocation
Date:   Fri, 30 Oct 2020 17:02:57 -0400
Message-Id: <ecaac3d0674a2ba8ec0427ce95d8e52eb38298c6.1604091530.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604091530.git.josef@toxicpanda.com>
References: <cover.1604091530.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're open coding btrfs_read_node_slot in do_relocation, replace this
with the proper helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index bf31b86945d5..874ae92c0df4 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2194,7 +2194,6 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			 struct btrfs_key *key,
 			 struct btrfs_path *path, int lowest)
 {
-	struct btrfs_fs_info *fs_info = rc->extent_root->fs_info;
 	struct btrfs_backref_node *upper;
 	struct btrfs_backref_edge *edge;
 	struct btrfs_backref_edge *edges[BTRFS_MAX_LEVEL - 1];
@@ -2202,7 +2201,6 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 	struct extent_buffer *eb;
 	u32 blocksize;
 	u64 bytenr;
-	u64 generation;
 	int slot;
 	int ret;
 	int err = 0;
@@ -2212,7 +2210,6 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 	path->lowest_level = node->level + 1;
 	rc->backref_cache.path[node->level] = node;
 	list_for_each_entry(edge, &node->upper, list[LOWER]) {
-		struct btrfs_key first_key;
 		struct btrfs_ref ref = { 0 };
 
 		cond_resched();
@@ -2285,17 +2282,10 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 		}
 
 		blocksize = root->fs_info->nodesize;
-		generation = btrfs_node_ptr_generation(upper->eb, slot);
-		btrfs_node_key_to_cpu(upper->eb, &first_key, slot);
-		eb = read_tree_block(fs_info, bytenr, generation,
-				     upper->level - 1, &first_key);
+		eb = btrfs_read_node_slot(upper->eb, slot);
 		if (IS_ERR(eb)) {
 			err = PTR_ERR(eb);
 			goto next;
-		} else if (!extent_buffer_uptodate(eb)) {
-			free_extent_buffer(eb);
-			err = -EIO;
-			goto next;
 		}
 		btrfs_tree_lock(eb);
 		btrfs_set_lock_blocking_write(eb);
-- 
2.26.2

