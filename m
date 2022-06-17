Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A7954F4C9
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 12:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381495AbiFQKEl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 06:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380451AbiFQKEk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 06:04:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0B469723
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 03:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=P4VRMTB0+46uU1b194sPuy6pQ4Gnkh/jOjT6k6qxCUY=; b=YrtN5iMjePofxnT+rqKg+YmfoC
        uJzmtyX4L2zBWmUSMsZYJ/h7fvWbnxY35Az2eEaOanpinx7UE4hptJ+YGaev8NCsIgQrD7avfugkN
        8Dz5qrPUD2yzARduy5JxEjKLUomZLS7zwCN1IVL0Js5EDMQrw3D1x29sTp1+4yQhje5wbZ8sSlww9
        uDQU1pJT6yEu6VuwacUmOXe+nlrHCmWf9PYkuBYhp5RyZuWDZkj7XAJ2CjgnsVtcA7iZFys9buMji
        Zh11khe/YJkpjLFwORVlqreYOI8KfUVeUX8AGb95MKYPAmg6BHXj5yGW66TjQ90WaNtUc4D+DLBdh
        zJ0iRboQ==;
Received: from [2001:4bb8:180:36f6:9c91:42c8:8d10:d7ed] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o28qE-006smD-Ff; Fri, 17 Jun 2022 10:04:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/10] btrfs: simplify the reloc root check in btrfs_submit_data_write_bio
Date:   Fri, 17 Jun 2022 12:04:11 +0200
Message-Id: <20220617100414.1159680-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220617100414.1159680-1-hch@lst.de>
References: <20220617100414.1159680-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_submit_data_write_bio special cases the reloc root because the
checksums are preloaded, but only does so for the !sync case.  The sync
case can't happen for data relocation, but just handling it more generally
significantly simplifies the lgic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0f8513d3a8a88..5a90fc129aea9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2594,28 +2594,25 @@ void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirro
 	}
 
 	/*
-	 * Rules for async/sync submit:
-	 *   a) write without checksum:			sync submit
-	 *   b) write with checksum:
-	 *      b-1) if bio is issued by fsync:		sync submit
-	 *           (sync_writers != 0)
-	 *      b-2) if root is reloc root:		sync submit
-	 *           (only in case of buffered IO)
-	 *      b-3) otherwise:				async submit
+	 * If we need to checksum, and the I/O is not issued by fsync and
+	 * friends, that is ->sync_writers != 0, defer the submission to a
+	 * workqueue to parallelize it.
+	 *
+	 * Csum items for reloc roots have already been cloned at this point,
+	 * so they are handled as part of the no-checksum case.
 	 */
 	if (!(bi->flags & BTRFS_INODE_NODATASUM) &&
-	    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state)) {
-		if (atomic_read(&bi->sync_writers)) {
-			ret = btrfs_csum_one_bio(bi, bio, (u64)-1, false);
-			if (ret)
-				goto out;
-		} else if (btrfs_is_data_reloc_root(bi->root)) {
-			; /* Csum items have already been cloned */
-		} else {
+	    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state) &&
+	    !btrfs_is_data_reloc_root(bi->root)) {
+		if (!atomic_read(&bi->sync_writers)) {
 			ret = btrfs_wq_submit_bio(inode, bio, mirror_num, 0,
 						  btrfs_submit_bio_start);
 			goto out;
 		}
+
+		ret = btrfs_csum_one_bio(bi, bio, (u64)-1, false);
+		if (ret)
+			goto out;
 	}
 	btrfs_submit_bio(fs_info, bio, mirror_num);
 	return;
-- 
2.30.2

