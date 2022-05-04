Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82752519F41
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 14:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbiEDM3G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 08:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349532AbiEDM3F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 08:29:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879A31106
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 05:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3iOwlL+ATVCdeoPoKzE76elXcx2suxwe/w1hmr9qMwk=; b=EAR+dKXPl9mziaWqIIx7cHMQt4
        e8acVr/sJt3Tp/kIYzBEKKj9eKbtIwGuuDaSpn/sOaIjXAh/vHBgTtsQ7vqzP4B85t6IT7FqL9fbu
        toU9Sio/q4L1UcZaU5+WrddjzyPZl9cML/AalusiffKTVSwPhyVYPa0NyI89P4ITYXEj9q58Pe9CK
        o3z1qsB4C+h8s3ZyDhuA2JFI8TmQQquCXlNu88O2jCnP+yXYeWc9qrINJjhD9v0Rt0lL9l74LVWW0
        DsMfCv+xYmyp/3EA6tzmPv/CHxg+Lg/U7cp+Wx3eamzvMvJIRtiUFUXZD6xJgWw2LI1gh444trMvw
        jt+DMggA==;
Received: from [8.34.116.185] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmE4L-00Ahlz-P2; Wed, 04 May 2022 12:25:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/10] btrfs: don't double-defer bio completions for compressed reads
Date:   Wed,  4 May 2022 05:25:15 -0700
Message-Id: <20220504122524.558088-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220504122524.558088-1-hch@lst.de>
References: <20220504122524.558088-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 fs/btrfs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b42d6e7e4049f..39da19645e890 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2598,10 +2598,6 @@ void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 	}
 
 	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
-		ret = btrfs_bio_wq_end_io(fs_info, bio, metadata);
-		if (ret)
-			goto out;
-
 		if (compress_type != BTRFS_COMPRESS_NONE) {
 			/*
 			 * btrfs_submit_compressed_read will handle completing
@@ -2611,6 +2607,10 @@ void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 			btrfs_submit_compressed_read(inode, bio, mirror_num);
 			return;
 		} else {
+			ret = btrfs_bio_wq_end_io(fs_info, bio, metadata);
+			if (ret)
+				goto out;
+
 			/*
 			 * Lookup bio sums does extra checks around whether we
 			 * need to csum or not, which is why we ignore skip_sum
-- 
2.30.2

