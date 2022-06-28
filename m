Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE7B55D998
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiF1H2x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jun 2022 03:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiF1H2n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jun 2022 03:28:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1743BE008
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jun 2022 00:28:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CCC681FB3C;
        Tue, 28 Jun 2022 07:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656401320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fqDh39Eux/iXUNBq/dB1wZRAl5zZcXfXHaBWI4ElYTI=;
        b=Lif/iwWm1brMCb1ac9Aw6rr1E2FN9YS/dOZOEKZkYg46+NzjlO4zx1NsxYS2E+VQE++ptC
        SqU6vcUDDKd/tHz8lbDCFFm8nM4F3w3Eh3Vpt4P8tsjbb8wAtxUwnOfuGI6DlbY7JBI/2t
        DrU4Z/HBjgZjVwKliaSnUlOxZyQ+BPs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E4CB139E9;
        Tue, 28 Jun 2022 07:28:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ULBZCqatumJzFQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 28 Jun 2022 07:28:38 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     marek.behun@nic.cz, linux-btrfs@vger.kernel.org,
        jnhuang95@gmail.com, linux-erofs@lists.ozlabs.org,
        trini@konsulko.com, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH RFC 4/8] fs: ext4: rely on _fs_read() to pass block aligned range into ext4fs_read_file()
Date:   Tue, 28 Jun 2022 15:28:04 +0800
Message-Id: <d001706f1471ca0d4e98b7de9f9080188ddd2252.1656401086.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656401086.git.wqu@suse.com>
References: <cover.1656401086.git.wqu@suse.com>
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

Since _fs_read() is handling the unaligned read internally, ext4 driver
only need to handle block aligned read.

Unfortunately I'm not familiar with ext4 and its driver, thus not
confident enough to cleanup all the unaligned read related code.

So here we will have some dead code, and any help to clean them up is
appreciated.

Cc: Tom Rini <trini@konsulko.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/ext4/ext4fs.c | 11 +++++++++++
 fs/fs.c          |  2 +-
 include/ext4fs.h |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
index 4c89152ce4ad..be2680994d8b 100644
--- a/fs/ext4/ext4fs.c
+++ b/fs/ext4/ext4fs.c
@@ -71,6 +71,10 @@ int ext4fs_read_file(struct ext2fs_node *node, loff_t pos,
 
 	ext_cache_init(&cache);
 
+	/* Higher layer has ensured to pass block aligned range here. */
+	assert(IS_ALIGNED(pos, blocksize));
+	assert(IS_ALIGNED(len, blocksize));
+
 	/* Adjust len so it we can't read past the end of the file. */
 	if (len + pos > filesize)
 		len = (filesize - pos);
@@ -183,6 +187,13 @@ int ext4fs_read_file(struct ext2fs_node *node, loff_t pos,
 	return 0;
 }
 
+int ext4fs_get_blocksize(const char *filename)
+{
+	struct ext_filesystem *fs = get_fs();
+
+	return fs->blksz;
+}
+
 int ext4fs_ls(const char *dirname)
 {
 	struct ext2fs_node *dirnode = NULL;
diff --git a/fs/fs.c b/fs/fs.c
index 30696ac6c1a3..e69a0968bb6d 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -236,7 +236,7 @@ static struct fstype_info fstypes[] = {
 		.exists = ext4fs_exists,
 		.size = ext4fs_size,
 		.read = ext4_read_file,
-		.get_blocksize = fs_get_blocksize_unsupported,
+		.get_blocksize = ext4fs_get_blocksize,
 #ifdef CONFIG_CMD_EXT4_WRITE
 		.write = ext4_write_file,
 		.ln = ext4fs_create_link,
diff --git a/include/ext4fs.h b/include/ext4fs.h
index cb5d9cc0a5c0..cc40cfedd954 100644
--- a/include/ext4fs.h
+++ b/include/ext4fs.h
@@ -146,6 +146,7 @@ int ext4fs_create_link(const char *target, const char *fname);
 struct ext_filesystem *get_fs(void);
 int ext4fs_open(const char *filename, loff_t *len);
 int ext4fs_read(char *buf, loff_t offset, loff_t len, loff_t *actread);
+int ext4fs_get_blocksize(const char *filename);
 int ext4fs_mount(unsigned part_length);
 void ext4fs_close(void);
 void ext4fs_reinit_global(void);
-- 
2.36.1

