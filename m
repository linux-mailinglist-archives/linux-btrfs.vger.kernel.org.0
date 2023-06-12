Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCE372C0D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 12:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbjFLKyq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 06:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbjFLKyX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 06:54:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CB191
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 03:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C2D0612A1
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 10:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877A4C433A0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686566422;
        bh=RSvgqOO8CTdiNYvCofQvpWVY23x/1yVDSMRNWqu3jOw=;
        h=From:To:Subject:Date:From;
        b=Ffxp0rzAE/mm8ljgYeX8KkiXX3FPkkVUFkJ5Wyyc+kyzLpQ9y6M3p0I9L9COCtN4l
         NrDZimk/vZdhr1DGst+pBbClK720Mi9u5WytvZOh+vCc8cLcxeIBhXBQOxeJhdTxLh
         eExFHnDaBkbJc/HBxkreyUvhgJnqNzuD/aHLaurEm34Kt8ARsqUUdj2BtaHFgfx0D2
         s003+OW3VZl8GFmrPOcpYZJ79sDDvKd4EMgkeGef7WwF7xZmHvNrJHgbiPpBQusOam
         b1rIZEPIlYWATbsZV0hvB39vzPhU+moIs8aOamtJ6adYtdKFbBOSIZx274OMrYGvZe
         bQthfZG7a+5Ag==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: do not BUG_ON() when dropping inode items from log root
Date:   Mon, 12 Jun 2023 11:40:17 +0100
Message-Id: <05225b2c8b1848cfb68125b858998111e18dd5cb.1686566185.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When dropping inode items from a log tree at drop_inode_items(), we this
BUG_ON() on the result of btrfs_search_slot() because we don't expect an
exact match since having a key with an offset of (u64)-1 is unexpected.
That is generally true, but for dir index keys for example, we can get a
key with such an offset value, even though it's very unlikely and it would
take ages to increase the sequence counter for a dir index up to (u64)-1.
We can deal with an exact match, we just have to delete the key at that
slot, so there is really no need to BUG_ON(), error out or trigger any
warning. So remove the BUG_ON().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index f91a6175fd11..365a1cc0a3c3 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4056,14 +4056,14 @@ static int drop_inode_items(struct btrfs_trans_handle *trans,
 
 	while (1) {
 		ret = btrfs_search_slot(trans, log, &key, path, -1, 1);
-		BUG_ON(ret == 0); /* Logic error */
-		if (ret < 0)
-			break;
-
-		if (path->slots[0] == 0)
+		if (ret < 0) {
 			break;
+		} else if (ret > 0) {
+			if (path->slots[0] == 0)
+				break;
+			path->slots[0]--;
+		}
 
-		path->slots[0]--;
 		btrfs_item_key_to_cpu(path->nodes[0], &found_key,
 				      path->slots[0]);
 
-- 
2.34.1

