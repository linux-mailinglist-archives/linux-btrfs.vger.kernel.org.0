Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB46B9C63
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 18:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjCNRAA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 13:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjCNQ7y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 12:59:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650CC7B11C
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 09:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=o9Kw7bNIJnG6kNx9bMLQaGSLCTJJ+3sDB7djyQZ1PKE=; b=hH0Lbs7UkTEhP4+UjHy1JELShi
        mOSkRY3ZtSCRBqSTFPU/RWUpnuMCGXyKst+EAa3d159GR1pX5GMZriutmpR6Wm2Wvf8NfO785ZbfC
        8L23ChYGxISRRVggMXIqU6WXXQP8XWfnzNFXn9359v79dnX95leOT0z76F/jbzBBLJGXWnAVzm8EZ
        bD51KPsT8aXpiTpwFkm0H6JW4lmsV0DS/8Gz0BGXENH0MMkgwo3zT/kkleQZ8923rw2waI3ZsFAs4
        Z4e9uQAkeS03+E6laNydVVpG0Yj1iK/Z2jy8pFA3hAavkTiISXUiUt5QVj9PWtBCRdW0H7m/KbZbV
        Cl3sMYCw==;
Received: from [2001:4bb8:182:2e36:91ea:d0e2:233a:8356] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pc806-00Avsv-1L;
        Tue, 14 Mar 2023 16:59:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH 08/10] btrfs: remove irq disabling for fs_info.ebleak_lock
Date:   Tue, 14 Mar 2023 17:59:08 +0100
Message-Id: <20230314165910.373347-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314165910.373347-1-hch@lst.de>
References: <20230314165910.373347-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

None of the extent_buffer leak tracking is called from irq context,
so remove the irq disabling.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b0f74c741aa7a9..8e1ad6d1c7ccca 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -44,27 +44,24 @@ static struct kmem_cache *extent_buffer_cache;
 static inline void btrfs_leak_debug_add_eb(struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	unsigned long flags;
 
-	spin_lock_irqsave(&fs_info->eb_leak_lock, flags);
+	spin_lock(&fs_info->eb_leak_lock);
 	list_add(&eb->leak_list, &fs_info->allocated_ebs);
-	spin_unlock_irqrestore(&fs_info->eb_leak_lock, flags);
+	spin_unlock(&fs_info->eb_leak_lock);
 }
 
 static inline void btrfs_leak_debug_del_eb(struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	unsigned long flags;
 
-	spin_lock_irqsave(&fs_info->eb_leak_lock, flags);
+	spin_lock(&fs_info->eb_leak_lock);
 	list_del(&eb->leak_list);
-	spin_unlock_irqrestore(&fs_info->eb_leak_lock, flags);
+	spin_unlock(&fs_info->eb_leak_lock);
 }
 
 void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
 {
 	struct extent_buffer *eb;
-	unsigned long flags;
 
 	/*
 	 * If we didn't get into open_ctree our allocated_ebs will not be
@@ -74,7 +71,7 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
 		return;
 
 	WARN_ON(!list_empty(&fs_info->allocated_ebs));
-	spin_lock_irqsave(&fs_info->eb_leak_lock, flags);
+	spin_lock(&fs_info->eb_leak_lock);
 	while (!list_empty(&fs_info->allocated_ebs)) {
 		eb = list_first_entry(&fs_info->allocated_ebs,
 				      struct extent_buffer, leak_list);
@@ -85,7 +82,7 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
 		list_del(&eb->leak_list);
 		kmem_cache_free(extent_buffer_cache, eb);
 	}
-	spin_unlock_irqrestore(&fs_info->eb_leak_lock, flags);
+	spin_unlock(&fs_info->eb_leak_lock);
 }
 #else
 #define btrfs_leak_debug_add_eb(eb)			do {} while (0)
-- 
2.39.2

