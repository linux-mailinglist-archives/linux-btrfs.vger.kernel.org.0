Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AEF6A6D3E
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 14:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjCANms (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 08:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCANmr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 08:42:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16003B67F
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 05:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nNEzlD2jMi0E94gPYfHSnZgBgwtm3sIkX8dAmKcdQfU=; b=V2zDAjp9bQa7NunYRZq3BSuH72
        WaPDydUTETp+5HlfvXOoxfz6xVlg5SlnKhjxVaoi/nutJ5nhUICSaCjk0bP6KP3TdnrEhEUfwpyyg
        52TqhuFE2idtrLGJUqzJWz1CrnyDpgSLHTN6UW9U3+ZbjJSs4Ce5YHjNK9uKfVwKOPNn3mSF7rQCj
        6O/Rp5z4VxBS5qJ5+7yUGLvv6Toqac+LeOJJu3K2HC+ygI/QlrvKWoi3ZL/8+KJ7WDvA8oC6PEYEV
        DB/f/NBukZ3NsayRbBigMp3yrTiHfuXY3nRBl9Reu/yQa3kybrpr7rh0LgLLdqpN4YoczTf24BXS9
        RZhENkhg==;
Received: from [136.36.117.140] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXMjC-00GN6T-RU; Wed, 01 Mar 2023 13:42:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/10] btrfs: remove unused members from struct btrfs_encoded_read_private
Date:   Wed,  1 Mar 2023 06:42:34 -0700
Message-Id: <20230301134244.1378533-2-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230301134244.1378533-1-hch@lst.de>
References: <20230301134244.1378533-1-hch@lst.de>
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

The inode and file_offset members in truct btrfs_encoded_read_private
are unused, so remove them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ecd0aa83927949..9ad0d181c7082a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9926,8 +9926,6 @@ static ssize_t btrfs_encoded_read_inline(
 }
 
 struct btrfs_encoded_read_private {
-	struct btrfs_inode *inode;
-	u64 file_offset;
 	wait_queue_head_t wait;
 	atomic_t pending;
 	blk_status_t status;
@@ -9958,8 +9956,6 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 					  u64 disk_io_size, struct page **pages)
 {
 	struct btrfs_encoded_read_private priv = {
-		.inode = inode,
-		.file_offset = file_offset,
 		.pending = ATOMIC_INIT(1),
 	};
 	unsigned long i = 0;
-- 
2.39.1

