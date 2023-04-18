Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C476E564C
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 03:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjDRBSR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 21:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjDRBSQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 21:18:16 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70B75275
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 18:17:57 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id E88BCC01E; Tue, 18 Apr 2023 03:17:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1681780675; bh=PkmCiQrLL96YjUanWM39Rl4r3Fvd3m+dxKjvFbXSGJY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=x0wQjItY1a08pEs/jBZdRfoK+1LmesvgY+fHTuktkpy2HL5g7J30l5U/aqnL4pt3U
         9DtY7Vln7MSBkGMAJmgKxd4gBD/GlTYpLSQKO/GlLiozEXEzQtY1PviakRK/KUgBop
         fQZVJC+36bEucdUjClJaw6BwyqQEjUD9pCsJ6jGs3ZFbWxcNJUuJVqHg20lWXEH100
         y8cXEwsW7WVbO0z5TQQ/4i9SNX87NnghlEy74SnXIPIi9mN2efyFkUbqcvcEwL6C/h
         H8LmkRnng5wSTTUh4h2eGaaLJ1sjLpPW/8kS81W4+LSdw15TYsfUSszq70OB9UYU9w
         I3pu2oQR+gerg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id E621FC01A;
        Tue, 18 Apr 2023 03:17:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1681780675; bh=PkmCiQrLL96YjUanWM39Rl4r3Fvd3m+dxKjvFbXSGJY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=x0wQjItY1a08pEs/jBZdRfoK+1LmesvgY+fHTuktkpy2HL5g7J30l5U/aqnL4pt3U
         9DtY7Vln7MSBkGMAJmgKxd4gBD/GlTYpLSQKO/GlLiozEXEzQtY1PviakRK/KUgBop
         fQZVJC+36bEucdUjClJaw6BwyqQEjUD9pCsJ6jGs3ZFbWxcNJUuJVqHg20lWXEH100
         y8cXEwsW7WVbO0z5TQQ/4i9SNX87NnghlEy74SnXIPIi9mN2efyFkUbqcvcEwL6C/h
         H8LmkRnng5wSTTUh4h2eGaaLJ1sjLpPW/8kS81W4+LSdw15TYsfUSszq70OB9UYU9w
         I3pu2oQR+gerg==
Received: from [127.0.0.2] (localhost [::1])
        by odin.codewreck.org (OpenSMTPD) with ESMTP id f0ea5edb;
        Tue, 18 Apr 2023 01:17:47 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
Date:   Tue, 18 Apr 2023 10:17:33 +0900
Subject: [PATCH U-BOOT 1/3] btrfs: fix offset within
 btrfs_read_extent_reg()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230418-btrfs-extent-reads-v1-1-47ba9839f0cc@codewreck.org>
