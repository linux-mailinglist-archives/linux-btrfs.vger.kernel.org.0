Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E46580ACC
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 07:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbiGZFXE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 01:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbiGZFXC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 01:23:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA26127CE3
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 22:23:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6191C34BB2;
        Tue, 26 Jul 2022 05:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658812980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QnjwJOqg2q74dFJjkG5kgqyCneA2BG0g7oVk3bzXxk=;
        b=rD1mz95ubv0McROngVcBFuZ5ZTQiasuQmOrtdbtiqi+IcCdH6twjVuYUMa2UsWfNGVl6fy
        h4VV0K/p8JsUFeaDrNkJhrIXPTvLMdUgwJczPNQpsBUsrEMrQ+KzkQ9zYaMqpLzQcy5FBu
        ZSIkF+KRGdqiXLB/W2qNGIIPDgOGZhw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07B1513A12;
        Tue, 26 Jul 2022 05:22:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EK/bMjF632IFOwAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 26 Jul 2022 05:22:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     marek.behun@nic.cz, linux-btrfs@vger.kernel.org,
        jnhuang95@gmail.com, linux-erofs@lists.ozlabs.org,
        trini@konsulko.com, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v2 8/8] fs: erofs: add unaligned read range handling
Date:   Tue, 26 Jul 2022 13:22:16 +0800
Message-Id: <e58e82d22e1492b51ad3cc591272462fa5b7ef86.1658812744.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1658812744.git.wqu@suse.com>
References: <cover.1658812744.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm not an expert on erofs, but my quick glance didn't expose any
special handling on unaligned range, thus I think the U-boot erofs
driver doesn't really support unaligned read range.

This patch will add erofs_get_blocksize() so erofs can benefit from the
generic unaligned read support.

Cc: Huang Jianan <jnhuang95@gmail.com>
Cc: linux-erofs@lists.ozlabs.org
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Huang Jianan <jnhuang95@gmail.com>
---
 fs/erofs/internal.h | 1 +
 fs/erofs/super.c    | 6 ++++++
 fs/fs.c             | 2 +-
 include/erofs.h     | 1 +
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4af7c91560cc..d368a6481bf1 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -83,6 +83,7 @@ struct erofs_sb_info {
 	u16 available_compr_algs;
 	u16 lz4_max_distance;
 	u32 checksum;
+	u32 blocksize;
 	u16 extra_devices;
 	union {
 		u16 devt_slotoff;		/* used for mkfs */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 4cca322b9ead..df01d2e719a7 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -99,7 +99,13 @@ int erofs_read_superblock(void)
 
 	sbi.build_time = le64_to_cpu(dsb->build_time);
 	sbi.build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
+	sbi.blocksize = 1 << blkszbits;
 
 	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
 	return erofs_init_devices(&sbi, dsb);
 }
+
+int erofs_get_blocksize(const char *filename)
+{
+	return sbi.blocksize;
+}
diff --git a/fs/fs.c b/fs/fs.c
index 2b847d83597b..23cfb1f5025b 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -375,7 +375,7 @@ static struct fstype_info fstypes[] = {
 		.readdir = erofs_readdir,
 		.ls = fs_ls_generic,
 		.read = erofs_read,
-		.get_blocksize = fs_get_blocksize_unsupported,
+		.get_blocksize = erofs_get_blocksize,
 		.size = erofs_size,
 		.close = erofs_close,
 		.closedir = erofs_closedir,
diff --git a/include/erofs.h b/include/erofs.h
index 1fbe82bf72cb..18bd6807c538 100644
--- a/include/erofs.h
+++ b/include/erofs.h
@@ -10,6 +10,7 @@ int erofs_probe(struct blk_desc *fs_dev_desc,
 		struct disk_partition *fs_partition);
 int erofs_read(const char *filename, void *buf, loff_t offset,
 	       loff_t len, loff_t *actread);
+int erofs_get_blocksize(const char *filename);
 int erofs_size(const char *filename, loff_t *size);
 int erofs_exists(const char *filename);
 void erofs_close(void);
-- 
2.37.0

