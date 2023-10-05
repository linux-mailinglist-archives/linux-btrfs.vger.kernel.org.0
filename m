Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744107BA259
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Oct 2023 17:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjJEPbO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Oct 2023 11:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjJEPaf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Oct 2023 11:30:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7906A91
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Oct 2023 07:48:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D13C3278B
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Oct 2023 11:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696504273;
        bh=LLScLk/mH2jQDnR3v7/8eqg7iev38SaUnt5Tr7kHa98=;
        h=From:To:Subject:Date:From;
        b=ecsB1BgPLHodKUhhWkB0np1b0pKaOuRYFoYf0Tk3QCrPeJWD/vb6qZHHUUkibfPfl
         MZO7GMPPOUY7XRYWWvV8nzor1LYoGmqY1fFw4PilcpI55aiAgmWGLPFgJ65KYh0q0B
         PhAivje2cT8NdilB/o6VniIPLYlLYvudifnNbDqNuJQgjHrZLEdb2J72ifqsymxRA3
         4CyvrNxMCUKDV9a4jw4SZHMgWmqjiZJUzhqJKLkLeHhncSljCakhgzK3o1FyHPVNH8
         ALhgBS2YtypndtGpX6x8FCWQSxKdeRd7cwUeB/mv2zc8+IMwcS+jFVqNQcAjmZ2Bn7
         l7azYX3iVmLKA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove pointless empty log context list check when syncing log
Date:   Thu,  5 Oct 2023 12:11:09 +0100
Message-Id: <f238738e93b197f7125509e5727a8ae93abbac54.1696504114.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
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

When syncing the log, if we get an error when updating the log root, we
check first tif he log root tree context is in a log context list, and if
so it deletes from the log root tree context from the list. This check
however is pointless because at this moment the context is always in a
list, he have just added it to a context list. The check became pointless
after commit a93e01682e28 ("btrfs: remove no longer needed use of
log_writers for the log root tree"). So remove this now pointless empty
list check.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 958bb23d3d99..8b3893c01734 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2996,9 +2996,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 	 */
 	ret = update_log_root(trans, log, &new_root_item);
 	if (ret) {
-		if (!list_empty(&root_log_ctx.list))
-			list_del_init(&root_log_ctx.list);
-
+		list_del_init(&root_log_ctx.list);
 		blk_finish_plug(&plug);
 		btrfs_set_log_full_commit(trans);
 		if (ret != -ENOSPC)
-- 
2.40.1

