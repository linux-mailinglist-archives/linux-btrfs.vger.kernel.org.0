Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F24592E60
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Aug 2022 13:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbiHOLqL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Aug 2022 07:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiHOLqL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Aug 2022 07:46:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1957EBC28
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Aug 2022 04:46:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C6C881FE69;
        Mon, 15 Aug 2022 11:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660563968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nmei75UQLrXMG2L7/xFI+FjzoA3oEelPp+lH7jJuaIs=;
        b=RXdEnIvMc1W7juWH+dQBLJza+h04qayfi59RzDYwBuc1a5htaxzLCM16rW9wTTDGBTy5Xw
        sBN6ZC2yhv78D0XJ7+Ms0CExP0xEmO+YpW5t26NVAF/PL433WXoJm0wYDEkVNXra6/DNZ8
        MlCDCCw9L4Fwjj2Vhj0kb6+frqvR4so=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 089D313A93;
        Mon, 15 Aug 2022 11:46:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sCGlLv0x+mLsGAAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 15 Aug 2022 11:46:05 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     marek.behun@nic.cz, linux-btrfs@vger.kernel.org,
        jnhuang95@gmail.com, linux-erofs@lists.ozlabs.org,
        trini@konsulko.com, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v3 8/8] fs: erofs: add unaligned read range handling
Date:   Mon, 15 Aug 2022 19:45:19 +0800
Message-Id: <a1ac116d3416d13161312a5a08c4d0e9f6218639.1660563403.git.wqu@suse.com>
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

I'm not an expert on erofs, but my quick glance didn't expose any
special handling on unaligned range, thus I think the U-boot erofs
driver doesn't really support unaligned read range.

This patch will add erofs_get_blocksize() so erofs can benefit from the
generic unaligned read support.

Cc: Huang Jianan <jnhuang95@gmail.com>
Cc: linux-erofs@lists.ozlabs.org
Signed-off-by: Qu Wenruo <wqu@suse.com>
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
index 8277d9b53fb3..82625da59001 100644
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
index 43c7128bcfc5..2ac43c05fcd8 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -376,7 +376,7 @@ static struct fstype_info fstypes[] = {
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
2.37.1

