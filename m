Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA3D9E920
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 15:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbfH0NWU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 09:22:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:48270 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729159AbfH0NWU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 09:22:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 85379B066;
        Tue, 27 Aug 2019 13:22:19 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: tree-checker: Fix wrong check on max devid
Date:   Tue, 27 Aug 2019 21:22:06 +0800
Message-Id: <20190827132206.1483-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs doesn't reuse devid, thus if we add and delete device in a loop,
we can increase devid to higher value, triggering tree checker to give a
false alert.

But we still don't want to give up the devid check, so here we
compromise by setting a larger devid upper limit, 1<<32.

So crazy scripts can't bump devid to that high value easily, while we can
still detect obviously wrong devid.

Reported-by: Anand Jain <anand.jain@oracle.com>
Fixes: ab4ba2e13346 ("btrfs: tree-checker: Verify dev item")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 43e488f5d063..f9d24f01801e 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -686,9 +686,14 @@ static void dev_item_err(const struct extent_buffer *eb, int slot,
 static int check_dev_item(struct extent_buffer *leaf,
 			  struct btrfs_key *key, int slot)
 {
-	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	struct btrfs_dev_item *ditem;
-	u64 max_devid = max(BTRFS_MAX_DEVS(fs_info), BTRFS_MAX_DEVS_SYS_CHUNK);
+	/*
+	 * Btrfs doesn't really reuse devid, thus devid can increase to any
+	 * value, but we don't believe a devid higher than (1<<32) is really
+	 * valid. This could at least detect bitflip at the higher
+	 * 32 bits while still consider high devid valid.
+	 */
+	u64 max_devid = (1ULL << 32);
 
 	if (key->objectid != BTRFS_DEV_ITEMS_OBJECTID) {
 		dev_item_err(leaf, slot,
-- 
2.23.0

