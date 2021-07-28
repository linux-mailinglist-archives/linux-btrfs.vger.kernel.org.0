Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFF63D9327
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 18:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhG1QZA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 12:25:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55948 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhG1QY5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 12:24:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BEAE9222B2;
        Wed, 28 Jul 2021 16:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627489494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fBC5VJrFD574cdmgIowSRLiY11c9y2+3+/2kj5GkzZs=;
        b=J7qN3ff24FeUccm2i3ql9L8n5v9uaTj6y7XmZmteqvuQ32L9UsMyQ5TVsEArcG/+ETaIAS
        UIeegyuF2TqIkcl7PbSNF8A+MSzmCJ0XoWseTA+HqdA9FHI137B8G3F5LbRGoX2k1/IDtI
        IVlGo7yrziRHOg+O4zE2/4qMzGZ1uqE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B7753A3B84;
        Wed, 28 Jul 2021 16:24:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CF3A7DA8A7; Wed, 28 Jul 2021 18:22:09 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     boris@bur.io, David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: print if fsverity support is built in when loading module
Date:   Wed, 28 Jul 2021 18:22:09 +0200
Message-Id: <20210728162209.29019-1-dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As fsverity support depends on a config option, print that at module
load time like we do for similar features.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2bdc544b4c95..d444338db3c6 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2566,6 +2566,11 @@ static void __init btrfs_print_mod_info(void)
 			", zoned=yes"
 #else
 			", zoned=no"
+#endif
+#ifdef CONFIG_FS_VERITY
+			", fsverity=yes"
+#else
+			", fsverity=no"
 #endif
 			;
 	pr_info("Btrfs loaded, crc32c=%s%s\n", crc32c_impl(), options);
-- 
2.31.1

