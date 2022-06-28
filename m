Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52A855D714
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242083AbiF1H2y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jun 2022 03:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242044AbiF1H2p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jun 2022 03:28:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED14B101E6
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jun 2022 00:28:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ABD941FB3C;
        Tue, 28 Jun 2022 07:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656401323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=STOFWKhpEtePim/Zo8FzXhxFJxFMKHbFtnaz4ZZx2qA=;
        b=OBCKu80fU6bo2TGp3CYrluglFbPV0RZymI9oKEQ6wBbhjCtMAEJEP0JQa6FHEbkQLFjE9N
        rZw8/cM2cl6CF3HckfrzmtLzQRzSGlCzlqzVtYDhBYeJVfoEelh9J6f+Pi5A9hYUwKHJeF
        oDkQTFFDBrWK1OIAjiM/akq1GhUartY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D708139E9;
        Tue, 28 Jun 2022 07:28:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iCXxAamtumJzFQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 28 Jun 2022 07:28:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     marek.behun@nic.cz, linux-btrfs@vger.kernel.org,
        jnhuang95@gmail.com, linux-erofs@lists.ozlabs.org,
        trini@konsulko.com, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH RFC 5/8] fs: fat: rely on higher layer to get block aligned read range
Date:   Tue, 28 Jun 2022 15:28:05 +0800
Message-Id: <baf6d4c4715b83fabe906e17fffe57934d4d6469.1656401086.git.wqu@suse.com>
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

Just implement fat_get_blocksize() for fat, so that fat_read_file()
always get a block aligned read range.

Unfortunately I'm not experienced enough to cleanup the fat code, thus
further cleanup is appreciated.

Cc: Tom Rini <trini@konsulko.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/fat/fat.c  | 13 +++++++++++++
 fs/fs.c       |  2 +-
 include/fat.h |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index dcceccbcee0a..e13035e8e6d1 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -1299,6 +1299,19 @@ int fat_read_file(const char *filename, void *buf, loff_t offset, loff_t len,
 	return ret;
 }
 
+int fat_get_blocksize(const char *filename)
+{
+	fsdata fsdata = {0};
+	int ret;
+
+	ret = get_fs_info(&fsdata);
+	if (ret)
+		return ret;
+
+	free(fsdata.fatbuf);
+	return fsdata.sect_size;
+}
+
 typedef struct {
 	struct fs_dir_stream parent;
 	struct fs_dirent dirent;
diff --git a/fs/fs.c b/fs/fs.c
index e69a0968bb6d..7e4ead9b790b 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -207,7 +207,7 @@ static struct fstype_info fstypes[] = {
 		.exists = fat_exists,
 		.size = fat_size,
 		.read = fat_read_file,
-		.get_blocksize = fs_get_blocksize_unsupported,
+		.get_blocksize = fat_get_blocksize,
 #if CONFIG_IS_ENABLED(FAT_WRITE)
 		.write = file_fat_write,
 		.unlink = fat_unlink,
diff --git a/include/fat.h b/include/fat.h
index a9756fb4cd1b..c03a2bebecef 100644
--- a/include/fat.h
+++ b/include/fat.h
@@ -201,6 +201,7 @@ int file_fat_detectfs(void);
 int fat_exists(const char *filename);
 int fat_size(const char *filename, loff_t *size);
 int file_fat_read(const char *filename, void *buffer, int maxsize);
+int fat_get_blocksize(const char *filename);
 int fat_set_blk_dev(struct blk_desc *rbdd, struct disk_partition *info);
 int fat_register_device(struct blk_desc *dev_desc, int part_no);
 
-- 
2.36.1

