Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDC256AB84
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 21:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbiGGTHl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 15:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbiGGTHl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 15:07:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5234957230
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 12:07:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 13A811FA8D;
        Thu,  7 Jul 2022 19:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657220859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qWpVpX96PVNlgiR8ifg/fSP2iOZtDEvMnzP3k4qvMic=;
        b=PhUshTz2Vi9/jgLoW3FBkDI5kXTWdK2Cj95aHmnu9tehM8bolzbH2UijDdvMGRyXVUSwLD
        7FcbcnY7+0I7PUJwL8vIViWi+abRyz2T91m0WFkS+ZJp3K0TKhzJ9MXtXFezUO5MJZu36V
        U1b7c48IU9eNuvuc53M2p/NSqYJoJDc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0BC882C141;
        Thu,  7 Jul 2022 19:07:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B0AE9DA83C; Thu,  7 Jul 2022 21:02:53 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 2/3] btrfs: switch btrfs_block_rsv::failfast to bool
Date:   Thu,  7 Jul 2022 21:02:53 +0200
Message-Id: <6177f616aa77dc5aa9ab8251ff5acf09f67d78f6.1657220460.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657220460.git.dsterba@suse.com>
References: <cover.1657220460.git.dsterba@suse.com>
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
index 734baa729cd3..f406a662e942 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2736,7 +2736,7 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 		goto out;
 	}
 	rsv->size = btrfs_calc_insert_metadata_size(fs_info, 1);
-	rsv->failfast = 1;
+	rsv->failfast = true;
 
 	/*
 	 * 1 - update the inode
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7790e307bf54..b9485e19b696 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5433,7 +5433,7 @@ void btrfs_evict_inode(struct inode *inode)
 	if (!rsv)
 		goto no_delete;
 	rsv->size = btrfs_calc_metadata_size(fs_info, 1);
-	rsv->failfast = 1;
+	rsv->failfast = true;
 
 	btrfs_i_size_write(BTRFS_I(inode), 0);
 
@@ -8687,7 +8687,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 	if (!rsv)
 		return -ENOMEM;
 	rsv->size = min_size;
-	rsv->failfast = 1;
+	rsv->failfast = true;
 
 	/*
 	 * 1 for the truncate slack space
-- 
2.36.1

