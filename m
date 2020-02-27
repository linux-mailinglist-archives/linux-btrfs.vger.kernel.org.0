Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 042A4172925
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 21:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbgB0UBO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 15:01:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:55720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730761AbgB0UBO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 15:01:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 43C43B17A;
        Thu, 27 Feb 2020 20:01:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 532ABDA83A; Thu, 27 Feb 2020 21:00:52 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/4] btrfs: balance: factor out convert profile validation
Date:   Thu, 27 Feb 2020 21:00:52 +0100
Message-Id: <0432001929a87bd8fc75019ca67257d21d1b1315.1582832619.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1582832619.git.dsterba@suse.com>
References: <cover.1582832619.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The validation follows the same steps for all three block group types,
the existing helper validate_convert_profile can be enhanced and do more
of the common things.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3d35466f34b0..b5d7dc561b68 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3762,13 +3762,25 @@ static inline int balance_need_close(struct btrfs_fs_info *fs_info)
 		 atomic_read(&fs_info->balance_cancel_req) == 0);
 }
 
-/* Non-zero return value signifies invalidity */
-static inline int validate_convert_profile(struct btrfs_balance_args *bctl_arg,
-		u64 allowed)
+/*
+ * Validate target profile against allowed profiles and return true if it's OK.
+ * Otherwise print the error message and return false.
+ */
+static inline int validate_convert_profile(struct btrfs_fs_info *fs_info,
+		const struct btrfs_balance_args *bargs,
+		u64 allowed, const char *type)
 {
-	return ((bctl_arg->flags & BTRFS_BALANCE_ARGS_CONVERT) &&
-		(!alloc_profile_is_valid(bctl_arg->target, 1) ||
-		 (bctl_arg->target & ~allowed)));
+	if (!(bargs->flags & BTRFS_BALANCE_ARGS_CONVERT))
+		return true;
+
+	/* Profile is valid and does not have bits outside of the allowed set */
+	if (alloc_profile_is_valid(bargs->target, 1) &&
+	    (bargs->target & ~allowed) == 0)
+		return true;
+
+	btrfs_err(fs_info, "balance: invalid convert %s profile %s",
+			type, btrfs_bg_type_to_raid_name(bargs->target));
+	return false;
 }
 
 /*
@@ -3984,24 +3996,9 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 		if (num_devices >= btrfs_raid_array[i].devs_min)
 			allowed |= btrfs_raid_array[i].bg_flag;
 
-	if (validate_convert_profile(&bctl->data, allowed)) {
-		btrfs_err(fs_info,
-			  "balance: invalid convert data profile %s",
-			  btrfs_bg_type_to_raid_name(bctl->data.target));
-		ret = -EINVAL;
-		goto out;
-	}
-	if (validate_convert_profile(&bctl->meta, allowed)) {
-		btrfs_err(fs_info,
-			  "balance: invalid convert metadata profile %s",
-			  btrfs_bg_type_to_raid_name(bctl->meta.target));
-		ret = -EINVAL;
-		goto out;
-	}
-	if (validate_convert_profile(&bctl->sys, allowed)) {
-		btrfs_err(fs_info,
-			  "balance: invalid convert system profile %s",
-			  btrfs_bg_type_to_raid_name(bctl->sys.target));
+	if (!validate_convert_profile(fs_info, &bctl->data, allowed, "data") ||
+	    !validate_convert_profile(fs_info, &bctl->meta, allowed, "metadata") ||
+	    !validate_convert_profile(fs_info, &bctl->sys,  allowed, "system")) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.25.0

