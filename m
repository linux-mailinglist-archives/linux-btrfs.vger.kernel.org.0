Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7AE4FF9E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 17:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbiDMPWx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 11:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbiDMPWt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 11:22:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A9122524
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 08:20:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3078FB824F7
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 15:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B88C385A4
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649863225;
        bh=ezqXZmYRSu1Z0BBRG7LPM4ZttffBYhoHky5fnrNFjlU=;
        h=From:To:Subject:Date:From;
        b=gw5ZvOqCUL6qGaJwY+7sRLV34bLsIID2skXzhOM1hvfy3LG+x4kPa+aIU619+s+vy
         lCzbpGyut7wbEAJ43lPZucDm88eNfVauq1MiGFh/SqM/QKDa0pWoirzXYaEZUzAlWm
         oxLwGoVcCIZRUj7GOkzocIZHe6G7W/8keJd2e54ZP+2opwvMeUy8TOGm+wcAodC0uy
         /x6KbjA798X1DrB7A1GXWFh3atScvSQs1/foOj4aM8sfWHw5IR8vzMzSC7/LpG+Ec6
         qMij/MXmh1U+di+W4jFKaI3BtNmQfGjLeIrxbgcpZ7Hi9fpP85PsZJW+HIgczljpUn
         q70Hu4K+wK6aQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use BTRFS_DIR_START_INDEX at btrfs_create_new_inode()
Date:   Wed, 13 Apr 2022 16:20:21 +0100
Message-Id: <ce76cc1a4fb3c2b4d6051c6d900286d6171885a3.1649862992.git.fdmanana@suse.com>
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

We are still using the magic value of 2 at btrfs_create_new_inode(), but
there's now a constant for that, named BTRFS_DIR_START_INDEX, which was
introduced in commit 528ee697126fd ("btrfs: put initial index value of a
directory in a constant"). So change that to use the constant.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1911116974b1..620baf24c6bd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6238,12 +6238,8 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		if (ret)
 			goto out;
 	}
-	/*
-	 * index_cnt is ignored for everything but a dir,
-	 * btrfs_set_inode_index_count has an explanation for the magic
-	 * number
-	 */
-	BTRFS_I(inode)->index_cnt = 2;
+	/* index_cnt is ignored for everything but a dir. */
+	BTRFS_I(inode)->index_cnt = BTRFS_DIR_START_INDEX;
 	BTRFS_I(inode)->generation = trans->transid;
 	inode->i_generation = BTRFS_I(inode)->generation;
 
-- 
2.35.1

