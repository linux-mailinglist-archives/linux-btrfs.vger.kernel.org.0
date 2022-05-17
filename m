Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D73252A54D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 16:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349299AbiEQOvn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 10:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349387AbiEQOvT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 10:51:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE1615831
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=l7e6jh4N6fG6Hwh7Zqm+d4K0UQfsCKbZxDQNeNzv8M8=; b=QTViyS1PbKcShSEUSjGad6TyxK
        p7i0tnaf4u6r+8Xrs75KnOCuDdJiNqJHp1ZWKZqcxA3/dInBvmkf44I9S5a+2+yiT9EbOPWUbZZHs
        M3vJboYRkS835jlRBi2b3p4d+eQViH+KAuh/vht9yD6erWuk+UiMp0v9cp0hsow9OIrvgLVM2j14P
        NwxvsDoi7s4SFo8644+NZLvKvv3B5TxYn2/Paa7U7NkHsgMNEkES2CAw6laUrAmfokuICbI0xESN4
        q0zlNGG9i3gQryjImqpsyHCoCVe5AfH+m4XWgzPlVz4VD1k77MCtAxBtOwaw9sHzgqB72ILAi8z9X
        dRovO8AQ==;
Received: from [89.144.222.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqyXc-00EXFN-4r; Tue, 17 May 2022 14:51:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 10/15] btrfs: add a btrfs_map_bio_wait helper
Date:   Tue, 17 May 2022 16:50:34 +0200
Message-Id: <20220517145039.3202184-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517145039.3202184-1-hch@lst.de>
References: <20220517145039.3202184-1-hch@lst.de>
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

This helpers works like submit_bio_wait, but goes through the btrfs bio
mapping using btrfs_map_bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 21 +++++++++++++++++++++
 fs/btrfs/volumes.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0819db46dbc42..8925bc606db7e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6818,6 +6818,27 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	return BLK_STS_OK;
 }
 
+static void btrfs_end_io_sync(struct bio *bio)
+{
+	complete(bio->bi_private);
+}
+
+blk_status_t btrfs_map_bio_wait(struct btrfs_fs_info *fs_info, struct bio *bio,
+		int mirror)
+{
+	DECLARE_COMPLETION_ONSTACK(done);
+	blk_status_t ret;
+
+	bio->bi_private = &done;
+	bio->bi_end_io = btrfs_end_io_sync;
+	ret = btrfs_map_bio(fs_info, bio, mirror);
+	if (ret)
+		return ret;
+
+	wait_for_completion_io(&done);
+	return bio->bi_status;
+}
+
 static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
 				      const struct btrfs_fs_devices *fs_devices)
 {
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 6f784d4f54664..b346f6c401515 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -555,6 +555,8 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 void btrfs_mapping_tree_free(struct extent_map_tree *tree);
 blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			   int mirror_num);
+blk_status_t btrfs_map_bio_wait(struct btrfs_fs_info *fs_info, struct bio *bio,
+		int mirror);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       fmode_t flags, void *holder);
 struct btrfs_device *btrfs_scan_one_device(const char *path,
-- 
2.30.2

