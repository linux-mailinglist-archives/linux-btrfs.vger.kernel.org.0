Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669AB5FB2C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJKM7B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJKM67 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:58:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389EE925BA
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:58:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5294722CEE;
        Tue, 11 Oct 2022 12:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665493134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wT1VV0mt27Od4rxCJxXOCNJ0qyOasVHb7iupZxxBfOI=;
        b=hhwq+ZsQg209srcJl+AN96dBsvIauuSEfBMsrjNPtbZ2aVy94S8rCp0sR9F5wqI2P2fPZ3
        Anemtp7KhEdYWjFp7HzNfuPtdhRDrvbRNpVluyT4boQEAEBVeqOEaTFqx3G/Ax3Rlf0Ldx
        fZw0NxlWw07XvZ8i4jcq9AkZaLZInyg=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4A2942C141;
        Tue, 11 Oct 2022 12:58:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F3C66DA79D; Tue, 11 Oct 2022 14:58:49 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/6] btrfs: convert BTRFS_ILOCK-* defines to enum bit
Date:   Tue, 11 Oct 2022 14:58:49 +0200
Message-Id: <03cb65c7992ccdb7a9d068bb8e318df35f99f9d7.1665492943.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665492943.git.dsterba@suse.com>
References: <cover.1665492943.git.dsterba@suse.com>
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

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a8b629a166be..ec924cb7033f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -34,6 +34,7 @@
 #include "async-thread.h"
 #include "block-rsv.h"
 #include "locking.h"
+#include "misc.h"
 
 struct btrfs_trans_handle;
 struct btrfs_transaction;
@@ -3128,9 +3129,11 @@ ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter, size_t done_befo
 extern const struct dentry_operations btrfs_dentry_operations;
 
 /* Inode locking type flags, by default the exclusive lock is taken */
-#define BTRFS_ILOCK_SHARED	(1U << 0)
-#define BTRFS_ILOCK_TRY 	(1U << 1)
-#define BTRFS_ILOCK_MMAP	(1U << 2)
+enum btrfs_ilock_type {
+	ENUM_BIT(BTRFS_ILOCK_SHARED),
+	ENUM_BIT(BTRFS_ILOCK_TRY),
+	ENUM_BIT(BTRFS_ILOCK_MMAP),
+};
 
 int btrfs_inode_lock(struct inode *inode, unsigned int ilock_flags);
 void btrfs_inode_unlock(struct inode *inode, unsigned int ilock_flags);
-- 
2.37.3

