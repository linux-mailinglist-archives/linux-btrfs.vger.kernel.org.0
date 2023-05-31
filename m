Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA71717503
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 06:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjEaERz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 00:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjEaERx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 00:17:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F06410E
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 21:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gyQUPySqgk3Y8ATRA/lxtVE3E/VVbzqYOiHEFSTNohQ=; b=DdogJ2wQDtDcx2dUd2J+0XJx+/
        XR27OFlmIMcSxONYkkNSHDjDwD70hayPhB8RZaI9bpl6TtwxpltnrII6M4QB/5yusI2MzZbT/TVVc
        AK77pKlpUnk1lUXnhWpV4Ca7hHx3sWv6eqR87yaW/L6hMGCP7IzFNk5By+7irJITHfT0WxdA6J061
        5TWkt9ImzgRBYFpjYBX3TxH6tLvjewLI28nQIczb0E7Yc6O+2CkE3eDH6eaKJ+Aa7H+Iop3rL6b+W
        WlF2/fsmK1P1j6TptmCJPBdbJ6WinsdyYNpGRKx5FvrcuUyikXZ4zeMkuQo+AtpOj4JGzYeIyvc/a
        zk8iUT0g==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4DHS-00G1Pm-1O;
        Wed, 31 May 2023 04:17:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs: remove btrfs_map_block
Date:   Wed, 31 May 2023 06:17:36 +0200
Message-Id: <20230531041740.375963-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531041740.375963-1-hch@lst.de>
References: <20230531041740.375963-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are no users of btrfs_map_block left, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 8 --------
 fs/btrfs/volumes.h | 3 ---
 2 files changed, 11 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c236bfba0cec3b..4c6405c4ce041d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6481,14 +6481,6 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	return ret;
 }
 
-int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
-		      u64 logical, u64 *length,
-		      struct btrfs_io_context **bioc_ret, int mirror_num)
-{
-	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret,
-				 NULL, &mirror_num, 0);
-}
-
 /* For Scrub/replace */
 int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		     u64 logical, u64 *length,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index e960a51abf873d..481f3ace988c44 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -582,9 +582,6 @@ static inline unsigned long btrfs_chunk_item_size(int num_stripes)
 
 void btrfs_get_bioc(struct btrfs_io_context *bioc);
 void btrfs_put_bioc(struct btrfs_io_context *bioc);
-int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
-		    u64 logical, u64 *length,
-		    struct btrfs_io_context **bioc_ret, int mirror_num);
 int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		     u64 logical, u64 *length,
 		     struct btrfs_io_context **bioc_ret);
-- 
2.39.2

