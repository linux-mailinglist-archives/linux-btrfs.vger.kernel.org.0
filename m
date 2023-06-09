Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483C4729764
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jun 2023 12:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238108AbjFIKtV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jun 2023 06:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238708AbjFIKtO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jun 2023 06:49:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AC5F5
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 03:49:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 537D263D6D
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 10:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3935CC433EF
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 10:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686307750;
        bh=mOver0kcOeu8v2JktalasqXu9wPhHmEtq+SPSllqatY=;
        h=From:To:Subject:Date:From;
        b=ZUVTNRObbPHsmhZUim0EvVPbjr56dFlYhdcB+paVtPyE+0XQgeqy65h3Gy5g0MkR2
         Uw50tEeVszFVSp/ygj+EV0AXQmQq2f4LD7rgzSVZwauPs0JkZ98H7qZwniC1VebrED
         MPKaCuusSJ/xbx7sTHqEvayMX7pjoe3cnbGt7RegoMACj7VyUlaXClwEGoyCqIqFMn
         pjtSQvS74dQOYySR/4hbml1d0QvCxvZkHqFL9vjl8Kj+JuQ4Tn7FJ8hxbrvTS4V1Kh
         vrfO2GSmjGHpBnltudc6DojQAV/VRR1cKXWE2EdQkvwPj8P79+64c7vrANHqAdjZFX
         KdeayhHx2vGPw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: replace BUG_ON() at split_item() with proper error handling
Date:   Fri,  9 Jun 2023 11:49:07 +0100
Message-Id: <5891832d9130694cc60cffac74b95db92521728c.1686307630.git.fdmanana@suse.com>
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

There's no need to BUG_ON() at split_item() if the leaf does not have
enough free space for the new item, we can just return -ENOSPC since
the caller can deal with errors from split_item(). Also, as this is a
very unlikely condition to happen, because the caller has invoked
setup_leaf_for_split() before calling split_item(), surround the
condition with a WARN_ON() which makes it easier to notice this
unexpected condition and tags the if branch with 'unlikely' as well.

I've actually once hit this BUG_ON() with some incorrect code changes
I had, which was very inconvenient as it required rebooting the VM.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 29c5fa252eb1..e6009da34835 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4000,7 +4000,12 @@ static noinline int split_item(struct btrfs_path *path,
 	struct btrfs_disk_key disk_key;
 
 	leaf = path->nodes[0];
-	BUG_ON(btrfs_leaf_free_space(leaf) < sizeof(struct btrfs_item));
+	/*
+	 * Shouldn't happen because the caller must have previously called
+	 * setup_leaf_for_split() to make room for the new item in the leaf.
+	 */
+	if (WARN_ON(btrfs_leaf_free_space(leaf) < sizeof(struct btrfs_item)))
+		return -ENOSPC;
 
 	orig_slot = path->slots[0];
 	orig_offset = btrfs_item_offset(leaf, path->slots[0]);
-- 
2.34.1

