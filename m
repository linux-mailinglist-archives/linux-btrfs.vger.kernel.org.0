Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA9263F4EE
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Dec 2022 17:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbiLAQNC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Dec 2022 11:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiLAQM6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Dec 2022 11:12:58 -0500
X-Greylist: delayed 328 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Dec 2022 08:12:57 PST
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3138717E27;
        Thu,  1 Dec 2022 08:12:57 -0800 (PST)
From:   Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1669910847; bh=S4FmVyhpZDGh9t63RCzhVDZHxm+vJyfoMFACVQFXfxQ=;
        h=From:To:Cc:Subject:Date;
        b=J0DFTLQVfRZfQasxYBV/3GIcgN2i84jcVRzywC94UHKlcUPRTXD0yRdCpR5g1DueP
         7K+7WcvA9+0FXASQo41mf7hWLnz76jOlNuyCbTYMsqZsxQXj6YcJ36mHgGdA47/vGg
         HTYUeuLMwEtd4b4Ax8rqXFo3YlFG2z66/wwrBuFY=
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shepjeng@gmail.com, kernel@cccheng.net,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Johnny Chang <johnnyc@synology.com>
Subject: [PATCH] btrfs: refuse to remount read-write with unsupported compat-ro features
Date:   Fri,  2 Dec 2022 00:07:24 +0800
Message-Id: <20221201160724.2593341-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs with unsupported compat-ro features can only be mounted as
read-only, but we can make it read-write indirectly through remount.
Just add the missing check to refuse it.

  mount -o ro /dev/vdb /mnt
  mount -o remount,rw /mnt

Reported-by: Johnny Chang <johnnyc@synology.com>
Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 fs/btrfs/super.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 5942b9384088..45836a426499 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1991,6 +1991,8 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	unsigned old_flags = sb->s_flags;
 	unsigned long old_opts = fs_info->mount_opt;
 	unsigned long old_compress_type = fs_info->compress_type;
+	u64 compat_ro = btrfs_super_compat_ro_flags(fs_info->super_copy);
+	u64 compat_ro_unsupp = compat_ro & ~BTRFS_FEATURE_COMPAT_RO_SUPP;
 	u64 old_max_inline = fs_info->max_inline;
 	u32 old_thread_pool_size = fs_info->thread_pool_size;
 	u32 old_metadata_ratio = fs_info->metadata_ratio;
@@ -2107,6 +2109,13 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		if (ret)
 			goto restore;
 	} else {
+		if (compat_ro_unsupp) {
+			btrfs_err(fs_info,
+				"cannot remount read-write because of unknown compat_ro features (0x%llx)",
+				compat_ro);
+			ret = -EINVAL;
+			goto restore;
+		}
 		if (BTRFS_FS_ERROR(fs_info)) {
 			btrfs_err(fs_info,
 				"Remounting read-write after error is not allowed");
-- 
2.34.1

