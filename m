Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86ABB5046F1
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Apr 2022 09:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiDQHdd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Apr 2022 03:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbiDQHdd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Apr 2022 03:33:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764111A042
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Apr 2022 00:30:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1BA5D2161C
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Apr 2022 07:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650180657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fFtnlQC1STPAtgOn/fQCwBEpjCYtfrfFeIBQQdNHWxY=;
        b=HoV2nPnCQBa8XiRS56EpN1seo1N6nsYGBfQdFtmdZUacv191GKL9DpPUDNEpUebWBMf6mz
        wk2FiPtJm9PrHk0jknzCOxhwsMhTuYRyjFs8KrFwisFCfslk+huvOEljSsZc4w1FeWj21M
        7qgV8Uh5gySjZDzNl5rnTYpBGOoUAkI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B2F413ACB
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Apr 2022 07:30:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YOJ4CDDCW2JvVAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Apr 2022 07:30:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: check: fix wrong total bytes check for seed device
Date:   Sun, 17 Apr 2022 15:30:35 +0800
Message-Id: <8ed9c80d960090f44b11c4420b5bfbe04170c4a4.1650180472.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1650180472.git.wqu@suse.com>
References: <cover.1650180472.git.wqu@suse.com>
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
The following script can lead to false positive from btrfs check:

  mkfs.btrfs -f $dev1
  mount $dev1 $mnt
  btrfstune -S1 $dev1
  mount $dev1 $mnt
  btrfs dev add -f $dev2 $mnt
  umount $mnt

  # Now dev1 is seed, and dev2 is the rw fs.
  btrfs check $dev2
  ...
  [2/7] checking extents
  WARNING: minor unaligned/mismatch device size detected
  WARNING: recommended to use 'btrfs rescue fix-device-size' to fix it
  ...

This false positive only happens on $dev2, $dev1 is completely fine.

[CAUSE]
The warning is from is_super_size_valid(), in that function we verify
the super block total bytes (@super_bytes) is correct against the total
device bytes (@total_bytes).

However the when calculating @total_bytes, we only use devices in
current fs_devices, which only contains RW devices.

Thus all bytes from seed device are not taken into consideration, and
trigger the false positive.

[FIX]
Fix it by also iterating seed devices.

Since we're here, also output @total_bytes and @super_bytes when
outputting the warning message, to allow end users have a better idea on
what's going wrong.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/check/main.c b/check/main.c
index e6e85784d5ea..64fc6f2ebdb7 100644
--- a/check/main.c
+++ b/check/main.c
@@ -8550,13 +8550,17 @@ static int check_device_used(struct device_record *dev_rec,
  */
 static bool is_super_size_valid(void)
 {
-	struct btrfs_device *dev;
-	struct list_head *dev_list = &gfs_info->fs_devices->devices;
+	struct btrfs_fs_devices *fs_devices = gfs_info->fs_devices;
+	const u64 super_bytes = btrfs_super_total_bytes(gfs_info->super_copy);
 	u64 total_bytes = 0;
-	u64 super_bytes = btrfs_super_total_bytes(gfs_info->super_copy);
 
-	list_for_each_entry(dev, dev_list, dev_list)
-		total_bytes += dev->total_bytes;
+	while (fs_devices) {
+		struct btrfs_device *dev;
+
+		list_for_each_entry(dev, &fs_devices->devices, dev_list)
+			total_bytes += dev->total_bytes;
+		fs_devices = fs_devices->seed;
+	}
 
 	/* Important check, which can cause unmountable fs */
 	if (super_bytes < total_bytes) {
@@ -8579,7 +8583,9 @@ static bool is_super_size_valid(void)
 	if (!IS_ALIGNED(super_bytes, gfs_info->sectorsize) ||
 	    !IS_ALIGNED(total_bytes, gfs_info->sectorsize) ||
 	    super_bytes != total_bytes) {
-		warning("minor unaligned/mismatch device size detected");
+		warning("minor unaligned/mismatch device size detected:");
+		warning("  super block total bytes=%llu found total bytes=%llu",
+			super_bytes, total_bytes);
 		warning(
 		"recommended to use 'btrfs rescue fix-device-size' to fix it");
 	}
-- 
2.35.1

