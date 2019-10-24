Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8502AE36F0
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 17:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409742AbfJXPpA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 11:45:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:49998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2409718AbfJXPo7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 11:44:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 686BBB36C;
        Thu, 24 Oct 2019 15:44:58 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 1/2] btrfs: remove cached space_info in btrfs_statfs()
Date:   Thu, 24 Oct 2019 17:44:54 +0200
Message-Id: <20191024154455.19370-2-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191024154455.19370-1-jthumshirn@suse.de>
References: <20191024154455.19370-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_statfs() we cache fs_info::space_info in a local variable only
to use it once in a list_for_each_rcu() statement.

Not only is the local variable unnecessary it even makes the code harder
to follow as it's not clear which list it is iterating.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d5d15a19f51d..b818f764c1c9 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2021,7 +2021,6 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(dentry->d_sb);
 	struct btrfs_super_block *disk_super = fs_info->super_copy;
-	struct list_head *head = &fs_info->space_info;
 	struct btrfs_space_info *found;
 	u64 total_used = 0;
 	u64 total_free_data = 0;
@@ -2035,7 +2034,7 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	int mixed = 0;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(found, head, list) {
+	list_for_each_entry_rcu(found, &fs_info->space_info, list) {
 		if (found->flags & BTRFS_BLOCK_GROUP_DATA) {
 			int i;
 
-- 
2.16.4

