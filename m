Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3D72AB0EA
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 06:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgKIFkF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 00:40:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:54508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729391AbgKIFkE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 00:40:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604900403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XA/YR97zEP721cxDtzooN0sVT+RRq9Px6SuFpZN/shQ=;
        b=XkZqyR/NHpLXj8uZhOJymFDQVipIdUiL8do6oOeDEXwvOShWn1z7XtpHcUPI16rpO4nwA6
        1YuqSYdIrqcG6uD/+7Jx+HZE9NuTPa7fKfYDAkBlTdYOcgFNtzc2acWzdnmLPywESOG4kL
        SK0prRzqON5S0T1uUBiIhN0yOlrHb1M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 022E4ACAC
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Nov 2020 05:40:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: check: detect and warn about tree blocks cross 64K page boundary
Date:   Mon,  9 Nov 2020 13:39:51 +0800
Message-Id: <20201109053952.490678-2-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109053952.490678-1-wqu@suse.com>
References: <20201109053952.490678-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the incoming subpage support, there is a new requirement for tree
blocks.
Tree blocks should not cross 64K page boudnary.

For current btrfs-progs and kernel, there shouldn't be any causes to
create such tree blocks.

But still, we want to detect such tree blocks in the wild before subpage
support fully lands in upstream.

This patch will add such check for both lowmem and original mode.
Currently it's just a warning, since there aren't many users using 64K
page size yet.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c        |  2 ++
 check/mode-common.h | 18 ++++++++++++++++++
 check/mode-lowmem.c |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/check/main.c b/check/main.c
index e7996b7c8c0e..0ce9c2f334b4 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5375,6 +5375,8 @@ static int process_extent_item(struct btrfs_root *root,
 		      num_bytes, gfs_info->sectorsize);
 		return -EIO;
 	}
+	if (metadata)
+		btrfs_check_subpage_eb_alignment(key.objectid, num_bytes);
 
 	memset(&tmpl, 0, sizeof(tmpl));
 	tmpl.start = key.objectid;
diff --git a/check/mode-common.h b/check/mode-common.h
index 4efc07a4f44d..bcda0f53e2c4 100644
--- a/check/mode-common.h
+++ b/check/mode-common.h
@@ -171,4 +171,22 @@ static inline u32 btrfs_type_to_imode(u8 type)
 
 	return imode_by_btrfs_type[(type)];
 }
+
+/*
+ * Check tree block alignement for future subpage support on 64K page system.
+ *
+ * Subpage support on 64K page size require one eb to be completely contained
+ * by a page. Not allowing a tree block to cross 64K page boudanry.
+ *
+ * Since subpage support is still under development, this check only provides
+ * warning.
+ */
+static inline void btrfs_check_subpage_eb_alignment(u64 start, u32 len)
+{
+	if (start / BTRFS_MAX_METADATA_BLOCKSIZE !=
+	    (start + len) / BTRFS_MAX_METADATA_BLOCKSIZE)
+		warning(
+"tree block [%llu, %llu) crosses 64K page boudnary, may cause problem for 64K page system",
+			start, start + len);
+}
 #endif
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 2b689b2abf63..6dbfe829bb7c 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -4206,6 +4206,8 @@ static int check_extent_item(struct btrfs_path *path)
 		      key.objectid, key.objectid + nodesize);
 		err |= CROSSING_STRIPE_BOUNDARY;
 	}
+	if (metadata)
+		btrfs_check_subpage_eb_alignment(key.objectid, nodesize);
 
 	ptr = (unsigned long)(ei + 1);
 
-- 
2.29.2

