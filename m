Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F19A8D9E
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 21:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbfIDRXC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 13:23:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:50850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731447AbfIDRXC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Sep 2019 13:23:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67ACEB024;
        Wed,  4 Sep 2019 17:23:01 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] btrfs: Don't assign retval of btrfs_try_tree_write_lock/btrfs_tree_read_lock_atomic
Date:   Wed,  4 Sep 2019 20:22:39 +0300
Message-Id: <20190904172239.14276-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904171635.13783-1-nborisov@suse.com>
References: <20190904171635.13783-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Those function are simple boolean predicates there is no need to assign
their return values to interim variables. Use them directly as
predicates. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
V2: 
 * Missed one call site in btrfs_search_old_slot.
 fs/btrfs/ctree.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 98f741c85905..e59cde204b2f 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2913,15 +2913,13 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			if (!p->skip_locking) {
 				level = btrfs_header_level(b);
 				if (level <= write_lock_level) {
-					err = btrfs_try_tree_write_lock(b);
-					if (!err) {
+					if (!btrfs_try_tree_write_lock(b)) {
 						btrfs_set_path_blocking(p);
 						btrfs_tree_lock(b);
 					}
 					p->locks[level] = BTRFS_WRITE_LOCK;
 				} else {
-					err = btrfs_tree_read_lock_atomic(b);
-					if (!err) {
+					if (!btrfs_tree_read_lock_atomic(b)) {
 						btrfs_set_path_blocking(p);
 						btrfs_tree_read_lock(b);
 					}
@@ -3055,8 +3053,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 			}
 
 			level = btrfs_header_level(b);
-			err = btrfs_tree_read_lock_atomic(b);
-			if (!err) {
+			if (!btrfs_tree_read_lock_atomic(b)) {
 				btrfs_set_path_blocking(p);
 				btrfs_tree_read_lock(b);
 			}
-- 
2.17.1

