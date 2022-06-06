Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368AD53EC84
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 19:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiFFJlb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 05:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbiFFJl1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 05:41:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732DF1CEACC
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 02:41:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0498B61335
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 09:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2190C3411C
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 09:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654508485;
        bh=mg7R0tu0C2jaGuLdqfGA5N1cOLIeL8YDbnAdin8sdY4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=caaiSpX7iod2+3tXreVhuPPdwJ53WOt7FumHdxpPmIj0wzq1eXAn2qI+/yoKdsZu0
         vKDKeJJB3RH9LrPa10js1tqB8tCOjCXkSy8SAzSET1DixYVpwbsoUUnKAAS5hKWbkK
         +9OU2T5lglu6Oi1wNtr5cPZx4Isa5SW4M+BQfNkyPjTtMkytDvGEM1hW87E5thCkoH
         ewWnU5FKT9PPt/sTx3UMCHUZumsXCdUW2AfCxgyYeDojKwHYaypiTnGARdp5cWB3nt
         +jJg3nfo6lQPEToDTML/VjOrpjrNaTNRY5mZeoE9VCOlDsKsBZsFsfH/IyslxY9vQK
         7JYbL4hDKGIvg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: do not BUG_ON() on failure to migrate space when replacing extents
Date:   Mon,  6 Jun 2022 10:41:19 +0100
Message-Id: <dc02b21c1afa5b0c7af14dc1d0b46a3855d5cd9a.1654508104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1654508104.git.fdmanana@suse.com>
References: <cover.1654508104.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_replace_file_extents(), if we fail to migrate reserved metadata
space from the transaction block reserve into the local block reserve,
we trigger a BUG_ON(). This is because it should not be possible to have
a failure here, as we reserved more space when we started the transaction
than the space we want to migrate. However having a BUG_ON() is way too
drastic, we can perfectly handle the failure and return the error to the
caller. So just do that instead, and add a WARN_ON() to make it easier
to notice the failure if it evers happens (which is particularly useful
for fstests, and the warning will trigger a failure of a test case).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 29de433b7804..da41a0c371bc 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2719,7 +2719,8 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 
 	ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv, rsv,
 				      min_size, false);
-	BUG_ON(ret);
+	if (WARN_ON(ret))
+		goto out_trans;
 	trans->block_rsv = rsv;
 
 	cur_offset = start;
@@ -2838,7 +2839,8 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 
 		ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv,
 					      rsv, min_size, false);
-		BUG_ON(ret);	/* shouldn't happen */
+		if (WARN_ON(ret))
+			break;
 		trans->block_rsv = rsv;
 
 		cur_offset = drop_args.drop_end;
-- 
2.35.1

