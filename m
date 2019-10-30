Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC33E9723
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 08:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfJ3H1Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 03:27:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:48058 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbfJ3H1Q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 03:27:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41225AEE9
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2019 07:27:15 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: Fix block groups read which may skip certain block groups
Date:   Wed, 30 Oct 2019 15:27:11 +0800
Message-Id: <20191030072711.73858-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Previous patch "btrfs-progs: Refactor btrfs_read_block_groups()" lacks a
fix which is in kernel counter part but not in btrfs-progs.

It doesn't reset the key.offset used to search next block group, thus
btrfs-progs can skip certain block groups items.

This can fail fsck/039 test case.

Please fold this fix into that patch.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 extent-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/extent-tree.c b/extent-tree.c
index 443f327a6bed..52b963265a07 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -2747,6 +2747,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *fs_info)
 			key.objectid++;
 		else
 			key.objectid = key.objectid + key.offset;
+		key.offset = 0;
 		btrfs_release_path(&path);
 	}
 	ret = 0;
-- 
2.23.0

