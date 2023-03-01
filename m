Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDE66A6D45
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 14:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjCANmy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 08:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCANms (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 08:42:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87153E09C
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 05:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Efh+cHcjZ6XZv2KlpQO1KaCXgzQFP8pC/0NRWqi2Vdg=; b=XyXOIjss3ypHJD5RCqW0N0bAco
        UObQ6lJcmDRQpT9Oy0svo3/Jl8caqylsfYFrNGKTNn3my2U0XwNNcscP7eDEu0l1kcwZYT54Nw+Ql
        25Ilsn3M2+it44i0FJuKuq+pyug9caZUmxqtYFoR/gRjI4R5b9vgPUhR0mWiCUY5c7tK4wDvPU6CJ
        3Age0CL+5Ank54+suvDWj22PA1FzlBxRPfXZnk5mi/ksYmkMtHevt6S+Lxk/9LmruaGlVxBRiU/YX
        4Hm9vtYuPM10syNOsDmwgs5+lk+hQ0X8uXnF+I5zDLGiW4FF6HxILTalLv3nCbV0E2praOEnbP6dJ
        P5g82fiA==;
Received: from [136.36.117.140] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXMjF-00GN7t-MD; Wed, 01 Mar 2023 13:42:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/10] btrfs: simplify finding the inode in submit_one_bio
Date:   Wed,  1 Mar 2023 06:42:40 -0700
Message-Id: <20230301134244.1378533-8-hch@lst.de>
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

struct btrfs_bio now has an always valid inode pointer that can be used
to find the inode in submit_one_bio, so use that and initialize all
variables for which it is possible at declaration time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6ea6f2c057ac3e..05b96a77fba104 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -123,23 +123,16 @@ struct btrfs_bio_ctrl {
 
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 {
-	struct bio *bio;
-	struct bio_vec *bv;
-	struct inode *inode;
-	int mirror_num;
+	struct bio *bio = bio_ctrl->bio;
+	int mirror_num = bio_ctrl->mirror_num;
 
-	if (!bio_ctrl->bio)
+	if (!bio)
 		return;
 
-	bio = bio_ctrl->bio;
-	bv = bio_first_bvec_all(bio);
-	inode = bv->bv_page->mapping->host;
-	mirror_num = bio_ctrl->mirror_num;
-
 	/* Caller should ensure the bio has at least some range added */
 	ASSERT(bio->bi_iter.bi_size);
 
-	if (!is_data_inode(inode)) {
+	if (!is_data_inode(&btrfs_bio(bio)->inode->vfs_inode)) {
 		if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
 			/*
 			 * For metadata read, we should have the parent_check,
-- 
2.39.1

