Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C133B6E5989
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 08:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjDRGmg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Apr 2023 02:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjDRGmf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Apr 2023 02:42:35 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83B935BE
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 23:42:32 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 92309C009; Tue, 18 Apr 2023 08:42:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1681800151; bh=CLoc2nYkGUH0ySh9uuLEtH9C4qapdF3krFLb/C+nEUw=;
        h=From:Date:Subject:To:Cc:From;
        b=ETqTMgTsEA0JqaxTG0QYd/J64P6FFIgmKd/oZOGGE5x8pIYPXo73UuA8qMhuTJPh5
         0AxYaQgCRRMCTZGcX5bc4W9SyHAM2tXW+anRain0EggMh67ENTG2E4YoqQOC9opLDD
         w5UCVSKvS1w2voehGP/YyIyeAao0VqfJcii6p6UCdkBYJ0LbNQnie06sDfBUpkX/PD
         hvnGJ9sc2kraCmwq/wBagAxOs2E0MUY10EQb4xt8TLjc2B1VBPOkNlAKpDpUhbQnQV
         pESvpE8BrL52CS33bSMOQA4K7Ila+pG5T1SI+IdAyexIXr1z20hSPjdVD1/z6g9LEt
         tba+LVOZ0QSPg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 36950C009;
        Tue, 18 Apr 2023 08:42:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1681800150; bh=CLoc2nYkGUH0ySh9uuLEtH9C4qapdF3krFLb/C+nEUw=;
        h=From:Date:Subject:To:Cc:From;
        b=Pfq8PhsQUhqOsluN7TT6XJasPRYHgxGOhUxtgWijQKoRZoMURfI7OMsVhYxvjWpVK
         /9fU7dH28JdC7lSPRMiDSMp9ZGxQUEOPZc7LKhyiEukUm8ut5kdTx2pOIYBG5NYFPV
         qk81MD9qPogSLGsnpzBk7iUSN12IR+GqaN8ygwg9M1qBTP2lc6qkPcHIbGEnyYOpbA
         ZIf2wVEeSQfKmAVfI2Eyr2YQVpBLNVpRvH8snPqCEtwtFvgqP+6bDMZ8muoORDxudL
         cs1sNpWoGu55AR32aaQokUajB5CLRmGuQUyNaN4BvCxaN2rBRrN+1M9oDjMWPH4pK1
         kvEnC6TqmZpqQ==
Received: from [127.0.0.2] (localhost [::1])
        by odin.codewreck.org (OpenSMTPD) with ESMTP id f040317a;
        Tue, 18 Apr 2023 06:42:26 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
Date:   Tue, 18 Apr 2023 15:41:55 +0900
Subject: [PATCH U-BOOT v2] btrfs: fix offset when reading compressed
 extents
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230418-btrfs-extent-reads-v2-1-772a6be2ea9a@codewreck.org>
X-B4-Tracking: v=1; b=H4sIALI7PmQC/32OTQ6CMBSEr2Le2ppSiIIr4wXY6Mqw6M8rNMbWv
 DaIIdzdwgFcfjP5MjNDRHIY4bybgXB00QWfQex3oAfpe2TOZAbBRcmromYqkY0Mp4Q+MUJpMgh
 jj1iKRpoKsqhkRKZIej2s6kvGhLQWb0Lrpm3tAXd2bdsbdDkfXEyBvtuJsdjaf3tjwTirTko2d
 dlYrvVFB4MfQv08BOqhW5blBxcb3EXZAAAA
