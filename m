Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB1158520A
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jul 2022 17:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbiG2PER (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jul 2022 11:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbiG2PEP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jul 2022 11:04:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA73A17594
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jul 2022 08:04:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4C1763446F;
        Fri, 29 Jul 2022 15:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659107053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qct9lZFW3dBU72pMfD5lDIksolL5Y2oxZOEasnIgvqg=;
        b=M6RJmakCyiO6fzLMQwQRUjwXxpGMGyd4QSL5Lo3FJIRav4Q6tAup0vOs5SXOcnkwEYxdOL
        axSKwn9gHQ9LUzGDBk3Du3Kkk861cY9DuqpLrx+B4rTwwiuMQPAJvx8ichCs0BeNyqHgg4
        KVPN9oqhbEGNL4Hu3HFXVXRUopGcO+o=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 437152C142;
        Fri, 29 Jul 2022 15:04:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 46F83DA85A; Fri, 29 Jul 2022 16:59:15 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/4] btrfs: sysfs: print all loaded csums implementations
Date:   Fri, 29 Jul 2022 16:59:15 +0200
Message-Id: <db927df81a8a70bf739c62eb8f4757f5e58c2867.1659106597.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1659106597.git.dsterba@suse.com>
References: <cover.1659106597.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Extend the sysfs FSID/checksum file and append lines with the selector
strings and implementation if loaded, or 'none'.

Output may look like:

  crc32c (crc32c-generic)
  generic: crc32c-generic
  accel:   crc32c-intel

Scripts that rely on single line in the file need to be updated.

All available and loaded implementations can be found in /proc/crypto .

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/sysfs.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 0909f1da425c..9ce353184c46 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -937,9 +937,18 @@ static ssize_t btrfs_checksum_show(struct kobject *kobj,
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 	u16 csum_type = btrfs_super_csum_type(fs_info->super_copy);
 
-	return sysfs_emit(buf, "%s (%s)\n",
-			  btrfs_super_csum_name(csum_type),
-			  crypto_shash_driver_name(fs_info->csum_shash[CSUM_DEFAULT]));
+	return sysfs_emit(buf,
+			"%s (%s)\n"
+			"generic: %s\n"
+			"accel:   %s\n",
+			btrfs_super_csum_name(csum_type),
+			crypto_shash_driver_name(fs_info->csum_shash[CSUM_DEFAULT]),
+			fs_info->csum_shash[CSUM_GENERIC]
+			? crypto_shash_driver_name(fs_info->csum_shash[CSUM_GENERIC])
+			: "none",
+			fs_info->csum_shash[CSUM_ACCEL]
+			? crypto_shash_driver_name(fs_info->csum_shash[CSUM_ACCEL])
+			: "none");
 }
 
 static const char csum_impl[][8] = {
-- 
2.36.1

