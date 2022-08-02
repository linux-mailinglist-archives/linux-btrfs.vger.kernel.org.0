Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7D1587C7C
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 14:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbiHBMdb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 08:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbiHBMda (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 08:33:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B0D37F8E
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 05:33:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C75AD37150;
        Tue,  2 Aug 2022 12:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659443608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E0JpVcS6h02LH5PGP4MdT7IfRGajbIHA2kqjo6COCFg=;
        b=UcHSbuafrrhWoV5lOfG1NZ1quJORrCrkEN8k25KcGB81XAkwnlNltnL5Ou3OB15w05lE/B
        6V0Tf0t+ThzvwsO8Pw5m+JCpyAmmdAbcW81LsrkSwxdRtiYNzGxP0bZSB0QZFsP9ebR5AQ
        mqJetfZCLqxD7avui3/9FwWFaFJAvtc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BEEC82C141;
        Tue,  2 Aug 2022 12:33:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 74AD6DA85A; Tue,  2 Aug 2022 14:28:28 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 4/4] btrfs: sysfs: print all loaded csums implementations
Date:   Tue,  2 Aug 2022 14:28:28 +0200
Message-Id: <0aab25d0dc9853d035d0ae76810447aac2f3ecf8.1659443199.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1659443199.git.dsterba@suse.com>
References: <cover.1659443199.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 0044644056ed..2f8bd75ce69d 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1095,9 +1095,18 @@ static ssize_t btrfs_checksum_show(struct kobject *kobj,
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

