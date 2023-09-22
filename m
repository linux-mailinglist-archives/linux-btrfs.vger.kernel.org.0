Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3748C7AAFBD
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 12:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjIVKj1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 06:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjIVKjX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 06:39:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2799CC6
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 03:39:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479DAC433C9
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 10:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379156;
        bh=6DlJ1krS+nsNbOzeaQdSWdPdqkEYQPl7zMFu4I/iN0A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cODs+yIs5Gk3zlh4BtabECZMc3eZyhljBGFV5oOvSzdha4lteXj6+4Z/mn+7bueYp
         kvmR8UT5HYHjViZtMsS63nxIiL1VB3+4TLk5CgeFIoHtLOBf0GPXeXtGmaWOT8CCFG
         uU9gFgGCxdpRGeqRJ7zZvmMXBCfuzyoRRfpon9rfllzH2ALPA4sf7oazqOJvSgGtTO
         Mg7t2bzY4dzJz8NjK4pXCfZO20MmBIE0n0YDpPg9Tk7Yt8s1i6++PLLThlZlqNkMpZ
         tZKMv1TowpuE0HLzepAgNsDtGwIBX0v/LoYrko+yiCQJatSe9prjuu8pKDSmtp4Dfe
         gMYA29nw/Cq3g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs: make wait_extent_bit() static
Date:   Fri, 22 Sep 2023 11:39:04 +0100
Message-Id: <b890f86f43d87fcac4cfa1931e97d5c15b0eb6a7.1695333278.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695333278.git.fdmanana@suse.com>
References: <cover.1695333278.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The function wait_extent_bit() is not used outside extent-io-tree.c so
make it static. Furthermore the function doesn't have the 'btrfs_' prefix.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 4 ++--
 fs/btrfs/extent-io-tree.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 1ca0827493a6..033544f79e2b 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -766,8 +766,8 @@ static void wait_on_state(struct extent_io_tree *tree,
  * The range [start, end] is inclusive.
  * The tree lock is taken by this function
  */
-void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
-		     struct extent_state **cached_state)
+static void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+			    u32 bits, struct extent_state **cached_state)
 {
 	struct extent_state *state;
 
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 28c23a23d121..ddcc8bbf1a05 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -192,7 +192,5 @@ int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
 bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 			       u64 *end, u64 max_bytes,
 			       struct extent_state **cached_state);
-void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
-		     struct extent_state **cached_state);
 
 #endif /* BTRFS_EXTENT_IO_TREE_H */
-- 
2.40.1

