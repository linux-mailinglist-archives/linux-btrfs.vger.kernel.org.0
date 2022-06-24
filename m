Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17EE559AEE
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 16:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbiFXOGv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 10:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbiFXOG2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 10:06:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6344EF73
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 07:06:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 41CDC21A9A;
        Fri, 24 Jun 2022 14:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656079576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rWgvrrVSpzsrI5iA6bGU662ZY6mdV/qrRAlZmDXE4XU=;
        b=d4TfC1GaEVmLmESEGKP55J/zBFUJwsLwS8V6gudxxlAUzuaxTXvSoEHzpH4TD4mbiu/uYG
        JqCJh3ZRuY6ainOlm5qBPXUh3vpaG6WAdBsiJlWp9LjZ8/rY1kipo1/LmvKLhwQvQFDvIa
        7QYPvYMFeT5qlAp5UP8dibSL7Q9cGPE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 390572C24A;
        Fri, 24 Jun 2022 14:06:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9F345DA82F; Fri, 24 Jun 2022 16:01:38 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/3] btrfs: switch btrfs_block_rsv::failfast to bool
Date:   Fri, 24 Jun 2022 16:01:38 +0200
Message-Id: <bf8fa9adf15bb078e3fc70d088d658c98a2b601b.1656079178.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656079178.git.dsterba@suse.com>
References: <cover.1656079178.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use simple bool type for the block reserve failfast status, there's
short to save space as there used to be int but there's no reason for
that.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-rsv.h | 2 +-
 fs/btrfs/file.c      | 2 +-
 fs/btrfs/inode.c     | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index 99c491ef128e..0702d4087ff6 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -26,8 +26,8 @@ struct btrfs_block_rsv {
 	struct btrfs_space_info *space_info;
 	spinlock_t lock;
 	bool full;
+	bool failfast;
 	unsigned short type;
-	unsigned short failfast;
 
 	/*
 	 * Qgroup equivalent for @size @reserved
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 89c6d7ff1987..3e7f89d50db9 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2734,7 +2734,7 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 		goto out;
 	}
 	rsv->size = btrfs_calc_insert_metadata_size(fs_info, 1);
-	rsv->failfast = 1;
+	rsv->failfast = true;
 
 	/*
 	 * 1 - update the inode
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 07b3fb90b621..1b2df600681b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5432,7 +5432,7 @@ void btrfs_evict_inode(struct inode *inode)
 	if (!rsv)
 		goto no_delete;
 	rsv->size = btrfs_calc_metadata_size(fs_info, 1);
-	rsv->failfast = 1;
+	rsv->failfast = true;
 
 	btrfs_i_size_write(BTRFS_I(inode), 0);
 
@@ -8676,7 +8676,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 	if (!rsv)
 		return -ENOMEM;
 	rsv->size = min_size;
-	rsv->failfast = 1;
+	rsv->failfast = true;
 
 	/*
 	 * 1 for the truncate slack space
-- 
2.36.1

