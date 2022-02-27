Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECDE4C5FF1
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 00:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiB0Xwc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Feb 2022 18:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiB0Xwc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Feb 2022 18:52:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A4A49FB9
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 15:51:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 61D511F892;
        Sun, 27 Feb 2022 23:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646005913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+gucloSnbB9fysLAIstUBeEXRnCbE0SbyF8eGIFVIJc=;
        b=HiH6UWLwBEky5rj5LTfiknZPSQ5uMa2HxZ2HQa9M0ZqPBkTpUYU5xj2AWxNND0HZBq1GSa
        42pAbpi0qvVm5vaV+yfzpF5bvueY8nV6ECN8Sz81Bn/oykMzODCHdSKnuHjw9+Cue4Zdt2
        CHV9K1ceWdxEzPUZvikBk+To+9mwnNs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E65013480;
        Sun, 27 Feb 2022 23:51:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2NIGDZgOHGLlKwAAMHmgww
        (envelope-from <wqu@suse.com>); Sun, 27 Feb 2022 23:51:52 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?q?Luca=20B=C3=A9la=20Palkovics?= 
        <luca.bela.palkovics@gmail.com>
Subject: [PATCH] btrfs: repair super block num_devices automatically
Date:   Mon, 28 Feb 2022 07:51:34 +0800
Message-Id: <ad2279d1be9457b5b0a7dc883f7733666abb1ef8.1646005849.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
There is a report that a btrfs has a bad super block num devices.

This makes btrfs to reject the fs completely.

[CAUSE]
It's pretty straightforward, if super_num_devices doesn't match the
deviecs we found in chunk tree, there must be some wrong with the fs
thus we can reject the fs.

But on the other hand, super_num_devices is not determinant counter,
especially when we already have a correct counter after iterating the
chunk tree.

[FIX]
Make the super_num_devices check less strict, converting it from a hard
error to a warning, and reset the value to a correct one for the current
or next transaction commitment.

Reported-by: Luca Béla Palkovics <luca.bela.palkovics@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=zqDq_cWCOH5TiV46CKmp3igr44okQ@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 74c8024d8f96..d0ba3ff21920 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7682,12 +7682,12 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	 * do another round of validation checks.
 	 */
 	if (total_dev != fs_info->fs_devices->total_devices) {
-		btrfs_err(fs_info,
-	   "super_num_devices %llu mismatch with num_devices %llu found here",
+		btrfs_warn(fs_info,
+	   "super_num_devices %llu mismatch with num_devices %llu found here, will be repaired on next transaction commitment",
 			  btrfs_super_num_devices(fs_info->super_copy),
 			  total_dev);
-		ret = -EINVAL;
-		goto error;
+		fs_info->fs_devices->total_devices = total_dev;
+		btrfs_set_super_num_devices(fs_info->super_copy, total_dev);
 	}
 	if (btrfs_super_total_bytes(fs_info->super_copy) <
 	    fs_info->fs_devices->total_rw_bytes) {
-- 
2.35.1

