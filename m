Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C76B490049
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 03:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbiAQCjQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jan 2022 21:39:16 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41310 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiAQCjM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jan 2022 21:39:12 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 826251F37B;
        Mon, 17 Jan 2022 02:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642387150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MiROSOBF4w842ZYFKsZAK2iK7QTaSS/c4gISreQeb8w=;
        b=bKb49QS4E/BbGBqSNIYLqmhIz07m+Mo8CrmKANw5z23xxsEDeXhVFST7+c9lJeGhp5xVRv
        rwaig3tZNtZwJTZRh7wcLd7fWDVvcwH3zNEsDLpo/YD4f4Wj1mDYMN4YiuZrJpH4sMFUN9
        bztI9hn5cyl9foZ7teq5JTZ0WXFzhvw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A118613216;
        Mon, 17 Jan 2022 02:39:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ePSvGs3W5GG9MAAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 17 Jan 2022 02:39:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Stickstoff <stickstoff@posteo.de>
Subject: [PATCH 2/3] btrfs: check/original: reject bad metadata backref with invalid level
Date:   Mon, 17 Jan 2022 10:38:49 +0800
Message-Id: <20220117023850.40337-3-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117023850.40337-1-wqu@suse.com>
References: <20220117023850.40337-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a bug report that kernel tree-checker rejected an invalid
metadata item:

 corrupt leaf: block=934474399744 slot=68 extent bytenr=425173254144 len=16384 invalid tree level, have 33554432 expect [0, 7]

But original mode btrfs-check reports nothing wrong.
(BTW, lowmem mode will just crash, and fixed in previous patch).

[CAUSE]
For original mode it doesn't really check tree level, thus didn't find
the problem.

[FIX]
I don't have a good idea to completely make original mode to verify the
level in backref and in the tree block (while lowmem does that).

But at least we can detect obviouly corrupted level just like kernel.

Now original mode will detect such problem:

 ...
 [2/7] checking extents
 ERROR: tree block 30457856 has bad backref level, has 256 expect [0, 7]
 ref mismatch on [30457856 16384] extent item 0, found 1
 tree backref 30457856 root 5 not found in extent tree
 backpointer mismatch on [30457856 16384]
 ERROR: errors found in extent allocation tree or chunk allocation
 [3/7] checking free space tree
 ...

Reported-by: Stickstoff <stickstoff@posteo.de>
Link: https://lore.kernel.org/linux-btrfs/6ed4cd5a-7430-f326-4056-25ae7eb44416@posteo.de/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/check/main.c b/check/main.c
index 540130b8e223..2dea2acf5104 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5447,6 +5447,25 @@ static int process_extent_item(struct btrfs_root *root,
 	if (metadata)
 		btrfs_check_subpage_eb_alignment(gfs_info, key.objectid, num_bytes);
 
+	ptr = (unsigned long)(ei + 1);
+	if (metadata) {
+		u64 level;
+
+		if (key.type == BTRFS_EXTENT_ITEM_KEY) {
+			struct btrfs_tree_block_info *info;
+
+			info = (struct btrfs_tree_block_info *)ptr;
+			level = btrfs_tree_block_level(eb, info);
+		} else {
+			level = key.offset;
+		}
+		if (level >= BTRFS_MAX_LEVEL) {
+			error(
+	"tree block %llu has bad backref level, has %llu expect [0, %u]",
+			      key.objectid, level, BTRFS_MAX_LEVEL - 1);
+			return -EIO;
+		}
+	}
 	memset(&tmpl, 0, sizeof(tmpl));
 	tmpl.start = key.objectid;
 	tmpl.nr = num_bytes;
-- 
2.34.1

