Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759DC76466F
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 08:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjG0GIU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 02:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjG0GIT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 02:08:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8371710F9
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 23:08:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 44BCC1F37C
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 06:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690438094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M7XXqtbf2QPqS9A2kSxYdkDd1PSjVyBfqLXIXsF7C1Q=;
        b=Z0g56Zgpu3/SRKmON+Xq6wgzKa0rE9lnDXSxZnXHviSxSdMxmoU9X9Vf66NRAkcsCZ0Efk
        RIWfkNQFWM7z1BO+1rYT+1aHZx36+NetOvAp9+fkYzL8fvKq9ZYjdSSUrgjGYujV8FG8bq
        sBLrcSjCueBiUKCRYurzyHxdZYNzws8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 800F513902
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 06:08:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IHKUEM0JwmQdDwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 06:08:13 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: do not commit transaction after adding one device
Date:   Thu, 27 Jul 2023 14:07:53 +0800
Message-ID: <878afba7683a3d7cfcc55850499ab4134449000d.1690437675.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690437675.git.wqu@suse.com>
References: <cover.1690437675.git.wqu@suse.com>
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
There is at least one report that btrfs falls to deadly ENOSPC
situation, where without adding new space btrfs would fail to commit any
transaction due to ENOSPC.

However this last resort device adding would not work if the filesystem
is using multi-device metadata profiles (RAID1*, RAID0, RAID5/6), as
after each device added, btrfs would commit the transaction, falling
back to read-only due to ENOSPC.

[CAUSE]
Of course we should not fail a transaction due to ENOSPC in the first
place, as this means at metadata reservation stage we did wrong
calculation.

But the current behavior of device add is also a little too strict,
considering device adding is the last-resort for ENOSPC, we should at
least allow end users to determine if they want to commit transaction or
not.

[FIX]
Instead of committing transaction, just end the current one.

Whether the fs would be synced would be determined at user space
(normally by btrfs-progs) instead.

Link: https://lore.kernel.org/linux-btrfs/CA+W5K0r4Lv4fPf+mWWf-ppgsjyz+wOKdBRgBR6UnQafwL7HPtg@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 70d69d4b44d2..eda90d1c881f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2789,7 +2789,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		btrfs_sysfs_update_sprout_fsid(fs_devices);
 	}
 
-	ret = btrfs_commit_transaction(trans);
+	ret = btrfs_end_transaction(trans);
+	trans = NULL;
 
 	if (seeding_dev) {
 		mutex_unlock(&uuid_mutex);
@@ -2803,15 +2804,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		if (ret < 0)
 			btrfs_handle_fs_error(fs_info, ret,
 				    "Failed to relocate sys chunks after device initialization. This can be fixed using the \"btrfs balance\" command.");
-		trans = btrfs_attach_transaction(root);
-		if (IS_ERR(trans)) {
-			if (PTR_ERR(trans) == -ENOENT)
-				return 0;
-			ret = PTR_ERR(trans);
-			trans = NULL;
-			goto error_sysfs;
-		}
-		ret = btrfs_commit_transaction(trans);
 	}
 
 	/*
-- 
2.41.0

