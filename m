Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5901AE3D6
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 19:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgDQRc1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 13:32:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728602AbgDQRc0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 13:32:26 -0400
Received: from debian7.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DF24208E4;
        Fri, 17 Apr 2020 17:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587144746;
        bh=ecBgLw1w9yQe1RySCuIf65DJjqZM3K8JlNSrvoGnj9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O1J4Y0Qif23PdrZj6FDE66dwLSZHqRhuHxaQG7/zeGUs3GOTyM53yFZlaFTOeQMDi
         j/1rIDfVYhnxy9TpgGlFFqIO5cv453md7501fMAXEyTv/+i+kP/wTXbq1EDjpaZBT2
         4baGL1objbAolgSxdyDIkm6dtVdjkjj5dDTj6dtA=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 4/4] fsx: move range generation logic into a common helper
Date:   Fri, 17 Apr 2020 18:32:21 +0100
Message-Id: <20200417173221.6380-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200408103627.11514-1-fdmanana@kernel.org>
References: <20200408103627.11514-1-fdmanana@kernel.org>
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

V2: Turned the first parameter of the helper into a boolean as Darrick suggested.
V3: Added destination offset align by writebdy when bdy_align is true.

 ltp/fsx.c | 94 ++++++++++++++++++++++++++-------------------------------------
 1 file changed, 39 insertions(+), 55 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 89a5f60e..2e51169b 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1930,6 +1930,39 @@ range_overlaps(
 	return llabs((unsigned long long)off1 - off0) < size;
 }
 
+static void generate_dest_range(bool bdy_align,
+				unsigned long max_range_end,
+				unsigned long *src_offset,
+				unsigned long *size,
+				unsigned long *dst_offset)
+{
+	int tries = 0;
+
+	TRIM_OFF_LEN(*src_offset, *size, file_size);
+	if (bdy_align) {
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
+		if (bdy_align)
+			*dst_offset = *dst_offset & writebdy;
+		else
+			*dst_offset = *dst_offset & ~(block_size - 1);
+	} while (range_overlaps(*src_offset, *dst_offset, *size) ||
+		 *dst_offset + *size > max_range_end);
+}
+
 int
 test(void)
 {
@@ -2004,63 +2037,14 @@ test(void)
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
+		generate_dest_range(false, maxfilelen, &offset, &size, &offset2);
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
+		generate_dest_range(false, file_size, &offset, &size, &offset2);
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
+		generate_dest_range(true, maxfilelen, &offset, &size, &offset2);
+		break;
 	}
 
 have_op:
-- 
2.11.0

