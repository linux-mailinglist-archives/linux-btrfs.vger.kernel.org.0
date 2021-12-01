Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B26465525
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352249AbhLASVH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352240AbhLASUv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:20:51 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3C3C061574
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:17:30 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id l8so24991201qtk.6
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zzGoFbPaHjYxOdEvMNYA2KUeGYoOWZmWRW9btUenLJA=;
        b=rWD1nK7qpDbeO90wudJouXkeaxvIPY45tTCHg4q5aCsHRRaPOFHlTPVR4mMSuHZ4dN
         L1iD3pmzX/gn34cRA9O8beq2TDXUDvsf/1eIcT31/Mng53H0DUBVYX+Ce1Td5r6VD7p+
         BVX6pFBLM0/TvbRbmi4DQ161oI1MEgsgdQIp9BL/Tny56dnz4El/DJt/WKSge6fbPLJI
         cpYTRxaqrliMO2oOgLizKXiDsJkIqQ/lUNr6cBaLKQphgvYYHHV2C5BVY/TR2vsNy9RZ
         WA24nlhJj2NgdoDFSx3JcHhuNkOx6h9/5vidaEf1bwdzgaXXmodCpS3QOWsUS6SyqSSh
         IFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzGoFbPaHjYxOdEvMNYA2KUeGYoOWZmWRW9btUenLJA=;
        b=ufJ/BMk2Rcsfn9vQduL/D44UWdL9F0MqZ59zEyLQAMb9SbhzhMDk66IXZMwEGaFoCL
         9MfZ4q+BAduARLlIt7d4HO0uUtJ9WyZJf+sQW8Ynoyh5uw6ymIdVtZj2xFcq+IxhpyLN
         8ZxVuZQECn6/nzMtAFCTEWzKOc2qi/ieHD63tWGubFalVlxf5/R58GER/2UbWhgf/PEN
         Du6b336KZQB45zs+sdOHVkkvrtd6Vdtm1hIXvR87P19zIiQpWWFoNurZvJGkXJAlVwsq
         t7yZQLzOvfEBGtSrjoCcVUR4qhMJDEcdn65qNNIACnk1hFVCs25Dcwor4Ib8EYYHh0rf
         lf/A==
X-Gm-Message-State: AOAM531u6pVYE7YOTgpu5KhniYzqpBVk+qrMBcFJQrn1HW1SUxYdX0Ei
        tgy1MOwxGxYwYvifKJgO+RceGxEBO3zfuw==
X-Google-Smtp-Source: ABdhPJwt+l4ag2J9vwmTUfL+n9k3gkkUlO+b2CN25uFFAlIB0EqdSVnaQVn1fYe0GLK9Oo9F+izeHA==
X-Received: by 2002:a05:622a:1312:: with SMTP id v18mr8527479qtk.177.1638382649073;
        Wed, 01 Dec 2021 10:17:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m9sm247079qkn.59.2021.12.01.10.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:17:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 08/22] btrfs-progs: handle no bg item in extent tree for free space tree
Date:   Wed,  1 Dec 2021 13:17:02 -0500
Message-Id: <efb95c539b70183e1afa363fefa919c0d3f63b4d.1638382588.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638382588.git.josef@toxicpanda.com>
References: <cover.1638382588.git.josef@toxicpanda.com>
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

