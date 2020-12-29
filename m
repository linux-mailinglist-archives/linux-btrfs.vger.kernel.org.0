Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B902E6CD6
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Dec 2020 01:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbgL2Aj3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Dec 2020 19:39:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:46646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730609AbgL2Aj3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Dec 2020 19:39:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609202322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dCPf6tUKGbJ3ORv5ryjQaBMhe3JgJi/HIc7W4tDMUiA=;
        b=CH7pR4eiys/2aRTh+wvjiKNfAa6faagjgcG4H1vxmF8QSfuoYEHYsW/rFNfiy3bsI49GNQ
        nYRsy7EWC46DR7e3neO/uCQdiaIWGaBtVdwZr7IUa9K849AbfXm2uIsOR6AWCCXctCj18a
        7YkfDhuIjxufUmhrm+GEPMjMaTy279Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 630CAACBA;
        Tue, 29 Dec 2020 00:38:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?q?St=C3=A9phane=20Lesimple?= <stephane_btrfs2@lesimple.fr>
Subject: [PATCH] btrfs: relocation: output warning message for leftover v1 space cache before aborting current data balance
Date:   Tue, 29 Dec 2020 08:38:37 +0800
Message-Id: <20201229003837.16074-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In delete_v1_space_cache(), if we find a leaf whose owner is tree root,
and we can't grab the free space cache inode, then we return -ENOENT.

However this would make the caller, add_data_references(), to consider
this as a critical error, and abort current data balance.

This happens for fs using free space cache v2, while still has v1 data
left.

For v2 free space cache, we no longer load v1 data, making btrfs_igrab()
no longer work for root tree to grab v1 free space cache inodes.

The proper fix for the problem is to delete v1 space cache completely
during v2 convert.

We can't just ignore the -ENOENT error, as for root tree we don't use
reloc tree to replace its data references, but rely on COW.
This means, we have no way to relocate the leftover v1 data, and block
the relocation.

This patch will just workaround it by outputting a warning message,
showing the user how to manually solve it.

Reported-by: Stéphane Lesimple <stephane_btrfs2@lesimple.fr>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 19b7db8b2117..42746b59268d 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3027,6 +3027,25 @@ int add_data_references(struct reloc_control *rc,
 		ret = delete_v1_space_cache(eb, rc->block_group,
 					    extent_key->objectid);
 		free_extent_buffer(eb);
+		/*
+		 * This happens when the fs is converted to use v2 space cache,
+		 * but some v1 data is still left.
+		 * In that case, we can't delete the v1 space cache data as we
+		 * can't grab the free space cache inode anymore.
+		 *
+		 * And we can't ignore the error, as for root tree (where v1
+		 * space cache is) we don't do reloc tree to replace the data
+		 * to the new location, thus the old data will still be there,
+		 * blocking the data chunk to be relocated.
+		 *
+		 * Here we just warn user about the problem, and provide a
+		 * workaround.
+		 * The proper fix is in the v2 convert mount, which should
+		 * completely remove v1 data.
+		 */
+		if (ret == -ENOENT)
+			btrfs_warn(fs_info,
+"leftover v1 space cache found, please use btrfs-check --clear-space-cache v1 to clean it up");
 		if (ret < 0)
 			break;
 		ret = __add_tree_block(rc, ref_node->val, blocksize, blocks);
-- 
2.29.2

