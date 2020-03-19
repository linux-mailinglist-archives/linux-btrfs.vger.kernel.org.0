Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8138F18B37C
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 13:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgCSMd2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 08:33:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:40808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbgCSMd2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 08:33:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 45F56ACEF;
        Thu, 19 Mar 2020 12:33:27 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] uboot: fs/btrfs: Use LZO_LEN to replace immediate number
Date:   Thu, 19 Mar 2020 20:33:18 +0800
Message-Id: <20200319123319.37848-2-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319123319.37848-1-wqu@suse.com>
References: <20200319123319.37848-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just a cleanup. The immediate number makes my eye hurt.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 346875d45a1b..4ef44ce11485 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -12,36 +12,38 @@
 #include <u-boot/zlib.h>
 #include <asm/unaligned.h>
 
+/* Header for each segment, LE32, recording the compressed size */
+#define LZO_LEN		4
 static u32 decompress_lzo(const u8 *cbuf, u32 clen, u8 *dbuf, u32 dlen)
 {
 	u32 tot_len, in_len, res;
 	size_t out_len;
 	int ret;
 
-	if (clen < 4)
+	if (clen < LZO_LEN)
 		return -1;
 
 	tot_len = le32_to_cpu(get_unaligned((u32 *)cbuf));
-	cbuf += 4;
-	clen -= 4;
-	tot_len -= 4;
+	cbuf += LZO_LEN;
+	clen -= LZO_LEN;
+	tot_len -= LZO_LEN;
 
 	if (tot_len == 0 && dlen)
 		return -1;
-	if (tot_len < 4)
+	if (tot_len < LZO_LEN)
 		return -1;
 
 	res = 0;
 
-	while (tot_len > 4) {
+	while (tot_len > LZO_LEN) {
 		in_len = le32_to_cpu(get_unaligned((u32 *)cbuf));
-		cbuf += 4;
-		clen -= 4;
+		cbuf += LZO_LEN;
+		clen -= LZO_LEN;
 
-		if (in_len > clen || tot_len < 4 + in_len)
+		if (in_len > clen || tot_len < LZO_LEN + in_len)
 			return -1;
 
-		tot_len -= 4 + in_len;
+		tot_len -= (LZO_LEN + in_len);
 
 		out_len = dlen;
 		ret = lzo1x_decompress_safe(cbuf, in_len, dbuf, &out_len);
-- 
2.25.1

