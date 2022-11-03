Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9E26180BE
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 16:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiKCPME (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 11:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiKCPLt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 11:11:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB83B5FA2
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 08:11:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8E5C221D9F;
        Thu,  3 Nov 2022 15:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667488270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZChqTUb4KyuojPWII9wno8vsPPnHsyVmFfGFhJmczbw=;
        b=qqRAo7maydXDGpOq5ga9Im8yxRLphG4Fbq5MTQCLlFaP1H83qzpGfjxcZrl3a7KuRFeDbz
        fhqiDFWsZtCJidIc39uzR3q+JKiiYE9/V3yHJxbCut80AKhsayOAi7g3UzA9P3lofwoayz
        o8huI+29RFWwfKWYNJxYTElYfQ8P5Nc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 84BBC2C141;
        Thu,  3 Nov 2022 15:11:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2950CDA79D; Thu,  3 Nov 2022 16:10:51 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: don't print stack trace when transaction is aborted due to ENOMEM
Date:   Thu,  3 Nov 2022 16:10:50 +0100
Message-Id: <20221103151051.28669-1-dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add ENOMEM among the error codes that don't print stack trace on
transaction abort. We've got several reports from syzbot that detects
stacks as errors but caused by limiting memory. As this is an artificial
condition we don't need to know where exactly the error happens, the
abort and error cleanup will continue like e.g. for EIO.

As the transaction aborts code needs to be inline in a lot of code, the
implementation cases about minimal bloat. The error codes are in a
separate function and the WARN uses the condition directly. This
increases the code size by 571 bytes on release build.

Alternatives considered: add -ENOMEM among the errors, this increases
size by 2340 bytes, various attempts to combine the WARN and helper
calls, increase by 700 or more bytes.

Example syzbot reports (error -12):

- https://syzkaller.appspot.com/bug?extid=5244d35be7f589cf093e
- https://syzkaller.appspot.com/bug?extid=9c37714c07194d816417

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/messages.c | 16 ++++++++++++++++
 fs/btrfs/messages.h | 11 +++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index 625bbbbb2608..5ad375463a90 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -322,6 +322,22 @@ void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
 	__btrfs_handle_fs_error(fs_info, function, line, errno, NULL);
 }
 
+/*
+ * We want the transaction abort to print stack trace only for errors where the
+ * cause could be a bug, eg. due to ENOSPC, and not for common errors that are
+ * caused by external factors.
+ */
+bool __cold abort_should_print_stack(int errno)
+{
+	switch (errno) {
+	case -EIO:
+	case -EROFS:
+	case -ENOMEM:
+		return false;
+	}
+	return true;
+}
+
 /*
  * __btrfs_panic decodes unexpected, fatal errors from the caller, issues an
  * alert, and either panics or BUGs, depending on mount options.
diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index d1deb8d217a2..295aa874b226 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -183,9 +183,11 @@ void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
 			       const char *function,
 			       unsigned int line, int errno, bool first_hit);
 
+bool __cold abort_should_print_stack(int errno);
+
 /*
  * Call btrfs_abort_transaction as early as possible when an error condition is
- * detected, that way the exact line number is reported.
+ * detected, that way the exact stack trace is reported for some errors.
  */
 #define btrfs_abort_transaction(trans, errno)		\
 do {								\
@@ -194,10 +196,11 @@ do {								\
 	if (!test_and_set_bit(BTRFS_FS_STATE_TRANS_ABORTED,	\
 			&((trans)->fs_info->fs_state))) {	\
 		first = true;					\
-		if ((errno) != -EIO && (errno) != -EROFS) {		\
-			WARN(1, KERN_DEBUG				\
+		if (WARN(abort_should_print_stack(errno), 	\
+			KERN_DEBUG				\
 			"BTRFS: Transaction aborted (error %d)\n",	\
-			(errno));					\
+			(errno))) {					\
+			/* Stack trace printed. */			\
 		} else {						\
 			btrfs_debug((trans)->fs_info,			\
 				    "Transaction aborted (error %d)", \
-- 
2.37.3

