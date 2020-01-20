Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1180A14274C
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2020 10:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgATJcL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 04:32:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:48682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgATJcL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 04:32:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 57086AAB8
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jan 2020 09:32:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: Output proper csum string if csum mismatch
Date:   Mon, 20 Jan 2020 17:32:05 +0800
Message-Id: <20200120093205.37824-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce a new helper, csum_to_string(), to convert binary csum to
string.

And use it in check_extent_csums(), so that
"btrfs check --check-data-csum" could report the following human
readable output:
  mirror 1 bytenr 13631488 csum 0x13fec125 expected csum 0x98757625

Other than the original octane one:
  mirror 1 bytenr 13631488 csum 19 expected csum 152

It also has the extra handling for 32 bytes csum (e.g. SHA256).
For such long csum, it needs 66 characters (+2 for "0x") to just output
one hash, so this function would truncate them into the following
format:
 0xaabb...ccdd
    |       \- The tailing 2 bytes
    \--------- The leading 2 bytes

Although this means it's possible to hit cases where both result and
expected csum look the same, but it should be rare since small change in
cryptographic should lead to completely different output.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index 74316eab85ec..7db65150048b 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5667,6 +5667,27 @@ static int check_space_cache(struct btrfs_root *root)
 	return error ? -EINVAL : 0;
 }
 
+/*
+ * The buffer size must be large enough to contain:
+ * - "0x": 2
+ * - Hex strings: 2 * 4 (CRC32 csum size)
+ * - "...": 3 (For longer csum size)
+ * - \0: 1
+ */
+#define CSUM_STRING_BUFSIZE (2 + 2 * 4 + 3 + 1)
+
+static void csum_to_string(u16 csum_size, u8 *csum, char *buf)
+{
+	if (csum_size <= btrfs_csum_type_size(BTRFS_CSUM_TYPE_CRC32)) {
+		ASSERT(csum_size == btrfs_csum_type_size(BTRFS_CSUM_TYPE_CRC32));
+		sprintf(buf, "0x%02x%02x%02x%02x", csum[0], csum[1],
+				csum[2], csum[3]);
+	} else {
+		sprintf(buf, "0x%02x%02x...%02x%02x", csum[0], csum[1],
+			csum[csum_size - 2], csum[csum_size - 1]);
+	}
+}
+
 /*
  * Check data checksum for [@bytenr, @bytenr + @num_bytes).
  *
@@ -5719,6 +5740,9 @@ static int check_extent_csums(struct btrfs_root *root, u64 bytenr,
 			data_checked = 0;
 			/* verify every 4k data's checksum */
 			while (data_checked < read_len) {
+				char result_buf[CSUM_STRING_BUFSIZE];
+				char expect_buf[CSUM_STRING_BUFSIZE];
+
 				tmp = offset + data_checked;
 
 				btrfs_csum_data(csum_type, data + tmp,
@@ -5730,11 +5754,14 @@ static int check_extent_csums(struct btrfs_root *root, u64 bytenr,
 						   csum_offset, csum_size);
 				if (memcmp(result, csum_expected, csum_size) != 0) {
 					csum_mismatch = true;
-					/* FIXME: format of the checksum value */
+					csum_to_string(csum_size, result,
+							result_buf);
+					csum_to_string(csum_size, csum_expected,
+							expect_buf);
 					fprintf(stderr,
-			"mirror %d bytenr %llu csum %u expected csum %u\n",
+			"mirror %d bytenr %llu csum %s expected csum %s\n",
 						mirror, bytenr + tmp,
-						result[0], csum_expected[0]);
+						result_buf, expect_buf);
 				}
 				data_checked += fs_info->sectorsize;
 			}
-- 
2.24.1

