Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B698352CE
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2019 00:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfFDWn2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jun 2019 18:43:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfFDWn2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Jun 2019 18:43:28 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92F10206B8;
        Tue,  4 Jun 2019 22:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559688207;
        bh=McnH01l012LgpITPnazCqRJYDfp8SFNlTpLeOyd0rDk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iMpvIC1KpLUBc26GINzifM0DVnm8whlDtaLjgjFzkGsUuxLi4URKQ7Kz86LO1axJb
         ROYDLOE5iJKCfO3e/mDuVFq36lJWgmDFCC1r7h0nwP2pLpHpITo/a8kmnu+8Xlf8E5
         EsXgRa+o7Hse3+A4mDjXy7HiDjwS37jUW3oVHF+8=
Date:   Tue, 4 Jun 2019 15:43:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        keescook@chromium.org, gustavo@embeddedor.com, joe@perches.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, pankaj.m@samsung.com, v.narang@samsung.com,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] zstd: pass pointer rathen than structure to
 functions
Message-Id: <20190604154326.8868a10f896c148a0ce804d1@linux-foundation.org>
In-Reply-To: <1559552526-4317-2-git-send-email-maninder1.s@samsung.com>
References: <1559552526-4317-1-git-send-email-maninder1.s@samsung.com>
        <CGME20190603090232epcas5p1630d0584e8a1aa9495edc819605664fc@epcas5p1.samsung.com>
        <1559552526-4317-2-git-send-email-maninder1.s@samsung.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon,  3 Jun 2019 14:32:03 +0530 Maninder Singh <maninder1.s@samsung.com> wrote:

> currently params structure is passed in all functions, which increases
> stack usage in all the function and lead to stack overflow on target like
> ARM with kernel stack size of 8 KB so better to pass pointer.
> 
> Checked for ARM:
> 
>                                 Original               Patched
> Call FLow Size:                  1264                   1040
> ....
> (HUF_sort)                      -> 296
> (HUF_buildCTable_wksp)          -> 144
> (HUF_compress4X_repeat)         -> 88
> (ZSTD_compressBlock_internal)   -> 200
> (ZSTD_compressContinue_internal)-> 136                  -> 88
> (ZSTD_compressCCtx)             -> 192                  -> 64
> (zstd_compress)                 -> 144                  -> 96
> (crypto_compress)               -> 32
> (zcomp_compress)                -> 32
> ....
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> 

You missed btrfs.  This needs review, please - particularly the
kernel-wide static ZSTD_parameters in zstd_get_btrfs_parameters().

The base patch is here:

http://lkml.kernel.org/r/1559552526-4317-2-git-send-email-maninder1.s@samsung.com  

--- a/fs/btrfs/zstd.c~zstd-pass-pointer-rathen-than-structure-to-functions-fix
+++ a/fs/btrfs/zstd.c
@@ -27,15 +27,17 @@
 /* 307s to avoid pathologically clashing with transaction commit */
 #define ZSTD_BTRFS_RECLAIM_JIFFIES (307 * HZ)
 
-static ZSTD_parameters zstd_get_btrfs_parameters(unsigned int level,
+static ZSTD_parameters *zstd_get_btrfs_parameters(unsigned int level,
 						 size_t src_len)
 {
-	ZSTD_parameters params = ZSTD_getParams(level, src_len, 0);
+	static ZSTD_parameters params;
+
+	params = ZSTD_getParams(level, src_len, 0);
 
 	if (params.cParams.windowLog > ZSTD_BTRFS_MAX_WINDOWLOG)
 		params.cParams.windowLog = ZSTD_BTRFS_MAX_WINDOWLOG;
 	WARN_ON(src_len > ZSTD_BTRFS_MAX_INPUT);
-	return params;
+	return &params;
 }
 
 struct workspace {
@@ -155,11 +157,12 @@ static void zstd_calc_ws_mem_sizes(void)
 	unsigned int level;
 
 	for (level = 1; level <= ZSTD_BTRFS_MAX_LEVEL; level++) {
-		ZSTD_parameters params =
-			zstd_get_btrfs_parameters(level, ZSTD_BTRFS_MAX_INPUT);
-		size_t level_size =
-			max_t(size_t,
-			      ZSTD_CStreamWorkspaceBound(params.cParams),
+		ZSTD_parameters *params;
+		size_t level_size;
+
+		params = zstd_get_btrfs_parameters(level, ZSTD_BTRFS_MAX_INPUT);
+		level_size = max_t(size_t,
+			      ZSTD_CStreamWorkspaceBound(params->cParams),
 			      ZSTD_DStreamWorkspaceBound(ZSTD_BTRFS_MAX_INPUT));
 
 		max_size = max_t(size_t, max_size, level_size);
@@ -385,8 +388,9 @@ static int zstd_compress_pages(struct li
 	unsigned long len = *total_out;
 	const unsigned long nr_dest_pages = *out_pages;
 	unsigned long max_out = nr_dest_pages * PAGE_SIZE;
-	ZSTD_parameters params = zstd_get_btrfs_parameters(workspace->req_level,
-							   len);
+	ZSTD_parameters *params;
+
+	params = zstd_get_btrfs_parameters(workspace->req_level, len);
 
 	*out_pages = 0;
 	*total_out = 0;
_

