Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3304D3EFD0D
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 08:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbhHRGp0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 02:45:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57272 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbhHRGpC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 02:45:02 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 65D0520059
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 06:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629269067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NDYhrGZMlzq1ZKVlV+U6mGMKlZSaGPExJa7MetEZ5hc=;
        b=d0vP+y7os9x5zEhVGyNklQ0yCWPC+/1eiCqRIg7/UiwqohP85rRB2pIkK3YV8NMBdVdDpy
        AkaXyAblCmwb/nW/e3HNoiSbx9CJTEzKD3L+rHnjtidPjySwkutmoRXV4Cwd3Z+0r4dI4b
        cUK4repG0GcjKZOBN+3F24ogbEQR3Ss=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9B281134B1
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 06:44:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id IAfqFkqsHGH4dAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 06:44:26 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: require full nodesize alignement for subpage support
Date:   Wed, 18 Aug 2021 14:44:20 +0800
Message-Id: <20210818064420.866803-4-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210818064420.866803-1-wqu@suse.com>
References: <20210818064420.866803-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the incoming extra page size support for subpage (sectorsize <
PAGE_SIZE) cases, the support for metadata will be a critical point.

Currently for subpage support, we require 64K page size, so that no
matter whatever the nodesize is, it will be contained inside one page.
And we will reject any tree block which crosses page boundary.

But for other page size, especially 16K page size, we must support
nodesize differently.

For nodesize < PAGE_SIZE, we will have the same requirement (tree blocks
can't cross page boundary).
While for nodesize >= PAGE_SIZE, we will require the tree blocks to be
page aligned.

To support such feature, we will make btrfs-check to reports more
subpage related warnings for metadata.

This patch will report any tree block which is not nodesize aligned as a
warning.

Existing mkfs/convert has already make sure all new tree blocks are
nodesize aligned, this is just for older converted filesystems.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c        |  3 ++-
 check/mode-common.h | 22 +++++++++++++---------
 check/mode-lowmem.c |  3 ++-
 tests/common        |  2 +-
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/check/main.c b/check/main.c
index a88518159830..a46fc9daf591 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5410,7 +5410,8 @@ static int process_extent_item(struct btrfs_root *root,
 		return -EIO;
 	}
 	if (metadata)
-		btrfs_check_subpage_eb_alignment(key.objectid, num_bytes);
+		btrfs_check_subpage_eb_alignment(gfs_info, key.objectid,
+						 num_bytes);
 
 	memset(&tmpl, 0, sizeof(tmpl));
 	tmpl.start = key.objectid;
diff --git a/check/mode-common.h b/check/mode-common.h
index cdfb10d58cde..4a3f7741f084 100644
--- a/check/mode-common.h
+++ b/check/mode-common.h
@@ -175,20 +175,24 @@ static inline u32 btrfs_type_to_imode(u8 type)
 int get_extent_item_generation(u64 bytenr, u64 *gen_ret);
 
 /*
- * Check tree block alignment for future subpage support on 64K page system.
+ * Check tree block alignment for future subpage support.
  *
- * Subpage support on 64K page size require one eb to be completely contained
- * by a page. Not allowing a tree block to cross 64K page boundary.
+ * For subpage support, either nodesize is smaller than PAGE_SIZE, then tree
+ * block should not cross page boundary. (A)
+ * Or nodesize >= PAGE_SIZE, then it should be page aligned. (B)
  *
- * Since subpage support is still under development, this check only provides
- * warning.
+ * But here we have no idea the PAGE_SIZE could be, so here we play safe by
+ * requiring all tree blocks to be nodesize aligned.
+ *
+ * For 4K page size system, it always meets condtion (B), thus we don't need
+ * to bother that much.
  */
-static inline void btrfs_check_subpage_eb_alignment(u64 start, u32 len)
+static inline void btrfs_check_subpage_eb_alignment(struct btrfs_fs_info *info,
+						    u64 start, u32 len)
 {
-	if (start / BTRFS_MAX_METADATA_BLOCKSIZE !=
-	    (start + len - 1) / BTRFS_MAX_METADATA_BLOCKSIZE)
+	if (!IS_ALIGNED(start, info->nodesize))
 		warning(
-"tree block [%llu, %llu) crosses 64K page boundary, may cause problem for 64K page system",
+"tree block [%llu, %llu) is not nodesize aligned, may cause problem for 64K page system",
 			start, start + len);
 }
 
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 323e66bc4cb1..1116f9872039 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -4265,7 +4265,8 @@ static int check_extent_item(struct btrfs_path *path)
 		err |= CROSSING_STRIPE_BOUNDARY;
 	}
 	if (metadata)
-		btrfs_check_subpage_eb_alignment(key.objectid, nodesize);
+		btrfs_check_subpage_eb_alignment(gfs_info, key.objectid,
+						 nodesize);
 
 	ptr = (unsigned long)(ei + 1);
 
diff --git a/tests/common b/tests/common
index a6f75c7ce237..9dbebd33a9c8 100644
--- a/tests/common
+++ b/tests/common
@@ -850,7 +850,7 @@ check_test_results()
 	local testname="$2"
 
 	# Check subpage related warning
-	if grep -q "crrosses 64K page boundary" "$results"; then
+	if grep -q "not nodesize aligned" "$results"; then
 		_fail "found subpage related warning for case $testname"
 	fi
 }
-- 
2.32.0

