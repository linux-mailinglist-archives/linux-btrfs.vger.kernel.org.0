Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1E51B12A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Apr 2020 19:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgDTRJW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 13:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgDTRJV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 13:09:21 -0400
Received: from debian7.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0D49206D9;
        Mon, 20 Apr 2020 17:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587402561;
        bh=1NURecO0mrbzqRJJhqwcnUklSVWjq4mXylGXv77qwzU=;
        h=From:To:Cc:Subject:Date:From;
        b=peRQsf5jD8aed7u1ZY4wNJK+QO4AgM4RRvq4VZgOP6ZyOV+jbl1zygQBSGAAqmxQ2
         fuSl2M9t7MkNFHsUIW7tQYhU5oInyVJA26MDEHAf07q7W//7rjzCFUgfbyO4Ar4wtf
         xV5RRCht31X+atU411k4d7RV4cglJfDMA7nQLGMA=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 3/4] fsx: fix infinite/too long loops when generating ranges for copy_file_range
Date:   Mon, 20 Apr 2020 18:09:17 +0100
Message-Id: <20200420170917.9994-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

While running generic/521 I've had fsx taking a lot of CPU time and not
making any progress for several hours. Attaching gdb to the fsx process
revealed that fsx was in the loop that generates the ranges for a
copy_file_range operation, in particular the loop seemed to never end
because the range defined by 'offset2' kept overlapping with the range
defined by 'offset'.
So far this happened one time only in one of my test VMs with generic/521.

Fix this by breaking out of the loop after trying 30 times, like we
currently do for dedupe operations, which results in logging the operation
as skipped.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
---
 ltp/fsx.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index ab64b50a..40cbd401 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -2051,17 +2051,25 @@ test(void)
 			break;
 		}
 	case OP_COPY_RANGE:
-		TRIM_OFF_LEN(offset, size, file_size);
-		offset -= offset % readbdy;
-		if (o_direct)
-			size -= size % readbdy;
-		do {
-			offset2 = random();
-			TRIM_OFF(offset2, maxfilelen);
-			offset2 -= offset2 % writebdy;
-		} while (range_overlaps(offset, offset2, size) ||
-			 offset2 + size > maxfilelen);
-		break;
+		{
+			int tries = 0;
+
+			TRIM_OFF_LEN(offset, size, file_size);
+			offset -= offset % readbdy;
+			if (o_direct)
+				size -= size % readbdy;
+			do {
+				if (tries++ >= 30) {
+					size = 0;
+					break;
+				}
+				offset2 = random();
+				TRIM_OFF(offset2, maxfilelen);
+				offset2 -= offset2 % writebdy;
+			} while (range_overlaps(offset, offset2, size) ||
+				 offset2 + size > maxfilelen);
+			break;
+		}
 	}
 
 have_op:
-- 
2.11.0

