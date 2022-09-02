Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46865AB949
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiIBURj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiIBURd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:17:33 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43E1D8E14
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:17:32 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g14so2336610qto.11
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=gz6bRoIfAhL2QVg/hVUDAaMs8W87PD05jLnQ0mOTd5w=;
        b=iU5b03KYanIHrHx5S8+V2uVMsSS8LekORuzkGr3xLXF3iAYic+qeVPYbJSXun+x9F/
         u5njOhHAAD4ynskZPH9Gwh+EWxB1c98PN8izlWUTs8Coo6FwdDcqhdcO+DE17BcvklMo
         GzPjQek5/imcOPHvcIAI0Byn+uxRHIicckq/tjeFFuMO+XW4DkpuWFJHEoaq90sl6Gin
         3RHzYcM8s5dIg/C50gCy3cFJUYr3VxTGVNcz2MBqiZaXO5+SFe48TRBVT8EDF7x3+PVT
         VxlHZRn53G1H26XSMkJbyGv9k2bK4Ij134f3akd96Xcw4uDaj5mVLyaNBw6RI3GNqyCw
         U21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gz6bRoIfAhL2QVg/hVUDAaMs8W87PD05jLnQ0mOTd5w=;
        b=GN+GakdOZxW3jpnuY0NCfsIzUfnTIext/YT7LDil2xI1hM5bXs5LOpNrqDclbcl9RK
         cCPwVSjMKxvhyJyvWnkmXaXd900nhu9ocMrixQ+1wVeBFwpZPC4pt4Qu/NZlUoVEofmf
         kkBOTYDL9NwobtKIYfpEx9vZkbSqqc8MaLQIrTk4Ct/IItpkd3ozASXJhz5IGph//hev
         aQnYJanMrq0ot6uw/HjIE60be8QAkhjXqNbxP65DGQbc2oVBMH3aMs3sABWNDTHllx7A
         9kx53kVfBJRYw9aJ9HuVMmXtDqV5CuqG2e06v6ci/+6qBfhWpMfu5UdaElPPMkGKflAy
         ZQXw==
X-Gm-Message-State: ACgBeo0ljzVyz6wmLaK451H0za5uAGJY1XkqwIbyenUKyLKuZFBPedCu
        H9plo3fmQfxQMGpIJF9ZsMqFKzX/vJlqvw==
X-Google-Smtp-Source: AA6agR5a6W0ppe824FdefcDITm06OXGGXjpLT0Zn6xvmmvIO3gPaWx/Y7nqOWjpE1YuhBaL59CBcpQ==
X-Received: by 2002:a05:622a:5cb:b0:344:551a:c804 with SMTP id d11-20020a05622a05cb00b00344551ac804mr29588887qtb.645.1662149852284;
        Fri, 02 Sep 2022 13:17:32 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w17-20020a05620a0e9100b006a6d7c3a82esm1966690qkm.15.2022.09.02.13.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:17:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 31/31] btrfs: remove is_data_inode() checks in extent-io-tree.c
Date:   Fri,  2 Sep 2022 16:16:36 -0400
Message-Id: <e84ddae2199bc7cb88ace4d398ce570243fc1453.1662149276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662149276.git.josef@toxicpanda.com>
References: <cover.1662149276.git.josef@toxicpanda.com>
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

We're only init'ing extent_io_tree's with a private data if we're a
normal inode, so we don't need this extra check.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index f37de54056e8..c67370469548 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -59,7 +59,7 @@ static inline void __btrfs_debug_check_extent_io_range(const char *caller,
 	struct inode *inode = tree->private_data;
 	u64 isize;
 
-	if (!inode || !is_data_inode(inode))
+	if (!inode)
 		return;
 
 	isize = i_size_read(inode);
@@ -332,7 +332,7 @@ static void merge_state(struct extent_io_tree *tree,
 	other = prev_state(state);
 	if (other && other->end == state->start - 1 &&
 	    other->state == state->state) {
-		if (tree->private_data && is_data_inode(tree->private_data))
+		if (tree->private_data)
 			btrfs_merge_delalloc_extent(tree->private_data,
 						    state, other);
 		state->start = other->start;
@@ -343,7 +343,7 @@ static void merge_state(struct extent_io_tree *tree,
 	other = next_state(state);
 	if (other && other->start == state->end + 1 &&
 	    other->state == state->state) {
-		if (tree->private_data && is_data_inode(tree->private_data))
+		if (tree->private_data)
 			btrfs_merge_delalloc_extent(tree->private_data, state,
 						    other);
 		state->end = other->end;
@@ -437,7 +437,7 @@ static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
 	struct rb_node *parent = NULL;
 	struct rb_node **node;
 
-	if (tree->private_data && is_data_inode(tree->private_data))
+	if (tree->private_data)
 		btrfs_split_delalloc_extent(tree->private_data, orig, split);
 
 	prealloc->start = orig->start;
@@ -485,7 +485,7 @@ static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
 	u32 bits_to_clear = bits & ~EXTENT_CTLBITS;
 	int ret;
 
-	if (tree->private_data && is_data_inode(tree->private_data))
+	if (tree->private_data)
 		btrfs_clear_delalloc_extent(tree->private_data, state, bits);
 
 	ret = add_extent_changeset(state, bits_to_clear, changeset, 0);
@@ -747,7 +747,7 @@ static void set_state_bits(struct extent_io_tree *tree,
 	u32 bits_to_set = bits & ~EXTENT_CTLBITS;
 	int ret;
 
-	if (tree->private_data && is_data_inode(tree->private_data))
+	if (tree->private_data)
 		btrfs_set_delalloc_extent(tree->private_data, state, bits);
 
 	ret = add_extent_changeset(state, bits_to_set, changeset, 1);
-- 
2.26.3

