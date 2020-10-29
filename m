Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0635D29EB39
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 13:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgJ2MDM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 08:03:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:32994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgJ2MDL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 08:03:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603972990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IatEoChM6vQSmeNAodiEgZ+wurYzG+cBO3AxcTUlypA=;
        b=UWTrfCvZm8ZPzFOxgN8MSRQW4PfpFKI2n6KAe/HY9sXCzZXbojy+4FKNsrwuIn/weirm4f
        FoR2lI1BTEMg7AgG4aw14QLsew+KZ+lWZT9zONEiHw6ieW3A64oF7daquWn+vXcSvH+syn
        1tGL+d2pcbRshRZnL8CXQbFq4/4zZvg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2929EAF37;
        Thu, 29 Oct 2020 12:03:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3A496DA7D9; Thu, 29 Oct 2020 13:01:35 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 7/8] btrfs: remove unnecessary casts in printk
Date:   Thu, 29 Oct 2020 13:01:35 +0100
Message-Id: <d4b745758ce834b4ffa716f1025f53cd58348270.1603972767.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1603972767.git.dsterba@suse.com>
References: <cover.1603972767.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Long time ago the explicit casts were necessary for u64 but we don't
need it.  Remove casts where the type matches, leaving only cases that
cast sector_t or loff_t.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/print-tree.c | 3 +--
 fs/btrfs/ref-verify.c | 3 +--
 fs/btrfs/uuid-tree.c  | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 7695c4783d33..e7ada5ceaa90 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -177,8 +177,7 @@ static void print_uuid_item(struct extent_buffer *l, unsigned long offset,
 		__le64 subvol_id;
 
 		read_extent_buffer(l, &subvol_id, offset, sizeof(subvol_id));
-		pr_info("\t\tsubvol_id %llu\n",
-		       (unsigned long long)le64_to_cpu(subvol_id));
+		pr_info("\t\tsubvol_id %llu\n", le64_to_cpu(subvol_id));
 		item_size -= sizeof(u64);
 		offset += sizeof(u64);
 	}
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 7f03dbe5b609..31caf4ec1c54 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -799,8 +799,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 		if (!be) {
 			btrfs_err(fs_info,
 "trying to do action %d to bytenr %llu num_bytes %llu but there is no existing entry!",
-				  action, (unsigned long long)bytenr,
-				  (unsigned long long)num_bytes);
+				  action, bytenr, num_bytes);
 			dump_ref_action(fs_info, ra);
 			kfree(ref);
 			kfree(ra);
diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index 28525ad7ff8c..74023c8a783f 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -129,8 +129,7 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 	} else {
 		btrfs_warn(fs_info,
 			   "insert uuid item failed %d (0x%016llx, 0x%016llx) type %u!",
-			   ret, (unsigned long long)key.objectid,
-			   (unsigned long long)key.offset, type);
+			   ret, key.objectid, key.offset, type);
 		goto out;
 	}
 
-- 
2.25.0

