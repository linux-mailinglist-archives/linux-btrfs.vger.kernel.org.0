Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7548572C187
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 12:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjFLK6x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 06:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbjFLKym (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 06:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F430199B
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 03:41:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0B4A614F0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 10:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1284C4339B
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 10:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686566462;
        bh=6FirqXpOdNQvNdL9OI3LXNC3Qeb4ax/FJRXqr50N1zo=;
        h=From:To:Subject:Date:From;
        b=YlCBqm0LfbX3B9AQdNOkTiAja2ic2jOtd85dS8AsuB3iQupYabJNyEspURHzV4GPS
         POx+hKVfSDTQYWtUI+1MhGYdEH/M8gOPKdbovWnLttFIKOFqP2LEQ0a4vYuq5YCVbg
         NSEF5fAEseUadD4Pu7+9SLJt2hyE1G+7EwqKJsHIf+sDzSh85SK1seX57ie/JxjvRJ
         ZzYX4C8G7aqbBSO6mG6gsYVBf1EhdvHEq87SHj6lcH9BFgXd/Xk01hz/7CReDoP7AE
         +aSfmovsReyd2K/gnokt6Rq4slvEaLs/37sbVsbWgJRtcrjdxUi274a7h6UW7nadJ2
         75IKwS6nSne/w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: send: do not BUG_ON() on unexpected symlink data extent
Date:   Mon, 12 Jun 2023 11:40:59 +0100
Message-Id: <f3c6cadc84e001f786b82ef540cf39e9e8ce859e.1686566191.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There's really no need to BUG_ON() if we find a symlink with an extent
that is not inline or is compressed. We can just make send fail with
an error (-EUCLEAN) and log an informative error message, so just do
that instead of BUG_ON().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index af2e153543a5..8bfd44750efe 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1774,9 +1774,21 @@ static int read_symlink(struct btrfs_root *root,
 	ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
 			struct btrfs_file_extent_item);
 	type = btrfs_file_extent_type(path->nodes[0], ei);
+	if (unlikely(type != BTRFS_FILE_EXTENT_INLINE)) {
+		ret = -EUCLEAN;
+		btrfs_crit(root->fs_info,
+"send: found symlink extent that is not inline, ino %llu root %llu extent type %d",
+			   ino, btrfs_root_id(root), type);
+		goto out;
+	}
 	compression = btrfs_file_extent_compression(path->nodes[0], ei);
-	BUG_ON(type != BTRFS_FILE_EXTENT_INLINE);
-	BUG_ON(compression);
+	if (unlikely(compression != BTRFS_COMPRESS_NONE)) {
+		ret = -EUCLEAN;
+		btrfs_crit(root->fs_info,
+"send: found symlink extent with compression, ino %llu root %llu compression type %d",
+			   ino, btrfs_root_id(root), compression);
+		goto out;
+	}
 
 	off = btrfs_file_extent_inline_start(ei);
 	len = btrfs_file_extent_ram_bytes(path->nodes[0], ei);
-- 
2.34.1

