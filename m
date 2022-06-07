Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040F753FB1C
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 12:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240432AbiFGKYb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 06:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbiFGKY1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 06:24:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1E25AA50
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 03:24:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 80BDC21AB8;
        Tue,  7 Jun 2022 10:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654597464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=uuXPKnv2F+MDakjUDyQSrSk0sElT3DovdgQupOWzb3E=;
        b=nsImpNqlKrUCArHDrzSbaUJmTftDafCeddWvnx47WYgRx2Pl6QNrQsMkX5QD95E57oTZ/f
        ej2Za9Zinhfn88n6YoytHvR5uLrO6/vnbWh31fApCqIa/eWs0Pj0AIM4VJnA9Y9gn0QlF2
        zglvNcsbaoeMwfVar7kCfCtTMki8DkM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F19513A88;
        Tue,  7 Jun 2022 10:24:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UTObEFgnn2JJTQAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 07 Jun 2022 10:24:24 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs-progs: convert: Properly work with large ext4 filesystems
Date:   Tue,  7 Jun 2022 13:24:21 +0300
Message-Id: <20220607102421.170419-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
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

On large (blockcount > 32bit) filesystems reading directly
super_block->s_blocks_count is not sufficient as the block count is held
in 2 separate 32 bit variables. Instead always use the provided
ext2fs_blocks_count to read the value. This can result in assertion
failure, when the block count is only held in the high 32 bits, in this
case s_block_counts would be zero, which would result in
btrfs_convert_context::block_count/total_bytes to also be 0 and hit an
assertion failure:

    convert/main.c:1162: do_convert: Assertion `cctx.total_bytes != 0` failed, value 0
    btrfs-convert(+0xffb0)[0x557defdabfb0]
    btrfs-convert(main+0x6c5)[0x557defdaa125]
    /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f66e1f8bd0a]
    btrfs-convert(_start+0x2a)[0x557defdab52a]
    Aborted

What's worse it can also result in btrfs-conver mistakenly thinking that
a filesystem is smaller than it actually is (ignoring the top 32 bits).

Link: https://lore.kernel.org/linux-btrfs/023b5ca9-0610-231b-fc4e-a72fe1377a5a@jansson.tech/
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 convert/main.c        | 4 +---
 convert/source-ext2.c | 4 ++--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/convert/main.c b/convert/main.c
index 73f919d25255..92ebb1acd181 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1134,7 +1134,6 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 	int ret;
 	int fd = -1;
 	u32 blocksize;
-	u64 total_bytes;
 	struct btrfs_root *root;
 	struct btrfs_root *image_root;
 	struct btrfs_convert_context cctx;
@@ -1161,7 +1160,6 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,

 	ASSERT(cctx.total_bytes != 0);
 	blocksize = cctx.blocksize;
-	total_bytes = (u64)blocksize * (u64)cctx.block_count;
 	if (blocksize < 4096) {
 		error("block size is too small: %u < 4096", blocksize);
 		goto fail;
@@ -1223,7 +1221,7 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,

 	mkfs_cfg.csum_type = csum_type;
 	mkfs_cfg.label = cctx.label;
-	mkfs_cfg.num_bytes = total_bytes;
+	mkfs_cfg.num_bytes = cctx.total_bytes;
 	mkfs_cfg.nodesize = nodesize;
 	mkfs_cfg.sectorsize = blocksize;
 	mkfs_cfg.stripesize = blocksize;
diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index 9fad4c50e244..610db16b81aa 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -92,8 +92,8 @@ static int ext2_open_fs(struct btrfs_convert_context *cctx, const char *name)

 	cctx->fs_data = ext2_fs;
 	cctx->blocksize = ext2_fs->blocksize;
-	cctx->block_count = ext2_fs->super->s_blocks_count;
-	cctx->total_bytes = (u64)ext2_fs->super->s_blocks_count * ext2_fs->blocksize;
+	cctx->block_count = ext2fs_blocks_count(ext2_fs->super);
+	cctx->total_bytes = cctx->block_count * cctx->blocksize;
 	cctx->label = strndup((char *)ext2_fs->super->s_volume_name, 16);
 	cctx->first_data_block = ext2_fs->super->s_first_data_block;
 	cctx->inodes_count = ext2_fs->super->s_inodes_count;
--
2.17.1

