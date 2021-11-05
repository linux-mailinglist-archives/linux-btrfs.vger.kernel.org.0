Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1D74469D8
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhKEUnm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhKEUnl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:43:41 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEBEC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:41:01 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id l12so7805588qtx.7
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zzGoFbPaHjYxOdEvMNYA2KUeGYoOWZmWRW9btUenLJA=;
        b=5Qs6M2XnHVQAjrLa+CxL0+IA+lmWK/E+yEYNijk2ca4P+NC/XezobHPNMHsS6E4P1J
         EEUmRwqCtFQSfSIJTSov2reA77Y+ToDcgN2wah8iqrsutsveVpeiqMJbwMpkG/u0kXDU
         Q153qAMMnLX0cPQAxG1Gp9zQFn5yx3p3l3rM2AaIqh3/FbKmLHWmvC02MmVgGosivKZv
         WOdkyVKwKhFilHsOWNXtS8OQ0K78PjC58G5XOE4h4ChdDPT1Pt6Pteei1+E/NalQDjz0
         9e6xL/wVT11rsZFwMe3/szCd0pl4L+vSF6//HXyGFwgBK2toh4bYoZ4cHESO9SwJtuiS
         GWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzGoFbPaHjYxOdEvMNYA2KUeGYoOWZmWRW9btUenLJA=;
        b=2Je/olpEBfSrOTCMcZlwoJHUCYX8U4TmKEhU+AKZS4mfm6zX4uzSvCCMOKxgOAN+kz
         Pmb75LiKedhZkkN3p6RKNyWQIX1lGM1a74PSn4pIkfQGw+L+p4wh9wB3cg/72kEw5JsR
         wo/n0EA+6CFL+G6fkhjfD87vhgSTVfonQul/7XtelIy18yrG2CBaYHn/XzVHgKPZVDdL
         FhbAM5e8hjAxJRyxuC7vo4VSsZnYUaz96RzZFQkKUg2Lcs7SXJadg1gAYa3wWAwjVb1A
         +tppBZqwWZzPqBaQQqioeIn/2J3oGrYCPSmEgTaJL7KVp5HHgcapx+X4rKCUxf/8Uubv
         +02g==
X-Gm-Message-State: AOAM532TOgCvq04WzacDgliqSK3ucUOzEpJIhiMS8TNnjqCuAU8wHCox
        go52P8ZYxQVmK1vHiTmPHhMBWRjmy3DdQg==
X-Google-Smtp-Source: ABdhPJxaSB6kv9HZ1QBBj/8wcoXZC8JjHqihfBxvme6LMbV+N2MvrJC45PMfQD527IKnvofoibjjTg==
X-Received: by 2002:a05:622a:394:: with SMTP id j20mr65502268qtx.386.1636144859995;
        Fri, 05 Nov 2021 13:40:59 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w9sm6181896qko.19.2021.11.05.13.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:40:59 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/22] btrfs-progs: handle no bg item in extent tree for free space tree
Date:   Fri,  5 Nov 2021 16:40:34 -0400
Message-Id: <ce42c1f18b80994e554fec7aa3a885bbb2656484.1636144275.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144275.git.josef@toxicpanda.com>
References: <cover.1636144275.git.josef@toxicpanda.com>
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

