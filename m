Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF5878A6A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 09:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjH1Hit (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 03:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjH1Him (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 03:38:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E15102
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 00:38:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6772162EB9
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 07:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DDFC433C7
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 07:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693208319;
        bh=Lx7T/F2BAhnoxh/xTw/MA/vjD7rrp42ZZlzTgXJiXcI=;
        h=From:To:Subject:Date:From;
        b=PzFo5yyshxS3oXvr2DLPttaLpie2q3CNxxNV2fQwY1Ean5uxoMytLoDHCA9Zm6N2Y
         rh75P8DDecEasdncvF+4ndLT0VAFOEdPcZththiWKG/5TC1Iut/gTwa3QP+fRFgjvW
         WUcZiDSRZMoy8onsNGWX2Pwhd3zdPlzPZ5wEZQRMEVX74+IErx9EpUpNYqwUeIxbu7
         C6fkGaF8Vy+U4AslynxCR9Nx51hRutHMPalMwZxGHGLxS0Ya0eHaIHCRe5r6/uw5sY
         bW0iJHFCwO5WazF/xdinFwyukg+rnj6ulvqTGNpV0v6rnV5BpCJlbot++LRFxYxP5y
         qlhbvHZccJU1A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: update comment for reservation of metadata space for delayed items
Date:   Mon, 28 Aug 2023 08:38:36 +0100
Message-Id: <283a7c5087a950342a862fba42922fad4fc71365.1693208275.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The second comment at btrfs_delayed_item_reserve_metadata() refers to a
field named "index_items_size" of a delayed inode, however that field
does not exists - it existed in a previous patch version, but then it
split into the fields "curr_index_batch_size" and "index_item_leaves"
in the final patch version that was picked. So update the comment.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 85dcf0024137..08ecb4d0cc45 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -513,7 +513,7 @@ static int btrfs_delayed_item_reserve_metadata(struct btrfs_trans_handle *trans,
 		/*
 		 * For insertions we track reserved metadata space by accounting
 		 * for the number of leaves that will be used, based on the delayed
-		 * node's index_items_size field.
+		 * node's curr_index_batch_size and index_item_leaves fields.
 		 */
 		if (item->type == BTRFS_DELAYED_DELETION_ITEM)
 			item->bytes_reserved = num_bytes;
-- 
2.40.1

