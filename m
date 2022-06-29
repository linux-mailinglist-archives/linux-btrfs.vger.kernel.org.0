Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4BA55FEEB
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jun 2022 13:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiF2LjX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jun 2022 07:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiF2LjH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jun 2022 07:39:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5513F304
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 04:39:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 863581FE7B;
        Wed, 29 Jun 2022 11:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656502742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sbUxiVYdk6aZy8J7Gm/I8CcZX32AdO9X/hxJuXeK2yU=;
        b=Iabo3qhjdiHWEr5vQcS+tB0+2LAhvqzAxRglKOnVwpG54FtH3a8NT7SKZ+50S2UZA/2Xz+
        DircC5ed6OrlD5z3rDUfUzB6MPTBqZnA34LRkPmtX4FPR77BW3meC4HwKslxJOF65m9vx0
        r9xN/xTqKWqFB0jfZRSJY9kzARiXWMk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44C9E133D1;
        Wed, 29 Jun 2022 11:39:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8LGpBNQ5vGLFPwAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 29 Jun 2022 11:39:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     marek.behun@nic.cz, linux-btrfs@vger.kernel.org,
        jnhuang95@gmail.com, linux-erofs@lists.ozlabs.org,
        trini@konsulko.com, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH 5/8] fs: ext4: rely on _fs_read() to handle leading unaligned block read
Date:   Wed, 29 Jun 2022 19:38:26 +0800
Message-Id: <e853732016e9e80dfdb2edce8d81d91be1dec15d.1656502685.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656502685.git.wqu@suse.com>
References: <cover.1656502685.git.wqu@suse.com>
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

Just add ext4_get_blocksize() and a new assert() in ext4fs_read_file().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Several cleanup candicate:

1. ext_fs->blksz is never populated, thus it's always 0
   We can not easily grab blocksize just like btrfs in this case.

   Thus we have to go the same calculation in ext4fs_read_file().

2. can not easily cleanup @skipfirst in ext4fs_read_file()
   It seems to screw up with soft link read.
---
 fs/ext4/ext4fs.c | 22 ++++++++++++++++++++++
 fs/fs.c          |  2 +-
 include/ext4fs.h |  1 +
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
index 4c89152ce4ad..b0568e77a895 100644
--- a/fs/ext4/ext4fs.c
+++ b/fs/ext4/ext4fs.c
@@ -69,6 +69,8 @@ int ext4fs_read_file(struct ext2fs_node *node, loff_t pos,
 	short status;
 	struct ext_block_cache cache;
 
+	assert(IS_ALIGNED(pos, blocksize));
+
 	ext_cache_init(&cache);
 
 	/* Adjust len so it we can't read past the end of the file. */
@@ -259,6 +261,26 @@ int ext4_read_file(const char *filename, void *buf, loff_t offset, loff_t len,
 	return ext4fs_read(buf, offset, len, len_read);
 }
 
+int ext4_get_blocksize(const char *filename)
+{
+	struct ext_filesystem *fs;
+	int log2blksz;
+	int log2_fs_blocksize;
+	loff_t file_len;
+	int ret;
+
+	ret = ext4fs_open(filename, &file_len);
+	if (ret < 0) {
+		printf("** File not found %s **\n", filename);
+		return -1;
+	}
+	fs = get_fs();
+	log2blksz = fs->dev_desc->log2blksz;
+	log2_fs_blocksize = LOG2_BLOCK_SIZE(ext4fs_file->data) - log2blksz;
+
+	return (1 << (log2_fs_blocksize + log2blksz));
+}
+
 int ext4fs_uuid(char *uuid_str)
 {
 	if (ext4fs_root == NULL)
diff --git a/fs/fs.c b/fs/fs.c
index f9df8d9ec9a4..3cd2c88a4895 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -236,7 +236,7 @@ static struct fstype_info fstypes[] = {
 		.exists = ext4fs_exists,
 		.size = ext4fs_size,
 		.read = ext4_read_file,
-		.get_blocksize = fs_get_blocksize_unsupported,
+		.get_blocksize = ext4_get_blocksize,
 #ifdef CONFIG_CMD_EXT4_WRITE
 		.write = ext4_write_file,
 		.ln = ext4fs_create_link,
diff --git a/include/ext4fs.h b/include/ext4fs.h
index cb5d9cc0a5c0..0f4cf32dcc2a 100644
--- a/include/ext4fs.h
+++ b/include/ext4fs.h
@@ -161,6 +161,7 @@ int ext4fs_probe(struct blk_desc *fs_dev_desc,
 		 struct disk_partition *fs_partition);
 int ext4_read_file(const char *filename, void *buf, loff_t offset, loff_t len,
 		   loff_t *actread);
+int ext4_get_blocksize(const char *filename);
 int ext4_read_superblock(char *buffer);
 int ext4fs_uuid(char *uuid_str);
 void ext_cache_init(struct ext_block_cache *cache);
-- 
2.36.1

