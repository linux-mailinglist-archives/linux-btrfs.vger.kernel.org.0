Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE43517DA7
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 08:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiECGzl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 02:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiECGxx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 02:53:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11CC63AF
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 23:50:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 58B63210EA
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 06:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651560618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FWAbtDGKIN1fbdmsym4iNqsHy3KEGM02Lg36Lop6FQA=;
        b=VugKKktlpceKgfMiI521PpgUiEYDbjLcZL6LhFHYLVoA00wBrC9RujyPzmKWjh5tcndZZi
        R4XfXRhTH0aMNnIXXkkfbELLn9epNJCrCU8moTM9UeT8JdiKdAZLJt/c3n9VQ85fvkzSqR
        SzfKwvkXBGlakyTNoUzsGGoB6VVFREI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C38BC13AA3
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 06:50:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QBDgJKnQcGIZDAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 03 May 2022 06:50:17 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/13] btrfs: save the original bi_iter into btrfs_bio for buffered read
Date:   Tue,  3 May 2022 14:49:47 +0800
Message-Id: <50c90265a7371f0ed1ec9e94c2e4e00a915ec69f.1651559986.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <cover.1651559986.git.wqu@suse.com>
References: <cover.1651559986.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although we have btrfs_bio::iter, it currently have very limited usage:

- RAID56
  Which is not needed at all

- btrfs_bio_clone()
  This is used mostly for direct IO.

For the incoming read repair patches, we want to grab the original
logical bytenr, and be able to iterate the range of the bio (no matter
if it's cloned).

So this patch will also save btrfs_bio::iter for buffered read bios at
submit_one_bio().
And for the sake of consistency, also save the btrfs_bio::iter for
direct IO at btrfs_submit_dio_bio().

The reason that we didn't save the iter in btrfs_map_bio() is,
btrfs_map_bio() is going to handle various bios, with or without
btrfs_bio bioset.
And we  want to keep btrfs_map_bio() to handle and only handle plain bios
without bother the bioset.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 12 ++++++++++++
 fs/btrfs/inode.c     |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 07888cce3bce..0ae4ee7f344d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -186,6 +186,18 @@ static void submit_one_bio(struct bio *bio, int mirror_num, unsigned long bio_fl
 	/* Caller should ensure the bio has at least some range added */
 	ASSERT(bio->bi_iter.bi_size);
 
+	/*
+	 * Save the original bi_iter for read bios, as read repair wants the
+	 * orignial logical bytenr.
+	 *
+	 * We don't do this in btrfs_map_bio() because that function is
+	 * bioset independent.
+	 * We can later pass bios without btrfs_bio or with other bioset into
+	 * btrfs_map_bio().
+	 */
+	if (bio_op(bio) == REQ_OP_READ)
+		btrfs_bio(bio)->iter = bio->bi_iter;
+
 	if (is_data_inode(tree->private_data))
 		btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
 					    bio_flags);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5b1a60a25ef6..f4dfb79fafce 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7926,6 +7926,8 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
 		if (ret)
 			goto err;
+		/* Check submit_one_bio() for the reason. */
+		btrfs_bio(bio)->iter = bio->bi_iter;
 	}
 
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
-- 
2.36.0

