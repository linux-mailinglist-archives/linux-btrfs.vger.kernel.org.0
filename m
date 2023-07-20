Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482F975AD42
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 13:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjGTLoj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 07:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjGTLoi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 07:44:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F614EC
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 04:44:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B592161A3D
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 11:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732FDC433C7
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 11:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689853477;
        bh=RUJDHLYbmpmvWRZ7GMvzWiwHieWjUz9gRWCKVxOSap4=;
        h=From:To:Subject:Date:From;
        b=dV+f/h5XKJyrLnJjo9P1orYK+iA25tUQD70z5LEA5DMX/sIw8ZwkV4MJbU1w0QkEj
         ZDO/1IPBcwC6t32sMtcxvAWCcpEUfZDNAEODtaE/kC1qIh+gTtWpC1UGZHmRCU/eUh
         rwnxConU8SbiywGecXC/uAzWsMwztCCTtBrEgt2caCI1yAKVd1oSrQHgBsGMGt/HxV
         N0SipMcRcrDu2BAr77hLPnHZSmS9/8GxYU10m0EdisKnKcukvIY9dNpzS4L03N56a6
         Hi2Vc3LNex4IrvthxVNZ+koKYyH8SFHoU9mRYNDDU8iW3F/XCNxyJeMbeKBzvgyzRD
         B08W4E71Qh5kg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: account block group tree when calculating global reserve size
Date:   Thu, 20 Jul 2023 12:44:33 +0100
Message-Id: <433db4e6908c35fd2636c6f89d1e9efa3a2f08e5.1689853275.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When using the block group tree feature, this tree is a critical tree just
like the extent, csum and free space trees, and just like them it uses the
delayed refs block reserve.

So take into account the block group tree, and its current size, when
calculating the size for the global reserve.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-rsv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 6279d200cf83..77684c5e0c8b 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -349,6 +349,11 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 	}
 	read_unlock(&fs_info->global_root_lock);
 
+	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE)) {
+		num_bytes += btrfs_root_used(&fs_info->block_group_root->root_item);
+		min_items++;
+	}
+
 	/*
 	 * But we also want to reserve enough space so we can do the fallback
 	 * global reserve for an unlink, which is an additional
-- 
2.34.1

