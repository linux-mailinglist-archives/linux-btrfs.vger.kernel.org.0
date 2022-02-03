Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A5A4A89FF
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 18:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352827AbiBCR1S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 12:27:18 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58582 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241975AbiBCR1R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 12:27:17 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 61E5B1F399;
        Thu,  3 Feb 2022 17:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643909236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cI28xQq/jaCGMIrda1+ADuuDDUaTqvUccpsJTMPhJOM=;
        b=tYCJ9GuLqHbchudAncLZT3kw+aVeuE/xQWdkDzHyaRwzw7UbLnenzNU5Nb8PgG2Qh9bcBG
        ojh6CN46Yu8mUDA3EFbC5628qRwRbukENAFQgF4yYQnvQxarjZu717sQqDJ2owVJ0CYB2Q
        OIAa9ciB+Jr7C2/dv0278J/ZvyIMDoc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5D19AA3B81;
        Thu,  3 Feb 2022 17:27:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5D375DA781; Thu,  3 Feb 2022 18:26:31 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/5] btrfs: fail transaction when a setget bounds check failure is detected
Date:   Thu,  3 Feb 2022 18:26:31 +0100
Message-Id: <617931b8ee53e8fcde1560eb86758024ca753f42.1643904960.git.dsterba@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643904960.git.dsterba@suse.com>
References: <cover.1643904960.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As the setget check only sets the bit, we need to use it in the
transaction:

- when attempting to start a new one, fail with EROFS as if would be
  aborted in another way already

- in should_end_transaction

- when transaction is about to end, insert an explicit abort

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/transaction.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 6db634ebae17..f48194df6c33 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -591,6 +591,9 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	if (BTRFS_FS_ERROR(fs_info))
 		return ERR_PTR(-EROFS);
 
+	if (test_bit(BTRFS_FS_SETGET_COMPLAINS, &fs_info->flags))
+		return ERR_PTR(-EROFS);
+
 	if (current->journal_info) {
 		WARN_ON(type & TRANS_EXTWRITERS);
 		h = current->journal_info;
@@ -924,6 +927,9 @@ static bool should_end_transaction(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 
+	if (test_bit(BTRFS_FS_SETGET_COMPLAINS, &fs_info->flags))
+		return true;
+
 	if (btrfs_check_space_for_delayed_refs(fs_info))
 		return true;
 
@@ -969,6 +975,11 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 	struct btrfs_transaction *cur_trans = trans->transaction;
 	int err = 0;
 
+	/* If a serious error was detected abort the transaction early */
+	if (!TRANS_ABORTED(trans) &&
+	    test_bit(BTRFS_FS_SETGET_COMPLAINS, &info->flags))
+		btrfs_abort_transaction(trans, -EIO);
+
 	if (refcount_read(&trans->use_count) > 1) {
 		refcount_dec(&trans->use_count);
 		trans->block_rsv = trans->orig_rsv;
-- 
2.34.1