References: <20230418-btrfs-extent-reads-v1-0-47ba9839f0cc@codewreck.org>
In-Reply-To: <20230418-btrfs-extent-reads-v1-0-47ba9839f0cc@codewreck.org>
To:     =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
X-Mailer: b4 0.13-dev-f371f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3027;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=zXCI+2WXL0xQZjXCJ7JbhDsxIxPG1DYINwdsoueMUxk=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBkPe+7UM3z+mAW/rG27aWAaxpGjZGEF3hH4Zfxl
 g71s9rxEL+JAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZD3vuwAKCRCrTpvsapjm
 cMf0D/991mQmrNQKw1rM7MT3B/m23XBniBrnN6ftSdX1iUTha/gF501CPsboTCiGLwmOBmAGkAn
 ysmugWIKNY0QWKtDqRILlxu9AeZVs8CDCteu80QcFa/XA8rQV0lpo6lCSgvWw9TmizdW8/kYMAG
 wzYCGYGvdKX3keBvrT0tlVchsmyh2ep94/jzo3asTdXckSl68O9BMDSnRtu+AtVxuoBG5NsTgfK
 eUZv9VIvfJljw3yfXYU7Q0yFRgHYmJffnxJXFUW8cKDXHBv/FXlQYx4mni8vEVS06yuxVK3SszL
 HmThvO/JRVWeuHDlzHKIl3jg1vt4rIk0pwj4p4DINyV+ZTXlnUYHrb3ZWl2GpOU8sryAJo5NlYF
 1UKUFAN/fTKYM8e/52qBfswZTq2P+hN+ynuzZq0AHwuuokCX1v83E5yxHGUZDosslhyvxWrfNUV
 ZOl5NOfSUJzLoorCOxi5YEOGHhnKO+cGoag9NDSihTslAypoSoMhKxjWS2iv1YkjqyVAf9MUu+L
 C5bPlYQSNcjLCv0KBKg9oXctbUZwGjpXs1tTPcCA9RddR6NfRB7CKlNt5klSPzkDSzvtpSKUrnc
 PTVAFwfxiMfYJl++5kqzhBQbnLDZuxh22tmCSepShGrBMf8YFjI1l9IdArD3eLjFgzQWa6LOo6/
 x/TMpGnD2Fw5B4g==
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
contained data from a few blocks prior:
btrfs_file_read()
 -> btrfs_read_extent_reg
    (aligned part loop from 0x40480000 to 0x40ba0000, 128KB at a time)
     last read had 0x4000 bytes in extent, but aligned_end - cur limited
     the read to 0x3000 (offset 0x720000)
 -> read_and_truncate_page
   -> btrfs_read_extent_reg
      reading the last 0x1000 bytes from offset 0x73000 (end of the
      previous 0x4000) into 0x40ba3000
      here key.offset = 0x70000 so we need to use it to recover the
      0x3000 offset.

Confirmed by checking data, before patch:
u-boot=> mmc load 1:1 $loadaddr boot/uImage
u-boot=> md 0x40ba0000
40ba0000: c0232ff8 c0c722cb 030e94be bf10000c    ./#.."..........
u-boot=> md 0x40ba3000
40ba3000: c0232ff8 c0c722cb 030e94be bf10000c    ./#.."..........

After patch (also confirmed with data read from linux):
u-boot=> md 0x40ba3000
40ba3000: 64cc9f03 81142256 6910000c 0c03483c    ...dV".....i<H..

Note that the code previously (before commit e3427184f38a ("fs: btrfs:
Implement btrfs_file_read()")) did not split that read in two, so
this is a regression.

Fixes: a26a6bedafcf ("fs: btrfs: Introduce btrfs_read_extent_inline() and btrfs_read_extent_reg()")
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
 fs/btrfs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 40025662f250..3d6e39e6544d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -443,6 +443,8 @@ int btrfs_read_extent_reg(struct btrfs_path *path,
 	       IS_ALIGNED(len, fs_info->sectorsize));
 	ASSERT(offset >= key.offset &&
 	       offset + len <= key.offset + extent_num_bytes);
+	/* offset is now offset within extent */
+	offset = btrfs_file_extent_offset(leaf, fi) + offset - key.offset;
 
 	/* Preallocated or hole , fill @dest with zero */
 	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_PREALLOC ||
@@ -454,9 +456,7 @@ int btrfs_read_extent_reg(struct btrfs_path *path,
 	if (btrfs_file_extent_compression(leaf, fi) == BTRFS_COMPRESS_NONE) {
 		u64 logical;
 
-		logical = btrfs_file_extent_disk_bytenr(leaf, fi) +
-			  btrfs_file_extent_offset(leaf, fi) +
-			  offset - key.offset;
+		logical = btrfs_file_extent_disk_bytenr(leaf, fi) + offset;
 		read = len;
 
 		num_copies = btrfs_num_copies(fs_info, logical, len);
@@ -511,7 +511,7 @@ int btrfs_read_extent_reg(struct btrfs_path *path,
 	if (ret < dsize)
 		memset(dbuf + ret, 0, dsize - ret);
 	/* Then copy the needed part */
-	memcpy(dest, dbuf + btrfs_file_extent_offset(leaf, fi), len);
+	memcpy(dest, dbuf + offset, len);
 	ret = len;
 out:
 	free(cbuf);

-- 
2.39.2

