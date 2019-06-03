Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCEFC32D84
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 12:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfFCKGJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 06:06:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:53982 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbfFCKGG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 06:06:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7CD30AE07
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2019 10:06:05 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/4] btrfs: Skip first megabyte on device when trimming
Date:   Mon,  3 Jun 2019 13:06:01 +0300
Message-Id: <20190603100602.19362-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603100602.19362-1-nborisov@suse.com>
References: <20190603100602.19362-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently the first megabyte on a device housing a btrfs filesystem is
exempt from allocation and trimming. Currently this is not a problem
since 'start' is set to 1m at the beginning of btrfs_trim_free_extents
and find_first_clear_extent_bit always returns a range that is >= start.
However, in a follow up patch find_first_clear_extent_bit will be
changed such that it will return a range containing 'start' and this
range may very well be 0...>=1M so 'start'.

Future proof the sole user of find_first_clear_extent_bit by setting
'start' after the function is called. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent-tree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d8c5febf7636..5a11e4988243 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -11183,6 +11183,10 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 		 * to the caller to trim the value to the size of the device.
 		 */
 		end = min(end, device->total_bytes - 1);
+
+		/* Ensure we skip first mb in case we have a bootloader there */
+		start = max_t(u64, start, SZ_1M);
+
 		len = end - start + 1;
 
 		/* We didn't find any extents */
-- 
2.17.1

