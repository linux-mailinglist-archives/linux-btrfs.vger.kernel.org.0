Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633E148A5B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 03:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346606AbiAKCez (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 21:34:55 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52266 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244251AbiAKCey (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 21:34:54 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF88C212B5
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jan 2022 02:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641868493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fc9vHzB5+gPdJegNErEVfVxRNkC9o2ptqc/QdQp5bTE=;
        b=LX1vc6obAdzgvZUg41BuDm7gKTGUgjP51RZMOC8oyZnhLPeOkaXbTCCrQvE08XgNz3UPDh
        ovMFkHNWpPlNe/ILlbXFNVfGcmOtCDvKGZJWHus2fOjsT3i8AXCPN1C8DkZQ9FFcK3w7FA
        dblytGl2khwV7Q2CkZ93+GCoTAE4UpU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11DB213A42
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jan 2022 02:34:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0CAyMszs3GERFAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jan 2022 02:34:52 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs: use dummy extent buffer for super block sys chunk array read
Date:   Tue, 11 Jan 2022 10:34:32 +0800
Message-Id: <20220111023434.22915-2-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111023434.22915-1-wqu@suse.com>
References: <20220111023434.22915-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
During test for 16K page size with 4K sectorsize and 64K nodesize, btrfs
will reject the mount with the following dmesg:

 BTRFS warning (device dm-1): read-write for sector size 4096 with page size 16384 is experimental
 BTRFS error (device dm-1): tree block crosses page boundary, start 65536 nodesize 65536
 BTRFS error (device dm-1): failed to read the system array: -22
 BTRFS error (device dm-1): open_ctree failed

The rejection only happens with sectorsize=4K, page_size=16K and
nodesize=64K combination.

For sectorsize=4K, page_size=16K and nodesize=16K (default) case, it
works fine.

[CAUSE]
The problem is in how we read sys chunk array.

In function btrfs_read_sys_array(), we allocate an extent buffer and
copy super block into the extent buffer, so that we can use various
extent buffer helpers to do the work.

But the problem is, we're calling btrfs_find_create_tree_block(), which
will do all the validation check, including the page boundary check for
subpage cases.

[FIX]
In fact, we only need a dummy extent buffer, without all the checks for
a real extent buffer.

This patch will replace the btrfs_find_create_tree_block() call with
__alloc_dummy_extent_buffer().

By this we can:

- Set the extent buffer size to BTRFS_SUPER_INFO_SIZE
- Avoid the unnecessary validation checks

Also since we're here, remove some stale comments on setting the eb page
uptodate, as now set_extent_buffer_uptodate() can handle dummy eb cases
without any problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b07d382d53a8..00c7f5cf4b52 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7373,7 +7373,6 @@ static int read_one_dev(struct extent_buffer *leaf,
 
 int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_root *root = fs_info->tree_root;
 	struct btrfs_super_block *super_copy = fs_info->super_copy;
 	struct extent_buffer *sb;
 	struct btrfs_disk_key *disk_key;
@@ -7388,31 +7387,13 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 	u64 type;
 	struct btrfs_key key;
 
-	ASSERT(BTRFS_SUPER_INFO_SIZE <= fs_info->nodesize);
-	/*
-	 * This will create extent buffer of nodesize, superblock size is
-	 * fixed to BTRFS_SUPER_INFO_SIZE. If nodesize > sb size, this will
-	 * overallocate but we can keep it as-is, only the first page is used.
-	 */
-	sb = btrfs_find_create_tree_block(fs_info, BTRFS_SUPER_INFO_OFFSET,
-					  root->root_key.objectid, 0);
+	ASSERT(BTRFS_SUPER_INFO_SIZE <= fs_info->nodesize &&
+	       BTRFS_SUPER_INFO_SIZE <= PAGE_SIZE);
+	sb = __alloc_dummy_extent_buffer(fs_info, BTRFS_SUPER_INFO_OFFSET,
+					 BTRFS_SUPER_INFO_SIZE);
 	if (IS_ERR(sb))
 		return PTR_ERR(sb);
 	set_extent_buffer_uptodate(sb);
-	/*
-	 * The sb extent buffer is artificial and just used to read the system array.
-	 * set_extent_buffer_uptodate() call does not properly mark all it's
-	 * pages up-to-date when the page is larger: extent does not cover the
-	 * whole page and consequently check_page_uptodate does not find all
-	 * the page's extents up-to-date (the hole beyond sb),
-	 * write_extent_buffer then triggers a WARN_ON.
-	 *
-	 * Regular short extents go through mark_extent_buffer_dirty/writeback cycle,
-	 * but sb spans only this function. Add an explicit SetPageUptodate call
-	 * to silence the warning eg. on PowerPC 64.
-	 */
-	if (PAGE_SIZE > BTRFS_SUPER_INFO_SIZE)
-		SetPageUptodate(sb->pages[0]);
 
 	write_extent_buffer(sb, super_copy, 0, BTRFS_SUPER_INFO_SIZE);
 	array_size = btrfs_super_sys_array_size(super_copy);
-- 
2.34.1

