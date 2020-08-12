Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90709242A22
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 15:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgHLNQi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 09:16:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:53826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgHLNQi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 09:16:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4E7ADB763;
        Wed, 12 Aug 2020 13:16:59 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] btrfs: Rework error detection in init_tree_roots
Date:   Wed, 12 Aug 2020 16:16:35 +0300
Message-Id: <20200812131635.8432-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200804073236.6677-1-nborisov@suse.com>
References: <20200804073236.6677-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To avoid duplicating 3 lines of code the error detection logic in
init_tree_roots is somewhat quirky. It first checks for the presence of
any error condition, then checks for the specific condition to perform
any specific actions. That's spurious because directly checking for
each respective error condition and doing the necessary steps is more
obvious. While at it change the -EUCLEAN to -EIO in case the extent
buffer is not read correctly, this is in line with other sites which
return -EIO when the eb couldn't be read.

Additionally it results in smaller code and the code reads
more linearly:

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-95 (-95)
Function                                     old     new   delta
open_ctree                                 17243   17148     -95
Total: Before=113104, After=113009, chg -0.08%

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

Changes in v2:
* Return -EIO in case of !extent_buffer_uptodate
* Change the error messages to distinguish both cases albeit they are still
rather similar.

 fs/btrfs/disk-io.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2f4169231992..2483648f2915 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2624,18 +2624,17 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 		level = btrfs_super_root_level(sb);
 		tree_root->node = read_tree_block(fs_info, btrfs_super_root(sb),
 						  generation, level, NULL);
-		if (IS_ERR(tree_root->node) ||
-		    !extent_buffer_uptodate(tree_root->node)) {
+		if (IS_ERR(tree_root->node)) {
 			handle_error = true;
+			ret = PTR_ERR(tree_root->node);
+			tree_root->node = NULL;
+			btrfs_warn(fs_info, "Couldn't read tree root");
+			continue;

-			if (IS_ERR(tree_root->node)) {
-				ret = PTR_ERR(tree_root->node);
-				tree_root->node = NULL;
-			} else if (!extent_buffer_uptodate(tree_root->node)) {
-				ret = -EUCLEAN;
-			}
-
-			btrfs_warn(fs_info, "failed to read tree root");
+		} else if (!extent_buffer_uptodate(tree_root->node)) {
+			handle_error = true;
+			ret = -EIO;
+			btrfs_warn(fs_info, "Error while reading tree root");
 			continue;
 		}

--
2.17.1

