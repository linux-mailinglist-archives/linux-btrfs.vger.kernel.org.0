Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 869B8F6F38
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2019 08:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfKKHvE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Nov 2019 02:51:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:38696 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbfKKHvE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Nov 2019 02:51:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 34C11AE40
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2019 07:51:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: Reduce error level from error to warning for OPEN_CTREE_PARTIAL
Date:   Mon, 11 Nov 2019 15:50:58 +0800
Message-Id: <20191111075059.30352-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Even if we're using OPEN_CTREE_PARTIAL, like "rescue zero log", the
error message still looks too serious even we skipped that tree:

    bad tree block 2172747776, bytenr mismatch, want=2172747776, have=0
    Couldn't setup extent tree
    ^^^^^^^^^^^^^^^^^^^^^^^^^^

This patch will change the error message to:
- Use error() if we're not using OPEN_CTREE_PARTIAL
- Use warning() and explicitly show we're skipping that tree

So the result would be something like:

  For non-OPEN_CTREE_PARTIAL case:
    bad tree block 2172747776, bytenr mismatch, want=2172747776, have=0
    ERROR: could not setup extent tree

  For OPEN_CTREE_PARTIAL case
    bad tree block 2172747776, bytenr mismatch, want=2172747776, have=0
    WARNING: could not setup extent tree, skipping it

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 disk-io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/disk-io.c b/disk-io.c
index 42f0026a6d2f..bdf63eee9bd9 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -886,9 +886,11 @@ static int setup_root_or_create_block(struct btrfs_fs_info *fs_info,
 
 	ret = find_and_setup_root(root, fs_info, objectid, info_root);
 	if (ret) {
-		printk("Couldn't setup %s tree\n", str);
-		if (!(flags & OPEN_CTREE_PARTIAL))
+		if (!(flags & OPEN_CTREE_PARTIAL)) {
+			error("could not setup %s tree", str);
 			return -EIO;
+		}
+		warning("could not setup %s tree, skipping it", str);
 		/*
 		 * Need a blank node here just so we don't screw up in the
 		 * million of places that assume a root has a valid ->node
-- 
2.24.0

