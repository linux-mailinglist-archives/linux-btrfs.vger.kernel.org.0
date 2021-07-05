Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA22B3BB509
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 04:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhGECEF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Jul 2021 22:04:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34336 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhGECEC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 4 Jul 2021 22:04:02 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D45E11FDDF
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jul 2021 02:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625450485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nRGLWUNqXnhrxfbUqafHzfxHbmkWuWWjlMSI/rHlwQo=;
        b=RLlYpKgCnD0p+Rj4AWmmyX9i1jj4GwqOyUjnqMa3tCWaXeltflfmQDCmrZTDcp5flg4LrI
        MztlwLihGZNxaaH4zcNQPuUJqsJaibcQGlSNPPl5QDFrz8/ESM4UPQtXUM+razA0QQ2ZqC
        7eHDFOcihxjcOQ/ABc9BSOrAeRNDD3w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CFE213522
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jul 2021 02:01:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oLY4NPRn4mAVSQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jul 2021 02:01:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v6 10/15] btrfs: reject raid5/6 fs for subpage
Date:   Mon,  5 Jul 2021 10:01:05 +0800
Message-Id: <20210705020110.89358-11-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210705020110.89358-1-wqu@suse.com>
References: <20210705020110.89358-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Raid5/6 is not only unsafe due to its write-hole problem, but also has
tons of hardcoded PAGE_SIZE.

So disable it for subpage support for now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 10 ++++++++++
 fs/btrfs/volumes.c |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b117dd3b8172..3de8e86f3170 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3402,6 +3402,16 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 			goto fail_alloc;
 		}
 	}
+	if (sectorsize != PAGE_SIZE) {
+		if (btrfs_super_incompat_flags(fs_info->super_copy) &
+			BTRFS_FEATURE_INCOMPAT_RAID56) {
+			btrfs_err(fs_info,
+	"raid5/6 is not yet supported for sector size %u with page size %lu",
+				sectorsize, PAGE_SIZE);
+			err = -EINVAL;
+			goto fail_alloc;
+		}
+	}
 
 	ret = btrfs_init_workqueues(fs_info, fs_devices);
 	if (ret) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 782e16795bc4..3cd876c49446 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3937,11 +3937,19 @@ static inline int validate_convert_profile(struct btrfs_fs_info *fs_info,
 	if (!(bargs->flags & BTRFS_BALANCE_ARGS_CONVERT))
 		return true;
 
+	if (fs_info->sectorsize < PAGE_SIZE &&
+		bargs->target & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		btrfs_err(fs_info,
+	"RAID5/6 is not supported yet for sectorsize %u with page size %lu",
+			  fs_info->sectorsize, PAGE_SIZE);
+		goto invalid;
+	}
 	/* Profile is valid and does not have bits outside of the allowed set */
 	if (alloc_profile_is_valid(bargs->target, 1) &&
 	    (bargs->target & ~allowed) == 0)
 		return true;
 
+invalid:
 	btrfs_err(fs_info, "balance: invalid convert %s profile %s",
 			type, btrfs_bg_type_to_raid_name(bargs->target));
 	return false;
-- 
2.32.0

