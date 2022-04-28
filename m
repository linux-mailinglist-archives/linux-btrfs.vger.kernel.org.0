Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324F851343F
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 14:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346711AbiD1M5A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 08:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbiD1M47 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 08:56:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABAAAFB16
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 05:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=z1rASdb5GrWDtPii1zoFi8PqlHM4suWB85C8pRknSLU=; b=Y73+fiZUGOq+HTvjUoEbsDOHPp
        bHfdZ/K8gcX0WBdBOn2VETiESTFMt+6VNwyvAvcuoXNBTAKiVB2AT4xX+XSPrnIHbKZLYMjeUX5mN
        bqSnJ5f8gBxPAHUiRCZe0FoqwmC0wEz8n4xSeXaUz0frjamBPWaUogXIoqfbReGWvJ6kUsx/Ik5GP
        WLSp7z9/pWnbxeTqgJKBYBt/vgrl5CL0KM88d6YDsBIG4yBqny84M4YUS2NkByKzcow4Jf3lhNXlb
        htQ7/w2XyCDw/8P9Wyqj1WteiPOgnBHw6I+V/7l0txZ14ImY9R298Peaeb5oViR9iX8vMHqb0ZlSX
        wzM7YXiw==;
Received: from [2607:fb90:27d4:6954:2d46:df24:4d29:e3d2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk3eQ-006uSb-PD; Thu, 28 Apr 2022 12:53:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     dsterba@suse.com
Cc:     josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        syzbot+a2c720e0f056114ea7c6@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: don't call destroy_workqueue on NULL workqueues
Date:   Thu, 28 Apr 2022 05:53:41 -0700
Message-Id: <20220428125341.4152527-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Unlike the btrfs_workueue code, the kernel workqueues don't like their
cleaup function called on a NULL pointer, so add checks for them.

Fixes: a5eec25648da ("btrfs: use a normal workqueue for rmw_workers")
Reported-by: syzbot+a2c720e0f056114ea7c6@syzkaller.appspotmail.com
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: syzbot+a2c720e0f056114ea7c6@syzkaller.appspotmail.com
---
 fs/btrfs/disk-io.c | 3 ++-
 fs/btrfs/scrub.c   | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 307230436ecd6..fd8d91947d3fc 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2283,7 +2283,8 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 	btrfs_destroy_workqueue(fs_info->workers);
 	btrfs_destroy_workqueue(fs_info->endio_workers);
 	btrfs_destroy_workqueue(fs_info->endio_raid56_workers);
-	destroy_workqueue(fs_info->rmw_workers);
+	if (fs_info->rmw_workers)
+		destroy_workqueue(fs_info->rmw_workers);
 	btrfs_destroy_workqueue(fs_info->endio_write_workers);
 	btrfs_destroy_workqueue(fs_info->endio_freespace_worker);
 	btrfs_destroy_workqueue(fs_info->delayed_workers);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a614ddde8c624..3985225f27be5 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3967,9 +3967,12 @@ static void scrub_workers_put(struct btrfs_fs_info *fs_info)
 		fs_info->scrub_parity_workers = NULL;
 		mutex_unlock(&fs_info->scrub_lock);
 
-		destroy_workqueue(scrub_workers);
-		destroy_workqueue(scrub_wr_comp);
-		destroy_workqueue(scrub_parity);
+		if (scrub_workers)
+			destroy_workqueue(scrub_workers);
+		if (scrub_wr_comp)
+			destroy_workqueue(scrub_wr_comp);
+		if (scrub_parity)
+			destroy_workqueue(scrub_parity);
 	}
 }
 
-- 
2.30.2