To:     =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
X-Mailer: b4 0.13-dev-f371f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3260;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=ukdUzhfywYgG2oTIbH7xDAzoLU14yAR7rBOZX7P6Ek0=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBkPjvS/oBvPXkm59cjaCKURjNL/FYhmpN+ogfrN
 vH68YyLh0OJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZD470gAKCRCrTpvsapjm
 cK3fD/9RI/3tby15603LlVrVyVXTIUjz8YzB1/X6QRifLguHPZK9CYUbnBF+9LoaakPp+4x1gM2
 D29cNGFm0drC5kqhlMFqipszhRmms6+JLFrNW/N5zXe6+GD9nnZRYhAAhbJEfLKky1xTigvn93/
 Q6ZP8jNZ2qsqROdN/r0YrfvqABhmXZNJqBD+hqvPGDrYaYmgOF/uyNY3LgDXFN4V9wejOAf3pQD
 GHzCb9w5mM/GF/c7JbjTzNMT89OG+EgrzbbjGUmb+SgPP5LPO2Ituidxg4tbM9hJEHFGF+UIKnu
 YsQaKEJq5UNwfBXV+rddJSo7SVhCNUubdof9ykO+NCr5yJGPfro/NI+PjcNxNHny7tKyOb1fI+N
 TrLDDGwt0BX+w1QIYDxXpXMCSZmpKAmXoFBz9j9QDMNGb4ZuMWgOfB1EWt8KCyCNNyMc4zsE1lb
 tGyQ10XT1nrkmhgNWm4egbHqyJpjxlD2PTphMxdUo+jgbAN5la3j4myM5yw4GKQGfKnH+NIxT/q
 HsDWZReiKIOSYXzUWQ11stH/Frzv/dZ5X1qnZLifzbcDaAVEMW9fSbXpDGLfsZ2Ea0CXry7gj/X
 hBI86e0oP9v3ieRnyeeOlbR51ba6aw9dyQQEBTH3sR8xV6it+3IKGkB/KDjLTA+UXVaNTtQNJQ8
 A40Tr4YFK1hNopA==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

btrfs_read_extent_reg correctly computed the extent offset in the
BTRFS_COMPRESS_NONE case, but did not account for the 'offset - key.offset'
part correctly in the compressed case, making the function read
incorrect data.

In the case I examined, the last 4k of a file was corrupted and
contained data from a few blocks prior, e.g. reading a 10k file with a
single extent:
btrfs_file_read()
 -> btrfs_read_extent_reg
    (aligned part loop, until 8k)
 -> read_and_truncate_page
   -> btrfs_read_extent_reg
      (re-reads the last extent from 8k to the end,
      incorrectly reading the first 2k of data)

This can be reproduced as follow:
$ truncate -s 200M btr
$ mount btr -o compress /mnt
$ pat() { dd if=/dev/zero bs=1M count=$1 iflag=count_bytes status=none | tr '\0' "\\$2"; }
$ { pat 4K 1; pat 4K 2; pat 2K 3; }  > /mnt/file
$ sync
$ filefrag -v /mnt/file
File size of /mnt/file is 10240 (3 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..       2:       3328..      3330:      3:             last,encoded,eof
$ umount /mnt

Then in u-boot:
=> load scsi 0 2000000 file
10240 bytes read in 3 ms (3.3 MiB/s)
=> md 2001ff0
02001ff0: 02020202 02020202 02020202 02020202  ................
02002000: 01010101 01010101 01010101 01010101  ................
02002010: 01010101 01010101 01010101 01010101  ................

(02002000 onwards should contain '03' pattern but went back to 01,
start of the extent)

After patch, data is read properly:
=> md 2001ff0
02001ff0: 02020202 02020202 02020202 02020202  ................
02002000: 03030303 03030303 03030303 03030303  ................
02002010: 03030303 03030303 03030303 03030303  ................

Note that the code previously (before commit e3427184f38a ("fs: btrfs:
Implement btrfs_file_read()")) did not split that read in two, so
this is a regression even if the previous code might not have been
handling offsets correctly either (something that booted now fails to
boot)

Fixes: a26a6bedafcf ("fs: btrfs: Introduce btrfs_read_extent_inline() and btrfs_read_extent_reg()")
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
Changes in v2:
- Keep offset decomposition explicit where it is used
- Add reproducer/clarify explanation in commit message
- Drop other patches temporarily
- Link to v1: https://lore.kernel.org/r/20230418-btrfs-extent-reads-v1-0-47ba9839f0cc@codewreck.org
---
 fs/btrfs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 40025662f250..38e285bf94b0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -511,7 +511,9 @@ int btrfs_read_extent_reg(struct btrfs_path *path,
 	if (ret < dsize)
 		memset(dbuf + ret, 0, dsize - ret);
 	/* Then copy the needed part */
-	memcpy(dest, dbuf + btrfs_file_extent_offset(leaf, fi), len);
+	memcpy(dest,
+	       dbuf + btrfs_file_extent_offset(leaf, fi) + offset - key.offset,
+	       len);
 	ret = len;
 out:
 	free(cbuf);

---
base-commit: 5db4972a5bbdbf9e3af48ffc9bc4fec73b7b6a79
change-id: 20230418-btrfs-extent-reads-e2df6e329ad4

Best regards,
-- 
Dominique Martinet | Asmadeus

