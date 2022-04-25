Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82B950DAB7
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 09:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiDYH6r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 03:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241796AbiDYH5x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 03:57:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDAF299
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 00:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kG3OkwKy25ss8i7xvQtXkOj9nzdJsB6ZYjoDtd3k6iQ=; b=EQ/M22qaYxS37uDl/vp07/DJgd
        0NOqrgIDEK+P0gq+Uaw3M4O8JPRcp+Wioi7qz8ORAt1+j2a/AhDd0pAdE1a4kbtS/bVzxHliuzihA
        R+24gyKt3TU15tBLy29nJwgEhKCs+6QUGoRnnVAueWIP+jhImRJu+bubDrvrC07jb2DA/UJW+5309
        WW/VMCC7wYH/QvfotVOSMIJrm91JRoO3e7ANHMh3O/yC+xHkwIVu0uiNSO+71gM7obLuHKF/P/OsB
        ujqupyg+BWCF4DOhxvX1oxf2ACgwXfnd9I86d9R5aXxstco4wWAqsSZZxhfW2+GmZtozOyzLXcUdr
        fc20PvhQ==;
Received: from 80-254-69-104.dynamic.monzoon.net ([80.254.69.104] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nitYJ-008ghb-Ah; Mon, 25 Apr 2022 07:54:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 04/10] btrfs: don't double-defer bio completions for compressed reads
Date:   Mon, 25 Apr 2022 09:54:12 +0200
Message-Id: <20220425075418.2192130-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425075418.2192130-1-hch@lst.de>
References: <20220425075418.2192130-1-hch@lst.de>
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

The bio completion handler of the bio used for the compressed data is
already run in a workqueue using btrfs_bio_wq_end_io, so don't schedule
the completion of the original bio to the same workqueue again but just
execute it directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4429d831793d5..d7b04e06da825 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2605,12 +2605,6 @@ void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	blk_status_t ret;
 
-	ret = btrfs_bio_wq_end_io(fs_info, bio,
-			btrfs_is_free_space_inode(BTRFS_I(inode)) ?
-			BTRFS_WQ_ENDIO_FREE_SPACE : BTRFS_WQ_ENDIO_DATA);
-	if (ret)
-		goto out;
-
 	if (bio_flags & EXTENT_BIO_COMPRESSED) {
 		/*
 		 * btrfs_submit_compressed_read will handle completing the bio
@@ -2620,6 +2614,12 @@ void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
 		return;
 	}
 
+	ret = btrfs_bio_wq_end_io(fs_info, bio,
+			btrfs_is_free_space_inode(BTRFS_I(inode)) ?
+			BTRFS_WQ_ENDIO_FREE_SPACE : BTRFS_WQ_ENDIO_DATA);
+	if (ret)
+		goto out;
+
 	/*
 	 * Lookup bio sums does extra checks around whether we need to csum or
 	 * not, which is why we ignore skip_sum here.
-- 
2.30.2

