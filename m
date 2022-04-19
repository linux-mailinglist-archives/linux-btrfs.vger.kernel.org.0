Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116C35069B5
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 13:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbiDSLVy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 07:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351120AbiDSLVL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 07:21:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB3A326F4
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 04:18:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4E52421118;
        Tue, 19 Apr 2022 11:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650367087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DpC5GeT5WmkjF0gDSoQalZ1qbUcoer97nLAmQXStwvk=;
        b=qqFGWzOUkSFynFcjg5FAKkQzfPX+q7TP9noaW0Jm0q9fFySwjtnW+mml34CobnPMEWk62N
        pgieP7CEZTcXeUg12O5sc6eq01qCDt9xLlBFUC7B5GCVAxWdHGcbTq63c6ItLnMpHV2s57
        E828GaJUfJlVQcL8a57Qws4eAT2w9jQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54BE9139BE;
        Tue, 19 Apr 2022 11:18:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aFiFBW2aXmJLRwAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 19 Apr 2022 11:18:05 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 2/2] btrfs-progs: fix an error path which can lead to empty device list
Date:   Tue, 19 Apr 2022 19:17:42 +0800
Message-Id: <090fd4a12800fe3f7a9c2b62630eeed738512a4f.1650366929.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1650366929.git.wqu@suse.com>
References: <cover.1650366929.git.wqu@suse.com>
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
With the incoming delayed chunk item insertion feature, there is a super
weird failure at mkfs/022:

  ====== RUN CHECK ./mkfs.btrfs -f --rootdir tmp.KnKpP5 -d dup -b 350M tests/test.img
  ...
  Checksum:           crc32c
  Number of devices:  0
  Devices:
     ID        SIZE  PATH

Note the "Number of devices: 0" line, this means our
fs_info->fs_devices->devices list is empty.

And since our rw device list is empty, we won't finish the mkfs with
proper superblock magic, and cause later btrfs check to fail.

[CAUSE]
Although the failure is only triggered by the incoming delayed chunk
item insertion feature, the bug itself is here for a while.

In btrfs_alloc_chunk(), we move rw devices to our @private_devs list
first, then in create_chunk(), we move it back to our rw devices list.

This dance is pretty dangerous, epsecially if btrfs_alloc_dev_extent()
failed inside create_chunk(), and current profile have multiple stripes
(including DUP), we will exit create_chunk() directly, without moving the
remaining devices in @private_devs list back to @dev_list.

Furthermore, btrfs_alloc_chunk() is expected to return -ENOSPC, as we
call btrfs_alloc_chunk() to pre-allocate chunks, and ignore the -ENOSPC
error if it's just a pre-allocation failure.

This existing error path can lead to the empty rw list seen above.

[FIX]
After create_chunk(), unconditionally move all devices in @private_devs
back to rw device list.

And add extra check to make sure our rw device list is never empty after
a chunk allocation attempt.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/volumes.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index c7456394285a..97c09a1a4931 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -1559,6 +1559,21 @@ again:
 	}
 
 	ret = create_chunk(trans, info, &ctl, &private_devs);
+
+	/*
+	 * This can happen if above create_chunk() failed, we need to move all
+	 * devices back to dev_list.
+	 */
+	while (!list_empty(&private_devs)) {
+		device = list_entry(private_devs.next, struct btrfs_device,
+				    dev_list);
+		list_move(&device->dev_list, dev_list);
+	}
+	/*
+	 * All private devs moved back to @dev_list, now dev_list should not be
+	 * empty.
+	 */
+	ASSERT(!list_empty(dev_list));
 	*start = ctl.start;
 	*num_bytes = ctl.num_bytes;
 
-- 
2.35.1

