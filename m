Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B3D4D0A95
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242436AbiCGWMI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242390AbiCGWMH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:12:07 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD98B75C29
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:11:12 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id e22so13215148qvf.9
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uA/URwCGn8bAA/76csPGjEdob3EPniuO7fG1hMDS2jA=;
        b=ON/XERb1hGS41ZCnUGXT6OXp+9Nsch3TmdFmIcXHW93nTt6pQTWB4a+gfpffyCXMtP
         CAXtBJqhn7rooSw7wIUg1qEzpuF/q8g6ZJJZqxqTXSkD1Ra5Kh6eBk++xOIZBLQfpa0K
         avmlfjQhDUJXqZT49CL4QxTB2ViS/5oBEJLYZ2d4o9DIrf9EwLoY8IwAcOaSqOv6UFXP
         PYlmWtA/tSAFWeAPFAtNTHFViMZ8APGtVFiEudlhYa5ZM9i/DcvAb980kOpgDQokdKji
         OTXj4k9dhQYLe/Lkphvbe5wLHobksFmS5zKAyK27nd+lU87Yh70bC0MNlmFqdg5OK5Nt
         6yxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uA/URwCGn8bAA/76csPGjEdob3EPniuO7fG1hMDS2jA=;
        b=EIO6ie1xjKS6nCzYMD8vuF9+508je+oQZq2Qkek2rBkkh5jCQbErpgeIanTvEOvzPJ
         IZdKZRZdIKArOZh0TocvJMdzcO2pPLwTniMizK/obZAADPruFoXRTFOso4alzJvJ8rDk
         +yqAzuj1Q+ML54EcS8f3Fl2i9U6hbeuwQoZ5U/blBZUwRjdJPgujUlpi+A1MPdWLCcW4
         ycufjpErNkjseAh19ANHKj1bi5sDMstavr8tbUhiLjjdRAn4N+smD3bWESJCJJ+Fl9v8
         01BkuMfPyAsFe/NrI6iTKXB0OP909/vkib/+VI9pQvQakQVSnXEDEJzAXQt8t+4JiS3/
         OvrQ==
X-Gm-Message-State: AOAM531SkQlSvEsZ0zgTB78k/7CkmBnU9zFSByMuSQ4aB5AkyfEvKXeX
        h6mqJNmvbh7+xWk+GrhSHwb2GUUqRMr2phxs
X-Google-Smtp-Source: ABdhPJzhxWFZZhKFRhYA62zgX4wijsE9xIJUD+5iXO94/5aFH+DiYRcIFlytuVr1hisWirirAohkcg==
X-Received: by 2002:a05:6214:1c05:b0:433:20a5:af76 with SMTP id u5-20020a0562141c0500b0043320a5af76mr10188915qvc.112.1646691071590;
        Mon, 07 Mar 2022 14:11:11 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e14-20020a05622a110e00b002d9d03dfe06sm9644540qty.2.2022.03.07.14.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:11:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 04/19] btrfs-progs: check-lowmem: use the btrfs_block_group_root helper
Date:   Mon,  7 Mar 2022 17:10:49 -0500
Message-Id: <47a06a95b02bc5e75417ed3d0cbf450aa8b1ddf2.1646690972.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646690972.git.josef@toxicpanda.com>
References: <cover.1646690972.git.josef@toxicpanda.com>
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

When we're messing with block group items use the
btrfs_block_group_root() helper to get the correct root to search, and
this will do the right thing based on the file system flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/mode-lowmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 99d04945..8535e684 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -266,7 +266,7 @@ static int modify_block_group_cache(struct btrfs_block_group *block_group, int c
  */
 static int modify_block_groups_cache(u64 flags, int cache)
 {
-	struct btrfs_root *root = btrfs_extent_root(gfs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(gfs_info);
 	struct btrfs_key key;
 	struct btrfs_path path;
 	struct btrfs_block_group *bg_cache;
@@ -331,7 +331,7 @@ static int clear_block_groups_full(u64 flags)
 static int create_chunk_and_block_group(u64 flags, u64 *start, u64 *nbytes)
 {
 	struct btrfs_trans_handle *trans;
-	struct btrfs_root *root = btrfs_extent_root(gfs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(gfs_info);
 	int ret;
 
 	if ((flags & BTRFS_BLOCK_GROUP_TYPE_MASK) == 0)
@@ -419,7 +419,7 @@ static int is_chunk_almost_full(u64 start)
 {
 	struct btrfs_path path;
 	struct btrfs_key key;
-	struct btrfs_root *root = btrfs_extent_root(gfs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(gfs_info);
 	struct btrfs_block_group_item *bi;
 	struct btrfs_block_group_item bg_item;
 	struct extent_buffer *eb;
@@ -4601,7 +4601,7 @@ next:
 static int find_block_group_item(struct btrfs_path *path, u64 bytenr, u64 len,
 				 u64 type)
 {
-	struct btrfs_root *root = btrfs_extent_root(gfs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(gfs_info);
 	struct btrfs_block_group_item bgi;
 	struct btrfs_key key;
 	int ret;
-- 
2.26.3

