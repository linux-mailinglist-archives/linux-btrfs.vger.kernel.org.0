Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAF0722156
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 10:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjFEIpd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 04:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjFEIp3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 04:45:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D15A100
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 01:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3+bItWR1gepd8DnNnjGK8NxI5XtSJB11Dh+SzqbGHDw=; b=AeCKBFaDqFr/HGdmAZzjpe/6V0
        oH2u0WiELpg/6+4q/G/NpgPWL9zisGbC9rMkVZKUKb6btx5dKUlHbe7REVgJhKW13LITOkQf8iZqs
        m3bh1u73h8vTyeD7e3pv8V/tAkYpl1It4UXXSraOE+AFZeUn46YDaJ/9KrXOBnsuJ8XrVvCDE9b2M
        tZzvAqoKqmfL5smtSq40N46OVohbGrqZE7pLuuXZoIP2hEqtJvwJ+Rp5dp6rG5mVqLeppuI8sy4EI
        DR3MRLeh5M6rlbw933QAgwFQmicqtPUSTdofeeFrngwkD8/t9GisjchGVRiTw74ZPzPFKUZyuoIOs
        YzIQq3lg==;
Received: from [2001:4bb8:191:e9d5:e931:d7f5:9239:69f3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q65q8-00Eka0-2Q;
        Mon, 05 Jun 2023 08:45:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: factor out a btrfs_inode_is_nodatasum helper
Date:   Mon,  5 Jun 2023 10:45:18 +0200
Message-Id: <20230605084519.580346-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230605084519.580346-1-hch@lst.de>
References: <20230605084519.580346-1-hch@lst.de>
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

Split out a helper to check if an inode needs nodatasum treatment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c         | 3 +--
 fs/btrfs/btrfs_inode.h | 7 +++++++
 fs/btrfs/file-item.c   | 3 +--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index c9b4aa339b4b07..627d06fbb4c425 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -659,8 +659,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		 * Csum items for reloc roots have already been cloned at this
 		 * point, so they are handled as part of the no-checksum case.
 		 */
-		if (inode && !(inode->flags & BTRFS_INODE_NODATASUM) &&
-		    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state) &&
+		if (inode && !btrfs_inode_is_nodatasum(inode) &&
 		    !btrfs_is_data_reloc_root(inode->root)) {
 			if (should_async_write(bbio) &&
 			    btrfs_wq_submit_bio(bbio, bioc, &smap, mirror_num))
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 8abf96cfea8fae..713439d62adda3 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -535,4 +535,11 @@ void btrfs_update_inode_bytes(struct btrfs_inode *inode, const u64 add_bytes,
 			      const u64 del_bytes);
 void btrfs_assert_inode_range_clean(struct btrfs_inode *inode, u64 start, u64 end);
 
+static inline bool btrfs_inode_is_nodatasum(struct btrfs_inode *inode)
+{
+	return (inode->flags & BTRFS_INODE_NODATASUM) ||
+		test_bit(BTRFS_FS_STATE_NO_CSUMS,
+			 &inode->root->fs_info->fs_state);
+}
+
 #endif
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 2e7d5ec6c9a68c..5e6603e76e5ac0 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -355,8 +355,7 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 	blk_status_t ret = BLK_STS_OK;
 	u32 bio_offset = 0;
 
-	if ((inode->flags & BTRFS_INODE_NODATASUM) ||
-	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state))
+	if (btrfs_inode_is_nodatasum(inode))
 		return BLK_STS_OK;
 
 	/*
-- 
2.39.2

