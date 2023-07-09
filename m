Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF32A74C161
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Jul 2023 09:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjGIHIo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Jul 2023 03:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGIHIn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Jul 2023 03:08:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFF51B1
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Jul 2023 00:08:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CB47922109
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Jul 2023 07:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688886518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=w4IShNTAMyat1Sa4zBwNJ+MBvOFPgxBGb57TZgIXFhc=;
        b=DJHbbfNL0S9JzpYPJsC+qalNb8Gk7OhU5BPyv53v95b4Xyd2ZycvAHimHedsqGrdlObMf2
        qX73a89kGxya/zl30AfPEqFHmoyCqFH4ntfvt3KiO/vfdJ1tHKhOmLxAMU/LmkjrBD3Nci
        ESxC9UMgZMhAVN4mcbufVZorT3hA450=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A72C13A63
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Jul 2023 07:08:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kqL3LvVcqmQhYwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 09 Jul 2023 07:08:37 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: move subpage preallocation out of the loop
Date:   Sun,  9 Jul 2023 15:08:18 +0800
Message-ID: <0b506e836b9e614b02263014282495626f950052.1688886476.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Initially we preallocate btrfs_subpage structure in the main loop of
alloc_extent_buffer().

But later commit fbca46eb46ec ("btrfs: make nodesize >= PAGE_SIZE case
to reuse the non-subpage routine") has make sure we only go subpage
routine if our nodesize is smaller than PAGE_SIZE.

This means for that case, we only need to allocate the subpage structure
once anyway.

So this patch would make the preallocation out of the main loop.

This would slightly reduce the workload when we hold the page lock, and
make code a little easier to read.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix a possible (not that possible though) memory leak
  If find_or_create_page() failed (which calls with GFP_NOFAIL), we
  still need to release the preallocated memory.
---
 fs/btrfs/extent_io.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f2b3007803be..5851bb05897d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3529,6 +3529,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	struct extent_buffer *exists = NULL;
 	struct page *p;
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
+	struct btrfs_subpage *prealloc = NULL;
 	u64 lockdep_owner = owner_root;
 	bool pages_contig = true;
 	int uptodate = 1;
@@ -3566,36 +3567,30 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	btrfs_set_buffer_lockdep_class(lockdep_owner, eb, level);
 
 	num_pages = num_extent_pages(eb);
-	for (i = 0; i < num_pages; i++, index++) {
-		struct btrfs_subpage *prealloc = NULL;
 
+	/*
+	 * Preallocate page->private for subpage case, so that we won't
+	 * allocate memory with private_lock nor page lock hold.
+	 *
+	 * The memory will be freed by attach_extent_buffer_page() or freed
+	 * manually if we exit earlier.
+	 */
+	if (fs_info->nodesize < PAGE_SIZE) {
+		prealloc = btrfs_alloc_subpage(fs_info, BTRFS_SUBPAGE_METADATA);
+		if (IS_ERR(prealloc)) {
+			exists = ERR_CAST(prealloc);
+			goto free_eb;
+		}
+	}
+
+	for (i = 0; i < num_pages; i++, index++) {
 		p = find_or_create_page(mapping, index, GFP_NOFS|__GFP_NOFAIL);
 		if (!p) {
 			exists = ERR_PTR(-ENOMEM);
+			btrfs_free_subpage(prealloc);
 			goto free_eb;
 		}
 
-		/*
-		 * Preallocate page->private for subpage case, so that we won't
-		 * allocate memory with private_lock hold.  The memory will be
-		 * freed by attach_extent_buffer_page() or freed manually if
-		 * we exit earlier.
-		 *
-		 * Although we have ensured one subpage eb can only have one
-		 * page, but it may change in the future for 16K page size
-		 * support, so we still preallocate the memory in the loop.
-		 */
-		if (fs_info->nodesize < PAGE_SIZE) {
-			prealloc = btrfs_alloc_subpage(fs_info, BTRFS_SUBPAGE_METADATA);
-			if (IS_ERR(prealloc)) {
-				ret = PTR_ERR(prealloc);
-				unlock_page(p);
-				put_page(p);
-				exists = ERR_PTR(ret);
-				goto free_eb;
-			}
-		}
-
 		spin_lock(&mapping->private_lock);
 		exists = grab_extent_buffer(fs_info, p);
 		if (exists) {
-- 
2.41.0

