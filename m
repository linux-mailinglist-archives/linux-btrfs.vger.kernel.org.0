Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2E21C4AC5
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 01:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgEDX6c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 19:58:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:37866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728278AbgEDX6c (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 19:58:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3717DABAD
        for <linux-btrfs@vger.kernel.org>; Mon,  4 May 2020 23:58:33 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 1/7] btrfs: block-group: Don't set the wrong READA flag for btrfs_read_block_groups()
Date:   Tue,  5 May 2020 07:58:19 +0800
Message-Id: <20200504235825.4199-2-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504235825.4199-1-wqu@suse.com>
References: <20200504235825.4199-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For regular block group items in extent tree, they are scattered inside
the huge tree, thus forward readahead makes no sense.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5627f53ca115..42dae6473354 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1985,7 +1985,6 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-	path->reada = READA_FORWARD;
 
 	cache_gen = btrfs_super_cache_generation(info->super_copy);
 	if (btrfs_test_opt(info, SPACE_CACHE) &&
-- 
2.26.2

