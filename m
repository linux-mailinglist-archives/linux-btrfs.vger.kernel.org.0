Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723214C639B
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 08:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiB1HGz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 02:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiB1HGx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 02:06:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DB5674C9
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 23:06:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C7AB7212BB;
        Mon, 28 Feb 2022 07:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646031971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=A+QGORgyg5Tts6vAEIEKNJLMcWNuMc4BLV1O7nIQ43Q=;
        b=V6jJYiOtzXnpAOr1OLJY7KYJ/AySsBFqQwQBNq0d5sD4j57Gnppg9AWFpNRmdAnIsq1r/6
        T4V3rXXQI5sykwKS8F5pgGwIFUC/RoRO7fJxh+yRXi6kSWygjZqxHmV8M6EBk5faR4As2e
        CbTOMxhLOexeezJnUl69syFHzX6TFAw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C38E4139BD;
        Mon, 28 Feb 2022 07:06:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cPywIGJ0HGLzGwAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 28 Feb 2022 07:06:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?q?Luca=20B=C3=A9la=20Palkovics?= 
        <luca.bela.palkovics@gmail.com>
Subject: [PATCH v2] btrfs: repair super block num_devices automatically
Date:   Mon, 28 Feb 2022 15:05:53 +0800
Message-Id: <732d0a86c3624bc96df3cca05512edac40efc75d.1646031785.git.wqu@suse.com>
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

  BTRFS error (device sdd3): super_num_devices 3 mismatch with num_devices 2 found here
  BTRFS error (device sdd3): failed to read chunk tree: -22
  BTRFS error (device sdd3): open_ctree failed

[CAUSE]
During btrfs device removal, chunk tree and super block num devs are
updated in two different transactions:

  btrfs_rm_device()
  |- btrfs_rm_dev_item(device)
  |  |- trans = btrfs_start_transaction()
  |  |  Now we got transaction X
  |  |
  |  |- btrfs_del_item()
  |  |  Now device item is removed from chunk tree
  |  |
  |  |- btrfs_commit_transaction()
  |     Transaction X got committed, super num devs untouched,
  |     but device item removed from chunk tree.
  |     (AKA, super num devs is already incorrect)
  |
  |- cur_devices->num_devices--;
  |- cur_devices->total_devices--;
  |- btrfs_set_super_num_devices()
     All those operations are not in transaction X, thus it will
     only be written back to disk in next transaction.

So after the transaction X in btrfs_rm_dev_item() committed, but before
transaction X+1 (which can be minutes away), a power loss happen, then
we got the super num mismatch.

[FIX]
Make the super_num_devices check less strict, converting it from a hard
error to a warning, and reset the value to a correct one for the current
or next transaction commitment.

Reported-by: Luca Béla Palkovics <luca.bela.palkovics@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=zqDq_cWCOH5TiV46CKmp3igr44okQ@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Add a proper reason on why this mismatch can happen
  No code change.
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

