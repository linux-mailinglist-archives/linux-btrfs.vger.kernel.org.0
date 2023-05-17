Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7E97065FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 13:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjEQLEC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 07:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjEQLEB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 07:04:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B4B2691
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 04:03:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BD7661252
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 11:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1BFC433EF
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 11:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684321349;
        bh=ASgSnEN9QqblV8lWLEsPxeC5wQhPN7oNGHH027nYfuk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=I/1J3ll0ZIdjV9jVLOb2jBSyZjMSDBtawKMphbqE/uiFT8ZB1tFhOx3vmhYKHaaaQ
         7NFnniuuMCMuRsXxIn0suidMblST4H6n9nyzcGydvl21/nBum6Fx7yjGV8y6V/0hsJ
         Z+91NtGqalFD/sHi8YI0sAZNba2ijr4mblFilCywd+5mnDotC27qXbjdJeaPJOt0Iu
         nyt8XXaGPwoSAzdTH/iTpQqmG8ng8Nj2uCLsGNuJeOZHQuFvJbANKlH1apwlqdZec2
         gx9cC1SJJMtaFlNS1mV5UDLQncNEof/K3UsljCPLa1pOutm/gMe/6XT3L+rT6aBKBh
         9VhJVRDxtzNjQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs: update comments at btrfs_record_unlink_dir() to be more clear
Date:   Wed, 17 May 2023 12:02:14 +0100
Message-Id: <0566cb2d00495c7c41dd859a93c4927ae3a7064a.1684320689.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1684320689.git.fdmanana@suse.com>
References: <cover.1684320689.git.fdmanana@suse.com>
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

Update the comments at btrfs_record_unlink_dir() so that they mention
where new names are logged and where old names are removed. Also, while
at it make the width of the comments closer to 80 columns and capitalize
the sentences and finish them with punctuation.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 42fe2d0b29e0..225497b07eb7 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7326,15 +7326,19 @@ void btrfs_record_unlink_dir(struct btrfs_trans_handle *trans,
 	mutex_unlock(&inode->log_mutex);
 
 	/*
-	 * if this directory was already logged any new
-	 * names for this file/dir will get recorded
+	 * If this directory was already logged, any new names will be logged
+	 * with btrfs_log_new_name() and old names will be deleted from the log
+	 * tree with btrfs_del_dir_entries_in_log() or with
+	 * btrfs_del_inode_ref_in_log().
 	 */
 	if (inode_logged(trans, dir, NULL) == 1)
 		return;
 
 	/*
-	 * if the inode we're about to unlink was logged,
-	 * the log will be properly updated for any new names
+	 * If the inode we're about to unlink was logged before, the log will be
+	 * properly updated with the new name with btrfs_log_new_name() and the
+	 * old name removed with btrfs_del_dir_entries_in_log() or with
+	 * btrfs_del_inode_ref_in_log().
 	 */
 	if (inode_logged(trans, inode, NULL) == 1)
 		return;
-- 
2.34.1

