Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D26D7126B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 14:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243206AbjEZMcq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 08:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjEZMco (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 08:32:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006FCE58
        for <linux-btrfs@vger.kernel.org>; Fri, 26 May 2023 05:31:54 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E6A1C1F8CC
        for <linux-btrfs@vger.kernel.org>; Fri, 26 May 2023 12:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685104238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QRN4WrVIbVp1i7xoJEi+f6Oe2uHNTk+y18zCDuV1o08=;
        b=g70RtJtXO8iyXSqLfHmmC2P9VAhrYhVx0oinwh0T47ZtTG88Hz0CAq1zIpZh2jMRnKt4lg
        3pUoJasIzOvVZTpb28BZ+ec+4If8pBHtjNc55Hlf7xCoMCRB6+AcDMBqljfwu7OE591ky9
        Fvq99LKXsTNWI8MBKC6z8qNjeOMlHNY=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 45C42134AB
        for <linux-btrfs@vger.kernel.org>; Fri, 26 May 2023 12:30:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id K90TBG6mcGSvWAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 26 May 2023 12:30:38 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix a crash in metadata repair path
Date:   Fri, 26 May 2023 20:30:20 +0800
Message-Id: <cd4159ae5d32fdb87deba4bf6485819614016c11.1685088405.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Test case btrfs/027 would crash with subpage (64K page size, 4K
sectorsize) with the following dying messages:

 debug: map_length=16384 length=65536 type=metadata|raid6(0x104)
 assertion failed: map_length >= length, in fs/btrfs/volumes.c:8093
 ------------[ cut here ]------------
 kernel BUG at fs/btrfs/messages.c:259!
 Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
 Call trace:
  btrfs_assertfail+0x28/0x2c [btrfs]
  btrfs_map_repair_block+0x150/0x2b8 [btrfs]
  btrfs_repair_io_failure+0xd4/0x31c [btrfs]
  btrfs_read_extent_buffer+0x150/0x16c [btrfs]
  read_tree_block+0x38/0xbc [btrfs]
  read_tree_root_path+0xfc/0x1bc [btrfs]
  btrfs_get_root_ref.part.0+0xd4/0x3a8 [btrfs]
  open_ctree+0xa30/0x172c [btrfs]
  btrfs_mount_root+0x3c4/0x4a4 [btrfs]
  legacy_get_tree+0x30/0x60
  vfs_get_tree+0x28/0xec
  vfs_kern_mount.part.0+0x90/0xd4
  vfs_kern_mount+0x14/0x28
  btrfs_mount+0x114/0x418 [btrfs]
  legacy_get_tree+0x30/0x60
  vfs_get_tree+0x28/0xec
  path_mount+0x3e0/0xb64
  __arm64_sys_mount+0x200/0x2d8
  invoke_syscall+0x48/0x114
  el0_svc_common.constprop.0+0x60/0x11c
  do_el0_svc+0x38/0x98
  el0_svc+0x40/0xa8
  el0t_64_sync_handler+0xf4/0x120
  el0t_64_sync+0x190/0x194
 Code: aa0403e2 b0fff060 91010000 959c2024 (d4210000)

[CAUSE]
In btrfs/027 we test RAID6 with missing devices, in this particular
case, we're repairing a metadata at the end of a data stripe.

But at btrfs_repair_io_failure(), we always pass a full PAGE for repair,
and for subpage case this can cross stripe boundary and lead to the
above BUG_ON().

This metadata repair code is always there, since the introduction of
subpage support, but this can trigger BUG_ON() after the bio split
ability at btrfs_map_bio().

[FIX]
Instead of passing the old PAGE_SIZE, we calculate the correct length
based on the eb size and page size for both regular and subpage cases.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c461a46ac6f2..65ac7b95d3a4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -176,7 +176,6 @@ static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
 				      int mirror_num)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	u64 start = eb->start;
 	int i, num_pages = num_extent_pages(eb);
 	int ret = 0;
 
@@ -185,12 +184,14 @@ static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
 
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = eb->pages[i];
+		u64 start = max_t(u64, eb->start, page_offset(p));
+		u64 end = min_t(u64, eb->start + eb->len, page_offset(p) + PAGE_SIZE);
+		u32 len = end - start;
 
-		ret = btrfs_repair_io_failure(fs_info, 0, start, PAGE_SIZE,
-				start, p, start - page_offset(p), mirror_num);
+		ret = btrfs_repair_io_failure(fs_info, 0, start, len,
+				start, p, offset_in_page(start), mirror_num);
 		if (ret)
 			break;
-		start += PAGE_SIZE;
 	}
 
 	return ret;
-- 
2.40.1

