Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F3D55DE71
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242030AbiF1H2n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jun 2022 03:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiF1H2h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jun 2022 03:28:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A370E008
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jun 2022 00:28:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1879D1FB3C;
        Tue, 28 Jun 2022 07:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656401315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EJDsnfm5CD6flKl27ug0ll/8C9SQYioiQTVCJ40ytaU=;
        b=SsQf2kEYU+3fPNOKwoJhXiwLGpRCNYE4ENLyZkim9hOpoGr6tTbW7QdNZ5/sPgiG8Ma97X
        /b+QlRy95AGsIJQBbQakogsV7eVkmvAw8E1bwuh9jtVCTv2clu3VpbNGlM6Ar8L/EBjhOE
        rFClffev3+tFVj8j9w3QS7LDF9X7n6c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DB70139E9;
        Tue, 28 Jun 2022 07:28:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MCnEGaCtumJzFQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 28 Jun 2022 07:28:32 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     marek.behun@nic.cz, linux-btrfs@vger.kernel.org,
        jnhuang95@gmail.com, linux-erofs@lists.ozlabs.org,
        trini@konsulko.com, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH RFC 2/8] fs: always get the file size in _fs_read()
Date:   Tue, 28 Jun 2022 15:28:02 +0800
Message-Id: <cd417bc9dc4b44c4ac8d98f146e47c98cf4aac5a.1656401086.git.wqu@suse.com>
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

For _fs_read(), @len == 0 means we read the whole file.
And we just pass @len == 0 to make each filesystem to handle it.

In fact we have info->size() call to properly get the filesize.

So we can not only call info->size() to grab the file_size for len == 0
case, but also detect invalid @len (e.g. @len > file_size) in advance or
truncate @len.

This behavior also allows us to handle unaligned better in the incoming
patches.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/fs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/fs.c b/fs/fs.c
index 6de1a3eb6d5d..d992cdd6d650 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -579,6 +579,7 @@ static int _fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
 {
 	struct fstype_info *info = fs_get_info(fs_type);
 	void *buf;
+	loff_t file_size;
 	int ret;
 
 #ifdef CONFIG_LMB
@@ -589,10 +590,26 @@ static int _fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
 	}
 #endif
 
-	/*
-	 * We don't actually know how many bytes are being read, since len==0
-	 * means read the whole file.
-	 */
+	ret = info->size(filename, &file_size);
+	if (ret < 0) {
+		log_err("** Unable to get file size for %s, %d **\n",
+				filename, ret);
+		return ret;
+	}
+	if (offset >= file_size) {
+		log_err(
+		"** Invalid offset, offset (%llu) >= file size (%llu)\n",
+			offset, file_size);
+		return -EINVAL;
+
+	}
+	if (len == 0 || offset + len > file_size) {
+		if (len > file_size)
+			log_info(
+	"** Truncate read length from %llu to %llu, as file size is %llu **\n",
+				 len, file_size, file_size);
+		len = file_size - offset;
+	}
 	buf = map_sysmem(addr, len);
 	ret = info->read(filename, buf, offset, len, actread);
 	unmap_sysmem(buf);
-- 
2.36.1

