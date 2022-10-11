Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E906E5FB024
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 12:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJKKIq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 06:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJKKIp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 06:08:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262B86745F
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 03:08:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B440921D47;
        Tue, 11 Oct 2022 10:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665482922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=DcjBFtO6fyk9dH6vL7M7Qrra8B8EhU4oY2gEgB4Ec2I=;
        b=GJyKGruI9EjmOqZ4dFezufar5Ccf/pnAAPLCu3HMRmusx20ktVF7HljTSJk/LB0UQYBhra
        6mK6IcEIJX7GEMR44aJyD+N2/V25Lk7uDeK8LfgcxuNOqyY5dk+Mzvn15hZh2wZ6pKJoYs
        04T9y8VyDYyvUfRLfkT4NlvdnJKWRtc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A8B792C141;
        Tue, 11 Oct 2022 10:08:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1390EDA79D; Tue, 11 Oct 2022 12:08:37 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: reorder btrfs_bio for better packing
Date:   Tue, 11 Oct 2022 12:08:36 +0200
Message-Id: <20221011100836.9064-1-dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After changes in commit 917f32a23501 ("btrfs: give struct btrfs_bio a
real end_io handler") the layout of btrfs_bio can be improved.  There
are two holes and the structure size is 264 bytes on release build. By
reordering the iterator we can get rid of the holes and the size is 256
bytes which fits to slabs much better.

Final layout:

struct btrfs_bio {
	unsigned int               mirror_num;           /*     0     4 */
	struct bvec_iter           iter;                 /*     4    20 */
	u64                        file_offset;          /*    24     8 */
	struct btrfs_device *      device;               /*    32     8 */
	u8 *                       csum;                 /*    40     8 */
	u8                         csum_inline[64];      /*    48    64 */
	/* --- cacheline 1 boundary (64 bytes) was 48 bytes ago --- */
	btrfs_bio_end_io_t         end_io;               /*   112     8 */
	void *                     private;              /*   120     8 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	struct work_struct         end_io_work;          /*   128    32 */
	struct bio                 bio;                  /*   160    96 */

	/* size: 256, cachelines: 4, members: 10 */
};

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 599b9d5af349..f8b668dc8bf8 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -395,6 +395,7 @@ typedef void (*btrfs_bio_end_io_t)(struct btrfs_bio *bbio);
  */
 struct btrfs_bio {
 	unsigned int mirror_num;
+	struct bvec_iter iter;
 
 	/* for direct I/O */
 	u64 file_offset;
@@ -403,7 +404,6 @@ struct btrfs_bio {
 	struct btrfs_device *device;
 	u8 *csum;
 	u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
-	struct bvec_iter iter;
 
 	/* End I/O information supplied to btrfs_bio_alloc */
 	btrfs_bio_end_io_t end_io;
-- 
2.37.3

