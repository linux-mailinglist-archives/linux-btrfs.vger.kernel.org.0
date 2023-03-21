Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8398A6C2FFE
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjCULOw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjCULOt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBF66EBE
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9526A61AEA
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBBBC433D2
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397252;
        bh=FJnfQ5I3a0N1gyIn4cKHc5U7EnTETAHGI88wfL9S1KY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GJJF9Wmn/Xf57uTw5fHOAXjsEg4T0dj7ZihyYA4HY3rItmUI0w1gDhf+D1deK9qY0
         e3XafTcoH7O6mw9Bh9rqrsTi/EKTGQmecov5QJWPbJuyHgShm7EaowqYmbaH+v89hc
         VKITmNXwankTMzeIjTtNiCtP+T1UefTj6CBhKWV5kPDF2sHECp50RShfzwpb+fJdnC
         ypUu3WMpW/dgpLkeL3yIhTRcyqQCxpjfkdNgn9UBX5Ysc9qLFJmvBtKlrmTdsOAYKZ
         fcjOni4KBmr3+V4dm6WvmkyXfjUPmexBKGkiaDICngVMiJrQRQatBpUdwLhA7LuHOz
         zd87jyoSNpJjw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/24] btrfs: collapse should_end_transaction() into btrfs_should_end_transaction()
Date:   Tue, 21 Mar 2023 11:13:44 +0000
Message-Id: <620d28d3978808483b962fc0024dda3600d45cb5.1679326431.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679326426.git.fdmanana@suse.com>
References: <cover.1679326426.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The function should_end_transaction() is very short and only has one
caller, which is btrfs_should_end_transaction(). So move the code from
should_end_transaction() into btrfs_should_end_transaction().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 18329ebcb1cb..c47b6838754e 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -942,16 +942,6 @@ void btrfs_throttle(struct btrfs_fs_info *fs_info)
 	wait_current_trans(fs_info);
 }
 
-static bool should_end_transaction(struct btrfs_trans_handle *trans)
-{
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-
-	if (btrfs_check_space_for_delayed_refs(fs_info))
-		return true;
-
-	return !!btrfs_block_rsv_check(&fs_info->global_block_rsv, 50);
-}
-
 bool btrfs_should_end_transaction(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_transaction *cur_trans = trans->transaction;
@@ -960,7 +950,10 @@ bool btrfs_should_end_transaction(struct btrfs_trans_handle *trans)
 	    test_bit(BTRFS_DELAYED_REFS_FLUSHING, &cur_trans->delayed_refs.flags))
 		return true;
 
-	return should_end_transaction(trans);
+	if (btrfs_check_space_for_delayed_refs(trans->fs_info))
+		return true;
+
+	return !!btrfs_block_rsv_check(&trans->fs_info->global_block_rsv, 50);
 }
 
 static void btrfs_trans_release_metadata(struct btrfs_trans_handle *trans)
-- 
2.34.1

