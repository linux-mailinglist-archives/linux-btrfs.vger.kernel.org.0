Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A4E4762EC
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbhLOUPG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbhLOUPG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:15:06 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0770CC06173E
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:06 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id de30so21311136qkb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gpEXg6Ak8RHRCUV/18ApRVwi9mo/U+5fevoU0rqcPpk=;
        b=uiT6uveJfX9AgZnhlVVyRvRaQw4C6wAKK7qiK8TfZ1CDi53e/fEtJ9U15RI/bn56Hk
         C6/Y195outKWL6eNz/dAZRpgCwneFikuRuGkkxmwCVtHgT7/sflolz/h0g7uOIMlo7x+
         /G/bYjBtYI+oV+yZ+ZIu8Xjzt28WuznenCocjfMvuXaGHg/LBE8W3S6Cj7j4whuykOvX
         GWo91bDlw4IvvOGAHlTY/0v37XtTcW4UdRGws/hwb9UdsI1VwFq5sp1ex9lYd7rRuqO6
         ptWP+LFUcOwLJk5UswV2vrAB4pP4NxE4iD057o8l58p9cu6BWQsx55ZHK0cEVpZkEPSV
         1SwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpEXg6Ak8RHRCUV/18ApRVwi9mo/U+5fevoU0rqcPpk=;
        b=U3FuvyqX6bGy/AJYAVA0ImZiFEkDljvpq+TRR7fE38jaym2FS6m5wJVyyaovYIfk8o
         mftjnagQAT5EmzKISe+wyjzQsI15O0AEQBOZfNBs0M4NpIBxSAecqmvlrW65u4uky6pl
         N7dGjdhsG4O3ocTd8Izz/QoDaxr6LEWYH9QJHavZbZBUfkmAVjNL72dBSH4Q8/gMGpLS
         pKkXhv7zLBLRSn3ARP4rLCZx8zLlQdV+qaW5gLVI0c3Ped37jv0ZL8MZnj0WQqv9Zg2R
         +qgPH5GHkzACktRFzve1uBwidCrBsidV2dZtB/khcP4BRJGBpcOnq5F0BIodX17Gh3bF
         LMjg==
X-Gm-Message-State: AOAM530wmrs3UBCFi1HQ8k7VAmalrkH5YD2NSsscomnzxl2YD3S5RzOD
        aXEakdp+3AxeioLWzBrcCFQ+e1EizWYbzg==
X-Google-Smtp-Source: ABdhPJwFg07JVOvCKoxKfg5Of8nA8LQgpvrvV9kpoRRffw1jKatpILDF5hUDnZI//lqdJenXHGFZcQ==
X-Received: by 2002:a05:620a:2948:: with SMTP id n8mr10565855qkp.620.1639599304969;
        Wed, 15 Dec 2021 12:15:04 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o1sm2395528qtw.24.2021.12.15.12.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:15:04 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/15] btrfs-progs: do not insert extent items for metadata for extent tree v2
Date:   Wed, 15 Dec 2021 15:14:45 -0500
Message-Id: <12f57b58282e51bd5d113a0e3ac2504bfaee812c.1639598612.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598612.git.josef@toxicpanda.com>
References: <cover.1639598612.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For extent tree v2 we are no longer tracking metadata blocks in the
extent tree, so simply skip this step and remove the space from the free
space tree and do the block group accounting.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent-tree.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 1af3eb06..7beff7ee 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -2392,6 +2392,9 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	sinfo = __find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 	ASSERT(sinfo);
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		goto alloc;
+
 	ins.objectid = node->bytenr;
 	if (skinny_metadata) {
 		ins.offset = ref->level;
@@ -2445,11 +2448,12 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_free_path(path);
 
-	ret = remove_from_free_space_tree(trans, ins.objectid, fs_info->nodesize);
+alloc:
+	ret = remove_from_free_space_tree(trans, node->bytenr, fs_info->nodesize);
 	if (ret)
 		return ret;
 
-	ret = update_block_group(trans, ins.objectid, fs_info->nodesize, 1, 0);
+	ret = update_block_group(trans, node->bytenr, fs_info->nodesize, 1, 0);
 	if (sinfo) {
 		if (fs_info->nodesize > sinfo->bytes_reserved) {
 			WARN_ON(1);
-- 
2.26.3

