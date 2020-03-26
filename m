Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA3131937EC
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 06:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgCZFgL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 01:36:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:51030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgCZFgK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 01:36:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D0B26AC1D;
        Thu, 26 Mar 2020 05:36:08 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     linux-btrfs@vger.kernel.org, Marek Behun <marek.behun@nic.cz>
Subject: [PATCH U-BOOT v2 3/3] fs: btrfs: Fix LZO false decompression error caused by pending zero
Date:   Thu, 26 Mar 2020 13:35:56 +0800
Message-Id: <20200326053556.20492-4-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326053556.20492-1-wqu@suse.com>
References: <20200326053556.20492-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For certain btrfs files with compressed file extent, uboot will fail to
load it:

  btrfs_read_extent_reg: disk_bytenr=14229504 disk_len=73728 offset=0 nr_bytes=131
  072
  decompress_lzo: tot_len=70770
  decompress_lzo: in_len=1389
  decompress_lzo: in_len=2400
  decompress_lzo: in_len=3002
  decompress_lzo: in_len=1379
  decompress_lzo: in_len=88539136
  decompress_lzo: header error, in_len=88539136 clen=65534 tot_len=62580

NOTE: except the last line, all other lines are debug output.

Btrfs lzo compression uses its own format to record compressed size
(segment header, LE32).

However to make decompression easier, we never put such segment header
across page boundary.

In above case, the xxd dump of the lzo compressed data looks like this:

00001fe0: 4cdc 02fc 0bfd 02c0 dc02 0d13 0100 0001  L...............
00001ff0: 0000 0008 0300 0000 0000 0011 0000|0000  ................
00002000: 4705 0000 0001 cc02 0000 0000 0000 1e01  G...............

'|' is the "expected" segment header start position.

But in that page, there are only 2 bytes left, can't contain the 4 bytes
segment header.

So btrfs compression will skip that 2 bytes, put the segment header in
next page directly.

Uboot doesn't have such check, and read the header with 2 bytes offset,
result 0x05470000 (88539136), other than the expected result
0x00000547 (1351), resulting above error.

Follow the btrfs-progs restore implementation, by introducing tot_in to
record total processed bytes (including headers), and do proper page
boundary skip to fix it.

Please note that, current code base doesn't parse fs_info thus we can't
grab sector size easily, so it uses PAGE_SIZE, and relying on fs open
time check to exclude unsupported sector size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Cc: Marek Behun <marek.behun@nic.cz>
---
 fs/btrfs/compression.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 4ef44ce11485..b1884fc15ee0 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -9,6 +9,7 @@
 #include <malloc.h>
 #include <linux/lzo.h>
 #include <linux/zstd.h>
+#include <linux/compat.h>
 #include <u-boot/zlib.h>
 #include <asm/unaligned.h>
 
@@ -16,7 +17,7 @@
 #define LZO_LEN		4
 static u32 decompress_lzo(const u8 *cbuf, u32 clen, u8 *dbuf, u32 dlen)
 {
-	u32 tot_len, in_len, res;
+	u32 tot_len, tot_in, in_len, res;
 	size_t out_len;
 	int ret;
 
@@ -24,9 +25,11 @@ static u32 decompress_lzo(const u8 *cbuf, u32 clen, u8 *dbuf, u32 dlen)
 		return -1;
 
 	tot_len = le32_to_cpu(get_unaligned((u32 *)cbuf));
+	tot_in = 0;
 	cbuf += LZO_LEN;
 	clen -= LZO_LEN;
 	tot_len -= LZO_LEN;
+	tot_in += LZO_LEN;
 
 	if (tot_len == 0 && dlen)
 		return -1;
@@ -36,6 +39,8 @@ static u32 decompress_lzo(const u8 *cbuf, u32 clen, u8 *dbuf, u32 dlen)
 	res = 0;
 
 	while (tot_len > LZO_LEN) {
+		u32 rem_page;
+
 		in_len = le32_to_cpu(get_unaligned((u32 *)cbuf));
 		cbuf += LZO_LEN;
 		clen -= LZO_LEN;
@@ -44,6 +49,7 @@ static u32 decompress_lzo(const u8 *cbuf, u32 clen, u8 *dbuf, u32 dlen)
 			return -1;
 
 		tot_len -= (LZO_LEN + in_len);
+		tot_in += (LZO_LEN + in_len);
 
 		out_len = dlen;
 		ret = lzo1x_decompress_safe(cbuf, in_len, dbuf, &out_len);
@@ -56,6 +62,18 @@ static u32 decompress_lzo(const u8 *cbuf, u32 clen, u8 *dbuf, u32 dlen)
 		dlen -= out_len;
 
 		res += out_len;
+
+		/*
+		 * If the 4 bytes header does not fit to the rest of the page we
+		 * have to move to next one, or we read some garbage.
+		 */
+		rem_page = PAGE_SIZE - (tot_in % PAGE_SIZE);
+		if (rem_page < LZO_LEN) {
+			cbuf += rem_page;
+			tot_in += rem_page;
+			clen -= rem_page;
+			tot_len -= rem_page;
+		}
 	}
 
 	return res;
-- 
2.26.0

