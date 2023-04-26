Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635F16EF2CF
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 12:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240520AbjDZKxG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 06:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240506AbjDZKxD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 06:53:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B2159D1
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 03:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2DC563551
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 10:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B540FC433EF
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 10:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682506303;
        bh=uEcXpSozdvBbZ497I+QuwNthxNCOfkmSxRk/r3JMERI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CQmmGLCqy/CaAJuiCwbGTUnf5dUs20JZviiqJPz0rpfJz2za9y4igQMmVm+nREQd9
         CFCxO8dgLfkE/CKz10hFEpYe3selfT/gQMDyozQOTjTSRjG+FxhG8AO+xGxGCJoocT
         6pjTWUvpohMVah05cVTnpIn8k1WBCUHuEdX4m3pkcHjOtWDrqZkSYzZfgnxqfeKG3X
         FTX3OMWsIr8G2gTkbMEMJKw/nWdshKMok88wP5GIkpMpHu8yD6HsTZNkZP4HysI7Nf
         0ssaXsCBukXwA6GctRDEu5I4MHLMdbwGl4E9/3duIivnGWJejZwChMUlH7yBLz97mU
         w0hTLin4q0cdg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: tag as unlikely the key comparison when checking sibling keys
Date:   Wed, 26 Apr 2023 11:51:37 +0100
Message-Id: <8e323961434327423faeea50a3c6a09ff82a364b.1682505780.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1682505780.git.fdmanana@suse.com>
References: <cover.1682505780.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When checking siblings keys, before moving keys from one node/leaf to a
sibling node/leaf, it's very unexpected to have the last key of the left
sibling greater than or equals to the first key of the right sibling, as
that means we have a (serious) corruption that breaks the key ordering
properties of a b+tree. Since this is unexpected, surround the comparison
with the unlikely macro, which helps the compiler generate better code
for the most expected case (no existing b+tree corruption). This is also
what we do for other unexpected cases of invalid key ordering (like at
btrfs_set_item_key_safe()).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a061d7092369..c315fb793b30 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2707,7 +2707,7 @@ static bool check_sibling_keys(struct extent_buffer *left,
 		btrfs_item_key_to_cpu(right, &right_first, 0);
 	}
 
-	if (btrfs_comp_cpu_keys(&left_last, &right_first) >= 0) {
+	if (unlikely(btrfs_comp_cpu_keys(&left_last, &right_first) >= 0)) {
 		btrfs_crit(left->fs_info, "left extent buffer:");
 		btrfs_print_tree(left, false);
 		btrfs_crit(left->fs_info, "right extent buffer:");
-- 
2.34.1

