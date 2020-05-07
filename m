Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B2D1C9C18
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 22:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgEGUUZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 16:20:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:56156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGUUZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 16:20:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AAD09AC6C;
        Thu,  7 May 2020 20:20:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 009DDDA732; Thu,  7 May 2020 22:19:34 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 03/19] btrfs: don't use set/get token for single assignment in overwrite_item
Date:   Thu,  7 May 2020 22:19:34 +0200
Message-Id: <0ef38b64e78028c5b31de4952e8bf683f992c5df.1588853772.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1588853772.git.dsterba@suse.com>
References: <cover.1588853772.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The set/get token is supposed to cache the last page that was accessed
so it speeds up subsequential access to the eb. It does not make sense
to use that for just one change, which is the case of inode size in
overwrite_item.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/tree-log.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index ee1c627bd618..60febf2082ee 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -505,13 +505,8 @@ static noinline int overwrite_item(struct btrfs_trans_handle *trans,
 			 */
 			if (S_ISREG(btrfs_inode_mode(eb, src_item)) &&
 			    S_ISREG(btrfs_inode_mode(dst_eb, dst_item)) &&
-			    ino_size != 0) {
-				struct btrfs_map_token token;
-
-				btrfs_init_map_token(&token, dst_eb);
-				btrfs_set_token_inode_size(&token, dst_item,
-							   ino_size);
-			}
+			    ino_size != 0)
+				btrfs_set_inode_size(dst_eb, dst_item, ino_size);
 			goto no_copy;
 		}
 
-- 
2.25.0

