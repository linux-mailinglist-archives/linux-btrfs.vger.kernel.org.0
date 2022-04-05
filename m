Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BF24F45E6
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 00:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiDEPD6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 11:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392005AbiDENt3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 09:49:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D882BA198
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 05:48:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 510D221110
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 12:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649162931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8TpcigrgfrlUSp+RfphJdAoz3ogvmEYZqc4PS+4JjJ4=;
        b=FK1PaLOYykRKVC2nCIEJseXYJ/ZrO4vj3iV7xpEGlDXcnjVi5vt7F9WBs+x1nsyo96hCIB
        A/C+0VkWbiaDm2Me/TbX5k3ZCOoKnqKdr9tJ1bl3lmAm9C2ht7D/4O4CbsP8F3tTLUywIe
        qXJ5IM9+hk9D0F6WjVwaqWA0pAuP+O8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A30BC13A04
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 12:48:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +MTrGrI6TGJLGgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 12:48:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/8] btrfs-progs: extract metadata restore read code into its own helper
Date:   Tue,  5 Apr 2022 20:48:24 +0800
Message-Id: <ccb15024f673d984578e25e1537b840bf50a58b3.1649162174.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649162174.git.wqu@suse.com>
References: <cover.1649162174.git.wqu@suse.com>
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

For metadata restore, our logical address is mapped to a single device
with logical address 1:1 mapped to device physical address.

Move this part of code into a helper, this will make later extent buffer
read path refactoer much easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/disk-io.c | 69 +++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index f2492547f77d..e6f5d554f13a 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -288,6 +288,30 @@ out:
 
 }
 
+static int read_on_restore(struct extent_buffer *eb)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct btrfs_device *device;
+	int ret;
+
+	/*
+	 * For on_restoring mode, there should be only one device, and logical
+	 * address is mapped 1:1 to device physical offset.
+	 */
+	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
+		if (device->devid == 1)
+			break;
+	}
+	device->total_ios++;
+
+	ret = btrfs_pread(device->fd, eb->data, eb->len, eb->start,
+			  eb->fs_info->zoned);
+	if (ret != eb->len)
+		ret = -EIO;
+	else
+		ret = 0;
+	return ret;
+}
 
 int read_whole_eb(struct btrfs_fs_info *info, struct extent_buffer *eb, int mirror)
 {
@@ -302,38 +326,29 @@ int read_whole_eb(struct btrfs_fs_info *info, struct extent_buffer *eb, int mirr
 		read_len = bytes_left;
 		device = NULL;
 
-		if (!info->on_restoring) {
-			ret = btrfs_map_block(info, READ, eb->start + offset,
-					      &read_len, &multi, mirror, NULL);
-			if (ret) {
-				printk("Couldn't map the block %llu\n", eb->start + offset);
-				kfree(multi);
-				return -EIO;
-			}
-			device = multi->stripes[0].dev;
-
-			if (device->fd <= 0) {
-				kfree(multi);
-				return -EIO;
-			}
+		if (info->on_restoring)
+			return read_on_restore(eb);
 
-			eb->fd = device->fd;
-			device->total_ios++;
-			eb->dev_bytenr = multi->stripes[0].physical;
+		ret = btrfs_map_block(info, READ, eb->start + offset,
+				      &read_len, &multi, mirror, NULL);
+		if (ret) {
+			printk("Couldn't map the block %llu\n", eb->start + offset);
 			kfree(multi);
-			multi = NULL;
-		} else {
-			/* special case for restore metadump */
-			list_for_each_entry(device, &info->fs_devices->devices, dev_list) {
-				if (device->devid == 1)
-					break;
-			}
+			return -EIO;
+		}
+		device = multi->stripes[0].dev;
 
-			eb->fd = device->fd;
-			eb->dev_bytenr = eb->start;
-			device->total_ios++;
+		if (device->fd <= 0) {
+			kfree(multi);
+			return -EIO;
 		}
 
+		eb->fd = device->fd;
+		device->total_ios++;
+		eb->dev_bytenr = multi->stripes[0].physical;
+		kfree(multi);
+		multi = NULL;
+
 		if (read_len > bytes_left)
 			read_len = bytes_left;
 
-- 
2.35.1

