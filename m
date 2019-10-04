Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0E0ECB75F
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 11:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387735AbfJDJbm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 05:31:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:39486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387406AbfJDJbl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Oct 2019 05:31:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D4ECB0B8
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2019 09:31:40 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: Enhance the error outputting for write time tree checker
Date:   Fri,  4 Oct 2019 17:31:33 +0800
Message-Id: <20191004093133.83582-4-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191004093133.83582-1-wqu@suse.com>
References: <20191004093133.83582-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Unlike read time tree checker error, write time error can't be inspected
by "btrfs ins dump-tree", so we need extra info to determine what's
going wrong.

The patch will add the following output for write time tree checker
error:
- The content of the offending tree block
  To help determining if it's a false alert.

- Kernel WARN_ON() for debug build
  This is helpful for us to detect unexpected write time tree checker
  error, especially fstests could catch the dmesg.
  Since the WARN_ON() is only triggered for write time tree checker,
  test cases utilizing dm-error won't trigger this WARN_ON(), thus no
  extra noise.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 16dc60b4966d..a0925b4e00af 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -545,9 +545,11 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct page *page)
 		ret = btrfs_check_leaf_full(eb);
 
 	if (ret < 0) {
+		btrfs_print_tree(eb, 0);
 		btrfs_err(fs_info,
 		"block=%llu write time tree block corruption detected",
 			  eb->start);
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
 		return ret;
 	}
 	write_extent_buffer(eb, result, 0, csum_size);
-- 
2.23.0

