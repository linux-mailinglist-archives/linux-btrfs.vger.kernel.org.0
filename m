Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E35691A1EE3
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Apr 2020 12:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgDHKgb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Apr 2020 06:36:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgDHKgb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Apr 2020 06:36:31 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C19A20753;
        Wed,  8 Apr 2020 10:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586342190;
        bh=kJQLcrgzAwge5U1k+lUnVNgNoNltpoecal7YgmW1t+M=;
        h=From:To:Cc:Subject:Date:From;
        b=Qr2GoGw1WcBdtGsrgGMCc7ru5Vl/Ss43LZftEw/3ruVEDoQIeN1KSF2tqelyi05lc
         SKJJrR6HQgSlg9BifvZYgePNDPo9ug5dCfHQKBMgPYqIaqtPsrVIDOzWlRYkvi+CTg
         GRpajTjTCs+obRkiH8ebrE5v7RPxbd+HFCRVgfK0=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 4/4] fsx: move range generation logic into a common helper
Date:   Wed,  8 Apr 2020 11:36:27 +0100
Message-Id: <20200408103627.11514-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We have very similar code that generates the destination range for clone,
dedupe and copy_file_range operations, so avoid duplicating the code three
times and move it into a helper function.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 ltp/fsx.c | 91 +++++++++++++++++++++++++--------------------------------------
 1 file changed, 36 insertions(+), 55 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 89a5f60e..8873cd01 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1930,6 +1930,36 @@ range_overlaps(
 	return llabs((unsigned long long)off1 - off0) < size;
 }
 
+static void generate_dest_range(unsigned long op,
+				unsigned long max_range_end,
+				unsigned long *src_offset,
+				unsigned long *size,
+				unsigned long *dst_offset)
+{
+	int tries = 0;
+
+	TRIM_OFF_LEN(*src_offset, *size, file_size);
+	if (op == OP_COPY_RANGE) {
+		*src_offset -= *src_offset % readbdy;
+		if (o_direct)
+			*size -= *size % readbdy;
+	} else {
+		*src_offset = *src_offset & ~(block_size - 1);
+		*size = *size & ~(block_size - 1);
+	}
+
+	do {
+		if (tries++ >= 30) {
+			*size = 0;
+			break;
+		}
+		*dst_offset = random();
+		TRIM_OFF(*dst_offset, max_range_end);
+		*dst_offset = *dst_offset & ~(block_size - 1);
+	} while (range_overlaps(*src_offset, *dst_offset, *size) ||
+		 *dst_offset + *size > max_range_end);
+}
+
 int
 test(void)
 {
@@ -2004,63 +2034,14 @@ test(void)
 			keep_size = random() % 2;
 		break;
 	case OP_CLONE_RANGE:
-		{
-			int tries = 0;
-
-			TRIM_OFF_LEN(offset, size, file_size);
-			offset = offset & ~(block_size - 1);
-			size = size & ~(block_size - 1);
-			do {
-				if (tries++ >= 30) {
-					size = 0;
-					break;
-				}
-				offset2 = random();
-				TRIM_OFF(offset2, maxfilelen);
-				offset2 = offset2 & ~(block_size - 1);
-			} while (range_overlaps(offset, offset2, size) ||
-				 offset2 + size > maxfilelen);
-			break;
-		}
+		generate_dest_range(op, maxfilelen, &offset, &size, &offset2);
+		break;
 	case OP_DEDUPE_RANGE:
-		{
-			int tries = 0;
-
-			TRIM_OFF_LEN(offset, size, file_size);
-			offset = offset & ~(block_size - 1);
-			size = size & ~(block_size - 1);
-			do {
-				if (tries++ >= 30) {
-					size = 0;
-					break;
-				}
-				offset2 = random();
-				TRIM_OFF(offset2, file_size);
-				offset2 = offset2 & ~(block_size - 1);
-			} while (range_overlaps(offset, offset2, size) ||
-				 offset2 + size > file_size);
-			break;
-		}
+		generate_dest_range(op, file_size, &offset, &size, &offset2);
+		break;
 	case OP_COPY_RANGE:
-		{
-			int tries = 0;
-
-			TRIM_OFF_LEN(offset, size, file_size);
-			offset -= offset % readbdy;
-			if (o_direct)
-				size -= size % readbdy;
-			do {
-				if (tries++ >= 30) {
-					size = 0;
-					break;
-				}
-				offset2 = random();
-				TRIM_OFF(offset2, maxfilelen);
-				offset2 -= offset2 % writebdy;
-			} while (range_overlaps(offset, offset2, size) ||
-				 offset2 + size > maxfilelen);
-			break;
-		}
+		generate_dest_range(op, maxfilelen, &offset, &size, &offset2);
+		break;
 	}
 
 have_op:
-- 
2.11.0

