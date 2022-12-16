Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF02664E4F5
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 01:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiLPAGu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Dec 2022 19:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiLPAGr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Dec 2022 19:06:47 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52A45EDE8
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Dec 2022 16:06:46 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4BA555C0061;
        Thu, 15 Dec 2022 19:06:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 15 Dec 2022 19:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1671149206; x=1671235606; bh=ao
        5cKxU5OtHoKbaskCkrtRXvuJVZ8p0FrE4XUbVTIK0=; b=xhjoT3d+TKxRicwMIG
        4Be3C+hlDd7BkPrQnUXAxE0EtYQDLgyVho76/dmydvv+uYgz0Nv1A5ApMAhRykz4
        QjjA4lUt7YrJzFwg0+11nrQegEU7iwffGPsdnfJ3iQQnzOvVQTjXIKdksOLWFnk1
        dT1zjxCsePos9Oa9E62llp1JEJ1R+HWQ2/gRva+k5lfYOUX3rGFG3CnvLV+g4sQg
        Turgg0We/8POy5R9VOIco/eKpIqPUchZfYbPbdZ3PyE8546Ydya+qNI8M2dykkyh
        CvVIPmh8LU1Jvy6EGPPuRU3tot6QzTKu35T5M3FEE7k6vRPl0Ou8UHb3qOH3HhOC
        wbiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1671149206; x=1671235606; bh=ao5cKxU5OtHoK
        baskCkrtRXvuJVZ8p0FrE4XUbVTIK0=; b=s7MIWI8Ic46ixYXyKfzmu/YoD7AUC
        ruc4CfE+lTZvOA7S3W7V/xnP0KnsO6g8nZq/QQKbD9st76FHYFT1HrG+cHaOe4RB
        GwYUxcRmKtqljyg0wwQ7E1L+/byRutapydfnV/N2/zekHO3wd9vECjlOsCGZZuGU
        +pBROWnGX+3tdvI261+fhkQt82ohI0taNV5HRsyJEtndqj3XoRErt7HxfijgB/cW
        yIsJFUWeuA5k3pwsnmaVqGaanICx25vQYuFeTi215bjp0oiZZ5kZbakTl+CvUYuX
        0YvbY4ciE7sw0UyqmkotLLme82sy6c1GqI2/0vWQigT6cU2QGCJZJ5K9g==
X-ME-Sender: <xms:lrabY9aTDIuelZfkuqgMUku8eJXld8liXuOa-0kpQLdAlVZa96-qkw>
    <xme:lrabY0ZSa6bv4yLPv9Bcydbfbq-JX5xVLXC7b0EDXlSD_Nc41Wul_wuoBlBoJCM2Y
    c6SnabaxmRqzCtwjWs>
X-ME-Received: <xmr:lrabY_9DhcvuvR5woOG3-6e1G0vvIVGRXT7r2jXMFvYTHOHU3jK6q9sZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeigdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:lrabY7p5zHj_zDaGKTn_T-AgY51IkUqvR_RVbFy7Z0nOwOvNd2I9Jw>
    <xmx:lrabY4q0KOTCpHAqX-Iw2R4fZFN-j6E0yxw6Sa01Z8yiA6s7XWQ69g>
    <xmx:lrabYxR3p1P2QslcpUNNN1--PvPAHPJGu2b_GLRZfxXQ4Yr1cJ6ROA>
    <xmx:lrabY_RBkV5VTRCkrQFe0ijdGe8WvST-arjvjrN6d2-ghktPccUwsQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Dec 2022 19:06:45 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 5/5] btrfs: dont use size classes for zoned file systems
Date:   Thu, 15 Dec 2022 16:06:35 -0800
Message-Id: <6214dfa0a7191e4e7b4a24fb24ef9c9562001012.1671149056.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1671149056.git.boris@bur.io>
References: <cover.1671149056.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When a file system has ZNS devices which are constrained by a maximum
number of active block groups, then not being able to use all the block
groups for every allocation is not ideal, and could cause us to loop a
ton with mixed size allocations.

In general, since zoned doesn't write into gaps behind where block
groups are writing, it is not susceptible to the same sort of
fragmentation that size classes are designed to solve, so we can skip
size classes for zoned file systems in general, even though there would
probably be no harm for SMR devices.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 13 +++++++++++--
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/extent-tree.c |  2 +-
 fs/btrfs/zoned.c       |  2 ++
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 75d5f952067a..0a691778551b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -646,7 +646,7 @@ static int load_block_group_size_class(struct btrfs_block_group *block_group)
 	enum btrfs_block_group_size_class size_class = BTRFS_BG_SZ_NONE;
 	int ret;
 
-	if (!btrfs_is_block_group_data_only(block_group))
+	if (btrfs_block_group_should_use_size_class(block_group))
 		return 0;
 
 	for (i = 0; i < 5; ++i) {
@@ -3579,7 +3579,7 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
 		goto out;
 	}
 
-	if (btrfs_is_block_group_data_only(cache)) {
+	if (btrfs_block_group_should_use_size_class(cache)) {
 		size_class = btrfs_calc_block_group_size_class(num_bytes);
 		ret = btrfs_use_block_group_size_class(cache, size_class, force_wrong_size_class);
 		if (ret)
@@ -4420,3 +4420,12 @@ int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
 
 	return 0;
 }
+
+bool btrfs_block_group_should_use_size_class(struct btrfs_block_group *bg)
+{
+	if (btrfs_is_zoned(bg->fs_info))
+		return false;
+	if (!btrfs_is_block_group_data_only(bg))
+		return false;
+	return true;
+}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index aaf5ca49defb..a8e7a02cad4c 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -359,4 +359,5 @@ enum btrfs_block_group_size_class btrfs_calc_block_group_size_class(u64 size);
 int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
 				     enum btrfs_block_group_size_class size_class,
 				     bool force_wrong_size_class);
+bool btrfs_block_group_should_use_size_class(struct btrfs_block_group *bg);
 #endif /* BTRFS_BLOCK_GROUP_H */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f39d9117c8db..23f90ed1f7f4 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4061,7 +4061,7 @@ static bool find_free_extent_check_size_class(struct find_free_extent_ctl *ffe_c
 {
 	if (ffe_ctl->policy == BTRFS_EXTENT_ALLOC_ZONED)
 		return true;
-	if (!btrfs_is_block_group_data_only(bg))
+	if (!btrfs_block_group_should_use_size_class(bg))
 		return true;
 	if (ffe_ctl->loop >= LOOP_WRONG_SIZE_CLASS)
 		return true;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index a759668477bb..fccc947d6c66 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1367,6 +1367,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		 */
 		if (!device->zone_info->max_active_zones)
 			__set_bit(i, active);
+		else
+			cache->has_zns_device = true;
 
 		if (!is_sequential) {
 			alloc_offsets[i] = WP_CONVENTIONAL;
-- 
2.38.1

