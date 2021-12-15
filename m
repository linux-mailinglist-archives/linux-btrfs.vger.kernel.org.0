Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B19047626E
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhLOUAF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbhLOUAE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:00:04 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0231C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:04 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 132so21189834qkj.11
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zzGoFbPaHjYxOdEvMNYA2KUeGYoOWZmWRW9btUenLJA=;
        b=7yCtJYHWfqARs8sKPp26qh2IWBqAgfIXwYEC+5RbEu5oabm5E2SoiPZ0a999FK4/ng
         wWvLvd7A+nfU2DJEyPJjUqgXQZnUYUlFo1PteLGkYPw8uJZhQXUX4GlVwCHnHdU/iZM8
         Nswyd0e9vBFsAhpHQV85q9HSlzen0shAE3JpSPrtQUWLHHoNnV/D2Db0kXyve3+Miqdv
         7qx4AJjp/yknvhIfjb0YBdpFLpCpREuCX3Gc1s+1v38b/5tW9Rhr+XFGAGV0f+Hdb5bk
         EUYMRu2aVgs2P5QEVu8lvhmYzjpfRsqA2bHn2yRm37qc7mAVaiL+Nt0vMD6YHAUef7HT
         yIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzGoFbPaHjYxOdEvMNYA2KUeGYoOWZmWRW9btUenLJA=;
        b=C0Ef/BSrzDorUd+VaO0e4FshV6yAQNmp3Lyrni3mi+IJhwf4grU+C2QkJ25Z1i2wk9
         jp6y3IIk4aw9YR5zL5W5hzwym02eqps0l6SGSlcQjEtVfwURuJWsHXe1DENyV4gxCx/C
         3otaE7gCU0Z8/xSCDSnA59beVaubVQOeuy3u7QTMiRYWFcpMRi63YT9wAg1m1j+P+Dme
         Cu6XL7NFRHw+KL2/u1MWMab8E//HaHLdMHQ+aQLGsNF6fDDh/WzNnsTD93WjQjWciZ8X
         3U7LgZgznopO0oyv9+b9Ptx62b4bypRGNBA606npKa6miQ2Q0Ap+5emRfJnMlp7KWHnA
         7c0Q==
X-Gm-Message-State: AOAM532r8dBbkNnj7twp+oH8B78UK+VA8ydL9qD+Ujw20UGwVmklgd1Z
        cxHlY1JPaBJj7FSz8uLl7VJgump1WfM+sg==
X-Google-Smtp-Source: ABdhPJxO0ooutcmOZjhUBR7T7n5TqeGYQNkJl38S5jLHRlFBVkJoh3VEwmbmQdqItRdgL0dUOxuPNQ==
X-Received: by 2002:a05:620a:ce5:: with SMTP id c5mr9836572qkj.285.1639598403215;
        Wed, 15 Dec 2021 12:00:03 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w10sm2246922qtj.37.2021.12.15.12.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:00:02 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 08/22] btrfs-progs: handle no bg item in extent tree for free space tree
Date:   Wed, 15 Dec 2021 14:59:34 -0500
Message-Id: <c2b3de1cd666a611c6b128456f7b51e51d9eb1b5.1639598278.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598278.git.josef@toxicpanda.com>
References: <cover.1639598278.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have an ASSERT(ret == 0) when populating the free space tree as we
should at least find the block group item with extent tree v1.  However
with v2 we no longer have the block group item in the extent tree, so
fix the population logic to handle an empty block group (which occurs
during mkfs) and only assert if ret != 0 and we don't have extent tree
v2 turned on.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/free-space-tree.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 0fdf5004..896bd3a2 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -1057,6 +1057,9 @@ int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
+	start = block_group->start;
+	end = block_group->start + block_group->length;
+
 	/*
 	 * Iterate through all of the extent and metadata items in this block
 	 * group, adding the free space between them and the free space at the
@@ -1071,10 +1074,11 @@ int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	ret = btrfs_search_slot_for_read(extent_root, &key, path, 1, 0);
 	if (ret < 0)
 		goto out;
-	ASSERT(ret == 0);
+	if (ret > 0) {
+		ASSERT(btrfs_fs_incompat(trans->fs_info, EXTENT_TREE_V2));
+		goto done;
+	}
 
-	start = block_group->start;
-	end = block_group->start + block_group->length;
 	while (1) {
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 
@@ -1106,6 +1110,7 @@ int populate_free_space_tree(struct btrfs_trans_handle *trans,
 		if (ret)
 			break;
 	}
+done:
 	if (start < end) {
 		ret = __add_to_free_space_tree(trans, block_group, path2,
 				start, end - start);
-- 
2.26.3

