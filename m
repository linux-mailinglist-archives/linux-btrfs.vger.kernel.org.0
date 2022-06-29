Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BA955FED3
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jun 2022 13:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiF2LjD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jun 2022 07:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbiF2LjA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jun 2022 07:39:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AC43EA89
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 04:38:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 402AF220C7;
        Wed, 29 Jun 2022 11:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656502737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZoBlzWZfVdqYKCb/B1++pokD0MnUEbdHZIspM4GSiHc=;
        b=n48vznRInu+9qjreEFq/gjsHNcPXkJR3Vi0OAldXQbSx6tFNomNb8n8vOJ5yHaMD4PQex0
        JE41nbR9fjhwtRYM61Jdn7ukSdP9hoNIAvWrSVe7U8koreSTXiONK9UsmO9IvYYVdcZ8EC
        H3C1T31wYSyuPaJkermqBJwzCxlbQPE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F29F7133D1;
        Wed, 29 Jun 2022 11:38:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cK4vL845vGLFPwAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 29 Jun 2022 11:38:54 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     marek.behun@nic.cz, linux-btrfs@vger.kernel.org,
        jnhuang95@gmail.com, linux-erofs@lists.ozlabs.org,
        trini@konsulko.com, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH 3/8] fs: btrfs: fix a crash if specified range is beyond file size
Date:   Wed, 29 Jun 2022 19:38:24 +0800
Message-Id: <94e08500aa3de95b3516be452b98c46e79fa6621.1656502685.git.wqu@suse.com>
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

[BUG]
When try to read a range beyond file size, btrfs driver will cause
crash/segfault:

 => load host 0 $kernel_addr_r 5k_file 0 0x2000
 SEGFAULT

[CAUSE]
In btrfs_read(), if @len is 0, we will truncated it to file end, but if
file end is beyond our file size, this truncation will underflow @len,
making it -3K in this case.

And later that @len is used to memzero the output buffer, resulting
above crash.

[FIX]
Just error out if @offset is already beyond our file size.

Now it will fail properly with correct error message:

 => load host 0 $kernel_addr_r 5m_origin 0 0x2000
 BTRFS: Read range beyond file size, offset 8192 file size 5120

 Failed to load '5m_origin'

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 9145727058d4..bf9e1f2f17cf 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -252,6 +252,12 @@ int btrfs_read(const char *file, void *buf, loff_t offset, loff_t len,
 		return ret;
 	}
 
+	if (offset >= real_size) {
+		error("Read range beyond file size, offset %llu file size %llu",
+			offset, real_size);
+		return -EINVAL;
+	}
+
 	/*
 	 * If the length is 0 (meaning read the whole file) or the range is
 	 * beyond file size, truncate it to the end of the file.
-- 
2.36.1

