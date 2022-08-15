Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4179592E5B
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Aug 2022 13:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiHOLqE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Aug 2022 07:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiHOLqD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Aug 2022 07:46:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E05ABC9F
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Aug 2022 04:46:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C947A352B4;
        Mon, 15 Aug 2022 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660563961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MCKxMgXFwdkGpSDQPhoMw3j6fGGECVOIJmuZZk37QjQ=;
        b=f3m+j49SiLQhfXNly4L66OiUh0+/I+le6WnS/uOwwVgWdNp4zAetQ/XuJnsaI261HyG+HD
        /FxhLlv28F8qtaorfyvbcqkD8/wZ+RGqAug2A1Cu9664FBc0UVJR2XURgI3JLssLo7vzng
        0eBuXqF/LpVpURsCpDMYFTUgjDwNo+Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90B4413A93;
        Mon, 15 Aug 2022 11:45:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ILHqNPUx+mLsGAAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 15 Aug 2022 11:45:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     marek.behun@nic.cz, linux-btrfs@vger.kernel.org,
        jnhuang95@gmail.com, linux-erofs@lists.ozlabs.org,
        trini@konsulko.com, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v3 6/8] fs: fat: rely on higher layer to get block aligned read range
Date:   Mon, 15 Aug 2022 19:45:17 +0800
Message-Id: <bff5d372d7fa62173a69d5200d844396dd4b9462.1660563403.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660563403.git.wqu@suse.com>
References: <cover.1660563403.git.wqu@suse.com>
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
index b26cc8e2e840..ea4325cd0b00 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -208,7 +208,7 @@ static struct fstype_info fstypes[] = {
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
2.37.1

