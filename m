Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12AE395812
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 11:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhEaJ1q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 05:27:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40366 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhEaJ1o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 05:27:44 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F269B2191B;
        Mon, 31 May 2021 09:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622453163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=PyZW+99/fXkXmQD1Q4wvqQgN4URrY8lOM9wCmfz7Yho=;
        b=TqDUoQfRVQ1gb73Rz4SGbaUDQG/o60yyg2VcJgM/4BrpmZqy9o7N023tvJZIgCV3NB3sLb
        oYadKsdYiz69rmYG67+YgbmD8FGADCWTQOQlBmZx3qU0NWQ8WoQFkhwJikFF14O9QDMJPb
        kTx32dRMLlFfqvx+JOnZDvTYn26XKwM=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id B307E118DD;
        Mon, 31 May 2021 09:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622453162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=PyZW+99/fXkXmQD1Q4wvqQgN4URrY8lOM9wCmfz7Yho=;
        b=SwGWEKiIfAIbMG1SVp8ne8t5ioIsYioYzpZSusRecqIKVNdSsr462RE/RfxbjwsdURUx7S
        e6JNZLIMmJajV4XE98ydkNfe84XEnqE6Z7eqvab5c/u5YpYYK6TmFqyHSR1tQf9NlowCoQ
        q+EEN4gP6uvVKFN/9bxHGn44thHRd1I=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id v8NuKaqrtGBBVwAALh3uQQ
        (envelope-from <nborisov@suse.com>); Mon, 31 May 2021 09:26:02 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>,
        syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: Promote debugging asserts to full-flegded checks in validate_super
Date:   Mon, 31 May 2021 12:26:01 +0300
Message-Id: <20210531092601.107452-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: imap.suse.de;
        none
X-Spam-Level: *****
X-Spam-Score: 5.00
X-Spamd-Result: default: False [5.00 / 100.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[a6bf271c02e4fe66b4e4];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_MISSING_CHARSET(2.50)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2]
X-Spam-Flag: NO
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Syzbot managed to trigger this assert while performing its fuzzing.
Turns out it's better to have those asserts turned into full-fledged
checks so that in case buggy btrfs images are mounted the users gets
an error and mounting is stopped. Alternatively with CONFIG_BTRFS_ASSERT
disabled such image would have been erroneously allowed to be mounted.

Reported-by: syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 99757939f8b0..cff694fe87d3 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2648,6 +2648,19 @@ static int validate_super(struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 
+	if (memcmp(fs_info->fs_devices->fsid, fs_info->super_copy->fsid,
+		       BTRFS_FSID_SIZE)) {
+		btrfs_err(fs_info, "superblock fsid doesn't match fsid of fs_devices");
+		ret = -EINVAL;
+	}
+
+	if (btrfs_fs_incompat(fs_info, METADATA_UUID) &&
+	    memcmp(fs_info->fs_devices->metadata_uuid,
+		   fs_info->super_copy->metadata_uuid,	BTRFS_FSID_SIZE)) {
+		btrfs_err(fs_info, "superblock's metadata uuid doesn't match metadata uuid of fsdevices");
+		ret = -EINVAL;
+	}
+
 	if (memcmp(fs_info->fs_devices->metadata_uuid, sb->dev_item.fsid,
 		   BTRFS_FSID_SIZE) != 0) {
 		btrfs_err(fs_info,
@@ -3279,14 +3292,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	disk_super = fs_info->super_copy;
 
-	ASSERT(!memcmp(fs_info->fs_devices->fsid, fs_info->super_copy->fsid,
-		       BTRFS_FSID_SIZE));
-
-	if (btrfs_fs_incompat(fs_info, METADATA_UUID)) {
-		ASSERT(!memcmp(fs_info->fs_devices->metadata_uuid,
-				fs_info->super_copy->metadata_uuid,
-				BTRFS_FSID_SIZE));
-	}
 
 	features = btrfs_super_flags(disk_super);
 	if (features & BTRFS_SUPER_FLAG_CHANGING_FSID_V2) {
-- 
2.25.1

