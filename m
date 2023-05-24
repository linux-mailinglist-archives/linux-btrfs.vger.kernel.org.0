Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1990370F9B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 17:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbjEXPDx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 11:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbjEXPDw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 11:03:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B78135
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 08:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=SGwH4OqnDp+nSeB531bM9ETOe0GT5AYHmZ4bdWoovR4=; b=s0uRfXOONgNb5sK/umYKVwfi3y
        QWWYkWBTDH+W0Eq42bo+zTM3I6SFYiGiBj5soGdUkMxcyXRdYfcOetY3oXvIA1jzcxhnMBPmDdEab
        jZ95/2V6u+Au7crHLCi0WcMkkr+s7zooRNxbxhSdGXAa0c7s4RLswlYvxKhStBMI6gIfKRiLWiviH
        0V91I+cNti89/unFsf8kcOBI1Kdom1f5jHRsmRaLfB5wvEkXa3kIgElZdyl7AJ5B/8oovYgIVnkf1
        q/0hOUThZL6BER4fwvdiap2ahfEJ5tie3MfBRV1jHtOm5g3EdIA00Jrlp2ypBOyQnp7A2EVy16+5+
        ILwJrzig==;
Received: from [89.144.223.4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1q1e-00Dmcc-05;
        Wed, 24 May 2023 15:03:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 07/14] btrfs: reorder btrfs_extract_ordered_extent
Date:   Wed, 24 May 2023 17:03:10 +0200
Message-Id: <20230524150317.1767981-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524150317.1767981-1-hch@lst.de>
References: <20230524150317.1767981-1-hch@lst.de>
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

There is no good reason for doing one before the other in terms of
failure implications, but doing the extent_map split first will
simplify some upcoming refactoring.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 781bd0d48f02ce..5de029ef0b399c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2719,9 +2719,7 @@ int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
 {
 	u64 start = (u64)bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 len = bbio->bio.bi_iter.bi_size;
-	struct btrfs_inode *inode = bbio->inode;
-	u64 ordered_len = ordered->num_bytes;
-	int ret = 0;
+	int ret;
 
 	/* Must always be called for the beginning of an ordered extent. */
 	if (WARN_ON_ONCE(start != ordered->disk_bytenr))
@@ -2731,18 +2729,18 @@ int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
 	if (ordered->disk_num_bytes == len)
 		return 0;
 
-	ret = btrfs_split_ordered_extent(ordered, len);
-	if (ret)
-		return ret;
-
 	/*
 	 * Don't split the extent_map for NOCOW extents, as we're writing into
 	 * a pre-existing one.
 	 */
-	if (test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags))
-		return 0;
+	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags)) {
+		ret = split_extent_map(bbio->inode, bbio->file_offset,
+				       ordered->num_bytes, len);
+		if (ret)
+			return ret;
+	}
 
-	return split_extent_map(inode, bbio->file_offset, ordered_len, len);
+	return btrfs_split_ordered_extent(ordered, len);
 }
 
 /*
-- 
2.39.2

