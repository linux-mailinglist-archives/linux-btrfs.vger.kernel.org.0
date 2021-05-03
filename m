Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9BF372373
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 May 2021 01:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhECXMp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 19:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhECXMp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 May 2021 19:12:45 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91C2C061574
        for <linux-btrfs@vger.kernel.org>; Mon,  3 May 2021 16:11:50 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id c3so4914327ils.5
        for <linux-btrfs@vger.kernel.org>; Mon, 03 May 2021 16:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6zev62OTk211hbqKygLUFpijw5yBb5yUs6rwPtVrKn0=;
        b=j3tc6ImLZEFaupeqOBqLjajHAsfwhzpE+4hv+VO63kJ9zlu8oPANZ7WV6j+x2CrHad
         7P3HXbly/dIBDzE14HKoY6JhB2Pj3GM5j6AmiD4LkOtr3ekFKexgpf8jP3PgcOSr8a9V
         DE9gTeKlC2WCpfi46+QVg7bjB2u3ZlBkz8/8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6zev62OTk211hbqKygLUFpijw5yBb5yUs6rwPtVrKn0=;
        b=My3YFK8RSFPFB3ZXZR0j2O/tXxBfBlvmWk/GFDzZHxynWqbPE5Fo0ACFo5CLf5wpd6
         w+NzyvnxnKkmx8AsVg133UNyRW060rrsDmjCLFC8F2JIGAbrYegdHBDrtdmZx2zkV3nu
         FN8Osv8fkHMhPA/gWtorjwxfFGPdq7au29WYJDjQQPs4QVOSDD3U2W4lNID+g5IMzL/C
         HySSCxPelzVoXPTv+8czeqj58/xA+Z44RlGBjM5aHRVYgff6xJ/Kfsj4IpBpf5NEdTFO
         IkWovLz7cBcUvlXf6c9ceWdbouKgeMXKF4TIRLqzf5KH06TsvgRCdDhnSGJ+6HdJgL7d
         aA3Q==
X-Gm-Message-State: AOAM5311oEwDW2UclaTzhKnI8GB27z2WlYJUSX0R9tCwgs6c5oG+Ohz8
        PjutvT47eptY+qA1ONPGTVk3Gw==
X-Google-Smtp-Source: ABdhPJy7ZPgo37jRE0wqmId8EnuPm7VPlnNi9OXpJfxvjiSrP5gkUHkWUXAyFv7aFfPUk1W9VLr7Iw==
X-Received: by 2002:a92:de49:: with SMTP id e9mr11350414ilr.132.1620083510459;
        Mon, 03 May 2021 16:11:50 -0700 (PDT)
Received: from kiwi.bld.corp.google.com (c-67-190-101-114.hsd1.co.comcast.net. [67.190.101.114])
        by smtp.gmail.com with ESMTPSA id o6sm422727ioa.21.2021.05.03.16.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 16:11:50 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     U-Boot Mailing List <u-boot@lists.denx.de>
Cc:     Tom Rini <trini@konsulko.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Bin Meng <bmeng.cn@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Andre Przywara <andre.przywara@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Simon Glass <sjg@chromium.org>,
        Marek Behun <marek.behun@nic.cz>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 04/49] btrfs: Use U-Boot API for decompression
Date:   Mon,  3 May 2021 17:10:51 -0600
Message-Id: <20210503171001.4.I7327e42043265556e3988928849ff2ebdc7b21e6@changeid>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
In-Reply-To: <20210503231136.744283-1-sjg@chromium.org>
References: <20210503231136.744283-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use the common function to avoid code duplication.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 fs/btrfs/compression.c | 51 +++++-------------------------------------
 1 file changed, 5 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 23efefa1997..7adfbb04a7c 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -6,6 +6,7 @@
  */
 
 #include "btrfs.h"
+#include <abuf.h>
 #include <log.h>
 #include <malloc.h>
 #include <linux/lzo.h>
@@ -136,54 +137,12 @@ static u32 decompress_zlib(const u8 *_cbuf, u32 clen, u8 *dbuf, u32 dlen)
 
 static u32 decompress_zstd(const u8 *cbuf, u32 clen, u8 *dbuf, u32 dlen)
 {
-	ZSTD_DStream *dstream;
-	ZSTD_inBuffer in_buf;
-	ZSTD_outBuffer out_buf;
-	void *workspace;
-	size_t wsize;
-	u32 res = -1;
-
-	wsize = ZSTD_DStreamWorkspaceBound(ZSTD_BTRFS_MAX_INPUT);
-	workspace = malloc(wsize);
-	if (!workspace) {
-		debug("%s: cannot allocate workspace of size %zu\n", __func__,
-		      wsize);
-		return -1;
-	}
-
-	dstream = ZSTD_initDStream(ZSTD_BTRFS_MAX_INPUT, workspace, wsize);
-	if (!dstream) {
-		printf("%s: ZSTD_initDStream failed\n", __func__);
-		goto err_free;
-	}
+	struct abuf in, out;
 
-	in_buf.src = cbuf;
-	in_buf.pos = 0;
-	in_buf.size = clen;
+	abuf_init_set(&in, (u8 *)cbuf, clen);
+	abuf_init_set(&out, dbuf, dlen);
 
-	out_buf.dst = dbuf;
-	out_buf.pos = 0;
-	out_buf.size = dlen;
-
-	while (1) {
-		size_t ret;
-
-		ret = ZSTD_decompressStream(dstream, &out_buf, &in_buf);
-		if (ZSTD_isError(ret)) {
-			printf("%s: ZSTD_decompressStream error %d\n", __func__,
-			       ZSTD_getErrorCode(ret));
-			goto err_free;
-		}
-
-		if (in_buf.pos >= clen || !ret)
-			break;
-	}
-
-	res = out_buf.pos;
-
-err_free:
-	free(workspace);
-	return res;
+	return zstd_decompress(&in, &out);
 }
 
 u32 btrfs_decompress(u8 type, const char *c, u32 clen, char *d, u32 dlen)
-- 
2.31.1.527.g47e6f16901-goog

