Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76E829EE3A
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 15:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgJ2O3Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 10:29:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:48078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbgJ2O3Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 10:29:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603981762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NUmPo6q8kniT5jJdnQhSis+rp7NNoMFAjkclB3vkeMQ=;
        b=L05vkWr4+nrkngwfm6oci+RzY8vvZ8L1W49bn9HzpzFTqNuzRcmoOghRDGVvUiTSoEmmW1
        qhryVyMPVrEFT4VDIvEuT1Jl4Rw8SFf2f+95TCfOCFJpKxCeVWZe2pSmQOuDTdAJUY5hLw
        ihEICrEXukf3lz6R9QQBXuL5KglzOfg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 33B0EB91F;
        Thu, 29 Oct 2020 14:29:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 35A81DA7CE; Thu, 29 Oct 2020 15:27:47 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 05/10] btrfs: precalculate checksums per leaf once
Date:   Thu, 29 Oct 2020 15:27:47 +0100
Message-Id: <33195f212e58bb0150017b3c1ac6df5c2d8c8dc7.1603981453.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1603981452.git.dsterba@suse.com>
References: <cover.1603981452.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_csum_bytes_to_leaves shows up in system profiles, which makes it a
candidate for optimizations. After the 64bit division has been replaced
by shift, there's still a calculation done each time the function is
called: checksums per leaf.

As this is a constanat value for the entire filesystem lifetime, we
can calculate it once at mount time and reuse. This also allows to
reduce the division to 64bit/32bit as we know the constant will always
fit to 32bit type.

Replace the open-coded rounding up with a macro that internally handles
the 64bit division.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h       | 1 +
 fs/btrfs/disk-io.c     | 1 +
 fs/btrfs/extent-tree.c | 9 +--------
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1f2162fc1daa..8c4cd79b2810 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -933,6 +933,7 @@ struct btrfs_fs_info {
 	u32 sectorsize;
 	u32 sectorsize_bits;
 	u32 csum_size;
+	u32 csums_per_leaf;
 	u32 stripesize;
 
 	/* Block groups and devices containing active swapfiles. */
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 25dbdfa8bc4b..f870e252aa37 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3079,6 +3079,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->sectorsize = sectorsize;
 	fs_info->sectorsize_bits = ilog2(sectorsize);
 	fs_info->csum_size = btrfs_super_csum_size(disk_super);
+	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
 	fs_info->stripesize = stripesize;
 
 	/*
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 29ac97248942..81440a0ba106 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2138,17 +2138,10 @@ static u64 find_middle(struct rb_root *root)
  */
 u64 btrfs_csum_bytes_to_leaves(struct btrfs_fs_info *fs_info, u64 csum_bytes)
 {
-	u64 csum_size;
-	u64 num_csums_per_leaf;
 	u64 num_csums;
 
-	csum_size = BTRFS_MAX_ITEM_SIZE(fs_info);
-	num_csums_per_leaf = div64_u64(csum_size,
-			(u64)btrfs_super_csum_size(fs_info->super_copy));
 	num_csums = csum_bytes >> fs_info->sectorsize_bits;
-	num_csums += num_csums_per_leaf - 1;
-	num_csums = div64_u64(num_csums, num_csums_per_leaf);
-	return num_csums;
+	return DIV_ROUND_UP_ULL(num_csums, fs_info->csums_per_leaf);
 }
 
 /*
-- 
2.25.0

