Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBCD7DE766
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Nov 2023 22:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344705AbjKAVZR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Nov 2023 17:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344928AbjKAVZQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Nov 2023 17:25:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368F1115
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Nov 2023 14:25:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CE9BA1F85D
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Nov 2023 21:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698873908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=cq6gaOD8A2KJZ0eM4yBiIKqhCBnXEtyWg8x+cL6mEaQ=;
        b=jbJPERQUOC2PbQ8lCiaCmfwzENu3vf2uHMyo94UPKU2I/7zvYTX3DFgZ6VrKbwlFLAD4NE
        tFiNSDpFTraiqK9/Lghac7gSvfmTDxQvKjmgJlQzdcvfZD5Blg1M7y0/CwZgSSPLp4IjjN
        XkYvpQ8quO8HIxIEW/NOuhtq6APJN8w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0906113460
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Nov 2023 21:25:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2NRcLjPCQmWGQAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Nov 2023 21:25:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add dmesg output when mounting and unmounting
Date:   Thu,  2 Nov 2023 07:54:50 +1030
Message-ID: <215e7eea95459d1b0cc4fd9ce522dc7c8f5d4e02.1698873846.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a feature request to add dmesg output when unmounting a btrfs.

There are several alternative methods to do the same thing, but with
their problems:

- Use eBPF to watch btrfs_put_super()/open_ctree()
  Not end user friendly, they have to dip their head into the source
  code.

- Watch for /sys/fs/<uuid>/
  This is way more simpler, but still requires some simple device -> uuid
  lookups.
  And a script needs to use inotify to watch /sys/fs/.

Compared to all these, directly outputting the information into dmesg
would be the most simple one, with both device and UUID included.

And since we're here, also add the output when mounting a btrfs, to keep
the dmesg paired.

Now mounting a btrfs with all default mkfs options would look like this:

[   81.906566] BTRFS info (device dm-8): mounting filesystem 633b5c16-afe3-4b79-b195-138fe145e4f2
[   81.907494] BTRFS info (device dm-8): using crc32c (crc32c-intel) checksum algorithm
[   81.908258] BTRFS info (device dm-8): using free space tree
[   81.912644] BTRFS info (device dm-8): auto enabling async discard
[   81.913277] BTRFS info (device dm-8): checking UUID tree
[   91.668256] BTRFS info (device dm-8): unmounting filesystem 633b5c16-afe3-4b79-b195-138fe145e4f2

Link: https://github.com/kdave/btrfs-progs/issues/689
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 1 +
 fs/btrfs/super.c   | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 350e1b02cc8e..2fef94bfa2ff 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3209,6 +3209,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_alloc;
 	}
 
+	btrfs_info(fs_info, "mounting filesystem %pU", disk_super->fsid);
 	/*
 	 * Verify the type first, if that or the checksum value are
 	 * corrupted, we'll find out
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6ecf78d09694..fbcd8c8d23dc 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -80,7 +80,11 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data);
 
 static void btrfs_put_super(struct super_block *sb)
 {
-	close_ctree(btrfs_sb(sb));
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+
+	btrfs_info(fs_info, "unmounting filesystem %pU",
+		   fs_info->fs_devices->fsid);
+	close_ctree(fs_info);
 }
 
 enum {
-- 
2.42.0

