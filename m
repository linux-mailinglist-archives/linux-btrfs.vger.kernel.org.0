Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D486533B23
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 12:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbiEYK7m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 06:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbiEYK7l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 06:59:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0605EDE6
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 03:59:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 19A6B1F93E;
        Wed, 25 May 2022 10:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653476379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lm7PihVKbV+9QZsORzpyjvpOtsEvQ3YmWkfAcpKY6cU=;
        b=HaCDgxZz/ZrdZp1GPiWtom11d5WoitEq7END8QLmHP706k8uvGi1fZ/GRbI1bzE+KnHXiF
        k6TmkRR+XaogHNvBx97cOL9btngtpiw4VmCEcihFradNd/P8jMZ6I3egNcumJmXyT0ZL42
        STLMt/SIxv5t9MOmslecwDtMArA3yBw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35EAD13ADF;
        Wed, 25 May 2022 10:59:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eNdBABoMjmK0AQAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 25 May 2022 10:59:38 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/7] btrfs: save the original bi_iter into btrfs_bio for buffered read
Date:   Wed, 25 May 2022 18:59:11 +0800
Message-Id: <be8e94c5b3236cda374109f9af64f860f88804c4.1653476251.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1653476251.git.wqu@suse.com>
References: <cover.1653476251.git.wqu@suse.com>
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
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 7 +++++++
 fs/btrfs/inode.c     | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1d144f655f65..1bd1b1253f9d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -188,6 +188,13 @@ static void submit_one_bio(struct bio *bio, int mirror_num,
 	/* Caller should ensure the bio has at least some range added */
 	ASSERT(bio->bi_iter.bi_size);
 
+	/*
+	 * Save the original bi_iter for read bios, as read repair wants the
+	 * orignial logical bytenr.
+	 */
+	if (bio_op(bio) == REQ_OP_READ)
+		btrfs_bio(bio)->iter = bio->bi_iter;
+
 	if (is_data_inode(tree->private_data))
 		btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
 					    compress_type);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 34466b543ed9..dd0882e1b982 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7974,6 +7974,8 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
 		if (ret)
 			goto err;
+		/* Check submit_one_bio() for the reason. */
+		btrfs_bio(bio)->iter = bio->bi_iter;
 	}
 
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
-- 
2.36.1

