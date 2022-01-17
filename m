Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F035490047
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 03:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbiAQCjK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jan 2022 21:39:10 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45070 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiAQCjK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jan 2022 21:39:10 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3F3F2218A4
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 02:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642387149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NgANhwYbd78Zx3rrbS/RB0I69pjP8p6HwOXnQ8noZHY=;
        b=FmHs7/MCXkgLTcg3eRNTI7bZREofzxz8LLmcPUUDnooW136wmUq0I9AqGSc8fd/9bR0TCG
        66fWDAWEANKw/zDEGV1upcGBf+/4hkT/bO9yu6vJvgv3/ZX86919xvhP0PUxATImuuYQBk
        xTM4KpDXLGQ187oTQQ4BS3BO4xY7rfA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 912E613216
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 02:39:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qCDpFszW5GG9MAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 02:39:08 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: check/lowmem: fix crash when METADATA_ITEM has invalid level
Date:   Mon, 17 Jan 2022 10:38:48 +0800
Message-Id: <20220117023850.40337-2-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117023850.40337-1-wqu@suse.com>
References: <20220117023850.40337-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running lowmem mode with METADATA_ITEM which has invalid level, it
will crash with the following backtrace:

 (gdb) bt
 #0  0x0000555555616b0b in btrfs_header_bytenr (eb=0x4)
     at ./kernel-shared/ctree.h:2134
 #1  0x0000555555620c78 in check_tree_block_backref (root_id=5,
     bytenr=30457856, level=256) at check/mode-lowmem.c:3818
 #2  0x0000555555621f6c in check_extent_item (path=0x7fffffffd9c0)
     at check/mode-lowmem.c:4334
 #3  0x00005555556235a5 in check_leaf_items (root=0x555555688e10,
     path=0x7fffffffd9c0, nrefs=0x7fffffffda30, account_bytes=1)
     at check/mode-lowmem.c:4835
 #4  0x0000555555623c6d in walk_down_tree (root=0x555555688e10,
     path=0x7fffffffd9c0, level=0x7fffffffd984, nrefs=0x7fffffffda30,
     check_all=1) at check/mode-lowmem.c:4967
 #5  0x000055555562494f in check_btrfs_root (root=0x555555688e10, check_all=1)
     at check/mode-lowmem.c:5266
 #6  0x00005555556254ee in check_chunks_and_extents_lowmem ()
     at check/mode-lowmem.c:5556
 #7  0x00005555555f0b82 in do_check_chunks_and_extents () at check/main.c:9114
 #8  0x00005555555f50ea in cmd_check (cmd=0x55555567c640 <cmd_struct_check>,
     argc=3, argv=0x7fffffffdec0) at check/main.c:10892
 #9  0x000055555556b2b1 in cmd_execute (argv=0x7fffffffdec0, argc=3,
     cmd=0x55555567c640 <cmd_struct_check>) at cmds/commands.h:125

[CAUSE]
For function check_extent_item() it will go through inline extent items
and then check their backrefs.

But for METADATA_ITEM, it doesn't really validate key.offset, which is
u64 and can contain value way larger than BTRFS_MAX_LEVEL (mostly caused
by bit flip).

In that case, if we have a larger value like 256 in key.offset, then
later check_tree_block_backref() will use 256 as level, and overflow
path->nodes[level] and crash.

[FIX]
Just verify the level, no matter if it's from btrfs_tree_block_level()
(which is just u8), or it's from key.offset (which is u64).

To do the check properly and detect higher bits corruption, also change
the type of @level from u8 to u64.

Now lowmem mode can detect the problem properly:

 ...
 [2/7] checking extents
 ERROR: tree block 30457856 has bad backref level, has 256 expect [0, 7]
 ERROR: extent[30457856 16384] level mismatch, wanted: 0, have: 256
 ERROR: errors found in extent allocation tree or chunk allocation
 [3/7] checking free space tree
 ...

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-lowmem.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index cc6773cd4d0c..99f519631a50 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -4242,7 +4242,7 @@ static int check_extent_item(struct btrfs_path *path)
 	u64 owner_offset;
 	u64 super_gen;
 	int metadata = 0;
-	int level;
+	u64 level;	/* To handle corrupted values in skinny backref */
 	struct btrfs_key key;
 	int ret;
 	int err = 0;
@@ -4303,6 +4303,16 @@ static int check_extent_item(struct btrfs_path *path)
 		/* New METADATA_ITEM */
 		level = key.offset;
 	}
+
+	if (metadata && level >= BTRFS_MAX_LEVEL) {
+		error(
+	"tree block %llu has bad backref level, has %llu expect [0, %u]",
+		      key.objectid, level, BTRFS_MAX_LEVEL - 1);
+		err |= BACKREF_MISMATCH;
+		/* This is a critical error, exit right now */
+		goto out;
+	}
+
 	ptr_offset = ptr - (unsigned long)ei;
 
 next:
-- 
2.34.1

