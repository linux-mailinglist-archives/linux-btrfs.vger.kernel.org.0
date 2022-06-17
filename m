Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B676C54F4CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 12:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381334AbiFQKEe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 06:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380451AbiFQKEc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 06:04:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7105369715
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 03:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/s6AxVfQjfOJcBS/P3TLYQh8QUDMxCVE4AVIN21llF0=; b=r6Nqmwa4ca+LdIyS/GiMOr3Jgr
        SEzzX7hiNvXtIVwjGQvktJtRO34uT9Jqy13a4CWNuV7RO8t8WI3r95mHX1BfAZ64djSGkHn086HWI
        5SpcIXpT7AtNrm2C1YAq/385syJPstbSZcMhid5fnlEMptld44lImW6Rj6IUNDd2GD44BdScFT9xk
        9ZXKFSxdWxW9i25gOnC0aGAHca7St9hDoDmRXfJ1paZJ+CtdSFccgy3JwsaItLPnAEVNgeTZp2YHG
        A5pWsG3B3EYVT0kQ+63qKJP9yXEB7V5JLciO0jDtn35W04+b82mTaTn5tqJ/C2pV8mZjP3G40TpOr
        HphN/0Tw==;
Received: from [2001:4bb8:180:36f6:9c91:42c8:8d10:d7ed] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o28q5-006skd-SN; Fri, 17 Jun 2022 10:04:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/10] btrfs: remove the raid56_parity_write return value
Date:   Fri, 17 Jun 2022 12:04:08 +0200
Message-Id: <20220617100414.1159680-5-hch@lst.de>
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

Always consume the bio and call the end_io handler on error instead of
returning an error and letting the caller handle it.  This matches what
the block layer submission does and avoids any confusion on who
needs to handle errors.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c  | 23 +++++++++++++++--------
 fs/btrfs/raid56.h  |  2 +-
 fs/btrfs/volumes.c |  2 +-
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 233dcef6ce3ad..c0cc2d99509c9 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1803,18 +1803,19 @@ static void rbio_add_bio(struct btrfs_raid_bio *rbio, struct bio *orig_bio)
 /*
  * our main entry point for writes from the rest of the FS.
  */
-int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
+void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
 	struct btrfs_raid_bio *rbio;
 	struct btrfs_plug_cb *plug = NULL;
 	struct blk_plug_cb *cb;
-	int ret;
+	int ret = 0;
 
 	rbio = alloc_rbio(fs_info, bioc);
 	if (IS_ERR(rbio)) {
 		btrfs_put_bioc(bioc);
-		return PTR_ERR(rbio);
+		ret = PTR_ERR(rbio);
+		goto out;
 	}
 	rbio->operation = BTRFS_RBIO_WRITE;
 	rbio_add_bio(rbio, bio);
@@ -1829,8 +1830,8 @@ int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 	if (rbio_is_full(rbio)) {
 		ret = full_stripe_write(rbio);
 		if (ret)
-			btrfs_bio_counter_dec(fs_info);
-		return ret;
+			goto out_dec_counter;
+		return;
 	}
 
 	cb = blk_check_plugged(btrfs_raid_unplug, fs_info, sizeof(*plug));
@@ -1841,13 +1842,19 @@ int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 			INIT_LIST_HEAD(&plug->rbio_list);
 		}
 		list_add_tail(&rbio->plug_list, &plug->rbio_list);
-		ret = 0;
 	} else {
 		ret = __raid56_parity_write(rbio);
 		if (ret)
-			btrfs_bio_counter_dec(fs_info);
+			goto out_dec_counter;
 	}
-	return ret;
+
+	return;
+
+out_dec_counter:
+	btrfs_bio_counter_dec(fs_info);
+out:
+	bio->bi_status = errno_to_blk_status(ret);
+	bio_endio(bio);
 }
 
 /*
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 1dce205b79bf9..3f223ae39462a 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -167,7 +167,7 @@ struct btrfs_device;
 
 int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 			  int mirror_num, int generic_io);
-int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc);
+void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc);
 
 void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
 			    unsigned int pgoff, u64 logical);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bdcefc19cd51e..b30d4449ef18d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6768,7 +6768,7 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
 	    ((btrfs_op(bio) == BTRFS_MAP_WRITE) || (mirror_num > 1))) {
 		if (btrfs_op(bio) == BTRFS_MAP_WRITE)
-			ret = raid56_parity_write(bio, bioc);
+			raid56_parity_write(bio, bioc);
 		else
 			ret = raid56_parity_recover(bio, bioc, mirror_num, 1);
 		goto out_dec;
-- 
2.30.2

