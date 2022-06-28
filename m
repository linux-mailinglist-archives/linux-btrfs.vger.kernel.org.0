Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D7955D2D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242089AbiF1H24 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jun 2022 03:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241106AbiF1H2y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jun 2022 03:28:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07D0101E6
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jun 2022 00:28:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E388121DAF;
        Tue, 28 Jun 2022 07:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656401330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H0EESViXB4p6lRdwcLWm42whKpOvIzvsf3ZNDH1pzn4=;
        b=FmfWzh+uZfcH5nz4Asg2Lqu/R9F4TYHzlNx4vxpq2BsEqPTt3nJnb6BCg2RtLngGsZKErU
        QtKoEnO28ptyipTAGbO8KChG+qUV/SvJNYbSr1uLmmI8b8HVoW9AuUSOfJf8OzEbznJoal
        1VeETsJf+LgbzeIH6WwOrRp8kjOBpH4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F830139E9;
        Tue, 28 Jun 2022 07:28:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IDBQMq+tumJzFQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 28 Jun 2022 07:28:47 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     marek.behun@nic.cz, linux-btrfs@vger.kernel.org,
        jnhuang95@gmail.com, linux-erofs@lists.ozlabs.org,
        trini@konsulko.com, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH RFC 7/8] fs: ubifs: rely on higher layer to do unaligned read
Date:   Tue, 28 Jun 2022 15:28:07 +0800
Message-Id: <0540802c15d2faf26e7ac82e8d0b89f69ae98fa2.1656401086.git.wqu@suse.com>
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

Currently ubifs doesn't support unaligned read offset, thanks to the
recent _fs_read() work to handle unaligned read, we only need to
implement ubifs_get_blocksize() to take advantage of it.

Now ubifs can do unaligned read without any problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/fs.c               |  2 +-
 fs/ubifs/ubifs.c      | 13 ++++++++-----
 include/ubifs_uboot.h |  1 +
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/fs.c b/fs/fs.c
index 337d5711c28c..41943e3a95db 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -302,7 +302,7 @@ static struct fstype_info fstypes[] = {
 		.exists = ubifs_exists,
 		.size = ubifs_size,
 		.read = ubifs_read,
-		.get_blocksize = fs_get_blocksize_unsupported,
+		.get_blocksize = ubifs_get_blocksize,
 		.write = fs_write_unsupported,
 		.uuid = fs_uuid_unsupported,
 		.opendir = fs_opendir_unsupported,
diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
index d3026e310168..a8ab556dd376 100644
--- a/fs/ubifs/ubifs.c
+++ b/fs/ubifs/ubifs.c
@@ -846,11 +846,9 @@ int ubifs_read(const char *filename, void *buf, loff_t offset,
 
 	*actread = 0;
 
-	if (offset & (PAGE_SIZE - 1)) {
-		printf("ubifs: Error offset must be a multiple of %d\n",
-		       PAGE_SIZE);
-		return -1;
-	}
+	/* Higher layer should ensure it always pass page aligned range. */
+	assert(IS_ALIGNED(offset, PAGE_SIZE));
+	assert(IS_ALIGNED(size, PAGE_SIZE));
 
 	c->ubi = ubi_open_volume(c->vi.ubi_num, c->vi.vol_id, UBI_READONLY);
 	/* ubifs_findfile will resolve symlinks, so we know that we get
@@ -920,6 +918,11 @@ out:
 	return err;
 }
 
+int ubifs_get_blocksize(const char *filename)
+{
+	return PAGE_SIZE;
+}
+
 void ubifs_close(void)
 {
 }
diff --git a/include/ubifs_uboot.h b/include/ubifs_uboot.h
index b025779d59ff..bcd21715314a 100644
--- a/include/ubifs_uboot.h
+++ b/include/ubifs_uboot.h
@@ -29,6 +29,7 @@ int ubifs_exists(const char *filename);
 int ubifs_size(const char *filename, loff_t *size);
 int ubifs_read(const char *filename, void *buf, loff_t offset,
 	       loff_t size, loff_t *actread);
+int ubifs_get_blocksize(const char *filename);
 void ubifs_close(void);
 
 #endif /* __UBIFS_UBOOT_H__ */
-- 
2.36.1

