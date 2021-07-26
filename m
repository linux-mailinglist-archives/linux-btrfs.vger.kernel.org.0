Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551F53D5337
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 08:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhGZFy7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 01:54:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35638 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhGZFy6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 01:54:58 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4F9091FE45;
        Mon, 26 Jul 2021 06:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627281327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KRGzsbeQCrjO+wrXD+iR7cGzltsGf1jrUZLzilEkpOw=;
        b=kGk5LUlLQPmFf5BXubHmBnywFbFk2LLdUGuN8wYx699NjqiSHXrtZCWgGXi6HDEYbCBCQE
        B8t+/Ax9DEr8t4dYtDGLIK6it26wM2OhZ9ujhM3xNRUXGvrCi7z1Pmkg8zgAqslfpxyQGt
        ph0YrajNnR19ZaZFT6Ud+sYCX6RIr1g=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 48C081365C;
        Mon, 26 Jul 2021 06:35:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id kHPCAq5X/mCXBQAAGKfGzw
        (envelope-from <wqu@suse.com>); Mon, 26 Jul 2021 06:35:26 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v8 12/18] btrfs: reject raid5/6 fs for subpage
Date:   Mon, 26 Jul 2021 14:35:01 +0800
Message-Id: <20210726063507.160396-13-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210726063507.160396-1-wqu@suse.com>
References: <20210726063507.160396-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Raid5/6 is not only unsafe due to its write-hole problem, but also has
tons of hardcoded PAGE_SIZE.

So disable it for subpage support for now.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 10 ++++++++++
 fs/btrfs/volumes.c |  7 +++++++
 2 files changed, 17 insertions(+)

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
index 86846d6e58d0..2f140b6f3e34 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3982,6 +3982,13 @@ static inline int validate_convert_profile(struct btrfs_fs_info *fs_info,
 	if (!(bargs->flags & BTRFS_BALANCE_ARGS_CONVERT))
 		return true;
 
+	if (fs_info->sectorsize < PAGE_SIZE &&
+		bargs->target & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		btrfs_err(fs_info,
+	"RAID5/6 is not supported yet for sectorsize %u with page size %lu",
+			  fs_info->sectorsize, PAGE_SIZE);
+		return false;
+	}
 	/* Profile is valid and does not have bits outside of the allowed set */
 	if (alloc_profile_is_valid(bargs->target, 1) &&
 	    (bargs->target & ~allowed) == 0)
-- 
2.32.0

