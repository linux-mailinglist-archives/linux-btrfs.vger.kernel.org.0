Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 777115FE85
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 01:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfGDXDJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jul 2019 19:03:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52638 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfGDXDJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Jul 2019 19:03:09 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hjAkp-0003Ev-LC; Thu, 04 Jul 2019 23:03:03 +0000
From:   Colin King <colin.king@canonical.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] btrfs: fix memory leak of path on error return path
Date:   Fri,  5 Jul 2019 00:03:03 +0100
Message-Id: <20190704230303.5583-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently if the allocation of roots or tmp_ulist fails the error handling
does not free up the allocation of path causing a memory leak. Fix this and
other similar leaks by moving the call of btrfs_free_path from label out
to label out_free_ulist.

Kudos to David Sterba for spotting the issue in my original fix and
providing the correct way to fix the leak.

Addresses-Coverity: ("Resource leak")
Fixes: 5911c8fe05c5 ("btrfs: fiemap: preallocate ulists for btrfs_check_shared")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: move the btrfs_free_path to the out_free_ulist label as suggested by
    David Sterba as the correct fix.

---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1eb671c16ff1..31127f6d2971 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4766,11 +4766,11 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		ret = emit_last_fiemap_cache(fieinfo, &cache);
 	free_extent_map(em);
 out:
-	btrfs_free_path(path);
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, start, start + len - 1,
 			     &cached_state);
 
 out_free_ulist:
+	btrfs_free_path(path);
 	ulist_free(roots);
 	ulist_free(tmp_ulist);
 	return ret;
-- 
2.20.1

