Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2E47AF2F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 20:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbjIZSba (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 14:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbjIZSb3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 14:31:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC178120
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:31:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1CBC433C8
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 18:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695753082;
        bh=odjEynOfRzaUFiblIxyQqoadvGhn1e5wUicDVMlLeno=;
        h=From:To:Subject:Date:From;
        b=Moxxiw+T5+2awhTKUM1PoNd54l3US5N8WkkwCh/vxKop4kuDMLBBhY/+TNVORoxSl
         cET2PaAGIRv31Emqw0JUrwPNkwEezv4QX6xY2f7MBwbrEEIxBC6+pa/oH4Na54WPZ7
         eXnlodCzAAT2RczIsa/NNRQQI9zhfTGmJQ3GXvF7xPgZFHf8wBmRfKyu+/9UrjETMB
         A7CNPdBbRUaRZRubUUgAHog98Xl2Xs80WuFZikFZPOTAYlb7ZZzYfA6520yiI2RSrF
         5yz0rGEhxK+Ta7KyHFYca5fNZCp86adGp5xFeZ7KXJtnK43m8oT/0F+SqEgSMAEo+o
         Rli8/8h8rI8hw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: always print transaction aborted messages with an error level
Date:   Tue, 26 Sep 2023 19:31:19 +0100
Message-Id: <70f9a616df5b0f4268f309312d93d3a972fd9289.1695753057.git.fdmanana@suse.com>
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

Commit b7af0635c87f ("btrfs: print transaction aborted messages with an
error level") changed the log level of transaction aborted messages from
a debug level to an error level, so that such messages are always visible
even on production systems where the log level is normally above the debug
level (and also on some syzbot reports).

Later, commit fccf0c842ed4 ("btrfs: move btrfs_abort_transaction to
transaction.c") changed the log level back to debug level when the error
number for a transaction abort should not have a stack trace printed.
This happened for absolutely no reason. It's always useful to print
transaction abort messages with an error level, regardless of whether
the error number should cause a stack trace or not.

So change back the log level to error level.

Fixes: fccf0c842ed4 ("btrfs: move btrfs_abort_transaction to transaction.c")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index de58776de307..f5bf3489d8c5 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -222,8 +222,8 @@ do {								\
 			(error))) {					\
 			/* Stack trace printed. */			\
 		} else {						\
-			btrfs_debug((trans)->fs_info,			\
-				    "Transaction aborted (error %d)", \
+			btrfs_err((trans)->fs_info,			\
+				  "Transaction aborted (error %d)",     \
 				  (error));			\
 		}						\
 	}							\
-- 
2.40.1

