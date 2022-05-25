Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73AB533B1C
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 12:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbiEYK7p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 06:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbiEYK7o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 06:59:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C47B5EDE6
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 03:59:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2E22B21A59;
        Wed, 25 May 2022 10:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653476382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WDctNB/veqTz/MmZVxHHf3z6LX06phlfzDb+nWHeCSc=;
        b=XbSXh2TTAL5G7W5GydpkGuUjw70M/gaxY5LkzGhZuL+dwMud2pZHovfbQTo+8ZKOM3ei5/
        LLup53WYhrpcvCywpmA6c6zSmQNKlrrqioTrrzhGsGoWMWbdAx1u2aC+rsme8xv7Fj3dbq
        vywcfFeaaAtbyeMqQQfGu3aZDiKGAmk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0999213ADF;
        Wed, 25 May 2022 10:59:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SOUUMRwMjmK0AQAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 25 May 2022 10:59:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 3/7] btrfs: add a btrfs_map_bio_wait helper
Date:   Wed, 25 May 2022 18:59:13 +0800
Message-Id: <aef1280361f3251d35f5a0a09092ddf2a9270d89.1653476251.git.wqu@suse.com>
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

From: Christoph Hellwig <hch@lst.de>

This helpers works like submit_bio_wait, but goes through the btrfs bio
mapping using btrfs_map_bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 21 +++++++++++++++++++++
 fs/btrfs/volumes.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0819db46dbc4..8925bc606db7 100644
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
index 6f784d4f5466..b346f6c40151 100644
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
2.36.1

