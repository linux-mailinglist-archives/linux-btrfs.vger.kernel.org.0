Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42D65BCE07
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 16:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiISOGt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 10:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiISOGs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 10:06:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7212A96B
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 07:06:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B9FF61CFD
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A50C433D7
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663596406;
        bh=F9OTfd59vVhJ+W+Zt4UJxMnkvEnWzWhu1CpWZI35Cns=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XnUyDWggyiUC0k5Lywq1Mg8DZ0MzLy7Ls4sY+Tckn3vSF0saP4PGFehKw5mkYI5it
         lou5NF/0qBC3rlQCnThixk7ulXvYLPlN8Je1xzcMbY6LuAC5qAUCp4D3aNuyqeZbOT
         oS0lV991IJHBiloJVOdzIH/kUzUwOod+zzYWzKf2KQha0lfLdw7zRVFb4bCDvKLFLv
         N9tyIswe5VdwcNhPjYE+dlowWjW1cGibsHDQPazocEsb85aJ8x9xJ27BwgR9lar/Ls
         ol5Xz3O/jmqU+mbQ4pqVJt12zQsndP/6KltR4DFA/wVocro8ChxOpEnkABYeSAEArx
         ezydrzB29fArw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/13] btrfs: use extent_map_end() at btrfs_drop_extent_map_range()
Date:   Mon, 19 Sep 2022 15:06:30 +0100
Message-Id: <3b02c4743f54ecd0b46e382981a0f8d4c6e5d793.1663594828.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663594828.git.fdmanana@suse.com>
References: <cover.1663594828.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Instead of open coding the end offset calculation of an extent map, use
the helper extent_map_end() and cache its result in a local variable,
since it's used several times.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 587e0298bfab..28c5e0243adc 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -690,6 +690,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 	}
 	while (1) {
 		struct extent_map *em;
+		u64 em_end;
 		u64 gen;
 		unsigned long flags;
 		bool ends_after_range = false;
@@ -710,7 +711,8 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			write_unlock(&em_tree->lock);
 			break;
 		}
-		if (testend && em->start + em->len > start + len)
+		em_end = extent_map_end(em);
+		if (testend && em_end > start + len)
 			ends_after_range = true;
 		if (skip_pinned && test_bit(EXTENT_FLAG_PINNED, &em->flags)) {
 			if (ends_after_range) {
@@ -718,9 +720,9 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 				write_unlock(&em_tree->lock);
 				break;
 			}
-			start = em->start + em->len;
+			start = em_end;
 			if (testend)
-				len = start + len - (em->start + em->len);
+				len = start + len - em_end;
 			free_extent_map(em);
 			write_unlock(&em_tree->lock);
 			continue;
@@ -767,7 +769,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 		}
 		if (ends_after_range) {
 			split->start = start + len;
-			split->len = em->start + em->len - (start + len);
+			split->len = em_end - (start + len);
 			split->block_start = em->block_start;
 			split->flags = flags;
 			split->compress_type = em->compress_type;
-- 
2.35.1

