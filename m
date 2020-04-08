Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6CD1A1EE2
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Apr 2020 12:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgDHKgU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Apr 2020 06:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgDHKgU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Apr 2020 06:36:20 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5716F20753;
        Wed,  8 Apr 2020 10:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586342180;
        bh=6FSXzXkB2zdDHEGg/5jNKvB21ddsGbVwCdko3LS1A34=;
        h=From:To:Cc:Subject:Date:From;
        b=vZgWRG2C38tZL9zRzxUKZ46RP6fzz8YnSDMAAQ9qwh9gQwUlTQT35s4ZrMAYdD0Jw
         THvzsojLY1Brrl31fVNBAVD6RryAJ9jAhm70NK2iYNpdy41ZzO2FysiQy6A0zg7jRf
         m847j5ItpWOUMin9HY/syad7GPwiS24mjJt0gTZE=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 3/4] fsx: fix infinite/too long loops when generating ranges for copy_file_range
Date:   Wed,  8 Apr 2020 11:36:16 +0100
Message-Id: <20200408103616.11458-1-fdmanana@kernel.org>
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
---
 ltp/fsx.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 5949ebf0..89a5f60e 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -2042,17 +2042,25 @@ test(void)
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

