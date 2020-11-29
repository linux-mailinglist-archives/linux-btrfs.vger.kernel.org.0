Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB76B2C7898
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Nov 2020 11:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgK2KR0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Nov 2020 05:17:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:44606 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgK2KR0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Nov 2020 05:17:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606644999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=T9pqWBhPSjtSqLonBUzm0WnQ9nlqpK0N5l+f4FRoLmA=;
        b=EiVr0pUIVYxcazC6/QD9xnAhI+wBdKvZTHHhh7LentirPP+GlUAmo1raYRFYyeEPf0uJue
        1lofmDb0aMQvNNSc8x2gU9ESytwG4F4A0dYEgI0Asqq2OH+1yIqReJK50teTXkFgKKESZE
        4PYb+SZ7Zqs00RbHbHTGUv5L0Se6eTw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2CEC1AB63
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Nov 2020 10:16:39 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: disk-io: output error message for tree block bytenr mismatch case
Date:   Sun, 29 Nov 2020 18:16:32 +0800
Message-Id: <20201129101632.110692-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a report from the community that, btrfs aborted transaction due
to page_offset() of a tree block doesn't match with its eb header.

The code looks like this:

	if (WARN_ON(found_start != start))
		return -EUCLEAN;

[CAUSE]
With extra debug patch and great help from the reporter, it turns out
that, there is a memory bitflip:

  [  471.998855] BTRFS warning (device sda1): page_start and eb_start
  mismatch, eb_start=17593525075968 page_start=1339031552

Note that:
eb_start   = 0x10004fd00000 (Extracted from in-memory tree block header)
page_start = 0x00004fd00000 (Page offset)

This is an obvious memory bitflip.

[ENHANCEMENT]
The check on extent buffer header can be considered as part of tree
checker, but more fundamental.

So it's reasonable to follow the tree-checker scheme to outputting human
readable error message, and output the "write time tree block corruption
detected" message.

Also with the human readable error message, there is no need to always
trigger a kernel warning, just trigger the warning for debug build.

Link: https://www.spinics.net/lists/linux-btrfs/msg107895.html
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 37b2e0aad162..b6040f8ffb08 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -465,8 +465,16 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct bio_vec *bvec
 	 * Please do not consolidate these warnings into a single if.
 	 * It is useful to know what went wrong.
 	 */
-	if (WARN_ON(found_start != start))
+	if (unlikely(found_start != start)) {
+		btrfs_err(fs_info,
+		"tree block bytenr mismatch, page_offset=%llu header_bytenr=%llu",
+			  start, found_start);
+		btrfs_err(fs_info,
+		"block=%llu write time tree block corruption detected",
+			  eb->start);
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
 		return -EUCLEAN;
+	}
 	if (WARN_ON(!PageUptodate(page)))
 		return -EUCLEAN;
 
-- 
2.29.2

