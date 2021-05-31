Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B026395780
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 10:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhEaIxq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 04:53:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:41242 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhEaIxe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 04:53:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622451114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yZk8Yg5JB+yxE2ONdvdyKzERDUeHue9odN2RGnbIGYI=;
        b=Tp8waowxaS9XcffWEMJQaYSSrNd2FOopQ2RNJZ5tFc2HheN8Svjq/sbmt6diwb8XD8zGwS
        6qTlfYxigQjrHoPBOEOIdl7jn/sUDheGcFDwNTAn3BVlz1iacLEJnPUSbLhFt44IyiTHOR
        Koyqs5nO5ly5kXXrEXtLQDrXneONvUI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B01F5B49C
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 08:51:54 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 25/30] btrfs: reject raid5/6 fs for subpage
Date:   Mon, 31 May 2021 16:51:01 +0800
Message-Id: <20210531085106.259490-26-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531085106.259490-1-wqu@suse.com>
References: <20210531085106.259490-1-wqu@suse.com>
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
index 8c3db9076988..2dd48f4bec8f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3406,6 +3406,16 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
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
index 582695cee9d1..1e0829f342f8 100644
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
2.31.1

