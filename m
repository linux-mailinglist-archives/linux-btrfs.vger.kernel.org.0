Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF0B7DBEA
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2019 14:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbfHAMuD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Aug 2019 08:50:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:34502 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbfHAMuD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Aug 2019 08:50:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01AA7ADF1
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2019 12:50:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1F1C8DA7D9; Thu,  1 Aug 2019 14:50:35 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/3] btrfs: tree-log: use symbolic name for first replay stage
Date:   Thu,  1 Aug 2019 14:50:35 +0200
Message-Id: <5e7f207680bb5e16c0ef4f8499b060bff308a8f5.1564663765.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564663765.git.dsterba@suse.com>
References: <cover.1564663765.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 5513e76cc336..f48c8b9b513b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6237,7 +6237,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 	struct btrfs_fs_info *fs_info = log_root_tree->fs_info;
 	struct walk_control wc = {
 		.process_func = process_one_buffer,
-		.stage = 0,
+		.stage = LOG_WALK_PIN_ONLY,
 	};
 
 	path = btrfs_alloc_path();
-- 
2.22.0

