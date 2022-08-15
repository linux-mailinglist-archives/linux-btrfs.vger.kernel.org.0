Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0308592E56
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Aug 2022 13:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiHOLpv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Aug 2022 07:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241432AbiHOLps (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Aug 2022 07:45:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F75B4BB
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Aug 2022 04:45:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B808D20866;
        Mon, 15 Aug 2022 11:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660563946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eTUxYj1OZDkY14aB7vIzWLz6w9dpyMmDNCfmBP+tQss=;
        b=vYKQQAcOZvfBzzTVRPp2uMoKJ2+Oq7ldkICJXN1nBPStK/RnQ+wBkKzfSCizuTbNj+xH8O
        a2jgwsZ2XGjjGZVrYQMKO6db8zDlTmBQ4IgZCQM0XtUHGZxEWKLMwRi5VIZGK5EAwTr403
        gPYHmnvtYWEicOiRynkrXXzk1dq/aC4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35DCE13A93;
        Mon, 15 Aug 2022 11:45:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uGLIOucx+mLsGAAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 15 Aug 2022 11:45:43 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     marek.behun@nic.cz, linux-btrfs@vger.kernel.org,
        jnhuang95@gmail.com, linux-erofs@lists.ozlabs.org,
        trini@konsulko.com, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v3 2/8] fs: btrfs: fix a bug which no data get read if the length is not 0
Date:   Mon, 15 Aug 2022 19:45:13 +0800
Message-Id: <bf56479cb718f70cc595caf5af081f0dbb49e9e7.1660563403.git.wqu@suse.com>
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

[BUG]
When testing with unaligned read, if a specific length is passed in,
btrfs driver will read out nothing:

 => load host 0 $kernel_addr_r 5k_file 0x1000 0
 0 bytes read in 0 ms

But if no length is passed in, it works fine, even if we pass a non-zero
length:

 => load host 0 $kernel_addr_r 5k_file 0 0x1000
 1024 bytes read in 0 ms

[CAUSE]
In btrfs_read() if we have a larger size than our file, we will try to
truncate it using the file size.

However the real file size is not initialized if @len is not zero, thus
we always truncate our length to 0, and cause the problem.

[FIX]
Fix it by just always do the file size check.

In fact btrfs_size() always follow soft link, thus it will return the
real file size correctly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 4cdbbbe3d066..309cd595d37d 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -246,16 +246,17 @@ int btrfs_read(const char *file, void *buf, loff_t offset, loff_t len,
 		return -EINVAL;
 	}
 
-	if (!len) {
-		ret = btrfs_size(file, &real_size);
-		if (ret < 0) {
-			error("Failed to get inode size: %s", file);
-			return ret;
-		}
-		len = real_size;
+	ret = btrfs_size(file, &real_size);
+	if (ret < 0) {
+		error("Failed to get inode size: %s", file);
+		return ret;
 	}
 
-	if (len > real_size - offset)
+	/*
+	 * If the length is 0 (meaning read the whole file) or the range is
+	 * beyond file size, truncate it to the end of the file.
+	 */
+	if (!len || len > real_size - offset)
 		len = real_size - offset;
 
 	ret = btrfs_file_read(root, ino, offset, len, buf);
-- 
2.37.1

