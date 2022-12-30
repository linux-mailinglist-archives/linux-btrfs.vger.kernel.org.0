Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2240F6593F5
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Dec 2022 02:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiL3BHa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Dec 2022 20:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiL3BH1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Dec 2022 20:07:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E02E1705B
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Dec 2022 17:07:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E0BF021CA1;
        Fri, 30 Dec 2022 01:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672362443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZWS87d0M09bdjfcRME35rmJAiVRsRZ4p7321F0KqWV8=;
        b=nAWQm7fo0o1XoCjkr7h3JKA+SGB2gn3YlsGcSH9urYpXKHYXm2oQamHNo4EnxI5LN6cQL/
        F5pqBYSFcRM1tg65ZpZXmsKiucZyP4WS88Jg4qzka35DS9bXP+pI2D1XsYI+FkCWM1Iwv4
        COBlIZnRNqqxH1vHrabS245dNNiBjuU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE10E1344E;
        Fri, 30 Dec 2022 01:07:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 49IVL8o5rmOVHgAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 30 Dec 2022 01:07:22 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     linux-btrfs@vger.kernel.org,
        Sam Winchenbach <swichenbach@tethers.com>
Subject: [PATCH] fs/btrfs: handle data extents, which crosss stripe boundaries, correctly
Date:   Fri, 30 Dec 2022 09:07:05 +0800
Message-Id: <57ad584676de5b72ae422a22dc36922285405291.1672362424.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Since btrfs supports single device RAID0 at mkfs time after btrfs-progs
v5.14, if we create a single device raid0 btrfs, and created a file
crossing stripe boundary:

  # mkfs.btrfs -m dup -d raid0 test.img
  # mount test.img mnt
  # xfs_io -f -c "pwrite 0 128K" mnt/file
  # umount mnt

Since btrfs is using 64K as stripe length, above 128K data write is
definitely going to cross at least one stripe boundary.

Then u-boot would fail to read above 128K file:

 => host bind 0 /home/adam/test.img
 => ls host 0
 <   >     131072  Fri Dec 30 00:18:25 2022  file
 => load host 0 0 file
 BTRFS: An error occurred while reading file file
 Failed to load 'file'

[CAUSE]
Unlike tree blocks read, data extent reads doesn't consider cases in which
one data extent can cross stripe boundary.

In read_data_extent(), we just call btrfs_map_block() once and read the
first mapped range.

And if the first mapped range is smaller than the desired range, it
would return error.

But since even single device btrfs can utilize RAID0 profiles, the first
mapped range can only be at most 64K for RAID0 profiles, and cause false
error.

[FIX]
Just like read_whole_eb(), we should call btrfs_map_block() in a loop
until we read all data.

Since we're here, also add extra error messages for the following cases:

- btrfs_map_block() failure
  We already have the error message for it.

- Missing device
  This should not happen, as we only support single device for now.

- __btrfs_devread() failure

With this bug fixed, btrfs driver of u-boot can properly read the above
128K file, and have the correct content:

 => host bind 0 /home/adam/test.img
 => ls host 0
 <   >     131072  Fri Dec 30 00:18:25 2022  file
 => load host 0 0 file
 131072 bytes read in 0 ms
 => md5sum 0 0x20000
 md5 for 00000000 ... 0001ffff ==> d48858312a922db7eb86377f638dbc9f
 ^^^ Above md5sum also matches.

Reported-by: Sam Winchenbach <swichenbach@tethers.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 49 +++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3f0d9f1c113b..7eaa7e949604 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -541,34 +541,39 @@ struct extent_buffer* read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 int read_extent_data(struct btrfs_fs_info *fs_info, char *data, u64 logical,
 		     u64 *len, int mirror)
 {
-	u64 offset = 0;
+	u64 orig_len = *len;
+	u64 cur = logical;
 	struct btrfs_multi_bio *multi = NULL;
 	struct btrfs_device *device;
 	int ret = 0;
-	u64 max_len = *len;
 
-	ret = btrfs_map_block(fs_info, READ, logical, len, &multi, mirror,
-			      NULL);
-	if (ret) {
-		fprintf(stderr, "Couldn't map the block %llu\n",
-				logical + offset);
-		goto err;
-	}
-	device = multi->stripes[0].dev;
+	while (cur < logical + orig_len) {
+		u64 cur_len = logical + orig_len - cur;
 
-	if (*len > max_len)
-		*len = max_len;
-	if (!device->desc || !device->part) {
-		ret = -EIO;
-		goto err;
-	}
-
-	ret = __btrfs_devread(device->desc, device->part, data, *len,
-			      multi->stripes[0].physical);
-	if (ret != *len)
-		ret = -EIO;
-	else
+		ret = btrfs_map_block(fs_info, READ, cur, &cur_len, &multi,
+				      mirror, NULL);
+		if (ret) {
+			error("Couldn't map the block %llu", cur);
+			goto err;
+		}
+		device = multi->stripes[0].dev;
+		if (!device->desc || !device->part) {
+			error("devid %llu is missing", device->devid);
+			ret = -EIO;
+			goto err;
+		}
+		ret = __btrfs_devread(device->desc, device->part,
+				data + (cur - logical), cur_len,
+				multi->stripes[0].physical);
+		if (ret != cur_len) {
+			error("read failed on devid %llu physical %llu",
+			      device->devid, multi->stripes[0].physical);
+			ret = -EIO;
+			goto err;
+		}
+		cur += cur_len;
 		ret = 0;
+	}
 err:
 	kfree(multi);
 	return ret;
-- 
2.39.0

