Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0ED6152DB
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiKAUMv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiKAUMq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316A11E72A
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AF9D51F38A;
        Tue,  1 Nov 2022 20:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJa/1EK43OTBFoLyZ+Km9QdvocqPaH7RDcQwvkKwTfQ=;
        b=kuUXJkQI80+WfeSU26MpY20n9+Z5XXflX/hKyBMsnyzNX2FWZnkwiIMXd+mAMyVooi4klF
        8Oj70O0SKryOZyGbbcCLj8j1GrWZfsHXP4j4jnUGE3wPrWSbZdkbs92IWAm2VKtt+6up2i
        qMX+zFQVzvoVB4CbQ5QIdTjmEjAbRP4=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A8A102C141;
        Tue,  1 Nov 2022 20:12:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 03DE4DA79D; Tue,  1 Nov 2022 21:12:27 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 22/40] btrfs: switch btrfs_writepage_fixup::inode to btrfs_inode
Date:   Tue,  1 Nov 2022 21:12:27 +0100
Message-Id: <ac14bc48d8b34d7ab23f87e8a6dd2e749df795ec.1667331828.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667331828.git.dsterba@suse.com>
References: <cover.1667331828.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The btrfs_writepage_fixup structure is for internal interfaces so we
should use the btrfs_inode.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 45c46043f5e4..3e2cb80c6c63 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2890,7 +2890,7 @@ int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 /* see btrfs_writepage_start_hook for details on why this is required */
 struct btrfs_writepage_fixup {
 	struct page *page;
-	struct inode *inode;
+	struct btrfs_inode *inode;
 	struct btrfs_work work;
 };
 
@@ -2909,7 +2909,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 
 	fixup = container_of(work, struct btrfs_writepage_fixup, work);
 	page = fixup->page;
-	inode = BTRFS_I(fixup->inode);
+	inode = fixup->inode;
 	page_start = page_offset(page);
 	page_end = page_offset(page) + PAGE_SIZE - 1;
 
@@ -3068,7 +3068,7 @@ int btrfs_writepage_cow_fixup(struct page *page)
 	get_page(page);
 	btrfs_init_work(&fixup->work, btrfs_writepage_fixup_worker, NULL, NULL);
 	fixup->page = page;
-	fixup->inode = inode;
+	fixup->inode = BTRFS_I(inode);
 	btrfs_queue_work(fs_info->fixup_workers, &fixup->work);
 
 	return -EAGAIN;
-- 
2.37.3

