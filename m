Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441675854B8
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jul 2022 19:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238080AbiG2Rsu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jul 2022 13:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbiG2Rsu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jul 2022 13:48:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFD58967F
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jul 2022 10:48:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5BEEF21CA5;
        Fri, 29 Jul 2022 17:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659116869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E0JpVcS6h02LH5PGP4MdT7IfRGajbIHA2kqjo6COCFg=;
        b=PHJQWNFgH8K8w4qxAsMe6IEDetTfPMV5/H1Aiw3uSpQoph2WmUPSd5HFPrNsNJVrK9PeJW
        ZBnVKEmkgIJTrYtTyBei4ngdI+oVkWKkX7FUI9aihJfVa/UU/dpOeUq+DYkdNvX3jml0cT
        U/mxh6Nx6BhDY2lwTfK6BcRjwOhEgOA=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 51E642C141;
        Fri, 29 Jul 2022 17:47:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 38BC8DA85A; Fri, 29 Jul 2022 19:42:51 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 4/4] btrfs: sysfs: print all loaded csums implementations
Date:   Fri, 29 Jul 2022 19:42:51 +0200
Message-Id: <e585b484d7bebeb2f500fb1951b370255bbe5c38.1659116355.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1659116355.git.dsterba@suse.com>
References: <cover.1659116355.git.dsterba@suse.com>
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

